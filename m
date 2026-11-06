Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AF1606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=u95/MWEP;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=HRcyBuI/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC78E60890;
	Fri,  6 Nov 2026 17:47:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IqiabvLGH-bo; Fri,  6 Nov 2026 17:47:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EEECF60771
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793987278;
	b=ZZ487RlrojYJB33JTxIIHytxHBis4x6pPPqL+Xsr7TbhfInwNpishj1AHaN4OTddOdCM
	 /C/y5EfDg23RaPNIq3ok7+40CZVc5zxtFyRLPMi5GnvZBL+A1MwVxBJyZOe0Gu4vp7Kp2
	 JsHSURZthPoAE94igyv0w1Oz/tHoKuwLlxQKwJ/GATaODJig46eChJamjOUJl4oKTomN1
	 QvZbcYI2YA7srMho8FdajZhI4KwhGMfJSETEkIPVXmgsdRT2vEq5+P/4HHjgKehyONzbr
	 2K4BAzuz9TukpeEnTJy7/ZfcZlhSydW/uuouu8CuCUz6FfHJf/+NsGgwck9DwcOSQ0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793987278;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/s5mnZSn3r80oPcxJB6WWms+oq6RNDAvvgt+8m99REg=;
	b=E9wl0neQiprYC2GL/ToM8tm8yjNcp9oJk78cTLPmIBNf6ZixOXIP4mvCb9mmzoMZDmaj
	 ioCV8L75FBCkfO0rmNAvJYNqjlWDu9IFVWkY3q6ZokICSuJZDCt2UPXutd88LEWnxqDoC
	 bjKDvd8J/oxYOMzDAFbKVHdEvwZd/xSv6swntok2FVc9OkbpE6OsuFQSClB6MBpmQiOft
	 /Vx92EAQRhspeZJcg8U4V37+NFIQJ02XfAUbQE1QUHCuMfjJ9M/FVUHqAa2mh/HUiJmMI
	 FWbI3j9aWXU4giWXWlgPWw51axzj/aoRJOVHmptMRLX2G7bLZl/5cloP0kqiW6gMvXg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793987278;
	bh=/s5mnZSn3r80oPcxJB6WWms+oq6RNDAvvgt+8m99REg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u95/MWEPMvdytPPY8bFRlSECGNPNCHNu/jPaddULw5ywPbv6Pt+x+EcoM7/xhRTns
	 GUFRbi3/E8jxqD9VBX5wlUf3tzKuJKYoq/Zu5+UYopKB7mi6WCaDi1bfH9Ljin0vfV
	 c1+M/GTqtAcobCXFZfxGO9ii375utD0sff+NDFtBzFg7us0X7XiCNE2fXvRQG4jQ6A
	 3W8RjsOUVW5x/rjCqLG+UpSWTv3cNb7CpTFKYrCUbWXlLOgBBco4lQyLPL0srxAzDN
	 1vHDbG9Im+fde2uQoTBzeVtTIE/03CicsPChicKBF75CUsl2h1K467SXlqgPO9E0lU
	 Zs0IZ5OFNEJIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EEECF60771;
	Fri,  6 Nov 2026 17:47:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 822FD2AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:47:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 689194080A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:47:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MCX5hnMjF8UG for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 17:47:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A25B8407E2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=HRcyBuI/
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A25B8407E2
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:47:55 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6df0b02fe91so1247710eaf.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793987274; x=1794592074;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/s5mnZSn3r80oPcxJB6WWms+oq6RNDAvvgt+8m99REg=;
 b=HRcyBuI/EEEr9tUDTaYiznc3xnW0QwyhExCzQzMafCVTLqSAvWqrFcpipZrUDIIP08
 tdmkwpppeHnSY/izFjG7Twb+vZvO04a6Ik3yNjg1j2L5Me7k8DTxQLvpPKJywCOHLQpa
 IuOgTv3chfAKuDFjJ/wdR86mMD9xHuEwENCUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793987274; x=1794592074;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/s5mnZSn3r80oPcxJB6WWms+oq6RNDAvvgt+8m99REg=;
 b=FTunLdzEEQZ6nOD1GLdvmQCULAFrt8tTTQz1PFk3SUOn8e5ao4Rh1mts8hFkZcSqxq
 JYVx9LuZ2dtjXnXY+WBp9iLWcrZJGfe7HbLUaVwOsEtylCrq+D0Dg2SMaxgiPYvMNbi7
 cEHHDPwYsElyAtPqgIHePmcfSYzpadlD3MwWz6Wp7hA+3HnMZE8qbXJakvp5stg7j6RS
 80fYRRGteh0nXRiglHAowa0V2avOE/16w6+9lBDVCcto1rE4zLAS8pr13nS2w5rAc6Kk
 nIxzbCLaVgcjvLfJ7Jtp2608XibpOcS0YyiYOVh5APfsSjaAl8+Tz6BPRCRoE4wgirbx
 TeqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByxrbgzapNiLJw5TVy5iOWQSoCWBslTSKD7nyhpeSVcovj0UR5sVkJUEaovlwJHW9wrlXiRD5U=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8q1MKlF4+nNX0gITVmxX/O9CxrYM9cGT7xwwPyxc18JBAmjSpj
 5MeU8SYKiBJ5vnHk2LGWY+gzKe7L6wUB8UT5WzNEVSV/IX3+aUlzTkGFZivTUeg2eOo=
X-Gm-Gg: AYBFou0QN/73Ut/WdJGb6EF5W6PkLutJqzAyRdUIkmPYuFIhQXrpOCONVBp5wN4zV4Q
 n7S9HDROQoovKHEVmb36rVH1FEWRCTpj1fgJgxnE5jP2n5OntpaFAyT1xOvYv96lHgrLKmgJ9/G
 Njm18uHPtTzKDbNxxcynC94VQBbLXw64b69kgHvSZUvKyHKhVYItKdt63AjUnWhjhZPxtAh3iOA
 VlxRRKxBehYrAMFYdv736srd4cBbU6KhdzKd7ISWEWayOK1cFUfqKfowd7/cpuOXYZ/WRqCf/E0
 ML2sSHN26C/z6WdzqXSdUBoMgiAHgkI3Ty4IbJdQoly7ki5as3rTgeFfHSaVY3vqphC6gOFv6VQ
 9Dis1Zd8omxE1GTi4Awp+DOPoD2WlNh+B7VNvM6MvdzrMC8j5A/RpR+ppnk3ei4s171EqF/iR1s
 bg+nxDrBAMJdl0mhCa3ljg/2aXw80xcQ81d8UGM5mwP7+qWRmih++IRPi/6VKBw5pXi6kG1c5e/
 uNhQsAyCK/W5++mZGhvlNKsZbfALYx/Q3VsvD5Q2b3b5GqOFYuw7j6yOiAYWhX7+SHDWdw8mNW3
 yzOLdiPHjz4il00a9FtsCHCRralpY+N9qfdfByljqTLovGwXBM8gDyKPnFEHeM825cMhDoxODm6
 qdJFWnDpzNbAgX2zHeH2EaPhU/pZuGYPtSv8bt4X/QFiySeInftcZUDu8Lux+9rJNLTRVP65qad
 656q2O00E2rYgWnOUJPal11nppp/iXMg==
X-Received: by 2002:a05:6820:1c81:b0:715:bd3:ad6a with SMTP id
 006d021491bc7-716d1e195ddmr3467005eaf.4.1793987274306; 
 Fri, 06 Nov 2026 09:47:54 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ad97a59797sm2472521fac.13.2026.11.06.09.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 09:47:53 -0800 (PST)
Date: Fri, 6 Nov 2026 11:47:50 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Carlo Caione <ccaione@baylibre.com>,
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
Subject: Re: [PATCH v2 4/8] arm: mediatek: require the DRAM description from
 the earlier boot stage
Message-ID: <20261106174750.GC3669968@bill-the-cat>
References: <20261105-mtk-mt8189-tfa-fdt-v2-0-c168a7b4041c@baylibre.com>
 <20261105-mtk-mt8189-tfa-fdt-v2-4-c168a7b4041c@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TuHp/pURPKUAduf9"
Content-Disposition: inline
In-Reply-To: <20261105-mtk-mt8189-tfa-fdt-v2-4-c168a7b4041c@baylibre.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--TuHp/pURPKUAduf9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2026 at 05:45:26PM -0600, David Lechner wrote:

> Add MTK_DRAM_DESC_HANDOFF to stop in SPL if the boot stage that
> initializes the DRAM did not pass a transfer list with a devicetree
> overlay, and enable it on MT8189.
>=20
> The overlay describes the DRAM size and the memory reserved for the DRAM
> controller, which depend on the DRAM fitted to the board. The devicetree
> built into U-Boot cannot describe them, so booting without the overlay
> would give the OS a wrong memory size and let it use reserved memory.
>=20
> The option is not specific to MT8189. The DRAM initialization on MT8366
> has the same code to reserve memory for the DRAM controller, so the
> Genio 360 can use it as well once support for that is added later.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
[snip]
> +/*
> + * The boot stage that initializes the DRAM describes the DRAM size and =
the
> + * memory reserved for the DRAM controller with a devicetree overlay in a
> + * transfer list. The devicetree cannot describe them, so do not boot wi=
thout
> + * the overlay.
> + */
> +static int mtk_dram_desc_check(void)
> +{
> +	if (!IS_ENABLED(CONFIG_MTK_DRAM_DESC_HANDOFF) ||
> +	    !CONFIG_IS_ENABLED(BLOBLIST))
> +		return 0;
> +
> +	if (!(gd->flags & GD_FLG_BLOBLIST_HANDOFF) ||
> +	    !bloblist_find(BLOBLISTT_FDT_OVERLAY, 0)) {
> +		printf("No DRAM description from the previous boot stage\n");
> +		return -ENOENT;
> +	}
> +
> +	return 0;
> +}
> +
>  void board_init_f(ulong dummy)
>  {
>  	int ret;
> @@ -29,6 +56,10 @@ void board_init_f(ulong dummy)
>  	ret =3D mtk_soc_early_init();
>  	if (ret)
>  		hang();
> +
> +	ret =3D mtk_dram_desc_check();
> +	if (ret)
> +		hang();

Can we simplify this to something along the lines of in board_init_f():
	if (IS_ENABLED(CONFIG_MTK_DRAM_DESC_HANDOFF) && mtk_dram_desc_check())
		hang();

And then mtk_dram_desc_check just does the bloblist check? This will
still get us the compile time sanity checking but a clearer path for
compiler optimization.

--=20
Tom

--TuHp/pURPKUAduf9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCau4SwwAKCRAr4qD1Cr/k
CuaQAP4tG5omm6RaAMhaR4lRuL3l1jha9bAC4tukpwF7LmZZQAEA6YUwmFQmhFDN
si0WlLSPyXdF8Q22d2K2PDbx05oX9QY=
=aBJT
-----END PGP SIGNATURE-----

--TuHp/pURPKUAduf9--
