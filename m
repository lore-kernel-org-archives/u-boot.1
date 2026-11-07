Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B574B606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UvzK4bBb;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SQdVerv4
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 90F8260A60;
	Sat,  7 Nov 2026 12:50:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r1GwDI7Zxx4Q; Sat,  7 Nov 2026 12:50:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D3043608D2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055833;
	b=FRltSxpF9w1zRR8jtGWP4F4V/FCr5/zRT5bFTfViynwFGkBqXDORmCQdF03ygoWEJ4Dp
	 EoC/8DjOTvH1uLpZj9DGcon6GTmko5LdoPmanVi6q+VKm9W9eb1xmy6TeKQmp6DVQD0qe
	 yo+HFVmd65QAy1e4aeTgxbsz6Fwb7gK3Q5SjuTzwtgwE0OP/BqvDIVcF45sv/zLzSibKP
	 bGHVcUZHFFiIg/iBTd4NeXVjGy8nZnUKZpalFWZ1XBhcYTGTVFBQ9Pgj2n4UCjipCEQEO
	 lYPWnpbMe0pIfAy9HVWCsIsBKSiOkzNaMGE5CgMl/btkrKVJ8Hb1/n/DU2LV+YrfkUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055833;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=m74K57aRohJYqYLJOZz3SHbV1NLzrx7im5oYCzLZJWA=;
	b=dbGu7ZExvdjQOObVfvtJUNTVjkOvM8f4sRWwJBpWxbgnP8DPDtrOZaGy+cjzDYVw+zfu
	 VAz74hjlXPrkdGuZT69fqqbRaeaCBNjXbLnpGgQg/Ugo3+h8BZErkJdfFA1AvQ4W4IJ+p
	 lqol3UhRJeQu9Om3LGsRQhBlWDXyH50mAygvqadIi5s40+RZqZxpU5tgsxP+EHVlgF+lT
	 Nh5VxGeK5ozhxOjEYM7eeTIXGOm9qiI/BTixA/GX9TGEbxquhdH6RXE2spaoptN6lpEE1
	 sx/9XW5a1iphG79U7+M2tgXelxIZp1oioh9bwE6rfji9Pb4kQnmq5muvBvg9hiUbBBQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055833;
	bh=m74K57aRohJYqYLJOZz3SHbV1NLzrx7im5oYCzLZJWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UvzK4bBbnVE3WFBDs6rlRNsqXERkEUOLy9wcXHSCKU9bUKOgEzJLwgQL7YYaLG1bX
	 HCZIGVz27ZZ7Mqma7/zYNpg41T0CZ0TFrUR5h27/KiSEmeoz2D+u84vUOvCbnaiqJl
	 Ga/uVaAmaWQcEE50xVp+R8EBJjQyHdxNKTa6QYj5UWYMo0m6MoEP0yL18YL7dx2xBz
	 +dP6hjQ4rD3GFz7M1eSMlZsr/722pi/l8+TK/NaNy+1rq0AljbIfTHLuOjRsG451K7
	 fUTXZR2xWe3Sq/rFhHyyawMtVHYT7FTyhdcyRnnLPdc7W3Gt2EQu3mvt9kyjZJPBwR
	 eajTDjUqxUZ4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D3043608D2;
	Sat,  7 Nov 2026 12:50:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B8CFE34D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9F0C840800
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0X8UB095z9Jl for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:24:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A9A7B407EE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::635"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=SQdVerv4
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A9A7B407EE
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:06 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c3fae9338f0so11522266b.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036244; x=1794641044;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m74K57aRohJYqYLJOZz3SHbV1NLzrx7im5oYCzLZJWA=;
 b=SQdVerv4X6csB3diiu2gkY6HJxU5KwgJ5ye594p4eHvCZOEFfKwnYj1CfgF/lbJbKn
 NJ4XIaxABswvWm1PNKdOU3fRILYVJ1Fv1Lx+PrFEqF0NlABwZE1/U55wXVXS+1zsgzfO
 sNa/1G0hANAYOtHm3KyX7nFS7JvyIriCrxe+4usWuI8zpKeJabVi6pr82tOnzXSp29dq
 3JXYdhk1JsmDegFz03tGqZtmDqp5/GRULj3VoOUR1mGoqcawRnZZ6GOVRkwzMQQSBYTD
 NfwnR8OWJNqmdyV85zEgah15x/ry5B8MAfIESKRGPAtKlS6SVyfb7mUGkddV+OymQ2K3
 17VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036244; x=1794641044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m74K57aRohJYqYLJOZz3SHbV1NLzrx7im5oYCzLZJWA=;
 b=GZgsW+yZwYipeTT7R4o1z74W4QJgAs91q7bmz+HqvaVSAyfvMnqpDRCkocCBorM49R
 3eudvUF8nQqCba1KtYQs8rMKFumUrHrB6RROkcN4TJo+KT6sy+8+9T3yarT29/+EvRZ2
 N6dglQiwBf/H7zhh1KErorBqDjrfGQuV3/w6oqPWx5t2LqBJabdsUOHtj9qD7WnXkYvL
 n5p4IOfMXIdk936sPVsy6m0F+8QIu9PkOICcfjGVDUwFcsEjtw5sJlfljQbNf4wrLjd7
 7jCvmSWXONrZ816Zq5Cucnf3iXDcMQI8AOK/7oomj8cST4c4kXXgxCx5PezYjezP63fP
 E8AA==
X-Gm-Message-State: APuU4Z+/1IMegMV/aa155kieZFXZ1UEVtE4EipXoRWyWN6lxLSs1BW51
 fWIHC9QQFkcUfeJJQbFPU9q11HAiFq5Z+4NpbEb6TCnqjZJXVMQe7LfpmWGT6+lEnKKE/uVnsOk
 Nzf2O
X-Gm-Gg: AYBFou3rxq+gFCSdtgmjMmaPwzlhxLANM3cQ6RCgNdv+OGXGoWW0vvNvW+Sgb6s3jWA
 NTBALE4nJQBlov2jnvCCOkn26icD1+q+tvI4s6+cJ3vDzY8sxk9+FaXOM8Fm30GM557wBiSEI7U
 ghWuf67Otz86tisbV0hZLRjnQyMkzRnSzsma8lBs5vgYQSoa5yFPWNtyeBDCpXP2u2r5OR5IoIX
 b8m7IaLEZNZ0ajM5i8E2+oswpMiydcZVuRj10K0G3FUbPZBOm4SAx65zCwC0ab293NN+tMYx7hZ
 aee5MxIjCTozBrog1efJEIxpeVAred5RK4IsD4hl9+JF5R1A6oIXnkAVhegrBajCxOY+uDcw3zQ
 C/NXJ5OCpPgfVXss/9KLyRlEu3zdF+ZIHLMSbP5fOl4dUy/Vwc607t42J9HyWqBeMMnm1unzekW
 ogWNpFpjgK7AtWao5nogXFq6yKRGh1mgCFEb3R4kLEDMxbTXlicBwRipObAa75KRD3SD9gGIyD6
 x37cxWra0yuyL9jckhpkAGTDp0trtWDiyV60p5Toa4I0mH/X4ubacw3PdQtkH/edkKEdu18dnfS
 MkhOD/BgAFjSjaEiV5HcTj4aoKMxFXvppEqhYfZPgDd5HQfBCorhVKgGwOWNd0voJpdAZVcksGX
 /xCp/kQkMIw==
X-Received: by 2002:a17:907:3a14:b0:c40:5ee3:8694 with SMTP id
 a640c23a62f3a-c4d35389057mr376042266b.4.1794036244195; 
 Fri, 06 Nov 2026 23:24:04 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ea8csm130129166b.22.2026.11.06.23.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:24:03 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v11 21/30] usb: gadget: at91_udc: register with udc-core
Date: Sat,  7 Nov 2026 08:22:15 +0100
Message-ID: <20261107072224.3492260-22-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107072224.3492260-1-anders.roxell@linaro.org>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:49:49 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

udc-core has its own usb_gadget_register_driver() now, and it only
knows controllers that called usb_add_gadget_udc(). Drop the local
usb_gadget_register_driver() and usb_gadget_unregister_driver(), and add
the gadget to udc-core in at91_udc_probe().

at91_udc_ops already has udc_start and udc_stop, so udc-core can start
and stop the controller.

taurus and smartweb call at91_udc_probe() from board code and there is
no udevice to use as the parent, so pass NULL. udc-core only stores the
pointer.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/at91_udc.c | 56 +++++++----------------------------
 1 file changed, 10 insertions(+), 46 deletions(-)

diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index b3c780a4e35c..ee2af2d699ff 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -1435,52 +1435,6 @@ int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 	return at91_udc_irq(udc);
 }
 
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
-{
-	struct at91_udc *udc = controller;
-	int ret;
-
-	if (!driver || !driver->bind || !driver->setup) {
-		printf("bad paramter\n");
-		return -EINVAL;
-	}
-
-	if (udc->driver) {
-		printf("UDC already has a gadget driver\n");
-		return -EBUSY;
-	}
-
-	at91_start(&udc->gadget, driver);
-
-	udc->driver = driver;
-
-	ret = driver->bind(&udc->gadget);
-	if (ret) {
-		pr_err("driver->bind() returned %d\n", ret);
-		udc->driver = NULL;
-	}
-
-	return ret;
-}
-
-int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
-{
-	struct at91_udc *udc = controller;
-
-	if (!driver || !driver->unbind || !driver->disconnect) {
-		pr_err("bad paramter\n");
-		return -EINVAL;
-	}
-
-	driver->disconnect(&udc->gadget);
-	driver->unbind(&udc->gadget);
-	udc->driver = NULL;
-
-	at91_stop(&udc->gadget);
-
-	return 0;
-}
-
 int at91_udc_probe(struct at91_udc_data *pdata)
 {
 	struct at91_udc	*udc;
@@ -1540,6 +1494,16 @@ int at91_udc_probe(struct at91_udc_data *pdata)
 	/* Clear all pending interrupts - UDP may be used by bootloader. */
 	at91_udp_write(udc, AT91_UDP_ICR, 0xffffffff);
 
+	/*
+	 * The boards call this from board code, there is no udevice to hang
+	 * the gadget on, so pass NULL as the parent.
+	 */
+	retval = usb_add_gadget_udc(NULL, &udc->gadget);
+	if (retval) {
+		pr_err("failed to register udc: %d\n", retval);
+		return retval;
+	}
+
 	INFO("%s version %s\n", driver_name, DRIVER_VERSION);
 	return 0;
 }
-- 
2.53.0

