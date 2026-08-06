Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAF9C5AC67
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 21:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5434E60826;
	Thu,  6 Aug 2026 21:03:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WBwkQ9PJy29a; Thu,  6 Aug 2026 21:03:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 86067605CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786050192;
	bh=mLUshkaiDfkaSbkWRlw0ZjKc2kpGWsBeFH18G8NGGDw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XowUDSBhfCqLi6mMnoz9/RYrz6xpezeo0ku01B+f7V/MeF5BcIq8Ahc09DbF832ZH
	 XZg5Iy9uV0f2JWsfW5OsPNOCrx1IAxZDxPblV4UNsvKG/jkfoj7ASv/fEgV0XlZNPG
	 jAJkStMds2GDzy0uThOQfW/9YpSvykH+MwX1U6/WVmohuivolZkDhav6y+wyaKlmX5
	 baPoPxIDkrnZwBHzrJsrkLft7CXmjCKWSNN7g7AXDefFz30ZcMx1MuNBUvUJX3A9UV
	 iNzmd9CC9J3W3BuceArPOlzzw8/S2wegeJ6idHI1vKk8087qv0EkPfIPpAWIonfAwt
	 DZCu3wAqbG0oQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86067605CA;
	Thu,  6 Aug 2026 21:03:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 75BE8282
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:03:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5C43980EEB
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:03:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ruFVdhlc8VME for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 21:03:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 70A2B80F05
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 70A2B80F05
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 70A2B80F05
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:03:10 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a1995ac437so911423a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 14:03:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786050188; cv=none;
 d=google.com; s=arc-20260327;
 b=HGOYE+u6mkfeW22q4HnakkjByS9swCHzD4yaVvCrh+wqNidvnY563T+/ZYBWqTVHOf
 dyWE1UHQT3zd/TI8hQli7J3au/TwWRn3CQ/Y3Ywh7Ahp+0CdSq239wEIJ4EVaCsyDF7+
 EFp6UNHYCvYsZWEuG/3ELRU6YTxDlZmU7pjM2O9fgo5Aw11b0Cyt/gpeZ5cnO9vEoVDe
 NO6MNJChQzv6UdICzzamIAtnJzDJ1W1OF2ZdEEu4saWL7vvX4hH3qvVfe9cBscczl7bw
 8E5Lp2iKDzk4s5Zo8cagoSaBKTSY9BzPmKct6Hi3j8EJXFeMH8zdvEkBmKEXfVfmmHg2
 ta9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mLUshkaiDfkaSbkWRlw0ZjKc2kpGWsBeFH18G8NGGDw=;
 fh=Ye9d8c9UuIgjdEYE5AmpFdHtipkFyQbZju95WIBagdg=;
 b=SLC1y8T1qRsrVu2TKC7NsJAbUFc7oEe8Eknytml85OBeSKTVbsBnbk6bBkWpUXIEf8
 Z3WD5b2ryG80m5fQj57kBUW2jGk8M+/63br3tygVCJDOmk9aVrTtz0m+vHyKHwX1bMCK
 E7OTI0d+zKdxCd2fe0rV9rbxqEP9s5pwuk6Zpq4+dC8JYNcSbqz9ihyLkiEZYc0RBevi
 xGXDVkXFLwUFvni9R+j6334YJtRdqe2Q+Pclf0XUp+wzfuWGU9y95WEtlvnP1eADBqEQ
 bHGNk8EtWP0ZXsq/n/Fm1XesyOupkh4JfygwYqCQKoHIL5Qwl7e5WjUZzbXyDZNTDAFV
 H2ZA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786050188; x=1786654988;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mLUshkaiDfkaSbkWRlw0ZjKc2kpGWsBeFH18G8NGGDw=;
 b=gF+BYD0TF+iY25ie/caZehLW7kfYOz+axAAL+uLP/DxWbzvR4HUS+xwsOr2kuNDrTT
 5J8t14BmrFznNg/iN6ua4GhdRCNUd//P7pIdNWXC8wfCdwj7EAed1vRIkY9bkL24wblt
 0uDvNqiuYSIsoCQeodkP1JMo+0+HysMaoFbEv02/7LFet6w9njg5cqfPQmr6j5H4Clu7
 ppoWUZsxPZI1d6LNqN/joC18XOJsC3qCHZ+rCDLzjhhLw7A+0/IbiAE/xsbRvp5tbXdB
 Jv50YdXQkQ3I4vCAyjlX7VH9XpJlMsgVxXI1Vlegis9vsBeVCiAlsF/KBCFNynfnkYRu
 Q70g==
X-Gm-Message-State: AOJu0YzCT1FBro8bhaqJqvC0JochoOMYAi1mIZPtjBCf2OiFom1DGfcH
 aHRbLDQajRzLNIDXc5R40z7f37H7ZIcyXXxXQGXVOnfTl/aUmxQBtM+JDFwYiqnmIsMRlBIbaOV
 KsPecSSAN6UPOl6T1nvLTX5AxNkWb7E3m3W46qmTwtk8iJm2r8sQ=
X-Gm-Gg: AR+sD11ZqmrLQANNDAQiCQuu6jCRnQS4qnt5BMsLtTK2DgI/Ae/x3nxmBG0bnFUeZ4B
 3CI52IkaYUKYtf/AmE3L0H/hefFmbDa5e9ff4w4o79DNEH3Z0/Pl1VTGOXRhC8EGG67ZQZOH4uh
 3P55t3qIcU6Haez8zoM1ewBaY/aVvoR/HSb5yIN7ibw2eUL1xjyNVbtKSL/TpYrWf8BOhps175U
 wUhTBGat904YP9+a84cMKgyEtd9e/xZa3i+U2UHEx8Up3fLvXeG5eicvLOUj+ew/NWqBBqigRqR
 a/3gCPM/MO/zt45UnX7/vK2p6qBeAj5hEboGRZLsUmpfPEd6mQdgNw==
X-Received: by 2002:a05:6402:21c9:b0:698:a9fe:2eb3 with SMTP id
 4fb4d7f45d1cf-6a18f0e1a5fmr4939551a12.9.1786050188470; Thu, 06 Aug 2026
 14:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
 <20260804-am62lx-v4-1-01746157643d@ti.com>
In-Reply-To: <20260804-am62lx-v4-1-01746157643d@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 15:02:56 -0600
X-Gm-Features: AUfX_myd19EkRokugRJDvhSJakSJTeVqcybJIMUyPx3-BZ2v8_WTOz2SlINd-4A
Message-ID: <CAFLszTgAAcgMYWDBpVRaRdneJfj2jYWJ=7HSa+t=9_WF1SLtcw@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] firmware: scmi: switch to dev_ofnode during bind
To: bb@ti.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786050188; x=1786654988;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mLUshkaiDfkaSbkWRlw0ZjKc2kpGWsBeFH18G8NGGDw=;
 b=N67rxhIqdKFKaBZp0wLvTZPyu8cdFFyHnv9dLVymRdNjTzg1DJ05ZiRRCkf/hxVDKL
 9PB5X0Y71rHdvF3Qy5CQCubaU3t/VAYll8xHYBTRtmWn8wcZRsXUy+OljNB6Ei+eOomx
 cxzf78PEZUX5oHf+ie5hqGOPFUeQqtdczJm/o=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=N67rxhIq
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Anshul,

On 2026-08-04T21:55:02, Bryan Brattlof <bb@ti.com> wrote:
> firmware: scmi: switch to dev_ofnode during bind

>
> When using ofnode_null() the node offset passed to the FDT API will be
> -1 which is invalid and breaks probe. Switch to dev_ofnode()

Please flesh this out a bit. Which transport is this seen on, which
FDT API call trips, and what does the failure look like (return code /
dev_err message)? A Fixes: tag pointing at 7eb4eb541c1 ('firmware:
scmi: install base protocol to SCMI agent') would also help - that is
where the ofnode_null() was introduced.

>
> When using ofnode_null() the node offset passed to the FDT API will be
> -1 which is invalid and breaks probe. Switch to dev_ofnode()
>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
>
> drivers/firmware/scmi/scmi_agent-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
> @@ -437,7 +437,7 @@ static int scmi_bind_protocols(struct udevice *dev)
>       /* initialize the device from device tree */
>       drv = DM_DRIVER_GET(scmi_base_drv);
>       name = "scmi-base.0";
> -     ret = device_bind(dev, drv, name, NULL, ofnode_null(), &proto);
> +     ret = device_bind(dev, drv, name, NULL, dev_ofnode(dev), &proto);

I'm worried about the side effect here. Previously the base protocol
device had no ofnode, so in the transports (mailbox_agent.c,
optee_agent.c, smccc_agent.c, sandbox-scmi_agent.c) the
'!dev_has_ofnode(protocol)' or dev_read_u32(protocol, ...) check would
fail and the code would correctly fall back to the agent's base
channel. With dev_ofnode(dev), the base protocol now shares the parent
SCMI node, and any transport-specific properties on the SCMI node
itself (e.g. 'arm,smc-id', 'linaro,optee-channel-id', 'shmem') would
be picked up on the base protocol device and cause it to try to set up
a dedicated channel rather than reuse the agent's. Have you tested
this against SMCCC or OP-TEE transports? It might be safer to keep the
base device ofnode-less and teach the failing call site to tolerate
ofnode_null(), or use a specific getter that does the right thing.

Regards,
Simon
