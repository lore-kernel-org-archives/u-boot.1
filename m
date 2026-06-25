Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43357CDE000
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 13:00:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA63484A29;
	Thu, 25 Jun 2026 14:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="u8RBYXQw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73A19848F0; Thu, 25 Jun 2026 14:20:06 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4425484704
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 14:20:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=629d8e15b=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1782390002; x=1813926002;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wtOQFyBf9UNBeRTukA8uIta1nuFU2lz0Jy4BxabHaGo=;
 b=u8RBYXQwUVieZz2jR99NBDHFGgNNJ/ARz9HhPnv5C+TdKYCP7e6zP2w0
 3CmmXgO6b+WkFBKbvXJP2UImDlSCqo42xQdpE/9jhbIVkEeKYQBHxHObD
 ZhJZ1VgC1aIRWJnYDMk17f3BCVKd0jNTIhsbdAdpyxBt1PT94mXz3pvzJ
 6UAunyqQVusLLc/ZknO73sIq7A0hTXakVgSHRkSa8qyC7an6kQTNDa8e5
 Aoh6Lq6Uv53dgHGRdZzWY5i2gqgNjOzHjLr1KeeeZEQK/c7B+p7APmwgk
 +0t1447vhuxkt6sAnNlrkGGAxIFfu1aF00qZme8BiCI4A+NRsSn5b5HGs g==;
X-CSE-ConnectionGUID: 1rN9PuDNTkylOL4TgwPcBA==
X-CSE-MsgGUID: 6B1gzZYfSpaBnBt1uP92fw==
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="291054888"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Jun 2026 05:20:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 25 Jun 2026 05:19:59 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 25 Jun 2026 05:19:56 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Sughosh Ganu <sughosh.ganu@arm.com>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Martin Herren <sputnik@on-the-web.ch>,
 Michal Simek <michal.simek@amd.com>, Adriana Nicolae <adriana@arista.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, <jamie.gibbons@microchip.com>
Subject: [PATCH 2/8] misc: mpfs_syscontroller: add mailbox RX helper for
 service responses
Date: Thu, 25 Jun 2026 13:23:19 +0100
Message-ID: <20260625122325.834568-3-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625122325.834568-1-jamie.gibbons@microchip.com>
References: <20260625122325.834568-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 25 Jun 2026 14:58:57 +0200
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

The MPFS system controller run_service() helper only submits the mailbox
request but does not read back the response data. However, the caller
must explicitly receive the response.

Add a public system controller helper to receive mailbox service
responses to populate the response buffer after issuing a system
controller request.

Without this, the drivers copy uninitialised stack data instead of
mailbox response data, resulting in deterministic output.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 drivers/misc/mpfs_syscontroller.c | 28 ++++++++++++++++++++++++----
 include/mpfs-mailbox.h            |  1 +
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/mpfs_syscontroller.c b/drivers/misc/mpfs_syscontroller.c
index f608d5518b0..61d6780f0b9 100644
--- a/drivers/misc/mpfs_syscontroller.c
+++ b/drivers/misc/mpfs_syscontroller.c
@@ -85,6 +85,28 @@ int mpfs_syscontroller_run_service(struct mpfs_syscontroller_priv *sys_controlle
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
+int mpfs_syscontroller_recv_response(struct mpfs_syscontroller_priv *sys_controller, struct mpfs_mss_msg *msg, unsigned long timeout_ms)
+{
+	int ret;
+
+	ret = mbox_recv(&sys_controller->chan, msg, timeout_ms);
+	if (ret)
+		dev_err(sys_controller->chan.dev, "Service failed: %d, abort. Failure: %u\n", ret, msg->response->resp_status);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mpfs_syscontroller_recv_response);
+
 /**
  * mpfs_syscontroller_read_sernum() - Use system service to read the device serial number
  * @sys_serv_priv:	system service private data
@@ -116,11 +138,9 @@ int mpfs_syscontroller_read_sernum(struct mpfs_sys_serv *sys_serv_priv, u8 *devi
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
index c0ff327a4ce..3922e8d1019 100644
--- a/include/mpfs-mailbox.h
+++ b/include/mpfs-mailbox.h
@@ -58,6 +58,7 @@ struct mpfs_sys_serv {
 };
 
 int mpfs_syscontroller_run_service(struct mpfs_syscontroller_priv *sys_controller, struct mpfs_mss_msg *msg);
+int mpfs_syscontroller_recv_response(struct mpfs_syscontroller_priv* sys_controller, struct mpfs_mss_msg* msg, unsigned long timeout_ms);
 int mpfs_syscontroller_read_sernum(struct mpfs_sys_serv *sys_serv_priv, u8 *device_serial_number);
 void mpfs_syscontroller_process_dtbo(struct mpfs_sys_serv *sys_serv_priv);
 struct mpfs_syscontroller_priv *mpfs_syscontroller_get(struct udevice *dev);
-- 
2.43.0

