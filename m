Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130E3606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Kp4BlJ9x;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MSpZP/6A
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBEE2815FE;
	Sat,  7 Nov 2026 12:50:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3tIGtyrjqJmt; Sat,  7 Nov 2026 12:50:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6854D81662
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055839;
	b=QdvK25VXMv2vbJth9moWvUjViFz4USz58HpfscSrU/Xc/LsfQUKwIRuZMGHJONshhqi0
	 i0j3eaq8sPm0zpSGoJF08VzBjZgr9J6N8umOSj5N7SBy3GED/XTjaIPo22PHGDjti9QXR
	 VFfP89BYRg3fPOLLHKJ37WJubNQ9Jyx0xDEChGDSEzcZ53MQ7cfLCft4vlCeFQ998nXLR
	 CfJdiNcTbLDwfEwxUCsi2eM7eqIHcjOGtn2vTV3AL0DsGCnyp6Iug5W5bAzJm1bKlrcKe
	 bOSKExNFjO2SCj38+9IFZHNhHqZdm+/BofKnEDbrENZMuhyeVF1XNtEfEtewbkjnJTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055839;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CNEFQ/UI5gfCATLRQ0FzKymNRknlobe6IRuUxFmapyc=;
	b=SPfGIt7wGs/fh+dlDdOj5LEXI/4zyJ+m9qPIfnyMMYOC/J/7uYCFWZwz1ghZi+LRA6JZ
	 xWMaJcAiLMfiQkKDqZNgyUWb0dW2k73XzEb2ch5Zc62xDufYpvAtu5L/9vq9PsM6LSkVl
	 fw5HgU69p6dS2vz5h/vwovxxBHNx9yXQkxNnoEXpLV5+OtxkSnmoHIq6rMXW7Yorcfuo6
	 lxEhgs0vV20MEDJZqacepT0yWWcxWjGYm3+XvErTQZL+DZArRgGXSIixHN3O1q2ecoFY9
	 7Qx/UzjOzxTkstnPpBS2LHw+YHI/h4vVlDP6IHiCQOrJQsrm98OyFONvTOWJhrjv/LQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="MSpZP/6A";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055839;
	bh=CNEFQ/UI5gfCATLRQ0FzKymNRknlobe6IRuUxFmapyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kp4BlJ9x28m6DJpPziXDzXxeTQdv0n4kx2PnAWbUvH9jPcs5K/zE8P05g2xl79+GO
	 sjcmQWW6orCUqLYp1ym1GwhTfO04pdXe+TbW9h+WbqOnvDV7/EPDpF4N0xxunl49ku
	 7Y/6iXPNmYZG08Bg6YArAK8+cRvQAOpso0+DITXdBsjvIp7lBg8BDW7Qj3VoN1IpwY
	 Xod9qaJomeP9puTB3yGzvM3CKBdEjs0fIFrdaMWB4XSOSFBv5ez0M97/Bcz9EYmI0v
	 MQ6TSEs0F3IS/olKe72fD7T/AlEsxelvsIB40pUen92N5Yq/TZC0s6VFkwXfwc3SRK
	 Ji8aiNvmWwunQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6854D81662;
	Sat,  7 Nov 2026 12:50:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 41C7F31F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 336A1811B9
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EEFi1u7tle4B for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:24:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2048D811BF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=MSpZP/6A
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2048D811BF
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:10 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b5785aea56so228385a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036249; x=1794641049;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CNEFQ/UI5gfCATLRQ0FzKymNRknlobe6IRuUxFmapyc=;
 b=MSpZP/6AYiyscoJTlvD2nRBEqgu91hh5FrrTwFvalVTIsRSFghe8K3y3g2mo8pfchy
 tkEZru/wyTrOg2j2yBwAO2A5vJUXeNwFhAhQ9V8xFEy2Yjdq2MyEnlLsJEpkFUq5hgLe
 nTLdGDfctBhoPkEiO3/lY8egTjCMH1X7grbsoMUDusnQwdAw3TA38LagAgWxBBPD63Rd
 K7QIR6SV0y2YpylhYev5xG00Pz3WEuyGT+qKp07m/gn6jlpalO3E778dGwVtLLb/NzWK
 yysSzlNGQlbgADhbwyWXTaUhoKES6C/zPXHOyfxIJbflHw+fT8yzL25Z2NyO1ZjM6Zd6
 pWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036249; x=1794641049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CNEFQ/UI5gfCATLRQ0FzKymNRknlobe6IRuUxFmapyc=;
 b=BBfvxARtwTdwfRTbTejGvmw1TPx0KdF8anMGuHG6V+skOrzOzDrt6j/0MQCWPU7nRs
 C6w51Tn6wCu5hD+/cd5+NLYgF+mcOk15K9La2ZbgHeqzwP6loB/k5CVWPe3BdZbL0DQ0
 4pWVqnGzw+XPLvUeAoSYNOhTlDW5uzcAKUrjlb47zPQ4B691uGwD74XQ1m1NHYUAOVTu
 wfz0grktgjIFdJTHI2uGgHhbjNUuSVEVi7w1xKMGRUsOWmatlfX5vIOhyo9KgNBlMDNj
 E5808MYo81XVi4/cRc9KwxzQBPU2ylPNhXviZxzJCZgEtjLQntZ4GWvskk6TSG42icyT
 c6bw==
X-Gm-Message-State: APuU4Z/V7f7oBYWFc/GlxIBKTCrHMErz7nJzbT6c10ef+y6I1eg+mU7H
 Htq2yQO0rtDBv64nUVisLblcdwS3XqvxrK0V9k/IJpLuMt/GCAEXDe5yObpTgFqyqMh8vdv8tcn
 8296+
X-Gm-Gg: AYBFou1gAgKQQ1kv6xnSmaIFGukst7W/kYApAf88LdiXwUe4haw7PYejojLMMShrLPj
 OIXhztIVVsPFBpv94jNjxGrbYJ5eMNiY5fIoiwNrrCeFTBKHLw/joUBdfky8j+hN9RINBgnvJ9c
 fxjMBf+N34MFpMTKMxb2CG1PTiGxe6c/Xf4L+Tk+SEpN6hJviaYuKAoz/xGdXaMwwl4PDGCAeBN
 RqUnWm9GZjXBOzekOYrZ1Zvwa5o0A8eHWbQXn8jcVU8duJM81Mi3Ar1JtrXSMZSWYWRKk3vxxCf
 8sHYEwECg9Rm4GEjUJih657w78Oy+3XxZs9QKEo7c9CY6qM71sxDDy/WYxEnI5oTAl3gWSje6au
 U+Yi/Dx1ACtcqt5VaZfkORWK3PDVPUnH4LYHCX5EFySnfAXfK6dsp9BJaSLVb/gzXoUOr5O7LRM
 2co7QfFYHB2cDloQqFp4eBZpYABep0F00X5+lqFEP0lDFjWpWo8bDgmwRNYN7S6sOYsXQdC8EwU
 MDJeRh/TegEsea1YRlTAUTCXZErA2HCt57ZhfdOixsYjQwpDGBPg29yXMnJfJgjCgr1+aD+peTT
 MUrphLZl7m3BH5clLkmW9/Oa3j/Zt4VFg5moGV/bi3x0Twy34LIOvE91AfADdY9ospmVV1NDIGn
 HuNaVhP6f81gKtP9ya1z4gMLg4qGE3Mg=
X-Received: by 2002:a17:906:a255:b0:c4d:1768:48eb with SMTP id
 a640c23a62f3a-c4d34c5a0bfmr424213366b.2.1794036248614; 
 Fri, 06 Nov 2026 23:24:08 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ea8csm130129166b.22.2026.11.06.23.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:24:08 -0800 (PST)
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
Subject: [PATCH v11 25/30] usb: musb-new: fix up after the resync
Date: Sat,  7 Nov 2026 08:22:19 +0100
Message-ID: <20261107072224.3492260-26-anders.roxell@linaro.org>
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

Adapt the musb-new gadget code to the new gadget API. udc-core has its
own usb_gadget_register_driver() now, so drop the local ones.

Without DM_USB_GADGET nothing adds the musb gadget to udc-core, since
the usb_add_gadget_udc() call in musb_gadget_setup() is not built in
U-Boot. Add it in musb_register(). Otherwise the sunxi boards and the
other non-DM users get "No UDC available".

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/musb-new/musb_gadget_ep0.c | 24 ++++--------
 drivers/usb/musb-new/musb_uboot.c      | 51 ++++++--------------------
 2 files changed, 20 insertions(+), 55 deletions(-)

diff --git a/drivers/usb/musb-new/musb_gadget_ep0.c b/drivers/usb/musb-new/musb_gadget_ep0.c
index 25b1de6e58f9..726864aa7979 100644
--- a/drivers/usb/musb-new/musb_gadget_ep0.c
+++ b/drivers/usb/musb-new/musb_gadget_ep0.c
@@ -320,51 +320,43 @@ __acquires(musb->lock)
 						goto stall;
 
 					switch (ctrlrequest->wIndex >> 8) {
-					case 1:
-						pr_debug("TEST_J\n");
-						/* TEST_J */
+					case USB_TEST_J:
+						pr_debug("USB_TEST_J\n");
 						musb->test_mode_nr =
 							MUSB_TEST_J;
 						break;
-					case 2:
-						/* TEST_K */
-						pr_debug("TEST_K\n");
+					case USB_TEST_K:
+						pr_debug("USB_TEST_K\n");
 						musb->test_mode_nr =
 							MUSB_TEST_K;
 						break;
-					case 3:
-						/* TEST_SE0_NAK */
-						pr_debug("TEST_SE0_NAK\n");
+					case USB_TEST_SE0_NAK:
+						pr_debug("USB_TEST_SE0_NAK\n");
 						musb->test_mode_nr =
 							MUSB_TEST_SE0_NAK;
 						break;
-					case 4:
-						/* TEST_PACKET */
-						pr_debug("TEST_PACKET\n");
+					case USB_TEST_PACKET:
+						pr_debug("USB_TEST_PACKET\n");
 						musb->test_mode_nr =
 							MUSB_TEST_PACKET;
 						break;
 
 					case 0xc0:
-						/* TEST_FORCE_HS */
 						pr_debug("TEST_FORCE_HS\n");
 						musb->test_mode_nr =
 							MUSB_TEST_FORCE_HS;
 						break;
 					case 0xc1:
-						/* TEST_FORCE_FS */
 						pr_debug("TEST_FORCE_FS\n");
 						musb->test_mode_nr =
 							MUSB_TEST_FORCE_FS;
 						break;
 					case 0xc2:
-						/* TEST_FIFO_ACCESS */
 						pr_debug("TEST_FIFO_ACCESS\n");
 						musb->test_mode_nr =
 							MUSB_TEST_FIFO_ACCESS;
 						break;
 					case 0xc3:
-						/* TEST_FORCE_HOST */
 						pr_debug("TEST_FORCE_HOST\n");
 						musb->test_mode_nr =
 							MUSB_TEST_FORCE_HOST;
diff --git a/drivers/usb/musb-new/musb_uboot.c b/drivers/usb/musb-new/musb_uboot.c
index 43ab3245e5c3..2da9f6cdf018 100644
--- a/drivers/usb/musb-new/musb_uboot.c
+++ b/drivers/usb/musb-new/musb_uboot.c
@@ -383,45 +383,6 @@ int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 
 	return gadget->isr(0, gadget);
 }
-
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
-{
-	int ret;
-
-	if (!driver || driver->speed < USB_SPEED_FULL || !driver->bind ||
-	    !driver->setup) {
-		printf("bad parameter.\n");
-		return -EINVAL;
-	}
-
-	if (!gadget) {
-		printf("Controller uninitialized\n");
-		return -ENXIO;
-	}
-
-	ret = musb_gadget_start(&gadget->g, driver);
-	if (ret < 0) {
-		printf("gadget_start failed with %d\n", ret);
-		return ret;
-	}
-
-	ret = driver->bind(&gadget->g);
-	if (ret < 0) {
-		printf("bind failed with %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
-{
-	if (driver->disconnect)
-		driver->disconnect(&gadget->g);
-	if (driver->unbind)
-		driver->unbind(&gadget->g);
-	return 0;
-}
 #endif /* CONFIG_USB_MUSB_GADGET */
 
 struct musb *musb_register(struct musb_hdrc_platform_data *plat, void *bdata,
@@ -450,5 +411,17 @@ struct musb *musb_register(struct musb_hdrc_platform_data *plat, void *bdata,
 		return ERR_CAST(*musbp);
 	}
 
+#if defined(CONFIG_USB_MUSB_GADGET) && !CONFIG_IS_ENABLED(DM_USB_GADGET)
+	if (plat->mode == MUSB_PERIPHERAL) {
+		int ret;
+
+		ret = usb_add_gadget_udc((struct device *)bdata, &gadget->g);
+		if (ret) {
+			printf("Failed to register the gadget\n");
+			return ERR_PTR(ret);
+		}
+	}
+#endif
+
 	return *musbp;
 }
-- 
2.53.0

