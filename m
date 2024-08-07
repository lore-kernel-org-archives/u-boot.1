Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55AAC52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 20:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A5C288C35;
	Wed,  7 Aug 2024 22:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Yn2RGmLh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 478CE88C44; Wed,  7 Aug 2024 22:50:46 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20C7688C14
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 22:50:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-260f1664fdfso241434fac.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 13:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723063843; x=1723668643; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kJyXp7ZeB8ljuGqQh+TkXqtzixe5UFS71xxyO19zjOE=;
 b=Yn2RGmLhYp1ZSWA5t0vrn787XOv3EokunYQ8vDLn1mC/8Qd3/E/M2HnXJvza9AxvnJ
 aaLqfVHAZe+Tk0GazhAHqixOmtQFoLUGn3BLS7qjjczIxU7eV/g2Ogxo9D+95PTJvxAy
 wPzN/2igkcDCIe2cOYuFukUpUiFhgBCz9e+lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723063843; x=1723668643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kJyXp7ZeB8ljuGqQh+TkXqtzixe5UFS71xxyO19zjOE=;
 b=pH3iogfprlq4oOaZQjFv1TTiCGa2SWw6BnU/0ncRxyKRRGcwVpbmtC8ONeippUkDVh
 Yqhc3Z4gLSdTlu3bAv2vLc7d6L/EYS2Eai+lVyLN9aOBtpfgUVdIQ3/l8WGcIvvjBUjm
 UHS1JEBfEcjhRAmdRPPNzQbWmk6V3YgYzU3Nk5tMM8Yr7rK1qVZtm9g1Nu/7c1Y++WY4
 Ou49E8l3rI5lpFZfwYod6F7ZHfKkZOv4uz0j060vIe8eps68ClGRy1OSp292e9jvv0vN
 rDthDtIKz/YfhPrzWxswzQQu3lFOAqmWskp5q3u817He9rZdzpE2u0LxbjbhOo7mvcE7
 ijiA==
X-Gm-Message-State: AOJu0YxMJwVHvF2HjqXitF7pksQLOlGBOH7mDcYRmJyIUL0Nz2sGp3XH
 M4uXD985rBnvDuNq/1ZUELwg5lq5nsXKYFUVm3EqRuzbgP3GIx9oaeszBo1Grw9+gR94RRsRGR8
 =
X-Google-Smtp-Source: AGHT+IGkfRjVushYAHbHg2mQX3l1nBnoy418fpfNCFXxQ5kHS259sbc2EQS1IMg7vsCu3x7tqKFJsw==
X-Received: by 2002:a05:6870:1699:b0:264:9484:a292 with SMTP id
 586e51a60fabf-26891e92feemr21172453fac.38.1723063842644; 
 Wed, 07 Aug 2024 13:50:42 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d6988421sm2912581173.32.2024.08.07.13.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 13:50:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 3/6] sunxi: Move to bootstd
Date: Wed,  7 Aug 2024 14:50:29 -0600
Message-Id: <20240807205032.3745680-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807205032.3745680-1-sjg@chromium.org>
References: <20240807205032.3745680-1-sjg@chromium.org>
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

Drop support for distroboot and move to using bootstd instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ba0359fed5a..5fb14cb23c0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1179,7 +1179,7 @@ config ARCH_SUNXI
 	imply CMD_DM
 	imply CMD_GPT
 	imply CMD_UBI if MTD_RAW_NAND
-	imply DISTRO_DEFAULTS
+	imply BOOTSTD_DEFAULTS
 	imply DM_REGULATOR
 	imply DM_REGULATOR_FIXED
 	imply FAT_WRITE
-- 
2.34.1

