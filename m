Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7A1606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AfmkQi9N;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zb4zCPCr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75D1081697;
	Sat,  7 Nov 2026 12:50:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UM8HEOKkMG2g; Sat,  7 Nov 2026 12:50:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 860D48161D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055831;
	b=gFJUQR+sOrKVCaoNSEfmjogZSxVdobnATao0aKaMkCmlA25yHpoB5OSFSQQQ3N18G05D
	 lmES7c9Z+PgDtoXEAa6uiLHBWvuIFKfdKFeXI7y623ozCnOLDWGcdub5Lg5xTOvS67M/F
	 Yyt+yNffqU4/nNea4eFOj5haJCz4QuLZEZMmbsweiv0C/MwOdHgraiE7uDMcNkMP/XHa6
	 AbSyVcOiXuIUXIRXAuEpCVIsIHACdQZBasMm0Tj3azoHKl7zbtYXW/Ox/quF6x9LmP8NE
	 vcpIezcXFW/kNV0wvvXsk+CDLdLBYg/9MRzMu97xvvGbgLs4WPYmnP22b4Rz4+7jyrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055831;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kHs5CbNv9B5aCtlj7OBepHuzuWM/75lhKgCtN8mNcpc=;
	b=EK1Gm3d44thSSKaCSBWtLEa9REQatkOpL888SJ6+5TVbAlCUJQupK1bsBhj/VfGxdPk3
	 pQx7t5uNqswJgyWFLyWzbB1pZ+Yp7GzSyWnuxxhW5vFH3Nn019jhmwWhA9RDSOhu2vQhw
	 m+69AM2OaskGMuCH62wfDOR+Jo1aVHR6RoJ36n1ajw6dLEZpb24Qo/MqTM+f+NOpYGfx+
	 l4jQ9S8I1hTtQ2CvkCCHpgtC3d9RXcK5iPp69JxFqTgJbCjGBMYv8oJdz27n+ty7S7ZO/
	 mhHQZ5LDtFenu6AmzXdnnQGkinSWhXSGZPzd02iIqxQ8ioj+IXdYseLZGSD7OWbCvOg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055831;
	bh=kHs5CbNv9B5aCtlj7OBepHuzuWM/75lhKgCtN8mNcpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AfmkQi9NTwZIdKEDeXQ2b4xfimfHHB1y7hLCUGEkU7j8p3+F/kbMKuzS2gf7jgavT
	 vlq40X+Hio+2mESh18Rkv3sWebw89oZ6DLr+wD5zDjWwLKW5nWwJvEPORAtNEM7OWV
	 SlpywdjCmd9MQKP0FcWL/mhD4d9tjUV7NoHjUpREn2tkP9Gn3hudmIC1y33AY4bXgo
	 Vl1YVM49567rsR4I7jAfymW38bHkoL+Os4P4Hl0ucSMQzvHkPTx4OgdQBkwiYJPdZU
	 1uydntPLhlI8gI6q+O/IqyYNj1eZmdpTbaZ1mQ41v65IOtg7nnUGYUT45j/kDwJrs6
	 9otenDziv2N6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 860D48161D;
	Sat,  7 Nov 2026 12:50:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2DA0031F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1348A606A6
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id POPaImbaHbXV for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:24:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A7A776069B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=zb4zCPCr
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7A776069B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:05 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b58c7fa717so235360a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036243; x=1794641043;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kHs5CbNv9B5aCtlj7OBepHuzuWM/75lhKgCtN8mNcpc=;
 b=zb4zCPCr+zEEG0z3m+UTcVSkaUIqdMKE/7y+QCu+3oCSIOQpw0IgVGUqKlRpLg7SJw
 6YSE9J5ZT0JhACLjlj1wSIsMvvyerd2NTsEuqd/g+DbBaXY+GYqGIsw3Ay0Y2oQm2H2g
 9Q3vcGIJ8q/455Dj874Aa3WxOdBqL6bdoWyJdkoM58G+1SJpKk85nuVMqv/5HmFIg0HG
 LssZfmOUHP8ivGd/WhRNYBKjD/pV2r86a83RDwAVj/4C0qza7aO37XlB0zM2+Aogz4XA
 dOF4YL6EYM0geLEthD6qfHx0pK8WBQLDtinupMb2KNxsqCAInXooImtvFNUvZRuLk4tt
 mzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036243; x=1794641043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kHs5CbNv9B5aCtlj7OBepHuzuWM/75lhKgCtN8mNcpc=;
 b=RhPFCw6ro+64Ri5KZdL/AQ5zz8kqngrwRKb9U15rL6HgSrANrUCstaG6U+UjVjNgX2
 DIdTBIgoGgWsQAk91cwfx2xfK+Rh1FzyXz3UNP6CdM6/jvowwUHrg1VwAG1BX7JIf6hT
 tK5XQhna2gyCM3yXnLrl3mzH7ysjJ4O0iaiu3E8qjVwKXs0aruoQJedRczN0Je2JREzW
 3FllcZFdgH33WpG3d0qZnETqQFeTxEwlG25CapndxZgubSxQ7zvFsuh8NiIxqKHbuLp8
 eIMbq9lY8nZDH4DlwSdytuJa4n7l2ZszD9/MHg7z4u6U4f4Beqj4k/T4j/K5rCovyk71
 qsPw==
X-Gm-Message-State: APuU4Z8EPvcHzSzL98KKXKBVVDvEPsQZL1flaccaQcjsSP8fMjOmod4h
 JMuhmXOjufOARfG9qLn2qBwYqRG+OpnZi2QyNc9qQ65SBqWoJHHBHl51Vd/jO81coCzvx6IEJBr
 oaCdp
X-Gm-Gg: AYBFou3TZWBHv++5nUC+rPKRbIzwNvcIxWXlbBG1dD4xSsSrI3PbFFPgnapZKcwjgoV
 8LxcsQtPjc80iszZf0GNEK7CoBVQuXLkl+EGIV76PQQFsJpLXztso0dcpwZ7xG7lBwZt5sEpUo+
 uT4aTHEI+fumaCESki3G1yxzWGJ2Oi9FwGlHcdffhG5Ta476ZO7vafSlgvcv+MTo+fcMr9+pqr5
 Sd2flCgM0fTKXFfD9ZQRrUgFkQZNKXqW9C7FhURfuJ8eDJmPKDrGZZEe0qQMSvCwelera5C2iis
 WPrZ9H1veavrUvQKi29J4oJFkkXjJscxv7UVproZ0t31LLD3PEYIhbiFZ5JhgqxazQJ2uPduEdB
 lXUbmpaSjdgYwGFMBeRK9nru4dzDvtuR6F5hY/m7tAMJrv/5Y5MC4S5le88INETWD0ljxCXWRhd
 jWMmXT/MVqZKINxKipFrC97tYvVSZST46yQaHu/jsuUWjU49cfSoR7/F0ECAovbEN3OtPTH3JAL
 5Kvkvjh6hVkgupO7nBCrcNxuRg3lkpXWnmlK93Sf6UZ361YBHJbGU4OW+I2Q0Fq6vqA79G9tCFY
 PhCZlV9qKQPndzLoxbSyHlsXhBt6YX3tBCK1pHFBQqNmsEATyA/63cNq8Wvlu5McOGrK8znzyM4
 72ANK2OAFqw==
X-Received: by 2002:a17:907:9210:b0:c43:f1ab:167c with SMTP id
 a640c23a62f3a-c4d351b6347mr372679766b.1.1794036243055; 
 Fri, 06 Nov 2026 23:24:03 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ea8csm130129166b.22.2026.11.06.23.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:24:02 -0800 (PST)
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
Subject: [PATCH v11 20/30] usb: gadget: fix up the function drivers after the
 resync
Date: Sat,  7 Nov 2026 08:22:14 +0100
Message-ID: <20261107072224.3492260-21-anders.roxell@linaro.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adapt the gadget function drivers (acm, fastboot, mass_storage, rockusb,
sdp, thor, ether and composite) to the new gadget API.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/composite.c      |  2 +-
 drivers/usb/gadget/ether.c          | 21 ++++++++++++++-------
 drivers/usb/gadget/f_acm.c          | 20 +++++++++++---------
 drivers/usb/gadget/f_fastboot.c     | 10 +++++-----
 drivers/usb/gadget/f_mass_storage.c |  5 ++++-
 drivers/usb/gadget/f_rockusb.c      | 11 ++++++-----
 drivers/usb/gadget/f_sdp.c          | 12 ++++++++----
 drivers/usb/gadget/f_thor.c         | 19 +++++++++----------
 8 files changed, 58 insertions(+), 42 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 04b85419931e..060788419553 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -833,7 +833,7 @@ static int bos_desc(struct usb_composite_dev *cdev)
 
 		/* Get Controller configuration */
 		if (cdev->gadget->ops->get_config_params) {
-			cdev->gadget->ops->get_config_params(
+			cdev->gadget->ops->get_config_params(cdev->gadget,
 				&dcd_config_params);
 		} else {
 			dcd_config_params.bU1devExitLat =
diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
index 7973927e8a7f..13a20441419d 100644
--- a/drivers/usb/gadget/ether.c
+++ b/drivers/usb/gadget/ether.c
@@ -925,8 +925,9 @@ set_ether_config(struct eth_dev *dev, gfp_t gfp_flags)
 		dev->status = ep_desc(gadget, &hs_status_desc,
 						&fs_status_desc);
 		dev->status_ep->driver_data = dev;
+		dev->status_ep->desc = dev->status;
 
-		result = usb_ep_enable(dev->status_ep, dev->status);
+		result = usb_ep_enable(dev->status_ep);
 		if (result != 0) {
 			debug("enable %s --> %d\n",
 				dev->status_ep->name, result);
@@ -951,14 +952,16 @@ set_ether_config(struct eth_dev *dev, gfp_t gfp_flags)
 	 * from REMOTE_NDIS_HALT_MSG, reset from REMOTE_NDIS_RESET_MSG.
 	 */
 	if (!cdc_active(dev)) {
-		result = usb_ep_enable(dev->in_ep, dev->in);
+		dev->in_ep->desc = dev->in;
+		result = usb_ep_enable(dev->in_ep);
 		if (result != 0) {
 			debug("enable %s --> %d\n",
 				dev->in_ep->name, result);
 			goto done;
 		}
 
-		result = usb_ep_enable(dev->out_ep, dev->out);
+		dev->out_ep->desc = dev->out;
+		result = usb_ep_enable(dev->out_ep);
 		if (result != 0) {
 			debug("enable %s --> %d\n",
 				dev->out_ep->name, result);
@@ -1156,7 +1159,8 @@ static void issue_start_status(struct eth_dev *dev)
 	 * FIXME iff req->context != null just dequeue it
 	 */
 	usb_ep_disable(dev->status_ep);
-	usb_ep_enable(dev->status_ep, dev->status);
+	dev->status_ep->desc = dev->status;
+	usb_ep_enable(dev->status_ep);
 
 	/*
 	 * 3.8.1 says to issue first NETWORK_CONNECTION, then
@@ -1314,7 +1318,8 @@ eth_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 				break;
 			if (dev->status) {
 				usb_ep_disable(dev->status_ep);
-				usb_ep_enable(dev->status_ep, dev->status);
+				dev->status_ep->desc = dev->status;
+				usb_ep_enable(dev->status_ep);
 			}
 
 			value = 0;
@@ -1333,8 +1338,10 @@ eth_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			if (wValue == 1) {
 				if (!cdc_active(dev))
 					break;
-				usb_ep_enable(dev->in_ep, dev->in);
-				usb_ep_enable(dev->out_ep, dev->out);
+				dev->in_ep->desc = dev->in;
+				usb_ep_enable(dev->in_ep);
+				dev->out_ep->desc = dev->out;
+				usb_ep_enable(dev->out_ep);
 				dev->cdc_filter = DEFAULT_FILTER;
 				if (dev->status)
 					issue_start_status(dev);
diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
index 2ea54dfbe695..7dfac3d7ae01 100644
--- a/drivers/usb/gadget/f_acm.c
+++ b/drivers/usb/gadget/f_acm.c
@@ -328,20 +328,20 @@ static struct usb_request *acm_start_ep(struct usb_ep *ep, void *complete_cb,
 
 static int acm_start_data(struct f_acm *f_acm, struct usb_gadget *gadget)
 {
-	const struct usb_endpoint_descriptor *d;
 	int ret;
 
 	/* EP IN */
-	d = ep_desc(gadget, &acm_hs_in_desc, &acm_fs_in_desc);
-	ret = usb_ep_enable(f_acm->ep_in, d);
+	f_acm->ep_in->desc = ep_desc(gadget, &acm_hs_in_desc, &acm_fs_in_desc);
+	ret = usb_ep_enable(f_acm->ep_in);
 	if (ret)
 		return ret;
 
 	f_acm->req_in = acm_start_ep(f_acm->ep_in, acm_tx_complete, f_acm);
 
 	/* EP OUT */
-	d = ep_desc(gadget, &acm_hs_out_desc, &acm_fs_out_desc);
-	ret = usb_ep_enable(f_acm->ep_out, d);
+	f_acm->ep_out->desc = ep_desc(gadget, &acm_hs_out_desc,
+				      &acm_fs_out_desc);
+	ret = usb_ep_enable(f_acm->ep_out);
 	if (ret)
 		return ret;
 
@@ -357,12 +357,11 @@ static int acm_start_data(struct f_acm *f_acm, struct usb_gadget *gadget)
 
 static int acm_start_ctrl(struct f_acm *f_acm, struct usb_gadget *gadget)
 {
-	const struct usb_endpoint_descriptor *d;
-
 	usb_ep_disable(f_acm->ep_notify);
 
-	d = ep_desc(gadget, &acm_hs_notify_desc, &acm_fs_notify_desc);
-	usb_ep_enable(f_acm->ep_notify, d);
+	f_acm->ep_notify->desc = ep_desc(gadget, &acm_hs_notify_desc,
+					 &acm_fs_notify_desc);
+	usb_ep_enable(f_acm->ep_notify);
 
 	acm_start_ep(f_acm->ep_notify, acm_notify_complete, f_acm);
 
@@ -457,6 +456,9 @@ static void acm_disable(struct usb_function *f)
 	usb_ep_disable(f_acm->ep_out);
 	usb_ep_disable(f_acm->ep_in);
 	usb_ep_disable(f_acm->ep_notify);
+	f_acm->ep_out->desc = NULL;
+	f_acm->ep_in->desc = NULL;
+	f_acm->ep_notify->desc = NULL;
 
 	if (f_acm->req_out) {
 		free(f_acm->req_out->buf);
diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
index 9a2e98501129..4df2407fb666 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -319,13 +319,13 @@ static int fastboot_set_alt(struct usb_function *f,
 	struct usb_composite_dev *cdev = f->config->cdev;
 	struct usb_gadget *gadget = cdev->gadget;
 	struct f_fastboot *f_fb = func_to_fastboot(f);
-	const struct usb_endpoint_descriptor *d;
 
 	debug("%s: func: %s intf: %d alt: %d\n",
 	      __func__, f->name, interface, alt);
 
-	d = fb_ep_desc(gadget, &fs_ep_out, &hs_ep_out, &ss_ep_out);
-	ret = usb_ep_enable(f_fb->out_ep, d);
+	f_fb->out_ep->desc = fb_ep_desc(gadget, &fs_ep_out, &hs_ep_out,
+					&ss_ep_out);
+	ret = usb_ep_enable(f_fb->out_ep);
 	if (ret) {
 		puts("failed to enable out ep\n");
 		return ret;
@@ -339,8 +339,8 @@ static int fastboot_set_alt(struct usb_function *f,
 	}
 	f_fb->out_req->complete = rx_handler_command;
 
-	d = fb_ep_desc(gadget, &fs_ep_in, &hs_ep_in, &ss_ep_in);
-	ret = usb_ep_enable(f_fb->in_ep, d);
+	f_fb->in_ep->desc = fb_ep_desc(gadget, &fs_ep_in, &hs_ep_in, &ss_ep_in);
+	ret = usb_ep_enable(f_fb->in_ep);
 	if (ret) {
 		puts("failed to enable in ep\n");
 		goto err;
diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index 20c094b0d96f..62b27b0b4090 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -2154,7 +2154,8 @@ static int enable_endpoint(struct fsg_common *common, struct usb_ep *ep,
 	int	rc;
 
 	ep->driver_data = common;
-	rc = usb_ep_enable(ep, d);
+	ep->desc = d;
+	rc = usb_ep_enable(ep);
 	if (rc)
 		ERROR(common, "can't enable %s, result %d\n", ep->name, rc);
 	return rc;
@@ -2201,10 +2202,12 @@ reset:
 		/* Disable the endpoints */
 		if (fsg->bulk_in_enabled) {
 			usb_ep_disable(fsg->bulk_in);
+			fsg->bulk_in->desc = NULL;
 			fsg->bulk_in_enabled = 0;
 		}
 		if (fsg->bulk_out_enabled) {
 			usb_ep_disable(fsg->bulk_out);
+			fsg->bulk_out->desc = NULL;
 			fsg->bulk_out_enabled = 0;
 		}
 
diff --git a/drivers/usb/gadget/f_rockusb.c b/drivers/usb/gadget/f_rockusb.c
index 77a89b47d990..60074109a4a7 100644
--- a/drivers/usb/gadget/f_rockusb.c
+++ b/drivers/usb/gadget/f_rockusb.c
@@ -203,6 +203,8 @@ static void rockusb_disable(struct usb_function *f)
 
 	usb_ep_disable(f_rkusb->out_ep);
 	usb_ep_disable(f_rkusb->in_ep);
+	f_rkusb->out_ep->desc = NULL;
+	f_rkusb->in_ep->desc = NULL;
 
 	if (f_rkusb->out_req) {
 		free(f_rkusb->out_req->buf);
@@ -247,13 +249,12 @@ static int rockusb_set_alt(struct usb_function *f, unsigned int interface,
 	struct usb_composite_dev *cdev = f->config->cdev;
 	struct usb_gadget *gadget = cdev->gadget;
 	struct f_rockusb *f_rkusb = func_to_rockusb(f);
-	const struct usb_endpoint_descriptor *d;
 
 	debug("%s: func: %s intf: %d alt: %d\n",
 	      __func__, f->name, interface, alt);
 
-	d = rkusb_ep_desc(gadget, &fs_ep_out, &hs_ep_out);
-	ret = usb_ep_enable(f_rkusb->out_ep, d);
+	f_rkusb->out_ep->desc = rkusb_ep_desc(gadget, &fs_ep_out, &hs_ep_out);
+	ret = usb_ep_enable(f_rkusb->out_ep);
 	if (ret) {
 		printf("failed to enable out ep\n");
 		return ret;
@@ -267,8 +268,8 @@ static int rockusb_set_alt(struct usb_function *f, unsigned int interface,
 	}
 	f_rkusb->out_req->complete = rx_handler_command;
 
-	d = rkusb_ep_desc(gadget, &fs_ep_in, &hs_ep_in);
-	ret = usb_ep_enable(f_rkusb->in_ep, d);
+	f_rkusb->in_ep->desc = rkusb_ep_desc(gadget, &fs_ep_in, &hs_ep_in);
+	ret = usb_ep_enable(f_rkusb->in_ep);
 	if (ret) {
 		printf("failed to enable in ep\n");
 		goto err;
diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index cd2c282247ac..ed9d16f63673 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -625,12 +625,14 @@ static int sdp_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 	debug("%s: intf: %d alt: %d\n", __func__, intf, alt);
 
 	if (gadget_is_dualspeed(gadget) && gadget->speed == USB_SPEED_HIGH) {
-		result = usb_ep_enable(sdp->in_ep, &in_hs_desc);
-		result |= usb_ep_enable(sdp->out_ep, &out_hs_desc);
+		sdp->in_ep->desc = &in_hs_desc;
+		sdp->out_ep->desc = &out_hs_desc;
 	} else {
-		result = usb_ep_enable(sdp->in_ep, &in_desc);
-		result |= usb_ep_enable(sdp->out_ep, &out_desc);
+		sdp->in_ep->desc = &in_desc;
+		sdp->out_ep->desc = &out_desc;
 	}
+	result = usb_ep_enable(sdp->in_ep);
+	result |= usb_ep_enable(sdp->out_ep);
 	if (result)
 		return result;
 
@@ -662,6 +664,8 @@ static void sdp_disable(struct usb_function *f)
 
 	usb_ep_disable(sdp->in_ep);
 	usb_ep_disable(sdp->out_ep);
+	sdp->in_ep->desc = NULL;
+	sdp->out_ep->desc = NULL;
 
 	if (sdp->in_req) {
 		free(sdp->in_req->buf);
diff --git a/drivers/usb/gadget/f_thor.c b/drivers/usb/gadget/f_thor.c
index 540b9f882378..210537d51e92 100644
--- a/drivers/usb/gadget/f_thor.c
+++ b/drivers/usb/gadget/f_thor.c
@@ -909,16 +909,15 @@ static int thor_eps_setup(struct usb_function *f)
 	struct usb_composite_dev *cdev = f->config->cdev;
 	struct usb_gadget *gadget = cdev->gadget;
 	struct thor_dev *dev = thor_func->dev;
-	struct usb_endpoint_descriptor *d;
 	struct usb_request *req;
 	struct usb_ep *ep;
 	int result;
 
 	ep = dev->in_ep;
-	d = ep_desc(gadget, &hs_in_desc, &fs_in_desc);
-	debug("(d)bEndpointAddress: 0x%x\n", d->bEndpointAddress);
+	ep->desc = ep_desc(gadget, &hs_in_desc, &fs_in_desc);
+	debug("(d)bEndpointAddress: 0x%x\n", ep->desc->bEndpointAddress);
 
-	result = usb_ep_enable(ep, d);
+	result = usb_ep_enable(ep);
 	if (result)
 		goto err;
 
@@ -933,10 +932,10 @@ static int thor_eps_setup(struct usb_function *f)
 	req->complete = thor_rx_tx_complete;
 	dev->in_req = req;
 	ep = dev->out_ep;
-	d = ep_desc(gadget, &hs_out_desc, &fs_out_desc);
-	debug("(d)bEndpointAddress: 0x%x\n", d->bEndpointAddress);
+	ep->desc = ep_desc(gadget, &hs_out_desc, &fs_out_desc);
+	debug("(d)bEndpointAddress: 0x%x\n", ep->desc->bEndpointAddress);
 
-	result = usb_ep_enable(ep, d);
+	result = usb_ep_enable(ep);
 	if (result)
 		goto err_free_in_req;
 
@@ -951,10 +950,10 @@ static int thor_eps_setup(struct usb_function *f)
 	dev->out_req = req;
 	/* ACM control EP */
 	ep = dev->int_ep;
-	d = ep_desc(gadget, &hs_int_desc, &fs_int_desc);
-	debug("(d)bEndpointAddress: 0x%x\n", d->bEndpointAddress);
+	ep->desc = ep_desc(gadget, &hs_int_desc, &fs_int_desc);
+	debug("(d)bEndpointAddress: 0x%x\n", ep->desc->bEndpointAddress);
 
-	result = usb_ep_enable(ep, d);
+	result = usb_ep_enable(ep);
 	if (result)
 		goto err;
 
-- 
2.53.0

