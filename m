Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5920C531D0
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 01:02:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B4E760B49;
	Fri, 24 Jul 2026 01:02:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7BN2-PI5fJFg; Fri, 24 Jul 2026 01:02:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9963760B27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784854941;
	bh=GBVxXcRnvkAMERmNZLyZ+WWWJcTMN/d+KarrNUc+mIE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iJWqocKHudGWgQjm8LC/ccPN9xwSPY7/OzTkyLf7eIG0uAiQ7xI+mf8FrkDvMfBjg
	 s5b9Q8vQroNeShg9txtWuxjcfTRLJe83Qx8B60h9rvGODLEWHjk5iOf45ndLoa7dZh
	 C8D6udBrVYTPpFyMf46ilJ6hHgI+KZa2hjDx5PB3H+UGupIPmA3hFGlwCtlnghFjoq
	 IdV22HWSjmizP7YUhX3etp7bXnVtoqYSWeDB6Woze4W+CEd3gFLj0awKkGo7X/ktKA
	 8Ha5C2thbmpbEYfUbGvOSBdAVHrfcJIYRTRmqhCjzJJIRnBlIuK0fKNF/IVBkscT99
	 RgnTBalCHc+TA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9963760B27;
	Fri, 24 Jul 2026 01:02:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 27B653B0
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0A5AB81167
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8i91YEQ2kLYX for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 01:02:10 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C53EF80F89
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C53EF80F89
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C53EF80F89
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:09 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4115A80117; Fri, 24 Jul 2026 03:02:08 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30870803F6
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 03:02:06 +0200 (CEST)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4a2fdbb7be0so571342b6e.3
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 18:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784854925; x=1785459725;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GBVxXcRnvkAMERmNZLyZ+WWWJcTMN/d+KarrNUc+mIE=;
 b=hpYD3ROC1fmFJnETaXL3O6vJrBIKufDXayaxK0TQqRXYou/ORjaeX/O3H1nJdcCWb2
 CAEUkHAQplEPD2IgFUjUtU9w5BUWNSjGS2LHIKUjOE33z0AzsAZC2hSFSRgIpWRjkvYJ
 cR4qJCrE13UhRO5BbdxhvAszaqcs1SlHsPp0egNQiYt8o+j2FRezDd4QTx58i+xW1Ftb
 73G5VOYtgqYB6qvU2MffJW+sgiUZgjxt+1GVjXDyEjXyUN9W1Jvd+mSomOLk5n+XJIBp
 wpz72UShhY4To8KNUNod9NsKOyyX2BFSYy+aBwZ2FYCeIYF5anJH9i2od1Car5dZHdTN
 1rGg==
X-Gm-Message-State: AOJu0YyYjlLR8emnXPkE2RrfhThS0QadYIVJ9JutS4igCzbwwkntempC
 IMddvhKUvPFk5KLRaTCk82OISFFdnTeLC3klrQ6iOdTl+TFt8SRHWxo9QPO99LoaPBQ=
X-Gm-Gg: AR+sD10EjVtC21tPWHpMq2S0UrhBoNMace/f9vWpNMDuTv3nlv1BRHUDVaMTOJDmNCx
 UrXf0bfra6YouiOBnA030XayWxFGbw+PLUJz28L8qWdYuwZLr1f3Ef/+TeN+3V2swmfKZOi+6yu
 U40u3ULGv+oYiu0KH+R8Ed32+iagmfGCuOzYPMLjI75M2EzMoBgCwFIXe6f8grHz00VCovvAata
 CPt94552s7zDHi62RojyjvqBsoEsOQpRNSurjqbUkE+zTQANYUCWnY9OHyaDnMq7hrGffEmcVOm
 rs8GyIrUjewv3vi/OKPpXh4t4fU7ifEKO3XNTuZmdnwagoxC2Tk7bMEIqEk80ThJ7iWB1rrBdQu
 gJWvKMMCCFUEZ6mdLj1jph0L0KjacAZHb/YG9HaBJ/AIDjMULLEb3355so6nDqSYvD02JzoqNKX
 5y5pCyurGTsKSclm24f5okKrmIVz66wQw2eKKlqvHsfbUQ4aQLpfF5knCeHqvlyUZXgYTpoLMjD
 rfq82LEe8Gd6Mt1EBhtFyetcg==
X-Received: by 2002:a05:6808:1250:b0:4a3:2bd1:5213 with SMTP id
 5614622812f47-4ab3573763bmr2404403b6e.39.1784854924751; 
 Thu, 23 Jul 2026 18:02:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ab0c7a01bbsm4196177b6e.1.2026.07.23.18.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 18:02:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aristo Chen <aristo.chen@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, 
 Ludwig Nussel <ludwig.nussel@siemens.com>, 
 Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <20260710131331.1388164-1-aristo.chen@canonical.com>
References: <20260705145445.2339-1-aristo.chen@canonical.com>
 <20260710131331.1388164-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v2] bootm: teach handle_decomp_error() about the noload
 decompression buffer
Message-Id: <178485492316.3246206.5675443617343586999.b4-ty@konsulko.com>
Date: Thu, 23 Jul 2026 19:02:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784854925; x=1785459725; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GBVxXcRnvkAMERmNZLyZ+WWWJcTMN/d+KarrNUc+mIE=;
 b=FSeEFxL9KG7ISOHbKuSAdCY8sZwWpq51/eI0hfczybBgcZRuWtEo6haGnmcyHZCYNA
 aH44+zTjLee9nFk+1nJ3kVF//s22rE3KlkN9p9UlBkhPW5vGhCJRe62uDQ9i+pp/K70C
 C6NbTokgS81O1XQsAkMkaMkNEuBCGcOeTSzVI=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=FSeEFxL9
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FSeEFxL9";
 dkim-atps=neutral
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

On Fri, 10 Jul 2026 13:13:29 +0000, Aristo Chen wrote:

> For a compressed kernel_noload image, bootm_load_os() allocates a
> per-image decompression buffer of ALIGN(image_len * 8, SZ_1M) rather
> than the global CONFIG_SYS_BOOTM_LEN. When decompression fails on that
> path, handle_decomp_error() still prints
> 
>     Image too large: increase CONFIG_SYS_BOOTM_LEN
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] bootm: teach handle_decomp_error() about the noload decompression buffer
      commit: 79b6ee1a4b3ce9ca2db0429fc2e8dfb4110cd7e8
-- 
Tom


