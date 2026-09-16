Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3EEC88E5C
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 13:09:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73ADC6085A;
	Wed, 16 Sep 2026 13:08:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J7PbnvsSY6wo; Wed, 16 Sep 2026 13:08:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 643A460858
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564138;
	b=bepeO69oKmpMbqysZ1DCJZ/OevjlEvUfAnETfmOZagYfc1FWV9wlLJ7y7Lgiewf84V8Q
	 Bg5yIDrEPbUaJJrkhVDK57I2OtrG5cjhu1q3YjoSVE1hyivipOEFgxUrQh3nKfh9M5egh
	 9I3yT/k0yz588X/4zf1IAwBCgYcu2kK+k63pB9CBUlFX5FENZyP+aXBf1IINLHYaZJmc0
	 j1ByTthxa+Pumi+iWuhT5ZIKeZPrfZoHBvDpJqE8KLeySZXz3AU9Dp3WN3I026VKTX81K
	 TMQvLulDLlidUTaOWTbuLZharl7T10iTkMIyY/hnmJAD9EsUdnkWyrV67+EVmoFqBfg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564138;
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
	b=Dcog3w/wrL+qsfrZE3EqFoBkVA846NGr27rrvJf/vICdU8qf6Z31hhfJ7WQEfqSvXIMp
	 ZazTMjeAg23r9Uk6AOpLAEaFZImcfiy6MOHi6gHMX6A7QLeM7xsMxFFRXeFn4x8ZrzXOS
	 8Fngic3FKOIYQVMJgqOnoq7R4lnumA83JXESfXtgxR+/OdQxnOvFL388alawCEtws7XMt
	 /yimBFsg5DngmrKK4c8LBEWHgu2Uwd+FHyH9X8zJCwbHbj7PoUCfa0/ZUJLR/xoCdlg35
	 SusvC54rHSaCKTXTNb4lZ9OgbW4UXekTtXunAjPFlaV/Dlz/lzEMC14jcfcm2ieLEPw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=n1rOOoND;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789564138;
	bh=XTkw99wHhMDKxohNnkz5GeHj5w+F7HqZ+heONCKVieg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aviwXLjfP7LsCrjBJ2y0+rp48JtiKo3omb2E5IbbmTlyTAUl0frAKH2khvMkaNkd1
	 TnKXmHzyqr1aXoIMYfwBsW5K5HlftY9ty+8ZFy//C8ijPFMQKF514Uf5dhd/+eADZD
	 svMZGkCAZU42GetQUpwC4BtDM1XosGqH9MnBpKCADmV91TYakbCodGG9ITIdGfE5Vz
	 HiNsgeYVO9747BFwOQxRuiv8GAseHdweiWoxYfk8MZoYC30MKLDRw6CUl39BPvM78f
	 bv5GsMkHFutVHGkSyUPaYG4qQ9JBv9M0QkOcKDIxS7iIbYvfVAITVDdDZ+qExOj8Sq
	 x5wHfVM6hazaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 643A460858;
	Wed, 16 Sep 2026 13:08:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E0DE829B
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D2808607FC
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yp4o_VqWrtDP for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:40:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C9C5E607D2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789562429;
 b=p9Dlz7akL//d8kY0/n7VRuatprhSoQ6+xNl00XBgZVgnnXC5Ym+sJRL9yo7XI7iMn+/z
 767ByQnqs6f3GxLTQkdke5gbn/gBNdXegxtfX8QMuGl+JCQxE803htSsG7zOxu15VmGTG
 fVcSsf/fnrtM+ln31VO0aVEu6AiBvGzZp0qg3n2u1MmNEkwcZvwBpjqck8SkIrU1l6ynx
 SKTiVVMRmlstsaSDBADdPFF6TgeS6YxZ8l5sLN02He6oGMffEh4Zk2lVSlucigrgBABxj
 T9XuKJAoH59db0X+eG7udlOJm5sdizS0ebC0klrfocEioLRZVO4M8TBCmFeGfvn1/cw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789562429;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=XTkw99wHhMDKxohNnkz5GeHj5w+F7HqZ+heONCKVieg=;
 b=phMbyFWi/UURCX6fu22WXyQjGKpDvyvsslAfx7d18o9yZ6WZfUyRw+QnUSZu9sDXKbGZ
 7X6Oynucj8r7jpTISmT9QVrLn9egPsUsBZjmyiYxbD1TAdnWWhwCKhNOKikB3xJMAkzGx
 osBI0eITQS8zMSKIJPWYS6MlokZ36GQYwtp7hayhX/yMkpjxuqbtutEAn+SQa8XkABAgq
 i0HTXfOQXNk/sp7CkxTYyzM7WIl8BjZjX8zh/nCFKTTgt+xk3O4YzxVv+t649hKlnKvbO
 SuMUuDimsLClb0fACVDd27ee4hy0G10NAWrbCZJOxlxR3YTF/kZ9JN88fIDRtyrCC4A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=n1rOOoND; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=n1rOOoND
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C9C5E607D2
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:28 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c293d3da33bso12445766b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789562426; x=1790167226;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XTkw99wHhMDKxohNnkz5GeHj5w+F7HqZ+heONCKVieg=;
 b=n1rOOoNDtXRNLmpp9phBSKs2cyRA/p5+vQ/XCxR2evABZasxJI5kYrmEaQNtJy0Eii
 UPyzJf2qkoR3kCTrzPri+Q7+PdeuKnfI2EjxowzgHK3USXZPYF0eY7559Zgd3HbxMxwe
 cSeR35h4RQOn4M/iOJ/Pbi1b5P9wJLMH4KCvItts9dE6WttKDowExsw3WSeKpxzr7liG
 8DBQT/MI3I6FsVirdx02yHXPFrmiwV5KHQWe5R36lBCvdJwHLdqOLZ/3EniuXgY8nQN2
 AD+PW0yAIQWnf7P7e6jjah26aaR/5TgV/1PofMULyktLooVHaniwv91jfUnXUfO2efH4
 EP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562426; x=1790167226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XTkw99wHhMDKxohNnkz5GeHj5w+F7HqZ+heONCKVieg=;
 b=fpXFU770rjUeKIPtz6FP3iw53+0K6bG3xwOR2DO0gf0q2Ma8fAweIChTN5dh0POYxX
 rI80FN1O48RZPRYA2ZSVkrxJiC4zmISMIFadES8DKiqSyKIrjvcXDh/8dR4V+BCiRNtm
 6hmpFv7Ft+K8a5CDPlAXiRZEQlbYrutWovthO951AmRnDSstnyc0x7gyXGaPWdn6lNod
 0j0WYfXedPbBrOrqHPi9FQEfORl/nWZmELu70CS1ZsRFkB1yupWDkT+dkzmIi6oTkeJM
 w0bKM6Vy09fwv17PZWWaVqBOBEiFSKrLBWemTCPBxKOyDZiQbX9uy6UbphxktKemp15D
 Skqg==
X-Gm-Message-State: AFuF++mGrDTWSnukju3lUHMAVLVfKDQjbUOlgU+CJQ9ACdw/yeonTbzX
 k0oWVGGHw5CrxfTg8W0JBYnWW+XGB7TwvFvmI+lvR3FBz+W6BZ9P2dH+8PEJIp41j7Wt70jTusp
 h8IMa
X-Gm-Gg: AYBFou3u2uiCFC8hZeD21faYZDjA9WOmYjXSmpsxl1JPCm/azliUFosWxH5yviUgN1f
 Zk36vvGuRa/nsIMDiSXT1QHcY2rAVUGICSLDpeeUbOQoPsBda3VeBSfTLl+jmj8PlkGOajUHJlE
 sbURn64IgjLGXDer0UVTYn2mKhI9wX+686Zms0NE99r7w34H3cz3EXEbhyvXPV0dvwnwh1u5H/+
 hnAch2eG5ad+ZEKMsH4KU5bXUA/KhlCitakgSNyZy3G38Km1ZuqJTC63VrKxt7/DTEFCKPBh1dA
 chLmiTn7/suyfEAlMmRRmViqXo+/+HD3O/ELIjQvWcIlogH6Q3ePa1EPfI60ZxrjTDcotW77VLr
 uvBJ4uhyc56rCxprsFBpKl46FjInKxjSCeUWSRrgF0icXYkyrx35yHT/S+WSjAYKyHVyMeNHYkn
 91/haXqbcW+61X+XAohQvYfN+6Wj2oEhiCIlctQaS46XBEvz31u5pkNQQuj7aNTlmvMfXV+JRzd
 JIrsUjRoyiWrV+MLcofLEPLlcG6Q/f1B9pkzwXp6ZDDdBnR1xD1SLN9
X-Received: by 2002:a17:907:da6:b0:c29:4634:5c8f with SMTP id
 a640c23a62f3a-c29e4ea2965mr174318266b.0.1789562426500; 
 Wed, 16 Sep 2026 05:40:26 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29e801cdfesm82430466b.58.2026.09.16.05.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:40:25 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v9 13/26] usb: gadget: ci_udc: move to the udc-core
 registration
Date: Wed, 16 Sep 2026 14:38:13 +0200
Message-ID: <20260916123826.517181-14-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916123826.517181-1-anders.roxell@linaro.org>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 16 Sep 2026 13:08:33 +0000
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

