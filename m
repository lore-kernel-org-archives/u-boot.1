Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB96DC282CD
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 14:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15AC381253;
	Mon,  3 Mar 2025 15:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kFU/i0zY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEB5B81298; Mon,  3 Mar 2025 15:13:38 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57A40812BF
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 15:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-223594b3c6dso74780375ad.2
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 06:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741011215; x=1741616015; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l5EZAP3C6sMdE4jT/Qaszrcb14U152LIuw4hvFyM1gg=;
 b=kFU/i0zYV7nag0l0YaL+ptoDFPGDKUZVKzjb5oom4/ghsPl5fobcWX8Gx8RcRHOD2g
 c1ibVxxFdm5EtimEEl2H5CswQxmjyESs2YsLFjCL1Dz4+chMwQrMrb6VkUxXMpM2kPdJ
 KKOsfdibbmdKUn0Pn9/rM9mqU6DYnhrCgpPLu/WNH6+2tqfjW96TzSUHrVVXQDL69Vke
 5xs6wlJd9M7CXfb6CqWwJEn83C6r4CizpjXGb+VKQYMTBAr/qC5/F0nmSkxIEKFnZfFq
 B1mpQagc+gvjNZzvvsFlQ7/RIFROR/an3FlkkEPMOe1a5puATu+6o+W4m5kXgKtCE5UQ
 xI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741011215; x=1741616015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l5EZAP3C6sMdE4jT/Qaszrcb14U152LIuw4hvFyM1gg=;
 b=JBsUp+D9/U4EszL72uz34Qsnu8JfT2sUHqsmlUTuRRUbG9HrkqcHLyYtW4hLqt/t1P
 j96ieB/haKvyGYJAnu9efaiVwYMUpaQP5ws/wCAlb73VnzBcat5257eUGDYSAEOPJX0I
 mQHsQjyWnkhSOLkkCSgnMfssZ3C4TP6UXiiKgDNdbG4WOYsAFGjcWE8MFXEG1gsdaRUI
 mMlN7R6qmk1rBiQl/YsHvG8i6qlKtGQEKSwPOZCMfxOXxSKfdDOAP8PaZzXbatvYYe70
 Vl4BTHfcZjYsT7lu+YkLUWQfFuQIgh9oXvfDW7Bvvls4PIJDCDbG6LNw99ziMIxEeST4
 67hg==
X-Gm-Message-State: AOJu0YybbRyYaSgd25TgP5JmQ6qH4NyvcPgXNGJh2HeGoz4wOCrS72ID
 +WYCKDqnn1FMtw24q8OHSJ8UYEHnqkcWf9lyCbNZDrykTlBtWeZAyAAfJcAqBuc=
X-Gm-Gg: ASbGnctTNOFWG05kyeSvLFvsQrIWU2xEJBB1eXpsrCiSrcxz9guUKgwEUNVCqdXoAtu
 1agjJqBTdve2lHmf3Wq4c9bD0r4gnAtBWZQMb6m/SU7rCHjBPuwDSMgyopHKvwb0PRaC8Cl0OFx
 rpqnkAbw9rKYoAdoKMHFAuVwa8XezI7thyU1OgHVgcG7w7syHKqAXc9x1stwumJNwqQxR74MqBV
 d2DjVm5O5VUA9P5XoqiqiG0l1XcxDsW0uibtHCJGBNC6PZEunJEmLHFWPk0F0vpQ5lkCsiuF6JP
 HqtYOzu3Gf1xBBhWnrkB0IaVFgxsHxlkS8+XU9aNRBopTJ0L/2IGboo=
X-Google-Smtp-Source: AGHT+IEwfXYRgdek6FpuzgS+f+klLsUlYhXehaqZxg3KaTKHKdJ0lZCLRIXSt5XiH6rbokReW4JsPw==
X-Received: by 2002:a17:902:e5c1:b0:215:b1a3:4701 with SMTP id
 d9443c01a7336-22368f85a47mr180081365ad.13.1741011214780; 
 Mon, 03 Mar 2025 06:13:34 -0800 (PST)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501faa33sm77875265ad.66.2025.03.03.06.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 06:13:34 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 7/8] efi_loader: efi_net: Add dhcp cache
Date: Mon,  3 Mar 2025 11:13:16 -0300
Message-ID: <20250303141317.265098-7-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303141317.265098-1-adriano.cordova@canonical.com>
References: <20250303141317.265098-1-adriano.cordova@canonical.com>
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

(no changes since v1)

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
2.47.1

