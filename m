Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A047C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34E9C80C34;
	Mon,  3 Aug 2026 19:13:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vR99W-EocDCr; Mon,  3 Aug 2026 19:13:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C904580BCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785784384;
	bh=ldmLs93zQiKS8UodQadQH2MKKsavVTNHpcIyrXp9F6M=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EWrzhGcHat1U0M58h3ecMR5XPBZZfhx6bGZJGmCHzp62jwMlhXvOQ2GfkbIH+RDr/
	 VpkOQGNXROInTAF1j3tSBQEwAVGdOjKEi/+rvs9sgE4HjfdLjuFo6BOQgcdi8yERb1
	 GoyZS6Q3uVKqW3v7ykQhMronNj+s7V62mdcn1Ir8hcIFi1QwnqAaCO6B/7WbCh79lF
	 mf7598z9iNJo9PmdEtwsyZSTjhtDQnhZt9yGMkMCCxsXL9gooa0sTvWtphAIUbDK6G
	 /IzNlIkZk2SDnMSicRHtys/uuhPdISXmreVmKvnPQH/KBFcAfc6VzIhDbt9U99I5ji
	 SkUD71SAm7WKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C904580BCD;
	Mon,  3 Aug 2026 19:13:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E8065296
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:13:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CE4DF405C5
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:13:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id na1SoEGjmsoo for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:13:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EC724405BF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EC724405BF
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EC724405BF
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:13:01 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6a09571dd5cso608379a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 12:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785784380; x=1786389180;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ldmLs93zQiKS8UodQadQH2MKKsavVTNHpcIyrXp9F6M=;
 b=pj1MfXEZXxpAGdhG4ypPutiG6v6+6z+68k3wiSWH4BrMYi5CVHQmdLIGRbP7k3F5Uo
 k3V6TPPwRWXisTIa8sE+CDrHwN/VqO7+tu97AKu8CU3piDb7+WkHftoe5sl3Tt8gSrud
 s6575ljx9HnPYidpjpxf6wwDzlYASiCE655yNXcxhQ9mML2ZpQNvJ3rfnmBg6JIoU/Z/
 I2lPFsSAHaaASY4bBm2cRJjxKSVzuZbPsmOtSap1zko70SJoe7vGhcongLYifMvsfvbr
 YaggK1kCtOwYHNOX8I4XY3ULnHN2rQRXF2TG7b3gutmBidZf61ACLPV53wHzGmK69l4s
 YvKg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/p+D4nI7r0Dwvv3Bnpo4x0aV3v4eWEFCCtQGcXYMIeZxJrICOGgf+wOc+p16rnIUhb8yIm/4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzGtJo5TqULFFrcse6A85SWqHQo2m/IaMyPCa7DtFoERgZzt8Q8
 JxIcju9kz7shmCF6zcyz5sP3NAKkOmowFQU3AaIEQq6KBGS/RV5NHAAA
X-Gm-Gg: AR+sD10iLtBcfUMY5JQFPtlV+US5yNCEWn2JBT0CCEonb1OmzSPNgLozBdLhgHkPDtV
 QAouXB/+/kMeBcHFeeldiArVyHPbzlYCea0HWsRHbkEXBQbYv934LBAVVS/jejZsYAj96d8Q60B
 gzqgT1IBXXAg5P61enACCKf5dK05+KFAuB/DnQjF9TUka3L7Lz/9s749Ppj6aRrkk4Lmv7Hig+Y
 xZuLgrUgySzlSLLqsUFdEnM05yltPTYqHkyVTsMUL9OI20Xz7FlWOdXpaMz2zf16uKc6XGLXYKR
 Bu10WbeHnb5W63XkaXL89sYu94gA5/v7GsxhVrQpQQxrZY0vQUpyt5fvztrEWKRbwqacQiNyXj8
 0PymZymqGUCCCPUawzCqUTPKM6ou3FSuSPeOIyIY/68jB00ebgvlyd07pljxASXadt6FXGrCpia
 njlrPFgdhpaHjjnBd+7ajuCLOWBsF/bs0KQMOyE6X3JHUoJ1ocrw05+TRkTVog2XebirqhYhDtC
 GQ2zbRJ4aVpEJi9wWfjar+He1I=
X-Received: by 2002:a05:6402:400e:b0:6a0:10c8:8f2 with SMTP id
 4fb4d7f45d1cf-6a0a7d2d573mr5001155a12.3.1785784379811; 
 Mon, 03 Aug 2026 12:12:59 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a0c6ff04d1sm2928513a12.11.2026.08.03.12.12.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 12:12:59 -0700 (PDT)
Message-ID: <2712b581-461d-49b0-af20-8abe98181d48@gmail.com>
Date: Mon, 3 Aug 2026 21:12:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 6/9] rockchip: tools: rkspi: remove reference to
 README.rockchip
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <d15555b5-e57b-4567-ab70-56d48fd4b878@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <d15555b5-e57b-4567-ab70-56d48fd4b878@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785784380; x=1786389180;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ldmLs93zQiKS8UodQadQH2MKKsavVTNHpcIyrXp9F6M=;
 b=JZVWatGJzcqSR701TCcDOJ/Z/mSMZhY4ZQS2nJyvizgnnkpMxBZaSoLArBRc9gRg8Q
 woNnyabUsg3ResgySYdD6YI7zJ5nFuqk+Gpi0aXvhd65Wf97+m+gBr8/KVMIQXZI+vWG
 UJPIzydm947OrLGz/JsxWw6fv5Wj81KchYGeg2JYaKnv/Tm2XNOVUMN587Fkn6Fh/deP
 O2CBTsDYoE6HMXxbBkCJrAFkNy9NsupT4b5ChJUz6qf/ip5amxMxF9HyUJXkbEclTFIl
 s4W2aFyBRf2s/DGDtWwvfjI3FkO2/VzScr5DlFjF0pIA9f+6KLYZZiu4k45CXz7b+xo0
 c66Q==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=JZVWatGJ
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

README.rockchip must be removed.
Remove the reference to README.rockchip in rkspi.c

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 tools/rkspi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/rkspi.c b/tools/rkspi.c
index f2530f7bde34..63770b61effb 100644
--- a/tools/rkspi.c
+++ b/tools/rkspi.c
@@ -2,8 +2,6 @@
 /*
  * (C) Copyright 2015 Google,  Inc
  * Written by Simon Glass <sjg@chromium.org>
- *
- * See README.rockchip for details of the rkspi format
  */
 
 #include "imagetool.h"
-- 
2.39.5

