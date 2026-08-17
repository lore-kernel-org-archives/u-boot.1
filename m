Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE51C5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 19:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE628407D8;
	Mon, 17 Aug 2026 19:24:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j-CO5mEJg_27; Mon, 17 Aug 2026 19:24:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 98303407E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786994690;
	bh=rbbN4R3JGzV9x/ZIqI5I4yF/lUVSx2bQ5MnjeLN8goI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mm46+Nb7hnMz0Hmfvj082plKWF5By4kF+aqic+WZ+jJIiZE606ys4ibZt0PqHOhEf
	 gbYoaOlPQPfvcDcJo/bjhtKVry2wPHahLcnGymCubQEdXNU+zNjpNNjs5UTl0l/4sX
	 zkeXpkN8Og6s5VjRE7JI1mJ7cV9UqiaJJwaqJK3xjgMOTsapRpTQU0HIytvjNHZ0bC
	 pcTl+MquoELqaNplDP/IaRLd6frbiPydu6BNiP/Eehuo8h9GTRSCRDJaohoJ+I4lFv
	 VcdYF3qIILEmLlSPDNJ6Dsbt6mR4JrXk2hdj30XONjvjP4r44w8GopFKI/XuiKWx8i
	 vbpS74GpcbCmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98303407E9;
	Mon, 17 Aug 2026 19:24:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E2BB282
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 19:24:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F8F08104D
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 19:24:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VUOfVpWWafn3 for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 19:24:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2b; helo=mail-oa1-x2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 237AD81026
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 237AD81026
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VomNoqPa
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 237AD81026
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 19:24:47 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-44856d185bcso2409377fac.3
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 12:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786994687; x=1787599487;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rbbN4R3JGzV9x/ZIqI5I4yF/lUVSx2bQ5MnjeLN8goI=;
 b=VomNoqPaNNRQNfSaAMQciRCOThU3SGEDvTRqLSALBQMc/vyrllKPDV9YG61vSBnDYi
 VBd18MpitoGHuoDR78MDOYxM3VTM5IlNXKH1nWYk5AieENqarOaOj4MuUuRQg/EuceEE
 yf6MkiRpy9ykROK447shvRzZj3Euj+DXfmgEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786994687; x=1787599487;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rbbN4R3JGzV9x/ZIqI5I4yF/lUVSx2bQ5MnjeLN8goI=;
 b=FSjSR7WF9gqXONpZx5RHQ34mVev6HkBLj8CeWPNtHzxZ9CkS78wU6xlXoCq9talhww
 8L0KsHvHME3SMw6npv5b69gjgW15tUkl/uY7m4VynBHLQrkn/8KYrVDXBEpkvAC3h4J1
 HoAUX8YdPo5SHt8/RTqs+bq4uMET6GdJ+8TYZEn4JdgSnizbJe3UhsME9gDC+6JER9OJ
 l9cUuTxGUEa14Zw8njvcEWSD4t+wee2l+zHE5Z3OS3lmD8f0qKRaaNJG6Y21J4DIcXc0
 IBZNDkemF004RCtyuRxMwJV0LINIhjDDCcywEBGNTYYSfhvq05/Z18dIaA9nn2JXawux
 y9Pg==
X-Forwarded-Encrypted: i=1;
 AHgh+RryI7gG3LyFvstUniZnG8LfBUOfIBo9InLZKl+QJ+QAa5eJFjIAYmUy8jr+GsnMmEPKn98O7eM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yzf8h/YIdwyUb1vUzZZenzR7P0RLSn9zttNCsoFVC6/ZhEkSd8q
 0bpgAmwYLOV/EZjotaKvoTtBkSRcWC6nh8RnDiaiR3tNkhjLRikYr0QT8oXcPF1qqDA=
X-Gm-Gg: AR+sD13y5M1tRCGbxgR87z+5Di71O1ppczYTyulveN09jww0N+vN/KsSbBr7pQc0J6e
 FyKOz8sKz67CoQGCs+fFowNpfdgei4mkRtGHWwlS+C9V2xUBFcjrvPW96BGtpbi9z2Daa2YwwN5
 hwtiyGDjbTY2Nor4UvJEt6lq1ihoNgwGrqsMFVrz/a8SYVFtG1d9k3ccRK/zA4SyXqFdw0utcAC
 naaMxUqv14xq2ZmtfTVjCnTT/J2OKp8uc26be33AqWhC7S1a8qxg2MQdofGCv7qErdDPQ0JLBCJ
 MbLa6Qn47Al029QRhgMeGl9ziw+6ZTn/x6wHII7V11lhuUsVE7D3vGTnsSGOEnZdX/2FqAFozaC
 5Rryu9oFUAy6Dl6Pfwg7swVDzLCZOejkO+39w+rh5k/oL35nDyRZ7O4oOIBc5eMEIuWxw+G5XLZ
 v878L602MpCzSDR9LWH9kUMxmkJ9DqKce1R3jNis3b8qrRuTcJCMWG0l0WRroy9RplmxdgWMi6h
 zoz6D/bO4vCTFsDdfuUWr9fyYAF5mw6l2J6I3su6wJbASkJefxaKDlZyUtW0um1eV290zzH2GdI
 j+/cj4rN9Q==
X-Received: by 2002:a05:6870:2b08:b0:455:c1d1:9cc0 with SMTP id
 586e51a60fabf-45e921bfcdamr26131696fac.19.1786994686844; 
 Mon, 17 Aug 2026 12:24:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45f22e940c5sm1693582fac.18.2026.08.17.12.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 12:24:46 -0700 (PDT)
Date: Mon, 17 Aug 2026 13:24:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Aristo Chen <aristo.chen@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 u-boot@lists.u-boot-project.org,
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Daniel Golle <daniel@makrotopia.org>,
 Randolph Sapp <rs@ti.com>
Subject: Re: [PATCH 1/3] bootm: size the noload decompression buffer from the
 compressor header
Message-ID: <20260817192443.GU3297518@bill-the-cat>
References: <20260809042338.63397-1-aristo.chen@canonical.com>
 <20260809042338.63397-2-aristo.chen@canonical.com>
 <20260809152703.GF394392@bill-the-cat>
 <CAA=k7=n1tcSPQnjfXVMOpksz20Zb30NLrbCdt6Gv5-UnV4Znig@mail.gmail.com>
 <20260810163728.GB1160436@bill-the-cat>
 <b8c3b59fdfb810940ea2afa0e50f03935a665a5e.camel@ew.tq-group.com>
 <20260812155750.GB3297518@bill-the-cat>
 <CAFLszTiGA3mZZHHTZ5cDD-QqOFRb4AgzDP2it7LEE-4LknHHbQ@mail.gmail.com>
 <CAA=k7==8-gRa-qFqf0EDrzxF7YtO_ssmx=E5-Pf6LPhNedYBWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Se2isdrXyyJpQyZK"
Content-Disposition: inline
In-Reply-To: <CAA=k7==8-gRa-qFqf0EDrzxF7YtO_ssmx=E5-Pf6LPhNedYBWg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--Se2isdrXyyJpQyZK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 12:01:31AM +0800, Aristo Chen wrote:
> Hi Simon, Tom,
>=20
> On Sun, Aug 16, 2026 at 2:33=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi,
> >
> > On Wed, 12 Aug 2026 at 09:57, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Aug 12, 2026 at 09:45:52AM +0200, Nora Schiffer wrote:
> > > > On Mon, 2026-08-10 at 10:37 -0600, Tom Rini wrote:
> > > > > On Mon, Aug 10, 2026 at 10:32:12AM +0800, Aristo Chen wrote:
> > > > > > On Sun, Aug 9, 2026 at 11:27=E2=80=AFPM Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > >
> > > > > > > On Sun, Aug 09, 2026 at 04:23:27AM +0000, Aristo Chen wrote:
> > > > > > >
> > > > > > > > For a compressed kernel_noload image, bootm_load_os() alloc=
ates a
> > > > > > > > per-image decompression buffer of ALIGN(image_len * 8, SZ_1=
M). The 8x
> > > > > > > > multiplier is a heuristic: it comfortably covers what zstd =
and xz
> > > > > > > > achieve on real kernels, but any well-compressed payload (s=
ay, a big
> > > > > > > > run of zeros) can exceed it and fail decompression, and no =
fixed
> > > > > > > > multiplier is safe against arbitrarily compressible input.
> > > > > > > >
> > > > > > > > Read the real uncompressed size from the compressor header =
instead.
> > > > > > > > Add a small helper image_decomp_get_uncompressed_size() tha=
t returns
> > > > > > > > the uncompressed size when the format carries one: gzip ISI=
ZE, lzma
> > > > > > > > header uncompressed size, lz4 frame Content_Size when the F=
LG bit is
> > > > > > > > set, and zstd Frame_Content_Size. Other formats return -EOP=
NOTSUPP.
> > > > > > > > Bootm uses it to size the buffer to ALIGN(hdr_size, SZ_1M),=
 capped at
> > > > > > > > CONFIG_SYS_BOOTM_LEN because the value is attacker-controll=
ed, and
> > > > > > > > falls back to the 8x heuristic for formats without a size f=
ield
> > > > > > > > (bzip2, lzo, xz) or when the header lacks the size (some lz=
ma or lz4
> > > > > > > > streams).
> > > > > > >
> > > > > > > Have we gotten actual problem reports? This is a good bit of =
growth for
> > > > > > > a problem I'm not sure we're seeing. Thanks.
> > > > > >
> > > > > > Thanks for the review! Honest answer: no bug report against the
> > > > > > current 8x multiplier has crossed the list. This is preventive =
rather
> > > > > > than reactive, and I should have made that clearer in the cover
> > > > > > letter.
> > > > > >
> > > > > > The reasons for this patch set are:
> > > > > >   * The multiplier is fundamentally a heuristic. Nora raised th=
e same
> > > > > > concern in the v1 round of the earlier
> > > > > > series(<https://lists.denx.de/pipermail/u-boot/2026-June/621575=
=2Ehtml>):
> > > > > > "Deriving a buffer size from the compressed size is not possibl=
e, as
> > > > > > the compression ratio may be arbitrarily high for data with many
> > > > > > repetitions (for example ranges of 0x00 or 0xff)."She dropped h=
er
> > > > > > replacement patch when we bumped 4x to 8x, but the underlying p=
oint
> > > > > > stands: any fixed factor can be defeated by a highly    compres=
sible
> > > > > > payload, and further bumps are just moving the ceiling.
> > > > >
> > > > > Yeah, I recall this. But we aren't really handling arbitrary data=
 here,
> > > > > so it's not as much of a valid concern I think, without real exam=
ples.
> > > >
> > > > It's probably not a problem when the OS image is a proper kernel, b=
ut if the
> > > > next image is a tiny loader itself, even a small amount of padding =
(either
> > > > inside the .data section or at the end of the image) might result i=
n high
> > > > compression ratios.
> > > >
> > > > While irrelevant for current U-Boot, one example would be OpenWrt's=
 lzma-loader:
> > > > it has a build mode where the <100KiB binary is padded to 1MiB (I m=
ay be
> > > > remembering the exact numbers wrong) before compression to force a =
cache
> > > > writeback during decompression (to work around ancient U-Boot versi=
ons that did
> > > > not implement cache handling correctly.)
> > > >
> > > > Specifically the case of kernel_noload would usually be used with E=
FI
> > > > applications, for which additional loaders (shim, systemd-boot, ...=
) are quite
> > > > common. The combination with FIT and compression is probably less c=
ommon...
> > > >
> > > > Nonetheless, I think a principled fix is preferable - I like the EF=
I-in-FIT
> > > > approach a lot (we may make that the default setup in our TQ-System=
s standard
> > > > BSPs in the future), thus I would like the feature to be well-suppo=
rted and
> > > > without known bugs.
> > >
> > > Thanks for explaining. My concern, now that I've put it through a wid=
er
> > > test, is that of about 1550 platforms, 1297 grow under this as-is. Of
> > > those, ~375 grow by around 400 bytes (380 is average, a few go higher=
).
> > > The rest are around 170 bytes. This is all presumably the difference
> > > between gzip only and gzip+others (with the few much high growth being
> > > all algorithms).
> > >
> > > Maybe a question here is, haven't we already validated the compression
> > > header, and so don't need to do it a second time? If we really can't
> > > live with a good enough heuristic, we need to work the size growth as
> > > this is very much not an opt-in feature.
> >
> > Given these comments I'm going to hold off reviewing this series. I
> > agree that getting the real uncompressed size is a nice idea, but if
> > it is too expensive in terms of code size, then we might be better to
> > stick with what we have. Another options is to write the uncompressed
> > size as a property in the FIT image.
>=20
> Thanks Simon, I think a FIT property is an attractive option,
> especially for the EFI-in-FIT case that motivated this: the boot-side
> cost becomes a single property read, the ITS author or build system
> already knows the uncompressed size so nothing needs to parse the
> stream anywhere, it works even for formats whose streams carry no
> size field, and images without the property simply keep the current
> 8x fallback. The trade-offs are that it needs a binding addition plus
> image-generation support, only images that carry the property
> benefit, and the legacy uImage form of kernel_noload stays on the
> heuristic (which is probably acceptable). The property value would
> still need the CONFIG_SYS_BOOTM_LEN cap before allocating, same as a
> header value.
>=20
> To Tom's earlier question about validating the header twice: the
> value is used only as an allocation hint. bootm performs only the
> format-specific parsing needed to obtain the size, caps it at
> CONFIG_SYS_BOOTM_LEN, and the decompressor remains authoritative for
> validating and decoding the stream. But I agree the property answers
> that concern even more directly, since bootm then reads nothing from
> the stream at all.
>=20
> On the size growth, since that was the blocker: I reworked the v1
> implementation into per-format helpers that are only compiled when
> the matching decompressor is enabled, and re-ran the world build
> (all 1550 defconfigs, v1 and the rework applied to the same base
> commit). Median growth on changed boards drops from +160 to +96
> bytes, the 856 gzip-only boards go from +112 to +80, boards without
> any of the formats go from +108 to zero, and 1222 of 1496 comparable
> boards end up smaller than with v1. Tom, the "few go higher"
> outliers in your run should be the binutils Cortex-A53 erratum
> 843419 workaround: each triggered veneer is padded to a full 4 KiB
> page, and any few-hundred-byte change re-rolls which arm64 boards
> gain or lose one, so those jumps are not code from the patch itself.
>=20
> So from my side both directions are workable:
>=20
>   - if the reworked cost is acceptable, I can post it as v2, split
>     per format so any individual decompressor can be dropped;
>   - if the property route is preferred, I am happy to prototype that
>     instead (binding plus the bootm side, with the 8x fallback for
>     images without the property) and hold the rework.
>=20
> The two also compose rather than conflict: with both in place bootm
> would prefer the property, then the stream header, then the 8x
> fallback, so picking one now does not rule out adding the other
> later. I have not listed the combination as a third option only
> because its boot-side cost is the sum of the two, so it becomes
> interesting once the header cost itself is judged acceptable.
>=20
> Which would you prefer?

Lets see a v2 of the rework. I think some of the higher size growth I
was talking about was on the platforms which enabled multiple
algorithms, fwiw.

--=20
Tom

--Se2isdrXyyJpQyZK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoNf+wAKCRAr4qD1Cr/k
CubZAPsG4AWeyJGe/+JtiYnIxteUSU2iy4eG/Nd/9pSmdLv7gwD/Vd0GerUs3lLg
wPZgUY+LlKyHC/ygiuZwI5mFGLsPHQY=
=RnT6
-----END PGP SIGNATURE-----

--Se2isdrXyyJpQyZK--
