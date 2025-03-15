Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA16C28B30
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:27:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BB3580F9A;
	Sat, 15 Mar 2025 15:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nUokreqT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81872814B6; Sat, 15 Mar 2025 15:27:21 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CD0C8141E
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:27:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43d0a5cfd7dso4297965e9.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048836; x=1742653636; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FLjPxxvNwl1Izdu8dNxj7jwuxoUTg5WIavhcch5Y3JA=;
 b=nUokreqTYM8EkuZdss6FQeaP4kyX8ml9dTa46AEVti7PYVs13m9wyM1yG7IOJYQr4p
 eKN+6Mn64ggNzKxwIYaIqqn9KDWN8GOUbzjJzmyUFoAcHPn1VcR45IcbltXUxELVt50a
 ljA5UdbnNHttGBd2EWvnUJgB1CBrNjxIlpX0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048836; x=1742653636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FLjPxxvNwl1Izdu8dNxj7jwuxoUTg5WIavhcch5Y3JA=;
 b=uyS5RZaEuH/G+hmU7IOx6OacQ2w3PORq8AjGfS6p0Y25/6dqnCdT6Z5xNKycGpcSdw
 4yjZRcMo/1+QTqhztIUCAHmr8eeHHixjjYU1GQdWABa4Sh1sArMkO+SxhLYdfQxlBefw
 fGnIgK2ZlucLLnOHe9oJCnrP4xPivvcPYhCBPpJTjnlgKsZp1C0Yj7ijNjHvnUmAHKPf
 DYz5m0RJa8BqAk9RCY0B5haSZZONSVGJa0vue4Q5mDglM3+lHVacRzDimCm0dASHyQOA
 LZ/N61UmEWwquHidnL0HDiDBKO07UiVan6Pu858P1pbzQ3muvRWHiFmgiYKds0hF7iv/
 7QBg==
X-Gm-Message-State: AOJu0YywZcISZvQuaeygb9XgjpPQFvIlOXd84DNRR88TEH1TRgxHuETF
 leePKwlTFEyCM4Eldzb7+xyNeu36lXve5Qa4d30UNLt9QDnDlSQGfXxO0DJG8LNfv7upaHrUEWd
 36w==
X-Gm-Gg: ASbGncvoK0g9CHbvUvKR5DU+4Xlj34FhcDxzey/iJCJdT09OLsvk0nDSGvUAylizSku
 nceGH9Vpu5bvXBuvHM/kRyevETDnAZSQFj6R/tRpbLCsIVDehXk3zZJ63NYc1C0lZfr7u2nqcgG
 xah2krPoNNm9a6idZYW3ese8ATXL0N9xQqVCysShKlY059/OU0tjmUGS5WarnzjZ8Ki1XBNGUa7
 LqgdAFEWIggr/mplq1V0hROtcWGU/y5TABFILRhTuv2/dWm3XQ7gp+7KPP35rho5gv7C/nyzju0
 mkWH2B+cujmscBeVEdJtgpDq4A5SK36RnHe9UupPyw==
X-Google-Smtp-Source: AGHT+IEDvpNFUmBhwX5TYKPHx+b2Y7z6YDMb/4vmdgdFt6qAcxKsU9DX1eExU3HvWOtHPklQqDhkPQ==
X-Received: by 2002:a05:600c:470e:b0:43c:ee62:33f5 with SMTP id
 5b1f17b1804b1-43d1eccf8c6mr69631175e9.27.1742048836057; 
 Sat, 15 Mar 2025 07:27:16 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 03/46] x86: Expand x86_64 early memory
Date: Sat, 15 Mar 2025 14:25:23 +0000
Message-ID: <20250315142643.2600605-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

The SPL and pre-reloc malloc()-space is not large enough to start up
with a display. Expand it.

Switch the order of SPL_SYS_MALLOC_F_LEN and SPL_TEXT_BASE since this
matches what 'savedefconfig' gives us.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/qemu-x86_64_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 792ba06c2b8..af275e8ce8f 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -1,13 +1,13 @@
 CONFIG_X86=y
 CONFIG_TEXT_BASE=0x1110000
-CONFIG_SYS_MALLOC_F_LEN=0x1000
+CONFIG_SYS_MALLOC_F_LEN=0x1800
 CONFIG_BLOBLIST_SIZE_RELOC=0x20000
 CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x40000
 CONFIG_MAX_CPUS=2
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="qemu-x86_i440fx"
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x3000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x4800
 CONFIG_SPL_TEXT_BASE=0xfffd0000
 CONFIG_DEBUG_UART_BASE=0x3f8
 CONFIG_DEBUG_UART_CLOCK=1843200
-- 
2.43.0

