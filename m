Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C87B606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OlG0nvjx;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FSsmcpA4
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E007260669;
	Sat, 21 Nov 2026 13:15:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hGooY6ecog7d; Sat, 21 Nov 2026 13:15:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9F2B060697
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266897;
	b=EDTnEtxlyvadq4Wu4qfLdIl2u3KZOYUhWRJ0LMJ6V1NQn3EdvxerY5gkk7ijhgBzo7Rt
	 Wzi2IAZo83uqsZJhmpF/dFY2C6AfRE1DeI0WGFCVECqX5W+U46Y9jJgK3Vd5DVdrOOqQg
	 WaCtPpddJJLUGETvTX98eTHCqNv+x5Aj24St8D7OjmvXsoEN9THuuJwhrsnZUumwT935e
	 RjV15gv9dZL6kz9gUXP7Nj8XOkTsgCAdiVU52eD/SQjPGR+obHAcnGD7pCtRWLJbTEexT
	 nhDNgK7edV+eGyspMZZN38DqvvQst6DPIkpSG26RJYn9/lFUkW8N+vtaXf2oWHUxybA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266897;
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
	b=JE05RzbFiv4q2zlEJwRYno/sO2JpOJ7TcFltgO8IkY1OmGulnTdRTwJ+XkbEahGbYxC5
	 dCswFwleart2oA0G4ntLu6OByFzqDp1kZ7xLws5ZjI1qD9Insv6bRhOE3FfQO+wl1SZMQ
	 uJRBwqks/dcmr4qLEgCkwLnSMTxsiR+bpVX06fWUfpqwoVn9VvYJdswYlseim9iL9LMCw
	 vdiOnlLmphPsXaf+1D49Tj/FylOpRwh9fN8Rh2b3Jn7HKblqkSHVhh0HtlC0wbQCHjZpR
	 1TWiXkPSBI1i56RPI/1s0r+OHiO1jV8y2ooancjW+uZILoUW/qOmqkOn0UYttu6YuJg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266897;
	bh=vnjBlR9C9eEOQ4tziP+6cJA1SnEzMY3CZLS7DEpWDJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OlG0nvjxROARuLSY2C+PRoapkfRPwzVVWOHOeVw6dTLdjluk6gXt/xhz3ZXfBeg3l
	 tdqNRVW3t/tMCRpQJyRpCp43uctTf/SszwLbCFPZWnDmLsYZSaq0SLyAZbf0T147gG
	 h5p0vyNr9PJ08bqbQ9FGNQ/gBSCzr92XWoPmyhMp7Fo3CAjLizj0rtga0MRqz17GfT
	 Jy1H0sWJO2SV9hKoyoaypFoNopJWLk28bZMhXGI1Ju5m12DqP0btO6w00sBXRukCKc
	 Dfo+kch3+lsX+q3qh+Of/JIL2El27O1uqypElpqVEnC4HavjwZg3yTCfCCW9v8Unnu
	 sbglpaaEqaMnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F2B060697;
	Sat, 21 Nov 2026 13:14:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 267C21AB
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 18D2B400F5
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z5O6dKmCynmD for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:55:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 075B440012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=FSsmcpA4
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 075B440012
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:39 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c505a0acbc1so33961166b.2
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262138; x=1795866938;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vnjBlR9C9eEOQ4tziP+6cJA1SnEzMY3CZLS7DEpWDJ0=;
 b=FSsmcpA4RtP/g41ukDKKJl7CAArbptiMYlctxH3pQiuwao3On7BdOMtvHHRY0aDxmB
 HhLpgaUy7nFhfD2jk1mJIJP0JCFAUO8ToOl3oj+5QXecOO7SYqaG7PgxkHsSZHumsLjp
 826G85XdSUCRPgWvT7s/QN0SlxE/yQb6B9JSRQxxFC2mJp9G5tQJQWLQgalxkXyy7GuE
 qhL9JNzYyVKDFOxN0nSMRhS9vm9TJqVCn2Wu6YRv9XZyIvrxmbhMDST7k5UhRT0AKo/M
 2+/ggqZGnlQHnAbMwuzmeQT8dTBSbuVcvLWQt4ynoMwMiO/+iuAircpQcHsyRu9PUB7f
 tkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262138; x=1795866938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vnjBlR9C9eEOQ4tziP+6cJA1SnEzMY3CZLS7DEpWDJ0=;
 b=XHBK6ZbE1h4hOqN1SbTpTdxFFLEIXF+D8yOFpl2O/0SG9YpywEkJ6EYF9MZWglemR7
 cO2EZkslGbSGaf0ugBRtId3FnOg2bk4yty1ayzFB+aT5PAZV8H+s75pdw8LgmHIUs/dL
 I7M12W2HEeZjBxnJgQt+eBi+LESESQd2jk53/vlqVl16RUP/v3OK4Sl2HwquB2aii//B
 YEakuuGnTMQYLof6+f0fRGiICLCiTMwngSSx2pQgZTWTb4N5eeay1gl9hj6K4Sb2ZlD6
 QIMs7ZXhAdO0KDBoNzGem+94BU5meBZ8YipVvA20RLqOQbCbjQtztdQCIqfql+KPRMfC
 6Otg==
X-Gm-Message-State: APuU4Z8+rz03QKpe7GmT2+tiCoZl3l3D/iXnE+J9sAju7J8EuTRQILYo
 rlMEtwyqlaKMyQZhwp2+ionmEETnelOPDZXFnlD2brEs4SqB+HkrqR2njE8m+twFCUgiafmGUov
 Hxk06
X-Gm-Gg: AZFdTZe/lYkef6nTYgpU4OjG0PBt1BTseya2lQrMBdP8sy/9PosWaxZaPeYXL8kb1s6
 qqvCc/3sRmsKBUyFQgB1bcaQ8qG0uPTSqoP3LU/cBGXuPYP8fC1PAyUOGlA7PbUmuUHcknIxdtF
 r+QdgjYeW+q8yrD5fswl/up3f71B8+Zf69xBoFhphvCjXuPd8T3dziHpCTVQ02lGznIRDPA++Gd
 WrQqzlA1ViR6CDbrZd1K+zkwRzbrEd7Y6wGEn8DGMFVRmaaCsyQvz1AdGcFDX6v8knXFaP8+js0
 /jVcqp95vDHgfTvnK+/axQHrm8Ig2MgsHoeYBGT3deNB9294tYHYkFOj21/S8xVyLwgAPjDzWOB
 kRuTnIjV4yYg6B8KhWzeLBPM2UP6cfkfsxxcbQLQnyMKpldqPpdQL3f3Ol0B2x1rlu83B9A6V6S
 8UhJKgn17uy/1XLsxADT4KJJQjhIWwm0Dx0w0KTCQrYP4816tqJdgOmU7yx44ny1Qcbg+wy4U3r
 /fQeM6YUek45RDbSZEaXahcBZOPSMC4GzfaosNLezsZHYKIaITeLotJlIp1Tge99UPE55ubSnIX
 HzqPEG99V0EO3EjYrqOT8FTdN8n64qcvLq0iNDyMGjljnaBgWq+bfQZSTxkRAjUyoDGAMyD5Tw5
 qrpkrYqAAxA==
X-Received: by 2002:a17:906:ad93:b0:c41:8e21:4d62 with SMTP id
 a640c23a62f3a-c513a4391ffmr491755766b.1.1795262137847; 
 Sat, 21 Nov 2026 03:55:37 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6780esm194960466b.17.2026.11.21.03.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:55:37 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v12 24/31] usb: gadget: atmel_usba_udc: set endpoint
 capabilities
Date: Sat, 21 Nov 2026 12:53:28 +0100
Message-ID: <20261121115335.548142-25-anders.roxell@linaro.org>
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

