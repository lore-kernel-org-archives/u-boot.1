Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5548DC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 19:50:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7341C885BF;
	Fri, 28 Jun 2024 21:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A8ITaIWb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ACB188578; Fri, 28 Jun 2024 21:49:32 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFE15885A0
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 21:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3d5c32840efso922942b6e.0
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 12:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719604169; x=1720208969; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y4eETtahG/lVsqv/BofjgRzwf1/LtnrnwK6zcx2J/Yo=;
 b=A8ITaIWbaq/pQZeWB+qX52RpneFPYXMD6+d6tHx+czzKFFhf0jsIZoeHen8REZgYDx
 8oCsfKKEMIwJsgevHupJTOuDrywcnAIgYyVaAKV8nOVLjET82RgxaQBo7hR0BplDnEIB
 wm2Fj51WUXkYtc4UcFvoRNS3GKYbTCUatb69M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719604169; x=1720208969;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y4eETtahG/lVsqv/BofjgRzwf1/LtnrnwK6zcx2J/Yo=;
 b=wn4x7JWRMa/T+N4f7Y7mH9MK1/VMQr3i2hN7XJehmNjKa4I9xMUOhP3V+STqsemNTt
 BlTu7RYMw/sBf83+poWWcgDWJ2PaAKfNjnendeONRiP/TBh9q8idj2eNgn/6PHVnOKjp
 RGE3iaG1HjktBY8/NF1rBlnmyJIAf7YIDUcCCELWuCb0Grdv+8a05ne5y3Mg20GRYuDy
 KN1HTFYM/81UaqS7sV0joKMcWb30ALNm3mj/IAaD21KiRtvbPtUidmsFZREnU2JsCyA0
 T7IfZTzD+Nu0H4syhPfZHuw06A93UUBsOa3AMNfs4ZRQ5Nw69C102YCK9nmNrsaoRqby
 J6pA==
X-Gm-Message-State: AOJu0YwEt/XKY0qXboQxUj5+cPfSwdS6JAYsxFNLGO9DHFp958fE/QCe
 7LKUKJp635rS7ME1nBqUuV+fJmnGgAJ0qWdlKeVErAhjuKTw5EjVsNhZNhBB2pI=
X-Google-Smtp-Source: AGHT+IF9o9rdk4TEVYChyVPYeRj2XaTnJjaQNlb3apJmWuOanZzQEzn3AlZBycVEcafQNC07hpH48A==
X-Received: by 2002:a05:6808:19a2:b0:3d5:6569:61c1 with SMTP id
 5614622812f47-3d6314dba36mr995941b6e.28.1719604168741; 
 Fri, 28 Jun 2024 12:49:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d62f9e5fd5sm414579b6e.22.2024.06.28.12.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 12:49:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Emil Kronborg <emil.kronborg@protonmail.com>
Cc: sr@denx.de, rasmus.villemoes@prevas.dk
In-Reply-To: <20240619105735.42745-1-emil.kronborg@protonmail.com>
References: <20240619105735.42745-1-emil.kronborg@protonmail.com>
Subject: Re: [PATCH] arm: davinci: remove unused watchdog functions
Message-Id: <171960416766.3614069.4424828997177748300.b4-ty@konsulko.com>
Date: Fri, 28 Jun 2024 13:49:27 -0600
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

On Wed, 19 Jun 2024 10:57:49 +0000, Emil Kronborg wrote:

> The davinci_hw_watchdog_ functions are defined but never called from
> anywhere. Commit 881ae794b93b ("calimain: remove board") eliminated the
> last call to these functions.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


