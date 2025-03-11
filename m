Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19C8C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 16:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B889581895;
	Tue, 11 Mar 2025 17:48:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h2sicUWO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A446381875; Tue, 11 Mar 2025 17:48:01 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 505CB811C1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:47:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22403cbb47fso111192485ad.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 09:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741711678; x=1742316478; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24Lk9zuv927yYKHBzhL6s9GnS87J8MCmO7HGhTqIRCM=;
 b=h2sicUWOvz/q8622wNBX73OJiQynsHSLJfUNjUIvd4CHzbFtQytNAce27wYEe0nlx6
 sJ2NSLMOCmIouBaRTrVHTLZYebO/yfXLpmjrAgBy3FK5wLDqTqYLeh3TmgaObh2ZkvHn
 qgPvO9YqDtT8LqQJ1XmbmnitFKCLwTYzN35+yrMJwWWLzl9lQBPUlMdx/i6P2vhSXnQg
 ohosSts7DG3Aq+y/7BnnV+GqEmjqYUOsAN8M1LcFbSWKPJUQwT5WB1bhLjVMC2Mw1AkA
 d95YiFvQoMHFGDXsod/Woq4aZTGf6V3cthzmIG6SiJQO2CVIfbvdskXunCvleiF1y+sc
 Phdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741711678; x=1742316478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24Lk9zuv927yYKHBzhL6s9GnS87J8MCmO7HGhTqIRCM=;
 b=lPhdLIenuLiSq1y6VSt1tfuttUOspEkmcwDW/MYwrEn7zw1GVQaAyTEX9SetMTS0FQ
 fCSh5CNeoWyvuQxhxHwtAGzmWbOefM3fcvkLeCgdEfJDlGeZq7mnrrlpC8xJ6U2K7ibF
 CZBMHe0GZFZJGnrqIyJD5QHCdaX9rIAag6jnHRBCRsvaE28v29XnQcUwPnXE56CwSCWv
 6NOOWOugrByhRxpv9oT1Rq08YAGnfqnc/mltC6DTV9jyFxFSi8iU+WrRaZk9e59GG/8Q
 KId1bCo4fP6uBHQuAhcBwCo8WSlncmjGMCCq15yZr2Sz+WK/cDWLYWeINLyMt7RVIGwi
 wB5w==
X-Gm-Message-State: AOJu0YzIh5im9cP8Wd0wDRqWRkFFZw9XLAcRgoxAqgypHfmrHyMf+ORp
 5X3bGSGd4e3cVA/RrGrArzIj3YQE9xI8k8SlGnGjpTN7S1kBqtdRo0DlmIh5hm8=
X-Gm-Gg: ASbGncsHtG3b9rsjKmFVEO1MpUxTihe4TlFjehvOKS69wLz2i48iDqRgu8IUT4aTd9b
 0CQtXB1oqYyAahvC6tymWW3kfMi9Ih68ovXgHypBdCUdvUO8aip8r81BDSktHZtvI7PAZlYn4b/
 Lk+jwuqFf8nM4JMHja2iSmBG2gmpOM0K+CCLJHlfe7t+S21rhwwtoF8UGO/mGVHt6tayAnn50sR
 j7bgxbrMd5ld159sfwmLcwqA8M7Ay1gwANHbLsnDMNC7SfPzTZCoG/vRxcwktbGm2R9L7CDCCDU
 qPrb31xgIkA7Mb1L0JpeTflA84Ub0o6oyreAIqsFKuSDMzjFQFG5ubM=
X-Google-Smtp-Source: AGHT+IGoEkyepMzZeS/fgwlAiRXJWVwWFgOeWG1DrlDjnICutx8/uiyl/wrzQgH7rkaYbcXIjh6skA==
X-Received: by 2002:a05:6a00:1817:b0:736:3979:369e with SMTP id
 d2e1a72fcca58-736aa9f1fcdmr21978669b3a.9.1741711677713; 
 Tue, 11 Mar 2025 09:47:57 -0700 (PDT)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736bf09ae2bsm6941749b3a.74.2025.03.11.09.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 09:47:57 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, =trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 03/16] efi_loader: efi_net: Reuse efi_net_obj's
Date: Tue, 11 Mar 2025 13:47:45 -0300
Message-ID: <20250311164758.421900-4-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311164758.421900-1-adriano.cordova@canonical.com>
References: <20250311164758.421900-1-adriano.cordova@canonical.com>
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

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_loader/efi_net.c | 81 +++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 8c0a3f5243c..d84fa6c2bc6 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -1162,29 +1162,35 @@ static int efi_netobj_init(struct efi_net_obj *netobj)
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
@@ -1301,12 +1307,6 @@ failure_to_add_protocol:
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
@@ -1367,22 +1367,35 @@ int efi_net_register(void *ctx, struct event *event)
 
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
@@ -1429,17 +1442,10 @@ int efi_net_unregister(void *ctx, struct event *event)
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
@@ -1462,9 +1468,6 @@ int efi_net_unregister(void *ctx, struct event *event)
 		efi_free_pool(interface);
 	}
 
-	// Free the efi_net_obj
-	free(netobj);
-
 	return 0;
 }
 
-- 
2.48.1

