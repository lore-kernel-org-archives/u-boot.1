Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CF71061B18
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 23:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45E0584106;
	Tue, 31 Mar 2026 01:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VGdQ9QDL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 686818352B; Tue, 31 Mar 2026 01:00:32 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EAB2840CB
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 01:00:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-464ba2bb3aeso2972956b6e.1
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 16:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774911619; x=1775516419; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fFu1pfG12RU8fQhUy1UZv/ONEDBX/AR90AsyvtPIoqo=;
 b=VGdQ9QDLx8oexP3X6TqfNG+KN1xv8nCqRgmNQ0ju+B1g6sLz/2Sx+S5D/v8XKMeb5S
 1L1zfV6riCz9kx92wAeyo4YFbwYHjHXLpLXXgtio44Uun0SOXSjcHIR1wLS+6ZKAf6es
 sOlbP0X1ALnk9AfWJ7rjZN+EXjjP0Lk74BPQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774911619; x=1775516419;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fFu1pfG12RU8fQhUy1UZv/ONEDBX/AR90AsyvtPIoqo=;
 b=EppPh5ZNGZmLfrGayVL87jOxbafKUFuhjxPwdDQSXpwhtEfaBcZUPFERNwkPGm3eBH
 SyV87TSqDEnf6dBiGEmW8Yk5KCBPUM1MlCxDbh7yqnRn2utR0LD00QnGO0IjOykMEL80
 MPitNBg2YJYxQVCgviz/Yx1DiMOp4Q+hpBxyHxUWqxDWSjkqVn+F5CjmEf9wgumoa3sZ
 PGq6XHd3IxR38Aakt0MtfldPBO89NpRcDlkyVDNvQEekxzlfqb17Ah0uWc77g6dbkw5g
 XYUZNIOMFao++/wKcM/+m0CHZ/X9CPbj9DtOoPYc3NQMKawXQmSqwLFGRXJMTFFkUdcd
 Js+A==
X-Gm-Message-State: AOJu0YwT0vndIICMm8slV4HAuEPXq+CIKyL4ZIRZRh7RJ5VdIQXNH1ZJ
 1MFA95zlVh21GCF/DGRHO5lJVcr7izSR0kyVqC+tR3q+inSNIm2Bomipw+/2tFND4xDSucs/t+F
 UAxlxuRQ=
X-Gm-Gg: ATEYQzytLZQq2Z7QS7ks1T8rMwH6CCrD3FuuV12fF/D0e9hhtYbLorMpYWAr9cS9nR5
 3Y3b++GEFKrtEU7NRnWsBW9J8HzX2GScwDc9JdZpcnLuF3SpAh96lDdPsjiwpSRO5stjqCMjKk6
 SapkgQEIrnVPuWIX6prQZbB+zkEJbHOSXrVgc7GAW+IvEYPq4O2iYj4H7pwbEGzGkhJT0tlBbEf
 YdWMauw8jl1pOP0OBfcV/QV8PbSZU4Fny1d3rSt6cfvQUvx4hfdXDm7tHilWC17OWzCd/YjbTw3
 djuQlAPf940r6WrC745tjBXNMU1Wbggc5AhCBaF+xyB+eu8gZqztghIDhw7B5IJ6dxhKvYQ3s9M
 fMsBlhiW28M/ySbqLPJIFT6Qpp2xTZfICn3idkUgDU7NaAtrCdQCMHe5unE0gpNK3XwAyTzwE4A
 e9ZRng0LCNn2TRcGMi70iPhaGKjznlx8rcchHl7ssA88GDsWusg5LjuJgqGRabbUjtTngTwL2i0
 rzMm/jgWot8ctUq5axVRc92L4eLxJXLABc61K8Yx5aoutc=
X-Received: by 2002:a05:6808:448a:b0:467:e1a8:2b92 with SMTP id
 5614622812f47-46acdbb1b8fmr835622b6e.10.1774911618909; 
 Mon, 30 Mar 2026 16:00:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46aa03b1e64sm5644737b6e.15.2026.03.30.16.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 16:00:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260317012419.4162359-1-trini@konsulko.com>
References: <20260317012419.4162359-1-trini@konsulko.com>
Subject: Re: [PATCH] core: Rework REGMAP symbols implementation
Message-Id: <177491161834.1028292.17963143952201557621.b4-ty@konsulko.com>
Date: Mon, 30 Mar 2026 17:00:18 -0600
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

On Mon, 16 Mar 2026 19:24:19 -0600, Tom Rini wrote:

> As exposed by "make randconfig", we have an issue with the dependencies
> for REGMAP (and xPL variants). As this is a library function, it should
> always be selected and not depended on by other functionality. This is
> largely done correctly today, so just correct the few outliers.
> 
> 

Applied to u-boot/next, thanks!

[1/1] core: Rework REGMAP symbols implementation
      commit: 0da1866a8fdd4d4bc4837ef2af281dbe010ae16b
-- 
Tom


