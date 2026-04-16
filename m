Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DA7F8A157
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 11:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32B66840AB;
	Thu, 16 Apr 2026 13:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="MhKGinQf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28CC984201; Thu, 16 Apr 2026 13:02:12 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 200B3841D5
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 13:02:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776337329; x=1776942129; i=xypron.glpk@gmx.de;
 bh=8/GVMVW3Hp5OSvdYCI5odZtWO0cxyeobVQ7DkwMY38o=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=MhKGinQf9+9yeysWy6+O3ewUZzr22e7U1CWD8SIf7egic1cqMYFkuEN6RQbto41d
 ZtvZgZnJupZvJowv3gus/+8vqvVVtbPh5BjQRQBgXF7FexdgPtqUk51yKnpCvPAYp
 9X4z4kd9dFaQsXfSCmfMk2slJ5NjhdgFp0G4OygkQcYY7iPdBBkrFuAI75UgfH5pt
 X1kwH4PPaA5p4LYBWb5H2AKugdjPueK/699P/aPhvxMo/Z/RAfn5wMQiM3hi7ROaa
 qQkQGbVK+sL+w2ANTHj5Ra/AC9hXtjxGRaQfK+qIIog1tXqYRWr9qykHLMzVEA4K2
 bOLK1ciyrWrtYl2hEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4axg-1wEzB922w2-009Usm; Thu, 16
 Apr 2026 13:02:09 +0200
Date: Thu, 16 Apr 2026 13:02:05 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de
CC: Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Ion Agorria <ion@agorria.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Simon Glass <simon.glass@canonical.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [RESEND PATCH] video: Kconfig: fix indentation of help text
User-Agent: Thunderbird for Android
In-Reply-To: <20260415183643.3031984-1-dario.binacchi@amarulasolutions.com>
References: <20260415183643.3031984-1-dario.binacchi@amarulasolutions.com>
Message-ID: <BD3542FF-94F4-43FD-A6DC-A9E4F028EDFF@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M/tIoGG/KPpzbYtouIuFDAFkal9Zoc5UF/DzshZuZssInn6mnc+
 rWzhAU58hzup5VIhbItcsJBDCcSv4iB5KHBnmYCDeoVRRmUWbyGWPBePbSB3925WfkJo9Dr
 OwOEXAbfA5Btq46JFrZ9SWcQdL+EZgvlgdUacG22XjC7y4O3ShyQ/GIm1qldFeWZQZdJPfD
 nTWOnT6agGbLZiYhDynAg==
UI-OutboundReport: notjunk:1;M01:P0:pqkHyHEqymE=;+cteYVjH/dnUWqVgH5gq5f0zOaL
 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
 NoYuVg==
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

Am 15=2E April 2026 20:36:35 MESZ schrieb Dario Binacchi <dario=2Ebinacchi@=
amarulasolutions=2Ecom>:
>Fix the indentation of the help text for VIDEO_LCD_NOVATEK_NT35510 and
>VIDEO_LCD_ORISETECH_OTM8009A to align with the standard Kconfig format=2E
>
>Signed-off-by: Dario Binacchi <dario=2Ebinacchi@amarulasolutions=2Ecom>

Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>

>
>---
>
> drivers/video/Kconfig | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
>index 08c9b0207884=2E=2E8ce660804072 100644
>--- a/drivers/video/Kconfig
>+++ b/drivers/video/Kconfig
>@@ -566,15 +566,15 @@ config VIDEO_LCD_NOVATEK_NT35510
> 	bool "Novatek NT35510 DSI LCD panel support"
> 	select VIDEO_MIPI_DSI
> 	help
>-	Say Y here if you want to enable support for Novatek nt35510
>-	dsi panel=2E
>+	  Say Y here if you want to enable support for Novatek nt35510
>+	  dsi panel=2E
>=20
> config VIDEO_LCD_ORISETECH_OTM8009A
> 	bool "OTM8009A DSI LCD panel support"
> 	select VIDEO_MIPI_DSI
> 	help
>-	Say Y here if you want to enable support for Orise Technology
>-	otm8009a 480x800 dsi 2dl panel=2E
>+	  Say Y here if you want to enable support for Orise Technology
>+	  otm8009a 480x800 dsi 2dl panel=2E
>=20
> config VIDEO_LCD_LG_LD070WX3
> 	bool "LD070WX3 DSI LCD panel support"

