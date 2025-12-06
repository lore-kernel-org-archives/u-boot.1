Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D3FD3B7D2
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 14:12:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 497BC83AA4;
	Sat,  6 Dec 2025 15:11:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OfzlWhiL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7A08839E4; Sat,  6 Dec 2025 15:11:08 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4780E83A47
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 15:11:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-450b2715b6cso1789690b6e.0
 for <u-boot@lists.denx.de>; Sat, 06 Dec 2025 06:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765030259; x=1765635059; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=64UIY99BZlBfLgZg429aGcIS6X0dC+nB33SvxGYALUA=;
 b=OfzlWhiL/FYC/Y4t0k7rNuylCa+M/dKPFbDbFU0qD/FdYKfguYjAVwXIZiG9tXW5MQ
 wGP9oSJd34gwLFo7HaxlupkjR8fmQCtQ30tTLWD1NEalsQCU4KZI+Y6JTc42I1crsD3a
 eAHWCiyLeY8P63zJqm8zeUL6Cf8p3BQ963Zew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765030259; x=1765635059;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=64UIY99BZlBfLgZg429aGcIS6X0dC+nB33SvxGYALUA=;
 b=G0aaN3RhiOCwA6FgT//MovIFmnFtTnxL7aLVq9jVgKMeSXuZTQp+b4jus0cf7KEJRx
 8Qybg1TEKpqf9SCyHrkwbDtfNvpTsTyP1SJLSLR24l5IpGRmcVNmjNeG12z/8ebHZ0iM
 +hlxJiyGfgVye7d/0HQwzvXCUdIYsR1D3iTwr9qJsP81CKYtUTYh9JUeN1iXbuJ/424J
 qiej8wqR33dU0aP4vsPO6L3wn6+cLa1yCDmsynaNSzlbZNCyA3/KgoAYkVLr62dqr4p5
 adWG/RayPKedF3QvvXCvyKF9AHruL87BywW3L35a+OqVtzYgla7E2rLafRb7Wxngh8Y9
 YulQ==
X-Gm-Message-State: AOJu0YyxYEUS5ldSXCLheCJL6NT3U2xok/DUh8UiOCPU90qzeOhZ4G8K
 n1xbzHzPpjQHuCy9MygG1/MQVJmC430z8x3lmH3GSXLWcwhnczG9h5pYG21v4ahwUaU=
X-Gm-Gg: ASbGnctR+mFtBfOr9X03X7oUujV51UOfJlH4FEsZiIxxkkkMqBVAxtrSK2KYifRELLH
 EBGfIUmhY/DfX/DDbL9e3bK2pQcJGnRDLQ8w78AQ8Bac4proysvzEjEG3Cxm65yk0rnWYrSzOz2
 Ce12GHz+Y+SiCAckaa6GgT0aTIjp8cnu5GOeKEPJF+4CWuQK+sPg/u9jV6pr+JbVoFvrMFCCnDB
 mA6XkqkYTXwIGEI5MEBXc5ij6e5Vgeoad0V4F0DAfE3caSOoygwVyMlNzkjn0idNlU3T1SCMwWd
 Wq/F/AvtYgGUcWgvIxbMVIccxvvtNJa+GxWoFZmhO+3sgfj9Hfnzv6GfgWsqCHIawiBYSi+nDed
 80+nYFd8uMYQfzDyCLzEvIOzAzEyRuorZ5utx2Plzv9x7Vjudjvu9bnYnYe6e0D/5cMSD/r2B0v
 RiNKvsf3Gn1RoOCUCXpK5MNVmDQ3mafNOq+ksFJJW35EJbcO2G
X-Google-Smtp-Source: AGHT+IGot/3Lk5BaEr4HlNX23Mdzv5Y3Z8MwioQ9n62FE3oqTpF+uqaUIOiJUfRpcizWVCa3OdjQpQ==
X-Received: by 2002:a05:6808:11c1:b0:450:340:2693 with SMTP id
 5614622812f47-4539e0c1a27mr1043272b6e.42.1765030258976; 
 Sat, 06 Dec 2025 06:10:58 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acd733bsm6078499a34.26.2025.12.06.06.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 06:10:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
In-Reply-To: <20251120041613.817311-1-marek.vasut+renesas@mailbox.org>
References: <20251120041613.817311-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] boot: Check noffset before use
Message-Id: <176503025820.2523567.12005109261657955730.b4-ty@konsulko.com>
Date: Sat, 06 Dec 2025 08:10:58 -0600
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

On Thu, 20 Nov 2025 05:15:30 +0100, Marek Vasut wrote:

> If noffset is negative, do not pass it to fit_get_name() and then further to
> libfdt, this will crash sandbox with SIGSEGV because libfdt can not handle
> negative node offsets without full tree check, which U-Boot inhibits to keep
> size lower.
> 
> Instead, always check noffset before use, and if the return value indicates
> failure, exit right away.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] boot: Check noffset before use
      commit: 717f8ded395fc0369620c3935980642fed909345
-- 
Tom


