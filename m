Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C69C28B2E
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 12:06:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67BA081417;
	Mon, 10 Mar 2025 13:06:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XqljIroZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9F4F812D9; Mon, 10 Mar 2025 13:06:18 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9A3E817A5
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 13:06:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so3510675ad.2
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 05:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741608374; x=1742213174; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NEnpYIfFBDUkqnKxrJ4eAyFQl9sG9dnaCB37gHOWOgo=;
 b=XqljIroZCrrUdrHhfSg794XSLJMBSAT8wGxZB62bmn7VOBIo1cyIRkhqYZ/invYTKu
 k0s0lNICBxVMvso3otQzlOgoCadcXPBXBR7lcVvBsLbBAQgcVbYH5bEOlP11AOKW1fUW
 P43ufkeaOqSY2a68it6sQh0TDrxUBm+aqyelzxN/9Hph2AZdfMlVDwRvjaHDr7TQu08J
 L0ihryaDSsH5uJk2/2AmNWWiDgewdxLkalXffJs8MysLGghKlnKXbU0QLD9kZSb/8+hj
 NrZDdBPyyGrhIcYLB/+Fz5sM4TZ9kMvGt2GbLufL1fdm5kwytNDK6YKbSqIOVrtW2auh
 R0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741608374; x=1742213174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NEnpYIfFBDUkqnKxrJ4eAyFQl9sG9dnaCB37gHOWOgo=;
 b=QaJP4uoDGs83EdzTwL7Jq0Z+16Xv1uCSfP1CaiivyPmr5RBlJyFPbFJl/ny8KPxR3o
 7ubPNzauHejbr7ZSSLAr9f26vjBrm/2Dl1S1Zd3uAlBXJy+5x6B6Tbnv3zMLE0WpKLps
 2v9wB4t71rqlIqfqB9IuFCxLaLQ81aykD8aeFywQa3qdVTxubodeD4lbJVMXXXTyLL7x
 H4XhrndQFABIjel2V5ixaT5CASew7CF+t63jzwjmoBAltSbW4FshSoRUTcdw4SceCfw7
 dCMajxOsy1YVohQXuNJZj3on3kXY69JzAlL8S+I1Ul3iD5g46txQEIItxg/kjCyb9XVx
 bVWQ==
X-Gm-Message-State: AOJu0YzT+hGMaIDvim5CLDioF/OiyB3E0hiB2m1I8pGrx38xuJ8GAQh7
 vC0UygHRkIFkhRPfxY65nlpMyj+jUDqHWhjkabZtZ59GTYVNqMdxJoqMa6W6Ay8=
X-Gm-Gg: ASbGnctpexFfTnQY+rVzOeZWy5GihSW1EnF0s6xG3pZ5QdsaTVu6dRJHsJz4tzP1kJj
 MIqrRyrN+dnYPx9iXtZaCK3Afrddu2qlOxVYR0j8BmLpfZHLs16gg/fSGsjn1oIOf46Ivk+r+7d
 EOdeMWJdsLgGRm7kl380Momtvmh+tyzF1S0jm+ucvLuoZjFzrqKg6m4TnsfW3maD4Efe3DoJNvZ
 q/beDal2VhvTUfAw2yRFvlilh1cDxG8tN0FmtYBRY/4bXA5Hh3wW9aydt3V9Q8/qQvBUSuShY01
 0ddHNuYs5aEjCpGp/26ZaE1/bbY7mzBbcNu4inIorJILLP1j1N9qrnk=
X-Google-Smtp-Source: AGHT+IHjXSZr15DisOGUquT+sd/pw3U/Jqga4QAn5NQvgtvG6OeKstPEPE5/t0dRtl1JSIzcocZZYw==
X-Received: by 2002:a17:902:ec92:b0:220:e9ef:ec98 with SMTP id
 d9443c01a7336-22428896a74mr222082725ad.19.1741608374507; 
 Mon, 10 Mar 2025 05:06:14 -0700 (PDT)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736a8b61f76sm6968899b3a.103.2025.03.10.05.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 05:06:14 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v3 7/8] efi_loader: efi_net: Add dhcp cache
Date: Mon, 10 Mar 2025 09:06:06 -0300
Message-ID: <20250310120607.186999-7-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310120607.186999-1-adriano.cordova@canonical.com>
References: <20250310120607.186999-1-adriano.cordova@canonical.com>
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
2.48.1

