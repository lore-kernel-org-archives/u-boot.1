Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6994CC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 121B480A4F;
	Wed, 22 Jan 2025 18:09:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KH6LhNPC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 639CE80A45; Wed, 22 Jan 2025 18:09:17 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 259D780977
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:09:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2167141dfa1so224925ad.1
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737565754; x=1738170554; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WAxpQ7BbnlYfz39n479+fz6ZI/hXxro6s0Iq0Oa4L1Q=;
 b=KH6LhNPCoMQNcTkDEomJz0DxWIov9VYsk5Zr9yd0tPqbnEfCFRsl8uxO3g/tUQJU7N
 e4Tx6a8w7Pr2H3tJaHuBYRFvBti/FaB/1zZLneq+1WdPMQGnnit7fs4SjzIKOVij7346
 KBAlcIyw4pHywYCsSzUZUSi3jbsSWTivvsiH0/g12Og3tmlAuoKsvrYRs7QkFcUo1YTZ
 0PL87Nl+lxm5YKTMOMIdQhxmgMtfYhmo8sg5T/ZWEeq8xIJIUjoLfO8woSycqVLXVGKl
 NUY2xrjCd/WOmtltjYoSQlAk8W5GDJACFSZSjq9GTvFiXdPSmqPsc5MY8Tu5IeRbjVjd
 DFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737565754; x=1738170554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WAxpQ7BbnlYfz39n479+fz6ZI/hXxro6s0Iq0Oa4L1Q=;
 b=wck1CULlYij7VHl4cy8H6ANr5RPMauPBkC+FFr75C8sUQpf1mRGJ9ukkYmk4WCA0RL
 mR6C27/UuqOMytLwTQ/AJ5fgSySGNwpXwSXYGyygTghLJqN9Dnr26+RInOZ7znEAWwWE
 8zhPpOxpq65DqRDE5aWKBlJ2AyfWBRa0BBR5wukzrVemogW7tWtntkd7Bc/YOsUkrRRj
 IL4ribvzk8I34GiqpOKvMmRs5rb4tC9euon8CY+IlttiGfy5lVi8PsUZ5twDMMAabRaW
 S6jDHKM8LZ3fLXl5z4wsd+XRXspQ1VrNJUaO600GGMxT0vz1aviyJYpiW3kGtdoEQ6k2
 jxOg==
X-Gm-Message-State: AOJu0Yy9DryY+7oHirsfDZge1GElS3bxU1gUUUNQ0SBv83o1wR9hDYg5
 W/NlfADmAz4oRO6ETLUf77+X3tCucE5w5vu4xZWpX+CSsfVBomsOHoPIyABU
X-Gm-Gg: ASbGnctKh5yA+NQEu9Yg2Y1BlW0Cf8cpvvr+wRACsOKyfKyLrwT1uvyBxVSxMQzqypu
 gUS44MJWv3Sk+HbmSxFtzky7cO1Hu/2xqrQ3mKaDTvEuAtxZX5+XogJFlyLZTXd0/OVBkTyuPlm
 FeVMfHlICsPWvKwCfMB3UEs/hHK0zrhqby9QHKmQo7PemPOrsVUC6Dyq8lzWAnJMpUfCXPAGavV
 5lBRwxDLgXLZcKTowONAqDA8IyG8gIirixehN5eGzmROUTDpk4P7OXPt5C0wLJWw4F8WsxhhprQ
 dA==
X-Google-Smtp-Source: AGHT+IGNbk3pcFHoUnY3pAgbm0bcmGiNl+O4zbrBCWRbH2xpysNfXUjatW7317mLtx7HMRjr2ENO0w==
X-Received: by 2002:a17:902:d492:b0:215:ae61:27ca with SMTP id
 d9443c01a7336-21d9938bba5mr350825ad.26.1737565753378; 
 Wed, 22 Jan 2025 09:09:13 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028cbsm98095225ad.227.2025.01.22.09.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:09:13 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 01/21] legacy-net: wget: fix wget_info handling after new tcp
 legacy stack
Date: Wed, 22 Jan 2025 14:08:38 -0300
Message-ID: <20250122170858.961359-2-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122170858.961359-1-adriano.cordova@canonical.com>
References: <20250122170858.961359-1-adriano.cordova@canonical.com>
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

Check wget_info->buffer_size for overflow and do not clean the
wget_info struct on failure, let the owner of the struct handle the error.
The latter is necessary, e.g., for when a request fails because the
provided buffer was too small.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 net/wget.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/wget.c b/net/wget.c
index 0b082c6194..f51cd342df 100644
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
+		if (wget_info->buffer_size && wget_info->buffer_size < wget_info->hdr_cont_len) {
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
2.43.0

