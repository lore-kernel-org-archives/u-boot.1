Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96253C02199
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 17:41:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D22680F0A;
	Thu,  6 Feb 2025 18:40:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="joX9rMlJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D5B080A55; Thu,  6 Feb 2025 18:40:47 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25E9D80C72
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 18:40:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21f4a4fbb35so6610865ad.0
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 09:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738863644; x=1739468444; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/6gkiYpjZZFm6dIKd0zTuGL36d+Ol7W2SOgZs7ql1A0=;
 b=joX9rMlJSxZYVGPgbjjjPNlBbVYInwyL4OazQwNLMHFYXVzWn5cLvXWUUDY2+fL/fV
 PIKlCi2wJOZEpV+IU6BL2B6Y/OnYUV42eTnJz+s+smfi0Oa6pmkJmPM3xPQWk5uyc+UV
 u0+4i2tiLcfgNp6CYhJaaWC7QF0MouIlT/pfj31XmFTDxhLuUoG2O6yyo+6u7mY9L1dI
 EBF6Pa6VgeQVuJ028rsN3xq8XfMnbQNLmSGNMSLGj5Srb9vVAtwR4bBNYmXfzEYUN4ZL
 3pEBUgppuF+MKw/p9NTQhH2DTr052XgLoMxT6MakkmvcPICfckiSR9wpbgPl34CGO5bi
 r/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738863644; x=1739468444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/6gkiYpjZZFm6dIKd0zTuGL36d+Ol7W2SOgZs7ql1A0=;
 b=cR4fPibL5pcelcWBhulgraKm587u/TgHdgn9txbhU5+avmufQKoOXAI48CMhUsLUl6
 vdr5ge9xVNDtSWbKYOYP/0puudarqgk15LKSEpOBPId0mlV0ELQogTSxGAMrmH5sG97m
 kRNdJheaPtfQfuqGvMCy8PmrP/jImNNZQMtpErT5/+9tyE9iWKr8pUb1VzX4HSy8JxM2
 f9PMKIYGleVrfY+1nbhThGCuNsw7QyCVrODNm4Qozig5LEi98hpqZdfOE3cpwtA1swJx
 W47hLIrvxRLjW8JZIQgK1+kU1CwQDy14GJKZZYIQVbntQbyuUBFle147sijpvQWSEX3W
 LqMQ==
X-Gm-Message-State: AOJu0YzdeGfqHEjkfm10N4RMYU7iOX0Q2NxbCCWAMphZkQTtHjhYwMzA
 Cf+tzvm3pq+OspzjF+nTOWplXw5U9J4B1sR3F81UDq6tpcWE/JCSp/AJEsQuIM5+kA==
X-Gm-Gg: ASbGncvUpZc6id64ivqUjODFBf+CJuSkJx7QIMvtcsHESRR2O2WHnK6G3nczfguPmX5
 KI2Q5u0mQGxsjgoxcMDaP2jL4LHXvXhUj7CiACCzT9KLwLYBv5TCbVh+dZO8lQzAaz8UiuVBQLG
 Ld6l4fuqToV3QU0TGwAm1UUdpwy5zpr2sCCeBp2mYv4RGWf6oxcorPG+Vx4yKze+T+pTwzvDn18
 XACH03I27GT41v+we/E5W2g5wFKlz5zmX1wG9PDgWV2/Ez8hCNkITBhQkPMU3Lz2OAw2l8+AZbs
 mPs1MCVZkKYy5tmK6B+SbNUW
X-Google-Smtp-Source: AGHT+IG0ZfPZ0uMuqqw/WAfd7hrH/vNv5t/dvaSCQRBJpjIOstYN8y8VMunMZDzqyEOAkTLuJTKR7w==
X-Received: by 2002:a17:903:1787:b0:21f:2e:4e4e with SMTP id
 d9443c01a7336-21f2f1458f1mr71551895ad.5.1738863643655; 
 Thu, 06 Feb 2025 09:40:43 -0800 (PST)
Received: from adriano.. ([191.119.55.28]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3687c31asm15476615ad.167.2025.02.06.09.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 09:40:43 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 7/8] efi_loader: efi_net: Add dhcp cache
Date: Thu,  6 Feb 2025 14:40:17 -0300
Message-ID: <20250206174018.465530-8-adriano.cordova@canonical.com>
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

Add a dhcp cache to store the DHCP ACKs received by the U-Boot network
stack.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_loader/efi_net.c | 55 +++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index f65287ad6ab..2fac39ae513 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -24,12 +24,12 @@
 #include <vsprintf.h>
 #include <net.h>
 
+#define MAX_NUM_DHCP_ENTRIES 10
 #define MAX_NUM_DP_ENTRIES 10
 
 const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
 static const efi_guid_t efi_pxe_base_code_protocol_guid =
 					EFI_PXE_BASE_CODE_PROTOCOL_GUID;
-static struct efi_pxe_packet *dhcp_ack;
 static void *new_tx_packet;
 static void *transmit_buffer;
 static uchar **receive_buffer;
@@ -61,6 +61,15 @@ static struct wget_http_info efi_wget_info = {
 };
 #endif
 
+struct dhcp_entry {
+	struct efi_pxe_packet *dhcp_ack;
+	struct udevice *dev;
+	bool is_valid;
+};
+
+static struct dhcp_entry dhcp_cache[MAX_NUM_DHCP_ENTRIES];
+static int next_dhcp_entry;
+
 /*
  * The notification function of this event is called in every timer cycle
  * to check if a new network packet has been received.
@@ -317,6 +326,7 @@ static efi_status_t EFIAPI efi_net_shutdown(struct efi_simple_network *this)
 	eth_set_dev(netobj->dev);
 	env_set("ethact", eth_get_name());
 	eth_halt();
+
 	this->int_status = 0;
 	wait_for_packet->is_signaled = false;
 	this->mode->state = EFI_NETWORK_STARTED;
@@ -718,18 +728,28 @@ out:
  */
 void efi_net_set_dhcp_ack(void *pkt, int len)
 {
-	int maxsize = sizeof(*dhcp_ack);
+	struct efi_pxe_packet **dhcp_ack;
+	struct udevice *dev;
+
+	dhcp_ack = &dhcp_cache[next_dhcp_entry].dhcp_ack;
+
+	/* For now this function gets called only by the current device */
+	dev = eth_get_dev();
 
-	if (!dhcp_ack) {
-		dhcp_ack = malloc(maxsize);
-		if (!dhcp_ack)
+	int maxsize = sizeof(**dhcp_ack);
+
+	if (!*dhcp_ack) {
+		*dhcp_ack = malloc(maxsize);
+		if (!*dhcp_ack)
 			return;
 	}
-	memset(dhcp_ack, 0, maxsize);
-	memcpy(dhcp_ack, pkt, min(len, maxsize));
+	memset(*dhcp_ack, 0, maxsize);
+	memcpy(*dhcp_ack, pkt, min(len, maxsize));
 
-	if (netobj)
-		netobj->pxe_mode.dhcp_ack = *dhcp_ack;
+	dhcp_cache[next_dhcp_entry].is_valid = true;
+	dhcp_cache[next_dhcp_entry].dev = dev;
+	next_dhcp_entry++;
+	next_dhcp_entry %= MAX_NUM_DHCP_ENTRIES;
 }
 
 /**
@@ -1036,7 +1056,7 @@ set_addr:
 efi_status_t efi_net_register(struct udevice *dev)
 {
 	efi_status_t r;
-	int i;
+	int i, j;
 
 	if (!dev) {
 		/* No network device active, don't expose any */
@@ -1123,8 +1143,19 @@ efi_status_t efi_net_register(struct udevice *dev)
 	netobj->pxe.set_station_ip = efi_pxe_base_code_set_station_ip;
 	netobj->pxe.set_packets = efi_pxe_base_code_set_packets;
 	netobj->pxe.mode = &netobj->pxe_mode;
-	if (dhcp_ack)
-		netobj->pxe_mode.dhcp_ack = *dhcp_ack;
+
+	/*
+	 * Scan dhcp entries for one corresponding
+	 * to this udevice, from newest to oldest
+	 */
+	i = (next_dhcp_entry + MAX_NUM_DHCP_ENTRIES - 1) % MAX_NUM_DHCP_ENTRIES;
+	for (j = 0; dhcp_cache[i].is_valid && j < MAX_NUM_DHCP_ENTRIES;
+	     i = (i + MAX_NUM_DHCP_ENTRIES - 1) % MAX_NUM_DHCP_ENTRIES, j++) {
+		if (dev == dhcp_cache[i].dev) {
+			netobj->pxe_mode.dhcp_ack = *dhcp_cache[i].dhcp_ack;
+			break;
+		}
+	}
 
 	/*
 	 * Create WaitForPacket event.
-- 
2.45.2

