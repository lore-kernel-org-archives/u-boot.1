Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F5BC5B572
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 15:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2742408CD;
	Wed, 12 Aug 2026 15:58:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h5nMO_jyhW1Y; Wed, 12 Aug 2026 15:58:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E311B408FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786550282;
	bh=X27DvWxJQ2Xuq6wM+0lOXVG77rVy+JvAYic2ZfD8MNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0mKCn+UKDEOv4HOiWlGJp5Z47wmeo1a+MRPLhRISWyRotn0igea1OX9K2Ss7QA4Vb
	 R6+LSSDRlNwSTMp2XivMsAoOe9VrB27vM7dTTXOj909RQ2e5iK/xWaPBksBrSRespR
	 ICe6OrRciQ9anDR1aO12QsdsjCyqJ9KxBU4bHv9AhMKUQ0J53NwkkVMv5bTdNsAPUJ
	 uCZZsWz1Db31qgihQkS2Xw7En/JaowQB1Y0xOG2VfFcPCHBmUCSmD0NLedsWaR9dnN
	 u7XqmAP8E2rwbcsJFV2rCs8GH8Vzf7moohPsFQfiiFw4+HzTKRWGb0366JirlNgl8n
	 imqzkUV6Aj7rg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E311B408FF;
	Wed, 12 Aug 2026 15:58:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 997C53A4
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 15:57:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7F4C9408CD
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 15:57:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1XqCRgrh0CNw for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 15:57:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C3100408BA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C3100408BA
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C3100408BA
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 15:57:57 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7ee4399c3abso777427a34.2
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 08:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786550277; x=1787155077;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X27DvWxJQ2Xuq6wM+0lOXVG77rVy+JvAYic2ZfD8MNE=;
 b=jg9GcxoIfKhqEVDtisS8+NWih0KOVJti/Aot6SpKADIEN3aH9MUkk+UH+wyFrpVmd/
 BFivYu1JmkxSCgpuhcL+GYCYD4uJ/Zkpbx/RrxI7FWI8vJNAscrjuluNCCJq2peCB7iL
 CfLJzf8o/uDGf70fFQlami6RxIozPVZzSU8u5lss0F1frEYizPJfdn1aWcRQUGwCyPFI
 8OcUuSNFE2NfRvx1KBDgHIZ7kP//8NBwMxaVGpMQUDug1YAi1zjEyqnWcX4e8rA+kpeZ
 qBfZm/ZDV4k/+YRi1jf8tVOg69VFsyc5MbDsY9tlqaC1G6HLCr1Pog05SaA44JNGbH91
 yMpQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp7QycDlonV1zjegiZYdELWCfGZe48Eg52m8CeH19qJaSOn93bO2uAJzRs2RyZ9bIhUYibKyMo=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyXzMB29YTFgEbkursIlo7ZQIGtIkTjTdT7muaOBDs66eAZI4y3
 qv6Y70BgMchkfvmLdHdeijFnd6iU6P8WD+RsZj17rc2u2EszKX5yy5qWkmfbWlLJd3A=
X-Gm-Gg: AR+sD10FumkoFmxFVnjrjM+YLlWxkFx23Y/HaZV3ZpwOMBrHbeLUT5d9KXdwPMIb9S3
 QfLc8a2sprIaHt/556Tjb0FArUPrykvxSjmR7zzqbMNbGzBlpvIXA/OFxdFHRg2AOMyb/An27Eh
 0RjPs0XCGbmBwlw6LZGojRc7APsOmmYQEBUyiYzcYGbgNww9iHYojgeU6MgZ9zL60gH2TEbXMKA
 8CFdigQP2CzxPi8EKGYTR52PeuBiIKEquBzx5ra7lb3t8N7Qgn+plJEVzAibE7Tu2zm34LVvXep
 wp3t+w/1vQNObajCmzjlO0vLE/bW/W9vAX7MhJLzGAM+AugTJJ2Sg+NwEH7MJm4Zmeb48CzXeQT
 kSwtcFECyqJz65PZjV+aFi2fcY+MgEQlauafR/6l6T3ZRi6gS1P31FmRIRkNRgtAVeGC1yA6WBW
 dcHUYpPU7IQx80pTla5eOJGzHb/mAdwE6ceyAhYGTog0ja5Nw0VGVqH8zvdpvwXxFRfZRP5UYOL
 DWBAg9lO1osbER8EjkJbRKze6PUJvEejjQzLW391+dtSsSmTkhiIJvNz90TaTkDROH3v2axI1Wq
 23K8wlSKJA==
X-Received: by 2002:a05:6830:67db:b0:7dc:3db6:f02 with SMTP id
 46e09a7af769-7f3b797daa3mr6511380a34.9.1786550273756; 
 Wed, 12 Aug 2026 08:57:53 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3b33ccbdesm3183321a34.17.2026.08.12.08.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:57:52 -0700 (PDT)
Date: Wed, 12 Aug 2026 09:57:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Cc: Aristo Chen <aristo.chen@canonical.com>,
 u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Daniel Golle <daniel@makrotopia.org>,
 Randolph Sapp <rs@ti.com>
Subject: Re: [PATCH 1/3] bootm: size the noload decompression buffer from the
 compressor header
Message-ID: <20260812155750.GB3297518@bill-the-cat>
References: <20260809042338.63397-1-aristo.chen@canonical.com>
 <20260809042338.63397-2-aristo.chen@canonical.com>
 <20260809152703.GF394392@bill-the-cat>
 <CAA=k7=n1tcSPQnjfXVMOpksz20Zb30NLrbCdt6Gv5-UnV4Znig@mail.gmail.com>
 <20260810163728.GB1160436@bill-the-cat>
 <b8c3b59fdfb810940ea2afa0e50f03935a665a5e.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BiOmeiK6NmPfupRr"
Content-Disposition: inline
In-Reply-To: <b8c3b59fdfb810940ea2afa0e50f03935a665a5e.camel@ew.tq-group.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786550277; x=1787155077;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X27DvWxJQ2Xuq6wM+0lOXVG77rVy+JvAYic2ZfD8MNE=;
 b=eld2o/Q8eCa+Hzx4j2pe8AtPvf93hGBRHPOecftleCsUcwMjF4+rgT9th4qXXSQoaK
 Wv3VKkDtvUZsYDF/3/6uLpQDyC/1GPhuU4AMRblk09O/lFevsWBpe6wEtw/kMw9Z3X+g
 u/s655fISR+QZQ4xgi3dfX6syDQCva89OOIsM=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=eld2o/Q8
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--BiOmeiK6NmPfupRr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 09:45:52AM +0200, Nora Schiffer wrote:
> On Mon, 2026-08-10 at 10:37 -0600, Tom Rini wrote:
> > On Mon, Aug 10, 2026 at 10:32:12AM +0800, Aristo Chen wrote:
> > > On Sun, Aug 9, 2026 at 11:27=E2=80=AFPM Tom Rini <trini@konsulko.com>=
 wrote:
> > > >=20
> > > > On Sun, Aug 09, 2026 at 04:23:27AM +0000, Aristo Chen wrote:
> > > >=20
> > > > > For a compressed kernel_noload image, bootm_load_os() allocates a
> > > > > per-image decompression buffer of ALIGN(image_len * 8, SZ_1M). Th=
e 8x
> > > > > multiplier is a heuristic: it comfortably covers what zstd and xz
> > > > > achieve on real kernels, but any well-compressed payload (say, a =
big
> > > > > run of zeros) can exceed it and fail decompression, and no fixed
> > > > > multiplier is safe against arbitrarily compressible input.
> > > > >=20
> > > > > Read the real uncompressed size from the compressor header instea=
d.
> > > > > Add a small helper image_decomp_get_uncompressed_size() that retu=
rns
> > > > > the uncompressed size when the format carries one: gzip ISIZE, lz=
ma
> > > > > header uncompressed size, lz4 frame Content_Size when the FLG bit=
 is
> > > > > set, and zstd Frame_Content_Size. Other formats return -EOPNOTSUP=
P.
> > > > > Bootm uses it to size the buffer to ALIGN(hdr_size, SZ_1M), cappe=
d at
> > > > > CONFIG_SYS_BOOTM_LEN because the value is attacker-controlled, and
> > > > > falls back to the 8x heuristic for formats without a size field
> > > > > (bzip2, lzo, xz) or when the header lacks the size (some lzma or =
lz4
> > > > > streams).
> > > >=20
> > > > Have we gotten actual problem reports? This is a good bit of growth=
 for
> > > > a problem I'm not sure we're seeing. Thanks.
> > >=20
> > > Thanks for the review! Honest answer: no bug report against the
> > > current 8x multiplier has crossed the list. This is preventive rather
> > > than reactive, and I should have made that clearer in the cover
> > > letter.
> > >=20
> > > The reasons for this patch set are:
> > >   * The multiplier is fundamentally a heuristic. Nora raised the same
> > > concern in the v1 round of the earlier
> > > series(<https://lists.denx.de/pipermail/u-boot/2026-June/621575.html>=
):
> > > "Deriving a buffer size from the compressed size is not possible, as
> > > the compression ratio may be arbitrarily high for data with many
> > > repetitions (for example ranges of 0x00 or 0xff)."She dropped her
> > > replacement patch when we bumped 4x to 8x, but the underlying point
> > > stands: any fixed factor can be defeated by a highly    compressible
> > > payload, and further bumps are just moving the ceiling.
> >=20
> > Yeah, I recall this. But we aren't really handling arbitrary data here,
> > so it's not as much of a valid concern I think, without real examples.
>=20
> It's probably not a problem when the OS image is a proper kernel, but if =
the
> next image is a tiny loader itself, even a small amount of padding (either
> inside the .data section or at the end of the image) might result in high
> compression ratios.
>=20
> While irrelevant for current U-Boot, one example would be OpenWrt's lzma-=
loader:
> it has a build mode where the <100KiB binary is padded to 1MiB (I may be
> remembering the exact numbers wrong) before compression to force a cache
> writeback during decompression (to work around ancient U-Boot versions th=
at did
> not implement cache handling correctly.)
>=20
> Specifically the case of kernel_noload would usually be used with EFI
> applications, for which additional loaders (shim, systemd-boot, ...) are =
quite
> common. The combination with FIT and compression is probably less common.=
=2E.
>=20
> Nonetheless, I think a principled fix is preferable - I like the EFI-in-F=
IT
> approach a lot (we may make that the default setup in our TQ-Systems stan=
dard
> BSPs in the future), thus I would like the feature to be well-supported a=
nd
> without known bugs.

Thanks for explaining. My concern, now that I've put it through a wider
test, is that of about 1550 platforms, 1297 grow under this as-is. Of
those, ~375 grow by around 400 bytes (380 is average, a few go higher).
The rest are around 170 bytes. This is all presumably the difference
between gzip only and gzip+others (with the few much high growth being
all algorithms).

Maybe a question here is, haven't we already validated the compression
header, and so don't need to do it a second time? If we really can't
live with a good enough heuristic, we need to work the size growth as
this is very much not an opt-in feature.

--=20
Tom

--BiOmeiK6NmPfupRr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCanyX+wAKCRAr4qD1Cr/k
CrMvAP9dNIM/dtVrESQj9gxR+CDBD1NewH5AiRHf+XtLiZguvgD/VhrknnQiB/yE
nNc+78kJgByDun96I8PBcw58W6C8Eww=
=8psN
-----END PGP SIGNATURE-----

--BiOmeiK6NmPfupRr--
