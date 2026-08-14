Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627F7C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:53:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3606040CF2;
	Fri, 14 Aug 2026 18:53:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ow42mFJrNyHB; Fri, 14 Aug 2026 18:53:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4103D40D2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786733615;
	bh=pGVHczSK99K049ADQnrifgyYOgr9k6R5mWrtCtdx/rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YIFDdHD7D3MWNh60MS5XkyXsGMezTIcarvYpe15K5s6F6LysJgYMhMUw2DDaB9NP/
	 9KH50ofYwv15PSHZIESj+1D3+cHMZ6TKlSe1aH+SVbNrAcNp0S5M/Tdpb1lngSyCzC
	 1wIR/rW1E7NgsU5n0rWZjlkmNgQc2EBKGxnEJ2DLx4t9+9WT1les9hjbaWvB4MkKFq
	 8kbveD+oyEE9scQ5x9+8VxmmZ+QSLjd9ZZulhWoaBwHSmWZmagRnGBa54m0U0TPlUi
	 mw/OadUnscYA+kmh+E3vl8i2spoGn6+gw1Lr+DnM4Adf8R5uK5W32/9XzjRDSjXSVj
	 oyRe++l0pHNpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4103D40D2E;
	Fri, 14 Aug 2026 18:53:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AC708361
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:53:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A9DC68128B
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:53:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1ny2S2UgD_Hw for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:53:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 808C58127A
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 808C58127A
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UZiBIMje
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 808C58127A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:53:32 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7e9eaf04bfaso601683a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786733611; x=1787338411;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pGVHczSK99K049ADQnrifgyYOgr9k6R5mWrtCtdx/rw=;
 b=UZiBIMje06wfBelqPZD9tT1jWc6ByF7TxRxxaicBrQUQsKIn5KD40TyOdgRoUYhlOy
 g6LleWEy4rCG9JORenpiro4witIGR0qimfl2QbGEvZhupmGudSUqmPy4Ye/6/8qcB3MF
 wMoSncFlmpRFX99WkdQ3zmc9z5hwuL8/aAhlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786733611; x=1787338411;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pGVHczSK99K049ADQnrifgyYOgr9k6R5mWrtCtdx/rw=;
 b=ZKRkkmDx76+PYgeR/q9f46WVVuKC4XYRFTXxO1V1+P8EEj5Faz0FAcwAL046PZ6qHv
 +ctpBxtKfIKkkhym+wIiWg6DCTSWwmBtFDur0jEFTwbZKyiiViDoCIQfvDPcGLtMe4ME
 Eo/5BuwM8A/5iV5Eh1BJkCBPNBJr6YWx6+J5hSKbaa47QuyHdFWwbOTB57P9FnVW/Veh
 qkg7XsD3PGsUWUP67jUu9jmfxv0rn4Tx1yAsXt+MW6WCETqWP1ouwIOYSbOTjm5f4N2b
 YRa/rVjioSQEeRhG5uvuOFuIZeu5aDGw9TtPJnxuYQRkRuS2wgFRZZw8nwFeYKOMDcOs
 d+Bg==
X-Gm-Message-State: AOJu0Ywwb09UfOGRUpjCgHUE9MW7CTEuKjma35znxia4qWzdPXFRQpxA
 wp+Q51+xCOdyyDYFQW6JFunOhYl2hufCswT4vXqxE/w68K2A3xhx4xbUmMiCgsTW7Tc=
X-Gm-Gg: AR+sD12MrcqF/aYJybXX/jQHVLwfRJ74Kife8J2i0sNfMcIT/gkDzTImp02j42l5RjF
 xj5iU+hqcmcx/y3sB6Z+mdeI7wBg5sOdv0VR/b1woj6Cu+AQCmfyg+cVY+E8BMCAAFlQaMSrrHZ
 1x1Ub+X60q1Vb4B/IwyGIkeIP7NFm8xxQjXaxXEFuXh7wIqy7rEjopoGGemK+sGRBCQb04HE8K/
 qmmkWYdyf185Ula1GWNBMwhTRjv+0rEhJ0DUmmlglFmQBr3YmcnCQjJ+eZPmyRK6w9DjSzEUSs2
 Qfh7fhzqK6WcAuSwJ0hXKU58YOYuY7q7YHk+K5JnD7ay5aQ5wLL1xRYCTkO0RsYVRsyC9emDVZ7
 yWAkK//PhHfiTJYdWs06rWUHv3PRlmMymWYTJFWmDlnEr2p4f7S4AftmD/wNzAnWO3gfLDWlewc
 kY2k48Tt6gqe9lc2y+wgMkIQETM9iJfDfu9m+Z28SKD7ZJ0IpL7D7GnEvfciIEwWe7nLZU4aWqY
 v4PMzykQ7/J9d3WAyx3I1PJrLjeMRsDMgKqPmmLj50yTOc4mg3X99UE18qiXPM1knJ4kuobCqXy
 GSnyUKzxWw==
X-Received: by 2002:a05:6830:81c5:b0:7e9:5022:3639 with SMTP id
 46e09a7af769-7f3de7c792dmr7261563a34.15.1786733611174; 
 Fri, 14 Aug 2026 11:53:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e86686c4sm1470802a34.23.2026.08.14.11.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:53:30 -0700 (PDT)
Date: Fri, 14 Aug 2026 12:53:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Cole Munz <Munzzyy1@proton.me>
Cc: u-boot@lists.u-boot-project.org, Alexey Charkov <alchark@flipper.net>
Subject: Re: [PATCH] lib: zstd: update to latest Linux zstd 1.5.7
Message-ID: <20260814185328.GK3297518@bill-the-cat>
References: <69502f5a39ab3f07b7872cc6dcbf7e86f7e7d42f.1786670589.git.Munzzyy1@proton.me>
 <dd01c4b5-ed45-4fc7-8670-026aa38ee284@proton.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/FvRxngw4D/APYpK"
Content-Disposition: inline
In-Reply-To: <dd01c4b5-ed45-4fc7-8670-026aa38ee284@proton.me>
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--/FvRxngw4D/APYpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 06:34:42PM +0000, Cole Munz wrote:

> Alexey asked which boards actually carry this and what it costs them, so
> here is the data.
>=20
> Nothing selects ZSTD except fs/btrfs/Kconfig, and nothing selects FS_BTRFS
> except CMD_BTRFS in cmd/Kconfig. So a board pays for zstd only if its
> defconfig sets CONFIG_ZSTD, CONFIG_FS_BTRFS or CONFIG_CMD_BTRFS, either
> directly or through an included .config fragment. Resolving those includes
> transitively, that is 41 of 1550 defconfigs:

Note that qconfig.py can do all of this for you.

[snip]
> Text growth, measured base vs this patch:
>=20
>   turris_mox                  +1920
>   mvebu_espressobin-88f3720   +1920
>   am62x_evm_a53               +2072
>   kontron-sl-mx8mm            +2072
>   imx8mp_dhcom_pdk2           +2072
>   sandbox                     +2888
>=20
> data and bss are unchanged on every one of them. ZSTD_LIB_MINIFY is defau=
lt y
> under ZSTD and none of the affected defconfigs turn it off, so those are =
the
> numbers boards actually ship. The three i.MX8MP/AM62x figures come from t=
he
> linked ELF; those builds stop later at binman for want of vendor blobs I =
do
> not have, with no compile errors.
>=20
> On a board without zstd there is no change at all. I built qemu_arm64 at =
the
> parent commit and at this patch with SOURCE_DATE_EPOCH pinned: .text and
> .text_rest are byte for byte identical.
>=20
> It is also not in xPL. SPL_ZSTD is a separate symbol, no defconfig enable=
s it
> and nothing selects it, so this only lands in U-Boot proper.
>=20
> I did not measure the RISC-V, PowerPC or 32-bit ARM boards in that list, =
as I
> have no toolchain for them here.

If you use buildman, you can tell it to fetch the normal cross
toolchains from kernel.org. It can also be used with something like:
https://git.u-boot-project.org/u-boot/u-boot-extras/-/blob/master/contrib/t=
rini/u-boot-size-test.sh?ref_type=3Dheads
to give a more detailed growth report. Thanks for digging in to this, it
is a question I had as well.

--=20
Tom

--/FvRxngw4D/APYpK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCan9kIAAKCRAr4qD1Cr/k
CpSAAP9EZbvIPjHI4lXRdzMcpcMqo+mzsSMgvt6Z959138UR4gD8Cb72uuYb8426
xJhPUQbLq00apVL9iB87Y0CwDAZYOws=
=zr8E
-----END PGP SIGNATURE-----

--/FvRxngw4D/APYpK--
