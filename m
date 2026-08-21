Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9A9C5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:16:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF03B40EF7;
	Fri, 21 Aug 2026 13:16:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id stHzOy3QgVYj; Fri, 21 Aug 2026 13:16:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318158;
	bh=ibjXcSl8e0eFnoe7t7MComfhh/8wURS7SJoiQquFyVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QL5qJWNBzcJ1btvDxOX9DPTkPMkSZa25kMNUJP2qqAttxTaC4UD3FlmkZUcY1Qj8d
	 19ojqQQgZRfZqSjYl+URrXbCP+vRP7HL/n9nz4zp5W5j2Op/KR05p/hXOlnGvjlmGY
	 gwbuWTzvsFUBsDSBwJR1VTH5SpnbCEakiZ9hJmUotkcafy6W6VK2VXul8zP5OH+SuG
	 1D7Ts1+qCiZFSq3cV7VGV+qiqCT9KkCZwKtAv2vdytyaSL58jsW4BEcSyexrJ715kJ
	 t9zA2DNU0AuW0JGSXGhILnwIxRp8ygPQfx6MFPy5OhfngmUqsFwXHL2RnOFtoGUdbY
	 K7e7Cb8exwFpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF89540E09;
	Fri, 21 Aug 2026 13:15:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B7ED22B2
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9EB0A8108F
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9KhCImFdMk67 for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=TtRiXANv
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6E90F80FF9
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:44 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6a1f56768baso158377a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302362; x=1787907162;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ibjXcSl8e0eFnoe7t7MComfhh/8wURS7SJoiQquFyVc=;
 b=TtRiXANvFIMW2sqxwV5me5wCZ3RVQC5rl8FdW3bDg/gdekpcfZHN4bLnr1mdqKYs8Z
 iAtIy/4j+SYvSN4dzi1KZ7FM+BhtYvmOfskiW0EsVZO4MHj7iFN5DV0Q1vnJ0NIjDKFd
 A3itciWgQ8i7HDTwGFGFJFmn668/nSZ40vEHNzZatMmggAm3QAJsQCXMqpOGV3lsTJ9f
 UN4wn0QX3fHFIBfKFKSoWwCa8jO7/sQaZKfbWiarwsOmvjAbrOPe9YfDo83U2gh85UrW
 y1+zqCkoLr+5Hvgs8c0+53jOBtBeNKSAhjNFpNwXBuGdoQybR0b1Q7AHC3VqnI+vyFgt
 qbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302362; x=1787907162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ibjXcSl8e0eFnoe7t7MComfhh/8wURS7SJoiQquFyVc=;
 b=fvAlX7bmj9Ld0nMKVUmYrtXa6rsGz+eG0p87jKuUYpes9ziwcn2zx8ekK5NobkwPJ+
 5CcD/cYOGYxBHdyB7Zomo+Zd0fF/2D66zinYsFXTB8ro8OYUJ5d4ollUlZMq8l+JGsYd
 kYQA6/D7SmiOHdxHURskOmBjk9wlPQIBua/kJTcz/SjAMEx4vHwA1cq2wM4vsARIeyUz
 UT9oPQhfuG9K18pTyDA+rKfE+p8DnKdkqd+TzZpueVt32ZWvjN4SPgKbRx8+fu4UXkfy
 AvHeR620My90ZGbKRogg5VIwkmkk7OBp+/JcZsrLSZqp3vkVcHV5EBMpcZ+ETnCwdeo+
 6vCA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpcR8JxKuFsQVhqOiXplDWhzHKDTviSFd7V3R05vHDbmKjefSBkSdubO0s/RdsI3ZGsah3xi2Q=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mFrLD8793eNzy6A/33JMY5PB+xrPDciMtcSkjVXwymVEwjnLlX
 JCzJwL4SEzGRzpQ9euquxzj2ZaXjEUmN6q8nUQfZU2OYh7wk28V6Si4+quEc1likrD4=
X-Gm-Gg: AR+sD13uPKE4GPw2Uu+etGnC+UxCEjRD8ZNs+266firhQsZrBn31cjb/cjCL22QM3U+
 /xCCCSMaovemo95QySEpF13Y3zd/eJ1X/anIPFrS2GY1JxmAJaRRx5DqWFbHTQTMBv06it8v/xj
 k+Z8KT9/VL5IfCHaE2FH/LfdtyGLlAUelRWZBb71rRLzcVF1h4jwypwbTCjv3ZGNcH3PCIGq9uU
 33bc8QFgj9rtkB7BUKRCZocKPMWQv++e2Fly91s3FJa+Mz5yw4lzLKr45HX3aSqp1Ty/OdTrcEv
 lqC/QDcB9w+Q/skdfqpHmaUq2TBaJLBzX38I+cDVl/q1vJd7ryF0uLeQBhJxTb94i22T8z9Xspk
 wB6GB3zsIkNBEAB2rim8+nuZqlnH7fsKyVp2VVx96YdZYWFYYonEdejKyc6+Q551nrrwfJlODTk
 ppwxl67XeltUWYGFUXZBtQ9pIhWLlDqlc1OYmpLHMBuTiMkL7ypioyX8eN3ppn27zxsH//SvGce
 CnqCVsrnBAby3TltvaZRr74
X-Received: by 2002:a17:907:d0c:b0:c20:38e2:b355 with SMTP id
 a640c23a62f3a-c246a6c97c1mr232553866b.4.1787302362346; 
 Fri, 21 Aug 2026 01:52:42 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c245931812esm418809566b.60.2026.08.21.01.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:52:41 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Eugen Hristev <ehristev@kernel.org>, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 79/87] usb: gadget: atmel_usba_udc: set endpoint
 capabilities
Date: Fri, 21 Aug 2026 10:47:55 +0200
Message-ID: <20260821084829.2070426-80-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:41 +0000
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

