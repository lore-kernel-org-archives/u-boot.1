Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439BBCFC509
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 21:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E83F83A41;
	Fri, 21 Nov 2025 22:40:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hYjQUgK4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A8E83A5A; Fri, 21 Nov 2025 22:40:22 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 165CB83A2B
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 22:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c75a5cb752so1452148a34.2
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 13:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763761219; x=1764366019; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gyhT1yZaqiepZ8u0mKRvCDEc6gzJSawpUxWnzYrCHBQ=;
 b=hYjQUgK4bUY5MZOzykH7vBCO8gppASVE075ryFfObtM0xYauxeLA+JM+d+IfS86eDx
 zlA+3g17zJrEo2kWscAplliAoEsrqWYDHLs7SCD85o8Pbl9hBYY255CJdbwqWRM6Yx5A
 0glhAyJf0+2OEyC7plsL+LbDKLXf5TfMKcEsFVouwZmnhZd0TaX3csDoS+fAHDKmJGto
 QUQZ5Au7UHyPU8/2cmaEM6fFwmcR2H29lsdvRW+NLZ9FPw8xrlwqidHQZpHqaF+OEJN4
 ZiTDGHIRET5wUP9RK/QHgfWyPKOXbY+mWzF4srUu4xzUWFF2QHGeRt6CzlhCnZfJCZX7
 VUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763761219; x=1764366019;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gyhT1yZaqiepZ8u0mKRvCDEc6gzJSawpUxWnzYrCHBQ=;
 b=DoJRtbHt2RFMv8VncfNNNP7VxXRiekbsJAooZS+6XjenRREXTkJM5gO5TpGySFNpuS
 SINWGm2JmcK2PShVVVls7sg4u58hDtO4aqxiZt9DRHMKKN+/JiH3xxwQEGv8FbgzIr6x
 MmQvbdG1QAASWI9RZVhgQznsf5cQannAw/XYZ/wmEigrFCBvAw3vtzHk+TWD7RaWm+7T
 kxnlBH9o9Ux9cvEgRURMR3MreeW/azM2HsQQL9Q7Ua09qYFytx4GHt0kgRGm8hkFQAZb
 D9EztqBtJnO+tANv+BswAFLRGC9pdzDvvxawLU76GT8qGlQw/UNAg62MC0+IK/P6molL
 cg3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDcTjS3AniUeMygfxk6ZhUjZjoq95c/2bvot4MI+fG5avIz2XHMVk3WaG4I7UCzsJBTn//4tY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2UYciS0mDZAuE+gH2daD+re1oGqAbQMHkJRVeTErWQn97/jds
 sAteE4LaVHx1SA7LCyVyrRsmGYmuxmh3kHCJHOkMMfUlPU7PKffBII8lRw5k42eFJiRBr+08ha0
 v8bavbh8sjL+MI0opaQqzUPLZ/DKwT+8=
X-Gm-Gg: ASbGncvownsmH6Mt+C5g3Y1F3WRQRL6JFMlbXa9YeKwu+SJCoS29sggAVutpxtUA4C/
 vQAuZsQLKIpujgCyAH2SGoJ10xasESdCuZrfEcs3Ki2YOpSa5eEFFd7NqM4aDfvdYSc4XFYxDwA
 rGeVn1t3MKM8VWNDczrlCAWWd8m4A405xUFTzPsUb0w+xnETZ7R4eD03jVuUw6/kXuf2PD02t1P
 s9pSFHcXUg1RAJS1dq1eq/ivtG5YIFtJeigwa3mRlR1QexMx1x/+SH0cA7J2IlRQTRddzIYNndv
 DWMJ/g==
X-Google-Smtp-Source: AGHT+IGKCrUNc9CbfrEuNjY+vGG+ixIs6n8d3tgZwOUSvfira3+puSSCw1GhGnTVwz9fPyTzKIt+7bxuIbAPzfkVmTA=
X-Received: by 2002:a05:6830:264a:b0:7c7:e29:70ca with SMTP id
 46e09a7af769-7c798ccd9a4mr1858354a34.22.1763761218691; Fri, 21 Nov 2025
 13:40:18 -0800 (PST)
MIME-Version: 1.0
References: <20251119111653.456-1-briansune@gmail.com>
In-Reply-To: <20251119111653.456-1-briansune@gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Sat, 22 Nov 2025 05:40:06 +0800
X-Gm-Features: AWmQ_bmyILqGycNzN0Eo-kbgoG6aTkouGrJpioxY9h0-Q3oGAB2o2KFuPt580cw
Message-ID: <CAN7C2SDvkci+ss2v6RjwEnmfWF5Of7wxSSHbsYwnd8Q39jZs-A@mail.gmail.com>
Subject: Re: [PATCH v8] Add optimized Makefile support for SoCFPGA handoff
To: Chee Tien Fong <tienfong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

> - Introduce socfpga_g5_handoff_prepare target in U-Boot
>   arch/arm/mach-socfpga/config.mk
> - Users can convert the handoff via make prepare.
> - Detects Altera/Intel SoCFPGA boards from .config
> - Combines vendor/board extraction into a single shell call
> - Checks for hps_isw_handoff folder and .hiof files
> - Uses ls -d instead of find for faster folder detection
> - Runs BSP generator script only if files exist
> - Non-blocking: continues if handoff folder or files are missing
> - HANDOFF_PATH user define allows overriding auto-detected folder
> - Minimizes subshells and other slow constructs for faster CI

Hi T.F.

Please review the new version.
Thanks,

Brian
