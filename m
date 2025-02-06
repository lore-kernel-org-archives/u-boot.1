Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EECC02199
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 17:40:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D05F080C77;
	Thu,  6 Feb 2025 18:40:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iV5y06La";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DEE780BA8; Thu,  6 Feb 2025 18:40:35 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBD2080BAB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 18:40:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21f49837d36so6580075ad.3
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 09:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738863631; x=1739468431; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/v5giVV226X4Qr07jZU2J9rD+v/J6GXnqx+au/I0xPU=;
 b=iV5y06Laz9Q9eDn7/sDPmKM/FCk8SrwYtMi76b0DR348zzfyIkmtUTxVjGs83IQJx+
 kGpq2u7fPqVw1+LrDrNen+S2BSeKUm8vszYtCD8NNifdXVmkJ+ph62NSfwYEs91IfGQZ
 stP87ECZGZhklXdiEQqshMsLVXAF6OKsvaw00zmc7yjAxwLKbxTg24SS46Z4iOjiZFgw
 tF8ZOifspbcC+qsSCFDq2+lmp7bxycnN9/FtYyDsZ9RudVQ3enfzcQ8ceMfELHSdPQfY
 YPOg76yWz9qfaNWurcg7iJz2AebugW6O6RUEStZjvzOz+uXlP/gjv06Y3ZlgnQl0lh6p
 s+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738863631; x=1739468431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/v5giVV226X4Qr07jZU2J9rD+v/J6GXnqx+au/I0xPU=;
 b=qkXkrLTyM0uJTiZnEU8pUzE3AmwxsfJfZPPgkD5Czjyqf5TnjC351Tk8Nwwt+FZktu
 zBGB7gO1bFu3ydhOATpFH7xxFYWRyVUvTKbMEokkbPS3ot6LRH72tegewgybnKPu3+D7
 EFAZOcPXOErcxFjBRfN878YgX7DRT1mw5BURa66SLMuGUTMYf+51oTlAzT9CeFjQON8V
 GRUyJe3VQNbR3rIEvTPi4j0rrkeDzITI0dIir8NYt2obGdZHFZwAo01p1r2CatVQDY/t
 +9tE1wtNcDgiipvZ8tRGeOWGIznr3Fh74zKsiIaUgbqPvPJNVRpf+G9zCeh25bAs+Wie
 YeJg==
X-Gm-Message-State: AOJu0YxjgJzksxJUX29ZRUD0DDpbUgI6VOCnbsX1nwjjbp3ohV5FbabE
 maDHFGmnU0DYdX87du5+R9KPHoXz4u0xHE+kw1YOpg2QVcLwKik4c48ILjaI8jJ//g==
X-Gm-Gg: ASbGnctYeZpWYO4ldMgxlc6OLePAWKwN3Ed/W3hyAL0DFP5Aj0zXBaxw7I/7mCL56u9
 RGpLgHgljNyRdIPlo6OQuq6JVJME8JZnjH+MDsNX0+IxRlvch6k+gPzLywup51IYwakmabGK+Ze
 POroo9l96H2y4ArSdkPEq2pxmDw8Vlt2LbUb7N/LkyR35Uzp1aQdwyyF28744oIAje529ppLaKL
 m3heN04WxpuAfH7ylsp5pdY7IBxeNfNC/6fb+mVXekSxI/iaCQX4QZO5q9GQAavFF8q9FKhzlEU
 RJD6omQAasjuz945611l0NiG
X-Google-Smtp-Source: AGHT+IGGC1ef1W0zC7pz1QqW6etwcvHWv6Nu4oPraaB9v0s+P/v27ikRck/XVuNtZ1teyDAVPkLEBA==
X-Received: by 2002:a17:902:e5c4:b0:21f:3a7b:f4e7 with SMTP id
 d9443c01a7336-21f3a7bf807mr48200435ad.43.1738863631184; 
 Thu, 06 Feb 2025 09:40:31 -0800 (PST)
Received: from adriano.. ([191.119.55.28]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3687c31asm15476615ad.167.2025.02.06.09.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 09:40:30 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 1/8] legacy-net: wget: fix wget_info handling after new tcp
 legacy stack
Date: Thu,  6 Feb 2025 14:40:11 -0300
Message-ID: <20250206174018.465530-2-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206174018.465530-1-adriano.cordova@canonical.com>
References: <20250206174018.465530-1-adriano.cordova@canonical.com>
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

Check wget_info->buffer_size for overflow and do not clean the wget_info struct
on failure, let the owner of the struct handle the error. The latter is necesary
, e.g., for when a request fails because the provided buffer was too small.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 net/wget.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/wget.c b/net/wget.c
index 0b082c61947..c73836cbc9d 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -53,6 +53,9 @@ static inline int store_block(uchar *src, unsigned int offset, unsigned int len)
 	ulong store_addr = image_load_addr + offset;
 	uchar *ptr;
 
+	// Avoid overflow
+	if (wget_info->buffer_size && wget_info->buffer_size < offset + len)
+		return -1;
 	if (CONFIG_IS_ENABLED(LMB) && wget_info->set_bootdev) {
 		if (store_addr < image_load_addr ||
 		    lmb_read_check(store_addr, len)) {
@@ -98,12 +101,6 @@ static void tcp_stream_on_closed(struct tcp_stream *tcp)
 	net_set_state(wget_loop_state);
 	if (wget_loop_state != NETLOOP_SUCCESS) {
 		net_boot_file_size = 0;
-		if (wget_info->status_code == HTTP_STATUS_OK) {
-			wget_info->status_code = HTTP_STATUS_BAD;
-			wget_info->hdr_cont_len = 0;
-			if (wget_info->headers)
-				wget_info->headers[0] = 0;
-		}
 		printf("\nwget: Transfer Fail, TCP status - %d\n", tcp->status);
 		return;
 	}
@@ -212,6 +209,11 @@ static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
 			   "wget: Connected Len %lu\n",
 			   content_length);
 		wget_info->hdr_cont_len = content_length;
+		if (wget_info->buffer_size && wget_info->buffer_size < wget_info->hdr_cont_len){
+			tcp_stream_reset(tcp);
+			goto end;
+		}
+
 	}
 
 	net_boot_file_size = rx_bytes - http_hdr_size;
@@ -227,7 +229,9 @@ static int tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf, int len
 	if ((max_rx_pos == (u32)(-1)) || (max_rx_pos < rx_offs + len - 1))
 		max_rx_pos = rx_offs + len - 1;
 
-	store_block(buf, rx_offs - http_hdr_size, len);
+	// Avoid overflow
+	if (store_block(buf, rx_offs - http_hdr_size, len) < 0)
+		return -1;
 
 	return len;
 }
-- 
2.45.2

