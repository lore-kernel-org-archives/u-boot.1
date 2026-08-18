Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D881C5DF81
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 22:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66A3A4054E;
	Tue, 18 Aug 2026 22:10:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kk92oXS0JnlW; Tue, 18 Aug 2026 22:10:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787091026;
	bh=PH5VIwqhEHqgX/Xi+FQQ28ydWqyc/MhIiscF+jGeDTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hfyYPkTDFiW/7yJiYqyC6csgqjO4uuiovcpRJCAohqBMglxzKvBSFizhdQbv+JirN
	 Hy+C3pmuZ36xsYLaJaFwhwlxgVBpLUE/hSCE0LYBUOXKdoazMkzDpuFYmac6ganNsk
	 jldf4Ky3qQWL9Kb43zrcWBYsFO+xKkWTXgTrd2uBKINXlYIyVJI/Bykjy9HlfV/RIn
	 NM82BS23qmTtbUPmM7lCmD26NLyitESKuw2rYHd3k/jXBPt+btSg4IpKkmVKvEpNra
	 pCTs3LTztrYvHBpBQhN7I8eorEx46wRQQBRKOaanRnqxav4CKeBdtsqWA1jSBW42d5
	 Fl0G3uXEYh9qA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6804940521;
	Tue, 18 Aug 2026 22:10:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2603D2FD
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 22:10:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C097400AF
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 22:10:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cs-7yJcHcQC5 for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 22:10:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=c1pcZCR9
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 123ED40077
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 22:10:23 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7eb9b427da2so956011a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 15:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787091023; x=1787695823;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PH5VIwqhEHqgX/Xi+FQQ28ydWqyc/MhIiscF+jGeDTc=;
 b=c1pcZCR9sfpQqM3YYkKUthsrYmTFb/G3IlIy1KjqkRWKLZMpmGBnqLSPfoB8OpMJ49
 ZDYwe4tH30UnpvTclcdOmOmZg4W1JPxeiT98uBpPV2nSsj/upyzL2Br5nEUV50nlGztJ
 Uv5UZza5rUmMpQlb1fJP6e6rxpn8OGZQJSwPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787091023; x=1787695823;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PH5VIwqhEHqgX/Xi+FQQ28ydWqyc/MhIiscF+jGeDTc=;
 b=Pp3Srv7J3kmz3zkYk+L4NXdvtY9rYhqFXHJOffx7SUCmH0dtLJjuuOQY1vICF50FrV
 Ryw8Rt+3fvdu1Pt4grwc4AxDAjFuaxX9IDpKaapj/04ZVjisIZXLivjN2cBNi5+qji0V
 BZVcoZnJV4w9AJuHY4iscthKMB4QBVSYECBKst/qs4C2mv86OQ//zs8h9yqL8hP3P/32
 4GG8pqtqU4FQm7xP7Zs5RIcPRoAzy2HzzUdu0eJm4Ta/vMi4u9QmVRBI0sZg0SIa+pbt
 O/6Xuh+ZaR4UA5B8E9I8KoTfWoXSqPjo5HagCadTSGgbKoWy9jv+H46aa8FSNTPNxEbC
 391w==
X-Gm-Message-State: AOJu0Yyue99A8yaXv/bwBDUVqw5uahcgM6QKfGf1bnUoQl/fpr6iJyv6
 ExWcAq2suXLAN0vbgCXL7Iu4wog+IH8n8QyEXg0NO2/je3JgaF3t5oizGvHgMaA6Ec+A4EpTi7h
 3NmVA3NI=
X-Gm-Gg: AR+sD12AAO68GxHiAGqIecRr8dZVcr+Sw0mJXjCz22HlM0RgJEFuownPmaVzemu290u
 OsIT02xjaJ0KiNXK3XA5extbGmHlgMheTF43m9wWVEgkIZfjdMQTjnXskeQl8j/4v0SThmz8vpR
 ENAlttkrvKskPEV1uFzqK32sJh/PVWY4quPkgOAV5gPCQM+faM/r+n1CuR2ZVKHQ9rumemRYuB6
 2j4j4xBgDVv9C28BPJFA9BHOcF/7vq4KmwlMSq9om3GRj2GIqxobVsd+TxeBL/Aorz+UbUYIGma
 is/2HGb4qTYuDkOiphIG26YwCvRLv2z1RrQXpSHT/tBiJlJj/gO7/QnsX02uz3tQPrvxoAWfoGO
 B0AQkODvN4FwEKqNAlY6MiB+RXZJG0x3AdlQaQdjdPP/W1R/SFnSC5Pf3466v5R6yC9XvATAF0d
 TTKSo7Cbp6GlmfZYgAsfeONqTvcLlXzrKfTqHuO/oRnLRhSW/jg/CLaQM/AkxFoS+pkT1IIVJet
 u18/rM04oxzO/y/AhJSleE6YK50C9ItvXAFFikvvFsNljJiQJXsBjNHU8CxewoPElqclZAK8Jhc
 75JByC8Gfg==
X-Received: by 2002:a05:6830:6add:b0:7f3:daf9:eda3 with SMTP id
 46e09a7af769-7f43e2cc101mr567744a34.4.1787091022815; 
 Tue, 18 Aug 2026 15:10:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f41beef73fsm5383311a34.4.2026.08.18.15.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 15:10:22 -0700 (PDT)
Date: Tue, 18 Aug 2026 16:10:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org,
 nora.schiffer@ew.tq-group.com
Subject: Re: [PATCH v2 0/8] bootm: size the noload buffer from the compressor
 header
Message-ID: <20260818221019.GE523975@bill-the-cat>
References: <20260809042338.63397-1-aristo.chen@canonical.com>
 <20260818132332.324173-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/xLNEpOM/YX48K0I"
Content-Disposition: inline
In-Reply-To: <20260818132332.324173-1-aristo.chen@canonical.com>
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


--/xLNEpOM/YX48K0I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 01:23:14PM +0000, Aristo Chen wrote:

> This is v2 of "bootm: size the noload decompression buffer from the
> compressor header". Tom pushed back on v1
> (https://patchwork.ozlabs.org/project/uboot/patch/20260809042338.63397-2-=
aristo.chen@canonical.com/)
> on two grounds:
>=20
>   1. No concrete problem report driving the change.
>   2. ~1297 platforms grew by ~170-400 bytes; the change is not
>      opt-in, so the size cost falls on everyone.

So, the first example that pops up in my builds is imx8mn_beacon_2g.
And for v1 of the series:
   aarch64: (for 1/1 boards) all +16384.0 data +14336.0 text +2048.0
            imx8mn_beacon_2g: all +16384 data +14336 text +2048
               u-boot: add: 0/0, grow: 1/0 bytes: 328/0 (328)
                 function                                   old     new   d=
elta
                 bootm_run_states                          3316    3644    =
+328

And now for v2:
   aarch64: (for 1/1 boards) all +16384.0 data +14336.0 text +2048.0
            imx8mn_beacon_2g: all +16384 data +14336 text +2048
               u-boot: add: 0/0, grow: 1/0 bytes: 368/0 (368)
                 function                                   old     new   d=
elta
                 bootm_run_states                          3316    3684    =
+368

Next, picking turris_mox as it enables ZSTD:
v1:
   aarch64: (for 1/1 boards) all +472.0 text +472.0
            turris_mox     : all +472 text +472
               u-boot: add: 2/0, grow: 1/0 bytes: 472/0 (472)
                 function                                   old     new   d=
elta
                 image_decomp_get_uncompressed_size           -     416    =
+416
                 bootm_run_states                          2360    2412    =
 +52
                 zstd_get_frame_header                        -       4    =
  +4
v2:
   aarch64: (for 1/1 boards) all +428.0 text +428.0
            turris_mox     : all +428 text +428
               u-boot: add: 1/0, grow: 1/0 bytes: 428/0 (428)
                 function                                   old     new   d=
elta
                 bootm_run_states                          2360    2784    =
+424
                 zstd_get_frame_header                        -       4    =
  +4

So, that is better. Looking at smartweb, both iterations are the same:
       arm: (for 1/1 boards) all +96.0 text +96.0
            smartweb       : all +96 text +96
               u-boot: add: 0/0, grow: 1/0 bytes: 76/0 (76)
                 function                                   old     new   d=
elta
                 bootm_run_states                          3592    3668    =
 +76

What's honestly concerning is chromebook_coral where v2 *shrinks*:
               u-boot: add: 0/0, grow: 0/-1 bytes: 0/-2 (-2)
                 function                                   old     new   d=
elta
                 bootm_load_os                              520     518    =
  -2
but v1 grows:
               u-boot: add: 1/0, grow: 1/0 bytes: 110/0 (110)
                 function                                   old     new   d=
elta
                 bootm_load_os                              520     587    =
 +67
                 image_decomp_get_uncompressed_size           -      43    =
 +43

> On the first point, Nora Schiffer replied with a concrete use case
> (EFI-in-FIT plus padded loaders such as shim, systemd-boot, and
> OpenWrt's lzma-loader can produce compression ratios that outrun the
> 8x heuristic), and mentioned this is on the road map for TQ-Systems
> standard BSPs.
>=20
> On the second point, v2 reworks the implementation to cut the size
> cost, measures it across the format and architecture buckets, and
> splits the work per format so each decompressor's support can be
> taken or dropped on its own.
>=20
> Background: for a compressed kernel_noload image, bootm_load_os()
> sizes the decompression buffer as ALIGN(image_len * 8, SZ_1M). The
> 8x heuristic works for typical kernels, but any well-compressed
> payload can exceed it, and no fixed multiplier is safe against
> arbitrarily compressible input.
>=20
> Each implementation patch adds a small static header-parse helper in
> bootm.c (no new public API) and wires it into a size-hint switch;
> helper and switch case are only compiled when the matching
> decompressor is enabled, so boards that do not build a format pay no
> code for it. gzip's ISIZE is a fixed trailer read, lzma's size a
> fixed header read, lz4 mirrors ulz4fn()'s frame-header validation,
> and zstd asks zstd_get_frame_header(), whose frame-parsing code
> already ships with the zstd decompressor. The header-recorded value
> is attacker-controlled, so it is capped at CONFIG_SYS_BOOTM_LEN, and
> it is only an allocation hint: the decoder stays authoritative
> during the actual decompression.
>=20
> Text size deltas of the u-boot ELF (size(1), distro gcc 13.3 cross
> toolchains); data/bss are unchanged everywhere. To make the columns
> directly comparable, the v1 column is v1's implementation commit
> cherry-picked onto this series' base, so both columns share one
> baseline:

Please use binman to look at the size changes, as it gives much more
useful information. I've noted
https://git.u-boot-project.org/u-boot/u-boot-extras/-/blob/master/contrib/t=
rini/u-boot-size-test.sh?ref_type=3Dheads
for others before as a wrapper around the options to get the most useful
information out.

--=20
Tom

--/xLNEpOM/YX48K0I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoTYSAAKCRAr4qD1Cr/k
CslqAQDfk+ycTEXebgvm8YVTa0M/6c7WIqcCDlUsZjr64yrChQD/YY//q8RN/nu7
HXykC9ac0ZmyolwlDjT0p8cNBFIfbAc=
=oENr
-----END PGP SIGNATURE-----

--/xLNEpOM/YX48K0I--
