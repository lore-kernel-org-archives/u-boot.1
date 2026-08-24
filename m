Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D460BC5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:47:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD85680DD1;
	Mon, 24 Aug 2026 16:47:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TBo-nR6Q1Yqc; Mon, 24 Aug 2026 16:47:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589942;
	bh=T/HYhZzMaFWvT/MD7BPp87mG1zBTpUmlEsa1vpee4qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nPLnxUVkmUdBs+v8JIACJSfmg6AujhKWPmw2pxAwJ4kSqrsK30GMesgfhH+C+Kadn
	 zrd4PMzOuu/ECUzBNuFIH1Cddheu4zHh8nTLkl0It99l4EjRH7JqM72qfbPkKmsJvb
	 oTYJxjsvy4PRsXz2s06t8ixlHx2u2kPi4IzXf9x4ZPf+qQhQz7Te+APh0ANP1E0YWk
	 xMzsd0UB+oSDvKtaUdvFjNfLxuXxQHfsGO8g8DhnWzc/VHsT5EOJtvsej9NFzB3LMc
	 veDmndYPJcWY0WQ7SKVpIS68k2XX5EssLikHhnQ97hZlBvL07bd6OlZMnkPzhRMfdj
	 SxN5cjnCLP2pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5559B80F3F;
	Mon, 24 Aug 2026 16:45:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3024F279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E46C80AE3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:42:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BkjqII_eQOfi for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:42:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=v4gsgeSF
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C4BF80B33
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:42:20 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6a1541ea780so596807a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787586138; x=1788190938;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T/HYhZzMaFWvT/MD7BPp87mG1zBTpUmlEsa1vpee4qg=;
 b=v4gsgeSF5ejoilFUQCHFsZDcHBFWp3MkLSLULjFjM3eOJ9qc8y73+oA+aH7MG6fczt
 zW00OzYbwxj/5TVTGjmjX5EdNm6lKb4RCIt8WzT3TbCoCaKYGd7bWSni+GaYBFbL+GzE
 Rqrsk0w5Ne5KdInF8UeFO926EHVWSYSGmeFstubqKHBrVmz4T1Ao+xMVDSH9A9goTRd8
 4o4t5feEg6C72nx6E8JozTeHdAau+13lxWyFn0vQ1x6vjvjRmJ1+FhNkHXjdQUeorqhh
 Sa+F7fgxV+SmSdM4GmiiCoViVrYUYKR8UQptgJZDaIe8alGGKdaCjU5+fRIz0HCpzg6q
 g0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787586138; x=1788190938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T/HYhZzMaFWvT/MD7BPp87mG1zBTpUmlEsa1vpee4qg=;
 b=sntVmhhzjkYbYPTrKpcf32YzAo0zNfiACi09eUqPMdSrtYjKp86wj/zXI7u4Vp0W84
 dU9PP6OWlrg5yurAIuOr4ijO+2A7Jj1b3fHY+YPnlC9vU/zN+CQbz7Qmg+5Xdp8p2qSz
 1/jhjSq4a/XWK7xj+Yaq88Wmpyt+KhG/EFb+YsgttLrxixL1rMeOFPOkQDOppfPJA1QH
 RRZ9A0k0SCn5JuoC5VPXYIF+6KbdCFtyPryxsv3jnUmY0gFthhnMZ6WWHMzasyVRPf6b
 fRaICofACigM6bYGjL6koykqEPQ2+yyY0F2KJfGVgiHbyJfhUxlvvPQV6Vga74/EVLmg
 IsYQ==
X-Gm-Message-State: AFuF++lxVT6e56DT3E4QMdDTswmLokxS4ZgUDNVyZUx47SbJX6iD2vjg
 K/fVSVAVfn6N6clMSCw1T/g4uW+kb4G7VoKamjJRx6bVPM2k5xQiS/l1dK7RS36bgOpIKbZi7YV
 sJl17
X-Gm-Gg: AR+sD13aN3silWjw864SA3m6GWzPon5J3+ekBDo5Kdq+QlnBemMy2YEzoYIN8yPft+z
 pVwGeg7XU4QDMBCrOIWRS5vr4Ji/jjU9zw0NWAqr1pmFve4ZkchvtwIFGvlHK/cVIfBiWrzhGnV
 H70lSjX18+ljJlwnfcd/Sy5sfSN4tLkMNRGBhRaywDazjV9Up8xg8PE8R5hCFMB4dxU77YrqIOR
 ObFcG6Cizr85IvD4OKcr/HveLLGAwGL2zSSePOBykmLwaBURQ58rfazm3zhYRJregg1wMC+B27u
 vK+UjJ8xGuI62VHu2qsqIHvO79kbvs+E0BVBN0ak+zDQiH+aIZeD37BGnOl/DjhfWCTS/tqvBBk
 PoZmDN971bY/9Ut8/82XIe9mmxFCYxUoSpze188V1cu6QWRV29kXz0kbTq97G3qJct5WuwVpzbb
 Z6vdxWP/tNX+PoVPZAolKtIA3X57vmqceyCHywHjmJ5OSQIXuuX+LziM+JBn2HQOYjXAEGUHlbm
 4Eo9pAubtCjaA50s5n09Rr9uJgLIENN
X-Received: by 2002:a17:906:478f:b0:c1f:4754:d87b with SMTP id
 a640c23a62f3a-c246a2efde0mr1611603366b.1.1787586138283; 
 Mon, 24 Aug 2026 08:42:18 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f58dfsm1278567866b.38.2026.08.24.08.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:42:17 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v7 09/24] usb: dwc3: ep0: flush and invalidate cache around
 ep0 transfers
Date: Mon, 24 Aug 2026 17:41:18 +0200
Message-ID: <20260824154133.217744-10-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824154133.217744-1-anders.roxell@linaro.org>
References: <20260824154133.217744-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 16:43:55 +0000
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

