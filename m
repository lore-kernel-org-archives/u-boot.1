Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64003C982C3
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 13:09:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2595240767;
	Wed, 16 Sep 2026 13:09:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K_ExtFbbP1F0; Wed, 16 Sep 2026 13:09:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 29E9240735
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564149;
	b=kARUY4m0Teu7T4GfDj85tq3sVYQS7dXQpatVYPZzsEPM2SCLYF0CLh1beKthtS/815I6
	 qESucY5J0x4nuGPAzU06dTuEZ1LRbPjh3dVocRcNfxJa3agBmIA7RRyBcPWLq45LaS6nQ
	 K+JRJOiTzJzOHWrQ2oovNenIwdTJwFRfNndkZh6hkhzIdsZaeFL9TYJU226T7f2EpiFNt
	 oEZkn7cP8mPktdIncQgp1U4ySb2tt9nMTkfpz2ZgFiVvjCUQcaiSrDegI72x2bIEoIMHe
	 rmxe0JaB6qA6nR4HWjhhE6lNea5LJ1fkrYoBIj9faBJNigl4t1KKg+wWfdBZDCk4R9g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564149;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ibjXcSl8e0eFnoe7t7MComfhh/8wURS7SJoiQquFyVc=;
	b=NQc0/2XgE/cPnqkNaB5naCTJaB9W1T7TvN8a0+pLkvtyE8n+yF2VP8xMeBri2o2bIrs8
	 fDDiQiJkXKVVUNkdwRJADc+W6oPgtWccBSLFufygDULJd8u+sbOGwkIVUWvsUMgs5S/sr
	 Xgajdr814lnhHQfnljH36kugPuIIdLsr8HK7VVUscUhOW0uE70oOPRa8VVV8rLPGbIvBl
	 loQDS4d710JDC0YNlTtTQxn57QW3utPm6L7cwsZexmkay7vg/EZ3QyKQV50QeLyrrFiVe
	 xS2POadr9mUiG3o1R5+FpV5aNFLAx7u2V91gkaT/8dup+fGWCfnok/X8dHJhQrk3q0A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789564149;
	bh=ibjXcSl8e0eFnoe7t7MComfhh/8wURS7SJoiQquFyVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p2DkdgA5ZFlw/LgKaLCljVj/sHZ0tVmkXjDkHyyDJZOdT5doUGLK3FSmwsH3wckMp
	 bH1kOZyimpGgK31IO6mzJbfiE49XGak5F3te8qafe69jzWnHCDbkFecTX/hVQ6SnC/
	 ZNEMam2QET4o4bBTip1ETnepRUQw6c7SOjYNB7OjZnUmD7vmjKKZNSSyP8YdxnzyuV
	 vHu033lSWRZyAaU8TwU+2R6u/b4CeRY+uX2ye31r6jueWgZTVhOt+wPW65LenN7iAY
	 0102nvNZK2Nwqb/cVWY4ZbsP1e/UX3u7eYXVZAWBRHjmQAKPyhRD7CEzk8LceKQqNU
	 SE9Uc5C4T0x8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29E9240735;
	Wed, 16 Sep 2026 13:09:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5AD77DD7
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 58DAE60807
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u5MPlwGQ5sIv for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:40:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 41457607FC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789562437;
 b=LJLnMITSgG0WKPF+l0ayiStNDkeRjPOsF+gHb+ppzKVL+4EIRqbg1uXEWIDNy0dTPwwm
 Meo5GWioRWsch6i+DHfsuQf3y855cEbZOGU0DdZoCyAzfyazA0cLfQpUH/feDXPXObXWe
 uw/76BNMG0BGPooTrdkrKcF5mqGKCu4VY0JmWlly+QYIHF8/LO5yybVuLZeVajaU5vuLy
 CBZdY3azK3ZvBFGoCwklKq8yGRvf6BTmyTlUj2cypnnhcHrhqY707TkCvbsjckXgkyDfE
 lMAzncLMHOIPKbvygaT0J2KSzB08bWiDdpGllkgWUJwsnebnBpImCN+wzIS6f0OtZ5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789562437;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ibjXcSl8e0eFnoe7t7MComfhh/8wURS7SJoiQquFyVc=;
 b=bNfO/tpHx6AIhjXpfQZemsb7QmoIA006TORTkj+NK73aY4gp4b4WcGU3EPQXETarU5S6
 om3Y40CiE26RzTuEUAfbCzRWmOZMivJyV6maCLMu18HBwwNBUl/nRPM58AHqo1S2ocKRI
 Z3hurHUzdELg3YKvyRTNIHsFA6JXV1TZvt3SLOdrJAm85bh3xiXC8CEclVaeDoON4zcD/
 3Hp8u1qI4Nz02BldlsiMuGik+U2b+IdlQwIQ6+6oaSqUPLl99GZMpx3bf4Z6mpvVrOuUM
 +7C6QKDXzad4xSPo2/syNh8xTBm841KemYg791s9OmfUzDL55KIg1i/t1obMfTxfs2Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Td8rdXRZ; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Td8rdXRZ
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 41457607FC
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:36 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c29385fb97cso10377566b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789562435; x=1790167235;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ibjXcSl8e0eFnoe7t7MComfhh/8wURS7SJoiQquFyVc=;
 b=Td8rdXRZwh2xah7/Wo1bL0v1Qk5d9RNVXoBlySC+tY9YglzLJb2pbh5qmt7z/XMlTf
 2GCmjQCncbZjxp2G7h+G/+gfSvGtl45z44V+WS0ZFGoDPoahSQKareUwG1M8hbyLxSrg
 ll4AMEAer2gUg3oSG/arL1RWW8eIg8GzSFn6kuOQUA+ijryx1dNRCy6C33mF17tnnb/V
 iyFr3PPa4zlk4JbU3RSuc9bxCR0LBvaM1WyrX8dDGYKAUOGCbCwnB0dBWzMY/lYYCxCp
 6TVD53CW0PC3eDM4YZHV4yzuSQ7W8PzlsyJL07PGb7SOT+qiyqmidcw0GYoN83+5yNai
 ezAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562435; x=1790167235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ibjXcSl8e0eFnoe7t7MComfhh/8wURS7SJoiQquFyVc=;
 b=npB2+UFH3aCN/eb/Cg17rrBTP7MxpLWmAejBFKxAdhMNSTHoR7Tqt3OYhaOz7feBs6
 CNjnJMLNmxujUnEniGYsAxoXrOc5hfYR9qV1srbgFtRzdLzj27HRMUbWN5It+8IZzQZE
 U79hRLU8qUq4iWatHmj5J8z3h3MIf7oKqG/FD61WufnFjZzO65k7JfRF9Uhw76JnRduW
 z+PIkKLN7i4Jtd/c2fj5caK31pMywGoVvnFz1gW3NO1kIbF/8mUSargAnbt/WKmpnPmw
 EvUg8XYGNNxN6+621C5a3PBYvM4Q4pf4bYCZju/dB3FA43LOoUnr3GnSePAfu1+vIIks
 hyzg==
X-Gm-Message-State: AFuF++mfq2CbdsKp3dbxvrQ2zOokVY4peuYTmp23CK/6Zklwe9Vp98y7
 tBbTkKHaq8ftTPxJBFCVZ0qeJd/w9umb790NcRtueXoHUiZZDCMOPyGNhMHFEXSFCvKes4JXTPs
 O5acZ
X-Gm-Gg: AYBFou1TPC9crInxJmMjejEjXIaadPgPONLltLQPMfkWsORtvrhw4u69ntfc0ioUj/2
 gQhZa8kb2z6NyPsXmFPGdMRr7nJPy0pbAftJh6sfDPifBHismSv2rOjltALCvopuU7e9q7AZLvh
 PVJorj0ZQlaiFN2qZlc0DC9TzQfNcUeNtYdo1A+AoE1/35a6njYNojbRfVmGXDjbz/lrYxnaL//
 A94NUMPy3C9/SLE22166InRJHL+AzhJyVWLYia+EpCFO+WO/hCJduohXIBd/hbwUVEqfaTWEPek
 LlC6cjpC3UyzbXZ3ki1drlZj9a0cXCLeSc7fwF/bvasEgdlHkptPvJnKegZ0VRfve6YXfMlL1hg
 yDRxIfEWqzaC++hk2tRLGpsMcJlfyDPhF2kCpQpkggiT7CT3PDuR0EEHWxw5Hyl0t2Ra9bvH/7w
 fYcKTPoW7beJWlh6fFLf2PUhujSZtB6P+IQQbB695n2bT5aCUYeT5zKG9migpZj0DJB7LymbcKt
 oo4bitto8yKGrbt3nxCGe3FWv2TWLjDOyDCPyG+2hOKLZnAyR2528Fy
X-Received: by 2002:a17:907:3f14:b0:c16:1290:11a7 with SMTP id
 a640c23a62f3a-c29e51d71e2mr195686666b.1.1789562434827; 
 Wed, 16 Sep 2026 05:40:34 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29e801cdfesm82430466b.58.2026.09.16.05.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:40:33 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v9 18/26] usb: gadget: atmel_usba_udc: set endpoint
 capabilities
Date: Wed, 16 Sep 2026 14:38:18 +0200
Message-ID: <20260916123826.517181-19-anders.roxell@linaro.org>
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

usb_gadget_ep_match_desc() reads the caps field and compares the wanted
packet size against maxpacket_limit. atmel_usba_udc sets neither, it only
sets maxpacket, so no endpoint matches after the dwc3 resync re-imports
epautoconf.c. Same problem dwc2 had in commit c5c4cc4c6b98 ("usb: gadget:
dwc2: Set endpoint capabilities via .caps field").

Set the capabilities like the kernel driver does, and use
usb_ep_set_maxpacket_limit() for the fifo size, like commit 6f9c431a2062
("usb: gadget: dwc2: Use usb_ep_set_maxpacket_limit() for fifo sizes").

Compile tested only.

Suggested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Link: https://lore.kernel.org/u-boot/87v7az6l03.fsf@kernel.org/
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/atmel_usba_udc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index 52900ad654cf..bcbfe5272d5f 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1188,7 +1188,7 @@ static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
 		ep->fifo = udc->fifo + USBA_FIFO_BASE(i);
 		ep->ep.ops = &usba_ep_ops;
 		ep->ep.name = pdata->ep[i].name;
-		ep->ep.maxpacket = pdata->ep[i].fifo_size;
+		usb_ep_set_maxpacket_limit(&ep->ep, pdata->ep[i].fifo_size);
 		ep->fifo_size = ep->ep.maxpacket;
 		ep->udc = udc;
 		INIT_LIST_HEAD(&ep->queue);
@@ -1196,6 +1196,16 @@ static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
 		ep->index = pdata->ep[i].index;
 		ep->can_dma = pdata->ep[i].can_dma;
 		ep->can_isoc = pdata->ep[i].can_isoc;
+
+		if (i == 0) {
+			ep->ep.caps.type_control = 1;
+		} else {
+			ep->ep.caps.type_iso = ep->can_isoc;
+			ep->ep.caps.type_bulk = 1;
+			ep->ep.caps.type_int = 1;
+		}
+		ep->ep.caps.dir_in = 1;
+		ep->ep.caps.dir_out = 1;
 		if (i)
 			list_add_tail(&ep->ep.ep_list, &udc->gadget.ep_list);
 	};
-- 
2.53.0

