Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A80AC88E77
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 13:09:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8F936083B;
	Wed, 16 Sep 2026 13:09:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h4wEsMOH-tMM; Wed, 16 Sep 2026 13:09:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C610060848
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564145;
	b=YMb4svZ/3/ZkDLl8NPlQJlSUmSTv9GALgibp5wfACU7dCna/OnMpD9tM9IG3ZhRFFrdu
	 qM5yMBsVnvr3nPyxcccQxYDQvtNZQVm1gn9ZsorHERpTWhapEIz9/2mrwFsWwm0xZrSDb
	 hZSHkWgKySHJnScamye51aGoj+yh4r4p9sYwE5bVZOQyMC6zlgY6S4+Psh4dyHGnuQLNM
	 v9lTuP6uJ77LHfHRTjFD3fy13MM60vs68pfNCijwlXzJI9IuXA2R2DQjkui1suuzbBJ0K
	 nGHp9ZCdzYOYHxhUqZ6K4vQjZGYCoW7+OsQztH4bXEkuzD/wlpAqemFa0EjrL9M3vkQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564145;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xaBqxyC+Jjh9e0kBNOWUOuyumSWEXIk9qbZ6rpBSa7E=;
	b=T6v73Xkaj6rX3R3Sr2R4KFTnQlXlKycy895UeWYdskPcpaVKFmGPjBfN5mlt3pICWjTr
	 psn2lCqTxgISxlR0aIjw1CdvWc8tHnLrgmBv2RDHtKLMVYuQgSKPuHqr5z+gp3rAXZj3T
	 368CwYdYHlJaoia/pmP8wk/egmOYEkbNuSwEUKKg5eNC2Lfy0LVVjuTCrUTqGfmi+/gEA
	 qoqst6nvVrS3KucQgHdmsz4GrNLj9lAaBl8RabDN2P7KLRqaGFCNsaeefYKjAehrvE2X7
	 cM14YdrhbZSeOh5Efmxjhi3gukleQd9SZ0QetG8Ql0jIdWCj3hjkcJrlBFpJpIykFiw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IWJsDq7k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789564145;
	bh=xaBqxyC+Jjh9e0kBNOWUOuyumSWEXIk9qbZ6rpBSa7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tjKUJNw/QyYL7Ud0WFSPSEsr8y/APUgh3FhiusknhEqbERDTp9NtnPYKCwx2CU1Q4
	 kisBQJum2tomrLfHHkIoKoqQYwaKSfspRZRFQrlvdOACIYOgYuLh63lV3o6RbMQAfz
	 +Xdz/QaX3WgqHzQpnDLH+vTp73aJXPH1P8qSCkjgNIwIFET6oUbSSLI1ZXktQhTcNl
	 9WcCeLBwBOo9JObSfSfdJmYAbzwWWHCRKJdu86bVZzKYdBrMmBkv+eUe5WxcCSWoJa
	 S6b6I77f/1TEjDRWxlqaM5N8s+jjNwscs0DK2Vj3vNKdM/jQsKUP46oJMLo28YEUTP
	 dba3V6bjAjXGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C610060848;
	Wed, 16 Sep 2026 13:09:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CC74D2E3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B2CC060818
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9EBkacvnXqmB for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:40:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 62195607D2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789562434;
 b=o0Z/bgnWH9tBW+jumZqwY2XxE76D0O59rwpCbur1moNCzxk7MeSP5y5ZUJwwi+Ja1KWW
 JG8A3X4Ymb0liXwZMzVt3Zojc0eoAVMoUjj1T+SjfO5nHhqjfkUYNmRy5QHIq6xSdZqC/
 YpJDa57W1zOlHu1k0pbK4zPqiN392TUIB+96S6e4613+sUqWAPAKuKQT0B7Xqy7twj5Iq
 mONXvGnUZJBqiykQ8QUtEsxklhdD5x94juhSZvCdPJy8wQjqTIyDXqJBhO8Efxy54fmfJ
 RYMgxj51JL1Ju1p2Cm9D95OlCekCJMNOs1D1oPKAj9HpKMcYA0DFqizMQ6yqNazjsXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789562434;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=xaBqxyC+Jjh9e0kBNOWUOuyumSWEXIk9qbZ6rpBSa7E=;
 b=SyJH7YHtM31V5uZiET8xNiZRdW67HwDM2kYoxEBXm2dzLt4aViFOvCq47zMQV6p5/wy1
 CBOpQx2MyH5mnjPc3iH6870lvMLsky8WlOVqKJP2TD4X47MuWPGF8oX7eoFTr+tA31UyV
 noiFJTnxCGxUu9jLnHbu7dutFOWQ0lRJGL5AWFh8Lfc5T9APJuEPMAo8wWTTfusxRAypl
 PdEWT+Jmv5efjSR9T/U5RDeyspdQ86o94N3kczHx7Uc22OuNVKy8NhW/XxbtBxaCFMXFn
 SkW+5F2ukvsdwrLx9S6iWtVgVMC1eBiZDwpmggNa7n20kojGGjhG8CVU4T8Wwt2MX+Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=IWJsDq7k; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=IWJsDq7k
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 62195607D2
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:33 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c2507a618e1so15795366b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789562432; x=1790167232;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xaBqxyC+Jjh9e0kBNOWUOuyumSWEXIk9qbZ6rpBSa7E=;
 b=IWJsDq7kopiH4yNxSeYdcVP1YuHAQgBamN4aGGQz0ssbMcv+505esjA97tzW7Jdctv
 +oMoonxHtruvebQWQB2k2gMxDgTR/eXm1w0EDyX5YH//NzLU3nzmxF5H6D6/859YYY5Q
 9fNWgx/u7yxIhca71tCKSTNCp/J2R7NaueOl8TaMjB1w1pejCj3wP1jFsj5k+chFIiHf
 VecIRH87NZMZhIg3nkvSdsyGAx5RlmBg5nviZlNxCBOMWOjHrJwrwTNGdK8hTYW1Sir4
 v7QZAxnO7lzU29qLTocBnCsjze05DmwC3FuRuvAYZ3m2g35o6/A8zfwtJvtGlzBOBpEs
 Ebzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562432; x=1790167232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xaBqxyC+Jjh9e0kBNOWUOuyumSWEXIk9qbZ6rpBSa7E=;
 b=pmcrvGwFkxp5+mYW29xdaecS/5+zX+xtXVqhsNFQAelzk7q6ObgaH+/oUil6VURliW
 66mHXHGDkhRTt9r2BEj7ua9Wk/sDbs5rgXREvopZp2EBwrRsVXfxP5re25du5uroNCVe
 EiobnmaMiv5fRwAYPZ2qd4xpgka1dCLpByj+MiMplt70aV8st/v6a7JRnPs7YN6kDBnp
 H8UEHWe6KSqZRnnRCoqND+TM8g1syI65STlXeSDyTEqx8RpccpYtbdoQNeZPprYS00PF
 Ll7QZRZEI34jqYKs+EpPalx1yzv7gMl7/hHfC9pTi+Bvdd4yh9TT1u3IlD3uI57BTlaO
 degg==
X-Gm-Message-State: AFuF++kUOI0mEKdokG55Y3C4MYjDfIE81FKXXy0VvAtlHCMmfISE+Gp/
 gEtHaYX3S6c7Pd+JD7BfB5sfcX+TL8exb2czYz70bdyiANcppmWOPe7LvcP3vH/QlhedbWHXmkJ
 HNy5m
X-Gm-Gg: AYBFou0P41v2xSrATve9ELwbZkpMUpGZ4Drls+/rV6fGm2EUTPCgBTFWEVEaf8dAx3E
 tJbAwp1gidK/OodySLYHhBNECvfdWnMxn5xxilCSRHtuSH8pEPAixWdEhC/SmGUTjZvZOmoFFm0
 1TUiECa0Q4jGsbbnqdtZS3BkGpOqGwFkd+VYHODK5LgDxoiZWQLddM1UVl+WglgYKHtwzJMBqMn
 ADZmYnPnGuhnC9Cwfp3LfD12l6x7SGjjHTWuU+/3CGRHIu0ufg/f+mu66WY4lG0O+dKAhdo/n6L
 YyUtyG7nJ1ZEhNQmwDuH5rpepcF7rIB0F9//v2dVlEkx+xDHpSdHHnanMoa9Vc0/3THIGyO/OoN
 kerOnJV1f+OsJwRncK08L/6/vK02TDPoC2cRLpNYkrJ8OaG/Odmk4luwing8DlH4kDPXRf26WAM
 hr5Hf8F7nHFpEA/Wkqu5cqF7U4qHK9nF2Yqcp8yzpMpPtLa+yhJ3B1wa4bcdsKXomVG56lZbVUp
 h2AZNQKA0H9Pdy06dtSAURIBaDMOZmHJ3gbUZorG9+Nrt/8A2HOX3qNbQ==
X-Received: by 2002:a17:907:94d5:b0:c29:5172:c532 with SMTP id
 a640c23a62f3a-c29e544cf06mr186727766b.4.1789562431948; 
 Wed, 16 Sep 2026 05:40:31 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29e801cdfesm82430466b.58.2026.09.16.05.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:40:29 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v9 16/26] usb: gadget: fix up the function drivers after the
 resync
Date: Wed, 16 Sep 2026 14:38:16 +0200
Message-ID: <20260916123826.517181-17-anders.roxell@linaro.org>
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
index b6c11d97a62d..5f5400bab7ec 100644
--- a/drivers/usb/gadget/f_acm.c
+++ b/drivers/usb/gadget/f_acm.c
@@ -325,20 +325,20 @@ static struct usb_request *acm_start_ep(struct usb_ep *ep, void *complete_cb,
 
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
 
@@ -354,12 +354,11 @@ static int acm_start_data(struct f_acm *f_acm, struct usb_gadget *gadget)
 
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
 
@@ -454,6 +453,9 @@ static void acm_disable(struct usb_function *f)
 	usb_ep_disable(f_acm->ep_out);
 	usb_ep_disable(f_acm->ep_in);
 	usb_ep_disable(f_acm->ep_notify);
+	f_acm->ep_out->desc = NULL;
+	f_acm->ep_in->desc = NULL;
+	f_acm->ep_notify->desc = NULL;
 
 	if (f_acm->req_out) {
 		free(f_acm->req_out->buf);
diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
index 8df0e3f331d1..e1eed5fa4cb4 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -320,13 +320,13 @@ static int fastboot_set_alt(struct usb_function *f,
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
@@ -340,8 +340,8 @@ static int fastboot_set_alt(struct usb_function *f,
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
index 7eb667c130d2..22a1352b6d2b 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -2159,7 +2159,8 @@ static int enable_endpoint(struct fsg_common *common, struct usb_ep *ep,
 	int	rc;
 
 	ep->driver_data = common;
-	rc = usb_ep_enable(ep, d);
+	ep->desc = d;
+	rc = usb_ep_enable(ep);
 	if (rc)
 		ERROR(common, "can't enable %s, result %d\n", ep->name, rc);
 	return rc;
@@ -2206,10 +2207,12 @@ reset:
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
index d679cdae97c8..37957b202f8c 100644
--- a/drivers/usb/gadget/f_rockusb.c
+++ b/drivers/usb/gadget/f_rockusb.c
@@ -202,6 +202,8 @@ static void rockusb_disable(struct usb_function *f)
 
 	usb_ep_disable(f_rkusb->out_ep);
 	usb_ep_disable(f_rkusb->in_ep);
+	f_rkusb->out_ep->desc = NULL;
+	f_rkusb->in_ep->desc = NULL;
 
 	if (f_rkusb->out_req) {
 		free(f_rkusb->out_req->buf);
@@ -246,13 +248,12 @@ static int rockusb_set_alt(struct usb_function *f, unsigned int interface,
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
@@ -266,8 +267,8 @@ static int rockusb_set_alt(struct usb_function *f, unsigned int interface,
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
index cd2c282247ac..0bb386053258 100644
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
+		sdp->in_ep->desc = &in_hs_desc;
+		sdp->out_ep->desc = &out_hs_desc;
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

