Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FF3606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U9TMRD7l;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Y0dA91N0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C40660EDB;
	Sat, 21 Nov 2026 13:15:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UXP4GcxmWZza; Sat, 21 Nov 2026 13:15:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B1B8360780
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266893;
	b=AlRpBJoErJeaGgmTU8QBfiL4sPND4LZeZvPiyiQvMFHf2jro5d+0kXJv8vH9JXQLp8a2
	 Zf72pnPgLL4zuqQQpfhDywQMn/mm7yhFWYlV6Q4Hp6wBeBxT/M4V6lHBjws0JjhiKHljA
	 kROMxg3mr85JZgIcmtterZyvg1dgaGKOlGSaYbBgkAePYXUU5Ambx3duVYj1fKaVyNiWl
	 kIZnwIZaKkJNCKd03Vj0BQlOQUwNjGzlKuJSNb8kcZ/O37buY8Tl9Yrj+Ps125LQ9OQX/
	 IvbCvgcc9BVo7kHmDeVpKU/dVtOjKuw53r7/FpgNsO7d6fGzKhU4NZYqy0rru8qvojw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266893;
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
	b=GaB88SPgljVUo/JSfu17l/l8llWCSruq7yQ3+ZouCCxk0dVNuJmekZlXli7Oshlsn/CO
	 QoKoTK6z0U86aBIbJGsXpX7JONw+zRs/vtwgNpivBAsIAZ5nKxAG0FwyTXw8g46QjZ+ac
	 DmWiWtI0hCRp2CYuZrgryrH13si7Fy+ZS8wLPrGbcSqzjJb9Hejm1s70ZwWXmlWU8qnDp
	 net9v6/kRfaz+7C67pEQMNF9dJn9Fgb5KyWk2plutXN2GQ3+Es/81l6qf42Wubn0tLQwO
	 EwDiwnTzgJZkvesqzmUYJssDiktdEeFeM/t4Jc42oe3XZEnwK8Q/Hy+dOyEUEvJk3BQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266893;
	bh=m74K57aRohJYqYLJOZz3SHbV1NLzrx7im5oYCzLZJWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U9TMRD7lg7q+DUKNCfdFRCJZpIWRSdPtmbrrUYpNC7SU41W7DG6Al505N1/qkJfd+
	 nsyu2qds3b9Xb9bFuWLuzyT7o0vkYP07B5Av7oFJ7pL+Jlx+ZZJefg+uUfbSKDFDYL
	 rAClSfH+gCFzWGUNv44eEfgF0vf3JDL2I1VbChyzm9BiI6r4RAoropST4TWVH9nmW7
	 Esi68wKhpd1vYplAtIXO5RZ6fW8HHIFto0fy3N7rAiNQgL7Mi8EobmFtc63KregW7Z
	 nFYtttJHtfIQ7ZkK5tLiDEkCWcZ9j++TjYoGv7mFhG5sIkn5cyoX0Nf1jlj9reCA63
	 XNikIyG4Z2nog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1B8360780;
	Sat, 21 Nov 2026 13:14:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A4D8C15D
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 96B0581404
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sqaFynH7Trte for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:55:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8E89581403
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Y0dA91N0
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E89581403
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:37 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c4cd28978b8so16501266b.3
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262136; x=1795866936;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m74K57aRohJYqYLJOZz3SHbV1NLzrx7im5oYCzLZJWA=;
 b=Y0dA91N0YVjUR3qTsx+e3EN3DkEL0u2Q41byPCiPaQE03rOCZa7VMqC0EhifzvwiiO
 9dRVbtAyCyVlziB7cWppshg8kHe8fSj1CvpEjihlvALBltLjOGRERS7ktGW/L8NVyXuk
 SpRNERBiLMshygSefXBrD432H45UV5FIH5fX+5aedCEy2RZ5jdZxEBW5ohoAdRPSKeUP
 AvFPRgRhCn+YgxbB9fbPYVX38IxKAzy8uKyOSr22m8o9wjcLmWcWFsIgFpesrPau95g9
 HqGXD7y8X2A4Wh1QC13gIu+OEalYS5MqdiICRYkGhVujVnNGRQxLTlVQ7Y6qfPc/FSwA
 1q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262136; x=1795866936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m74K57aRohJYqYLJOZz3SHbV1NLzrx7im5oYCzLZJWA=;
 b=JhqaG4jQobCygaIE/H6XC1I41qngRovwPnI8lhs89UOKBOjl2ZFoN+naPIwA+CJnzC
 kR6lkerwVNR7Wn1d+AcyP866qhGptSww6BvJfuhHcVZUbREAsS0ikTcjqkcW6CdE9GpC
 Txb+DitwTn0UyEB4ZEZIlVbXbwvNPBFdnmpse3m9HpOa4OiTg8R+hdHL57w8ElBm3+hQ
 b2vMz2PPYqDClHg17WF2ABRNP079jVThxqbpBsdlrgTgyiRfVf2YdlyNAk/4tBOEIcKb
 CqCplbGRijoDCAyMbt2u/YUtVq2UbvlqcAs9ghz+aHPQR50hcdznmxmZZo5iiD73D7kg
 iUFA==
X-Gm-Message-State: APuU4Z98/waBaYKer1sQGKhLusoi23stWPBafAzAoJK3TbENDsMKpeV7
 UqKhDpql8KQMQKi4H7+3HpcNShwvqrY5vk1hf33xbY2duwQbMBAELP2U0RlMKAzyRny+3fTygNk
 RYYrO
X-Gm-Gg: AZFdTZdAvnK33BrWJrs7Jze+6TGTheenRqwFE3Fh3qcTmi077RVjykwW64jn2XETIh+
 Tua3MWRYu2ps2Xh4fhHnA7pFpSegbKECV20/tU3yPLmmkMJJmE3vatwvuWDPym2ZdnAhykkRHB+
 9chD1jXyEQhRdnyYjthx7YyjWDMbcxwvmdWXEhf7c1fvIemR4DqazXjrP73KiZ4FvgmwbiBYaxr
 GvABMg4PpMHj2JoSbY8LkUV3NVdBEXbGOmDlOgJcm+upEDEtiu7xIWdSOfNd1pKVElRDzZw1ORf
 PZ4IIrcgl8NzQch+CavLjVySUyWKn/XixC6phfaHXw2IAs1ikco+ZCZovkerXZVyCoe10dvImjV
 alPNvzPT83qaQ3HoSM0CiCie36QRVkj5bi1MTPySD3EWdYreOddbk8S7DQ5FqcM3GpSXYQLvojG
 2K6cyrA7zNdMHvtdX2ArcPxO58LcIPG09+GIXe/H/hTrib1KOA8F6vVrG6XRNuSPw4RKQYpUOUI
 4tYQgxwOEJtevCDGr6bEg6Hp0pRL/UwKRJnW7dBmMauDmF/SyWNEMqIG2dns6WIIV51yHR/c0Gg
 NCGdvrRM+QWZJm0M1VoQvjCqeWR/dED0cavUvgu0bR7SHou1LYqUhwRfvEGxtNIf+oJKgR67htA
 HFBGKM/50jQ==
X-Received: by 2002:a17:907:e83:b0:c50:a6c8:2606 with SMTP id
 a640c23a62f3a-c513a1cf79fmr539909266b.0.1795262135802; 
 Sat, 21 Nov 2026 03:55:35 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6780esm194960466b.17.2026.11.21.03.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:55:35 -0800 (PST)
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
Subject: [PATCH v12 22/31] usb: gadget: at91_udc: register with udc-core
Date: Sat, 21 Nov 2026 12:53:26 +0100
Message-ID: <20261121115335.548142-23-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121115335.548142-1-anders.roxell@linaro.org>
References: <20261121115335.548142-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Nov 2026 13:14:06 +0000
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

