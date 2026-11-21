Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA67C606A32A
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zNQHvZGP;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JmSCAicl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C840760EC1;
	Sat, 21 Nov 2026 13:15:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iCe54JYRVuAh; Sat, 21 Nov 2026 13:15:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BDD8D6065A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266879;
	b=Z3v2GrilLHjRfTezOD7gbHVj4IaAfYtBWAU05u7fn3a5JwYtKkXu5tevxJBDZP3hhAsk
	 96oYseiO37vjA7/+hMAH/FSEEqWZeYxAPWnJWOVvR4YE1LBWmdMU5rOf7KnV7rTFOp1XC
	 ow6QloFZCeg/6kUGjn+uBPpwpqlNetWnsKl/5QTfiZ3j2OtigfBSOWHqrPILuaKi93o8u
	 f82Zc6jCNN22nR99D3SKTApT8V7Ddr/tTc/EEfK6/HdyisweJ0lcZo2QMoRjL06MppM4S
	 EqnxokTJGWb1mZ3MyJa3nrE7GoJWNlnrffAJUVfWqLPy1VW8vOxTCHQvQJWM18B9fZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266879;
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
	b=EuL9Yov2+ZUYo4pv8Uw+qMr4K4YWeXTOznn/nwPyKNztAdiJ+DBs7oKqmyu90yxfn3YE
	 PrBYs1gT5Isl+Xilx/gwKbZkoAwwfEiGIpc87t0EnK+C2phNxqWBEI51hmKi0SIvhrmwI
	 Gj2/q9he2/YqMQPkraray+LmLlrti5QOqBgDaY1i3nwPICF3nH8Ja7+XEyKwLefZkq/IK
	 HgTX9SU0Gvyq9x17gOSAsUwDuRPU6a3hIwSpdL3foC7R3yhVOb1KDCb+QJ3Tu4HKurrVP
	 rylwiEQhOC4fSceX+Qk/WgJ009D1rKoJxcS/F8hsUtiMWLBmPar4HlrFb7tkJnOLqMg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266879;
	bh=RJDvLMPmRPtM6VTbYaQF/EhMY5CwgUVLT/3BrFKX/8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zNQHvZGPQ+89VHCEOud1/Ibj5f9k1Pcm8SvO2w3hWaLGZluQDs5qFhjU7OdJ6q5sd
	 8bIAfj5p4pLgZ3EYN8zpAMNkmwuA+vdRHMW6rYii0d9jXbNawEW36Bfx30khUf8h5y
	 rklb/ECc+IM1KMLlHIt4eLrthWUAZG3wtgWizKISoFBXo9r5or62aEr6Whses4f805
	 Huxg050N8eOZ+aVQRuKFKwxEkPHj3A37MiQyb7zffGtBeCqTAQSEV0T7gkUPd6TZX0
	 phUilcZ6dapwYGpnDPmk4DefQfz/orNzAdaNB5jQ8ujiYw3/BTf6hjr4AwiEbGCl5I
	 d9+bqAJPYIOzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BDD8D6065A;
	Sat, 21 Nov 2026 13:14:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 29E9D260
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A7734059A
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:54:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZvmmwbKaRZ5k for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:54:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 32C9B40596
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::632"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=JmSCAicl
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 32C9B40596
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:54:47 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c50692e6c0aso30407966b.3
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262086; x=1795866886;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RJDvLMPmRPtM6VTbYaQF/EhMY5CwgUVLT/3BrFKX/8g=;
 b=JmSCAiclXYmvf7moCwDOLC/af/KJC8oCyzXrCuK9mPOO2g/FE8H1IUJ/LqaDNS5sjH
 QTp9sAnlwoS7o1mZNZ4A/Xz80LXc1MFklaeAMY9aHwg2/6DAiB5xCZbJpiGefBp9Lc6R
 6wxREPsY7RYKqYvQ8q2craMj4ZEuME0dw9GQiWIfbdfCtOkHU6x2Wii1q++VGpL5UzRe
 z5lrglXKMmxfbCpbaWKueR5mZUtX9Yef6ILvj4nOoTyRSrjJ/x1dTOFJlQLu7gfI1tsp
 obcIJfYqr3q5X7Ub3VMqX+K6VJh4e6sBLMt1I38+CV1YlOR66iBYBfVfTBoQ3RYndpek
 yN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262086; x=1795866886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RJDvLMPmRPtM6VTbYaQF/EhMY5CwgUVLT/3BrFKX/8g=;
 b=HWq7Ed6vhcZS0moToyFVRsPg4HVXx4KNSOcPafIPWozSEV4Ho3Cno5TxwzhAwpP+Fw
 rNNvMB4KRzklHIKVnaAgGQtv56Mf+w16RqA59T4MrgT4V/8oYt34+em1DiKQ4ouW9802
 gjO+k+PcRRs1Nk+Fkd1eQx/kjeIE7N2CFETZxh03ujt8M5rD80/b0XiVatIEycosK7+y
 vH2OpJWlq/RJ60xZr6KY2s/MeiDLXoKFeYJTAG0AW0vaV1D+ZJ6nFkK52KQc71MAy1TP
 4pXGFWqb1BGl+kooVrDqOD297d8iOkLwl0USsysn2gZh2jxR06yqKv2moRiy6z+UZIq9
 ntDg==
X-Gm-Message-State: APuU4Z/ClcZ1jKdw3636mpwHawnl5K2KpsxzPrcxsRe66mo0cE9M2KVX
 qzf7Cy0Lp8Iump7nm2uWcKT2LdZlmSpAml4I+Ue32ojOX5E3AAK4FFvPwMDhDIGNA6w2KKh1wJs
 /SZPs
X-Gm-Gg: AZFdTZdkiPbb8u405Ld4b+TTUcl5xVnLC3qh7JEtXVT6TaIizQsWZFZZGpg/0QJ9o3O
 c5nZTU1Y9K7kaLoXm6iqMztOAb1UW8JQDC548BRps4SmEs7XfbzHapfIqWoqAPGEz1eowL2aLUL
 h4HaYutZVo3820zGXXsGSfAH7caO0ElyTve3CBncZbBHVGThLJ/nCDbM789xRC4dq4YfO0Ogy5u
 vJnKTbkCNxTQBWB7LIfDkTCZIlBiGzzPgWeWqmrcW8weQ2u5AtA/BBVg7q9CDHp5EoiAKNhnj1Z
 SgiYi/LchjdFENBKaEX+ToWGO3bTjfQHw4OMutO4evbavVfvEQq8YAXt71sn+8lZWfxV/X1hQrk
 94UcZtFDj4uNThq0iYtWOp40K+o2cuutdDPO37lvM2Mb00wpNaLv9eT7xsdpTu8Ngi5zLsMR8LM
 3ZdRpDL4MhMXq9yvaQi2beAelhx3QnxxCeesV1LqniShWUf7zrKJzA19MIYJ7EKiGyXVs6TExO3
 tQWFAmMxF4kNmKD2oGJJDEIU5Xyig8efNc9aJPVe8u9BwNTYCZv/pO3/Z78l2Jg75FddnwLRY24
 YuY5Onaiv4nZ1Kdqz9FqUEYx62HuskLVoomI1LvdSfug+RLq0FiXBwkAs+t7X4FSZq+zaeEvwxp
 3iOLcXUVdag==
X-Received: by 2002:a17:906:26c5:b0:c51:3b84:6fb8 with SMTP id
 a640c23a62f3a-c513b84886cmr456132966b.4.1795262082460; 
 Sat, 21 Nov 2026 03:54:42 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513a8678cdsm186595766b.0.2026.11.21.03.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:54:42 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v12 14/31] usb: dwc3: ep0: flush and invalidate cache around
 ep0 transfers
Date: Sat, 21 Nov 2026 12:53:18 +0100
Message-ID: <20261121115335.548142-15-anders.roxell@linaro.org>
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

