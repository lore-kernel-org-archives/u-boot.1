Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C35D41D46
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 02:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B61B8893B5;
	Tue, 12 Nov 2024 03:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N5LO5NNr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A5F189390; Mon, 11 Nov 2024 22:09:16 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26E1289308
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 22:09:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20ca388d242so50032805ad.2
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731359353; x=1731964153; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qmGkMdqzulSjuW4hC8wyrnhuag8BeWgA1BOlcFI+SZ8=;
 b=N5LO5NNrDBQaBiZhNh2WTEfefgcmSzB+KxdJQXQUMiKP3cqw7q38/JDuFhjH4OvGZL
 8HOrQ2+aAw+m4uNiFe8WEHHj/+U3keRUYka9Tl03ULDJdPr1BryZxKTrRy7aHujAn+BT
 9JUMQgXkV1rBRRI0G0WaK68IVe/fsaw9wO6sfSmwZ12484gTmzOjCutuV/hRZaiNyUGi
 6+bKGOjbRgjTFvsCiA6he5vlTgCPSre9SIcWYPzt72lPfZ+cDN4CR6u0Oh0R6d1lchI9
 T0liWdTrGbWRsa5mOb80djkmJNk4MizZEpulXqiDvtoZfDwQbhP2woB1XF/AGRxwMrbp
 Hr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731359353; x=1731964153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qmGkMdqzulSjuW4hC8wyrnhuag8BeWgA1BOlcFI+SZ8=;
 b=KoU7KfcU2xrrNFok0TafDJOSAvX5/FEjOGTIw+CFAYh1qkbcJTWRDHDge1k0pB6xFb
 W+6eyHRgGBaAcsh419e3JX0sx82iYb99kAWWPlDekumWfu9ZWlFAdYrD57CkCRUmuSDX
 Ouj8mv9RDZ6wUCfacmGfkOwIRZI5ex1cKU2FftcUaFvzQBD0Hsak9kAWPTcPvzkB+Zar
 H9Qn7oBBCjsZ9PenDCmsmnwt7b6guHxRYgRe0CeXJMYN0pAslx+KesIHCco0MNxHtsGb
 IODSp5yHxHe4bOCu/ioxaChEpRnHStBxmMnjZLqexLQqgvyl656HwXkxaWkOeUM9Ql3s
 GSTg==
X-Gm-Message-State: AOJu0YwmegLtOu9gb1Q13Zw2EAWHPNWsNupms//C0NlRZm0krXEBPay9
 4RP+QyMcboujJnT8xW5kRbvAbkDNj7IxqJiw2X9i2BuMorPek3GOcmLjJkQu
X-Google-Smtp-Source: AGHT+IFo5WWtMe6wEsIhOW8r4QmAdVj8mcc0zVFbDuHko4kwOjG71ssmkF74HpWPByZwopyGMwN39g==
X-Received: by 2002:a17:902:d50d:b0:20c:9ec9:9a77 with SMTP id
 d9443c01a7336-21183e11f41mr174391635ad.37.1731359352557; 
 Mon, 11 Nov 2024 13:09:12 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc9068sm79807415ad.2.2024.11.11.13.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 13:09:12 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2 3/7] net: wget: Add interface to issue wget_requests using
 wget_http_info
Date: Mon, 11 Nov 2024 18:08:57 -0300
Message-ID: <20241111210901.560691-4-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241111210901.560691-1-adrianox@gmail.com>
References: <20241111210901.560691-1-adrianox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 Nov 2024 03:47:02 +0100
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

Declare and define a global default struct wget_http_info
and an interface to issue wget requests providing a custom
struct wget_http_info. This code is common to legacy wget
and lwip wget. The idea is that the command wget should use
the default wget_http_info and other internal u-boot code
can call wget_request with their own wget_http_info struct.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---

Changes in v2:
- Instead of having a single global wget_http_info struct, let
  the user of wget (e.g. the efi code) provide an instance of
  wget_http_info to wget with the desired parameters. This lets
  the user cache the wget paramenters in their wget_http_info
  struct as desired (e.g. the content length from a HEAD request
  to a subsequent GET request, see the next efi patch). 
  If none is provided, wget uses default_wget_info.
- Add wget_request to trigger a wget request with a custom
  wget_http_info struct.

 include/net-common.h |  4 ++++
 net/net-common.c     | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/net-common.h b/include/net-common.h
index 8985b81c2d..1efb0db9ff 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -554,4 +554,8 @@ struct wget_http_info {
 	char *headers;
 };
 
+extern struct wget_http_info default_wget_info;
+extern struct wget_http_info *wget_info;
+int wget_request(ulong dst_addr, char *uri, struct wget_http_info *info);
+
 #endif /* __NET_COMMON_H__ */
diff --git a/net/net-common.c b/net/net-common.c
index a7f767d5e9..45288fe5f8 100644
--- a/net/net-common.c
+++ b/net/net-common.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <net-common.h>
 
 void copy_filename(char *dst, const char *src, int size)
 {
@@ -11,3 +12,16 @@ void copy_filename(char *dst, const char *src, int size)
 		*dst++ = *src++;
 	*dst = '\0';
 }
+
+struct wget_http_info default_wget_info = {
+	.method = WGET_HTTP_METHOD_GET,
+	.set_bootdev = true,
+};
+
+struct wget_http_info *wget_info;
+
+int wget_request(ulong dst_addr, char *uri, struct wget_http_info *info)
+{
+	wget_info = info ? info : &default_wget_info;
+	return wget_with_dns(dst_addr, uri);
+}
-- 
2.43.0

