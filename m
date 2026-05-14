Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA849CD37AC
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 17:55:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A387E846B0;
	Thu, 14 May 2026 19:55:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JwdsIKiO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B9318465A; Thu, 14 May 2026 19:55:39 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7132F846B0
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 19:55:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-47cba53479aso5178503b6e.0
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 10:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778781336; x=1779386136; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pq6ZEihaO2ZJCcGZ+7QQWrV7E1XFV+2qM9oER+wvei0=;
 b=JwdsIKiOaNO2f3bmTRfVyUxpRHQqBzLxwRFUJUX/W/MEzIbRRU+USDYgkXPIyJ+ETe
 pAX/HxqQ+ByNWQUegDOl8CdQH73wHQm0URC/lkHTOqpBArBgY6aefXpZXSy4VHx0pLYC
 IebA1P+m51WGHUNcYu7maME8M3fszU0M2ezlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778781336; x=1779386136;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pq6ZEihaO2ZJCcGZ+7QQWrV7E1XFV+2qM9oER+wvei0=;
 b=sGIEu7CuA3tB9wemQ959eIQK2+gNmdxJKk2pn5PYEZF9c/vWoqdditnnmbJyxXmFu+
 naKWHYfx09JmwWEcigq24ylAfmwwM2BZKEZpu3GIBNrRPG8RYzS1jfQKJdflQbQMF/9W
 NuHHWGCOAkBlgAz9cvGOGfGyuPG73YINEQPN3l8YLGMbZ1FxGrlTNgLe3Xn+TDA34I1B
 cHt/ITpZvGhYBOTVS0Df54LOtm1aLVPQyxzOykg25kk4uRUa3ZckrUg9DxLFcF/RO9PS
 pnck11cyeJdxLyzNr0MFUUuGH9D+orQJVH0riY3rgCGGD20jxhUMKR617h1jwbkeMkiz
 NGSQ==
X-Gm-Message-State: AOJu0YzoHsNNDLps/mCaUjLt+UKlvtyN5k+g9b7HQFfEVZucUuD9ZuDM
 05fPEN0MZkXkZrI6Px9izM3qQubnsPvMgqaZhG2f/NuzJlN13KAtU7VCphlUjz+rqhPqaP/6JK2
 BwwJW8H6EDkgq
X-Gm-Gg: Acq92OFgQ0mqDsdPfh6llQDSF02WQ9uYJoOxbwvnAroRTvzTLHjF/wVb4qJajeOvSIB
 qN2rCuZFKsZ39VQIJVrSC9oGoylj/6MXZVqbuHx/xuXMp3/nqgEX3PfmbvoriILEnR0Y9v6Z1mN
 jDG4gU8c0NBQA4+n75Yrd0tB3LYO4enD1tGdhGAG0Zq91OdGyNTGzRI3yfwPVVatE+QBq2f50pS
 +YB0banGrUKQ0Th3KmxNYRbIWrgVebxU22zX9xoqt0BZqFiBy6S0MDmhiNh/+l/Y4Z2SF5ulLnm
 kvEFXU+4pFaqFBcKfMCx2XbF0YFqcqm8D4bZd3CedDW+yzAwxJeoeBHIXcbwTWoydTq3lEiflUU
 XXJG3VWZPB171MYWV5gq+uv3gFqV13ZEdaAXGHuah61zdlJJ7nbtLPJTgGEsenM0w7y3LgCCRi2
 zNMcsQvcaXZwlCYwBZdQGry0sY4eOM/u2ED6NxpX14Wd76sqAjFVyHrxdHqDf3nwRa8/Rt0asqH
 0s0UQPsA6WUl82awtisNcg598a47pg2+CxsgQA3S4gzbCm/Pw==
X-Received: by 2002:a05:6808:e68f:b0:47c:3793:c589 with SMTP id
 5614622812f47-482e5729f77mr217154b6e.26.1778781336126; 
 Thu, 14 May 2026 10:55:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-439fc53f2acsm2401711fac.14.2026.05.14.10.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:55:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: kory.maincent@bootlin.com
In-Reply-To: <20260513065206.1158795-1-ilias.apalodimas@linaro.org>
References: <20260513065206.1158795-1-ilias.apalodimas@linaro.org>
Subject: Re: Pull request for ab-master-12052026
Message-Id: <177878133542.4050569.5343818809748680506.b4-ty@konsulko.com>
Date: Thu, 14 May 2026 11:55:35 -0600
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

On Wed, 13 May 2026 09:52:06 +0300, Ilias Apalodimas wrote:

> This is a quiet cycle and I've been waiting for more patches before sending a PR.
> Just a fix from Kory on one of the tools.
> 
> The following changes since commit 5732bd0f457b4c671e46574d64d4acb099c0f0a5:
> 
>   Prepare v2026.07-rc2 (2026-05-11 16:05:08 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


