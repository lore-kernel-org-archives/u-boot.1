Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDF1C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 04:35:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B74FC80F92;
	Wed,  5 Mar 2025 05:35:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KPyN7qIt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4557280FDD; Wed,  5 Mar 2025 05:35:00 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2177880F56
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 05:34:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e60c4412127so2849464276.2
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 20:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741149297; x=1741754097; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQzS5m4yjofhRsVkzRSLYvaQbsrVt0IHhdRqRxDP/mw=;
 b=KPyN7qItVZVhZgg9QofaFriPnYi0HPqTu7wbQLog8Ji6mmysUIxh0vuX+4C/iBhOws
 ntIXmVX0oPpz3P6+n8n2oglc4fHwXAbOHq/+aFpA7kYrkz4/yumqr8v/dl6jmmVznNG6
 xeVTyYumKrPQcYXuNGnUoBU34c86AcPcz5AyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741149297; x=1741754097;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bQzS5m4yjofhRsVkzRSLYvaQbsrVt0IHhdRqRxDP/mw=;
 b=RtSq3jZmabLDoeTLEl2PfUJ/LHzpsXOned40Oj+bxvy4mF84te4Esy8YrmSiXyn51z
 M/SsjwPcjeYHuPCnfePjS10xxDJmVQYsNu/kGRCFDAEu2e/USh91W5mxglgpz/DvgAjB
 n1jpAIOkYqtmJVBgFSS1CPCeenUZ41t3O8yDGWgRu7Eq+r7MlBs14Z5PalaNxTXTjUek
 myBW3CZu99nUaurTXykAC97xs2UGFN5Bn7zraBQJJMCCxsLI/IkVqt+xfOT2vAXkcs9I
 F4QwQJjz1Ai1c+Ry05KssDTQOksD4eAy4nTqK1AwOknE4kQdq+3zlQHIM+OSFvZDKbjE
 q/sw==
X-Gm-Message-State: AOJu0YzPdW0OshijEvnPNH4nag5SsLO4CSPeJT4LemkOK10fMfxTqsNE
 asfvkoAaT112jMbjn+AC57Ophzy64XeohfxCxwFRzXNobSkMeNx2yyU6+dHlxUY=
X-Gm-Gg: ASbGncvibO1yHUHEKrOpP8pS9Ow6Neaost0raMmwWn+Qcn+GFFJ40BddZsIjbq2Zg6F
 2JDcc4ptq3eeUNnw92RuEPOj3tcShQ7DP+5EKB59yq4EvPD568cuu5si3HaOqImbeX33BnloGvj
 gc/TB9PspnTGRQAZV05Sr0k7ODNF8luNw7a84xbjwelimtDJh68mHfCFVaMhYAMQHjBksKLF3rd
 U2aTFRe2iSRAMFklg0u9gEMOdL53E5QMUGq4u8FMOC3tDVSkzU/KMJBujqZISFv6nWs6j2w8wwE
 7MjRDaGNHOitRMpI40OP5VubamKKlNyGbimPKMRuRQ==
X-Google-Smtp-Source: AGHT+IG911WPwERbiXB2iCyg6b2gx74mWyakPzezvcQv2aOcNa+ThetVTI7Z3bELhdt4hRmJRvVjbA==
X-Received: by 2002:a05:6902:1583:b0:e61:1be5:d0ae with SMTP id
 3f1490d57ef6-e611e196a54mr2675004276.5.1741149296986; 
 Tue, 04 Mar 2025 20:34:56 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e611fe84574sm224657276.46.2025.03.04.20.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 20:34:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Heiko Schocher <hs@denx.de>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Simon Glass <sjg@chromium.org>, quentin.schulz@cherry.de
In-Reply-To: <20250226091858.73197-1-hs@denx.de>
References: <20250226091858.73197-1-hs@denx.de>
Subject: Re: [PATCH v2] led: fix next coverity scan error
Message-Id: <174114929536.2897264.7705032936049885382.b4-ty@konsulko.com>
Date: Tue, 04 Mar 2025 22:34:55 -0600
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

On Wed, 26 Feb 2025 10:18:58 +0100, Heiko Schocher wrote:

> Tom reported the following covervity scan error:
> 
> *** CID 542488:  Control flow issues  (NO_EFFECT)
> /drivers/led/led-uclass.c: 277 in led_get_function_name()
> 271                     return uc_plat->label;
> 272
> 273             /* Now try to detect function label name */
> 274             func = dev_read_string(dev, "function");
> 275             cp = dev_read_u32(dev, "color", &color);
> 276             // prevent coverity scan error CID 541279: (TAINTED_SCALAR)
> >>>     CID 542488:  Control flow issues  (NO_EFFECT)
> >>>     This less-than-zero comparison of an unsigned value is never true.
> "color < 0U".
> 277             if (color < LED_COLOR_ID_WHITE || color >= LED_COLOR_ID_MAX)
> 278                     cp = -EINVAL;
> 279
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


