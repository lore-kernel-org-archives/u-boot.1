Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB62C4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 16:18:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D759D87FB5;
	Sat, 13 Apr 2024 18:18:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rkz6w3tG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 859E98801F; Sat, 13 Apr 2024 18:18:14 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6206E87F95
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 18:18:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3c603f6eb37so741322b6e.1
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 09:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713025091; x=1713629891; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a0JpThIYF4yxkvgymW8gv9Jnd48XmHJMJ8g14ef+F8E=;
 b=rkz6w3tGKQF6m/NIV4LHJH6ZnSA0UlZnleSuvXL3Ky7d/pCeYUA07dwRaIN87J7zGR
 yWNUaBNt70pDV/DxcTm5AvHVdDze1kibwU4DUXkkMKspBC4/z84yP04giWn5CMIC1Fus
 l3oiBhIx3eok+oMfysXDqVQRM5pP8j+PK4bfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713025091; x=1713629891;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a0JpThIYF4yxkvgymW8gv9Jnd48XmHJMJ8g14ef+F8E=;
 b=HhpEso1+rAIjG96xosqrRecvW8yOVqMKY3SSLMjJPMwB4c1JvotwrPLSYIqSKunsUq
 DZiZMbHfXaMwnnlMhpkIIEXR7npSX/OIENah5jviThYuSwCR1WajprmDCJRJjo9PMuKY
 dV2K8uTNFuhRas1UIxl30SsoA4s+1OTkiHrfqjZqGOjDM8mNDVjV/N4DDMyuEa/IvOOx
 1X/zq7ZU2Ht6zOlcTeK6qYJYDJp9RmxbGXLd5tx4Rl5jcuG9uFmLGOQ+S+B30k/TaETW
 KwGCbOLKu0R8lIdMbvQRAiD9SCQPjRkiCZpfK4mQUt/31xc4I1MPVh8nEXrmr0CMgvaS
 qBWQ==
X-Gm-Message-State: AOJu0YxmRXZ+dUorM6rsD99gENf7+cNIucxgszRnRQoo7EaApGcP+eps
 Ojv7utJzhkzsnR1ywuSHZjtcUIrL7yBhrxJOlvkBl5PozlALmo9ucgEjqLUP2ouTbl15460gTew
 MfN48MA==
X-Google-Smtp-Source: AGHT+IFNw5yyG5LUCXLWSswVjxaIegg/b3j7mxlKO3d9/UsmJ7BBMr4y24CjScrf3nuUKCCNybIPHA==
X-Received: by 2002:a05:6808:218c:b0:3c5:eddb:47c1 with SMTP id
 be12-20020a056808218c00b003c5eddb47c1mr7049350oib.5.1713025091154; 
 Sat, 13 Apr 2024 09:18:11 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 kk5-20020a05622a2c0500b00433002038a2sm3653937qtb.44.2024.04.13.09.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Apr 2024 09:18:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Eugene Uriev <eugeneuriev@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240331200327.29141-1-eugeneuriev@gmail.com>
References: <20240331200327.29141-1-eugeneuriev@gmail.com>
Subject: Re: [PATCH 0/9] mcheck implementation for U-Boot
Message-Id: <171302509010.1116517.17419455571970615491.b4-ty@konsulko.com>
Date: Sat, 13 Apr 2024 10:18:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Sun, 31 Mar 2024 23:03:18 +0300, Eugene Uriev wrote:

> There was no "mcheck" for U-Boot before.
> 
> Since U-Boot has only 1 thread, and normally makes 4000+ - 6000+
> mallocs, it's better to use havier canaries to protect heap-chunks.
> My variant uses 2x8 = 16byte-long protector. And
> the multiplier could be changed to tune speed/protection tradeoff.
> This protects not only against memset()-s, but against "near" wild
> pointers too, and makes more probable to catch "distant" ones.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


