Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F004CD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 05:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 727E08432A;
	Thu, 21 May 2026 07:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m4ejuV/V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91040846EC; Thu, 21 May 2026 00:00:36 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 353E08432A
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 00:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ryan.persee@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48fe26a177cso40576035e9.1
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 15:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779314432; x=1779919232; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uqCVYyvf3RLtqD7sVZ4hYhu2V2qVvSoyvdm3JuaSDYE=;
 b=m4ejuV/VbSKyenMkOhLpjYUtZUCM3CBY4PYkzHtNbqev/W3ThGXN9Zk85veZJikRvQ
 8F+9twN34wDEVUl8snc0XfdJO7FnAEJ5uz+56R02xcyTl0lAFb+4hfJ95gcRjndQMw09
 bqTruZAzhPT83dBL1kGInCiNvCuNHUNP8pIx9oI8zPBniJnu4xJ5K6zDo5Ufg7r5CP5P
 Djhc+4b5AGkC4LrZPT8Ez/OIf85uj61DdHzf9UjyJb6RXZ1bC9K4i9CaGkWC7gvO0apA
 EFSHaQG7hIHAH9ZCFB7X7SP/FEHw/zOQzvCpWwGysy7mpVmqklb7IfZJ5DrsJDvsT3sA
 lGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779314432; x=1779919232;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uqCVYyvf3RLtqD7sVZ4hYhu2V2qVvSoyvdm3JuaSDYE=;
 b=nRROFzlEW69Qpu+KFBx5M5gRT+vU7BB5a8cHSgD3Vv1k1Mv6GaWuDlIpVUi5h3dLpy
 n4ZT987XzpVIQLyNHXkAyRSZB8I8xYp7VAezvU9Jy8KLonJtEjx9GEdGcegxl5Dv6cC+
 c5Yb/1eAJpqcCSwJGewhd+EubV+dZiv+HZ+ochcMsbXD956gZIrQlL1G+MlNAFDGafBB
 ei8ksNF8+xzYVTD6l8Hz9Xa1EUJE8YKQ6uw1igSkCrOAkQ+6SP8jUEKAWyECqQykXqJ5
 /E8KrDJwat5qjjA+9pjY6zGoYaI/rh80uK6wr8Drif8TJhiqwJxKzPRzVaNZclwrRV2m
 dZIg==
X-Gm-Message-State: AOJu0YzBPDwdSS4Anf2lwP+wC0vGX1N1pxKzdTczcYm606H1DGR6cjbt
 WGUA6O6lDKSrx29Ar3UTTIROoTBxrmIHmQ2OOotWKOFcLIgssoZ4+kA6Bo4EpAhmRZ4=
X-Gm-Gg: Acq92OGAFRgoxOfLo4jJ7i6G5WlJQnnKm23grToy5vcmJckLc7dFuwLBUHTZhHE85cS
 VA/+RXppOFhOweF0zrcRT8vL4MhoB0XiLfVumbeuksOcYppvoxg+kMEQ5zqCul7ri8EIg05jvp1
 Bl2ko8jrAUjJK4McDOlbChYylcKtMS04sz5mwG+RwyTmYUqvSwvmP7np9MvVarSd1FDSexvdriM
 JxPyqJ3OENNIBSbZQT1Ti4TyINLDrgB2e+hWYo79jibyLiet9K+cIGY0iKtGzcUGhG6+cZavwTk
 AsJVqNtea7ocd9mEAnolPcKg83uGC+8aBu23g7cfIoNCZd+ts4pm3JPXhVx8HTm0Ua3Lg3CI5f4
 BfMXaL4AwTUqPctIynbeIZl+vvQNr08vJ3zyQMaw3MVbMxHSPGL2vAT8aITffEIywjdywZu1Plv
 R+cFdzf6nTLkoyukClrhJ1kXTeZICxZOb2bntcMlVhHhZSwY1luJluRGsXQeuFp7DhjHVR9TQvp
 FeTOekS181VPRW5FemeKophILJbT6101Pg0pGxQGM8jOg==
X-Received: by 2002:a05:600c:b95:b0:48a:8b02:ae91 with SMTP id
 5b1f17b1804b1-49036067420mr1985545e9.11.1779314432132; 
 Wed, 20 May 2026 15:00:32 -0700 (PDT)
Received: from vm-noble-01.tail86f08.ts.net
 (2a02-8428-632f-2600-0000-0000-0000-0576.rev.sfr.net.
 [2a02:8428:632f:2600::576]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d8e24bsm19761155e9.10.2026.05.20.15.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 15:00:31 -0700 (PDT)
From: "=?UTF-8?q?Ryan=20Pers=C3=A9e?=" <ryan.persee@gmail.com>
X-Google-Original-From: =?UTF-8?q?Ryan=20Pers=C3=A9e?=
 <98691129+rpersee@users.noreply.github.com>
To: u-boot@lists.denx.de
Cc: jerome.forissier@arm.com, trini@konsulko.com, seanedmond@microsoft.com,
 ilias.apalodimas@linaro.org, quentin.schulz@cherry.de, xypron.glpk@gmx.de,
 Max.Merchel@ew.tq-group.com, paul.henrys_ext@softathome.com,
 marek.vasut+renesas@mailbox.org,
 =?UTF-8?q?Ryan=20Pers=C3=A9e?= <98691129+rpersee@users.noreply.github.com>
Subject: [PATCH] net: bootp: extend ProxyDHCP support to read bootfile name
Date: Wed, 20 May 2026 21:59:44 +0000
Message-ID: <20260520215944.85060-1-98691129+rpersee@users.noreply.github.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 21 May 2026 07:01:44 +0200
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

When CONFIG_SERVERIP_FROM_PROXYDHCP is enabled, a ProxyDHCP server
responds with a zero yiaddr and supplies PXE-specific parameters such
as the TFTP server address. However, the bootfile name was only read
from the BOOTP legacy 'bp_file' header field. Modern ProxyDHCP servers
(e.g. dnsmasq, iPXE) advertise the bootfile via DHCP option 67 instead,
which was previously ignored.

Furthermore, once the ProxyDHCP bootfile was stored, it could be silently
overwritten by a subsequent DHCP OFFER or ACK from the main DHCP server
if that packet also carried a bootfile (via option 67 or bp_file).

This patch makes three minimal changes within the existing
CONFIG_SERVERIP_FROM_PROXYDHCP guards:

1. Add store_proxydhcp_bootfile(), a targeted helper that walks the DHCP
   vendor options of a ProxyDHCP response and extracts only option 67.
   All other options are deliberately ignored so that the ProxyDHCP
   server cannot alter the client's network configuration (gateway, DNS,
   etc.), which remains the main DHCP server's responsibility.
   Option 67 takes precedence over the legacy bp_file header field;
   bp_file is used as a fallback via the existing store_bootp_params().

2. Add a !net_boot_file_name[0] guard in store_bootp_params() and in
   dhcp_process_options() case 67 so that a bootfile already set by the
   ProxyDHCP response is not overwritten by the main DHCP exchange.

3. Extend the ProxyDHCP wait condition in the SELECTING state to also
   delay when the bootfile has not yet been received, mirroring the
   existing delay for the server IP address.

Signed-off-by: Ryan Persée <98691129+rpersee@users.noreply.github.com>
---
 net/bootp.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/net/bootp.c b/net/bootp.c
index 8976936b184..a16245cc7e8 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -161,7 +161,11 @@ static void store_bootp_params(struct bootp_hdr *bp)
 	    !(dhcp_option_overload & OVERLOAD_FILE) &&
 #endif
 	    (strlen(bp->bp_file) > 0) &&
-	    !net_boot_file_name_explicit) {
+	    !net_boot_file_name_explicit
+#if defined(CONFIG_SERVERIP_FROM_PROXYDHCP)
+	    && !net_boot_file_name[0]
+#endif
+	    ) {
 		copy_filename(net_boot_file_name, bp->bp_file,
 			      sizeof(net_boot_file_name));
 	}
@@ -935,7 +939,11 @@ static void dhcp_process_options(uchar *popt, uchar *end)
 		case 66:	/* Ignore TFTP server name */
 			break;
 		case 67:	/* Bootfile option */
-			if (!net_boot_file_name_explicit) {
+			if (!net_boot_file_name_explicit
+#if defined(CONFIG_SERVERIP_FROM_PROXYDHCP)
+			    && !net_boot_file_name[0]
+#endif
+			    ) {
 				size = truncate_sz("Bootfile",
 						   sizeof(net_boot_file_name),
 						   oplen);
@@ -1080,6 +1088,43 @@ static void dhcp_send_request_packet(struct bootp_hdr *bp_offer)
 	net_send_packet(net_tx_packet, pktlen);
 }
 
+#if defined(CONFIG_SERVERIP_FROM_PROXYDHCP)
+/*
+ * Extract bootfile name from DHCP option 67 in a ProxyDHCP response.
+ * Only option 67 is read; all other options are intentionally ignored to
+ * avoid letting the ProxyDHCP server alter the client's network config
+ * (gateway, DNS, etc.) which is the main DHCP server's responsibility.
+ */
+static void store_proxydhcp_bootfile(struct bootp_hdr *bp)
+{
+	uchar *popt = (uchar *)&bp->bp_vend[4];
+	uchar *end = (uchar *)bp + BOOTP_HDR_SIZE;
+	int oplen, size;
+
+	if (net_read_u32((u32 *)&bp->bp_vend[0]) != htonl(BOOTP_VENDOR_MAGIC))
+		return;
+
+	while (popt < end && *popt != 0xff) {
+		if (*popt == 0) {
+			popt++;
+			continue;
+		}
+		oplen = *(popt + 1);
+		if (popt + 2 + oplen > end)
+			break;
+		if (*popt == 67 && !net_boot_file_name_explicit &&
+		    !net_boot_file_name[0]) {
+			size = truncate_sz("Bootfile",
+					   sizeof(net_boot_file_name), oplen);
+			memcpy(net_boot_file_name, popt + 2, size);
+			net_boot_file_name[size] = 0;
+			break;
+		}
+		popt += oplen + 2;
+	}
+}
+#endif
+
 /*
  *	Handle DHCP received packets.
  */
@@ -1100,6 +1145,7 @@ static void dhcp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 
 	if (net_read_ip(&bp->bp_yiaddr).s_addr == 0) {
 #if defined(CONFIG_SERVERIP_FROM_PROXYDHCP)
+		store_proxydhcp_bootfile(bp);
 		store_bootp_params(bp);
 #endif
 		return;
@@ -1130,7 +1176,7 @@ static void dhcp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 				efi_net_set_dhcp_ack(pkt, len);
 
 #if defined(CONFIG_SERVERIP_FROM_PROXYDHCP)
-			if (!net_server_ip.s_addr)
+			if (!net_server_ip.s_addr || !net_boot_file_name[0])
 				udelay(CONFIG_SERVERIP_FROM_PROXYDHCP_DELAY_MS *
 					1000);
 #endif	/* CONFIG_SERVERIP_FROM_PROXYDHCP */
-- 
2.43.0

