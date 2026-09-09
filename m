Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0217C79FB7
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 12:46:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8DB10407CF;
	Wed,  9 Sep 2026 12:46:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hfB9o3f6kGI5; Wed,  9 Sep 2026 12:46:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3BED540791
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788957992;
	b=JQmm8s5xol/Fsy8gzJN9sXoXtDD3MgCwjFMeely/0bu/ixvvZdugZ6753Lp770cRPcpF
	 /xzb8aQWMLegqd3B/XsLZLPJ4v8IyjybpPx4T7tRQOJRDOomk3sTORcjyS485PzachAp7
	 pyyNuGLoc1z9KJ23WDB8FYxeLW8ZDxBELYuAv4jE5ukJB/RckVyp9EsCdosEKXxuQ8bxN
	 Te+5/LDZu1+9lQQEi7dsAf9DB8XJslyVg+9nPD87TwWdrrkWpyGapPGJUpZYDtCr7VjDD
	 fwf8gpMcR3TbB6pvp0Ii6De8O1pfyMfKXwvrA5aCJPNd9Y6MHguxjZBFffj34xCkExg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788957992;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3SFnx7mHEBtVl8L5Ja4985xmjxwacWTdBthYAY7xw2A=;
	b=DRnVisuLFzddCDHZ8FJ/2v6SzH7C+Jy6SJRAlbPLcNve4VTtTS1SrSLNToKgDi6mHGzJ
	 zrroQACvfgZkpgTIyzatuZt0Vfxd1AlNzYvUA/pxbHAdlmFPP8OnytXQ9bwi4okIM7xeP
	 5lBLJKVfku+PviZXB9r7xFVj6Rm3VTgwR60h0mWK+sWHnox/h27J62z+8lepU8/U7Jva8
	 N16asItSSI+KgHYAVRbNeDKqdve/jyxSVwH+6sAVLl7loZ19Dnkvqxcm4Flp8MGK11BwF
	 gRzLY+Xz+AQxiWdhBxQgPxihop69RXBPhf0r8rkPxs2APmZ0FvBAgiQuLthsXIiziLw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788957992;
	bh=3SFnx7mHEBtVl8L5Ja4985xmjxwacWTdBthYAY7xw2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QQP9cf7c7BsCE/7BQXYb2NaYKdGCGiTl1RMHYT8BHz4uoPtyv9Q0gE1U4GUpqQ9Ow
	 DTz4SRoq+L+jH8behP8a1TDxyDV3MTi5RTCLqgIE/6JQVQ9fbufpfgyNILacuGpTRV
	 7AV/dVjcCMGudoK2xbL+m5t1tpAyDNBv4ZJkPOk5JgOvRgZ4Gsm50P6MSyFUTP2m+o
	 SZg5Rz+gJGv6JZ14WXUfhSRe6QxJWOYvE244dlKxwCMnLvtyrJTaSdLRLmMJuobxt7
	 8A1QWC0b5dmDa4TD8ksLKrmu1yGGhJufO8zdMA5YFwrOBHXn/evO+rL1OfcNi28iCq
	 f7TqbKApOlJDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3BED540791;
	Wed,  9 Sep 2026 12:46:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 08E7D2D2
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:53:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E376C80BFE
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:53:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aKlYFuUKkxR7 for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 08:53:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 074378095E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788944004;
 b=kgu4nV9VjW9NXxc1O1r8pi13sYuEj35lpZKWYVaNaP3SQ5ItNskoLg8WPLk5PeTXXAJN
 8hq7pgvbynqXvyBTpgUkm8VemwbzMeXekaIRj9Axm1j/xWwPy7w3zAAIK8sH+nZdSh+oi
 F3ySpNANov4lON0WhNJcfpOGdkl9BxWnBSJXlyo6lT6LdB95igh8P5OrFm0++CP2p43Ni
 6aGNe6H1cbI7lM9UYCafpWL2H69fmI+VjfbhmFOZ8kb0/fLgZxNiWsy21I9cGVAVHudxc
 97Vs+eVs8TdEpb8YTp+gs+FemF2QBO7D+YC8ESwAll3jtE27++mD2S4r+yDXDEKPT7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788944004;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=3SFnx7mHEBtVl8L5Ja4985xmjxwacWTdBthYAY7xw2A=;
 b=oezX/dnh+C/xYKVHAY9BS+xEKW/4cj/mS/9M8a8LVn0yDbrjHizAc+Nuqx+ov/he1uBY
 DJ6R/j/DvwHG3MADzYsQI/13pTUpZV4yt0QQ/YeYNbaaefRXeVCzsOqcdkCJojuCslbEh
 KNSX6JBqpCgsdhH3dheAOhH7xngVLn1uIVoCPjmtkvEGhqFoXAr+oc+BBo1qSBYuLGNHi
 dbifw2SO6bEy0IB8jqLDrBw0bZR6CJ+hWF5rYsTO2Y+XHJZbdcf2CpibzjjvncfhWqX9/
 gZpt/IQg9/rl2Jy+t6zo6UiI5MJUGlEKEImpqMKGOdiwwF6d2kcNBuPprGa/1xaOQWA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Q8Qm93iy; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Q8Qm93iy
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 074378095E
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:53:23 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c250848d11cso74845966b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 01:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788944002; x=1789548802;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3SFnx7mHEBtVl8L5Ja4985xmjxwacWTdBthYAY7xw2A=;
 b=Q8Qm93iyRfd9itutcpIFk6luRcDDFx8CrQ2RLEHEx9oSS555ThaF+uyYDJskJYn1SX
 lIATMAUslvRC2gc/tdoeiMoWbt70dZDKo+a7hrnZGVcawRQ293uaXBBkcjHmJifTIte8
 iWm74HekExEJjHokl9qfc2CDiQ5TQL1x/V5N2aEV2F5pzLT+LZg5plf5ZXxVT4R6HYZi
 A/Q8WrnzrwU6DkRAP9mMaCScveUsbICTZUY2n6XJ0KsaMR/kx2w0mWwnWVAFzkoZNkZB
 1T74F5JCQPuVrS3vln94+xeLvbNsCOxPaEUpFWObkP7ZQpSlU+/KItHWXjvCRBgjsKPj
 aDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788944002; x=1789548802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3SFnx7mHEBtVl8L5Ja4985xmjxwacWTdBthYAY7xw2A=;
 b=EFKRTI3s02q/tIQiVWkZBayCS8XmgGqqmSvYWu4h0lHZyfciussWThS1TntEqG2xbw
 MnszLawIEb8oDyX9rjqk7jqOGjqX1NoroCaiZssmxeiK1oP2qiJ8T5m7klnOX4i7ijaD
 lYey0FesVP+Xus00zqjjDaV0SIo8dJd0sqBTdX/SMxWxXSKGISbfWFpyyVPQ2GgJ3qeN
 h07EmXjXGleuAmwEjWhL75izBmXY3c5xxaYity+ZrCIJQJIC6Ksa6LmN3xONPC8Y+l8A
 gEDzTCKTvBJ+I/o17WKIDWbXozXpT3XbgIDngwHPxTCeui+R4/5Yxh3PYUg15VC7XKoP
 6cOw==
X-Gm-Message-State: AFuF++nSjcmpbAm62mGbdlxYJeJXsS3tzN/YoRbOXqiI+snB3RSVyuFp
 mQud9G/0P6GqJEpJIQlnyzACCN903aB8EIYUPXGWnbm3ESHRUYa+B8hXJ9ZyJg+EA8D2PJj66Ef
 3rHMG
X-Gm-Gg: AYBFou0GmaDMyBUsCAogOtThLQedaIrZaP7Yt7DmsYlZjR6mhDviQeRg5oZrbU2f0RA
 /QnRnplZN8kLBWsXrkvFvl9+Ca1gWPkG5/fbUR4y30X80lAj6583mcPLxazym249xXXBtuOVUKi
 lICr4sCtL7ZDeZ62NkaKkXJzmnzAzPlNovnMOn3VczldyfK+fBdP+zaUMzipeEMohgGDoHMsZis
 Myv5EbxOL8p0hO/k+SyPt1F9lqHonzK9uwV41Z1tGr8326izWAfuu1gmI+J/Zn2h6/o/cg4Ig0M
 B0qs21nM31p2QSNUR+5xq0nH4Ke2PtfR7wQNr5YigbD5mmRDMcQzRWn5SWoVpS9XhftwI67QKcC
 XYo/8pQrsrAshz2DBEzuGaUPutJ2hBnlLLkHI/43e+7h+U9jVTzX17CmyiH7h6cA0qIrJoYWZc7
 wqDPjfv8NFIhGu1lR2ZkMUHjGeW064OcRQfpCrISceyg6G+W3jEGhC7u56gVAAIK+LskqNYdcAJ
 OEIxgF20YUd7d87y6smBDFpXkomSmiulA==
X-Received: by 2002:a17:907:94d3:b0:c16:1290:11a7 with SMTP id
 a640c23a62f3a-c2624f0a534mr1117928566b.1.1788944001721; 
 Wed, 09 Sep 2026 01:53:21 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c262f97f1a3sm557381266b.19.2026.09.09.01.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:53:21 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v8 20/25] usb: musb-new: fix up after the resync
Date: Wed,  9 Sep 2026 10:50:10 +0200
Message-ID: <20260909085015.2480097-21-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909085015.2480097-1-anders.roxell@linaro.org>
References: <20260909085015.2480097-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 12:45:47 +0000
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

Adapt the musb-new gadget code to the new gadget API. udc-core has its
own usb_gadget_register_driver() now, so drop the local ones.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/musb-new/musb_gadget_ep0.c | 24 ++++++----------
 drivers/usb/musb-new/musb_uboot.c      | 39 --------------------------
 2 files changed, 8 insertions(+), 55 deletions(-)

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
index 43ab3245e5c3..16907c4681bc 100644
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
-- 
2.53.0

