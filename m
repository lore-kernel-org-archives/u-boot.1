Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F685C5AD7B
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 16:37:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAD5F6073D;
	Mon, 10 Aug 2026 16:37:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Fpr2UYBfnEP; Mon, 10 Aug 2026 16:37:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CA05260730
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786379854;
	bh=stEGPLmWq9r3sAco/aw3yaZQmfxwJoBWpfwGqhyFrs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xV6W2Jzfb3r6JBPXciwXXu3JC2yod6uAxTVfBmvXCugq8YxFXLJnB2GKp8xQagN6h
	 kgPfQn1mv2zLwkH7MjNWMX/hQHr8mG8RpycNP60h4xB+J9elnzH8kFjY0mA8BTC/md
	 2QqSFypxOHh+1yrCZ8OmwvgQpIxHbLzB/1l3QohCHGepTNLG8ZBOpqdpkawqb1RQHw
	 pfxLq2fVIW4dGSbCfpdfM6G4/Oig/5X1ui8blUAu+3rqxbDjrhWnK+ha2abXgf/Qro
	 eecTjfS5hRIlFs+Rzym1qB2Ep3GhuSuyFurAm6x9meNSBLqrpevhOK5gh4cd46dRZl
	 JrN5ELgPOmc6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA05260730;
	Mon, 10 Aug 2026 16:37:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C1451AF
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 16:37:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E593D4064B
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 16:37:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wNy1hgSgLYE6 for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 16:37:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::30; helo=mail-oa1-x30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CC69240640
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC69240640
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC69240640
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 16:37:32 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-4563ac048f4so958636fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 09:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786379852; x=1786984652;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=stEGPLmWq9r3sAco/aw3yaZQmfxwJoBWpfwGqhyFrs8=;
 b=L8p7nrjFGBO9LHR05HBZsp8yX6ZON9MhoLjce+GEBa/ZDCqWS02KTAcLyBINphf/8q
 vDTPTvlweLRw0LhkqvJeNeXvAUxjnlM4r0Vv57fFsGKldYKa4Gy1xanFwUsyMnLFWexu
 r6dOvXr4YufzCHUL4IzHXZnKv7MmvN5UiKsP6YoSeJWKUFuo0d6JINmoW0mzzpL2pold
 +rHAzc/SIc5UfMs5ok7qd7a8WyTRNgUUTvRDhrkzIsyuq5MUy53lCjDmaeUHBL5wP5vq
 oJs+5lJ2Q9ahKcO7Eq8xbHUMoVwZzu29rVtGP+w7uzpN1b1ym4/fRA8tUjpI6F9vyGVJ
 IAjw==
X-Gm-Message-State: AOJu0YwTV+TtiHYdVrpLycO7U+ZkHHS646cFLkkFJV1aXD0ACat9C93s
 GiQEyCyrSv5IoOYYsIveQNXPT4QQBSW1Mg8CzU2iOmwDMqnUnbb4Gyodp90tW4zjz/M=
X-Gm-Gg: AR+sD134oXoHWTYtWNoHR+lJFJxXOKGYlsOECwNmV7ZgiTU+GwjMVpKHEjIhFMx068v
 9BT/3ctexi7zObSc8jrCKQ2OUKuzW6tGhM0O0HhbbTBJ7NuTv0/gnJHhD03uAmtNat+zE1NJ2qt
 eyPC8b5WbZKlvobgOR/m/FkUimrnTH4ZOYG5UK1JEKJ6Y4MHFHU7WJNQhpOLiR6teDo3sTTTqLk
 6V1so+XbDboUUq5R1gwISkTjS0VatsGggwhF/GZSJ/2IhwAecY1qow/vRLEkVdAGUPW+eQG3HVS
 nYsvp7KKKe3rgdFfDwQpGtHzF5Rsv22KR98wj3urBNp3xvU7Rb23EPm/EMud8ESjWI4KH6fi4hl
 R++kW7q3w/sbnJm5y2Qbk+TdVxAb0svKmbtHJvIGnmG2RIJSY6Sal1uTr18vYjwOU+T0nBCJMCo
 PcbZknRJ4QryTHAyJepIt/uGaXjQWhwFfGQAYdSNmPfxJ4CoSGbUaiv707aiQtJxp3zK++d4a7X
 PGQgxrE+hCXB8AQfgT0Yn1tbq71PJ0pcaD//rKaIjbTkeLQlUeZXzW3TuuTO4pKukWwRM3KSQWg
 xgMNqunOAw==
X-Received: by 2002:a05:6808:4fe0:b0:495:eb9f:53c4 with SMTP id
 5614622812f47-4b1a0e7bcedmr17215957b6e.9.1786379851548; 
 Mon, 10 Aug 2026 09:37:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b1aeda740csm6875013b6e.0.2026.08.10.09.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 09:37:30 -0700 (PDT)
Date: Mon, 10 Aug 2026 10:37:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Daniel Golle <daniel@makrotopia.org>,
 Randolph Sapp <rs@ti.com>
Subject: Re: [PATCH 1/3] bootm: size the noload decompression buffer from the
 compressor header
Message-ID: <20260810163728.GB1160436@bill-the-cat>
References: <20260809042338.63397-1-aristo.chen@canonical.com>
 <20260809042338.63397-2-aristo.chen@canonical.com>
 <20260809152703.GF394392@bill-the-cat>
 <CAA=k7=n1tcSPQnjfXVMOpksz20Zb30NLrbCdt6Gv5-UnV4Znig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DyWQFXETkmtE/6pe"
Content-Disposition: inline
In-Reply-To: <CAA=k7=n1tcSPQnjfXVMOpksz20Zb30NLrbCdt6Gv5-UnV4Znig@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786379852; x=1786984652;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=stEGPLmWq9r3sAco/aw3yaZQmfxwJoBWpfwGqhyFrs8=;
 b=Rns3UedGfT+DhHj6OHR28baDi9avItVNrjUIBp4nOSI1v9Brxb4WZjhfdDzXNHInJ+
 mGJBWAKOiRvl2AgWDn5gUSrCADSoqG+vHrP3yP6Q/zKlYYmQUzz5xmjG195fwzpDXAFS
 wV6kVzyF3HvipwxIUvwgZoFgi6YayNf2yynDg=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Rns3UedG
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


--DyWQFXETkmtE/6pe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 10:32:12AM +0800, Aristo Chen wrote:
> On Sun, Aug 9, 2026 at 11:27=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Sun, Aug 09, 2026 at 04:23:27AM +0000, Aristo Chen wrote:
> >
> > > For a compressed kernel_noload image, bootm_load_os() allocates a
> > > per-image decompression buffer of ALIGN(image_len * 8, SZ_1M). The 8x
> > > multiplier is a heuristic: it comfortably covers what zstd and xz
> > > achieve on real kernels, but any well-compressed payload (say, a big
> > > run of zeros) can exceed it and fail decompression, and no fixed
> > > multiplier is safe against arbitrarily compressible input.
> > >
> > > Read the real uncompressed size from the compressor header instead.
> > > Add a small helper image_decomp_get_uncompressed_size() that returns
> > > the uncompressed size when the format carries one: gzip ISIZE, lzma
> > > header uncompressed size, lz4 frame Content_Size when the FLG bit is
> > > set, and zstd Frame_Content_Size. Other formats return -EOPNOTSUPP.
> > > Bootm uses it to size the buffer to ALIGN(hdr_size, SZ_1M), capped at
> > > CONFIG_SYS_BOOTM_LEN because the value is attacker-controlled, and
> > > falls back to the 8x heuristic for formats without a size field
> > > (bzip2, lzo, xz) or when the header lacks the size (some lzma or lz4
> > > streams).
> >
> > Have we gotten actual problem reports? This is a good bit of growth for
> > a problem I'm not sure we're seeing. Thanks.
>=20
> Thanks for the review! Honest answer: no bug report against the
> current 8x multiplier has crossed the list. This is preventive rather
> than reactive, and I should have made that clearer in the cover
> letter.
>=20
> The reasons for this patch set are:
>   * The multiplier is fundamentally a heuristic. Nora raised the same
> concern in the v1 round of the earlier
> series(<https://lists.denx.de/pipermail/u-boot/2026-June/621575.html>):
> "Deriving a buffer size from the compressed size is not possible, as
> the compression ratio may be arbitrarily high for data with many
> repetitions (for example ranges of 0x00 or 0xff)."She dropped her
> replacement patch when we bumped 4x to 8x, but the underlying point
> stands: any fixed factor can be defeated by a highly    compressible
> payload, and further bumps are just moving the ceiling.

Yeah, I recall this. But we aren't really handling arbitrary data here,
so it's not as much of a valid concern I think, without real examples.

>   * Simon suggested the header-size approach as the principled fix in
> the same round (<https://lists.denx.de/pipermail/u-boot/2026-May/620121.h=
tml>):
> "It might be worth updating image_decomp() to take a ulong size... I
> believe in each case it is also possible to find out the decomp size
> by looking at the header."

Which would make sense for a more general problem, or a less constrained
system.

> So the growth buys correctness: the buffer size is derived from the
> compressed stream itself, not from a multiplier guess that can be
> defeated by any payload with a high enough compression ratio.
>=20
> That said, I understand the "we're not seeing it" concern. If you
> would rather wait for a concrete report, I am happy to drop the series
> and re-send when one lands, or to shrink patch 1 to gzip only, which
> cuts about 40 lines of parser code. Let me know which you prefer.

Yes, I'd like to wait and see what problem reports we get at this point,
thanks.

--=20
Tom

--DyWQFXETkmtE/6pe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCann+RAAKCRAr4qD1Cr/k
CohQAQDD2mN7cgxlvfgYbc8+xRfJvtBwEIQV0zTvKfptFWSQFgEAnamxLDor0f4E
F0a1cg4RIa1MEx1ux/vUS2tRnVHPhQM=
=YDXD
-----END PGP SIGNATURE-----

--DyWQFXETkmtE/6pe--
