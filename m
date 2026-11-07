Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B37F606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mv2IIhWb;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qSHGq9/A
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45E0981638;
	Sat,  7 Nov 2026 12:50:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SuznIG2BMYIg; Sat,  7 Nov 2026 12:50:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0E900813D8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055836;
	b=PSscqYjiDvc8EfyFYhjdzWiGYMDLjqY3HvAMjQMXD9D154fMtbX8sVRhK24gbWRWn8BJ
	 r8c1vwFdhtJbfxvRo1Iob4NroLgaH6nouZsIn/My4bJXVk0DZHtk7ItlDqmzOPJCogRal
	 y08DhNTtMwtiWYXdxcgtCx1V7FuXyKjMY1s40g66p+EMStLAT1J/lvR6obmAkxftFSol8
	 jAQQgEgMyvAA1X6Ib6wk1qNVtFis7V6ewBrO5rqLZuog36sUHURn9GqVJv9+twRLKlAuQ
	 BHgWHRmi9WafqHWc1R6ACZJO7uTrzJJW02bwXrGWKa0naRRu0zDocvgjuZkDqUNup3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055836;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vnjBlR9C9eEOQ4tziP+6cJA1SnEzMY3CZLS7DEpWDJ0=;
	b=auJOiTtgOLIMOjcUhEv7KiPFhBpu7mwFgUbMDh+QqOULpNpqMH1S6mR33fWFiZb3MLYB
	 EIkF7H7iG7DnZrK9xZz/PayO3YrIsFu/zjgjTHkOLB96j1MoWntDFpOYYoaTxsalBlXtG
	 6vNAANnBPQq+EhczszMD3qwNICupBgWQRM07242FRA7O36C8Ovnblxtne2jsqUvCM4FIC
	 fIMEQRgxcmAg85ngpI3Bh0zX/95LZNpgarIQXks8RANAkFpOsdzGHBGb1377FoWY1gDS5
	 XVpVPEqhtlNnPCsSLW2bYFsCsd4vp2bVtPKAxeUbsiKJ80U5gJvPK8NiLt3Mlvjk+2Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055836;
	bh=vnjBlR9C9eEOQ4tziP+6cJA1SnEzMY3CZLS7DEpWDJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mv2IIhWb1VNwy7QBi37kLTD+hAmI0SP3RmRcQN298QEvZUzljL80N8pRPrDTZs+b7
	 ymn7BW1h5Yt0r0CNQxV08dArSLDz5i+gtN7qSrWUH7xk4a6OkqhWEVOe16b5GhywNO
	 Jy3rNO52c3p8t5IMkvE6BY+gUnUBmtG1+NQAhQFrygSKQT15x4RRFY7R+pcEL6lBcw
	 PstG4nIB8ouJpImmq3jzC6csGs0IbtLw0JsuNf+snX1HwFAC0p/0x0zEATBXDMX+Pq
	 sujq/NAfWByja8Fv6PvN2LcM7lb2qFqvRxvf2HzYFQ8SwUngrsuFjHauxYPThg6iQX
	 /3B+Ka7FpLsRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E900813D8;
	Sat,  7 Nov 2026 12:50:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D32F2AC
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0F020606C0
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eN0yWi0nzM45 for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:24:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D8A176069B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=qSHGq9/A
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D8A176069B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:08 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6b56bca14b8so214500a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036246; x=1794641046;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vnjBlR9C9eEOQ4tziP+6cJA1SnEzMY3CZLS7DEpWDJ0=;
 b=qSHGq9/A8sp10xk3uGHI/ZKpwF4PF3Mk+2rc+EIP1JYSiqtwgQqfwp2TkpaTDPMBOI
 yhZdFXqtmFnDvmX8nAfRVogoXdeq2Mb5o1DQJOQ2ARTYqg/AtofJLpF0dMxFtv1/cWwi
 B9NXSURZJB7XL+UQopbFhgLorwBSshxePs5m8AT7I8ACy7ZGTdAWvBjrEFm0TUTCfqX2
 Wi4qLnVEulirRz1nmobftjpKa4clBC8YgAR6nvdiqQmwzTQ2FAF9KLwq4L2So1tISQiA
 jTXrVxFfFpVoW+q5j4Xxn1BEB3vTszBig1NII63u4lFHlvG/aDHCJ3ilZnyZ1ZPRIv0M
 N7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036246; x=1794641046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vnjBlR9C9eEOQ4tziP+6cJA1SnEzMY3CZLS7DEpWDJ0=;
 b=1/LBxGggFzhse/ddSCLvjgNiijgOv9GRM9mWRtjaUoeseoh0zuJM590fugu9mxBk8q
 UQzFa5IVzn79aIJO7OFubXBoL7m5UxKFecRoli3GxNZk9y8111iCiQ/p4yjr3RUJluJH
 cCNLUZOClySs0XKiYf3yUhPtt12CjRaYrDBDiB6ivFCqqPVessftbChqVECMTi0nW3z3
 4FWCLGG6qQ43uHiDB1+XWmkW9OSLTmlPd/upW0Eb1dZIfoRIFqvFvFVO0YXgkyCDbJ6l
 OaFkvEFNsS8U7HgLF05o2A6nTRRaMBUjeBfGcc313OiBw8g/soEz+Usk5aMJ2Vwz7ho4
 4DmA==
X-Gm-Message-State: APuU4Z+MsNOrjAEBVkSq3rnngxbfH42Z1C1zEoLmODmyYqN1gwyAT2Rt
 Djwk64LLBrl4xFwIhztvb2OpsEBg+IFMM66F2C7dAZjGijxi5Lyg6DrQkRi2QpDGigAaYyUp1od
 wELD8
X-Gm-Gg: AYBFou2zSGVaPAS9uVZGxMZMFmjxcOca5Bs5/P6PZUbfM+2njtL/uVwg4NcvlP3P3pT
 bKUSsFklfu/GCwWhPhaBxZM+0336wc+kzjqpcMqMO2ojahgsJByrKlwSsONO24RNjAWefjPJSr7
 EyD5tjD6qfT8XBiLnyyJW+dJdjRnWhZH1+TkHTpekTF+ZDjy4Hei7O3SJfnID4G/o4p8jC1ieAe
 mtNT1c2ejTJvdMaRW1rU1mn6OvPjowNgbXp+4D1ehRZh+gu9P+7G3rqQFRL7thY45g0bL7q3QnA
 TCpz7QAo+upgYQbb/2rQxhXXqS/URmQvItwhj38Mp7gvz3RsyzzGKUdX2Ht50JU8lgRx6Sp0dGG
 RyFA1QPfmyBkWzre6rTQ9GtcoJ+tF0xhTD5T4NYaLKf2LRmMl8wfu6GYmSIG2U/naAgbcPr9ts6
 0Ohr0Ye8Twcyu5GlDjS0cHmlkrVziGpA+f0uuTJVeZD9aaT+MNRxy9+w10QEr4wPwv92ZDcDLpp
 GXZUn7hvmB7+LmX7Pd1PA1zxQE1tmSmlxcI8PES91pJA/Iw4XqRSBcU9QGF/75V8Se3eJLammqe
 fNOI6CXpR/UtIEOWo+7ZAESfQiYFcABBGBZlW6urYUiOPscHqXRsn7xipjU8rOS8fzVwXBE/TZw
 zOv7v3ZKWSg==
X-Received: by 2002:a17:906:3555:b0:c25:2ded:ad36 with SMTP id
 a640c23a62f3a-c4d34f01d0amr381619966b.0.1794036246479; 
 Fri, 06 Nov 2026 23:24:06 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ea8csm130129166b.22.2026.11.06.23.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:24:06 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v11 23/30] usb: gadget: atmel_usba_udc: set endpoint
 capabilities
Date: Sat,  7 Nov 2026 08:22:17 +0100
Message-ID: <20261107072224.3492260-24-anders.roxell@linaro.org>
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
index 4df013bf215f..9771988606d4 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1218,7 +1218,7 @@ static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
 		ep->fifo = udc->fifo + USBA_FIFO_BASE(i);
 		ep->ep.ops = &usba_ep_ops;
 		ep->ep.name = pdata->ep[i].name;
-		ep->ep.maxpacket = pdata->ep[i].fifo_size;
+		usb_ep_set_maxpacket_limit(&ep->ep, pdata->ep[i].fifo_size);
 		ep->fifo_size = ep->ep.maxpacket;
 		ep->udc = udc;
 		INIT_LIST_HEAD(&ep->queue);
@@ -1226,6 +1226,16 @@ static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
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

