Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64625C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:08:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF7A8874DE;
	Sun, 12 Nov 2023 21:03:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mIKrLDir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 107BE87528; Sun, 12 Nov 2023 21:03:56 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD53B874EB
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7a956887c20so158227139f.1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819432; x=1700424232; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=znhKgN3yzosOpVQF3/WQtIpPpeEoGmQmll65r52lm3M=;
 b=mIKrLDir1LSNrVu0usJ3MdE4IQZnYwUATeoVM5nyTVnzJ/EycczvHrJEuXyuPlqqow
 u3thBG6lz+SDdLrAOX1NMMhfJv+qjRKVOV9xWB2U/0ApmxaNkJYDApkR2nZb2LoejVAS
 YutMcwpEp+R5JvQD5WaI4QTa3LkaeRlup34bQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819432; x=1700424232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=znhKgN3yzosOpVQF3/WQtIpPpeEoGmQmll65r52lm3M=;
 b=pJFaKfGxdnHoQbN0NbBPU83DCNok7Yuz6oqpsF6L/HrFbhoYCs7bW+toDzbj+A8AGk
 HC/qJtur/221Av6iA5ohyxInCDBDCTjM09wVWOFjPziXZnZNzZUZS3dqg/xke7Pj0+MC
 FJl3pZ9rTpo1jrO5dqnixqaNcWneEXritUN7U0H+XxyuvG7w9JnYZViDPLzrzsW+2Z4u
 2nmPX6M+2w9lWT3hCd0FM4dKoxzj2zsBszomfw07v/at7uL301Dmdch//M/Wh33iJU0K
 SEvXPozlUG83vP37ch/lFHwLBgJ6o9j1PXvkA9xxGj83tomhls1y40QDtGmXAiPbeY8f
 paBw==
X-Gm-Message-State: AOJu0Yzy1bQGFCmD29yyGO1nlfKmSFTGPKXeVWnFja5vkeKjO+dgVVyE
 MJd0nJLTzq0+o0zSRpddxUwoLYA9I85fdm73nOl54Q==
X-Google-Smtp-Source: AGHT+IFBZ4hlcxl1DO4bOXT0hoqwiT1RHsY2vDUWkt2zAHm+zv+dswm8PNlzkgImeCDMbT1fQIbslA==
X-Received: by 2002:a5d:8d02:0:b0:786:25a3:ef30 with SMTP id
 p2-20020a5d8d02000000b0078625a3ef30mr5451625ioj.7.1699819432472; 
 Sun, 12 Nov 2023 12:03:52 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a028524000000b0045903dcfa05sm1239951jai.109.2023.11.12.12.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 12:03:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH v3 2/2] blk: Drop reference to DM_SPL
Date: Sun, 12 Nov 2023 13:03:47 -0700
Message-ID: <20231112200349.172779-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112200349.172779-1-sjg@chromium.org>
References: <20231112200349.172779-1-sjg@chromium.org>
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

The intent here is to only allow SPL_LEGACY_BLK if !SPL_DM - i.e. that
when driver model is enabled in SPL, legacy block cannot be used.

However this combination is used by about 240 boards, so we cannot
disallow it, at least not yet.

So just drop the condition.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/block/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index b897cf1a3d1b..6ad18889f61e 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -13,7 +13,7 @@ config BLK
 
 config SPL_LEGACY_BLOCK
 	bool # "Enable Legacy Block Device"
-	depends on SPL && !DM_SPL
+	depends on SPL
 	default y if SPL_MMC || SPL_USB_STORAGE || SCSI || NVME || IDE
 	default y if SPL_AHCI_PCI
 	help
-- 
2.42.0.869.gea05f2083d-goog

