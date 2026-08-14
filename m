Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F2BC5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 14:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5FBBD40EF8;
	Fri, 14 Aug 2026 14:48:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ShZxpDNxdKKP; Fri, 14 Aug 2026 14:48:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2751840DA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786718894;
	bh=MFfIz9O2F3Z86LHBXvxQJaur+HJu9opJ15GVcDMjClU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WhEqFksk9bT5ACgvvyLg2YbAXKbwhow6VSapB1aCW4EQj2/sgzjAXo6T0EjzIK/9a
	 6mj4NFVOCH4UptYuJbTX9nkHUtJrtD/B7HHojSGahOQdlPqGU8xKXXuZFB7WYGoJGN
	 J2m9fhY/JqFogqCxI3GlnVjmdDIh29Y2eQxEyGZpNJM+RGVIFAoz6obOc4vUVlqJx2
	 ++JjlAUrN3o1Zhr/eYHn8vfGURwAsjgYVjAPiw8yezlP4Hw+e+gFSriVQiNbkLezlZ
	 yzBeR2a2wcqNMMB5wYPXDf6K9TIoSUdf5lwC47TzDSCyojaQHRxgARub157AYccuIY
	 o97yDyAUNbi0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2751840DA3;
	Fri, 14 Aug 2026 14:48:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DD728139A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:48:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C37B88146C
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:48:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 86TvRvU94KiJ for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 14:48:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B5B7E813A7
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B5B7E813A7
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=IEn9ZjKY
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B5B7E813A7
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:48:10 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c1fbe461f59so176941066b.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786718888; x=1787323688;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MFfIz9O2F3Z86LHBXvxQJaur+HJu9opJ15GVcDMjClU=;
 b=IEn9ZjKYn8xEJ9tJRAqqQcxjA9OwzgwXv+nPu1mnRSFjugb+qU49DVTqOMQqiKr4Aq
 myep46SrJmC0tO06LbQEX277U/g6uh8ooMihrvE+AKtRQmDO+SbfLHDJgYKDCVvrh7s6
 n9Nndl5qESsuET4kDobEzQAJ9M0RzZF6113iTqbfWr99eV8j/NSMD3k8B/zCfjQ0P8lz
 +UHsFDX6d1S3pp0xmNi8/6j2CcM8A0CAyDaVvSsrxFuPmmIV0L0ayO8cNjt8m/zomKu0
 BWsYI2zi7eFOGw1iKcXfGX/H8cVqOI890iElzaK73Qod9TxB+6r95cNSHwPxbxKqzi2N
 jkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786718888; x=1787323688;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MFfIz9O2F3Z86LHBXvxQJaur+HJu9opJ15GVcDMjClU=;
 b=gMBXcsMsScmPgOJ5JEbyO8NBdYxdUlmfpY6PVR1DJhgNeTXAITvRk3ZRJTC485qmoC
 w5Vd4Am8F7TVAPgvOv1MrHNxEKAL45XDikHQJfGlI+cVdiMoYlOIsl6zkJaPxWAIO/TR
 zZMxGkWY30bQdu1nvfa1ulmqg0Y5pvcJ01tyrZENn4ns8TxPnBCSVaeEYdJtPA4BYYzc
 wDxPAp0DKluzLcNAlNEH8e0t/0zoUwtoSArLcpk7b20LQH6EJ2zPMtQk4ziNXGddoGUC
 1urzKWJzowvWsq4GrJ00pFY2nEH4MJSaEFzmVpe+UurQrjzNP1judv4/ohIW3Ghbn/fG
 5GFg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr6ySWEIu3nveMnMho3bse60Tp44f3XwU/EnaoWUQAfO8SK6HPal0DHdTyvPla+wCqtW0+sW/c=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yws0xVYE3+Ueuu2vgmVDjbQpNGu+HmQqfRHj73rj8CJCi2+zXDx
 DYjGWwsYzRnM3xpW6/IotLkB0plZWgjkV+6TgtN7syIROxmUTldlp+ggXpBIGDJAqQ4=
X-Gm-Gg: AR+sD13wUm4MYvBiqnRtef5bUsQ5yKukO6FqA6NGu6WbrqPp4PkaTg9GE3R7AZTkdxC
 9WAXxSFlBWhZaB9hJvwZbLqIwHl8scd3Fzia5W3wfx2L7X6lUC4m7mMtGYViA5XiB4pBAn85MOF
 EvNasmnsEsmkoDfagNBfZUL6+DMr8/cW1Ws7TarHKZDYxwzpkKQXJHqzgSFa3wW2lzI1edRNXbl
 2gqk65mH6ufxzhA21Fh/nZV4SX8UkOvJgjE+9Fy1HkhpKUXfOPXfq8Gb+Hivc4tt0cZWF5IeC5T
 HnKp35MIXoUtdUcrtY2OoD3QTqG8Sf6sDLK2NuqXIwKKQxiiPsaPSYk9SlR9LzBof0oQPD0Zldp
 lzoYBTdB94ysy5FQYe0R+qMJJmfjErff4xEkrw4/hnMzfffRVTAsZAGkRvAwtB5d9G6j1eI/9Kz
 YyaX2qGl+zNudOSs4eSvK/TY6IXiTBgwr9PpOZei/gSlqHFqwUsDD1Tr4htFH1G2MbhzjjD7Icq
 HP/DGhH7PKr/+VTEjvI4WvIIngqU1tqz5nVaETJXj4Nqe97FaxwBra/BLY+KB/8l5ATV0k=
X-Received: by 2002:a17:907:c78e:b0:c20:f6d9:d8c7 with SMTP id
 a640c23a62f3a-c212a256de5mr278522966b.24.1786718888536; 
 Fri, 14 Aug 2026 07:48:08 -0700 (PDT)
Received: from macbook.tail959722.ts.net (static-226232.rol.raiffeisen.net.
 [195.254.226.232]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c212378d9fcsm114992666b.34.2026.08.14.07.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 07:48:08 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 14 Aug 2026 16:47:52 +0200
Subject: [PATCH v4 2/6] configs: mt8188: enable eMMC FIT boot from SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-ccaione-upstream-mt8390-spl-v4-2-f4f92978a79e@baylibre.com>
References: <20260814-ccaione-upstream-mt8390-spl-v4-0-f4f92978a79e@baylibre.com>
In-Reply-To: <20260814-ccaione-upstream-mt8390-spl-v4-0-f4f92978a79e@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, Julien Masson <jmasson@baylibre.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>
X-Mailer: b4 0.16.0
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

Enable the Genio 510 and Genio 700 SPL path entered by the external DDR
loader at 0x40000000. Bind the raw SPL to the loader's 0xaf000-byte copy
window, place BSS separately in DRAM, and retain the non-overlapping SPL
malloc region.

Use generic SPL MMC, GPT, FIT, and Arm Trusted Firmware support to load
the firmware FIT from eMMC partition 1. Keep U-Boot proper at the shared
MT8188 CONFIG_TEXT_BASE of 0x4c000000.

The MediaTek BL31 used on these boards stalls when passed the runtime
devicetree as its platform parameter. Enable SPL_ATF_NO_PLATFORM_PARAM
so SPL can still use the tree to locate OP-TEE and U-Boot while passing
NULL as the separate BL31 platform parameter.

Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 configs/mt8188.config | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/configs/mt8188.config b/configs/mt8188.config
index 29e2b3db878..a84e617e30f 100644
--- a/configs/mt8188.config
+++ b/configs/mt8188.config
@@ -28,3 +28,30 @@ CONFIG_MTK_SERIAL=y
 CONFIG_WDT=y
 CONFIG_WDT_MTK=y
 # CONFIG_RANDOM_UUID is not set
+CONFIG_SPL=y
+CONFIG_SPL_TEXT_BASE=0x40000000
+CONFIG_SPL_MAX_SIZE=0xaf000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x400bb800
+CONFIG_SPL_BSS_LIMIT=y
+CONFIG_SPL_BSS_MAX_SIZE=0x100000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x5c000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x9000000
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_SERIAL=y
+# CONFIG_SPL_USE_TINY_PRINTF is not set
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_PINCONF=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_LIBDISK_SUPPORT=y
+CONFIG_SPL_EFI_PARTITION=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=1
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y

-- 
2.55.0

