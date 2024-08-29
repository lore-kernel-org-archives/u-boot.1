Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04B4C83F2D
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AE0A88CCB;
	Thu, 29 Aug 2024 16:58:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jbKiWLDV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81FEB88C44; Thu, 29 Aug 2024 16:58:37 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA2F188C9C
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-39d30564949so2750685ab.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943512; x=1725548312; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z0qUbpteAyA1vbeFCITLlL6Vvc8C3sWCWgjlMOTA6kc=;
 b=jbKiWLDVViSaDE/u0IU6J8WgJPrLEfFe3UAwQrf2xlWPm25OlVNyzOEcrqRGez8z5u
 GoaF8I95Sm4rE9GwaR2NKkCXM4V9/qHWeRtOkpwwYc2pneFb4/oF726djdurxUuKtF5z
 t8+EdxuNndU7UEgUBnyNu4nsvJQ/2T+Zl/UL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943512; x=1725548312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z0qUbpteAyA1vbeFCITLlL6Vvc8C3sWCWgjlMOTA6kc=;
 b=EJYOhbbN5KjFlJc/yStgvVJe1JONRgjxfvbJ1FvZ0JCFrg7pWCiZt3sklgO7bCmaqa
 f2IpDbX6TL5/8cIIctLtQV9rJJe//oSoUcVsNWOdVBQ/+ZgdZGx/tuFiG8y7UCGwMtAP
 d4V1hmoMKXHzG6XMQVpJMLHOk2BNOHKnPqlK0pB6iIa1IZ86zrNGcPRsIidHUBUyStWS
 JhtRC5WdynXGqwuWfl7E8FL1ivNb1QYfhi16qVwk+bnz9nu3ijF4zQXExfZyASTiKFSn
 O9JOaLKE3DWjFLLc3YTMFzOad4qsLUD9OaLWSbyoQchKbe4LQtrSirCnE44W36zzWLUQ
 KP4Q==
X-Gm-Message-State: AOJu0Ywv6sIZeeuaMvAZafHzW9E7J3CX/fdq7AKkLu/ywUJOAyFfDca1
 ey+pGnW28VuDS4ge+8uAx/+8Ubs+kveEgUH1LtybUB28uaJdn/K5XKcPI7laJAzhxhG6PswGjyM
 =
X-Google-Smtp-Source: AGHT+IHsTVm+7co+H61tzAPJ2VXEvzGI6kzL31TkH8nUcCei/tusNC8qxBuvuUW/K7wMUntpGDBVqg==
X-Received: by 2002:a05:6e02:148c:b0:39a:eb81:ff9a with SMTP id
 e9e14a558f8ab-39f377f52a1mr39797765ab.10.1724943512567; 
 Thu, 29 Aug 2024 07:58:32 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2dcdd2bsm284900173.21.2024.08.29.07.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:58:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 19/19] hash: Plumb crc8 into the hash functions
Date: Thu, 29 Aug 2024 08:58:02 -0600
Message-Id: <20240829145802.1827952-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829145802.1827952-1-sjg@chromium.org>
References: <20240829145802.1827952-1-sjg@chromium.org>
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
2.34.1

