Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9916DC46CD3
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 20:59:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD7E0879DF;
	Thu, 28 Dec 2023 21:59:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U0u4qlWs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03CC187945; Thu, 28 Dec 2023 21:59:04 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95BE1879DF
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 21:59:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5e7c1012a42so53885907b3.3
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 12:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703797140; x=1704401940; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GrjBJogsVWr61d08budZhl615XkButBVA8xg4GdMOVw=;
 b=U0u4qlWsM1Y/Ac5xRAZo9+q5tUf4Qb44t1GWpXM3hsiC1bCBmMUtro1yKUFtgMAeFS
 boH7v8t+hIysFLaG9+PT2lc0bud9cq9YJksYHuLI4C3zsvC1ckHoC6HMpPqniakE3ePi
 fHuQUFBMGXWFUMJPOCiyFXNdNGsSeEBK9fxnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703797140; x=1704401940;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GrjBJogsVWr61d08budZhl615XkButBVA8xg4GdMOVw=;
 b=SFCa2kWCTY8ow773U/WFQ7MpDm+M6Ji5WZPgIHKaKnpOXvHWeJyprwCv23Rg9PeYdm
 UsQe/+flemYSXxbUKt9cw/IIK7SN4mfqmFRBLViZ3LYEqIJspR+u9JHd1ARLsqt12rnB
 Gpa+OssZMU1tuqB/VxMXS6NR1ZdyXP5Efm84ILqRaMTMaZSVX9L/C4Q970HZnL+kCUxD
 lBBHUFVzFpGt6FAGWq2RcjN5lRrG3s6uYJh+LRcUYBIpUz5qwKaPWxxHK4Kkzc2AiHJ5
 43SyGKdZ8I3ACPKKsdQyU9iUIo/93dC2EcMbCTRMFnzbCGnC1qwVWzvazuynx/oiZRWF
 x+bw==
X-Gm-Message-State: AOJu0YwPLkMZsVjMocF1NpCkD37zKlhWuHTG/KSoRCDd3cUxxJmHtWSq
 pURt88SLEjhQxn1kqg3cjfvQvizxY+K+Pw==
X-Google-Smtp-Source: AGHT+IENKpL8wFP6NgeUbRGBovqhFuARjP2KWetGOvR9psl51wqFLGwpf1So6ReGALA6Z8lRMweg2g==
X-Received: by 2002:a81:8903:0:b0:5e8:7954:ed9f with SMTP id
 z3-20020a818903000000b005e87954ed9fmr6971408ywf.91.1703797140257; 
 Thu, 28 Dec 2023 12:59:00 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 x4-20020a81a004000000b005e3f0da06ffsm7828571ywg.34.2023.12.28.12.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 12:58:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Francis Laniel <francis.laniel@amarulasolutions.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
References: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
Subject: Re: [PATCH v13 00/24] Modernize U-Boot shell
Message-Id: <170379713946.899302.2054678070497875668.b4-ty@konsulko.com>
Date: Thu, 28 Dec 2023 15:58:59 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Fri, 22 Dec 2023 22:02:20 +0100, Francis Laniel wrote:

> During 2021 summer, Sean Anderson wrote a contribution to add a new shell, based
> on LIL, to U-Boot [1, 2].
> While one of the goals of this contribution was to address the fact actual
> U-Boot shell, which is based on Busybox hush, is old there was a discussion
> about adding a new shell versus updating the actual one [3, 4].
> 
> So, in this series, with Harald Seiler, we updated the actual U-Boot shell to
> reflect what is currently in Busybox source code.
> Basically, this contribution is about taking a snapshot of Busybox shell/hush.c
> file (as it exists in commit 37460f5da) and adapt it to suit U-Boot needs.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


