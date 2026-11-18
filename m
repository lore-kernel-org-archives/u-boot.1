Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAC8606A320
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MD5kQyNh;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=jBgFiqeb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA3DE8108A;
	Wed, 18 Nov 2026 13:18:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GcKvq168YA1D; Wed, 18 Nov 2026 13:18:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5DB6C811D7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795007910;
	b=NrLYU19Qc/mgsALVMS2BDwm0Xji4JH6ZrHt9Lr6iLGIqPmriSl+mkZ6PjuPKVtoksW5f
	 /Qy3lhNgWWFKzTN25sijfxmFg1pr52ZRMy762K3I9F7vKpXZAo7Pevx/hs6U3+UWtv34L
	 adzitcOxzDZwYkT9zaMusK5JgwMsq0KaS2gwkw2hD/r/Yu2TXjQxA5YsA30yEcodfm5Ud
	 hTSX01R4Ugtk0d8kl849EmRDKvgXkRchSOdhsoVndi9WS5mcOjd8U/G1m/ypadLvKbNh4
	 nZNgjZk0U7qzYCtQ65Q9jLY/MTzXRPlRKuip17S065MYE1Gf0ksgz/rCyF3hF/9jypA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007910;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=S1k2LXI/kXlUJLzaT3s1yc1orbi+AL3yLduVukqxVbw=;
	b=eJHwln9Uwn5Yk94BLaC4kE1n4+vVGVzjZ4NLXvplx/clfowHsfZ/ZAapGe9Tkn4IAB4w
	 FZKW++nR4V5LxduOiIS4E9EQthvYJ5PRjZKKRYrWRgTxCzBugTkIvNxlSwDFyfGa9lFnb
	 AEWkjiUFyez6aHrAqhielXdVDtxNb44jrOjNZAfzhpJSBC6sG1BEGW7oCNGN5SsQePkZh
	 B0IpDIhcCHjshPzsW0xCXJgLcO3HhX2hKOM4+O8w8J3kMis5thuH4t1ME0hwaVd2FazbI
	 xtJXcYTQVUTOhfo62IqNbvuikg6RDlESMCNahtZn3+8CTT0IeGkr/7BZrNIlwQVGFVA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=jBgFiqeb;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795007910;
	bh=S1k2LXI/kXlUJLzaT3s1yc1orbi+AL3yLduVukqxVbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MD5kQyNhMiruibHWSpS87cFdwda8NLzWSdDFfO7vUHw5CnWfT4BKDdsz73ARnS+MH
	 GHj55c+M4ryd9sAZhp7v9EZWr26/M440vIdomnLQxRvhqIjUL3Y5CYIvfMWv5l+6MU
	 T2BcfRhZ0poguGJO7EP0dd+8LsO0jc15VEF0Z+3isOho03wyV1Uu9cVWnHIHWfKYWQ
	 WgGe7twCi42zGjO0Ge7S8qE8iNGJXI7YhwLXqP2okzpeOn0uAZ8jKhfIEeKcMVwnca
	 cXKxWWlNxLTopaI7RFmzfYFO+qstiJ4u3RmC/O3tf7A2vWjSUflGoduYFfUUX8YuV1
	 +PmIUPShp9w4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DB6C811D7;
	Wed, 18 Nov 2026 13:18:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C498EA0E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A78FF8108A
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gR_OqQ7Ua9cl for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:18:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9607880F4E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=jBgFiqeb
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9607880F4E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:25 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 8E3661A16D0;
 Wed, 18 Nov 2026 13:18:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5C26D5FE9B;
 Wed, 18 Nov 2026 13:18:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DB49911BC1F9E; Wed, 18 Nov 2026 14:18:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795007898; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=S1k2LXI/kXlUJLzaT3s1yc1orbi+AL3yLduVukqxVbw=;
 b=jBgFiqeb6JfYcVP6/rTu5ua9HPpR7l7S439eZngdsid6/O3HIpvu5qLhThcbh89ptcuHkf
 MySG72UydWRa1G8vAMrLCyRg1FWU4jw2vhEAQB1x6wolNuVBWzJUHnIEaaK3y5IG0ppmMG
 51KYU5Z46DQiDfmvP81zAwDwJ6lJI6SZTl7biuSUJvEYkj4W+jSM0WTRVU/ZE0LCqf9uq8
 S+sVLzO6j7gZzyZSsd3hYHwR+UnN63hAFaVKGtD67wuy5TgiKxH08YORfB2Sbgz9tm+Y7A
 V4QvuFznzk8aGt1sFtk//UpUG8nESWyWq4zSbPB80tIeTlWjbke9S0gMFFOGXA==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v7 01/20] firmware: ti_sci: add low power mode operations
Date: Wed, 18 Nov 2026 14:17:48 +0100
Message-ID: <20261118131807.135859-2-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118131807.135859-1-richard.genoud@bootlin.com>
References: <20261118131807.135859-1-richard.genoud@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Prasanth Babu Mantena <p-mantena@ti.com>

On TI-k3 platform, at resume, uboot SPL needs to do several tasks:
- restore TIFS minimal context from DDR
- send DDR save address to TIFS
- load TFA and its context in MSMC
- set TFA resume vector to its warm_entrypoint
- authenticate certificates and apply firewalls

All those operations are now done by TIFS with those messages:
ti_sci_cmd_min_context_restore
ti_sci_cmd_decrypt_tfa
ti_sci_cmd_core_resume
ti_sci_cmd_lpm_save_addr
ti_sci_cmd_proc_auth_apply_fwls

https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html
https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/security/PROC_BOOT.html

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/include/mach/security.h |   1 +
 arch/arm/mach-k3/security.c              |  62 ++++++++
 drivers/firmware/ti_sci.c                | 181 +++++++++++++++++++++++
 drivers/firmware/ti_sci.h                |  92 ++++++++++++
 include/linux/soc/ti/ti_sci_protocol.h   |   8 +
 5 files changed, 344 insertions(+)

diff --git a/arch/arm/mach-k3/include/mach/security.h b/arch/arm/mach-k3/include/mach/security.h
index 8502b57bd80a..fa90fed7c427 100644
--- a/arch/arm/mach-k3/include/mach/security.h
+++ b/arch/arm/mach-k3/include/mach/security.h
@@ -9,3 +9,4 @@
 #include <linux/types.h>
 
 void ti_secure_image_post_process(void **p_image, size_t *p_size);
+void ti_secure_image_auth_apply_fwls(void **p_image, size_t image_size);
diff --git a/arch/arm/mach-k3/security.c b/arch/arm/mach-k3/security.c
index c7017bba99ab..2df922a2fa27 100644
--- a/arch/arm/mach-k3/security.c
+++ b/arch/arm/mach-k3/security.c
@@ -133,3 +133,65 @@ void ti_secure_image_post_process(void **p_image, size_t *p_size)
 	      spl_boot_device() == BOOT_DEVICE_UART))
 		printf("Authentication passed\n");
 }
+
+void ti_secure_image_auth_apply_fwls(void **p_image, size_t image_size)
+{
+	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
+	struct ti_sci_proc_ops *proc_ops = &ti_sci->ops.proc_ops;
+	u64 image_addr;
+	u32 backup_size;
+	int ret;
+
+	if (!image_size) {
+		debug("%s: Image size is null\n", __func__);
+		return;
+	}
+
+	if (get_device_type() == K3_DEVICE_TYPE_GP)
+		return;
+
+	if (get_device_type() != K3_DEVICE_TYPE_HS_SE &&
+	    !ti_secure_cert_detected(*p_image)) {
+		printf("Warning: Did not detect image signing certificate. "
+		       "Skipping authentication to prevent boot failure. "
+		       "This will fail on Security Enforcing(HS-SE) devices\n");
+		return;
+	}
+
+	/* Clean out image so it can be seen by system firmware */
+	image_addr = dma_map_single(*p_image, image_size, DMA_BIDIRECTIONAL);
+
+	debug("Authenticating image at address 0x%016llx\n", image_addr);
+	debug("Authenticating image of size %zu bytes\n", image_size);
+
+	/*
+	 * Authenticate image
+	 * The size argument is modified by proc_auth_apply_fwls and may be 0
+	 * when the authentication process has moved the image.
+	 * When this happens no further processing on the image is needed or
+	 * often even possible as it may have also been placed behind a firewall
+	 * when moved.
+	 * And moreover it expects a u32*. So, use the backup_size.
+	 */
+	backup_size = image_size;
+	ret = proc_ops->proc_auth_apply_fwls(ti_sci, &image_addr, &backup_size);
+	if (ret) {
+		printf("Authentication failed..but assume pass!\n");
+		hang();
+	}
+
+	/* Invalidate any stale lines over data written by system firmware */
+	dma_unmap_single(image_addr, image_size, DMA_BIDIRECTIONAL);
+
+	/*
+	 * Output notification of successful authentication to re-assure the
+	 * user that the secure code is being processed as expected. However
+	 * suppress any such log output in case of building for SPL and booting
+	 * via YMODEM. This is done to avoid disturbing the YMODEM serial
+	 * protocol transactions.
+	 */
+	if (!(IS_ENABLED(CONFIG_XPL_BUILD) &&
+	      IS_ENABLED(CONFIG_SPL_YMODEM_SUPPORT) &&
+	      spl_boot_device() == BOOT_DEVICE_UART))
+		printf("Certificate replay passed\n");
+}
diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index c015bd3cc245..050f4d61562a 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2014,6 +2014,64 @@ static int ti_sci_cmd_set_proc_boot_ctrl(const struct ti_sci_handle *handle,
 	return ret;
 }
 
+/**
+ * ti_sci_cmd_proc_auth_apply_fwls() - Command to authenticate certificate and
+ *				       apply the firewalls present in it.
+ * @handle:	Pointer to TI SCI handle
+ * @image_addr:	Memory address at which payload image and certificate is
+ *		located in memory, this is updated if the image data is
+ *		moved during authentication.
+ * @image_size: This is updated with the final size of the image after
+ *		authentication.
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_cmd_proc_auth_apply_fwls(const struct ti_sci_handle *handle,
+					   u64 *image_addr, u32 *image_size)
+{
+	struct ti_sci_msg_req_proc_auth_boot_image req;
+	struct ti_sci_msg_resp_proc_auth_boot_image *resp;
+	struct ti_sci_info *info;
+	struct ti_sci_xfer *xfer;
+	int ret = 0;
+
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	if (!handle)
+		return -EINVAL;
+
+	info = handle_to_ti_sci_info(handle);
+
+	xfer = ti_sci_setup_one_xfer(info, TISCI_MSG_PROC_AUTH_APPLY_FWLS,
+				     TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				     (u32 *)&req, sizeof(req), sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		dev_err(info->dev, "%s Error making the tisci command\n",
+			__func__);
+		return ret;
+	}
+	req.cert_addr_low = *image_addr & TISCI_ADDR_LOW_MASK;
+	req.cert_addr_high = (*image_addr & TISCI_ADDR_HIGH_MASK) >>
+				TISCI_ADDR_HIGH_SHIFT;
+
+	ret = ti_sci_do_xfer(info, xfer);
+	if (ret) {
+		dev_err(info->dev, "%s Error sending the tisci command\n",
+			__func__);
+		return ret;
+	}
+
+	resp = (struct ti_sci_msg_resp_proc_auth_boot_image *)xfer->tx_message.buf;
+
+	*image_addr = (resp->image_addr_low & TISCI_ADDR_LOW_MASK) |
+			(((u64)resp->image_addr_high <<
+			  TISCI_ADDR_HIGH_SHIFT) & TISCI_ADDR_HIGH_MASK);
+	*image_size = resp->image_size;
+
+	return ret;
+}
+
 /**
  * ti_sci_cmd_proc_auth_boot_image() - Command to authenticate and load the
  *			image and then set the processor configuration flags.
@@ -2745,6 +2803,125 @@ static int ti_sci_cmd_min_context_restore(const struct ti_sci_handle *handle, u6
 	return ret;
 }
 
+/**
+ * ti_sci_cmd_decrypt_tfa() - Request for decrypting TFA to specific address.
+ * @handle:    pointer to TI SCI handle
+ * @unencrypted_address: Address where the unencrypted TFA will be restored to.
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_cmd_decrypt_tfa(const struct ti_sci_handle *handle,
+				  u64 unencrypted_address)
+{
+	struct ti_sci_msg_decrypt_tfa_req req;
+	struct ti_sci_msg_decrypt_tfa_resp *resp;
+	struct ti_sci_info *info;
+	struct ti_sci_xfer *xfer;
+	int ret = 0;
+
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	if (!handle)
+		return -EINVAL;
+
+	info = handle_to_ti_sci_info(handle);
+
+	xfer = ti_sci_setup_one_xfer(info, TISCI_MSG_LPM_DECRYPT,
+				     TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				     (u32 *)&req, sizeof(req), sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		return ret;
+	}
+
+	req.unencrypted_address = unencrypted_address;
+
+	ret = ti_sci_do_xfer(info, xfer);
+
+	return ret;
+}
+
+/**
+ * ti_sci_cmd_core_resume() - Request for resuming TFA.
+ *
+ * The TIFS will launch the TFA from the entrypoint saved via the ENTER_SLEEP
+ * message.
+ *
+ * @handle:    pointer to TI SCI handle
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_cmd_core_resume(const struct ti_sci_handle *handle)
+{
+	struct ti_sci_msg_core_resume_req req;
+	struct ti_sci_msg_core_resume_resp *resp;
+	struct ti_sci_info *info;
+	struct ti_sci_xfer *xfer;
+	int ret = 0;
+
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	if (!handle)
+		return -EINVAL;
+
+	info = handle_to_ti_sci_info(handle);
+
+	xfer = ti_sci_setup_one_xfer(info, TISCI_MSG_CORE_RESUME,
+				     TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				     (u32 *)&req, sizeof(req), sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		return ret;
+	}
+
+	ret = ti_sci_do_xfer(info, xfer);
+
+	return ret;
+}
+
+/**
+ * ti_sci_cmd_lpm_save_addr() - Message to inform TIFS about the context save address.
+ *
+ * By restoring its context, TIFS will restore its firewall.
+ *
+ * @handle:    pointer to TI SCI handle
+ * @context_addr:  address where the context will be store to and restored from
+ * @size:	   Size of the context save region
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_cmd_lpm_save_addr(const struct ti_sci_handle *handle,
+				    u64 context_addr, u32 size)
+{
+	struct tisci_msg_lpm_save_ctx_addr_req req;
+	struct tisci_msg_lpm_save_ctx_addr_resp *resp;
+	struct ti_sci_info *info;
+	struct ti_sci_xfer *xfer;
+	int ret = 0;
+
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	if (!handle)
+		return -EINVAL;
+
+	info = handle_to_ti_sci_info(handle);
+
+	xfer = ti_sci_setup_one_xfer(info, TISCI_MSG_LPM_SAVE_ADDR,
+				     TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				     (u32 *)&req, sizeof(req), sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		return ret;
+	}
+
+	req.ctx_addr = context_addr;
+	req.size = size;
+
+	ret = ti_sci_do_xfer(info, xfer);
+
+	return ret;
+}
+
 /*
  * ti_sci_setup_ops() - Setup the operations structures
  * @info:	pointer to TISCI pointer
@@ -2813,6 +2990,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	pops->set_proc_boot_cfg = ti_sci_cmd_set_proc_boot_cfg;
 	pops->set_proc_boot_ctrl = ti_sci_cmd_set_proc_boot_ctrl;
 	pops->proc_auth_boot_image = ti_sci_cmd_proc_auth_boot_image;
+	pops->proc_auth_apply_fwls = ti_sci_cmd_proc_auth_apply_fwls;
 	pops->get_proc_boot_status = ti_sci_cmd_get_proc_boot_status;
 	pops->proc_shutdown_no_wait = ti_sci_cmd_proc_shutdown_no_wait;
 
@@ -2833,6 +3011,9 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	fw_ops->query_dm_cap = ti_sci_cmd_query_dm_cap;
 
 	lpm_ops->min_context_restore = ti_sci_cmd_min_context_restore;
+	lpm_ops->decrypt_tfa = ti_sci_cmd_decrypt_tfa;
+	lpm_ops->core_resume = ti_sci_cmd_core_resume;
+	lpm_ops->lpm_save_addr = ti_sci_cmd_lpm_save_addr;
 }
 
 /**
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 68908c6c8c46..d6ae08144d46 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -57,6 +57,7 @@
 #define TISCI_MSG_PROC_AUTH_BOOT_IMAGE	0xc120
 #define TISCI_MSG_GET_PROC_BOOT_STATUS	0xc400
 #define TISCI_MSG_WAIT_PROC_BOOT_STATUS	0xc401
+#define TISCI_MSG_PROC_AUTH_APPLY_FWLS	0xc402
 
 /* Resource Management Requests */
 #define TI_SCI_MSG_GET_RESOURCE_RANGE	0x1500
@@ -85,6 +86,24 @@
 #define TISCI_MSG_FWL_GET		0x9001
 #define TISCI_MSG_FWL_CHANGE_OWNER	0x9002
 
+/* LPM requests */
+#define TISCI_MSG_SYNC_RESUME			(0x0302U)
+#define TISCI_MSG_CONTINUE_RESUME		(0x0303U)
+#define TISCI_MSG_CORE_RESUME			(0x0304U)
+#define TISCI_MSG_ABORT_ENTER_SLEEP		(0x0305U)
+#define TISCI_MSG_LPM_WAKE_REASON		(0x0306U)
+#define TISCI_MSG_SET_IO_ISOLATION		(0x0307U)
+#define TISCI_MSG_MIN_CONTEXT_RESTORE		(0x0308U)
+#define TISCI_MSG_LPM_SET_DEVICE_CONSTRAINT	(0x0309U)
+#define TISCI_MSG_LPM_SET_LATENCY_CONSTRAINT	(0x030AU)
+#define TISCI_MSG_LPM_GET_DEVICE_CONSTRAINT	(0x030BU)
+#define TISCI_MSG_LPM_GET_LATENCY_CONSTRAINT	(0x030CU)
+#define TISCI_MSG_LPM_GET_NEXT_SYS_MODE		(0x030DU)
+#define TISCI_MSG_LPM_GET_NEXT_HOST_STATE	(0x030EU)
+#define TISCI_MSG_LPM_ENCRYPT			(0x030FU)
+#define TISCI_MSG_LPM_DECRYPT			(0x0310U)
+#define TISCI_MSG_LPM_SAVE_ADDR			(0x0313U)
+
 /**
  * struct ti_sci_msg_hdr - Generic Message Header for All messages and responses
  * @type:	Type of messages: One of TI_SCI_MSG* values
@@ -1588,4 +1607,77 @@ struct ti_sci_msg_min_restore_context_req {
 	u32			ctx_hi;
 } __packed;
 
+/*
+ * struct ti_sci_msg_core_resume_req - Request for TISCI_MSG_CORE_RESUME.
+ *
+ * @hdr:			Generic Header
+ *
+ * This message is to be sent to start the TFA on the main core.
+ * The TIFS will launch the TFA from the entrypoint saved via the ENTER_SLEEP
+ * message.
+ */
+struct ti_sci_msg_core_resume_req {
+	struct ti_sci_msg_hdr	hdr;
+} __packed;
+
+/**
+ * struct ti_sci_msg_core_resume_resp - Response for TISCI_MSG_CORE_RESUME.
+ *
+ * @hdr:			Generic Header
+ */
+struct ti_sci_msg_core_resume_resp {
+	struct ti_sci_msg_hdr	hdr;
+} __packed;
+
+/**
+ * struct ti_sci_msg_decrypt_tfa_req - Request for TISCI_MSG_LPM_DECRYPT.
+ *
+ * @hdr:			Generic Header
+ * @unencrypted_address:	Address where the TFA should be decrypted
+ * @encrypted_address:		Address where the TFA lies encrypted
+ *
+ * This message is to be sent when the system is resuming from suspend, in order
+ * to restore the TFA.
+ * The TIFS will decrypt the TFA at specified location and restore it in SRAM.
+ */
+struct ti_sci_msg_decrypt_tfa_req {
+	struct ti_sci_msg_hdr	hdr;
+	u64			unencrypted_address;
+} __packed;
+
+/**
+ * struct ti_sci_msg_decrypt_tfa_resp - Response for TISCI_MSG_LPM_DECRYPT.
+ *
+ * @hdr:			Generic Header
+ */
+struct ti_sci_msg_decrypt_tfa_resp {
+	struct ti_sci_msg_hdr	hdr;
+} __packed;
+
+/**
+ * struct tisci_msg_lpm_save_ctx_addr_req - Request for TISCI_MSG_LPM_SAVE_ADDR.
+ *
+ * @hdr:			Generic Header
+ * @ctx_addr:	Address where the LPM data is to be saved
+ * @size:		Size of the context save memory region
+ *
+ * This message is sent to TIFS to inform it about the address where it
+ * will save the context to in case of system suspend and where to get the
+ * context back from when resuming the system
+ */
+struct tisci_msg_lpm_save_ctx_addr_req {
+	struct ti_sci_msg_hdr	hdr;
+	u64			ctx_addr;
+	u32			size;
+} __packed;
+
+/**
+ * struct tisci_msg_lpm_save_ctx_addr_resp - Response for TISCI_MSG_SAVE_ADDR.
+ *
+ * @hdr:			Generic Header
+ */
+struct tisci_msg_lpm_save_ctx_addr_resp {
+	struct ti_sci_msg_hdr	hdr;
+} __packed;
+
 #endif /* __TI_SCI_H */
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 6b1dd801f5f8..1d0a6340e1ee 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -336,6 +336,8 @@ struct ti_sci_proc_ops {
 				    u32 *sts_flags);
 	int (*proc_shutdown_no_wait)(const struct ti_sci_handle *handle,
 				     u8 pid);
+	int (*proc_auth_apply_fwls)(const struct ti_sci_handle *handle,
+				    u64 *image_addr, u32 *image_size);
 };
 
 #define TI_SCI_RING_MODE_RING			(0)
@@ -635,9 +637,15 @@ struct ti_sci_fwl_ops {
 /**
  * struct ti_sci_lpm_ops - Low Power Mode operations
  * @min_context_restore: Request restoring context from DDR.
+ * @decrypt_tfa: Request for decrypting TFA at specific address.
+ * @core_resume: Request for resuming TFA once decrypted.
+ * @lpm_save_addr: Send DDR Save address to TIFS
  */
 struct ti_sci_lpm_ops {
 	int (*min_context_restore)(const struct ti_sci_handle *handle, u64 ctx_addr);
+	int (*decrypt_tfa)(const struct ti_sci_handle *handle,	u64 unencrypted_address);
+	int (*core_resume)(const struct ti_sci_handle *handle);
+	int (*lpm_save_addr)(const struct ti_sci_handle *handle, u64 context_addr, u32 size);
 };
 
 /**
