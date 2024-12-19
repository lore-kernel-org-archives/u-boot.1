Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1902E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 18:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48D96803CA;
	Thu, 19 Dec 2024 19:30:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="abIigF2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DABBC803F1; Thu, 19 Dec 2024 19:29:59 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 689E1803DF
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:29:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3a7d7c1b190so3635245ab.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734632995; x=1735237795; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mFlySH6dQLmkhS7MCXkBfCUPcnXvP3Ypqo0yQSQPMJk=;
 b=abIigF2rpEPj1+7SeSb4e3lRMUu+5DodjWXwZN/rEmW5ta+yG0ibprZmYWJuRcGjh5
 WeRJX7+ShfGj/M5iTCUuRxpL8R7t5LcAZEQAV9WLTTom7AcZmr5mlf5o91XFdES5oSxn
 1L0zThPiCqebiBhNOIQp+RHp1OK7rk+jbFmus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734632995; x=1735237795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mFlySH6dQLmkhS7MCXkBfCUPcnXvP3Ypqo0yQSQPMJk=;
 b=UFaU8q/TQu9nXCqhmI9dhLrEChm1phZkCd5aNvX8iPeMA9Vhk4GQ/Wakcny+UpQ2eB
 syNJxZqzwydLQ5OGkq9FmPXuIiPSfNq03eFuXbyfBJcrQFJh1ALblREsK3yHCpEZZsz+
 mGTIuMLKJ0NlPYzckCwzlJrlhQVBjwi3dZuVCWvbu2/c5JVbU5AyYrJbTvlQgLzGSdlo
 D3tg06DDZ2shay4zBb8OmKM1YoahEDImERbjkath+yXv9yLQ5dTXvvUtkYPz1GT02ALJ
 7iy9tqsxUeEBUNkc4yGSYaj8zXB61zZtIMTH85s9RJE1KkrdK4XupuCJFuznC+Ue6Wdl
 RASQ==
X-Gm-Message-State: AOJu0Yx+BbpnGUE8Z18E041C0kijxx33nIYPqXNyUGRU5D1ZSeeZu4L4
 Ua3edoQVy27ZHcRrjuJMZ7ha19Yxm4WCCYtfVck8qOWJsM1qtwTbGCRKDuCL0jvok7lViRftkPw
 =
X-Gm-Gg: ASbGncum/pQziOGR5V5V4uO5pW53TnsdSo0mSNnSQC8vjVZSpSfiJMhAM6WYUDKrEol
 5uGedZdg/YOXnBWdcKDBGF+T6jtXn3MTNYACUyj6ZgIocVTI5W/6bRb+reswcSE+ah9CJDFyL4+
 6XVIiuL+GJG0sQiM94I1a1Ybtz3SSdy66evMUF8OD1tnxF98v5lTP+LvGDK7Qjk7XwZvfN1+G24
 6c5UvyuV4T2SWeu2xxhVQwbk5aZjBI8FoPdIeoMl1R7hL4Jpcw3A2MRJW9M7t80F4zzTg2tDmAL
 EBjpIbWmhLuMU4ls1Q==
X-Google-Smtp-Source: AGHT+IE0X+GQUToIUEwOdLYlFCNzKnYqCdASXdx5uzFstafqVtQNtwdWtPa8kYHVrsYaXEMDb3E3DQ==
X-Received: by 2002:a05:6e02:1a6f:b0:3a7:d672:652d with SMTP id
 e9e14a558f8ab-3c2d4c834camr952305ab.16.1734632995293; 
 Thu, 19 Dec 2024 10:29:55 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68bf676c6sm393655173.50.2024.12.19.10.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:29:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Alex Shumsky <alexthreed@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Joshua Watt <jpewhacker@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 19/19] hash: Plumb crc8 into the hash functions
Date: Thu, 19 Dec 2024 11:29:07 -0700
Message-Id: <20241219182907.2609704-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219182907.2609704-1-sjg@chromium.org>
References: <20241219182907.2609704-1-sjg@chromium.org>
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

Add an entry for crc8, with watchdog handling.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
---

Changes in v4:
- Add an option to avoid code bloat with rcar3_salvator-x for example

Changes in v3:
- Rebase to master

Changes in v2:
- Drop patch 'serial: ns16550: Allow clocks to be missing'

 common/Kconfig       | 8 ++++++++
 common/hash.c        | 8 ++++++++
 include/u-boot/crc.h | 3 +++
 lib/crc8.c           | 6 ++++++
 4 files changed, 25 insertions(+)

diff --git a/common/Kconfig b/common/Kconfig
index e8d89bf6eb9..0e8c44f3f74 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -845,6 +845,14 @@ config HASH
 	  and the algorithms it supports are defined in common/hash.c. See
 	  also CMD_HASH for command-line access.
 
+config HASH_CRC8
+	bool "Make crc8 available via the hash API"
+	depends on HASH && CRC8
+	help
+	  Most times, the crc8() function is called directly. To make it also
+	  available via the hash API, e.g. in hash_block(), enable this
+	  option.
+
 config AVB_VERIFY
 	bool "Build Android Verified Boot operations"
 	depends on LIBAVB
diff --git a/common/hash.c b/common/hash.c
index db6925d6782..8dd9da85768 100644
--- a/common/hash.c
+++ b/common/hash.c
@@ -304,6 +304,14 @@ static struct hash_algo hash_algo[] = {
 		.hash_update	= hash_update_crc16_ccitt,
 		.hash_finish	= hash_finish_crc16_ccitt,
 	},
+#if CONFIG_IS_ENABLED(CRC8) && IS_ENABLED(CONFIG_HASH_CRC8)
+	{
+		.name		= "crc8",
+		.digest_size	= 1,
+		.chunk_size	= CHUNKSZ_CRC32,
+		.hash_func_ws	= crc8_wd_buf,
+	},
+#endif
 #if CONFIG_IS_ENABLED(CRC32)
 	{
 		.name		= "crc32",
diff --git a/include/u-boot/crc.h b/include/u-boot/crc.h
index 5174bd7ac41..b2badaf6a97 100644
--- a/include/u-boot/crc.h
+++ b/include/u-boot/crc.h
@@ -25,6 +25,9 @@
  */
 unsigned int crc8(unsigned int crc_start, const unsigned char *vptr, int len);
 
+void crc8_wd_buf(const unsigned char *input, unsigned int len,
+		 unsigned char output[1], unsigned int chunk_sz);
+
 /* lib/crc16.c - 16 bit CRC with polynomial x^16 + x^15 + x^2 + 1 */
 uint16_t crc16(uint16_t crc, const unsigned char *buffer, size_t len);
 
diff --git a/lib/crc8.c b/lib/crc8.c
index 20d46d16147..811e19917b4 100644
--- a/lib/crc8.c
+++ b/lib/crc8.c
@@ -32,3 +32,9 @@ unsigned int crc8(unsigned int crc, const unsigned char *vptr, int len)
 
 	return crc;
 }
+
+void crc8_wd_buf(const unsigned char *input, unsigned int len,
+		 unsigned char output[1], unsigned int chunk_sz)
+{
+	*output = crc8(0, input, len);
+}
-- 
2.34.1

