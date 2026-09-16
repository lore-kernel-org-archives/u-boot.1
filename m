Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D33C982C4
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 13:08:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB8076081E;
	Wed, 16 Sep 2026 13:08:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xvJvqsQep_Na; Wed, 16 Sep 2026 13:08:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9D70760834
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564133;
	b=a0hg82KvhzHl9TP3PrWcitR7yIpndjqo0aGv0XQt/iSHM7eCA+nH4jclARYYeMogisFo
	 qh4C/Rk73l20cc4Sm5+J7rfX2lehXLKBZRaHJJDvMsJuFgoJFwAfiOJSHCyJyXvFSXPeR
	 cKCv/GJIEwGY5o0jKqpXUDXdg2wqbaeu25cNPE9fNO0+WC5Weuk9U7O5K/gaWqqAZ2f1c
	 SiHKMV3rj7n/MAOeUhRQUk3KNcBP7+hKynRZpeXgJkCwRmrNLXNh2oTjrplK3t8i7aJfK
	 Z9hFfENxZnuz/10TVYKBdlOZvfQw/cDodzeGyA5N6ryF/UlKApj4Jp3+tmAsfAaWzHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564133;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RJDvLMPmRPtM6VTbYaQF/EhMY5CwgUVLT/3BrFKX/8g=;
	b=B+9kSae5sno8SmAhxUlzuXJ8ov1fRXBvDsVt5zLFpbXyBA38D0GGQ3rHzGTw6kxK6xN0
	 KNSIDNzmmCvxJDAJ7VJ6Iaj89SEuz3lickIDBD4MuGyJRjSzxIXhR2F25nRsEaWJy2UFH
	 6qGalTta34s23RHwAMlffhY5b+XINv3DHjXAkokgrCHfOsfqGDnfCN63LTdHHubyC7XWJ
	 /9ALv45G++2YU3fvsluSfrtYsSsTnJKBPvmRnIN73TDcBaOpuGzX1xuA83QYOk1aSkv/i
	 IkQxz8XsjpQ4LWAXgwVqupqQ1NAoCPLpCUoTFBkVDeWecZO56cCNDH+zwXA2GMwhm+w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789564133;
	bh=RJDvLMPmRPtM6VTbYaQF/EhMY5CwgUVLT/3BrFKX/8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wCErD8wSloXSYOrfMsjkj3eWzcNl0M4+30boBSM1PlMxi2+XQMWjjpg/R8QJXOmKj
	 axGqVkDW0NatIcn0HBGCryLGuseJXYkFdZ9QLc358NU44OwIz9nbP2VjY1nj5+j7FJ
	 s41GkK6/VSDewPX0/zCe7NJR3FdXJc9mrQ6smztJvKpD2eAlQHuIyIrVOch3JaP5wV
	 aIV3i3zN60DE7oRnc1Wyu2KjwKBCMwzOyz2VEORZhJloEKfwQGZn3dtNDtckGjcixY
	 y0UUJeAMa/oKvdNEh4WltJ3435d9BVo2th+S/qqmkRcB5pXOWH4dDiY9lkuZFEzO3q
	 bp4MaL4RLHW9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D70760834;
	Wed, 16 Sep 2026 13:08:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D99A29B
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 236E580E42
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c65gt5ttiEQv for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:40:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3E23080E3F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789562425;
 b=l0oQs4eCPsK218YK9im6MRwOH7/txAwbopLjqrvvz5wRNPwlIfV621nXVfbZuSdemI4A
 22pM1XxoFFRjFKX6VAM7PaSujL/HoEFrPKiK0vCJ2stkEAsqkqiGK89g26CGBw2izni0W
 PiU8/noYPPv2b+KbzauF2X4rf2RbW0jHJBpcHDEgoQ1ZEc/8AfF4n+nKcUqcda3YajWJH
 /ZISEPxzUw0/4WXJH1MGBzdVeih6hvBg+h3NBgvs580BwFN8jnLqYmtzOekBYHuqJqiGz
 GUye5tYnQEps5GlirklDOlBqCUeP1HEfowMDHMuER+/rg9AkJhju7cNyL48/xSazkMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789562425;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=RJDvLMPmRPtM6VTbYaQF/EhMY5CwgUVLT/3BrFKX/8g=;
 b=pGt+KPWHPNRlPifJ/brzUaA138A5/SV0UxA84Q5jmAe0oLOqO174cGI1wasUwBzwGlnX
 wrrhO3IaF0vmU0S0OZuwv439Ca+ufpapmqJUotJAapABU1tszO9LuCXZ3qQvXMiHEulp5
 K1xgBHAzUSPHwKj546HkrJ/7eQVEl8PiVFUsk/oHjWx5QyPJ45xpdz/+UzYsSSn4S3o8F
 RCr5o34f4myAU4xIkR9yzMwfylkBEjR9bLeS3KWWvYnAvBxeYWt5C/sZs2CA8Yh/TP1hC
 8Ug3VaCCkztoORNzXJYWZMBh+hgxwQ5fLXUjFQoIumOeGcMODzCT6j/8U0e84zdnsnw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=KEJUlL0k; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=KEJUlL0k
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E23080E3F
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:24 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c252fb14159so13049666b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789562423; x=1790167223;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RJDvLMPmRPtM6VTbYaQF/EhMY5CwgUVLT/3BrFKX/8g=;
 b=KEJUlL0kyx9QyxyMI85UV60XmSgdUlM6XTD6UTb0IQrr1klKfd9r+bxDcvh8cKq63B
 1O1Xc1gw+YXkwP+GmZGOIKcjpaYIg8X+rlsM8PjyQFrPrh3+qS5v4KmPach5CquUMH35
 bd1BWJvUWO0h4z/pHFLv6T2iyMp37P9X+lmi4QrChENsOsMaVTwAN/BTI/WqFlFinZHj
 9y68pInRouJlMPI50chtvyySzAA/LNjfSsL3zeV6yQGSj6ggKpu+qYFupHumrihSdNjA
 11O+6kJhYkk5hlJr/O9dm1JygtFhqix0RRvAZO2X8IMBfN2lDgnacOiC0vv5Zs5bia2C
 yRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562423; x=1790167223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RJDvLMPmRPtM6VTbYaQF/EhMY5CwgUVLT/3BrFKX/8g=;
 b=Is9jOPsSyY7mR/LUHAbiB2rkFcooO2uHE/WTSFMpt7AI06O9INwyPl3OiVdxNceweJ
 Ecqo98h4cke8SH/wpttuj7cIbbbUu0/7uBX4GRFcdvp2opYT8k98wEJ13Nc2aKQ9embP
 3a9gbMi/aVqo7rCKLycDtp5H5CnH6Xw6yFaVwc1l6V03dlFaMow8kWz308lj23qsGbp/
 Je765gD714yS4tjxib/tcwn/E3QPn98sgak/aSncikr2bvM7OVC3CF8oinJd4NjhQ0p1
 69rYyNwlDMPqRbqKSNOUWZZmS1RvVU4SIf2lWPLxr3kbOEBR78LW+1lAwbpyjXb/MIiv
 a/fw==
X-Gm-Message-State: AFuF++nP6we5TCdqbaU/DgmNkSPeJCaEhRPmibkRVJjI/yoStuYplrfl
 Q5HcvQO+Q77VCRYJQpvkC5mTFHyt656HUhIz2GzTvAR6IOA6VBBkl4/eEX81Inf96YO3oYl1zsT
 zZWwl
X-Gm-Gg: AYBFou1AvkLy45TYNtSH/1PIDyx93C1THAbKllXOXw4vqN2lsjnz+gqkK4hbY/7HYmI
 gAaauR8H4iC7bdGwD6Zkq03Pb52ZmeqKEB1/jqO2TL4Bhpat9CP44r9dqwDGonRIFUy8nLgoaZj
 1R8bBkGrFIS7nkFmRuBfOrgFf/4A2e51RqKo4luJep3nonvPOWa/uDswqegzM0ZANmQ3uZH25qU
 XQ2ndUlEvRs/CUP34KeD+lzF7BM2qe5RJKR1uFKPKWi5/sdiEs22kaKH1+G7MKZIw6jfV0xIZn6
 uBK+33cb8K5fNMWUQf1y7wyC9QOxVgJn4x5uYgsLcVxuttFhpVl1aiKQH5K3J9b8SsAC1QdsE40
 uesYD1mu4HYIFv8IUDF5OanmrlCkQggRKi4inMmXuU8xqmXdmGWwfWjqb6P/Awv02VuMEmgKE4W
 dpCoi3hj1AylEtI91QKWqt/oo+9UkG3eR4LcvTXWPx5sHXzqBI1CREIdvtgvKjYMJY7B6lFGRQe
 2QZTtbktfgK+uJGw4k7nHR2Cwl+5cy5rN1N6U9BFMBCs6wLNh6l4l4nBryEJh5v/A0A
X-Received: by 2002:a17:907:94d5:b0:c12:732a:fe52 with SMTP id
 a640c23a62f3a-c29e53f0b26mr192711066b.4.1789562422874; 
 Wed, 16 Sep 2026 05:40:22 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29e801cdfesm82430466b.58.2026.09.16.05.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:40:21 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v9 10/26] usb: dwc3: ep0: flush and invalidate cache around
 ep0 transfers
Date: Wed, 16 Sep 2026 14:38:10 +0200
Message-ID: <20260916123826.517181-11-anders.roxell@linaro.org>
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

The dwc3 driver was synced from Linux v6.16. In Linux the DMA api keeps
the trb and the buffers in sync with the controller. In U-Boot the ep0
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

Tested on BeagleBoard-X15 with DFU.

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

