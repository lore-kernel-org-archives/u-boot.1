Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05708C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:14:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F92188A1A;
	Wed, 24 Jul 2024 17:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DE9zU423";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE51888A06; Wed, 24 Jul 2024 17:10:04 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D61D889AA
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-396db51d140so28269895ab.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833801; x=1722438601; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xOVgChu1VZBjNIcgCqt50cmuCEU9tvjR/fmESKpeRwI=;
 b=DE9zU423JRuehCzz010QjTPHIop4zdoC6/81X7C9RLi2Yu/IDsZohYGrXUn3196R5N
 RjY3lR5LthT54x3EP4M1Su83NN1fP8ONO0xy38Js+Ei3PJ+n42XtBHum6gY7Eo3EsTSd
 gxUerJsWUiKW+NOT0T44qpJ4PltTs+aKlEgp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833801; x=1722438601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xOVgChu1VZBjNIcgCqt50cmuCEU9tvjR/fmESKpeRwI=;
 b=V9Ar72kDn7Ez87Ns5D5OsXXBb8RHxWi1qmClOxB+EL38udC84IYyuBckTG1l2CgW2M
 ViBJzYxZ2cvRsYT9YkdqGw+R/ZHLAAGbt7SuBj+2aDwbh/2Tl+oGAsc+BXuWbcivz/4H
 zvqj7tOPDjWoQ6X+b6Yc7RTpUK9mCZ0cyc81eIAnoZJT9IZ/2aZd5r1vqjfs0YHfcVrN
 EtMEid7sdU8T88sc7MHyV2dZJwWbj4TFGEcQUzr1Z6vOJLNUiMGqu72+xIRhpmpFiaPv
 zabMsFf9vjBDhEH2sTjzYXq5m1EeFP1WUHbzgJL/8km9ZxV+bLiJdetfpSUGluRv4qTE
 bfXQ==
X-Gm-Message-State: AOJu0YxlM+KWs5LOBvlnqHZjOMn/bLj/cWymlvNEgDrdb6M/Lj8kSnG7
 VPA9H3l6T/43qz5i0gIaESTnoeoAmJqkKDOWJMHL61eFVsjCql/3NOOBKCYMfBfpmDrRf9UzGew
 =
X-Google-Smtp-Source: AGHT+IFq8h6LgA3MiKj13QycNAAztQsdGIoG5H7vZaPq38MedAPxBGplzQ0KBgai7m2xarv6EiEIog==
X-Received: by 2002:a05:6e02:1381:b0:39a:1d8d:fc9d with SMTP id
 e9e14a558f8ab-39a1d8dfdf8mr16099785ab.22.1721833801112; 
 Wed, 24 Jul 2024 08:10:01 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:10:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH 27/35] global_data: Move baud_rate field lower
Date: Wed, 24 Jul 2024 09:09:14 -0600
Message-Id: <20240724150922.2343249-28-sjg@chromium.org>
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

 include/asm-generic/global_data.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 21d4ddea12d..a52794e1e86 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -54,10 +54,6 @@ struct global_data {
 	 * See &enum gd_flags
 	 */
 	unsigned long flags;
-	/**
-	 * @baudrate: baud rate of the serial interface
-	 */
-	unsigned int baudrate;
 	/**
 	 * @cpu_clk: CPU clock rate in Hz
 	 */
@@ -74,6 +70,10 @@ struct global_data {
 	 * @mon_len: monitor length in bytes
 	 */
 	unsigned int mon_len;
+	/**
+	 * @baudrate: baud rate of the serial interface
+	 */
+	unsigned int baudrate;
 	/**
 	 * @env_addr: address of environment structure
 	 *
-- 
2.34.1

