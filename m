Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58E4C5DF89
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:16:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9977B40E5D;
	Fri, 21 Aug 2026 13:16:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hUyjy2sLypyL; Fri, 21 Aug 2026 13:16:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318142;
	bh=T/HYhZzMaFWvT/MD7BPp87mG1zBTpUmlEsa1vpee4qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q7qSmrqCoRnXHfwDtdNrafKh8UCqg1Agehvk+uRJbI7iieGfbpFT12lZV882oiiDU
	 sc0jzmTe0M9yeX6oeclnB0tPMiR/vFJHhHHGEbJ/qiyQwm5qbDGtONChebZvSdtrdR
	 at4mM062/DiFmIz/KFIdk5g1CXEBX99+AyWOuIBoPky0ZCfzyd3WQNhLMP/vSq0VTy
	 ZZwv8+ZcbccOJRKYm9OrntlcraVh0/s3rvxU1wKgYwHs4GqnaTiRLnQynowAGH0PiF
	 Lf1BZbKJ+WNDfUbdWeikKDHTZpbqNmNt0vOp4s4j/ESFl0lhQU2MzX4MP3Au987ReH
	 gCpMD1bwE0RuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7EC3340DC8;
	Fri, 21 Aug 2026 13:15:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 60B57279
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5244240958
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UFT4aUlsvJ0p for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=hp6dfKWV
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DF6074090E
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:36 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F5CE84A12; Fri, 21 Aug 2026 10:52:35 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 752C38498B
 for <u-boot@lists.denx.de>; Fri, 21 Aug 2026 10:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="hp6dfKWV"; 
 dkim-atps=neutral
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-69fdfd98eb8so151964a12.0
 for <u-boot@lists.denx.de>; Fri, 21 Aug 2026 01:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302353; x=1787907153; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T/HYhZzMaFWvT/MD7BPp87mG1zBTpUmlEsa1vpee4qg=;
 b=hp6dfKWV3bbQfRzQizWNPi0hmLChvRqfU9yxAdDymN+W1jQPdHl6kdPztuLCNfB325
 b8/9GsIKR/xUkw67l5YhDYxmy3CN5lYiZqnnNzLFBaETvOGhqNYX9Ur6i8JcPrF/+6BM
 CvHXrdqGV+6Pw05SzZyzsB9awgjCikOeSFyM9Gq4ArHQLbN7gUOPo6KW09N6/yDKXhAP
 JFWapumVVv7nCYD4Aq7q+1N5H7Ws7CwRDfIh0QpUIrzY/t96issVLJhkQROo6HBHDKR8
 w9YqfAXizoCPJIfthU2SeO4rKk4TtsO6X1+CSspW95NFTOHqAwXAZeOe0vICYN6MJRDK
 fkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302353; x=1787907153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T/HYhZzMaFWvT/MD7BPp87mG1zBTpUmlEsa1vpee4qg=;
 b=OqoYNtm1nlAjlFeaObX1PQFuX35EoaNRjrmjdAk+lK8wBrgoc0wI6JtdJYOMpO838g
 tI2ZFFe2QgnCVg/7x+Hno2DxAt82pcmiYI6FTE7I79aQayC0viVgeEzhTiU/YtdGoan9
 Y7GkSthVQuT0fFGXMC1gsK1SBzaciRY6LoFexs+qt/rAe0kc9fnNtEYWIuapEzx2x69P
 45LMYPTweRkwo+zBKq4rMYF0HcIGWN3y9cCeBEmENgtarHDpYtrUb86COfvKewTE/W10
 lhh642X0Ay/e5cYKlds5XmCjSzIUCVShcijS5rQBsk/SQUcgoe5L3S8CAcPCFBpWDHEt
 Md0Q==
X-Gm-Message-State: AFuF++koSIFN5t9kNhadM4Jctpz0Ff8hbg9kP5gY4E9lj043TgKsmv5z
 qLoAo71zhSMxLjqGZePikQoU91LlpAPLBkDg59K+jTP78GG4k+SpOOdy3U3IQHR7LIyBz3gx+4p
 5mYDQ
X-Gm-Gg: AR+sD10M5xwc5WzpkKcS3nftN8BLV7EzhmBEJrpCyur7txMsvxopAq6m+BcrmPO1Nv9
 2WJzPk6v3n4FGyPewgWZVMZ1PrGxfWLXpmD4fVU4GzxG0DMvOXHhKDihENM7JWpPYNljjJKXBTs
 uwm0P8VLuPqBbWURrRXG1o797M58nFSURMhZLsN4dnGIxl9OfQJZv9xtKgGj/yjKcaY1sY6bwKH
 F+BMDe6alArz7UoNT8xL8ykc9gRoT5zr8Yw3j/pXZIc7JGH5bkojXsQxqaMOxzshJ3+Qm5kapkU
 +mjHmM1sgDdprJaasVksuha9TCSS/EZE/9j8f34Dsx9Cq1cRIAI67+kWc+r61OKGhClbeLKJGry
 QXa8lK2+OQgq3/vqXrCw80DPaJnEq5g6f+pAyuk8Orqeqp13KLelG3I6i6NF3Euhxi8TewFBMMV
 PkONEDMCiofkoK95OfXcQpG3yLrAfsmo4N8pRt+VQRiexlDKWof8t70hwAslsm0VrwpJmCER7vv
 fCPdU668gwngnEkSiOGeR2k
X-Received: by 2002:a05:6402:d0e:b0:6a3:fee5:adc8 with SMTP id
 4fb4d7f45d1cf-6a42eeb84dcmr2856042a12.0.1787302352743; 
 Fri, 21 Aug 2026 01:52:32 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff1563c5sm5576530a12.14.2026.08.21.01.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:52:32 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Anders Roxell <anders.roxell@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 72/87] usb: dwc3: ep0: flush and invalidate cache around
 ep0 transfers
Date: Fri, 21 Aug 2026 10:47:48 +0200
Message-ID: <20260821084829.2070426-73-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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

The dwc3 driver was synced from Linux v6.16. In Linux the DMA api keeps
the trb and the buffers in sync with the controller. In u-boot the ep0
trb and buffers come from dma_alloc_coherent, which is just cached
memory, not coherent. Nothing syncs them around the controller dma, so
we must flush and invalidate by hand.

U-boot did this before, the resync dropped it. Without cache maintenance
the controller reads a stale trb and a stale buffer, and reads back stale
status. The device answers GET_DESCRIPTOR with garbage, so the host fails
to enumerate with -71 (EPROTO).

Flush the trb and the buffer before the controller reads them. Invalidate
the setup packet, the status write back and the OUT data buffer after the
controller writes them.

Reported-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/ep0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index e81404e11405..f82c0f7e6dec 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -55,6 +55,9 @@ static void dwc3_ep0_prepare_one_trb(struct dwc3_ep *dep,
 	else
 		trb->ctrl |= (DWC3_TRB_CTRL_IOC
 				| DWC3_TRB_CTRL_LST);
+
+	dwc3_flush_cache((uintptr_t)buf_dma, len);
+	dwc3_flush_cache((uintptr_t)trb, sizeof(*trb));
 }
 
 static int dwc3_ep0_start_trans(struct dwc3_ep *dep)
@@ -812,6 +815,8 @@ static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
 	int ret = -EINVAL;
 	u32 len;
 
+	dwc3_invalidate_cache((uintptr_t)ctrl, sizeof(*ctrl));
+
 	if (!dwc->gadget_driver || !dwc->softconnect || !dwc->connected)
 		goto out;
 
@@ -857,6 +862,8 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	dwc->ep0_next_event = DWC3_EP0_NRDY_STATUS;
 	trb = dwc->ep0_trb;
 
+	dwc3_invalidate_cache((uintptr_t)trb, sizeof(*trb) * 2);
+
 	r = next_request(&ep0->pending_list);
 	if (!r)
 		return;
@@ -874,6 +881,9 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 
 	length = trb->size & DWC3_TRB_SIZE_MASK;
 	transferred = ur->length - length;
+
+	if (ur->buf && !r->direction)
+		dwc3_invalidate_cache((uintptr_t)ur->dma, ur->length);
 	ur->actual += transferred;
 
 	if ((IS_ALIGNED(ur->length, ep0->endpoint.maxpacket) &&
-- 
2.53.0

