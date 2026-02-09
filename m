Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85001E81BD3
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B20D8388D;
	Mon,  9 Feb 2026 18:59:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kSG5/LAx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C30EC83CD3; Mon,  9 Feb 2026 18:59:53 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCE1883C61
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 18:59:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-59e4a04f054so2468923e87.3
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 09:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770659991; x=1771264791; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gpAupF9MpmCV5OKA3j1B2ib7HRDmuHhE/bctYfYIIow=;
 b=kSG5/LAxMib2Qe9wsViZcCN+GQuEar9iW8yrDm0uR3ZadBH6zuVBWyPcFIi4xtb0zt
 eOhKiZVqc1rvCkY4WXLXjYHwaGjbWc3lSyfAkVeZMPmgW09/3cIRWwchkL3ugCOQKD8F
 +06/EoigFQ3IYDITxGCeO3iOkp7wjI4kiFF0FifXM0p940hNzzoo8JodrODaCf5GEXSS
 Fbf4cw+YPthrQ+Zym3rjlp1PfCXZY+ufaZUtIHs0PMjw7otp17Q6mVqYBoEG8fLnQEXf
 4F3SBXcd9XrA5wFzcU9nH160DcH3If5a8ku3kP6DmvFlKDzCo63MBQgTF5/vqCaqVYdC
 athQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770659991; x=1771264791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gpAupF9MpmCV5OKA3j1B2ib7HRDmuHhE/bctYfYIIow=;
 b=dHqjayfYFT7fPCPx+YZsFGp+Zeez+SfX5WMWfPt9GhJn8Xx0+XnL6d4blnvaJfZZvz
 IMci3POSgpQnhc/bqIiqa33vSGAzCiX/SUD2rH491XL++8NWQ29EU4wxQ0mMXYY2z69V
 4pW6nwyfKbe7UO48vsC/JsxNpWMi4uEUiRfT2Lao7lkQ8jReIbiq1vrkQVYZY5MzLKS1
 J1+Aydu34TxdXpFimYY+fbKclcyaMX1wMcTjJRLbZZr9psNw6UCn+86NAJw8Fo+jw11e
 CbqVwQZfiCWNm8X/wUiVrftBgklSsaJmA/yWos1XOgvLpyZueIzcT5Zm7va1WGjKrq0a
 BalQ==
X-Gm-Message-State: AOJu0YxxM3FWw+gCZHMY1aMmv1P2rJJHC7LsnmKf9WqfHKkxGEl55n/7
 Fi9AzPDb0id5oZKR5uw4fgi7BoEbZP+i9yXGty8gAX5FtyXXE6L0Q0NQ
X-Gm-Gg: AZuq6aLOv6I4MP5+g2AHLXMbN/K2hma71sgdiAKMMv42P3u6ysXIRvBo+sxiPzOWRk3
 IXP9bONx3yVkOAEgpWpAN4FLfXIukIaS+6Gedluh3bSIr0675HzGY+MhFolkVUc/27byuDFbyjQ
 2Dyu60ks4DPWXV/zpfG9zNNWGQMyMXb9+aL3ZXAOBPlZi8JRG1fG1t/UjOrUZYLzw82aCXVcoTf
 NVVWDrRNN5DnQSIaMKpeZ51Mjxo52xvuqiGkQg+3e3quoSNusLsZI76s6233Gb3u85GXBEnfhbq
 BQy6Nad3FmHmfu7IUUZVZ+PQpPdqbwYyLmmeVkHdqzwarILcV+IN9fBJXuNKuPEd1O1ZNUKsoZ2
 A9YEoAtYerpgOxh9BO6vrBfewoeO2Ekd0YoOLvWMl+/3bzWRsbN5Tl5iHvi/EpY84e1Fcj8rBXC
 j2V0Nk2xhp+uE=
X-Received: by 2002:a05:6512:3356:b0:59e:24e6:c5f8 with SMTP id
 2adb3069b0e04-59e45152f40mr3809144e87.32.1770659990847; 
 Mon, 09 Feb 2026 09:59:50 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59e44e21c9fsm2756688e87.77.2026.02.09.09.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 09:59:49 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Ion Agorria <ion@agorria.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/3] ARM: tegra: ap: add debug prints for unknown SKU
Date: Mon,  9 Feb 2026 19:59:36 +0200
Message-ID: <20260209175937.32010-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209175937.32010-1-clamor95@gmail.com>
References: <20260209175937.32010-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Ion Agorria <ion@agorria.com>

Add debug log prints with a message that SKU is unknown.

Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/mach-tegra/ap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-tegra/ap.c b/arch/arm/mach-tegra/ap.c
index 4d66de1e937..48617f3ea93 100644
--- a/arch/arm/mach-tegra/ap.c
+++ b/arch/arm/mach-tegra/ap.c
@@ -78,6 +78,7 @@ int tegra_get_chip_sku(void)
 		case SKU_ID_T25E:
 			return TEGRA_SOC_T25;
 		default:
+			debug("%s: UNKNOWN Tegra20 SKU ID (0x%02x)\n", __func__, sku_id);
 			return TEGRA_SOC_T20;
 		}
 		break;
@@ -86,7 +87,9 @@ int tegra_get_chip_sku(void)
 		case SKU_ID_T33:
 		case SKU_ID_T30:
 		case SKU_ID_TM30MQS_P_A3:
+			return TEGRA_SOC_T30;
 		default:
+			debug("%s: UNKNOWN Tegra30 SKU ID (0x%02x)\n", __func__, sku_id);
 			return TEGRA_SOC_T30;
 		}
 		break;
@@ -94,21 +97,27 @@ int tegra_get_chip_sku(void)
 		switch (sku_id) {
 		case SKU_ID_T114_ENG:
 		case SKU_ID_T114_1:
+			return TEGRA_SOC_T114;
 		default:
+			debug("%s: UNKNOWN Tegra114 SKU ID (0x%02x)\n", __func__, sku_id);
 			return TEGRA_SOC_T114;
 		}
 		break;
 	case CHIPID_TEGRA124:
 		switch (sku_id) {
 		case SKU_ID_T124_ENG:
+			return TEGRA_SOC_T124;
 		default:
+			debug("%s: UNKNOWN Tegra124 SKU ID (0x%02x)\n", __func__, sku_id);
 			return TEGRA_SOC_T124;
 		}
 		break;
 	case CHIPID_TEGRA210:
 		switch (sku_id) {
 		case SKU_ID_T210_ENG:
+			return TEGRA_SOC_T210;
 		default:
+			debug("%s: UNKNOWN Tegra210 SKU ID (0x%02x)\n", __func__, sku_id);
 			return TEGRA_SOC_T210;
 		}
 		break;
-- 
2.51.0

