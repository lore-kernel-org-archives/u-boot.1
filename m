Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45618CD4F21
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 19:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C90B884198;
	Tue, 12 May 2026 21:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WthQZUei";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28F9284099; Tue, 12 May 2026 21:31:50 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE6DE83E36
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 21:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7dcc9b506d9so4857723a34.1
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 12:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778614306; x=1779219106; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OCPY1TUv4GuTUqgP3o+yJ3DG09wapF3+5vsueRYd7Pc=;
 b=WthQZUeiOW6eeArzJHME1W0oMPsS9kgPAgnLqV5O8eFJ3OC/8hlLSQIUFREsrXVRNN
 Mr6JJ50LZsPa1EU23lTfWm20xDYpv54CkssVZemDQNEzZehaiW2Z6WsWoE8FuSz7lhno
 ekE/ooIcM9IlLK2hVxF7qudvpnq+8jIuZIO+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778614306; x=1779219106;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OCPY1TUv4GuTUqgP3o+yJ3DG09wapF3+5vsueRYd7Pc=;
 b=AFjcXl4TuyXotdi5e38lXC1N51U0UnDf95LACRFKTZq3a7bdu7qgy8WbQtKsy+vdtV
 i18gtBNg+kZmIBLH6OC1jHPguW+RZEuAchKWienQjNQdXLf0Ae/4liq7DEPf2N6zz790
 T5DmfD6e/pvBrXsDfrb0RDRze718F4Ct0K7n33tsj4DRv+2TaP5S0eTYyO7JCmoT//cK
 Tot5CTQngJitbgbBRtVUHjs+wvsPrmTXmmv3GKQhTFm/RZU0b+48ElWJJMFTEuB7M0G2
 XLNXgw/XkZufdZWXxyeCcUb/YHOILNSV5iLxbFzhn2mWiycDymzhdQDuhGLzmqhewEO6
 c0aQ==
X-Gm-Message-State: AOJu0YzlDhTvwg0zhkOcJTf+IRn9QuV0Qi7XQlpirvaQpGWiQco+vUL2
 S7YdDazzlpSwDXwprmyVqaLtjCqQnI0UdCNL6p9JeaMOLih6x2YS+F4EfDmCCGhqkdg=
X-Gm-Gg: Acq92OGDDrJJEBdMJtqQ+GNUm0gK212tmONSrcMfq0e6VDICHJ90heFaZCemKdw9rqZ
 H8gSxqtK0mvsxagARwG8FOPpR9g+FLllwmPXRmK+lxEdWQuMWsACWC5ZcJKB4B3do/FN34MoouQ
 m0uNqTssoT/RyLW04fnm5MwNVzcDj0J19neq6agNLSL7uwkezNZrNrY8m8ZK0l5o+Q2uKcFkUzy
 HkIqmq7b1EXnDngaI/+t6lKJaKvd0t/atDr7Lo1NOKN5tgArLCL6HnB8LZeZrPWtOtRTVo9W2u4
 /FF15pBIr8Lr3l4klw6S32Rs6TG1/HIQRvriv0b+YNy7ejKd5VseShYs4aB+C0diWfX/A7UNmDF
 vkboBjHMVQJQg9JQtXqywyK96ewQk/L8NhN4dshFNQqzOz95sBxo8tNEdALTjRzDFqkM6t9khrr
 3Yl1TKPswfGmxK0p8wnZMtvUTFUCL0PFuSn9aIwl2NiLpJgj8hphZP4iof1UJp+T+DCRqQfUycP
 mDz14wgRyDLzdFtgfw9pbzDPjijN4h4Kb3FQS3DBdzZdIBi0Q==
X-Received: by 2002:a05:6830:6ab3:b0:7de:84b5:88e3 with SMTP id
 46e09a7af769-7e3da0b80e6mr50134a34.8.1778614306557; 
 Tue, 12 May 2026 12:31:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d4f05csm10369170a34.17.2026.05.12.12.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:31:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>
In-Reply-To: <20260430-apple-compat-pinctrl-v1-1-f214a79616a2@jannau.net>
References: <20260430-apple-compat-pinctrl-v1-1-f214a79616a2@jannau.net>
Subject: Re: [PATCH] pinctrl: apple: Add "apple,t8103-pinctrl" compatible
Message-Id: <177861430593.3279584.1365780465368790833.b4-ty@konsulko.com>
Date: Tue, 12 May 2026 13:31:45 -0600
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

On Thu, 30 Apr 2026 23:29:55 +0200, Janne Grunau wrote:

> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,pinctrl" anymore [1]. Use
> "apple,t8103-pinctrl" as fallback compatible as it is the SoC driver and
> bindings were originally written for.
> The t602x (M2 Pro/Max/Ultra) devicetrees submitted in [2] use this
> compatible as fallback instead of "apple,t8103-pinctrl".
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] pinctrl: apple: Add "apple,t8103-pinctrl" compatible
      commit: 1588f7b8a35b342ec30b099d9b011c9904341388
-- 
Tom


