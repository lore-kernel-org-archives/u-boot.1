Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768ED606A323
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qOvy+x5/;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GbHNg6aZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F398C81763;
	Wed, 28 Oct 2026 14:49:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CM_NS1p89Z8M; Wed, 28 Oct 2026 14:49:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F263D81118
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198899;
	b=A4/xhkNJKA+YFkN8DaiL65n55QLSnx975IcJ8UgkxAMCzj3uXlq3mxwwvDSufXZMxLjA
	 a/IsH9V6bL36xuOmiIcuWhPXxTX4itmjaxosrwtcU+Q7uXYFIsRoDc3m4qBZ7d7J631+p
	 /OxZnshkLs1WHhCnFyxcF0HmIymal+/mQdRQcMiLo2iF7Trb+lN4o/AZkzGY5HHVfwWwE
	 xItVsmiTnGKRQuYl8i5r/DBHYQh+62o+x70fsHyRkDnAgm3zp8sVC1L+wZBVhj7P/YOU3
	 bcwkC/Ab48ED4FzAl0rce5uGqXfxcphkM+38c2ZpD5o4hB9Vup70LQfjfM8OxlxDE/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198899;
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
	b=b607OE8bDrKxe12DJFJY4pwG4tSNnOwPElHzhzMHhuOJfg61DE+vVduUYMXAQ5gmGIFd
	 Qt/2ubmo6FNfMX+mkY1C0UuV8vyO8q86RBU/ROvN/w2JW958ITHFS+uBQQrRwqQcuGNYM
	 clG8wMK/N60q677JBO7+U9ndsYlc9vWmzyJTIdVGrCeFXuKtXtgOnHpsrG1zPO+42/eZc
	 6Bz/Ib35XBsVMjnPZiKaufssPTAzr4lIk+rcgLrVV0B8+141tcEl5MDyLrIx6gQaESZtz
	 xWTyFW/QC07MO0CKwOCuvPMCuW8ok8PrHUqlxgyQhLR1tQvuccI8MW+VCO87CY6HPsw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198899;
	bh=RJDvLMPmRPtM6VTbYaQF/EhMY5CwgUVLT/3BrFKX/8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qOvy+x5/djSP93BLQfmdFMlnZXxYLBhps3OG6i5GS1Z+HTIwz56NHiTRO60DVTNGd
	 oeErfJqWOp/cEKBysXTn2PbHJuc/nZQIZ6bjX0u+mLxomi3nIPgJAaONKHO/ks/8tI
	 bNGoRl/zU1NZQMh6Rpb4RgKqmHwky5//TwwxnKVvTQ2LusbPE5N8ur4yqAMTcoK7Rq
	 jllGhIqfdplZpLr3cPieSWzyRMxmfPlSomMIqkPBdv8oA+NY1Li2ZODiXMExdmHLLj
	 lv8/A5rae/wg0EVQ7OHmk0Mn8zM86zflkbiRflhLqvGH0svU9o7c5FdBAB6GCfVpVf
	 mcKR8P41zNjlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F263D81118;
	Wed, 28 Oct 2026 14:48:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C4B23356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AADE840557
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OnBdrgrgoIUP for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:16:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C744B40550
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793197016;
 b=KDE80EMCo7plm4uIQ0zr/R+oqY47LIVpoFbVoLQjEqp6nXo3EwMGoKKw5gKWNZ3mKI6s
 RLUzdNK2CAzDwkpSOiYI6+Ae3Qzeo91QdDnqyXDqD0EXSjzeJ+IcW0e6LeoLgsX4VeX3/
 +0HFx9QNNpd7WDB1hkawqXdDttJF9sAL2h/wg5uLboxs9Kb8BjccYJx1hTM6jJyYY5POh
 IhVwIVpPvT/wSeY4Jnt9j7OwcyyLPvLq7qiIfPbfwIH12rdgT5vG9E9uB2uTakgemmSCc
 3rNaTRUKUVh3dHM5R5UEk8tz7YW5H0nf+0d2hCqkQI+cjfCJjiHiFE9OxuPhPMoTVkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793197016;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=RJDvLMPmRPtM6VTbYaQF/EhMY5CwgUVLT/3BrFKX/8g=;
 b=U6PfASt81fgQ8rpMekHLJpxTJwpNiOzm0JV34JaTpemVK6dRtyDmBvhNMqf9iXdi0jnG
 zWHep51zVd29E0B38HTejq84+HmQeU0zDm48SGiACvpiUJMf6VhnHBMTDxDSwr9tRjXC/
 AdsoWVU0GZLlOYoP1+8gkXnteV2qHjgSJQkIOtQFQZem+adFvlJuJEI4HjcMWSkBiwD2I
 tXSn63TN/UjZAySVepYUrG5sIFNgXAdk7OducVvg1un1PvCGQNPfarKH1wNvXLaPI7c0j
 Sji0SwiUejccx8TUZlv1//4Xny37HBr0C+XAo1Qe76mhgCVXJGwXNgGdSr3YZCa+PeA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=GbHNg6aZ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=GbHNg6aZ
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C744B40550
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:55 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c4021bc8ce6so11822466b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793197013; x=1793801813;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RJDvLMPmRPtM6VTbYaQF/EhMY5CwgUVLT/3BrFKX/8g=;
 b=GbHNg6aZzH+CUYa6c5pR1X7X0WP/lCbgLwV0gi2Oh5De6hmjBpH3tJIsuaqRMaUKY4
 XlMgz8SCsfOEqd9wHQMEd6AuMQcduSuFxck6db8qkU/8k1A9f/AuNmx3RO/Akt9vsZyr
 zSTabYG7B4tZC1B3evit10S2Bk74gagmM+hRKJDRQtBhWdS+xBZWhi1E2BLBLBwI7Wm3
 DHLt96s7DfeGOLqLOc89GXsbuhn2RCfGMREM5tGmsDnWfvy7oOANV39mYzzEw9t/31wK
 qMyjZ75n3LEe2vH413Tz1TowjKCMWf+mQQHuu+D6zF8poSwI8UflKgPzl+VSrxnAoYRI
 JeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197013; x=1793801813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RJDvLMPmRPtM6VTbYaQF/EhMY5CwgUVLT/3BrFKX/8g=;
 b=S+pK2BJgGj94LGm1CBBxM7hbL1Ejkyy0Dy5nAt5mHvPgI2NtNH3DUq9hecYHzza3yK
 8WjEdITEEnJ4i0kL2STypCwdM4FXkAmgh7VyOq4caSQV51buQ3WsT+U8S7HRJwPQTWnM
 HbDQCyTCcOTErHS0YXXgI8VqE4l2ZB2zN+PbR9N7AQWuDTz4Ba1+eTsdr72hcIqekglv
 31vEBqrSOIBCMByWWj3CPDDn36tnPdA6VuO0plvpcuRnG2sTILFoyYDPzIK/JdMT9Pvk
 32S3wC9iUo+Y8h70DG0lMpS8Ja1zu5ejDXWER0+aSW2M5YFQtreWrCbE47GKqDTY0bdt
 X3ow==
X-Gm-Message-State: AFq9FYJ3bSWy8ky1TYOHRpytwY5tREhJnX9x9h3egScLVMkUnK/afpBG
 w6jExFtldffaIoOYCtVcE2tPJWz8A0K3xbxhWpbvzp+v/WwNuT7THf2i2B/NSDNP309rDIMjjrz
 yfhid
X-Gm-Gg: AYBFou2jWdGpB+u3XQqX5vSYTGKNa/HaYNpQ44B3lfZFYUVvlB9IjdHFos8MI07P125
 Q1+plaIzuhL8CDQ8Nu3tQvSmIwUa8FHb2Iunv1KXKFQ3UwFVXNeoc8bTrWc8m4pha76hJUCyHpJ
 9irlLiOjGTA47ih2Q+9CSP4dY072mgKLG3QlVdwEV9Ia7mcPCw/haIYV/E0iU30y7wGmOp8+Gps
 d/XbcESPUzpvaT9dBtYGtPHAECRiTNIIuYvLfy5N/nq/Gpw0wSYf4AVKLx6f6U7VI4sL78YSInw
 02KkTwe2uc8jewXTrE2yXQ8jKE2MDpBFnrSFCWKtnXEuUf87ffHrOSzgscBJvJB2FuJQWPEbceS
 ADYqntRrxP982Z/34aD1Ton9ArkHdkkTnRTOHshf7U3UjFQ6NxA1lCurI6ztOmBeomuqROAyp36
 8rnfekyLcgMGnaUk4goGNYjQ1s1tXLu3lZVTtTBmPeyPAM2T3TngdHcFip4dvWs4TwI0AUFEY3P
 PRgEA6E/k4fhQzKR/aYr6Ug10KVe7bsOVic+2Vul9dPvoHvsnobHVfQBn3rQx1Idxj7K0lpLXsl
 KA/YemvPiZr9idimqR47QIsQ7y4wmcJIroCVWD1Rzb4AJElLDTxWDHsfcjTjJSw5DjHCEvGJP71
 rPPWw7gfdpg==
X-Received: by 2002:a17:906:b30c:b0:c3f:98d4:dfda with SMTP id
 a640c23a62f3a-c49bde860a4mr227914266b.3.1793197013382; 
 Wed, 28 Oct 2026 07:16:53 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd524266sm630412866b.38.2026.10.28.07.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:16:52 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 13/30] usb: dwc3: ep0: flush and invalidate cache around
 ep0 transfers
Date: Wed, 28 Oct 2026 15:15:37 +0100
Message-ID: <20261028141554.3073545-14-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141554.3073545-1-anders.roxell@linaro.org>
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:47 +0000
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

