Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70412C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 20:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 269E684A67;
	Fri,  3 Jul 2026 22:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RRL0rYZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DF3E849E5; Fri,  3 Jul 2026 22:32:07 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ABB384A0F
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 22:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e6b554044fso680426a34.0
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 13:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783110724; x=1783715524; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=snCdKJDyRJqfcRKlS59Z/mgFez1M/oubfV12pHp6WBE=;
 b=RRL0rYZ4OZkU/Vl+7Zwzwk3DoEM2U0ikx0Ka5Wv+8JildvoBRFK0P3X97A264bJIUN
 78YrFHBVu/5WLJOhMEthcazyVDviPS3YUCmJuBdgRccXJbZC2Ee5vqytrDd09KXYBR4/
 7SD6bMspkJBIbxdem2jOtdGnUy16SOtSNK7Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783110724; x=1783715524;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=snCdKJDyRJqfcRKlS59Z/mgFez1M/oubfV12pHp6WBE=;
 b=GFDQScyn7EbhcccvOl4qKzp2644lagfZBEW5lzatOB87Z/tg+gTvMobMEB0sXRMDwX
 BhJJdzrj3wNNOFMZTJyZrpaFkPrqPLUQ6dxpRyMGzqunQyXs0wwVU1F6nVbR5nAJeAmY
 Tl1bzC40H7qSb0mX55d2y35oL5awuvUS2mnQqNxZdyBtxVhza/jdqyqdJlFk/uaKaM/F
 tLwHrMpuNHql4nN5Bo7NxSYlnDr0fSCloQV5HSzA1jG/dMvhMApCTqtaxP2dFMQAffnz
 i+6P+aVCN6T5Efgo+ObqzGRM2ig3q1hYFbbLPC2DTaPEH3za289S1vP8TzC23DKWBMja
 OcBw==
X-Gm-Message-State: AOJu0YxLohYMCZyxkUtgO7zWC3bEsfo0nf5iS5Mvvzu9O0Awwo3X3F/S
 RlOX88xP9k1GWlD53peaCNRecyy5kdyItQE7SqIEVgFzilPHEODdlnGrbvLpB+1+UVs=
X-Gm-Gg: AfdE7ck87c9xfuCHqDk1dA08BKp8CMF7uSNb2pCADRzBYyqlTKwZO5u8J9LMZ5JWM/b
 u8RJgKWkDfAw6V4JCKKe4yEp86nI4kre2+koR5+Bsr4W2MlRL/hRc0lVOlFzPeyjwj0kd/FR31p
 2ulSJ3mONCQOhEw9HK7glj/XhBr/L+2e5VyCqPnBv2C7QURn4ygNrFu+BPFzcJTcgPhgXaEt/mO
 2MlQCVfVLAktnz4jf/EFJ/10WAvjVcFRbBYkGKWUS1Z+IrxIqMcUTl9wjLaEI2+6zGCpt3sZiV4
 sHgYIgN7b5p6Q5ObtBigQ7I82hKjTKbNDdMZPfCC8tGiAyT1tTviBinogY1hHLSxd/VgNlc0yCt
 m1ynsvQPceqVkWxv7TRFsnDjmj3TA/r/lBAh8D71FPJapaClyzv9gdJBcBSOJcrf4oBxFUxApbm
 rJOKWBgpDgM4J2A7L8FR6mQeYj0mE4hnFhz2JLBNPYwBt1nqQveijZZ9z6tP8R5UHq3nBvxUc/N
 c2E5gZt9QMF7H4iNZ0nL64kWdlKTabHpW8K
X-Received: by 2002:a05:6820:6ac5:b0:6a1:50eb:d4fb with SMTP id
 006d021491bc7-6a32f57ca48mr390734eaf.60.1783110723771; 
 Fri, 03 Jul 2026 13:32:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1bb17fsm2917874fac.5.2026.07.03.13.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 13:32:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Nora Schiffer <nora.schiffer@ew.tq-group.com>
Cc: u-boot@ew.tq-group.com, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>
In-Reply-To: <20260622111933.1488593-1-nora.schiffer@ew.tq-group.com>
References: <20260622111933.1488593-1-nora.schiffer@ew.tq-group.com>
Subject: Re: [PATCH v2 1/3] bootm: fix flush_cache() with IH_TYPE_KERNEL_NOLOAD
Message-Id: <178311072300.3138827.15419616193590905354.b4-ty@konsulko.com>
Date: Fri, 03 Jul 2026 14:32:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Mon, 22 Jun 2026 13:19:31 +0200, Nora Schiffer wrote:

> `flush_start` must be set after `load` has been assigned.
> 
> 

Applied to u-boot/next, thanks!

[1/3] bootm: fix flush_cache() with IH_TYPE_KERNEL_NOLOAD
      commit: 0f890963da2d463dd47ec77ef75b1324cc8064f9
[2/3] bootm: warn about load address for IH_TYPE_KERNEL_NOLOAD in FIT
      commit: c2abc606653e7eb1e8dbdbaaf1eac392689875ea
[3/3] bootm: allow omitting entry point for IH_TYPE_KERNEL_NOLOAD
      commit: c63051237f2bc79838a27473709948408acdf38b
-- 
Tom


