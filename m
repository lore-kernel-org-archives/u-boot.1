Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C560DE7717B
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 17:28:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D43DD895A1;
	Sat,  7 Dec 2024 18:26:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bVCTKFi4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC146895E4; Sat,  7 Dec 2024 18:26:54 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88A5A895B7
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 18:26:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-843671e1426so121092339f.0
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 09:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733592411; x=1734197211; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ulv0stjlP+4cbSGnOAIl/yn91i+xBY3qRSNdA9wamiI=;
 b=bVCTKFi4tWTS/Bt8K2kU3pEnnyxux6u+AQiLpAf725hvpNhTHLnNV6efCdvhbdx7oF
 mkn1JVKNhsSBdGlMP8RZCy8fjOkW0y9roiV/mQfqJkLTOys9/moSUao/dbFLHqyK4paz
 CIPVgFI9KXbACZAld3pm+jyvQ6O8ZDqBwKOSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733592411; x=1734197211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ulv0stjlP+4cbSGnOAIl/yn91i+xBY3qRSNdA9wamiI=;
 b=BALUmGBCbQuWtePYTDuQz8ovH21qZ8CXf7olR9PATFAOlxa73YCeOmERTBb76MKrHW
 rdCINQaq6Fve/HRq9XAZKXA3uWDyjf3AEwEtBH7bNgLcM5u047zXTRfYY7Hocmyems1X
 gfVxknFgbZu98L3dneSpZ52/gPlYZ5rUUnp6D6b84EIwutM+ate+TXV/GixiS0NWUFHd
 zgyzpaBKetJWQjxVi9D6WU7D1P2Lr6r7QrH6NLEIi4V5vZsiogCBAUfqXPxXPn/eIMkv
 I2Jx60bEjTMamMYbRrrtJ+oKCZub/b3Lcer+YjIWZw8skweIPRvc0bv6NiGLl5Ncbuyx
 ZYDA==
X-Gm-Message-State: AOJu0Yyr12N0UpV/OwFOSTbXGYB8ahhqT4Jiww9WqucfrUOkq+xxLYb+
 BI5bcHAYn/N+B3bGOWE9Xi8dLRfWeOKT74AQAauOoy9k3GAuC0hEf1QJE07Pzhtq4a8Psr31ZXY
 =
X-Gm-Gg: ASbGnctOqpKatC6OTWMAus1xsRxOA1CtQ29vsUoEg6Lrv3i3aJV63NXSL/zNO60OG4C
 +3yDs6pB1xx8fiA+jTqmuHUJxJfkEi5GOTREUiIdBuKTOu/cIhRboOGY4X6SQggzdCSricyotfZ
 2fW2daPzeUFJcCy5IcI9IHBgwJv/7lAqV1ZpKFY2y3R+XR+jWiLltapSC+/tYqIlS+TfbGL2KMx
 3z+T4lhZeoivbd1Ayi8FjsdZeviUKQe+RuAgt1giC5RuPFrg5sCV/bxHj/oPzMkeZ/wo62jUiKw
 OTAHtIO+Oj0=
X-Google-Smtp-Source: AGHT+IGAwB4if4TA39HyWqQKQaB4m5w2e0eQLh+1JyIUmu6p3AA+UZazjXs5/RxMWzTIpwjGMz9EfA==
X-Received: by 2002:a05:6602:2cc5:b0:837:7d54:acf1 with SMTP id
 ca18e2360f4ac-8447e200ademr899665539f.2.1733592410826; 
 Sat, 07 Dec 2024 09:26:50 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a7080csm171745739f.45.2024.12.07.09.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 09:26:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 19/19] hash: Plumb crc8 into the hash functions
Date: Sat,  7 Dec 2024 10:24:12 -0700
Message-Id: <20241207172412.1124558-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241207172412.1124558-1-sjg@chromium.org>
References: <20241207172412.1124558-1-sjg@chromium.org>
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
---

Changes in v3:
- Rebase to master

Changes in v2:
- Drop patch 'serial: ns16550: Allow clocks to be missing'

 common/hash.c        | 8 ++++++++
 include/u-boot/crc.h | 3 +++
 lib/crc8.c           | 6 ++++++
 3 files changed, 17 insertions(+)

diff --git a/common/hash.c b/common/hash.c
index db6925d6782..5d389420eff 100644
--- a/common/hash.c
+++ b/common/hash.c
@@ -304,6 +304,14 @@ static struct hash_algo hash_algo[] = {
 		.hash_update	= hash_update_crc16_ccitt,
 		.hash_finish	= hash_finish_crc16_ccitt,
 	},
+#if CONFIG_IS_ENABLED(CRC8)
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

