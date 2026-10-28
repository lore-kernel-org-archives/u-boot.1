Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4547D606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z+uEZsBy;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zZ6PgYFh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 062C881583;
	Wed, 28 Oct 2026 14:49:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LP7Wx6QOomGo; Wed, 28 Oct 2026 14:49:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A9067812BF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198906;
	b=ZBKjbTcCtf7WvFvtdcjV1OyyMx1tGOL0gRt/8+T1MjwI7pvWpJNoVZlCj5tOnH6+epV1
	 Sl0AXjhOvYUjv6THYJmIWBfHEMtSiRZmSX0FIVVezAHZSshtsu8iQrlkv58I9HVXh5hK8
	 lsl4CkvBTSkwvmRdAjvFy3eGqvvWDbiGQwADF0B2MP6CVGZcgqV8OtJDCObKw7IX2QGCs
	 SkRidW1W2ELMuZ8nh86To5RtKDEQuNBnfkX+gYqqF9/ss0RklygqNqTOGfP2fODOWHhrG
	 jRhakZKaYm1KOIzLDBCAD/IMsWhUlSHDzu8B4X4FmYpof2E00naeoY0hzs1s2o6SvMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198906;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XTkw99wHhMDKxohNnkz5GeHj5w+F7HqZ+heONCKVieg=;
	b=OQ2ALGUst/q1Ij0Kkk6vHThnh14n2WdyKPLKHdW8WYnHV4eJ3yIfgFVXNs/hwNhi/T3u
	 Zb6q9FRxgEsokTP61604urG5wa1eIYX/JebiMfG2PutcZByO/sf/1cYzzQV2bXoQHwqP5
	 KmfG1e5DZHMlS9L2Ien6pOHGeif85lWG+l84oQcgXicdDDhPSp9DkZ1962kozvu1aG5FF
	 2CsDNMjEicgi2IOBnqmiQGTkjew+aN3TRPeLliXAUH5erL2jVS+R9h9stCWnDrMcLnaFs
	 PsHaeEFrT549tQL07KtF40a2cx1iH68uQq6ZTzZigvjqdvzkbzqefolI6thHdnC53Fw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198905;
	bh=XTkw99wHhMDKxohNnkz5GeHj5w+F7HqZ+heONCKVieg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z+uEZsByyunmMzPDDRhpViEjLDiBcxgJSFg87RrgVfA5u8nAM+Iw/EbTZ4pEu+A0h
	 WasMqvfmiojjpqGCFNkC6cZfZLGOOb1GrZpc6SusWDmCXPMdKj7Z4aMUvDOko1Rthv
	 +eTG29DJDdXEcRNoWYkAbnW7McC+27SDUQC6JoSMSXWLexbVqtWJwMccYCltdcktxM
	 XIoXahN8f1GmIDrJtl5QJH4lZSJikiUAc9FNlMJHW+SdFm58qKF1AASf2vsFZLFNKk
	 S+YEnn/6A15LAMeXASiqg8dciEu1JqkxB6J4cHXjzp/tVC7L4yhleICrYVBjSmsM8T
	 8xv5V4fok6uTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9067812BF;
	Wed, 28 Oct 2026 14:48:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C1E8356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 02033605F1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fDyY-RBoRDqs for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:17:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0EFDB605EB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::633"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793197022;
 b=rUBI18sgWW5aooj3hqcJvP/EPRmV19BtwxC90gOHK1VAAApA8rtfggUE50Lh2SIZ7Dz/
 iYi/N0avlMwfYGbby7m3uXCWdoVlw2HD6qhU/EGFBwCkOH7xxcbidqeG/ikT+lFwxTLjq
 ZcQ1jCs3ZTFiUXtINDTrpoLWWJMKBqog/c3orjZpZgTdqRzj66cGwyt0j1WSnp9psAwyQ
 ixb9GxA7qvSBwefQ6OcLKP26cRQd6LZmiiNOHQ4zNTcQ9MbV5m+R3ENoUvbrZM0eeKI0l
 xLu8DxiD29FNCXxTUfcV/l0tR5/iZXCZ472bEFkCNxocKt00QQxETEnv1tKgq/fRb/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793197022;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=XTkw99wHhMDKxohNnkz5GeHj5w+F7HqZ+heONCKVieg=;
 b=Fo7DZ+KIAIT2kqchGvaOvqtGK+N/Db+pBUgV4NSMFPxJ2HSch9mtq1CNWZZ7IPdSvek8
 zJPycl+bS41gJnRgSUtGrq/Rl1bE1u8qVycSMigve3uvQBP3VOEO4zr8JM19PcjSBYbcY
 jYaVKaHQhAhNXOGx4hFcLsFR+KeLkG53o4uFbqqDKCh0/6VxJd4pZ0WjWM4zsFb4CwmOV
 rkObUeB5S8Tyquh9W4q/FB58ZvcD4fI8mA0P1X9oVhGPdfYp+GY/eoURvWoTR0smkHQvj
 EPew85OKIC0u4fzDUFaXmQKxmjacs9xHMDpeqCr1I26q2xlkSoQ0PiIA0QPkEuyPgQQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=zZ6PgYFh; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::633"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=zZ6PgYFh
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0EFDB605EB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:01 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c499b5be0f1so11859866b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793197020; x=1793801820;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XTkw99wHhMDKxohNnkz5GeHj5w+F7HqZ+heONCKVieg=;
 b=zZ6PgYFhkIFFg2dCvLf5/clMMLVc9okTysVxCob1CUKx4wWrTVKoaZi3JKduh6P3T4
 4asbSPNCzmShZtsV1bamHvrfk9VKGgy3+61xIr7DnPIYVpmPdBruMjKrFra9ng32Jjo1
 KFSls+DUwrUFh8MC25ttvNbzkJft0Avaz7zX4KcllJ3NpPEXR3lOdoUM17XoBJwWbDGB
 OwHyz0ydLxkBZ2v4synU9bu4X2zJlVYPovgFVXwBzxOZH3dduFrSsa/H23lGtRwK4PC7
 vrH10t3kv+UHkoEDaeUvAgyvc4xmPPQsxu0v3hwyBT1md4jz2yR3+ekefzXAFFCxku9F
 IYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197020; x=1793801820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XTkw99wHhMDKxohNnkz5GeHj5w+F7HqZ+heONCKVieg=;
 b=slk0xXHjOUmO5bc23LLtmRggYPwKIWdJ9mJFNlEWVKnJ7vF3MDj7Yp+QVOSHEZOx1/
 MzQhozjm0Z+nr7quMk60pcz4Gf2So90yQhiLdt8+s3InSeaQ3naUApyncQydojqt6/4d
 La8vLbghsg4ftVpOTPevk6UgCaD5S4btmGjATg+k5uwflJdlqPjsdNznxmZEBY81Kewm
 7hv5NeTNZbGXu7ZuqMmWb2knC4zxRm5tOQC2lZ1/zUQllhVuLcbG++ti7Zn/1E5a/K9N
 NfRTsGIMFK9fwHO3r8+EkEFJprEhBgCAPzBCIEDFcb8nZ8UqM1VcEcvmordUM3RVXOWh
 VZEQ==
X-Gm-Message-State: AFq9FYJCzzgCTm5uykMLibj8EAAz7HrISbHA39a8cUmGZaDktXeRl3EW
 U+L4bTgQmtwEsFzsPiWU/NmcMPSr2FkbmYvP5JBklMac02n6mP9kgaywqG1aIjcKUUnMfHRAnxy
 MgpKO
X-Gm-Gg: AYBFou10MU6BcOPrYfcN22WXFYg17oBHWcAtPixiFlp9K2GXrS9hLOA5RtP4/hwIRQU
 8C35laNptoN7UD4xhO5Xw5pZmBi6dTQ1myIIpG5tgF4G76YYdlorup8DjB7Y9UI27rVopmKJFap
 /OysznE0eJY4WqdYI+k7ZBygEkurNEln00L0hMPVBrXUCrjmtC5CLMEFwzlm6f7Us2wvpxrshdf
 1+kn9qUGm8BE7LzFeorBAZurPWfVomh5V4XRbTUC270B10PthvvNNP5uaPpEEPznzbQVrEiWCLP
 2DlsAokAbsR/ELrogWUhLPtKsBjWqJol6Ha+O9/yfu2uvz18ahpE77x04xuI3dICD2ktZPsDbbt
 /LEz+Gkn43zcx5FeqAYEyhVABFmUhvuUl3TCTX9YzNYR/9LTPwGZgFZmxS9HnSaTOZwnnDOO9Hy
 ly6iDqOhDaiBYEEmDzekR+utf1tJhZ3sT1gUSKSYcPKZrkPlU/IAkOtlA3cwF8xO/uNpOpPsgLU
 fETVmTYHedfJwYVhmi7HIFqvquNoU/nerT6SqYD2UBgLldZnJdwRUxxkQifqfj5O3qxSjNcvVEg
 Z6bUz7cCrMTpbHgHhnZ4zSjBoIyX94JNosuM+rrMF0iT07nN9R8J5Slce/OXIGZUcI5ruRsrRjK
 9XqZsbNbiGzo=
X-Received: by 2002:a17:907:4c8:b0:c12:6db4:4bf4 with SMTP id
 a640c23a62f3a-c49bd9fe0e1mr240548466b.0.1793197019539; 
 Wed, 28 Oct 2026 07:16:59 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd524266sm630412866b.38.2026.10.28.07.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:16:58 -0700 (PDT)
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
Subject: [PATCH v10 16/30] usb: gadget: ci_udc: move to the udc-core
 registration
Date: Wed, 28 Oct 2026 15:15:40 +0100
Message-ID: <20261028141554.3073545-17-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141554.3073545-1-anders.roxell@linaro.org>
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:47 +0000
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

udc-core has its own usb_gadget_register_driver() now, so drop the local
one and the matching unregister.

ci_udc has no probe and no board calls into it, so there is nowhere to
call usb_add_gadget_udc() from. Take over the controller and set up the
queue heads from usb_gadget_udc_bringup() instead and let udc-core bind.
Without this udc-core never sees the controller and gadget stops working,
topic_miamilite for example. It still builds, so nothing catches it.

udc-core calls udc_start() when it binds the gadget driver and udc_stop()
when it unbinds. ci_udc had neither, it set controller.driver from its own
register function. Add them and keep that assignment there.

Tested on an i.MX93 board with ums, the host enumerates the SD card as a
USB disk.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/ci_udc.c | 57 ++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 35 deletions(-)

diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index 53796887dac9..87194601f67a 100644
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -94,8 +94,14 @@ static struct usb_request *
 ci_ep_alloc_request(struct usb_ep *ep, unsigned int gfp_flags);
 static void ci_ep_free_request(struct usb_ep *ep, struct usb_request *_req);
 
+static int ci_udc_start(struct usb_gadget *g,
+			struct usb_gadget_driver *driver);
+static int ci_udc_stop(struct usb_gadget *g);
+
 static const struct usb_gadget_ops ci_udc_ops = {
 	.pullup = ci_pullup,
+	.udc_start = ci_udc_start,
+	.udc_stop = ci_udc_stop,
 };
 
 static const struct usb_ep_ops ci_ep_ops = {
@@ -1139,14 +1145,23 @@ static int ci_udc_probe(void)
 	return 0;
 }
 
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+static int ci_udc_start(struct usb_gadget *g, struct usb_gadget_driver *driver)
 {
-	int ret;
+	controller.driver = driver;
 
-	if (!driver)
-		return -EINVAL;
-	if (!driver->bind || !driver->setup || !driver->disconnect)
-		return -EINVAL;
+	return 0;
+}
+
+static int ci_udc_stop(struct usb_gadget *g)
+{
+	controller.driver = NULL;
+
+	return 0;
+}
+
+int usb_gadget_udc_bringup(void)
+{
+	int ret;
 
 #if CONFIG_IS_ENABLED(DM_USB)
 	ret = usb_setup_ehci_gadget(&controller.ctrl);
@@ -1162,35 +1177,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 		return ret;
 	}
 
-	ret = driver->bind(&controller.gadget);
-	if (ret) {
-		DBG("driver->bind() returned %d\n", ret);
-		return ret;
-	}
-	controller.driver = driver;
-
-	return 0;
-}
-
-int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
-{
-	udc_disconnect();
-
-	driver->unbind(&controller.gadget);
-	controller.driver = NULL;
-
-	ci_ep_free_request(&controller.ep[0].ep, &controller.ep0_req->req);
-	free(controller.items_mem);
-	free(controller.epts);
-
-#if CONFIG_IS_ENABLED(DM_USB)
-	usb_remove_ehci_gadget(&controller.ctrl);
-#else
-	usb_lowlevel_stop(0);
-	controller.ctrl = NULL;
-#endif
-
-	return 0;
+	return usb_add_gadget_udc(NULL, &controller.gadget);
 }
 
 bool dfu_usb_get_reset(void)
-- 
2.53.0

