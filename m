Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFA1CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 17:01:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 878F2848F5;
	Mon, 25 May 2026 19:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EqvLqL4i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F57C848DC; Mon, 25 May 2026 19:01:26 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13F9C847EF
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 19:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-47c918c62b4so6373715b6e.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 10:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779728483; x=1780333283; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kFizwmCoFElwcMecYKJLqTSi2GZz+iDNgLvO9Roq39E=;
 b=EqvLqL4iAx7Mbm1snIWefmzx3/79Nuhk1UsoIWSLvsN95nEer0uPFlaeG/UtJUYBGv
 7jr3CG4OiZVKwhNzD6WZvqCuRJQzAuEfppV/gJMrJ4tMB+TlDMNaQiBTQ3EBtMFDbqT/
 skrMa2tTr8DFm8U5lwBcFFywqhsGsaO64Xa+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779728483; x=1780333283;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kFizwmCoFElwcMecYKJLqTSi2GZz+iDNgLvO9Roq39E=;
 b=SjX4rUPs4PBJPVbGx+JTzUk4lEXLOJNdcnv1bq1bf2tV/K97bIiR+aFmu7MLub7zgI
 jgyXsK8DTpSfYHTnMyEQ9nO2KFmxk0UvNZ6GFnwfEtUBoSncZnUu0iWq6hqXP7RL25FF
 V3bwVsjrcJjOKDna6nGRcFh7Uj5nDBNZXHuEcYQ1QbJ8RDlDSL4ZNTMA6LNBEKNGDv+X
 CCyTU7xOFMPN9cFk2nPTfSYdbV6XEvUZE/Lawn0fAdtUJOzjc4Ii4UK5uy36uD7SnID3
 E8oufhZ1uVLXDWcDq5yKkpvZ1k9+ma+uTo8zAHYBCl8fWAT8MbTn8OWLgWIDVuM+xub8
 kvjQ==
X-Gm-Message-State: AOJu0YwkXBcGcaHqqCZK0E2r3TY0b2OuAbX7RaySXe7KNNetmNpYhR2U
 XeCn7CiKEBkrK+FAfJ1NgFzfea4XhzbxAyI6Ub6u5XVh9M+zsM0WKEmwMW1b2B1uJujvUTzt/zD
 BEz0PIPA=
X-Gm-Gg: Acq92OHY1HICUp/A2OMiTdTB28IrWUdHTro7xgszvkGTD8sIsxMIolhTsYBTaVklgJC
 w6iVjlguZECgqr4N5Ml/XL1DFEAlyPrbkbFrh7QHxRVol0hq9dqBgLrUgovfKP7SF49AuLUAnj0
 UgmbvCT0wHwVb27sAfBsHpoakkpApfjhqa9K+ZxczbBhLN0WiFqW4HpzejchSWfiQZTWXsfukV8
 BDYIaamPLlS/Xlvt1HVEbzDMA6IDUGXFUkMVCNyF0RqHAz7pwN8yj4fkYEl+7snJ/dzpL7arqq1
 r5gTx4blRNrO8zC/VXWyEytdwLjLrN7q/7/n3rmEmtS1gUwjCSIBXsVju8Ktpw5qarEv2hO3hSY
 aYH0MkJzmWqdJdaLQCUSjQsfHnhrSTvxbTZlEeOdZyU/1Df+lm3RyPeWwVR41PS4DdOT93Anjkr
 OJRT0QUC67/z19WFUalEQsyV4nG6lF+Vn4QsvtD8CuveN/gKjVRDRvookDwa/2K0/sKizQJFN/z
 LD27sG97EcDNfAEmOT8Go/Eo6PWGd6WAEJ3Pk2EAzFG
X-Received: by 2002:a05:6808:3998:b0:475:be6f:aa with SMTP id
 5614622812f47-4854a1b31cdmr8923746b6e.19.1779728482701; 
 Mon, 25 May 2026 10:01:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-485546edd14sm4993136b6e.10.2026.05.25.10.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 10:01:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260522235838.2536318-1-trini@konsulko.com>
References: <20260522235838.2536318-1-trini@konsulko.com>
Subject: Re: [PATCH] global: Update URL for U-Boot project
Message-Id: <177972848191.683406.3461294016979485262.b4-ty@konsulko.com>
Date: Mon, 25 May 2026 11:01:21 -0600
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

On Fri, 22 May 2026 17:58:38 -0600, Tom Rini wrote:

> Our official domain is now u-boot-project.org, so update all in-tree
> references to use the correct domain.
> 
> 

Applied to u-boot/master, thanks!

[1/1] global: Update URL for U-Boot project
      commit: 7c419d4b578492e9781d4d7e755809c78c2c3661
-- 
Tom


