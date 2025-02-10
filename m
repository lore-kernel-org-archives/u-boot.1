Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EF5C0219D
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 20:39:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAA3280BAE;
	Mon, 10 Feb 2025 21:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y72JwW2H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E7A380C91; Mon, 10 Feb 2025 21:38:51 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 087DD80548
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 21:38:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6f7031ea11cso46210497b3.2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739219928; x=1739824728; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iGdYurKqs/kdkqwQxn+A7kGkmNg+95mAUhzVVv5tI6g=;
 b=Y72JwW2Ht8XUfV6wzMCvxh16Kobu1MSKTnUlc/imbSFQJbZ/nc+pCZmEOTLgXFHfnO
 EXXNTMgtFNMeajUc+eCj0lVBJaJXg1X6FYUCSQoKL4U0lx0+01svgDCKxWchql1BI4tc
 XQ8k3MX1PtqQz2knvBaJK4gpE32wqPa6yR4Fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739219928; x=1739824728;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iGdYurKqs/kdkqwQxn+A7kGkmNg+95mAUhzVVv5tI6g=;
 b=r1iVXBetTLF3muTp8YJzH4rLtv55I9Rk8k4xUhBshLM9n6qhurhGY9nu0vNKOx+GZx
 LFnZOziwGEGL7t12sHtWN3uUF+woCWonME0h1hKtrI9rHsq59F6IAiNLLCBr7ureUmMu
 dK6BJpn9X1Ah8wXI5DH5eQSOS0HKPqFr0bfOKhHMyoq5xK4idgcKH2/X0YjMzO6lm1qS
 FEHhBI8a+HQJZj+sPuTJGggbaXrYJjZeG+BH5DxdNZuGoXP6P/aBS9XnORjVsMZHQupW
 oCi6tmAnDhLMsH33yiQ+vYNo7weTEVAxx9fv1MWfgx/eGMjMXp2Jo/8WWRGOA228VnKb
 PBcw==
X-Gm-Message-State: AOJu0YzRRmE0UKpf7Xeii8wG4zAoNWNIpE2lByFFxbnM9hNkvUPrsIdM
 87KWT5t57MOBUfRwWeOYfBmDdjb4cv0j6U+ULo02fSyrYABLO/7UeebnYAGShnr9k5khUI1JuGP
 N
X-Gm-Gg: ASbGncvw2H9LpEYphsDNRZL6yC/6I9yQ9MCEgD07yU7Mgs/cyAYmjEJF2ieR+/kL3io
 xirSuIk/OeOTYWUEM1vmFiOJFrizO3u6uP11dUbbJPipvXCK20j7qe9WQjw25Gn73FC+4E+FrF7
 K3PoQqOa2atjrtNFJWzc16n6IhWxTJKEugoPI1FXhNO/jHqjpL1ua/skl41ekd0zWkhEzYNy0QI
 kNMkpP0SDgzmO4fTKLD3R96XcO1DgzxmUNcX6vvrxDCX/HKOqA52go7FmFXdAChO0e6z6wp8vCF
 Wx33Q9JFMr48OQ==
X-Google-Smtp-Source: AGHT+IHQgkFMkxCDc2HP9svFBO3cOVO4BoNrOe3e8OzTCmHUFgGcmwodiTEnLlEwOuE45WhGpVkm1A==
X-Received: by 2002:a05:690c:25c5:b0:6f7:409c:f659 with SMTP id
 00721157ae682-6f9b2845068mr129861577b3.8.1739219927909; 
 Mon, 10 Feb 2025 12:38:47 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ff6a8d8sm18233207b3.79.2025.02.10.12.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 12:38:47 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
In-Reply-To: <20250205012437.111689-1-weijie.gao@mediatek.com>
References: <20250205012437.111689-1-weijie.gao@mediatek.com>
Subject: Re: [PATCH] mediatek: mt7981: enable ethernet switch auto-detction
Message-Id: <173921992705.2921783.7573168916182604822.b4-ty@konsulko.com>
Date: Mon, 10 Feb 2025 14:38:47 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 05 Feb 2025 09:24:37 +0800, Weijie Gao wrote:

> This patch enables switch auto-detction for mt7981 as some new mt7981
> boards will use AN8855 ethernet switch.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


