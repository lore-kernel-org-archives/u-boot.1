Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1BDCA0EFA
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 18:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E587780422;
	Thu, 21 Aug 2025 20:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N4JoDU0H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 037868144A; Thu, 21 Aug 2025 20:49:13 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 766398004F
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 20:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-61bd4ff762eso653277eaf.3
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 11:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755802149; x=1756406949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mW1IV7TtUhTOBiSyGS/dNM8LlXFe3RwVSfUMdpGaYWk=;
 b=N4JoDU0H/JwJU1ZqAMtJ3IPOjsn+TZIYShgyWYGy4OlbyyasoXc0d1lxDvKSK0xC7N
 dLgrxZSAZW5ie62NyHfy3lpP7bP2RRDH6UQf7UkbxSZE+9idBnc+SBt++T8Iqz9WdRCd
 lkaUEs6YDIcdUKPbv7RRKZ7bM4zHUI8/e3I9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755802149; x=1756406949;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mW1IV7TtUhTOBiSyGS/dNM8LlXFe3RwVSfUMdpGaYWk=;
 b=HmJGcwMbR1cZSzeZSKc+Czv7TQi9Ug4mGO/IBWKJ6rrE0MIeAh7bIQk19MzhnLPil0
 oWXc48gC0geY4pUzB37EsXEVQQn88+xkfKlPpSkEPZmcFzxUYhIsPAjzDbXSONE6QSof
 XHRDNUBgvWephHJQKlZsKii5xasWfQaj0xYxHNM2QvKjlqoFHU7+Elhl+1LqhhfEoh2N
 6x8zVNdUSZXRo21noGPwB2RuvhHhxsYX0DWFwNOOQ/eN8J+YCu6O3D3QOoSGRgrpXmKo
 LACJ3oDzNImBJUV/O5PA22rCAoRd5Bt22pB0huPRmDT1+EYGjGy7WxD3Syg7YUx6J3oo
 bRLg==
X-Gm-Message-State: AOJu0Yzxv85mLlTPB/tcv5O/B6xc3YKIe6MKYGHu8+777mmwwxioqeEc
 r9qMQue7aiuUVCia/Y+XF8DWLG6ySaRE+ddQuCWa+dvujdV7LcnKttRfEy/HMIzRBBxGIGk6wMT
 I9JyAdQ8=
X-Gm-Gg: ASbGncvZSVrNGpQVUc1pdhPdo/zKIRKN20+tjzz+A25M6HO/ij0zqYRSyjYNmQ5hVtR
 2lYmEM/kc5kZZu0frRljyswHb9GQ/FXBFTb7mVf1iT7qdMUi0Ob7gF7srH49TkTB/FpNgf/QB0u
 P7FxW70NSJOFLJbO3WdSsOhStYCgDVsMbgsOG0fg94CCq5ztlx5Kvv7z6k9lwSvikEUMmEcyNhX
 41WR9R+P1PfpMlG9McgjbIz7x7n+CmkOX/M9t+8W5L1UMELawz1rFiqgENH4zX5M2fijwwZ9xmE
 ah2zhWN/vW4+y8ziFlCpuSg5Ooz71BSbuQYqXmN274FvExqLwb3fGBg+kTZ31CDvqserqe8xa2n
 HTvGZ6TeM0weFit2A0kKMupcB6+MRljoBHaUt+4pl1gTIA5Df/J5oOiE=
X-Google-Smtp-Source: AGHT+IFScZbj7zqbJMfceabPn8uDVQtf49411mCC0upBPf48NA5QJcc0Lh3GuI+0/4LoXXH37ysyVg==
X-Received: by 2002:a05:6870:618c:b0:2d4:e101:13ec with SMTP id
 586e51a60fabf-314dce7070cmr116510fac.33.1755802149188; 
 Thu, 21 Aug 2025 11:49:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7439203b1efsm3578313a34.27.2025.08.21.11.49.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 11:49:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250821172359.154970-1-marek.vasut+renesas@mailbox.org>
References: <20250821172359.154970-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <175580214827.915379.16525075373814963138.b4-ty@konsulko.com>
Date: Thu, 21 Aug 2025 12:49:08 -0600
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

On Thu, 21 Aug 2025 19:23:44 +0200, Marek Vasut wrote:

> DRAM controller driver off-by-one error fix.
> 
> The following changes since commit 54fbdd408873413af86d86de03a490c5abf280f1:
> 
>   Merge tag 'net-20250818' of https://source.denx.de/u-boot/custodians/u-boot-net (2025-08-18 10:54:44 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


