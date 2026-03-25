Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27C1109C05B
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 20:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE31183DA6;
	Wed, 25 Mar 2026 21:32:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y/+q/Pf+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEBFA83A91; Wed, 25 Mar 2026 21:32:14 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E20383DA6
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 21:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-467e8aaa865so116385b6e.2
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 13:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774470727; x=1775075527; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ykn3kCeOhVeIWvbf8LKSJJDQd0/cSOqr8rUjSYQc5vQ=;
 b=Y/+q/Pf+LuqhzrbBAdvwu7RwKuR2giZ0KBkk2ocGvtKTr4/bavY/EMe4oTgn7r7S3l
 i5arXRlQJk55wL7V4Qj9eIx63m0/PfZ61d7ztkYZzoZtE0UKO80miOY8k64NdqUUvpUx
 7Y0Il6Ar4DE8XFEAphUfRf5KQjZxIpb+t7XAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774470727; x=1775075527;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ykn3kCeOhVeIWvbf8LKSJJDQd0/cSOqr8rUjSYQc5vQ=;
 b=FCYgaeH8CpXt4QjS3Llx6YA3irFtrLMQvh5L27CCG9rpWFtEg3maiVeItB0IfhdYx0
 6YHv9CONA+aRvOvWwF8kPrBDKPa2IocQzKschAZ1FEsloPML6AKTmjn9fr3UM06pEZhd
 PThLMAoDFmofltOjZioh4pwdIc/U5xCtEP1HxRk8oH/AscaKzeLXc1PUndbGXZAsUmoN
 k+MWklR9MlrkxDeAU458ZMiq9Z9TodWs4Wh1cnPZhLeNYNaawnnWBoEM0w8ANIWvQWTQ
 mI4p9vHQ52IfnVEtA3CDUzselES/rwMYsacduU3/uFtideLLH9bsIbTG5eZTr1pDoLox
 BCOA==
X-Gm-Message-State: AOJu0Yxrz/ZQvTkDUtvgTIDmbOSU0Rms8f1wEq/XEI3qKJSE/bkOvMo/
 y5GrO+2PZEmse4C29u/jjXLGoKYP7K5RL2VBis8tqCKljNRdSLNIbKWDCes9flOe7qg=
X-Gm-Gg: ATEYQzwLLnKthtv9sUYzoycZyyM75Po6H2AkhHsSKtvP0HfMGgV96NsN/4/LuLcJnoA
 6NB4FQ3iebG9NZBSqLRoO03amVKvZPm3xa+Jd6bdQ5t/qgAV2jD8Yh9n16r0spEOOVC/QZqG80u
 wRUdHaVJSHZPsF/iCaGz1q65iFyyXC9WhJHCaG9OQ2RH503TT4XLQUGTjQhfbZFuyv8D9vMo8Pr
 Pnr5RLhW42v/K2Gixzghpx+qx/wtwxKSFH3ZBGKRkXBpjLIipbdsg3lURmsW7lIlfcRLosls5J7
 EoHTcQQ/pwbGsaAJ/kMMplPZuXjp69W8/vy1HTkiETQckVPUFmKnyTnWJ51I6W1JQynlOwuIRp2
 BfQmY15IglVOAuU0QjAz+0WUscrEn/cuRPMjI4kDQS6TCCdCdcQmwE2fp7QdH43oGotZV/nW2Oj
 AlXb53YmLoierfTyPeT4Asn/YBQsFLZL7qdpYfBCdWe/8vD9DfAB0aDgee2Udkr3fnhNh7GB2/E
 nXIgrt0Tsq3RXCKn6kAk5N6YOmOKMNCLQLf56r/R5MwSho=
X-Received: by 2002:a05:6808:4f49:b0:467:46e7:e6dd with SMTP id
 5614622812f47-46a5c59bd95mr2291420b6e.16.1774470727226; 
 Wed, 25 Mar 2026 13:32:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41ccb6b1d25sm107735fac.16.2026.03.25.13.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:32:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260325094136.6714-1-clamor95@gmail.com>
References: <20260325094136.6714-1-clamor95@gmail.com>
Subject: Re: Please pull u-boot-tegra staging
Message-Id: <177447072664.3473727.9628836415294763503.b4-ty@konsulko.com>
Date: Wed, 25 Mar 2026 14:32:06 -0600
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

On Wed, 25 Mar 2026 11:41:34 +0200, Svyatoslav Ryhel wrote:

> The following changes since commit eb00c710508d09b2a3b9aca75dd18280f1304703:
> 
>   Merge patch series "bootm: Clean up arch-specific, pre-OS clean-up" (2026-03-18 18:36:50 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


