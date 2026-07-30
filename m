Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176D8C55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:18:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4C7840B3B;
	Thu, 30 Jul 2026 14:18:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ztgm-mgsUJY8; Thu, 30 Jul 2026 14:18:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF64940B47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785421119;
	bh=MFfIz9O2F3Z86LHBXvxQJaur+HJu9opJ15GVcDMjClU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bVDaN0MgD1qWdvzkDAxcliw1/GhaiJLy6aseERXkHYNhmnDHuI1oUpejy1gYyDKuA
	 sMY27ZDQ/8zHJsd5dpzy8FIKEZx3RtpuxUOK1tuPpBZ7alV0Uq5E4j8auZrWLzpKWq
	 yE9UiR2moG6eutkP4Cx8daNVyRAtpbtgZReYhCyasuiej7GUrYdPM5CquVRZ28nB5M
	 hGGt6+UcnXfdlnuroyFVIy/QH0IVkhJULxGcVsmFiIN6krIZ0fD7gYxf7MChVnTwYx
	 so1iA07pml1DqdhgZYt426WiX89Onm9NCGYxIdd/bbvf3eflC5A3WJmXETPkIYygEv
	 j/lJEoJFuJPMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF64940B47;
	Thu, 30 Jul 2026 14:18:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6262269
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:18:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5462E60898
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:18:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QzjDkvAZCOYK for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:18:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5AD3660890
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5AD3660890
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5AD3660890
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:18:37 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so223818166b.0
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 07:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785421115; x=1786025915;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MFfIz9O2F3Z86LHBXvxQJaur+HJu9opJ15GVcDMjClU=;
 b=Ts99ZbQUJzHUlocQzIGg30CwifzHM680cEibdDbwEkcWM2Q/3soww+pL9soArVdQgs
 Mv1D9O+/KGjfHPRzJHbN4CnqXzleWvIY8ktiAxEdoGZwNWL6/bA4uWw46XauSSUK4sh2
 ioaickgtnfOlJWiPmnFfgZJGqnYpjkLRrBFMPfA30gOReqjU+TTD85NLvJkKaSVkOaN6
 GyXb4HFOarWpUJglNHzKkgRoAcCrkyI6uIsOp84uPJeYd8w0sYh9r5kxh1X7HXwMl7Yd
 i2N9kZJco5blNcArXHIu36S+mKqPig3rXKjqvsPgpakKch8lpGDm/4Bo3cXWW1yigWx1
 Hf8A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4VBkhzxt+C+9L3yABwdjJ1m0ILIVkG5knAfdBG3r699X9IXcAI0XDEFuQ/VT3JN/anW/N/w4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyuspE+/BplbLqVDvnxcPdi+4kzieRxNfzpa0A1V0Cz+6ibhp7P
 YrKCSJJMB0/FASfkqoiazsVQYRUTQvBrA9D79ZpsfoJtiU/SMJforr6THcSvcQguCRE=
X-Gm-Gg: AR+sD12Hn26RHXmeH2xP7JS7vG+YDyVDfhKmBtCC1MrC3wN7eitJOxGPYiije/8nlRu
 6/QjIF0nZBVO0w7sjzpnznYuX6qsDtiV2fRkzWDraM7mjTtASBnAVweSqvjjkM8Njt5UFYOaBSo
 3Z4MKhAyU0Rn66laFimOIUZ4Fv6giXegL226/xK18fCk1VcyC+1Pp8GPN9C9JnBeUs7qrQB6dH8
 FBDSK8UWeJEwIX0GVIOdgiwbk+atkj8maq4COm1LTA37gf+oVUUO9oJj6GoHXG3r6gEkRg8LGHs
 Hkopbsa2PV6qwKYY2LbbEtPj+LR4hpH8261BQSR+7Ed+7WeYDzehihhWyz+WlUOq180fxtTLHfL
 YMYVRifenuSuVmAfD8MVu2N8Fd42J8QNXDGhw2Kb+Ce9AfiLqgYsrxJ+ekMlQNbkMr9EEZ9/VDw
 6fQ7JW1s11fD1pl1E9M6yj3mnnteDCfO3dWKh+ooA1zxfUkF/FOmRL2zzviQzOek8Phq9wy+H4j
 0QygmSmrBdMQ120fHGvMp01KZZlLz7ojSPZ/0cvkZGVE0xEEtDyzxyhueSDIq9vAbYPs61ow8sT
 NJkGOQ==
X-Received: by 2002:a17:907:6d27:b0:c16:2a6d:86da with SMTP id
 a640c23a62f3a-c1fa5777781mr157243766b.54.1785421115092; 
 Thu, 30 Jul 2026 07:18:35 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.retail.telecomitalia.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa851b369sm78608266b.9.2026.07.30.07.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 07:18:30 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 30 Jul 2026 16:18:08 +0200
Subject: [PATCH v3 2/6] configs: mt8188: enable eMMC FIT boot from SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-ccaione-upstream-mt8390-spl-v3-2-82fb3bca27a4@baylibre.com>
References: <20260730-ccaione-upstream-mt8390-spl-v3-0-82fb3bca27a4@baylibre.com>
In-Reply-To: <20260730-ccaione-upstream-mt8390-spl-v3-0-82fb3bca27a4@baylibre.com>
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
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785421115; x=1786025915;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MFfIz9O2F3Z86LHBXvxQJaur+HJu9opJ15GVcDMjClU=;
 b=pZivSvTeeUxCgH8948IyOtE31zYXp3Bf7mDPYPdIhYCESDPBlaQm16VgS/YqGuNT3N
 KHdik0wkdGLj7yN5K698LpGMsca9MJBbHnMsMEAhSXLK59MfUi0jCyCQ1QAYsNQ2BbtM
 9avJDOOXSx8HO+cdVtP6l5sieMDpYBVhGDeAiDqIBFH3u0PRHq78E6kM7WFEXqHUjSag
 EZX+gLzkRyKeu/75ymOHtqdvyoShuzNsqvSx+b7bg36qe5xhESpSt1qUDO0CufUNZVKs
 +ZU3qh2JU1O1ws6J1bp4l4QthhBhTX5CzJAQEnnoUf/b34lwWU+O9uEJnvJdEqLABNYC
 bJtQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=pZivSvTe
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

