Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0775CCD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 15:58:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47EF7848B9;
	Wed,  3 Jun 2026 17:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gnj0e3c4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00C75848A2; Wed,  3 Jun 2026 17:57:51 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E051E8488F
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 17:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e6b5dfde3cso1943651a34.3
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 08:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780502267; x=1781107067; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nhXaYVvjYBXydvdQR5NvDS0VdkW9O8O6MUDsi1GKzgY=;
 b=gnj0e3c4daHE6oiJDdayBZ4YX9O+rI7EPEvlHcYwCRyAJkRNFfNCbl/OcwN16H4psP
 G+zOrXIZ9J0HBufbZSJM9FiGfMzdfjJP5Ee12eu+hJgnMfOKK3iXn4H93/i+Cxs7AlLf
 ffv3CPVsDUQw864XExq6VxV2kX8TTRmZwm04g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780502267; x=1781107067;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nhXaYVvjYBXydvdQR5NvDS0VdkW9O8O6MUDsi1GKzgY=;
 b=B8jKmkEZ9s0kwkMfDJVsmmlE5O1YU0JEuzwm0r6OecO1++PmA/codHDSwMcRrKXi4j
 qHgxqexi5DqNRl5hN33VTO9h2f+QxWGhWUhi7+0VRVGdbOU9DOlMBdy2IA+P2o6etGbl
 Vho8oraJIJs0RD97AKOUHhVAhNw1ijs4nwLvCN+j/d5pJo2Faa7j0eEq/XiKsfjgX0iS
 111aed+EJ2X6kV/zMbWJ4SSCFzO5AQYfJJRk4O2rblbWr74jl6709nHSao5YRslmM9vN
 coaaRa69ZLYZ6mjyYLNSfI49QDcp0ggu/spjuhg5YcdFAy67M9ZmkoQGKM8qv7f1F6f+
 7RpQ==
X-Gm-Message-State: AOJu0YxnkGo1uGniSf8W97Th0icJyaIa891sRDQUhpVeW++dm2sKIP8K
 b9PmhjObILofhpz4lTAnrRUxDOGR81HGHlnYO7JNS+tg/vvWSbAOVlaShxtQOxcheqpy/JMblla
 HqMtjzc4=
X-Gm-Gg: Acq92OG854vO69UA/+3Wi73Yyquq9cuUA/xin4iggZvGxm+zqIbJtInRr7NqYoesvBL
 4rARCrj4cTGwdqPClaBx4xy8gDIBMHIvhB6cM8RLxZUF7/zQknkheWRSMMje0EyttPeYrwsy4hO
 lZ8jaFQfeFDzeBXUN2d5CQAQol1D9eE2h69kerwebAvnZnSo8mN62DZfJ2Lzdo/R5Cn2T41ok/y
 BUh3+S4h6t/OhjHXrMjAUnNUx+OzUpzuYfk4D8hNjkTIobnShdjwLQ2q3/kYbQ3Gl2hl2DI70F0
 yGjHo3In5q4aZkYrFwM9ltf/bDoyZL5a6GXdsMGsiaCucJhK3YkcjGAw61vu6ARGEO7c61ZFi5G
 JpGEUhIGkNsTPPwVjHrXgLtMlu9QYkw0HbcsBs7nOmVzp6Ll4sgv0HM9Uzhbx6OqYb5OHAuEuYD
 Lcy7CEWWhhUkBHLUt/hZf+/qE2q7jGvSLPIX8sIV3ysAG1N/Qba+tZBcW7TzE74XWEMocVrr1Sg
 pSkg18Juan46YmZScQfTatNKXNF87KhMPgqP2X1oasob780lg4owr1Vatmf
X-Received: by 2002:a05:6830:b93:b0:7dc:dd58:50b8 with SMTP id
 46e09a7af769-7e6e9d3b28amr2454051a34.13.1780502267693; 
 Wed, 03 Jun 2026 08:57:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e78e7f9csm1970441a34.17.2026.06.03.08.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 08:57:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, dmukhin@ford.com
Cc: sjg@chromium.org
In-Reply-To: <20260526210002.1447806-1-dmukhin@ford.com>
References: <20260526210002.1447806-1-dmukhin@ford.com>
Subject: Re: [PATCH v2] .gitignore: exclude logo generated file
Message-Id: <178050226657.2193579.231742236447860748.b4-ty@konsulko.com>
Date: Wed, 03 Jun 2026 09:57:46 -0600
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

On Tue, 26 May 2026 14:00:02 -0700, dmukhin@ford.com wrote:

> Correct the rule in .gitignore to skip u_boot_logo.bmp.S artifact which
> is generated for any board with CONFIG_VIDEO_LOGO enabled.
> 
> Also, correct the stale u_boot_logo name in CLEAN_FILES in top-level
> Makefile.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] .gitignore: exclude logo generated file
      commit: 5188b96cdb7884cdcad2a068450e66516edf74f9
-- 
Tom


