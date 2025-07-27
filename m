Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0689C83F17
	for <u-boot@archiver.kernel.org>; Sun, 27 Jul 2025 00:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A05F88309A;
	Sun, 27 Jul 2025 02:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aCzcH34S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AC65830E4; Sun, 27 Jul 2025 02:58:18 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDE5A82BCD
 for <u-boot@lists.denx.de>; Sun, 27 Jul 2025 02:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2edec6c5511so2189773fac.2
 for <u-boot@lists.denx.de>; Sat, 26 Jul 2025 17:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753577894; x=1754182694; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/uqSyPnuKGu/IYzQU0JpIWg05jly54bHnLT/AMjDUgg=;
 b=aCzcH34ST8iBoG2/JDL3XFYid0qo3aznprqMxjKQLsHahsvwWx6sOaEiNQi4Nlp3Wq
 jIK8bU3ZoPT8wqFqs8jdhxUg9VbgIY+sl3bH/xWaLUapu5qL3WcrlqvJ+VxA8JNYLKhh
 iDmrdSRq4+b4PEI4juUPMJLcZj40ShzvLAq28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753577894; x=1754182694;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/uqSyPnuKGu/IYzQU0JpIWg05jly54bHnLT/AMjDUgg=;
 b=L7rpuoud4tw2JwL8SKb93zZWf68F/bCNri2Z/tm+Q7aBH2cj9AlUDOk77o5v5G9lr4
 4liq7uz9F0zpq1Oz2uzBUgwUSAgtirE993Mp9+vD57qylUhxtL5WDgg5QasRwhzR0oQT
 y/Fw278dGjeltOhJfwbNGB2ltJbpPyg5gfNBpzwrK2SkU/+o7LI+mSdNq1Rp06TK+XqN
 f7YwqVOXkCL9j6qJI23wNPGbHyjPbb8++yLqfMoWN3j/hgITUeynEqbSZr3RqF+7D9iB
 azWL0WrWIf1pyx79Z6YbWf9g6uXI0fb8gJnx3hw0xFaCSKX/8EqydzPf4//wumxqNjDW
 oF7Q==
X-Gm-Message-State: AOJu0Ywz8wv8pbmef80n+zeiYBCevkqR0izM7EJvABYG8TMySjj4A7WC
 8OTJ4mKoJOj8GgDSmvaSuusbBw59sFbUEL9As+6CI2PZ6jERT7pPwtQoLGHS+7I5Ru4=
X-Gm-Gg: ASbGncsmbBfLz1dZrT9mSRPMGRNXdo0bIzwm9qeURE5OKKmkn9on4dud6BAUccyGCOx
 ljlafhp+AEVrBH4rGgILySX+UkRdtRq0ebCxCymcHE+04smaezT6NTaPXRoh/4wL8Jko1LSNA13
 juIeKKxFjplMp1CS+ja9gMrxxVXvnOlGULRvnCS9bcJFlDYWPT/O2v01kixS83lwMGXka5NW6KL
 S5N8P1hFFLGju5fXwp2yS+M+GxHxPi47FeEBsdFh/oQH5Sbm4qnycUxuRxfLn922SNBCkAUrQWw
 c5WTsZt88j5r7BU0ah8SWBXDDtiaMB1oG+kAfEg+Un/dY+/lBOiliNTTO2Ss2oKPDD+RyDdzig7
 Cc8dnUXveXRsrQdyB2wqxmJYmH/BEep6Iy1EZgguf/1OXnflzgnB4yIfqYCmquw3LWQ==
X-Google-Smtp-Source: AGHT+IHv9yZbQQfkYkWTKGJdkZf9j8wZtUOOd7zCJ/maAhDz56bANsAFri+n4uFxXfRNm15urPD5oA==
X-Received: by 2002:a05:6870:36ce:b0:2ff:9953:42dc with SMTP id
 586e51a60fabf-30701b115e2mr4513490fac.32.1753577894417; 
 Sat, 26 Jul 2025 17:58:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3071316fd03sm858135fac.4.2025.07.26.17.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Jul 2025 17:58:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Enric Balletbo i Serra <eballetb@redhat.com>, 
 Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
In-Reply-To: <da13de7f-da68-4185-8c5a-65e6767d2cfd@gmx.de>
References: <da13de7f-da68-4185-8c5a-65e6767d2cfd@gmx.de>
Subject: Re: Pull request efi-2025-10-rc1
Message-Id: <175357789274.137048.11122467897278383010.b4-ty@konsulko.com>
Date: Sat, 26 Jul 2025 18:58:12 -0600
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

On Sat, 26 Jul 2025 09:15:43 +0200, Heinrich Schuchardt wrote:

> The following changes since commit 088d24eb96fb8ba64e3afee310a9f32ee36c22b0:
> 
>    Merge branch 'master' of
> https://source.denx.de/u-boot/custodians/u-boot-samsung (2025-07-25
> 07:50:44 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


