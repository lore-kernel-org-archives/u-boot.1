Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317A1CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:32:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0985605ED;
	Mon, 28 Sep 2026 22:32:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v1i4SG7NFKXO; Mon, 28 Sep 2026 22:32:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 29ECC60614
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790634758;
	b=rsH6luok+S8OqdLM8XOka7xm6J2KFTiyzzPowyRiq0BRo2ttLj30Ke+2l+Yackhoxq3g
	 V5fTsNTFTaQuevoIbkqkAPg1vxHvP7qMijxjml1R+f9OsPRbGLrZqwkKFmgZ+avArCTV9
	 HHhSL3USK0gWAmQzyJG/UNlX2WHlgbJ8e+6/p7b/770EZ1P1b7K2J4DNpSW2RrVV2OrAu
	 iFplW4jbofq4DF8dfoMpRqZSYH677xFUVJGlrroPVGVgM5U5SwqD1DSIKzWZps1FUxoBZ
	 vJxhoOSPNVlJvAcwSgeuncpbZswhKIMX923LSXMTI9/ZvF6oTgeRbF23eC71m+CCCXA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790634758;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PXrTIpY+jkIFK70X91FIy/XZt0vg3cJz7yPKIaOsV88=;
	b=Oj0oZchtNhlIFLRxAVx7JMH20WVgDKyBrzssFusijnvnkXOXAFCcfVEKMcO/iDKuCHKq
	 1ROrgMy8cRay8R069tGMTpqM9m0VM9mFxzB7RxnVCw8LDroF0vxM87L7JBSv1Jy1LRRcv
	 fEgfJB6qM7AMlXTYhaeBKWiARKMH16WoWPsZo9hzRHau1zPBKlqTY0kqlHBEg57bq+73a
	 mYTk9LsLdTt9ws6PJbtNe5NGfcg7TqF54kLCRO5N0X2tVB2kBwS19cXLj/TSYj5FW04cT
	 JO8tglCUb2yK1lao9q3CstBGu8bGzSdtYCsOfsqUzXELrzgV+9/FxEI3nRIhOnFRd2g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PglfDNbr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790634758;
	bh=PXrTIpY+jkIFK70X91FIy/XZt0vg3cJz7yPKIaOsV88=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W3KZnbvffaoMVbEh+/yWszPVvQnb024Jz0rUsk05fEQIbn3EAKdzx/y/rekKccfLt
	 i816SVkxgnoQbBuOfw0M3ON06p/nEwDpJJGrqcqMDrXBtmn9b+FtMhHyAERxL+w81w
	 6eOCFrAmVAHDliReJ/Nnr1T//cYQte4c0Ko7dFvNowoZJccUb3Xfv91FSt6utKV+IM
	 dLF9IyQel9JODi7TdU8PayqTihXUtotZxlKM+qBqdfc6gOyyC4YMkqKhhUFRefQoNr
	 F8/ReuFYlO8DP35wkjN+eDDci7qn52SN/9KyEGDLqc6aNLrsMJiewMsk6Yk/R4toka
	 uxF5URWwTvGBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29ECC60614;
	Mon, 28 Sep 2026 22:32:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E935335
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:32:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7428C60614
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:32:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v3nBpEe_gYPX for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:32:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6D79E605ED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790634756;
 b=m/cB70NEcYhx7DFzef2Gz8QgsSSi+meadGq8On9/9MHxbXBNvxLKV32CuRyf1trtEITM
 HtUyFkSPFxcZkeOIGQ0BIPCR1TWAfFZy2438+Zf1rGy+2LbJjB5167JGc44TuCEel9tJ3
 JdaWfSewjfbZoQpiPe8jNZm8ZAc6DIhSPpKb+9apA3vY9BouEf5i5Q2TVViCyIx7RG9XW
 FNA3ghMTnWKSzdmn/q1LtGWgpMyAB73rH5q8gEtcQCKOCB6tXYfvuoce1mwEUIoFVsQmP
 RUXLtPNmobxRoMlvOXP885bj/c0hVQXSRzj2mCSFp6yYmF+YN/jkid+Bk4WT91xwkUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790634756;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=PXrTIpY+jkIFK70X91FIy/XZt0vg3cJz7yPKIaOsV88=;
 b=PjQEfADaTcNRZG4aUpnO2bRJElN583pgI6c+BCdau9Aaheg2Is71Otxg33VkcB+F+CSa
 nnVFrXkivQRG+vRmCcBH6Xnsjf+z1tarbSUhMunXkMCbYi/wfDqt9n7XFND0z5t6bk6AY
 J/njl5ogPAQZl38Cxh4OmQ6OW7ALt+Aup4974/QSVrk2k9Izb5Soj5jnXAwlv/a3s6eMt
 yjI0f0JlUQ6mwIiDH2aVLf1N/QFv/RgjdT4Hd3dkQeaRXV0qyqRze6umYSntwF2Kgm+eb
 EfgR02PQ6kUgTOkDYtQ/om5eOKCTmNcBbH8HuSaoKp9FA2/jwQ9ShgT5+HSr5s2q2HQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PglfDNbr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::e;
 helo=mail-ed2-x0e.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=PglfDNbr
Received: from mail-ed2-x0e.google.com (mail-ed2-x0e.google.com
 [IPv6:2a00:1450:4864:33::e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6D79E605ED
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:32:36 +0000 (UTC)
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aaf688ebb0so4017034a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:32:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790634754; cv=none;
 d=google.com; s=arc-20260327;
 b=EeEv8i5ciCbpg9BrZ+G8NEhBvTNgq3l58XTzFAldaH8k64dSD67vPIUwOaUlAwSkl+
 haphcoWOUQaznh4PSc4phg7r7Rqhz1DmpkCBu0R61ULlY8xPbancg/m4Xrn0u1EIH4Ak
 sz6SLbQqaiqaps/8vVk5fkbLevtD2Uklxl1JbC3uBPkejFdIcegvmguwWm5360EJtohv
 RSddiVpdaEpSFn2u0sAdmApaZEQ8MrSOJMSY1b41cwI0bCEIbECCTddT7mrZg6VpBV99
 yjmrFaehMXnubQNGi4UyJuaLIBTqtCb2NcWA65OHg4ZWQQPdjB9v84XsXFmTX8BqciRH
 XCYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PXrTIpY+jkIFK70X91FIy/XZt0vg3cJz7yPKIaOsV88=;
 fh=bFUxJLktzAAw44NUo8K810njxzDqWaY84yRZTytHMqo=;
 b=kKr+fAgSmGCSVAewK3qrgScdkCyW/PjbTfXzlG6t7oVYjkBil1G4+WN6HEGVGhGXhQ
 Th8LmJg+fAdzd+Y3+u7ucSTKPJHAj0w1mqEyq8wGqEOFAtOSbuWtseXaeEeBRZ98fEir
 /5bL8PDh+ivr72sM7qE9GCKcG4daSmpUjzFs6H6Z2Ya2snYWYJ87jm3jq8nLCSxpcxpB
 9LrjFgJlOqTXtAdOM/t2nPzxkA4J5kLyGQw0hTbOka2QXAyIAodFLaGV+ePBpcZf82Y0
 MJmV8PHY7GZZzC0Et8vEfjOVFBtdvwoM4euD5oBdK8diFrMCltVWj+q23XcHYkDoybJN
 fXMg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790634754; x=1791239554;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PXrTIpY+jkIFK70X91FIy/XZt0vg3cJz7yPKIaOsV88=;
 b=PglfDNbrb21LwqDnaCJdGJ7ingW7+OVLjFXx9vL0EIf8N8tuPJaOLjjQum/7KfACAY
 2rlsJH/BexAxdaqpL0YgfJhTfoOXS55U4foGBiIftvVpemJKh97bg7qjLlp1BCvCiNOc
 hcOYxAXpZ4T3xXLc8AhF7eSpYz/9Uz/CioqhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790634754; x=1791239554;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PXrTIpY+jkIFK70X91FIy/XZt0vg3cJz7yPKIaOsV88=;
 b=ckOVgm1q9EUfxGWvxO81McwYJh24CAPXYqHYafKmke+CIsYELUhIXYffGc9f9mAd1S
 x9NbRDxVNDZLceP5yIaeeAAocoZ1QWNeV1RpHeTEdI6//+FkmYY0qBHI8uDJBlGb8kbo
 TouMkqqhIjGBh3gOAtJS7Tkb0qg7J+2BO1EeU1UJTUeenPU+5uGJvnxNOA6Nrq0pq87k
 dim8GudAqh2HEx83puwOEj1HzpGtpxq0Pv50n0phdfiUPkYnhs4lMRDJUW7GkrjjJVlI
 nTW9pjiL1zplQ2Szra9IP9omtW7t/9rKpBRKuQT3feuLfaRVeVMmlRSFmlgPGGN8ASr5
 a/oQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxY9llwW44IPUPSicoYmpsOov+FAocGs53IZI/cK2CV/kYxoDxOnCHEVBw6+BzCMrjFFvds9PE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJDiMwNJP8oazhecO1HRz++pQX0bbX8Tu7R+5UOvg/mJg0b7z+y
 sy5imqP5xE+paXPUClIlItFJzfqNsDgB3XzcTkP6rBrP2YvPrppnbT6xuUIwX04QsAbqePl7xCK
 dgj9rHI14CxQlnoBcnnt5cedOIp30JCKp8OW7cEQl
X-Gm-Gg: AYBFou1zj4xfiKa4wOcCe8qQwOc2r1LdHlF0NVfEG00xBmk/pZPGBJtuMKgY150r5Ur
 htkljUqi7qx2ELuNs1Jq2yRoFQYx5sp1dZn9eD6ekddOXTdign3VaeI5lqq17gDMskoRIdXPkJK
 wcdPEcJ3k5AXS4Nh/Vgx7ecgRs7+ESlzxRaa/rR4Y6NvhEEOpcGOY0biln0SWCKceJMyI/uq9D8
 CLqNCFmHPL5FEmpMZ2B2jiztzHEW2+KHmsmSZ95we4Dl8D+io6D+70dkK2RoHrBuCqorJbpNKDL
 lwYU0S/6GWcjzr7T0t+eWG8BpGdtOK/+j3FTY9W1dweUU2Toqghg8UPhww==
X-Received: by 2002:a05:6402:5187:b0:6ac:7d7e:e56c with SMTP id
 4fb4d7f45d1cf-6ac7d7eebcdmr3053938a12.5.1790634754551; Mon, 28 Sep 2026
 15:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260911-imx93-secureboot-v3-0-542a99793af0@bootlin.com>
 <20260911-imx93-secureboot-v3-7-542a99793af0@bootlin.com>
In-Reply-To: <20260911-imx93-secureboot-v3-7-542a99793af0@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 16:32:22 -0600
X-Gm-Features: AclHuK_oAOw899mDUDVa7Npa6HMCAJspeFxwLizTRCEIrjnk2OuroMWZWMKLxhY
Message-ID: <CAFLszTjfgWwNMNvkVfxednbw+ZoC+wAAwBUoACnooe2G1c=q9Q@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] binman: test: add code coverage for nxp_imx93cst
 etype
To: jeremie.dautheribes@bootlin.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Christophe Guerreiro <christophe.guerreiro@non.se.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi J=C3=A9r=C3=A9mie,

On 2026-09-11T16:35:05, J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric)
<jeremie.dautheribes@bootlin.com> wrote:
> binman: test: add code coverage for nxp_imx93cst etype
>
> Add test methods to cover all code paths of the nxp_imx93cst etype,
> reusing the pattern of the nxp_imx8mcst as done in commit 0cab35362d77
> ("binman: test: Fix code coverage for iMX8 and cst bintool") by Simon
> Glass.
>
> This brings nxp_imx93cst to 100% coverage.
>
> Signed-off-by: J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric) <jeremi=
e.dautheribes@bootlin.com>
>
> tools/binman/ftest.py                              | 85 +++++++++++++++++=
+++++
>  tools/binman/test/vendor/nxp_imx93_csf.dts         | 18 +++++
>  .../binman/test/vendor/nxp_imx93_csf_imagename.dts | 24 ++++++
>  3 files changed, 127 insertions(+)

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -8152,6 +8153,90 @@ fdt         fdtmap                Extract the devi=
cetree blob from the fdtmap
> +        ele_data =3D bytearray(0x410)
> +        ele_data[3] =3D nxp_imx93cst.CONTAINER_HDR_TAG
> +        ele_data[40:44] =3D struct.pack('<I', 0x866)
> +        ele_data[0x400 + 3] =3D nxp_imx93cst.CONTAINER_HDR_TAG
> +        ele_data[0x400 + 12:0x400 + 14] =3D struct.pack('<H', 0x90)
> +        self._MakeInputFile('imx93-container.bin', bytes(ele_data))
> +
> +        with terminal.capture() as (_, stderr):
> +            self._DoTestFile('vendor/nxp_imx93_csf.dts',
> +                             force_missing_bintools=3D'cst')
> +        err =3D stderr.getvalue()
> +        self.assertRegex(err, "Image 'image'.*missing bintools.*: cst")

These tests execute the lines but do not check the result of the only
real logic in BuildSectionData(): the header-address detection and the
signing-offset computation. Since write_config() runs before run_cst()
records the missing bintool, the generated config is available even in
this case, so please can you check it, e.g.:

    cfg =3D tools.read_file(tools.get_output_filename(
        'nxp.csf-config-txt.nxp-imx93cst'), binary=3DFalse)
    self.assertIn('Offsets =3D 0x400 0x490', cfg)

and similarly '0x0 0x90' in testNxpImx93cstNormal. Without that, a
mistake in the hdr_addr handling would go unnoticed.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -8152,6 +8153,90 @@ fdt         fdtmap                Extract the devi=
cetree blob from the fdtmap
> +        # Mock run_cmd() so that when cst is invoked, it creates a fake
> +        # output blob and returns success, thus covering the signing pat=
h
> +        original =3D bintool.Bintool.run_cmd
> +
> +        def fake_cst_run_cmd(self_tool, *args, binary=3DFalse):
> +            if self_tool.name =3D=3D 'cst':
> +                arg_list =3D list(args)
> +                if '-o' in arg_list:
> +                    idx =3D arg_list.index('-o')
> +                    tools.write_file(arg_list[idx + 1], b'\x00' * 32)
> +                return 'fake cst output'
> +            return original(self_tool, *args, binary=3Dbinary)

This is a copy of the mock in testNxpImx8mCSTSigned(). Please can you
move it into a small helper (or a context-manager method on the test
class) and use it from both tests?

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -8152,6 +8153,90 @@ fdt         fdtmap                Extract the devi=
cetree blob from the fdtmap
> +        self._DoTestFile('vendor/nxp_imx93_csf_imagename.dts',
> +                         force_missing_bintools=3D'mkimage')

Just to check, is 'mkimage' needed here? The nxp-imx93cst etype
overrides BuildSectionData() so mkimage is never invoked, unlike the
nxp-imx8mimage etype used by testNxpImx8ImageSizeNone(), which this
appears to be modelled on. If it is not needed, please drop it so the
test does not suggest otherwise.

Regards,
Simon
