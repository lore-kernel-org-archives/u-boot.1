Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5561CCF58E7
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B78D89466;
	Fri, 20 Sep 2024 10:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DdhknYP0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EC208945A; Fri, 20 Sep 2024 10:13:52 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24A5D89452
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:13:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-536a2759f0eso2317639e87.3
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726820029; x=1727424829; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OcOfvCyO/5N3kjPO2omuLXBUuqkVueXoyg9VgaloaBE=;
 b=DdhknYP0hL3Iak/eXNavH/dhGuP7s1FuUHIprHwtQf+Roi4Ewi9NduQNzQmTpnXOaw
 QH0toaSAj4JKLzqE1nrqfgAbPHIFgC+nKLF231fxsXQq2nILnm4TB6urtDxiSwxLy+72
 KpMuNG12dpFlHPJ57c07eL2w9QFkr8BNZ1SOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726820029; x=1727424829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OcOfvCyO/5N3kjPO2omuLXBUuqkVueXoyg9VgaloaBE=;
 b=sBZbPu1AHbIbxmcazhoaC9ERGYwEEef2UJ4gFMMyKi1kZ++bg2p9nvXqmo2aSwevcC
 OLHf7EylbhXo9dBEQE3/MGsykgOh7IZo67QAyGHZUncLyHt2mpSg8MY2PAIBUDOqSVJ4
 WZrNw2v2dvesEe7stS92hMd6xv1/NjneY8j4WD/HJBJ9ObdTDm/VAyBYBMTkzed0ClZ9
 LC7R4NsGEg7kmd/q+jrCtCmhzm8YIrCowtjWovdyBPF7uSTy3yFk6VEtTDE9Rz/eOvha
 9pM0O6UN8ak1NI+ayQbOnrIr7xD6acwspi+C8j14caKWQVI3hv1h0WefShvn+/D7EcrT
 p3ZQ==
X-Gm-Message-State: AOJu0Yz0/qKQ9lV1t7y2Y5KiDTmoXTb65/OtmGD0OTBGqT1gor/RP3Js
 y2Qv85UNNj8ozh7/YwbxHeVpsDCLfm413X3LMYXk3yefJr2Ml3vgr2E0OfJP+llDWw3wjmZhJlA
 0e4Ha
X-Google-Smtp-Source: AGHT+IEj8cX5pb6yTj0NFgznZPLAFbntYwVHDPpAhjsiO13K6bglb5suFJ5dGLJmSF495ElS3aQzMw==
X-Received: by 2002:a05:6512:12c2:b0:52e:f99e:5dd1 with SMTP id
 2adb3069b0e04-536ad3c9abfmr747069e87.47.1726820029111; 
 Fri, 20 Sep 2024 01:13:49 -0700 (PDT)
Received: from chromium.org ([83.68.141.146]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bc88cf7sm6804447a12.90.2024.09.20.01.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:13:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 18/18] hash: Plumb crc8 into the hash functions
Date: Fri, 20 Sep 2024 10:12:57 +0200
Message-ID: <20240920081309.140426-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920081309.140426-1-sjg@chromium.org>
References: <20240920081309.140426-1-sjg@chromium.org>
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

Changes in v2:
- Drop patch 'serial: ns16550: Allow clocks to be missing'

 common/hash.c        | 8 ++++++++
 include/u-boot/crc.h | 3 +++
 lib/crc8.c           | 6 ++++++
 3 files changed, 17 insertions(+)

diff --git a/common/hash.c b/common/hash.c
index ac63803fed9..43c4e185750 100644
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
2.43.0

