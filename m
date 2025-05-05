Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEB1C3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 23:36:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47F228211F;
	Tue,  6 May 2025 01:35:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t8vs1FCd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D383F829D4; Tue,  6 May 2025 01:35:36 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A76D58294C
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 01:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-401c43671ecso2470429b6e.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 16:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746488132; x=1747092932; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKUehVCk76+I3gymxAKHREqRWNDqkY1BhoYz14tvEtk=;
 b=t8vs1FCd5u+yHMOeg8JXExJCDGejRf4b88Uc+IBNjE4i76IqhqyagvsitT16CfnNLg
 UQDov8JWsOlsBb1ooEc6wH8AolvY/kF6WdGd20tRW8G9y55saVhEnwSMNyZNUyYYIVOt
 nnBg5mP7tapgsCEbF1l+ayJO1hs4EQASHTVwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746488132; x=1747092932;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bKUehVCk76+I3gymxAKHREqRWNDqkY1BhoYz14tvEtk=;
 b=F1m/n2yXcK3iMNLMdpY77IzQASKSMKbGZyKTjT/a9yka7zOXJg6CK1kRqT8Nrsztoa
 7H1DXyYbrjFnRvq7586rlIKcO+vDEysLrfGidA8/NngGwftMQtsrous1a2+oaUMojwK4
 Eopg/omT02oSj8nucdikyC6iI0WIQmqEKVu2BYb8M2TyS7jEuT5qM7acJokEklW1YspI
 /fiExoWG1/ABpQHdM5YKS2SsvE1p/MicknI+du5UrrO4KnArae7i14fNoxc3h/2V+SdG
 Wfuhh3e/xw6NgnFFuVVJQY3/O7qMzc+WXaD+33KOcB0he0riNSR3lUoMCNz5GvnUOFO1
 J6Yw==
X-Gm-Message-State: AOJu0Yx3TH8db/ctx9ntWwUI86jkv6s6kpnsG+lzC1yGpzneozrf4F38
 GhxK0f14iJPaD8SkQ75F7nXtVuUwaAC7FEQvEAoldW6e6sbLLpe0MtvKpHCiSTKwqa8ydUKGyvQ
 3
X-Gm-Gg: ASbGncvhNOlz5b2p59w6xAREhk8fi1ZCP4sh06X+A3l4dDTgy6HxtsfRGCKOYS1W+Oh
 YKBHthcHH6vMMyxAXXh0ThuSgG+YmSQHGUJcXhSbev1umPQIBH4B1dJ5pvlLrpSbQToxDkRZOq9
 n3jGDFSyeP3AZHGgrs3Q+6YoFgXVbW2TzXqxAPUno1khF2JsEHe60+oSz5CXjbkwXnuosdA8J/G
 +t6aRsO5/Th/Ly/588C+EyRP2P08MRj6i8iQxCvMGwc3o+kilUwS9ikwEXjv+wyRq+APlWtTH7Y
 Rb3x2ulASQe3wI8gskxhOCkpo2i2DjJ20AgfjIPUfVK03ydv3m11yZIRCnTLba+rrTiy9p+47Jp
 j
X-Google-Smtp-Source: AGHT+IEXldEAcr8nvuf935PkRXzmnfiDUOOeiQbjT39aok+DpOLPbTLt31xSpeaXliQUlO+X5TGp9A==
X-Received: by 2002:a05:6808:2192:b0:3f4:e3e:10c5 with SMTP id
 5614622812f47-403686f2ac9mr885591b6e.0.1746488132319; 
 Mon, 05 May 2025 16:35:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7fe85a4sm1913408eaf.39.2025.05.05.16.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:35:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot mailing list <u-boot@lists.denx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20250429120232.3874362-1-jerome.forissier@linaro.org>
References: <20250429120232.3874362-1-jerome.forissier@linaro.org>
Subject: Re: [PATCH] cmd: spawn: reject 0 as an invalid job ID
Message-Id: <174648813155.69658.12453402397052680586.b4-ty@konsulko.com>
Date: Mon, 05 May 2025 17:35:31 -0600
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

On Tue, 29 Apr 2025 14:02:18 +0200, Jerome Forissier wrote:

> Job IDs are positive integers greater than 1. 0 is not a valid job ID,
> therefore fix the comparison in do_wait().
> 
> Fixes Coverity defects:
> 
> *** CID 550296:  Control flow issues  (NO_EFFECT)
> /cmd/spawn.c: 172 in do_wait()
> 166                     for (i = 0; i < CONFIG_CMD_SPAWN_NUM_JOBS; i++)
> 167                             if (job[i])
> 168                                     ret = wait_job(i);
> 169             } else {
> 170                     for (i = 1; i < argc; i++) {
> 171                             id = dectoul(argv[i], NULL);
> >>>     CID 550296:  Control flow issues  (NO_EFFECT)
> >>>     This less-than-zero comparison of an unsigned value is never true.
> "id < 0UL".
> 172                             if (id < 0 || id >
> CONFIG_CMD_SPAWN_NUM_JOBS)
> 173                                     return CMD_RET_USAGE;
> 174                             idx = (int)id - 1;
> 175                             ret = wait_job(idx);
> 176                     }
> 177             }
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] cmd: spawn: reject 0 as an invalid job ID
      commit: 0352eab7d373664c1c01b23154025b83ec0eadca
-- 
Tom


