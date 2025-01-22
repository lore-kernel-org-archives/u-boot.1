Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B4AC02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E28A380ADE;
	Wed, 22 Jan 2025 18:09:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AL5i+/tP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E899580BB1; Wed, 22 Jan 2025 18:09:35 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 936C680A09
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:09:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-216395e151bso398595ad.0
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737565772; x=1738170572; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DdhsDSS4BYjmWfQLYGfOeY0VkD+5cK30MrbqqAAWLOs=;
 b=AL5i+/tPaiAt0R/TTTvp+fGUXSCpTpsFi+pdNpVOa91MIq+QQr7Qo89bc1RFUHeyUO
 QthyZi2nMtylbSFOIaYxbX0S/W1j7w6yUIXoQ9tubNyioAFIlj0MZ+xUJECpAfocu4FB
 wQi1Yl8+GTe5R7fPZj9RovMaO+r9bcrLXCKG0lLjT1CaVEefWxXGYVekuod/ZzJYwE9S
 o50WYCk8+y+MbqOK/rL27zYVxnlmx+o4B402AtxFJQe9X//2UfbN3X4IUTzUtG13yyFR
 nJQEzke/FR6uziyo1ZO7J0o4azFIU0CVvr2JUM7P7L2MjaC7s1kIl2dy7d3nQ+MWU3lu
 FadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737565772; x=1738170572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DdhsDSS4BYjmWfQLYGfOeY0VkD+5cK30MrbqqAAWLOs=;
 b=Um4c5DKHmigtkiBbCXTjWomZzkniq6/EUzMhEKWnC6TdDGaXpJ8FEMe4Qs6iF4/435
 ws2vrvwMP36ti6FtsNpkwWU0EkFF5Yr1W7Z7jg2Wq5/Jl/fKLxSaI0J3r7caWtAnEsys
 aR1bry2X48uxKVY98m02OjiCIGb9mxz1tizJzh2aLGEERqr61r5Q6hquWdHPL0TvW1zK
 Zg80NDWwler0DYbGjQxJT/8p9X6aM42PTkwABw4inYrMiymRfxshHDHiZFqYMCZD5QWx
 8Cheks+TakwEykA6xU7OYo/AxYLJ8YIbx+T2RICWBKzpMh7Wh6eNkqnN1Qwdf2x+ZpdM
 JeoQ==
X-Gm-Message-State: AOJu0Yw+RTPQrnsunSnozm3o9aQ6xGUIQJ+XufgA/RMbgkTaWqE9Xi7X
 pXz85J8QVd/oiQDZ9F7dz2w1smi1ZCiIoViDUwHiHoZkLJYNB44we1jMvBTY
X-Gm-Gg: ASbGnctu4lQ8gHOr7G82ZvmYb7nFW/0FcH3/FvdSsObhVny/SnhXFyDzO4VfZHNFewh
 J8Rc3Ksf69dcc8GreC6ufaykjfOs87PuK+yqKaoA2flEQyIRhbL4nUCaFI9Uq6ouAtyHHQMvimv
 JN43kjGTrZvN508u6k2/JJboqJFjIl7i0nLeBhV9tQBUu1IKWX2K70+O0BC2zhu8Yz+U2KIz6ud
 N9CRcN4jirv2vxSVR9GTCl7S6FqzNaQ4poOUtBirxBaQE+SQkCfpda6Zp1m8/FKwroJDUpqj/k8
 vg==
X-Google-Smtp-Source: AGHT+IG3h0VcxnPGTXtfp7brqBgi8qoP37SaI267I0Yz+ycYSJ9jVPb+MlXrnXWbaAEGFxHraoep2w==
X-Received: by 2002:a17:903:2c5:b0:215:7287:67bb with SMTP id
 d9443c01a7336-21d99236461mr1215075ad.0.1737565772005; 
 Wed, 22 Jan 2025 09:09:32 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028cbsm98095225ad.227.2025.01.22.09.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:09:31 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 08/21] efi_loader: efi_net: Reuse efi_net_obj's
Date: Wed, 22 Jan 2025 14:08:45 -0300
Message-ID: <20250122170858.961359-9-adriano.cordova@canonical.com>
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

When an efi_net_obj gets unregistered, save it and try to recycle it

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_loader/efi_net.c | 81 +++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 20d2c3a5f6..6bae5a5cd7 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -1152,29 +1152,35 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
 	}
 
 	/* Allocate an aligned transmit buffer */
-	transmit_buffer = calloc(1, PKTSIZE_ALIGN + PKTALIGN);
-	if (!transmit_buffer)
-		goto out_of_resources;
-	transmit_buffer = (void *)ALIGN((uintptr_t)transmit_buffer, PKTALIGN);
-	netobj->transmit_buffer = transmit_buffer;
+	if (!netobj->transmit_buffer) {
+		transmit_buffer = calloc(1, PKTSIZE_ALIGN + PKTALIGN);
+		if (!transmit_buffer)
+			goto out_of_resources;
+		transmit_buffer = (void *)ALIGN((uintptr_t)transmit_buffer, PKTALIGN);
+		netobj->transmit_buffer = transmit_buffer;
+	}
 
 	/* Allocate a number of receive buffers */
-	receive_buffer = calloc(ETH_PACKETS_BATCH_RECV,
-				sizeof(*receive_buffer));
-	if (!receive_buffer)
-		goto out_of_resources;
-	for (i = 0; i < ETH_PACKETS_BATCH_RECV; i++) {
-		receive_buffer[i] = malloc(PKTSIZE_ALIGN);
-		if (!receive_buffer[i])
+	if (!netobj->receive_buffer) {
+		receive_buffer = calloc(ETH_PACKETS_BATCH_RECV,
+					sizeof(*receive_buffer));
+		if (!receive_buffer)
 			goto out_of_resources;
+		for (i = 0; i < ETH_PACKETS_BATCH_RECV; i++) {
+			receive_buffer[i] = malloc(PKTSIZE_ALIGN);
+			if (!receive_buffer[i])
+				goto out_of_resources;
+		}
+		netobj->receive_buffer = receive_buffer;
 	}
-	netobj->receive_buffer = receive_buffer;
 
-	receive_lengths = calloc(ETH_PACKETS_BATCH_RECV,
-				 sizeof(*receive_lengths));
-	if (!receive_lengths)
-		goto out_of_resources;
-	netobj->receive_lengths = receive_lengths;
+	if (!netobj->receive_lengths) {
+		receive_lengths = calloc(ETH_PACKETS_BATCH_RECV,
+					 sizeof(*receive_lengths));
+		if (!receive_lengths)
+			goto out_of_resources;
+		netobj->receive_lengths = receive_lengths;
+	}
 
 	/* Hook net up to the device list */
 	efi_add_handle(&netobj->header);
@@ -1291,12 +1297,6 @@ failure_to_add_protocol:
 	printf("ERROR: Failure to add protocol\n");
 	return -1;
 out_of_resources:
-	free(transmit_buffer);
-	if (receive_buffer)
-		for (i = 0; i < ETH_PACKETS_BATCH_RECV; i++)
-			free(receive_buffer[i]);
-	free(receive_buffer);
-	free(receive_lengths);
 	printf("ERROR: Out of memory\n");
 	return -1;
 }
@@ -1357,22 +1357,35 @@ int efi_net_register(void *ctx, struct event *event)
 
 	// Find a slot for this efi_net_obj
 	seq_num = -1;
+	// Try to recycle
 	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
-		if (!net_objs[i]) {
+		if (net_objs[i] && !net_objs[i]->dev) {
 			seq_num = i;
 			break;
 		}
 	}
+	if (seq_num < 0) {
+		for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+			if (!net_objs[i]) {
+				seq_num = i;
+				break;
+			}
+		}
+	}
 	if (seq_num < 0)
 		return -1;
 
-	netobj = calloc(1, sizeof(*netobj));
+	if (!net_objs[seq_num]) {
+		netobj = calloc(1, sizeof(*netobj));
+		net_objs[seq_num] = netobj;
+	} else {
+		netobj = net_objs[seq_num];
+	}
 	if (!netobj)
 		goto out_of_resources;
 
 	netobj->dev = dev;
 	netobj->efi_seq_num = seq_num;
-	net_objs[seq_num] = netobj;
 	printf("efi_net registered device number %d\n", netobj->efi_seq_num);
 	return 0;
 out_of_resources:
@@ -1419,17 +1432,10 @@ int efi_net_unregister(void *ctx, struct event *event)
 	if (!netobj)
 		return 0;
 
-	// Remove from the list
-	net_objs[i] = NULL;
+	// Mark as free in the list
+	netobj->dev = NULL;
 
 	if (efi_netobj_is_active(netobj)) {
-		free(netobj->transmit_buffer);
-		if (netobj->receive_buffer)
-			for (i = 0; i < ETH_PACKETS_BATCH_RECV; i++)
-				free(netobj->receive_buffer[i]);
-		free(netobj->receive_buffer);
-		free(netobj->receive_lengths);
-
 		ret = EFI_CALL(efi_close_event(netobj->wait_for_packet));
 		if (ret != EFI_SUCCESS)
 			return -1;
@@ -1450,9 +1456,6 @@ int efi_net_unregister(void *ctx, struct event *event)
 		efi_free_pool(interface);
 	}
 
-	// Free the efi_net_obj
-	free(netobj);
-
 	return 0;
 }
 
-- 
2.43.0

