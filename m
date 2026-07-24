Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69CDC531FA
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 08:44:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2D4380D77;
	Fri, 24 Jul 2026 08:44:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7I4mdbQm2rrF; Fri, 24 Jul 2026 08:44:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4EAB780D21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784882682;
	bh=D2o5gZ2L2kXbjJgyMF0JAHXx92biuhXxvUQACEWplnI=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=nmlFiA1Oaih4Og9/swBw6qtDKMbc8vU4QfWM0XH0fnSWFBy8+T1+2WSwLdIf++DXK
	 HqsV9Z/cCRCgJM81D6rbnaiM756+XYntrXQ0eWTLurWD3N8uc+U8wjQtCVz0TaRU1B
	 SkkvJBNCM9Id6davPnDXxeHMLPKbBPYQ7jHSdGqfPGFMd8lukiAbGvLqI7wn/KhiwD
	 PLBoFBW0I2KRdEd84WfyCmJyXGF5b4eaWdMa4p1sWpXx7c60+5/rhifS/R7MCqcFbb
	 E0JFdD2qIosT9nqjswnO+ov2HnAZgtAkWworkq4vXMpJ7E/D1zD5OmeIp112tbaqR9
	 trl06W8FpKrWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4EAB780D21;
	Fri, 24 Jul 2026 08:44:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 97DF678A
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 08:44:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 89DF1404A3
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 08:44:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B8VsDDlanAZb for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 08:44:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2F1D140064
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F1D140064
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F1D140064
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 08:44:39 +0000 (UTC)
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-84e3007a2b7so136827b3a.0
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784882678; x=1785487478;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D2o5gZ2L2kXbjJgyMF0JAHXx92biuhXxvUQACEWplnI=;
 b=WL8tx4r/SBpZ2ySPRtNbnLrfNpbllpSD+mtOdqjTSvm+hK9sBVxk8xca2iebo8lBsc
 WfvCh7DUq03rHePaTSVEH06W9TedJyrGGuBGLSV3/eYmS4j7cbTjyW/n/6uioGm79FqW
 EEw+GjAAlUm14UaA+mVySctOWiwz2yRY39UM3DDjSAEDetzdcYPMFr7fE6KArttxwPET
 i93dKh0NEaKPcOi2/zFke6UAAdCA32YeyXlWnh4awxMY1QYigWFAqWaiJCgG4FxrpxCr
 wkvW9dVYTKuGzaFpUPiHABxOrm25ISSK/7vNduUCfIThCscW0ABl7BvSTnrAfYNdg4ht
 CR3Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRiz21I58Gw2Eiw6vACvsU9CqiB7bShFlEcyojZRNY6LXh0C6PdoGXwhKpr9bL3g3fqPbEGR4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw5qVJXiSN7RcEWMcmRpWcYD/ILke680sKX9Cp46GbYdR6U2MVf
 tliYhPMGMp6oqqXvvDgbQg7Jc7uPm4UutxUo2OjlAFf6UJsk5JIJVAgS6W1ezi1N+6I=
X-Gm-Gg: AR+sD12HDGOZ2yDDTgpaBo15WpVAibPDYSmYNhDsgP8I+ib2UEZ84elZzcYjXrWKIBB
 /l4xlMFZcYFKX3fAXIw1B6noz/6d/76krMgDma8t9emFVjkUcvKFnAbiqjMOTHvI3TeYsnNA6S5
 A1ricJUxI5gNROqB1AiCkho+mm6IR1lz7yoVrH+HxyBQaS6Gf38LuQG92gN2k26OMf7P8NnmfRU
 l51XukUVnr7MeAFvv2uFYT0JgcLo2kM/H3Na8Vx3AqNgFLeoA4pmoWVEk/DwoS1KO5/9MSpEAhF
 WLjdd3y+gb1s6hjSbeIRyAGLu6j/6BQMhF5Ag8fdYT9UH4rJov7eHP2DIcrLjIDcnsllitE23zL
 piGJhMoVUcNI0WfPhXVAznPXoEpWKbvmCy+5ajbAQuyK2JjtbSq/BSXS8yFrt/kTVYVj5IZABps
 mfHrEVcEBWPBfNl9Uf4pk=
X-Received: by 2002:a05:6a00:13aa:b0:847:77e9:acbb with SMTP id
 d2e1a72fcca58-84e2b7e6d44mr6714441b3a.13.1784882678461; 
 Fri, 24 Jul 2026 01:44:38 -0700 (PDT)
Received: from lliang-1876.localdomain ([136.226.240.178])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e175b26bbsm4254839b3a.46.2026.07.24.01.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 01:44:37 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:44:33 +0800
To: Hiago De Franco <hfranco@baylibre.com>
Cc: u-boot@lists.denx.de, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] riscv: dts: cv18xx: fix spi node name
Message-ID: <amMlizBtI3T_aWui@lliang-1876.localdomain>
References: <20260430193518.66482-1-hfranco@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430193518.66482-1-hfranco@baylibre.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1784882678; x=1785487478;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D2o5gZ2L2kXbjJgyMF0JAHXx92biuhXxvUQACEWplnI=;
 b=F2KOqI47Ldwti2O2y88AoRSVPnXKNTb7TlgdYvV1BR3YNktIB2T/GYMuIqeaf3sqAu
 DrDs7Clh69nWP8BEPhHGsX1HHTw71go3ttS41vk7Gbg6ZuohwgxeLzflEtiVzHLCGoI6
 rBo7+6Lu85a6FXxddHVarrr8eKfikcYN18moOXMhj3Y7Z+BpHZ4AeJLZrZnVZOnz0sjk
 5KYbCbLUUpBcl1wsm+DdKDWI8Vr7ovkfgDnOelKiZ4LO/xOJCEStvBz7BXGZ2zljgfNf
 SW0/d2I0wn+ci9Ce0T6p8wx5xwFTs4EBCtT07kkQEGZRm9w1hO0qS2pIcx6Xl333ejzF
 hqJA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=F2KOqI47
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
From: Leo Liang via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Leo Liang <leo.liang@sifive.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, Apr 30, 2026 at 04:35:18PM -0300, Hiago De Franco wrote:
> Fix warning:
> arch/riscv/dts/cv18xx.dtsi:208.26-216.5: Warning (spi_bus_bridge):
> /soc/spi-nor@10000000: node name for SPI buses should be 'spi'
> 
> Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
> ---
>  arch/riscv/dts/cv18xx.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-riscv/main, thanks.

Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>

Best regards,
Leo
