Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF69C79FBE
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 12:46:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8329240721;
	Wed,  9 Sep 2026 12:46:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id njMbxw3FKcbB; Wed,  9 Sep 2026 12:46:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E5A5340769
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788957987;
	b=F3YXHj9Vvm9QecdUh+ESHqONZVzklJ4/CYA7dH9JphWCc6mPGkoq4KWDqSJ+lkfbZpo3
	 7mF+D7EmbTJL+4mFOyCczHnXHsLV7AgIOMiiAhUyR2PLC1QR6uuhJ4TAl25OeO5kV3yAA
	 lQdxqHVng1y9tdQY3Zhi1eMCWWZ1ufS/Oz3B0/RqXKkzlO3RG+DEbGAcxhWVYnowXtCM1
	 5O1ahUvsZrSV8nk8bKoS3kXQvXv5nXsdKoxLJzkdnj6K8p45bXnqzbw+qgTs4uFnt6Kpv
	 dauxvXIVB5MfQ2b1oDtwBzlkekWYmjQygMxjB9n9/9WYNwjC29JTl8d58YBGC+h/DEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788957987;
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
	b=A15kbh9Dz12f+U5r8SKp9G+PdOvbUbVXepjIhdp4otFPUUde1L0COcSOSXSNJcSkdHjJ
	 rSPaZXWMKeUGF4dKywVgYjjnovC9ZUNm4b2gDmpmSc/cKP18l+c8NCOHdZeWDman/TYUE
	 52+6w/tGiKAprX4iGhPkEozw8Hsaak09r5LfZN7BSUzoRbY0X4G2ZrzQaLopB1fR4O0wA
	 b0gecxDPHfi3s0Bm+J25VB6/YwJJcT9RllKkkR1f8jTPxwnDGz/aRTswLphXJ9sFDHSBI
	 BcppMJMcDJkeT+CWIBcD/a6MZu6oYZgNpQJjpmOz1fx1X6BR+USJ8rLWkArBmdVxKJw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oUcbzMd6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788957987;
	bh=ibjXcSl8e0eFnoe7t7MComfhh/8wURS7SJoiQquFyVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EckQWpjf+Zgk6OAanLsfTg5EZuK4jQpWLJvjKRcVUEEINNiSiu/5oag9tbTXiGwDX
	 8P8H4sBr3TIzMs8NYY8dDmSYChB29NWE+8ecIvRGnMrv5fFL0HyEpCITVzYCjYyx7T
	 lyf1ibGFhKMAACEliLeERqfLywGVZSpORJiYTUd4hOndS72CJyvfoth/10Q84AQH7k
	 GJaTIB5nMaTW03KM03jmKbSSw2EDtVh/v3u0nrP5q1cy93lOClyNu1NyWXUhyq+hiA
	 azZcwO2Ht7634g4dvZRq4T5CEOAOQFXSkNpsF7h4Xqp6XDTlmzQHYbVCfW8MWpKxfO
	 D/LSAudMpBLcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5A5340769;
	Wed,  9 Sep 2026 12:46:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A59183AF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:52:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A36F3406D0
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:52:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F2tgJRPd7NQX for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 08:52:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8C0A6406AF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788943949;
 b=J66oszZ8FMyw18pp5CM4SGerqvGqOYGlTDKQnQ3eCMBH+Sx6RgZ+zgdSPSto/2Cshi6t
 NTTG6BjTzccVPW8DBgxUjsFUyh2HL+nazdwvH5VBaWn9FTFIlIRHf6DPsbyEswSCvpwt3
 +U/QS5AlXPgaqZzJu446ORyRA5riRG0dNdB3NYEYrY8yz0UXHKOpuP8e5a6pq9PFYt/Sw
 YNYnPj+IhZq+Bbs9foRY3DRwJkQzKXcYEt5VwBZYr3knD7Zh5ZXiFLxp/mVYk3Za5RDjR
 mWcPHTQ+77EWgov6NsFoGrBFkhr3HvNryU2aZaDLcwm8sMexIJiC+PQZbsJG/t75koA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788943949;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ibjXcSl8e0eFnoe7t7MComfhh/8wURS7SJoiQquFyVc=;
 b=jG4CxzZIjl7YleBntAEWJnFeShAKpU8LHzyNtANllAwhLnEfzUEe5tMGIWk9XXHk0kH2
 s3d8SXi6jfRoQAhIbl3xuYP+UKCshYZVAuQaX9zrUJMYh9ZNIR0dodaQjsEKwlnXGLmUc
 aQFo9862fRJb4Abina/Fw38uFdo/92DWt+oSq0CvwyREYFeUi73WdiDhBpddTG8R0gTky
 GA1DuS7lL7dzresEJVSr5jw3vPydN7dEApLqMf0ZGfy7Is7UPb0ytXuxEYzwaRrGreymO
 zYOyVGxN4xXliCtKX668lCvKU54GUGWGWO9PRNq7UAquEFHt99buapO0GAZZ/5K3lpg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=oUcbzMd6; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=oUcbzMd6
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C0A6406AF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:52:29 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c2939b2e4caso3770266b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 01:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788943948; x=1789548748;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ibjXcSl8e0eFnoe7t7MComfhh/8wURS7SJoiQquFyVc=;
 b=oUcbzMd6gNf7VLrMaXMsOnc9HxQY7/dTDPt0pICXrEiJEgkjqwXmh+NRhAtf7/S+pe
 8Mr2N0iercHdX9Pjc/pzIV0n4grCS+yHkH8MuY4Av+Rudb4e86V0ErZ7y1oaMNA0cClQ
 7A6X5aRVdNkcBI/EGZlZEIevDbinlqLbq9qNeFBDxz4B/jfNPein7wYHAqyMYMXLc3db
 3er/sFnKyTb9i42LPc02V6TAXrJ1cSdBGq0o+CHI9Q3cFRTd6fS821oSeHCIB6cz1hgO
 uIIJVJvj9LYek1xc27x8jfOxqO0nMnKVrF8HRo2TmGSHFbyhSsveXl+0F9cnraX4qfcl
 OSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788943948; x=1789548748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ibjXcSl8e0eFnoe7t7MComfhh/8wURS7SJoiQquFyVc=;
 b=pQVQGb+ohQSIrgZYNw3SXehWseR0qLGujKBg+ZfDvJ3iJeRO2tGYwSUhazQDIftOOB
 bZ9VantkY5oclCpBvrfo4Kb1FtqdYxAEyTq3oVxp7cZC8PTsNNHZL8ZUDWL0Q/eo9/lB
 Ty4JAfK/Wf4NRPMY07j7vShnjVBj+mTy2KLLufX68Z5cJuuzUqPnjErH2Q9lnRItX1a8
 mzeyL9tVlj+3WeqMNz4oYm9bMy/yd/7PxqPpGFXlBdNqErVL9TXCAQ8J9RTwZLoh7e+/
 B9zaHVbP1Yz1emkCGsd/znysl01rhVLs0DcKv8E0KHgKfnq7yDUhLMbrfAcDO1g15WLM
 Q9rw==
X-Gm-Message-State: AFuF++n/aemOWbTP8DJ0t/7xey0RERdvg7PxgOvrS0z74ZjqhJc4sYQA
 pbko749H+blyFy9T+vFNdSCkQpn+OMK/ouyz0hSLP6Y/h63pnDuKsz3wNWk4+viOjwfhOGcizIk
 xz3Ty
X-Gm-Gg: AYBFou2N7Yx5g1Duyaos8zqE7sA9pl7WjFeSQLCXRkHYK0icNziV9UgAXQk/WkcWY3e
 OC5roPuGONGpwhwS+vjgcLPzeNzHEIerRXsDIg9sTKz3sw4yaKWh1/27TVEG6jj0C6eixfbet25
 7FXRZ5Q6jBHd/8/bjnfl9VJZneiMr9HcbrMBTHOKn8dd/Cekd9QfNpfNeKbIjMhyoMLRmCSU2AO
 4WAHkVko24hBiWFmYI2vfAL45Jbe03SL9brO5oLhOxdfydtx5gKvxvEXdVK3LyBalsLTh8KAoSU
 j1/Egx2pObH1IR/R/Zafu3Q4g+GjtwiCWIoSS/249Xsi1bTJu6/RjHdSxUF/iLhxkik6zb/Ts4H
 cTAoDkvTVYaTLqBrZ0cMJOYaT+F2GqSHc1piffe6tvfLjnmVfitRsKi7Su9wIoNSfpGHhAgQS17
 kfa6yzygrPXyzX9CeLcAuMNVvfMYfqJtBNtPiJVTJb2FEpdjUys7dMyKYZM0RhGifRvTz6IfsO6
 oWyiKCrBgiWur2nRVuibE//z3AyTMya
X-Received: by 2002:a17:907:940d:b0:c25:3ccf:bd87 with SMTP id
 a640c23a62f3a-c2624d27f76mr972489966b.0.1788943947554; 
 Wed, 09 Sep 2026 01:52:27 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d5b371esm730398266b.54.2026.09.09.01.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:52:27 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v8 17/25] usb: gadget: atmel_usba_udc: set endpoint
 capabilities
Date: Wed,  9 Sep 2026 10:50:07 +0200
Message-ID: <20260909085015.2480097-18-anders.roxell@linaro.org>
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

