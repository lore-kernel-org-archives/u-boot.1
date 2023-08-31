Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE00C83F29
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 04:05:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E70BB8655C;
	Thu, 31 Aug 2023 06:05:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="nBYuhAyH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB98486561; Thu, 31 Aug 2023 06:05:27 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2473586558
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 06:05:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693454723; x=1694059523; i=xypron.glpk@gmx.de;
 bh=Zaabr2xSecYebXHmeyY3uCPMyBBttLkwR0BBHSIPYKY=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References;
 b=nBYuhAyHAkUQpiTKSHy6whvW5kQtFWNS4KWu7wA20b5keGhDKi3p5CWPv9DJxpASDvd5qLD
 +xdwsBp+KFjFRIULXZGAxa1WW9l3esWiBQDS4cNK3jl2TcfJnQ0NlhZsmgrS1A+PZ8YhO6nvm
 93KP5DyESCzKLFNFzYsjvcLl/c8KT3npUK/CsBj98u99WdRufmihbbHz3eKIeFn3fikcxLEVu
 9MKOz70IZGHdGyAZUyETyNu6mvNFvKJS/ij3OJzn6tr3Lmw567BRDO2sM8tprakr1LlmwRNgv
 eFMzQRvE52tzLINZ7YwHXn8VU6YcVWQRT2yyNNMB2tCbSp9Qffng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([62.143.244.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfpSl-1q0ZEA2RDN-00gKjl; Thu, 31
 Aug 2023 06:05:23 +0200
Date: Thu, 31 Aug 2023 06:05:22 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>,
 Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2 03/19] video: Hide the BMP options
User-Agent: K-9 Mail for Android
In-Reply-To: <20230831035319.2316665-4-sjg@chromium.org>
References: <20230831035319.2316665-1-sjg@chromium.org>
 <20230831035319.2316665-4-sjg@chromium.org>
Message-ID: <96711E1B-FA6B-44D5-ACB8-421C85373432@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wr+gHEyjx2j7XegcGPwo9yPUR3jGYFEHLXFwWM99PnFCLi26aZ8
 V9Be+wXN/w9Von0MVS/lRws3+2Ap7npxsIXzD42d7bAEixBRtD2ucuu1OrCSncbAcRCNK9k
 j3Ba6cbK1d2CUhyiu0HdI+Hvq/211GRDVcAK8aU6ALGo8TQOl7INbiPo4uKSlz+anATC5XH
 JzO8kw2XtAa0mIQBHoc6g==
UI-OutboundReport: notjunk:1;M01:P0:G+XyX1Zi76Q=;7v83kdFL3UTx5Ow6hR8UtNxE1Ps
 0tPn4GZSlTLhJ/uxn38gpYnr4W/3Zh5BTu0sRMjlsmG5tXi6iVB+Sz+1XYBHQyyuSpO3MAdUs
 TgLSFOyJr234Sd+w8JpHGyXLrLKHTC498FG27YM35Pc8Vb71w0O1I+9v40i2bilKFOdGd/8eO
 o7IHt7R9eb3F39UATz/SfnneILB4RrF8v6M3jM3GpUz0JplnxGiSdkAd4DhRTAY2KwwH337NC
 KcVfb/6dLCUgkLjgLjY5uHqOWkxOTZv5ASsrjoOgN+wUIidVg3SYO2G/NLzL21/SNf4d6rctm
 mCuKhBj7enEdVdBl4WfZpEVOCIDIqd8yIGUsND/2gpcoFNitpoFqtagzQlRcpTUaIlMnuMUuV
 wZq2k9pRyAaNkDstkWGFe6AHbIJaqXjS8Tnq2FEtiIdJJ8CdYcDWn1n/6pSUiK6SISXVRNR2K
 PIGQt30QTT+w0ProJRvpBvdyUVpf+lRMK0unuIICVABVb13XcxFAfEk70D+Ad0ZMENwwJFqhC
 89Nx9OFDldGc2/jrQR0tuC49A78XK5mrNzHoI9dQF77/jUEMMuUcTb7NeNJ+Fkc9vGyvwhrsL
 nfZHuIbuOuOlJkQstA0mb2HUkWkbIKuyHPfRMfavLOi34OkWxUAvCtHl9nUIEgnbXonxUHoBb
 Bt9VirKzTEgv8JWQYHGN4eTOviBKGecBpGr3PeS4D5B9B212mJQSZUgdyBUxh84lhxBAvCs9T
 YENvbg8xKpWEp/RrzVWEHZOGbNiWJwTwlWsy/Vul/E9G/hBvL8AWXLZJnOSj5PMr+sdCyoZ2j
 alTEogVYazmQ03d18IqUFlDo5xZREHimt0BKS/gSoIM/DfXLvm+3G0trEyzcNfgXodbTHnUIv
 543rZ5A6EY6JbnifviYU4JttWWf17rrGYFl+dYotl2rOlFmDrNKaoRevIomry6im2Gao390ED
 UoHbNg==
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



Am 31=2E August 2023 05:52:57 MESZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>These appear prominently in the main menu at present=2E However they are
>selected when needed so do not need to be visible=2E
>
>Make them hidden=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
>(no changes since v1)
>
> common/Kconfig | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/common/Kconfig b/common/Kconfig
>index 0b09bd68bd13=2E=2E844531a59eda 100644
>--- a/common/Kconfig
>+++ b/common/Kconfig
>@@ -1169,12 +1169,12 @@ config IO_TRACE
> 	bool
>=20
> config BMP
>-	bool "Enable bmp image display"
>+	bool # Enable bmp image display

This must depend on video=2E

> 	help
> 	  Enable bmp functions to display bmp image and get bmp info=2E
>=20
> config SPL_BMP
>-	bool "Enable bmp image display at SPL"
>+	bool # Enable bmp image display at SPL

Why should I not be able to deactivate the logo display?

Just move the entries to submenus related to video, please=2E

Best regards

Heinrich

> 	depends on SPL_VIDEO
> 	help
> 	  Enable bmp functions to display bmp image and get bmp info at SPL=2E
