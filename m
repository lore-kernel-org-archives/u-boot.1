Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0729D44D77
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 14:14:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADF2F891E9;
	Wed,  6 Nov 2024 15:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cWTryvzT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C31D891D2; Wed,  6 Nov 2024 14:03:30 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50686891BC
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 14:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21116b187c4so48005615ad.3
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 05:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730898207; x=1731503007; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nTcq1xsSMSqUo9ODZN+EvP0e3Vg3LWs2Mru9xD3rYU0=;
 b=cWTryvzTzBpG2PiZZLOmMoA6gGbs0UVTkCI2QW2rnrVBGJeydQb6cbIPlI0ozn7Mch
 jdYvuV512dOyjqBEFKeGQjDAKG8qImEQAycui97AJFTckS5L0n/hiu7IY02js9V54s4Z
 eNloys6xjsri5PS4XYOx8i5PeB7x28o0de/jqzzJb0lHe7C1bzjid/71tYvlMV4KmJus
 FgW/YEr/92/XzMd+25qdwkKT5QSzSH729XQitjJZexgN54ZPxpGO9k95EYgu47E7HxFO
 3sE0mijKORVXE4IQbrI3kT7lT/907WxC+LPVRvjmkn2Kj0o5jakqBqDBuAay+/Scl/mG
 KdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730898207; x=1731503007;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nTcq1xsSMSqUo9ODZN+EvP0e3Vg3LWs2Mru9xD3rYU0=;
 b=Hy6ROpl7S9xRNkzwSFxEKPki+6TC+ivykwlDmgZVklkxbpsio+VLUB2OTHOUJHzicR
 bYP8DjxLNwBJ+5gdJURbr9jJDySY47CUCRDuVF3XaMNbQGYeiTNUlutEh0wqxfvHk9q3
 jxmc+MAiLFcc1FlquFCzvebxAW9d9sDLVZ+NRbSxCChnh/9cxjPFRtIaQcpImjAVnE7k
 kb+QsRyQWuzpFzSx51RnomUF+1rmPtgQcydkAFQaU5WhRJEeZOort4GtNS9HuQuU8C1z
 ggzd/RbbMoJ+E6qBWiyrOTi9ZfWZgOkS8JhdhP5ZvhZ4bK86ukNZGb/dgiN1H0g1+ePT
 esZQ==
X-Gm-Message-State: AOJu0YwaKPQ+8nCvoMR+7/AirTAyAkNzBz2MBYcIVO1vjelaQE+49iRF
 R5yz0sV3eyNIuJDB6LtyUpvsnTKqKysfj/dUKMo/q+J2Qon/J5pJQ7OXyU/xwYE=
X-Google-Smtp-Source: AGHT+IGaiaITR2X5ZWA3PdVGEROn+P5FPwBbeK8kzHu2TGR1fLpoF3Px/b+DEOzSkfM6HxzHyJFK4w==
X-Received: by 2002:a17:902:ce85:b0:20c:a1a3:5373 with SMTP id
 d9443c01a7336-2111b01c640mr277755555ad.55.1730898206580; 
 Wed, 06 Nov 2024 05:03:26 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a62bfb6sm1411296a91.43.2024.11.06.05.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 05:03:26 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 2/7] net: wget: add definition of struct wget_http_info
Date: Wed,  6 Nov 2024 10:03:18 -0300
Message-ID: <20241106130318.211072-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 06 Nov 2024 15:13:43 +0100
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

The struct wget_http_info exposes the HTTP information of the last HTTP
request issued by wget, and it controls whether the efi bootdevice is set,
and whether the buffer size needs to be checked (lwip stack only). This
information is otherwise discarded. The wget_http_info struct can be used
by HTTP drivers to have more control over HTTP requests.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 include/net-common.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/net-common.h b/include/net-common.h
index fd7c5e7b48..38ba95cf60 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -8,6 +8,7 @@
 #include <env.h>
 #include <hexdump.h>
 #include <linux/if_ether.h>
+#include <linux/sizes.h>
 #include <linux/types.h>
 #include <rand.h>
 #include <time.h>
@@ -506,4 +507,30 @@ int wget_with_dns(ulong dst_addr, char *uri);
 bool wget_validate_uri(char *uri);
 //int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
 
+enum wget_http_method {
+	WGET_HTTP_METHOD_GET,
+	WGET_HTTP_METHOD_POST,
+	WGET_HTTP_METHOD_PATCH,
+	WGET_HTTP_METHOD_OPTIONS,
+	WGET_HTTP_METHOD_CONNECT,
+	WGET_HTTP_METHOD_HEAD,
+	WGET_HTTP_METHOD_PUT,
+	WGET_HTTP_METHOD_DELETE,
+	WGET_HTTP_METHOD_TRACE,
+	WGET_HTTP_METHOD_MAX
+};
+
+#define MAX_HTTP_HEADERS_SIZE SZ_64K
+
+struct wget_http_info {
+	enum wget_http_method method;
+	ulong status_code;
+	ulong file_size;
+	ulong buffer_size;
+	bool set_bootdev;
+	bool check_buffer_size;
+	u32 hdr_cont_len;
+	char *headers;
+};
+
 #endif /* __NET_COMMON_H__ */
-- 
2.43.0

