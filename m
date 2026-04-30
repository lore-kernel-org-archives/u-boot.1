Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CA0CD13DA
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 19:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4A28803C6;
	Thu, 30 Apr 2026 21:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RJ5DMMoM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6562080433; Thu, 30 Apr 2026 21:15:29 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EA7F80086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 21:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-694891f8f75so687701eaf.1
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 12:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777576525; x=1778181325; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i+RQxuM/tnJo5m2qLSjrccQZckyorIdv5lR1rDwCrmw=;
 b=RJ5DMMoM350xoir4Fl97utOdkITB3dyZzCiZjavzXGM5ugriM2VpWstgLNSu5Btfrx
 ai7Msz083Cu3Pqe/PxHAAssUe9NTonyNry2nY6H+NLEPWNQJu57qxw021fnjSaD3NTY2
 D7gXUSdacCbINpTQftGZHVlMXz44ZR0HKYBI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777576525; x=1778181325;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i+RQxuM/tnJo5m2qLSjrccQZckyorIdv5lR1rDwCrmw=;
 b=qyT90qZJ+WLDcbzs2JdWD1dXWChk+ozchzwFt1gRz/VA0HLAM2u/cZxu8Kmpzgz9PH
 vMCfIvSmHGygxwmRCDW7cFA/5AyyLyw+EhkSCGm5arNDxIjbKqfauH6x2GXI9dqnyI7x
 2kBkcdJqQUquDAEyZblD6SBupuQsN88OoYWPOOvTwiqYVvl26ThrjBDwTO4nuqAlrOhc
 ssEbci4Xz1OWr4UJmA9JuGfh7IAfMs9t5N+gnujy2HiLZbzwBROpHluxvGC24PTlPviE
 ypZVWHpKq5JT8qO0/EguJeDvRG5X/OK+6AaSPMMYfTzb5RCWlzq6lppS5217tLKzpJ51
 H5qQ==
X-Gm-Message-State: AOJu0YyFrU85VsvbjG+rMIarHLAIY2g4h2I82+FAY1QmVOnp+to4/Elr
 008LhC9GR9HvmxfL8E/QnGQwytG8lrrPZatU5Zxx6qszxchy0O1yDHqcGqwWQS8IcsJ8/+5zoe2
 bdVsBr5BqnNzY
X-Gm-Gg: AeBDievcrDXCkj6NZu1iX6lBG2HI1fFRcRSWZyttUdmY0lpiokqcK7Jgut0JGwM+SJC
 d++M7bytPKa1yyixLMUbUfdwi9juyTNUxR4udkGuHv7kvR64W+5RopCQYlJbPK8FnPfSS4xHRWC
 sSIoY1StSOueAbo6OXFfZJE4+iCsYJMoW3r6XkCUkJs9gmctT1g5d/5oDv+G/tO8vBSp6+wDMmE
 wO0HQ+aCmJURFztb5JpW/7vqCAD67qkoQkuMJWi9tVchw5G3OYY5fs2YCU1AzB1wRR407WjXMxm
 DxVfuI7asoiCVpVLQTxOjnhSHkbiXUEjLZNY6OZWO1/0KtNEIqT71L9ZnrmLu/ZBJDZqpQOJek7
 jA83w+XVCTa10ihcRpljPXcHhPNAjShW7RPygfXMu+ropKcbBd+/AESUgKnw0IZEsmpro0nQfyW
 45wsVKA5Gc5h6QNj8u0l/22pOK9be4lW2X0C+viTCHfPLDYNDDnR3C8kx4J26szKTdhjtWMu445
 2edNFR2MDU8YXZRK4ko5AlcUm9ZQyZt9nD1bz/agB79RUxYd1dRpueJQL8M
X-Received: by 2002:a05:6820:134b:b0:685:d2b6:6df0 with SMTP id
 006d021491bc7-6967a4c4369mr2339733eaf.3.1777576525343; 
 Thu, 30 Apr 2026 12:15:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6968974560fsm142074eaf.15.2026.04.30.12.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 12:15:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Cc: thomas.petazzoni@bootlin.com, quentin.schulz@cherry.de, 
 marek.vasut@mailbox.org
In-Reply-To: <20260429144615.142350-1-joaomarcos.costa@bootlin.com>
References: <20260429144615.142350-1-joaomarcos.costa@bootlin.com>
Subject: Re: [PATCH] scripts/dtc: drop yaml in DT validation
Message-Id: <177757652458.1689679.13411123339948819206.b4-ty@konsulko.com>
Date: Thu, 30 Apr 2026 13:15:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Wed, 29 Apr 2026 16:46:15 +0200, João Marcos Costa wrote:

> The build issues found in dtc/yamltree were partially mitigated by a
> previous commit (807bcd844a: "scripts/dtc: Fix pkg-config behavior under
> sysroot"), but upstream dtc simply disabled yaml, and the same should be
> done here in order to permanently avoid those issues.
> 
> Backport the change below from Linux v5.18 [1]:
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] scripts/dtc: drop yaml in DT validation
      commit: 8ef8dee4f3a2b2021decfefd853dbd2a1632b77f
-- 
Tom


