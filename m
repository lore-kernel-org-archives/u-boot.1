Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC6CC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 23:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A555A8881C;
	Tue, 23 Jul 2024 01:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fk1qH9tJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LdEe2v3C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 503A5886F0; Tue, 23 Jul 2024 01:30:14 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BB0987E13
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 01:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WSc2G6MBdz9smm;
 Tue, 23 Jul 2024 01:29:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nW3VbY956tN9CviVLH8HjBLK6dczNJ1lxgWqQr7Z8OA=;
 b=fk1qH9tJ7L+WV05+LF+Tv3ki5n31YN/D39pAOUL1NbYmqgJVNPjQ5pm4jNnEyuoAAaR9ep
 JF25YnOtBaTEHO4TJHj09pxetyPcSYWgKOHIE4MO8raKvvriz90/5ENpNB8BfZArNWvgzB
 +DBGoieHORxBF7x5AU5NSYV87MK1GSr6UUx+wMj9BdDVQ4hVtZEKbpUgr9CFXqPXumzz5d
 29P9KttxWLNMTWrYZQ/FoZ5NNbCadbg2fgRzGtopn3/meVvYp/p6nCf9LoISRW6dDrps5o
 XZBPn3ChuDEcyspl5b7xTy1iXVuttcJV0wWSvr+L18EeOv/RtGbsAa6dQKol3A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nW3VbY956tN9CviVLH8HjBLK6dczNJ1lxgWqQr7Z8OA=;
 b=LdEe2v3CJW7fLDsCw2UQKvkS66kbgWO0iCmwuYsJNu3ZZoAnFz/tvFFyyxPbtm3B8FSQPN
 tDJoDblbAZagk+O07G75rO+H1X37UkWDeSrcJ+K+sWnNTe3dlWToaPOVJEr8d4AzbE/ncc
 0HoXT1jwg2Imm/pv9UPkGvZC0keUkcdItIve7lY+UQdhto9Mm/nZWzjmiM8tqdNTCsnSkm
 DYm4fM/9lBQpvqpY+tbvmuMtRpDrrbwRBmrnTEu5HV8L4EpPalt16iEO51F6tbJPB4+W7g
 ZC4PXVyGmOdUFLjF5dQfHV3+kxfFlap73ioUfSsogTWirP49UahpSnHF6+X/Cg==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 12/15] include: usb: Remove duplicate newlines
Date: Tue, 23 Jul 2024 01:28:31 +0200
Message-ID: <20240722232910.91249-12-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
References: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0f397705b631dd74714
X-MBO-RS-META: 5ree7971mxmugqfrt6do8wh3934bqmxd
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 include/usb/ci_udc.h | 1 -
 include/usb/ulpi.h   | 2 --
 include/usb/xhci.h   | 4 ----
 3 files changed, 7 deletions(-)

diff --git a/include/usb/ci_udc.h b/include/usb/ci_udc.h
index 06adb2bb4d3..9f15dbabe53 100644
--- a/include/usb/ci_udc.h
+++ b/include/usb/ci_udc.h
@@ -4,7 +4,6 @@
  * Lei Wen <leiwen@marvell.com>
  */
 
-
 #ifndef __CI_UDC_H__
 #define __CI_UDC_H__
 
diff --git a/include/usb/ulpi.h b/include/usb/ulpi.h
index 126623cf9a8..10e31221103 100644
--- a/include/usb/ulpi.h
+++ b/include/usb/ulpi.h
@@ -116,7 +116,6 @@ int ulpi_suspend(struct ulpi_viewport *ulpi_vp);
  */
 int ulpi_reset(struct ulpi_viewport *ulpi_vp);
 
-
 /* ULPI access methods below must be implemented for each ULPI viewport. */
 
 /*
@@ -314,5 +313,4 @@ struct ulpi_regs {
 #define ULPI_CARKIT_PLS_CTRL_SPKRLEFT_BIASEN	(1 << 2)
 #define ULPI_CARKIT_PLS_CTRL_SPKRRIGHT_BIASEN	(1 << 3)
 
-
 #endif /* __USB_ULPI_H__ */
diff --git a/include/usb/xhci.h b/include/usb/xhci.h
index 04d16a256bb..5fcdae1421f 100644
--- a/include/usb/xhci.h
+++ b/include/usb/xhci.h
@@ -682,7 +682,6 @@ struct xhci_input_control_ctx {
 	__le32	rsvd2[6];
 };
 
-
 /**
  * struct xhci_device_context_array
  * @dev_context_ptr	array of 64-bit DMA addresses for device contexts
@@ -699,7 +698,6 @@ struct xhci_device_context_array {
  * might not be able to handle the maximum number of devices possible.
  */
 
-
 struct xhci_transfer_event {
 	/* 64-bit buffer address, or immediate data */
 	__le64	buffer;
@@ -835,7 +833,6 @@ struct xhci_event_cmd {
 #define TRB_TO_STREAM_ID(p)		((((p) & (0xffff << 16)) >> 16))
 #define STREAM_ID_FOR_TRB(p)		((((p)) & 0xffff) << 16)
 
-
 /* Port Status Change Event TRB fields */
 /* Port ID - bits 31:24 */
 #define GET_PORT_ID(p)			(((p) & (0xff << 24)) >> 24)
@@ -1134,7 +1131,6 @@ int xhci_hcd_init(int index, struct xhci_hccr **ret_hccr,
 					struct xhci_hcor **ret_hcor);
 void xhci_hcd_stop(int index);
 
-
 /*************************************************************
 	EXTENDED CAPABILITY DEFINITIONS
 *************************************************************/
-- 
2.43.0

