Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C8FC44532
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 00:52:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A855409AC;
	Thu, 23 Jul 2026 00:52:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9oFq4VmTECzV; Thu, 23 Jul 2026 00:52:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5FDDC409F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784767943;
	bh=2biwqb5b3gTXW5RZTx/G60J5MRFwbfBPshGcKj7gfrM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NoEvazdFzp5l+0oJLEbYESM53wLY8GaZmnVkWnzJ4NQNPoSDyThoHrw1lKjh3VzVD
	 gnc4ltwdWfXFmEXvvw3X8mPXQDOWIoOJRE6XC45sNDyz4B71swHfLLmZBiuUqYhI+d
	 1w/8211Ex9DYqNNHvXyHkmBXPvEeWmLlO8jXF9sl4SYvs1fMeiKoGzRReLdZxwgbLp
	 +eZOBSPRWMcY+pfBHtTDjR8RfyvM6CyObGKC2Cu62fU81eipnGg+GlDpFSxDKMRtuD
	 fCIghbt7NL08PYJcPkYay+xXWQMxvEnOlWFjVTqY1QblQtR98eRgcyVXdcoyD9cVu4
	 6qwo6Al2PGU3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5FDDC409F9;
	Thu, 23 Jul 2026 00:52:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 258D3390
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:43:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0B708400B8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:43:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h8wLQ5L93MFn for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 15:43:02 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=prvs=656eedf95=jamie.gibbons@microchip.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 354FF40087
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 354FF40087
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 354FF40087
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:43:01 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5EA78494B; Wed, 22 Jul 2026 17:42:59 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A28C848BA
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 17:42:57 +0200 (CEST)
X-CSE-ConnectionGUID: dAyyRM0CTP2MTfYPJrJZ/Q==
X-CSE-MsgGUID: 6SK4hxDPSWu/VKemlMkZhg==
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="61326537"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Jul 2026 08:42:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 22 Jul 2026 08:42:54 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 22 Jul 2026 08:42:52 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 "Leo Yu-Chi Liang" <ycliang@andestech.com>, Sughosh Ganu
 <sughosh.ganu@arm.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin
 Herren <sputnik@on-the-web.ch>, Michal Simek <michal.simek@amd.com>,
 <jamie.gibbons@microchip.com>
Subject: [PATCH v2 1/6] misc: mpfs_syscontroller: add mailbox RX helper for
 service responses
Date: Wed, 22 Jul 2026 16:45:44 +0100
Message-ID: <20260722154602.3373184-2-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722154602.3373184-1-jamie.gibbons@microchip.com>
References: <20260722154602.3373184-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 23 Jul 2026 00:52:16 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1784734977; x=1816270977;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nNayFCktWyvc5/5YlQUBAmmKTWnxOS9TRWxvP1W2EsA=;
 b=QCh7pJO2q0N4Gu2llC5AkDtJnJ3N2K6OV5mcrUXzaaWK/rlGBUDR7WU/
 TwgdtnCuWtSqutBNNnFeLLbcVcpY5cQzxZyMMQKiBOAIoo8yXl59lZwsX
 CPHBIs8zwdZfHpktknyvwG6dLJx+q2PLpz/lrvmeML2aXGBe/JsKZdM9B
 MAm6JpUnXvZMMyOagZzW65cb8eiE0///F4//0vW6dKpnG4Ee/AzoBcAAs
 dl0rM+zwYXgarGw22/RVdY+NsqUK6kuG9Du3idSJ6ilkNuqhojV0kC1AG
 SYfZ+RZqvRYbnkA4UmACHXnSb+Kty9gWTcKwN8dS3Gp08Gxt68oK1G/Le
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=microchip.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=QCh7pJO2
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=microchip.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=656eedf95=Jamie.Gibbons@microchip.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.b="QCh7pJO2"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The MPFS system controller run_service() helper only submits the mailbox
request but does not read back the response data. However, the caller
must explicitly receive the response.

Add a public system controller helper to receive mailbox service
responses to populate the response buffer after issuing a system
controller request.

Without this, the drivers copy uninitialised stack data instead of
mailbox response data, resulting in deterministic output.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/misc/mpfs_syscontroller.c | 30 ++++++++++++++++++++++++++----
 include/mpfs-mailbox.h            |  2 ++
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/mpfs_syscontroller.c b/drivers/misc/mpfs_syscontroller.c
index f608d5518b0..8803263ca4c 100644
--- a/drivers/misc/mpfs_syscontroller.c
+++ b/drivers/misc/mpfs_syscontroller.c
@@ -85,6 +85,30 @@ int mpfs_syscontroller_run_service(struct mpfs_syscontroller_priv *sys_controlle
 }
 EXPORT_SYMBOL_GPL(mpfs_syscontroller_run_service);
 
+/**
+ * mpfs_syscontroller_recv_response() - Receive the MPFS system service response
+ * @sys_controller:	MPFS system controller instance
+ * @msg:			System service message
+ * @timeout_ms:		Timeout in milliseconds
+ *
+ * Receive the mailbox response for a previously issued MPFS system
+ * controller service request and populate the response buffer.
+ *
+ * Return: 0 if all goes good, else appropriate error message.
+ */
+int mpfs_syscontroller_recv_response(struct mpfs_syscontroller_priv *sys_controller, struct
+	mpfs_mss_msg * msg, unsigned long timeout_ms)
+{
+	int ret;
+
+	ret = mbox_recv(&sys_controller->chan, msg, timeout_ms);
+	if (ret)
+		dev_err(sys_controller->chan.dev, "Service failed: %d, abort. Failure: %u\n", ret,
+			msg->response->resp_status);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mpfs_syscontroller_recv_response);
+
 /**
  * mpfs_syscontroller_read_sernum() - Use system service to read the device serial number
  * @sys_serv_priv:	system service private data
@@ -116,11 +140,9 @@ int mpfs_syscontroller_read_sernum(struct mpfs_sys_serv *sys_serv_priv, u8 *devi
 	}
 
 	/* Receive the response */
-	ret = mbox_recv(&sys_serv_priv->sys_controller->chan, &msg, timeoutsecs);
-	if (ret) {
-		dev_err(sys_serv_priv->sys_controller->chan.dev, "Service failed: %d, abort. Failure: %u\n", ret, msg.response->resp_status);
+	ret = mpfs_syscontroller_recv_response(sys_serv_priv->sys_controller, &msg, timeoutsecs);
+	if (ret)
 		return ret;
-	}
 
 	debug("%s: Read successful %s\n",
 	      __func__, sys_serv_priv->sys_controller->chan.dev->name);
diff --git a/include/mpfs-mailbox.h b/include/mpfs-mailbox.h
index c0ff327a4ce..39c998e4c8d 100644
--- a/include/mpfs-mailbox.h
+++ b/include/mpfs-mailbox.h
@@ -58,6 +58,8 @@ struct mpfs_sys_serv {
 };
 
 int mpfs_syscontroller_run_service(struct mpfs_syscontroller_priv *sys_controller, struct mpfs_mss_msg *msg);
+int mpfs_syscontroller_recv_response(struct mpfs_syscontroller_priv
+	*sys_controller, struct mpfs_mss_msg *msg, unsigned long timeout_ms);
 int mpfs_syscontroller_read_sernum(struct mpfs_sys_serv *sys_serv_priv, u8 *device_serial_number);
 void mpfs_syscontroller_process_dtbo(struct mpfs_sys_serv *sys_serv_priv);
 struct mpfs_syscontroller_priv *mpfs_syscontroller_get(struct udevice *dev);
-- 
2.43.0

