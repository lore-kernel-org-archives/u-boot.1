Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8606C3ABD8
	for <u-boot@archiver.kernel.org>; Sun, 18 May 2025 15:32:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09C65803DF;
	Sun, 18 May 2025 17:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mdJqid0R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5049D8059D; Sun, 18 May 2025 17:32:01 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD0F38004F
 for <u-boot@lists.denx.de>; Sun, 18 May 2025 17:31:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3f7f7b70aebso3003071b6e.2
 for <u-boot@lists.denx.de>; Sun, 18 May 2025 08:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747582317; x=1748187117; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1R2pVF32YcxJpg8kY1ZmkUbil9lQtoG6/N4OgmMBduY=;
 b=mdJqid0RMIzUgv8GS7fXO9YzOjcZn++TyRjHyBcVy6LZMd+g5YBnQborw6OmM4MElA
 H29O8Iw6n2HGMxvQEd5F5vmJxtkvmYZT9IxYzM4OPjX0mDjirV5aXp6xxVxVT+MJK6Tl
 wib7nNssFkSjhnh7lydEeN4EZgqWjcpy5Opl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747582317; x=1748187117;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1R2pVF32YcxJpg8kY1ZmkUbil9lQtoG6/N4OgmMBduY=;
 b=lBgUWb71tgNLhnseNHiPgbVG2r4+WQpAYxj2DK+eKXmDBwei2wGN5BZDNwhP78l8L6
 qB4oBMF5bC2MpR2ePqTkCDZV5B/PxRQjytkv5FRFhgJJsqytQ40DFyogtzrE2BiKz5qx
 77SmMqyMYUVjSfkZsnB5kuTD2rPoudekKVg17COCiXgHA8M72zcATwP9w8rcJZQc5JWS
 pVaP2xqtSLRPOfdSSYwF4mqDBSZxhbZYynFGfc3GJMUtaS6OX3aVDnr6LBjwV5HMgW2U
 qdj87nfW2lE/f8bRG7Lbn6gnknmvTzpO0Pcae536B1lWNtEfNFbjXJb1+RxzfjaiFq1A
 w0YA==
X-Gm-Message-State: AOJu0YxmMePupYKg2r0RfMCI8Q3c3FwHmhDD9TVHRnO+i2Yq66PPPYAf
 URYEcyLbxfk7hxgzwcG/6G4LE+wlCjhH/2z32oxCe6ejjbzD+OKs1MOB0KogQwl4B2ZQPiKTXm7
 a9xwj
X-Gm-Gg: ASbGnctTnz3nMGStbGe5FDVEZr29Q1ZfKCfZO3bNyCMjNPeTFApcN7xEM1v6eYwP2Zr
 wH41QKSbm7tZJ/GryRsFXrMIhNQO8wYHeozG/bD2xrdfC3FISCW8Y8lHF9aaiP5FQJaVCoMxC8m
 xcRjUlTJzJD+EYTRyFpkF7rUlC4ZmottBrOy/8vwjxlxdfNaayR4vFryt+czgvfncVrrV1nMt8x
 MnDkhGTJkJFiP+STAJWWwWbt1HdndrXJrqK8z9NMMti/V+j6cUL95GegpwdR5YufGlZOaoCRHKw
 4+bp/OQ8/YfhXpB1yL3P7NZSj/UNyqrAf+kqcqfHPWM8ziH+QPq5PaxhUJHQoPqFalpNU99hslK
 YiHzpEZDaFkw=
X-Google-Smtp-Source: AGHT+IFmkjX1APn0SsEHppEM/1oyFinc1YEvyRtQ3/ax9meWAYAfo+kYIyL2zcedRwCXhHcDFCgKIg==
X-Received: by 2002:a05:6808:80a9:b0:400:32b9:7926 with SMTP id
 5614622812f47-404d863751cmr6380740b6e.6.1747582317669; 
 Sun, 18 May 2025 08:31:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-404d98b2714sm1049181b6e.39.2025.05.18.08.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 08:31:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <98d37342-2e0d-4de1-861a-6b8d95d867ea@gmx.de>
References: <98d37342-2e0d-4de1-861a-6b8d95d867ea@gmx.de>
Subject: Re: Pull request efi-2025-07-rc3-2
Message-Id: <174758231607.3240136.9771146711872830619.b4-ty@konsulko.com>
Date: Sun, 18 May 2025 09:31:56 -0600
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

On Sun, 18 May 2025 10:51:00 +0200, Heinrich Schuchardt wrote:

> The following changes since commit 126a88d49bcae04bbfc0d6723097cd6341355ade:
> 
>    Merge tag 'u-boot-watchdog-20250516' of
> https://source.denx.de/u-boot/custodians/u-boot-watchdog (2025-05-16
> 11:05:27 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


