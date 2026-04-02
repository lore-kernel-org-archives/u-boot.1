Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1001DD6AAEC
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 18:46:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43693840F1;
	Thu,  2 Apr 2026 20:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bQN6gdhR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C004B84056; Thu,  2 Apr 2026 20:46:00 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A42F383CF5
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 20:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4645dde00a7so1756195b6e.1
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 11:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775155557; x=1775760357; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IKxyjCvIJpEgSrsgg8MIB136uBH96o+NxDfQjgk6uqk=;
 b=bQN6gdhRFDKZ+pLO+yQS+wyuWly1bQ2TWdj4fZx3gZgsEezfU7n+pyfZChMedYaXVL
 6nf78zqCccER9LbfyvAg9/U/ND1Z/nhoE+HetTL07oUaLsovy2/suiUEVWfd7JP9hQ5u
 97g6ipTbQ09UyYk9tRGQS5civH7g4ALanZ4VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775155557; x=1775760357;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IKxyjCvIJpEgSrsgg8MIB136uBH96o+NxDfQjgk6uqk=;
 b=qeaLF/sg/rRSf2kGGBylp+pwODRDti01+gE254QVT/uftZiEVH9mJyHaO835JXD74I
 b+APm73mbqVOX/iHo7aKnxFbH36OJZkLRJzxkDRMvZI+zmBdEqIV0jZIXn/dSIQMlyhH
 8WG/bZ8mB0UFHRSWuECmTQdGTnHxrU+69922RYYOiCYngF7FncvI8df6XZH07apLuZI6
 NQCczM24QlQOBPwAoUz2TPp8IdfdwfipzAQXs8MuZJ5ishwu3jf4s7ls1eivqdpFqLMG
 yYHWL3eY/mJmdtGWWv1jSsJl7L8At9yQtXQqJU2SItdnoTwyi7I+sBJD0b8cu7aoXBPX
 4k4A==
X-Gm-Message-State: AOJu0YxJNGuCbsRmC3KfuL8z9cLUc9w7vZWWv4LR1CzGntIdlWZ9E8NJ
 /aFlgvmng0yYT686evDf+osJ69xcHunoT0OefgVcmVWT5dzqP9M/Z8CQbS8tEUsWUfPf5s+BSpD
 9ZkT0D94=
X-Gm-Gg: ATEYQzwhN4hRCaz6kvUu5plxbqEz4Q6qMnjDG6aaVQKJHblII6RGAUd1ckTTYb/QmGw
 TtRgA29eJqzpZw5/AMdpTzwdzELIP5rYSLXaH5n5MoXbGoFrN0gyJ2sOgtyOXD6IrBK6FjoaOiT
 xO+iFfbqNTjj+4iSaQmz7eqneDbcwpoVeLgu2ZeqUW4mqmn3V3YU2LHchZ6JVieWjXTk4U5wSgN
 KTjbyIbZsrevq6y0HnrKMDvxp0Qn4/AS10etuMsnv1qDGkC4mqGWq5/8N2ygnLX0/EyEjq5l3ju
 w/kGAX/gWYxAUPpCTF2wkuZ4d98aB1NEi4bwb6C7qKScfkwq2VUcSTBTCjxcti/EMgFraMcSEqb
 AQHI49Xc6yHIk+4+6qmTu5AiAXHR+lIYPjtCnZILII/cuhTWaA8g6MrJVRXcjWgwjUKyx+iVfD4
 6+/TaGbh9kPI/vyIQPrVHCCFJkuOYr75r6Q8eyP8Dot5JMS0kHVLaCkzbPHf13Mj0aYYifDmXyf
 qEs0f/FSo0WXXGlzTCff8AVvDnMPad06uuXFeDElmsm71CM9NOt4Xd+sg==
X-Received: by 2002:a05:6808:2203:b0:467:f1e5:a294 with SMTP id
 5614622812f47-46f00b46690mr162622b6e.4.1775155557344; 
 Thu, 02 Apr 2026 11:45:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46d9044725dsm2085830b6e.8.2026.04.02.11.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 11:45:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Neil Berkman <neil@xuku.com>
In-Reply-To: <20260318211515.35246-1-neil@xuku.com>
References: <20260318211515.35246-1-neil@xuku.com>
Subject: Re: [PATCH] env: flash: add catch-all for unrecognized flags in
 env_flash_init()
Message-Id: <177515555639.1935668.12528563896137657901.b4-ty@konsulko.com>
Date: Thu, 02 Apr 2026 12:45:56 -0600
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

On Wed, 18 Mar 2026 14:15:15 -0700, Neil Berkman wrote:

> When both environment copies have valid CRCs but the flag bytes do not
> match any recognized pair, env_flash_init() falls through without
> setting gd->env_addr or gd->env_valid. This is a problem because:
> 
> 1. env_init() then sets gd->env_addr = &default_environment (in RAM).
> 
> 2. In env_flash_load(), the pointer comparison
>    gd->env_addr != &flash_addr->data evaluates true (RAM != flash),
>    triggering the pointer swap that selects the secondary copy.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] env: flash: add catch-all for unrecognized flags in env_flash_init()
      commit: ff7039032b7de3549b9b287b2c000c9e96c60380
-- 
Tom


