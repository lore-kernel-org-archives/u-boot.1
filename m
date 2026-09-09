Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1F0C79FB6
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 12:46:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E402740753;
	Wed,  9 Sep 2026 12:46:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CxBjL9zz5ZkI; Wed,  9 Sep 2026 12:46:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D101540776
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788957968;
	b=L8J5DIv8y0V0AbL1cUVHkf/x+H1wayfMOEPVBz+aMX/6qJxtZNYAvkCyU9nfaE+1t94w
	 AIFkXLnkLJjpmeWH7u9b1/QWg9WK3XtHgSTmEv/wEiclAe0vE3Z8tfkAORVFLO1tTCKEZ
	 VFLtnXbfVtIZQIHTldHeqAR2BpaROUdhy5w+dJtvYdotMHV45QdcpBr7pDdT2/NrVCIIh
	 jlqS3EJ7H9TmgJxc05xewGRjXrn+Wku8ecVdgRUWc/1Hk2nwak6U2J7R1Il4XTHbnJaCL
	 AIYiKvQw7XHDVT+tmdFtjE2mZuZTO2Bb0S/Sd0n189EgCuhRpN7nhQDtD+CSgYBozFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788957968;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=J5JTmE4Z/10/POw7qAxiIXjEf0EFvW2GL7Gv6BG/pO4=;
	b=DJSLMB94fvniPIJuwcAjD52IRRWLvYA4P5wJ/ijenST12ZMQI3ZJnuoGn101Aypzsl4x
	 YqfZK+fO8FwOuRjkCX2PI13wAYHTUwjw3zBaD66ABlTJKy9p4B1H9QjyhnREVvj0PTGJt
	 CapBFf+e8YfFZ2xRulrnF8u7gYIMQxCOiuLsZOcKXFOXSEU8GiWPPJ4Ia6A8WgeR9pjp6
	 jjBsuwCIKiJDpoA+jltMsJe9nfs/CAW6DTrCVwR1635RFMigmIT5rOwWzZnCp65jA6ULL
	 bUg2T/vFx9L0OQgV5dSIOrke10K6tTleY+q5DYHLKroSAVSRpU5tXvXS4AIt6+lwRHA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GD0KTIgv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788957967;
	bh=J5JTmE4Z/10/POw7qAxiIXjEf0EFvW2GL7Gv6BG/pO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SiLd2GlzZiUPChYNaw4usM8rOf7K0Tbcm4d2RyqpMoV8ZFPYq2MxIsS2nFl9xGuam
	 UCZ/sC/nHQtAT1einjUe4Pm+brCpJbuEJJbeyGqoF7WPZhEoHFidLooPEfPXRXg2Qh
	 6iJBCv8hmbwDgHdJMdmKw0vcnG1kYU/FWxGZ6msdacvzdGSwF5D3Min2PnMZCE1j9n
	 ix8fslqcSNxeA+IK1hi2yp2Q0XETMedcYynww29+MMWJFn2Nff4JcmQpW3IacTcqX1
	 OOPDTR1KQwNdW4rXzeb29Uwp2xONcpA8iKteo7Mv2B6Ov8w6vK0NTlmRWJeTfKja7c
	 d5dh0ZDU02+aA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D101540776;
	Wed,  9 Sep 2026 12:46:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 33A5F268
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:51:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2590B406D0
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:51:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GnVMRO-HTyHB for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 08:51:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 54B0C406AF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788943882;
 b=hifG+FkEPR0CfD7ryH2x0CX5EalHhg9vwAJMwmUN0vCiJvvyuNm1uTnOWWerginw2mjd
 MESrufY9jC2TVFax5rR5hGB5lNNoJn4Vkj4eyjN1d03VrwXSffArKvvpsYsa3rMod118l
 E6BY7cZDhEZWY6trRVj820QBIH9DzKTMYBrZvyTRw1bH1Nm7gEYaemPnSEkmih8ZkaVYJ
 SN+GzrvqqHlgUWCH38bRn0jO3kY37W2OqTwvh9vGP5xLpKszeDtokBRkuKSCsHJ9mvK2B
 EFBMUlvjsLfkAu6EhX0+ESWKqsADdglQg2OGxCU/OHX1+f+DTr/pkFKHOM79buy45Bg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788943882;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=J5JTmE4Z/10/POw7qAxiIXjEf0EFvW2GL7Gv6BG/pO4=;
 b=YVvv6I822DtgfY8UiWLCmAZfG+zy6BVE2LDcDlVzNl6GD11qjzh1ZP/t7aNdbifspIx0
 seWfHvICwgnq6h3fdjO3GgeYTrdjilS7vvGy6+sAIlK551L7eIPCJWiseCLKk2fzPsPWZ
 1mnqzucuLFjuEn9EUJgM0956gu6nXZWg/JYzS+r8lBAbCiL/EMy2aJRZ4AYrWwfXmGaua
 WWoRVr/dy2T43nRuO2gEAkOxBxkUBluxgdRxD7uWXFeN9MALXksy1WWEYVTlhHIlIQH5D
 VFpkeA3AUJHkALAmkC4AN1n7sSSEh+a3JExlU2BFUZnMy5Ahcxk2UF7nuLOCsW+F8yw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=GD0KTIgv; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=GD0KTIgv
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 54B0C406AF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:51:22 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c25085f2422so66518666b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 01:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788943880; x=1789548680;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J5JTmE4Z/10/POw7qAxiIXjEf0EFvW2GL7Gv6BG/pO4=;
 b=GD0KTIgvxdMFAF/BGs8KNxaVwWd4ytVjY7SIz7qmyMT6cdB3tRQ38SOsMasoMtWPZO
 kEXxYGSIQYmgFzaB4+TkILVFkLMXtj+O2r6uF4bbXvuicS3IwmdNvLvqphY8tE+mAy7S
 rzcWcSwPffQAZpT5Kd+phnp8S0WzaOc9xlaHdpHk29jfvEEfK6/DRw1KSyljzG8DkSdA
 1UxeeMj4RAnhroYCs+SFxtcT3gE6XCv2130l9lvdxaEYucWnAiDKp89GDBdp4ZhY9GuV
 VKPQjn5+ZoPoftploMd9r8XZr+AifyTJz2KpariPI6l0ETQEnstBwQ3GcWmuEHX1KcAX
 b9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788943880; x=1789548680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J5JTmE4Z/10/POw7qAxiIXjEf0EFvW2GL7Gv6BG/pO4=;
 b=c945grTCb4RduQjLg305VAh9PQWnbbo9/7pvZmLkk8pJe4wqjxX4EWehKSFC+ry+TO
 CdyAD/2Gg8DF/GNMKq5yD3+mtDIftIGHNU6y8OZaq9wIOByzg6HeiL7FBqk6qsBGUisu
 jeYVlccK3/h1RPQwA4KmcnA4IpVpPOWWygdC23l8AL1SmXUGNLngN55b97O/G0bSYU66
 Vyj5tL0Qm+PIjr5t4+B9dTeGqSmDGl/sDr8fkzKCAzscNancRZ7X9x0Na+QTbOPa7Ehu
 R60d3c8q39FgImNaxzB8hqWs4hFSs3pnoEYCcob+LR4LZQ1fMDPx8qdHfRyjRTA0LWHB
 KJAQ==
X-Gm-Message-State: AFuF++lPk84DTuLntJAiJj7IecWUz5TSRIEQOu+y/G1zRV4MGMsIQWN0
 msMcfY6vT2FeH+xjgOXF6K+ucu08ISWT/YT91eJCTB7pWuKIsdNHA4ZJARG0sZ6l2ilsFKjbHse
 pxiNN
X-Gm-Gg: AYBFou3Xdr5rCo/naf0R778mHZ6Vs9PdnvNYchCX9JLh7Uf/g9pnLh856e9ATLTz9GT
 A/amzb9zaCkILwHdbVYyCjc4tXFF4uKM8lugPd2O1u0fEWztR8KJ5zmETq/SEC2BPcNF7TK78kb
 FfvgaPO7O8JjixaWqujdYV5kihqrbezfBtCNMb8E8aNXPvmWAA3eqoRRZrNCu0wNGDom0xrA5DZ
 8YVX/GrkwkcEEtx+UVj826zJH7Iw+hddQe2iNRiaiae8f1snBrVYVfrLvjWIf2RhjBF4Lw/m3dz
 a5RB0Wv2paRQecRekSoK8jh/KqAFjK8sCcyF8mp0vUVqqyGodIdhKVpA2/nNY+j1ZgA2mDKolma
 jpRnwpfotzMJWX6qKRqOseES/UkajbbK1JnBfccag1ScbVwAhSSjlQYJpqv/s957Unz4peIUgQS
 NU29pp/sgxfHL0zPDWr03pABig9yPRWgyN5ELuc+7PYmJl8usZOe2gxG+MdGgJoKZhj8jAMcWaw
 QBc55qAua1Eg8rOk71byrH9p/FN9p1s
X-Received: by 2002:a17:907:3f8d:b0:c25:ca8a:8e25 with SMTP id
 a640c23a62f3a-c2624eef698mr999255566b.1.1788943880309; 
 Wed, 09 Sep 2026 01:51:20 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c292c14c6a8sm90988566b.47.2026.09.09.01.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:51:19 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v8 09/25] usb: dwc3: ep0: flush and invalidate cache around
 ep0 transfers
Date: Wed,  9 Sep 2026 10:49:59 +0200
Message-ID: <20260909085015.2480097-10-anders.roxell@linaro.org>
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

