Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB016C021A0
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 20:24:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F8E6809D0;
	Wed, 12 Feb 2025 21:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="TYGhhzRq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9017280BAA; Wed, 12 Feb 2025 21:24:13 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B82B807C0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 21:24:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1739391846; x=1739996646; i=xypron.glpk@gmx.de;
 bh=UHOikI4x+1xOF8LzsX/J9Y1d1wQ6lqLGTP+jNjFrexM=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=TYGhhzRq0Ou2lYYPedVPjaWNktfnJv5mh/MEziSP4xzalzV89akPICKoz6phsjUl
 2+YLUFyrlJBHmiG9GCKd6glsiAR3lu4EwmluDQmesMeOx2iZL2BDqxMjIkTQI9kac
 ahkSMX6cPvKMgKOlZJ6APOhEjOlGMpw2LvGqnRoaFj8smPAiLGCmbGKIScJWR7NPf
 A8I7Kzbd7ivF4+9lvLk5gjDdg9nolQ6AB+CXrjFFND1N/gfUBNe0Y2hgzx0f/J4Re
 Cs/8yy08SkP3io6cyZ6O1Cz4a9gFgPnFnlTcHXF5LnihDBGGZbNrX63t1liJeNUkk
 1WPB+DM9iB94Lzgs8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.107.45]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f9h-1tfIL42yD9-007Fxv; Wed, 12
 Feb 2025 21:24:05 +0100
Date: Wed, 12 Feb 2025 21:24:05 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Sam Day <me@samcday.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Robert Marko <robert.marko@sartura.hr>, Luka Perkov <luka.perkov@sartura.hr>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
CC: u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/5] clk/qcom: apq8016: use BIT macro for clk en_vals
User-Agent: Thunderbird for Android
In-Reply-To: <20250212-msm-rng-fixes-v2-1-645cf8d3fd3c@samcday.com>
References: <20250212-msm-rng-fixes-v2-0-645cf8d3fd3c@samcday.com>
 <20250212-msm-rng-fixes-v2-1-645cf8d3fd3c@samcday.com>
Message-ID: <7E0D3F85-5F61-4536-B155-DB85A8F69A80@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P1YA+t7Ehq644JwUfnhiUghmcTeXh0fjlBQy2XH/1YG0HowF6Wc
 eNkwv4Kp5MY+0P3OkvJC8WWyc6uSMzFqRAHK0GTo8Ldj6HqdKPnzWt0AAGaJy36qX16fv6p
 tHUBFASr8n2hQl4ZcLr7Y0q2Rw8ZB3hnKPWyJL8MDQItqKZ+xpYsKiZ2gyJR7xoV+MlKOPz
 RCWkSOkkM6litbxFdJF9Q==
UI-OutboundReport: notjunk:1;M01:P0:bYyue9k+bS8=;q7QRnV7mksAOdROKCX5rBhP5WAN
 ipDgzUTYAzQl85EWO5QymyPYU9jirhViqf+yboP6cYXmJhobnelV2BylWzg5UcLA3cO0S/4gU
 J+UsrNvLZFDGW7I4JWfswCrROPYEHDEmq1ib9MRrQ5FOjLFs6+AeOct6rPjpo3D5sFzu4dzWH
 bRzic2gZGEnJBjmTDSDi2rEqdphIwh1fH/GIPnjo2QTPWz3qD449+wUULgoB/WB7O9hlXXFDI
 vrO5kJB/USTlXNiNEcHsTKs8RDlFlHqfnp/fLMTTEsD2l0xbesVy2SxuxcZs0ItgJkr1Lk47P
 EQAGWcLsdimxXkmXD7AAise9l/zIea0zua1RdQ8HCpJCydDgHK+5QiqMcVZWtu8MRqhknnrJc
 +xX5hWXIMfYXongNLf3iF8bVJW9XtpoaOIswYg7cuFsGihDueHxd3WTffigRz7ugCAhJazgLc
 0TpyOCH1b92MyDfPK43Mnwo3cpZuYp3iOgWhM01zEI4h+3H/QAsc+vQByKmruB+52O18/Oeuj
 qOqTNN4YWZmw7WY1SBPGYrnU6mxJakkTtyF/Mh6oOEvjlYvmIb8RmVfRXNv0/EEJJC1Qavua6
 2VZMu464+cJHUoaMttoPOoj2/qnfhydkXPRl/zVN5WnpumZj83bDp6Hl8JE/OJsU+s3yWDvDy
 iwgtdAl21htgKZf1GlBu2P7MgY32f2f/28pwWWJO8UrkHk1mQYP6pOKASL8tSCQI76NAk0P8h
 cDcStpHDKHpDuXt+XXXVInwgPKcaY2068j3+3oFcqIcrWU67oV3u+pYe/TOeWItaAA+aFaOmr
 BdiZdGXE/D0Gw8DJsrhfWVKrXSbk5PVdMTEM7VpKhjFCP7Ent9Mc9ngvHQna+DPvwz+BggNFP
 CklxGQi3A29wVeYME3EL0Om6TIFxPgIqOIKCxr7Uh+ZSmzhyxojmuSU5+wApnJ6mCxSIeAfyE
 k76Rc5BQuf6o/NwQynCRUccL9xCwWmISjc1nCAGlMDm6WBABMi0SmeLYn00eJsFBTL7gw4mxC
 hqXfDWJSPpNyekcOmDnHih/Xw3LHUR9BFpl29s0xP7+CbdJEj7M01UzEztcVwzd+4Mz2a3KUO
 dSB5+6bq4fVYD4msijnXXwROr++haAEer9GIN0GcHE4F5QvX0lkTAv5qSfJ9tDYOTRmXmf8Z9
 Smk/etdMFabCLwdybyBQjDyAoulO0kjOWDaQPmuIh2DZgqmD4HRCAakA3rUyrFEHUVn88lAiM
 7Qy/IWRLI0IWkvxckPn6fUI6P4dbOHfEZ8fjtLuxwdIMUgh5DAkyVryiK9yfYJr8JdI4oOUEB
 EgI/D23DI8z4R/y1KJJdr5HtM443v06XBbMy+xuyBpGkpyKsvt6vTT2Qvep5GuM0qAyHkWcE+
 5eahNDMqoca/WTm0a7DK7rwbynDwNwKRFj2segu1g7XHf6gtx+MK9hQMPuzPPjfJa21SZ/mcy
 hUNVKAw==
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Am 12=2E Februar 2025 08:01:27 MEZ schrieb Sam Day <me@samcday=2Ecom>:
>This reads a little bit nicer (IMO), and is consistent with the kernel=2E
>
>Signed-off-by: Sam Day <me@samcday=2Ecom>

Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>

>---
> drivers/clk/qcom/clock-apq8016=2Ec | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/clk/qcom/clock-apq8016=2Ec b/drivers/clk/qcom/clock-=
apq8016=2Ec
>index b5def55dbc2ac671130624dec56592288a0ceb3d=2E=2E0c247250bd92b2bc888ec=
b7dc0a06e808e087fc0 100644
>--- a/drivers/clk/qcom/clock-apq8016=2Ec
>+++ b/drivers/clk/qcom/clock-apq8016=2Ec
>@@ -54,8 +54,8 @@ static struct vote_clk gcc_blsp1_ahb_clk =3D {
> };
>=20
> static const struct gate_clk apq8016_clks[] =3D {
>-	GATE_CLK(GCC_USB_HS_AHB_CLK,    0x41008, 0x00000001),
>-	GATE_CLK(GCC_USB_HS_SYSTEM_CLK,	0x41004, 0x00000001),
>+	GATE_CLK(GCC_USB_HS_AHB_CLK,    0x41008, BIT(0)),
>+	GATE_CLK(GCC_USB_HS_SYSTEM_CLK,	0x41004, BIT(0)),
> };
>=20
> /* SDHCI */
>

