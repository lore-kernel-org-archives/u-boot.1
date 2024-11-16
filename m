Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF230D68BE4
	for <u-boot@archiver.kernel.org>; Sat, 16 Nov 2024 07:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2413E891B1;
	Sat, 16 Nov 2024 08:37:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="D6xhpfWf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56306892AB; Sat, 16 Nov 2024 08:37:43 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DA2689137
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 08:37:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731742657; x=1732347457; i=xypron.glpk@gmx.de;
 bh=AHstzJUrSkEvcMAHYQxnycG56jkc+iYptF75+K8kW28=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=D6xhpfWf/3YwaA4XbH3t3mQiU6QAAsHwZP35tzag8zBXETb6d7j70Tm69WSE0DTm
 KX/0qga+OarpNtKhNKk/Qr55C6u4QTVAoP8gdz9B3CXfdsGX78AEUhTOiLXmJ9IB7
 ix0SyT3EnuNIhnR54Ndff35oWFMXmj0U+4809SiAe+0bzpFQIk2PWSbegx1LpIsz5
 38Cnc+Y3TNZlhHMGrxGA8dPhqLUDETaO7QLi8el+yUh6ZYV078g0Nq4E1QwzyEhiX
 U/OtIvMs1q2oLbgtCqXp1KkL0mKa6ork5qmXLuNKBibPRvW1r3JaLlgfhZGpVQhXd
 hdaGBJJPiRMqo27qtg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUm7-1t3AR53gRL-00BZQ4; Sat, 16
 Nov 2024 08:37:37 +0100
Date: Sat, 16 Nov 2024 08:37:37 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: [PATCH v5 3/8] efi_loader: bootstd: Drop bootmgr for sunxi
User-Agent: Thunderbird for Android
In-Reply-To: <20241113150938.1534931-4-sjg@chromium.org>
References: <20241113150938.1534931-1-sjg@chromium.org>
 <20241113150938.1534931-4-sjg@chromium.org>
Message-ID: <9635EF98-611F-4F70-8759-516FF79ECBDD@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M65udpFeH3zh5X6Z8xuYTLr79PD98R2t/DXorWRVBF/4SBc86nc
 8JIj9L1E7xLtclOXImVaFt733ZO9yExTJShHQ3035v0ZoBI4LBJXdujrwa3M/XjHKppNtVM
 JyFKJNeUs9kMMU2NqCTwr6L1a+5O6SUMzQBrgXuyX46XR5qtfegXfz5c42YwbcDLJKJ3VMu
 s54SSlzR+kHEcPoQzE4uA==
UI-OutboundReport: notjunk:1;M01:P0:qgU9ALluPJo=;AbH92X7kg9j4gXXcC7dyj9DDbEU
 EPMb6n1rKkOmmwosqoKB1TTobS8K0Cc+c0pmc+GSn0XBbuaupe1zU//KVMvHI+eeKangKSD1a
 Uye4sQ6HExwAwc8KKl9ja5Gkyr3C5pewsxrSD1QDO1nc/g+jbxrpiPexmaDJ3d4ywnusSnep6
 T4gtTA83GR05qXLJT9kAMgepvYfDz4nMKymnb8amobJMn6xPtMwEbzYgg3Xpoiq1EMQIUMNPs
 PUQBGCeolzjx3DBbEa1yejKhXqmKYRl+qmwC4H3O6Gz2n2RXl4CdbbdGXYuSwxIF5uI9BLSsk
 2t06RBdG0OIeOm0cTqJWYeMYJwozprws2hzSh7O0m28SKadHfAfd+8BXirlQIT3FIksR7SFq8
 cZscpXEfDmyswcvJ6zJQdTNmKGal3+Tv8TSklqrbjwCH7Ah2VdpmoD5GNH4IRUU4jrA2WEWIW
 OCm+4A404TiTg55KeC31OtvXb+gm6BwTEBe7IGeC7YLEhGTsNqbywQPCp+byB0FpcNm9sUGLo
 CwkksM67laYtsZFRovlQHWdx472/kWROWIy5Az1AY4mmZD915RVB2aMUTETAPT5aSJ7jvrVKU
 M1nPfrvfg4dUlG1ePLLXyyq7hdVwe2lKKIjjPri6cIrEQTbUvBevko4AIe4yU7k1YMqAsiM4g
 0CFVwRKefnJtKNIp1jHOiIM0d0j1+TjPtDOzInnO5FsNU5WrcCoHAfufRuMfT8jETDkDA+GpE
 Syt1/ANKgZHiD+TLIuphuDf0kMRK1OV4yN99C6J8xZy+HEfiPc5TpJ1jM2ouhHdPO+dQKurCY
 FtsuEblg9KytZv1SiWcIhmxrsb8TDzaY/GFULOHEXYodiRZqBdZIr5UlAUFAUKrm7+uGA1wui
 WQicsBdpF/G2MmAngrFPpFEi4ZrsE8sRIiAYbbwZOtKgALYNED1vwsUD8
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

Am 13=2E November 2024 16:09:33 MEZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>This causes problems with the boot order, so drop it until we can figure
>out a better way to know when bootmgr should be used=2E

It dhould be used by default=2E

Please, describe your observations in sufficient detail=2E

I don't think that we should break EFI booting on sunxi boards=2E Please, =
mark the series as RFC, if it is not working properly=2E

Best regards

Heinrich

>
>Link: https://lore=2Ekernel=2Eorg/u-boot/20241112171205=2E4e80548d@donner=
ap=2Emanchester=2Earm=2Ecom/
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
>Changes in v5:
>- Add new patch to drop bootmgr for sunxi
>
> boot/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/boot/Kconfig b/boot/Kconfig
>index b612360ca55=2E=2E42c5ed288c5 100644
>--- a/boot/Kconfig
>+++ b/boot/Kconfig
>@@ -583,7 +583,7 @@ config BOOTMETH_EFI_BOOTMGR
> 	bool "Bootdev support for EFI boot manager"
> 	depends on EFI_BOOTMGR
> 	select BOOTMETH_GLOBAL
>-	default y
>+	default y if !ARCH_SUNXI  # Temporary work-around for sunxi
> 	help
> 	  Enable booting via the UEFI boot manager=2E Based on the EFI variable=
s
> 	  the EFI binary to be launched is determined=2E To set the EFI variabl=
es

