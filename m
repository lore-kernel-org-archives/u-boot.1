Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1BEC3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADBD588A23;
	Wed, 24 Jul 2024 17:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gE32nogh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 883CE8897D; Wed, 24 Jul 2024 17:10:05 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65406889E9
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-39728bbf949so25733565ab.3
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833802; x=1722438602; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=biv477SUku2PWI/np0g8ugf/hkmgK0ip2MclOV363hs=;
 b=gE32noghn4jsnIVmnz9RHeFHh7416vlPPjp1pSxJPMX7RJb/nxL0JXiPhqC3O588PA
 fNYhXOP6H4E2/BgC/USN5Fdolrc5KTenKaDtdwWvnmWakzVZGIJfeXFk6jcVRqtqgVW9
 nXBR5jHs7jS1tr5byPWb1dzCmcLZ1xQlOSHY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833802; x=1722438602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=biv477SUku2PWI/np0g8ugf/hkmgK0ip2MclOV363hs=;
 b=eOEPUwXM0d5AWV7nsUBHuAr4wi5d+HfX346T+H60ac4IYsUHFmk/piWKWMEY3ckkyu
 W7cynLfQ/h9lOlQFNinVM3Di59XPcM12S7KejJsc9qTpQJMlFukYOrMAJavj89cNhoTs
 jRv1noV3DiSidPDxyf+XnRT9dt6S3eP4FKyfYrRQqoYYCfNiODqegZZNYFowFEOvx5eh
 66LXygvoCipZLzhk1U92xB2qnFrB/eDQ70YR1bPaXCrniYRfjH0ISK5y4VNs/6gPLIW9
 Yz/kYdCG5oTqrfH5W+63mfjYo5fcm0XTvHPriZjZ0RslZep23yF4WreLv8GqViv7DJhw
 gIYQ==
X-Gm-Message-State: AOJu0YwdDPcdKny2VkjVDhlcV33ICMgYDkOulIgb0GP5slJVgnAR0Vmi
 8lrFCIm0LkIrr07RFgQQdC8CeaRAg3SDesZO5l5YRQSwJFoNPoxadgcmp/AtyALgKzyGkzAjOCI
 =
X-Google-Smtp-Source: AGHT+IGo4wN6Lc0LofaVouHxPPkddW4DGSaW3Ch0poZmLDSQS/idLftzVaM0QjlUZsqUnCHBYCsxkQ==
X-Received: by 2002:a05:6e02:148c:b0:398:d627:44a2 with SMTP id
 e9e14a558f8ab-39a194d7c4cmr28942125ab.26.1721833802061; 
 Wed, 24 Jul 2024 08:10:02 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:10:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH 28/35] global_data: Move env_addr field higher
Date: Wed, 24 Jul 2024 09:09:15 -0600
Message-Id: <20240724150922.2343249-29-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
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

Move this field to be with others of the same alignment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/asm-generic/global_data.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index a52794e1e86..368b19ffb60 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -58,6 +58,13 @@ struct global_data {
 	 * @cpu_clk: CPU clock rate in Hz
 	 */
 	unsigned long cpu_clk;
+	/**
+	 * @env_addr: address of environment structure
+	 *
+	 * @env_addr contains the address of the structure holding the
+	 * environment variables.
+	 */
+	unsigned long env_addr;
 	/**
 	 * @bus_clk: platform clock rate in Hz
 	 */
@@ -74,13 +81,6 @@ struct global_data {
 	 * @baudrate: baud rate of the serial interface
 	 */
 	unsigned int baudrate;
-	/**
-	 * @env_addr: address of environment structure
-	 *
-	 * @env_addr contains the address of the structure holding the
-	 * environment variables.
-	 */
-	unsigned long env_addr;
 	/**
 	 * @env_has_init: bit mask indicating environment locations
 	 *
-- 
2.34.1

