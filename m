Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DE2C282CD
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 14:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 445B1811B2;
	Mon,  3 Mar 2025 15:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jM3mXDjZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A900C811DF; Mon,  3 Mar 2025 15:13:26 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E44580C93
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 15:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2235908a30aso62964505ad.3
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 06:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741011203; x=1741616003; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NLgHJYKsbxZZXIlzPsQeJpF5/NLkauuuq6JJp/O8t24=;
 b=jM3mXDjZJdxwNOa7qAzkvNC0kdE2T18OPeJwXzomZeRNH7K06Uw7L0DYirdiYtutOF
 3H4LnVw7O0QCQ5F66A8BiXTw0H/xYuRcqeqsn+z2Ht2ti+WeXoHEPcbF2dP+SgbelezG
 spUJDu9s7a7Xdsj3IyLUyEa9rBAYfiRpzoRl+c7jy0Yvp4q6SbmmKoqc5R8OMuIvEkja
 XWwydi3xEgmWrkSE4pPZnbKhD4nYBtTjcZGNSW50reoamChcEdJhqIycwZG+tkMzfVs/
 vD3JKZPUL3sert3bLjEZK4mclFwH5OCy//G0WzkGMkRuTjfDJ4vaImBklvm4UUiZNnPL
 HMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741011203; x=1741616003;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NLgHJYKsbxZZXIlzPsQeJpF5/NLkauuuq6JJp/O8t24=;
 b=KaSI9CpAOSFTUJk01J5MqIUpzC1ICc3dT8TGApxrxSDmjGPpHl0R+xA88Wa1KPjrzA
 vIYZ4ohvdMdffAoWSj92/S5DMwgihwTfAuV/zSYXUxTinWZTIS24bcl9T/ZWqyb2dfYW
 aQ53dTXDr3Ba7us7ps2x2QBO1dWrju1k+f1yFVrAFzthaeuFAPSoPapr8cyTaT4bVOHG
 1TygBvubgN/A3zYKrKP1H20cBaW58Zw7pvgCXuc8P4XX2ONhkYoTmbe8oK/unlNZ0JDu
 RdFt8wfjrofhduwwtYWVbxnF9dyi3R03FjzPOV+WTxiWIEPgWrPbm2l7O6mA/FsbsnkT
 RhoA==
X-Gm-Message-State: AOJu0YxuVBr2gp5X/Pcud84zGqC2B3qLs1dE8FA2b/m8oYCAMrhELby3
 9FpODz359uaZDPCWFHHKAVyqwSF44zqCwmp0g3Nxr+CaiLzTgeblYcUm/7keheo=
X-Gm-Gg: ASbGncsOcvJo7XpSFZLb98ThBlFXLJN0abqlAH+iftw8agVSVpU8Z+clgpZoSQrRTx9
 DleJbTIwHqhz1nkQ3BAZTOJAf4O/oAMDmpzbWfneTcjFrWdEhKDctRc7EwExPqeYytC5ilxc80O
 +W0hUYzwkhJ70N46MH+ZVKWFCwznQ53NiWsS9wcNij2Ii9dQ2CmNpZrQVEX4h6iuH/GQXYRJIvL
 3Ocgn+wxnUP6UwHPceKGmqIavqQjiCLQu93sr4Foim8HOumCWbvK7Aj7fJa4QFGL4D8evt9czlH
 cwpIHmgCOHqi8I7V9+EqvcTdzEXjtpnVQHo7kVJiTD9tTkD47KZl+kg=
X-Google-Smtp-Source: AGHT+IE0fwmD2V/kw9cKwLFFkQMbVhUlLmqULTpLhbJID3vy6tow/WqxEwTX4xmwD7gzFoAk6AVuqQ==
X-Received: by 2002:a17:903:33cc:b0:223:5a6e:b16 with SMTP id
 d9443c01a7336-22368f60ac5mr187349865ad.5.1741011202595; 
 Mon, 03 Mar 2025 06:13:22 -0800 (PST)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501faa33sm77875265ad.66.2025.03.03.06.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 06:13:22 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 1/8] legacy-net: wget: fix wget_info handling after new tcp
 legacy stack
Date: Mon,  3 Mar 2025 11:13:10 -0300
Message-ID: <20250303141317.265098-1-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.47.1
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

(no changes since v1)

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
2.47.1

