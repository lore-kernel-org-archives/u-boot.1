Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1FF606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MxxofNO3;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BmhoL5T0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92A68608E2;
	Sat,  7 Nov 2026 12:50:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XgtBCcTxA_Vy; Sat,  7 Nov 2026 12:50:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 98949608DB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055813;
	b=J6kFBohlXmtWO5qLqCnW3kK0l6CgfNXkHYF+lJUEjsTrEHIF0anLNokyxvuPoTgHhbwN
	 UlzHR3HKXrWBrBhWyb7mRAtR9aU262+vK4ILf11Oq4DcB47LUOzt+Kl2uwZiyCKIFISCm
	 kL1zNFZHyHRX8u2kXGc8yyRBESiMPL7JVGaDv7VZlburXBTXsRtuyZD0w1/NOxG0UWzjP
	 3dhbJeP1tpX8rsoo0cXp0pnPv0ob1SZ0bemb4Kjo/yPynPDgRNwrCvkzpfdUfrN/QzZi6
	 2GBdJ0rWB+w3mphyJIyFTBcgdidZx3twNSZYbMpPAaGlO//7apVCAAL1GA4YhVbxZEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055813;
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
	b=QvNrdS0TvufGaluRAmsE77KzS+yB7GpNnlDk+mare/PD3N9cxSQ1HZnu3Ev6q2wSQJN7
	 v2CO0BesXv2+RT33QEozB6d1Zcb8ffvDhY08sH+ZRZj0A5uu5dOdUEfv0e5Dd4RomvYIO
	 vCfClx2QKWQL1GrXJBVe/E2uNtcHz84v4lkJIacyotjhI8m2vhMg/sGNmdMxW2rFvcUf4
	 ECUC/JyWOCEeuApRK8UhAaRJbWzs2dGIpw3o78zxQUpPs0MMsl0nY5vwvpvw1CD8xY57M
	 /QEiwQ53a4syJH3eqZzzRNpIjWONbacw81YEvOHEIrmmmBxfINUxBS63PEwm8wUrVjg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055813;
	bh=RJDvLMPmRPtM6VTbYaQF/EhMY5CwgUVLT/3BrFKX/8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MxxofNO3P8cfzsiTumYgt5V/nNDjwFyedLDgbvW22zuzkG8IqZx3hdTJr8UhxB+lV
	 kRP8W8CfZ2FVOnsiGT4oNaG3XQiCHFnd8WQ9G2woqIrnWxGunKxK3YIA3SDNf21Xy1
	 txoA5y0LH0bBW0h212ptDTe4PrZa9tsgHMrS/fMtLBFyHl/o7vdxD4BPnZCXcT84O2
	 SmLapX7bH8FuNitMJPGCu5gKVVDMjLJS8eqyU7yQmefF7op0VCTluTKXx9Z3Fgm7Mb
	 sQeGfUrd9ktDvdw9KNDU7c33QZzXY9lcMkqmJu8IO7MkvU1QaG1h/m0e1xXzPfo1Eu
	 NBCH/6A/g6PzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98949608DB;
	Sat,  7 Nov 2026 12:50:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C3742362
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:23:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A8FCB4005F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:23:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 05rjhFMPdTrQ for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:23:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CA49D40042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=BmhoL5T0
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CA49D40042
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:23:23 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6b58c577e9dso248027a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036201; x=1794641001;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RJDvLMPmRPtM6VTbYaQF/EhMY5CwgUVLT/3BrFKX/8g=;
 b=BmhoL5T0KaDlmDN+ePylpn7MtmHXBV3LpzkmfGSiKDOowBsYG5ku1tADa5HX6ayUC5
 RLLJkH8qjjuuCmBHE3C4Ef+s/HWGseChWo8xBUvAViRxi0Uc8QcoxbhcNNwrbokEGbi/
 xA73xyE/92CqJxHW+9Yw9x8rzTc/DTiMyWhn7/sS46vJqJxNbGNknj3bq5or481p8Mzn
 DDbuwZHG98DlqQPDkJVznO5cg90dThmY869ZEelsmiO/VgbnSeUcqJWlmymTQHb1KSnK
 s01YAoBHUjKfLUgch59KZdMm/ohmddCCRz9MI8IFYLVv1n7Wysnhm57NNiFqCIi/LQ50
 Mpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036201; x=1794641001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RJDvLMPmRPtM6VTbYaQF/EhMY5CwgUVLT/3BrFKX/8g=;
 b=brc9Td7CvvaeVuSM22VDdQC4VLBv0O2KOJT8eAuP1DcJH2pQZeHCJki0d0NOnP3W1a
 rYQlQGVceYjalkA6+C9CuVG94ZroaHEbK3jQdbaN7fe9BsuwF7+V9QGp3y6C3aY30OxI
 UG9FbWLvSkaeSUfjuvI6G2x+ChyD9DZYiCg7Jlk01TGctAOnWDET2FDjpRPQbI4M7q+m
 vpV36NLhIwk4sCsBB0H705VR0Ebpvf8Yx38deoTpAcaGws3cHCPRmzP4eAv8CvySR+qg
 5Bj912sSvytIS9X84BoE3B34haED1YS+G0MlGCwxCVXcZsyLCncTZ6TTy2F3L8QK+br1
 5vXg==
X-Gm-Message-State: APuU4Z+p0cU9ZC/Noaklo+OOLAahbaXSTWeLCyFqL0pKs3RbaJRWLpCL
 /Q8hA5rWyCGaUBBnBCmxRG+jrjTVQ9gY1catnNDfecPCEwa4LMZP59mTcmNEZejuGuy32P3HkQi
 PaeHj
X-Gm-Gg: AYBFou21uKvOP4jMzvMLm85aZPvymkbc2X0Cv1uKAr24IZO0xrEm8ZYEvEpB37Ioy1K
 ZKMdH1I3eMuN+jRjFL1wuh5DtgOH+gXson/13hvj3j4xQY6WJ+81hbJrTsaf6VAu4fDZ8o7FXni
 MYRrogQShwSPCmOhQnYPtHyw9ItOD82TN28EnhGI7ixgYLdJJ+6AAJpGL3bSM5p+uGjbegolB0F
 5QL36mtVB1nzZZazWGADfJw6YyVfPvmhu3Yg1dJ6icn40T1HYt+zMr4H8D0P5lmGPMWjPaZvF4X
 8hLTBiG+2Z4Mebv5yWE92D4hFqMBQzlt87Wo7RnnoO0i/+PN1+f+1nXzEBNDHy5JpkwF+rlavCo
 kunEy9VwtFnpEVU4lShCu8ltxz+hjVOBdQ6OY8O454sAbYT1rU6/LeF8atGCoij9eqKQ7rdmQ+m
 ElDnbJ+bPxvywLRxNGmtpmD9CMOn3IGzAWXbdyMU3ZfPNOtptjKWQ30QTJHgljNZGS6bSWNZtJm
 8ZGAZCELk/vL7dWbFI8i/tyAHgsa55xxHXZu6OxBEwURfX92XnKl9BHrNQku08FyFyog9liYhk9
 0msevAJ8DhnnXvJijNTC724SbC/b3i1SGy3qhTz8hMqhFFu2pmLsfalfNM4CeEciRSGt4RjbS97
 B5LqS7aw2xQ==
X-Received: by 2002:a05:6402:1611:b0:6b5:4c87:3698 with SMTP id
 4fb4d7f45d1cf-6b597474d2fmr3374074a12.0.1794036201189; 
 Fri, 06 Nov 2026 23:23:21 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b664afe545sm1490649a12.23.2026.11.06.23.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:23:20 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v11 13/30] usb: dwc3: ep0: flush and invalidate cache around
 ep0 transfers
Date: Sat,  7 Nov 2026 08:22:07 +0100
Message-ID: <20261107072224.3492260-14-anders.roxell@linaro.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

