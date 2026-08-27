Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3F4C61DC2
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 07:35:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF8BD60770;
	Thu, 27 Aug 2026 07:35:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D2pxvQs-xxz5; Thu, 27 Aug 2026 07:35:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787816134;
	bh=ryXz6NyphhMMWjewgZxC11lE9LeSGr9WPAxbQW9mNhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zzCfGkYYmEcRnVRogjmCEHq2wjOE+jBH0U21lOei3dMoe9MUnvQcgMr5l2LpuQ+IS
	 yr8W/fXS+TaYfac04Jce3ycK0sIyPycdC73lCsdeVgyLRu+DqCMWMyBBDpQ/Ezko3s
	 86SCGdn3sQMkSJPU1JtMrzMYRmxfKSLi8RhMspyzx9yQjSnASxeJrDwgE+XahXdg1K
	 Z1go9BM3pVlEkOvD8CIiNe5VedAqu40DR13pYA4WwFf/7Fcvyai4lhngxBWF1b76KZ
	 b6o0YjJt+vQVhl29H/u+10uURUcXlMk8M3cs3L6d1HE6TC4CSQ1zdFvKSyFQ20QQKD
	 ccEsnPSeEBBXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D23A60774;
	Thu, 27 Aug 2026 07:35:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3616C39E
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0CDDF6077C
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:35:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id esXHhSw7L1u4 for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 07:35:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=I+ZX6fOB
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 09FC360770
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:35:27 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47fe2d179e2so1012700f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 00:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787816125; x=1788420925;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ryXz6NyphhMMWjewgZxC11lE9LeSGr9WPAxbQW9mNhw=;
 b=I+ZX6fOBOswEZD/7ERXKigu48XuJnDrlJJw4F37WI1nawrJwJD/4/ZQPvi7VpTZWl4
 wkAlEN22TVTA3Vfww05KV0ea2Y75PVo+j1pM9beeHUMdpXe5DugSZ4PKIZbwm0jrYQk2
 iAn0IAs61JLhP83KKtaPQy0T6BRQRxDxgkv39/sZhhG012LQMjELS7o+G6zCZnan55F1
 RMrRTijs6fqF76TQ0KqDsfHd7OPY1bt7VwQ0gDaegkzs5tmpWDp9q8q8rwn3vQd7aF5b
 5LNHxyVth7Qs3aIW8+Nclzfw1QYKlYcP9Vm/g0Rp2P5qwp1Pj7ofUNdRaSeIKT+06hO9
 N9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787816125; x=1788420925;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ryXz6NyphhMMWjewgZxC11lE9LeSGr9WPAxbQW9mNhw=;
 b=gt/WBTzoq+1b8fHBOakuciMy3/a75AejK6bg/V8GpHpbKvFYjF3+sTUQU1hKtS9K4v
 sTs9QVzASlAUdUulUes3jCmvIU0LW2mHWGg9EAvs3K/pr2db0HpafITs4V4RZ8KqKerl
 MBE32IyeyajZy+f2kG9iddv5fh4VnuTTCcTUo8J30lkT1N8IGFF7caARte15LP5wxcUX
 AFMqPLtNVofEpSKnYiPDQIfsQfNMyBXQrHrRUBeWvc3yh1Um2evnOOwjdRdnC9XEmi1L
 BoiDqTEFuGSqUMHEWz7GXP7ND/L2Bbs9dVX1MAMe3wQE7ObMATTPv4WoN7HvJBF3BB3t
 ckMw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rreaw/UycUXZDysLNgvwh7MsyjKtxLdyYtOmg9A27NffNu99e1m4xqR3g8FeMXiXZ7Bt6JQb4U=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n0NuHo3Q0ybS0IxVYRKW/ongeLF5NRQQd7yteCCQTkNVv3k0WI
 AFyJJa3t/p7gWGNNXu5sYwiiqjVh/155MShwipxA6QQf4DWK4Ow2WsXoRzlVZNw4p0s=
X-Gm-Gg: AR+sD12mSxLseB9umWmiLczmOgt/0gERI3Og7auSVEXpIhnKyOn8aiDNA08+FmbAoyw
 8266oRatJa2orTYoFjkTTiHAK0heGYHFF1F+n9+MRtV7J++7mj5r2pxYw1rwvH373o8EN4Y69d9
 C8OwT1t20F+1owFpPluXERU9Ckgx7oZUzb/esYCxU9qnMavVhF/bXcC+46olSHCzTvcbVfP4oLf
 +zUSKXjUMkM5jbM7mLWMKlWoL8/vg3aGxqvkFgW8WvAQQkSdGA8HKSvLgtjHU6t0ORlglhpYCzb
 EDKoz7uJtn0yCdezOc6RN4VctqTRIY7q4xf2lRyGMYy0/02lRkNd4SYvU/wdpqqqg79oXhhK1is
 QZi8DuECiSd4NkEj+Sb4SA6C7XdQLM4GU5riWCzu69XGXidtsEWGCH3/OSv3B6XuIhmF87VP2Y1
 Fk1RxEsggvlI3by4MvZErrvtdeGE1nXZZ0rOcO1t5iVuTPrn9GgQVXPl9HPthEz4vth+wFxjpr/
 +hmTHrBYyaAIVeyTZGYZ/GT2wswVCYfCKE8MIRigjIB92ilyeGx2uWvFCgrvQCF+a6LOsxe/eJh
 9SiG3pSO5A==
X-Received: by 2002:a5d:6f07:0:b0:482:e658:bb88 with SMTP id
 ffacd0b85a97d-482e658bd47mr11956191f8f.5.1787816123577; 
 Thu, 27 Aug 2026 00:35:23 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.pool212171.interbusiness.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e27ab6d0sm6788666f8f.13.2026.08.27.00.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 00:35:23 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 27 Aug 2026 09:34:59 +0200
Subject: [PATCH v5 2/6] configs: mt8188: enable eMMC FIT boot from SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-ccaione-upstream-mt8390-spl-v5-2-81d04e3ab785@baylibre.com>
References: <20260827-ccaione-upstream-mt8390-spl-v5-0-81d04e3ab785@baylibre.com>
In-Reply-To: <20260827-ccaione-upstream-mt8390-spl-v5-0-81d04e3ab785@baylibre.com>
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
 Alexey Charkov <alchark@gmail.com>, 
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

Enable the Genio 510 and Genio 700 SPL path entered by the external
DDR loader at 0x40000000. Bound SPL to the 0xaf000-byte loader copy
window and retain the non-overlapping malloc region.

Place BSS at 0x400bb800 (0x40000000 + 0xbb800), the end of the SPL
reservation used by the downstream flow. This leaves a 0xc800-byte
guard between the copied SPL window and BSS.

Use generic SPL MMC, GPT, FIT and Arm Trusted Firmware support to load
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

