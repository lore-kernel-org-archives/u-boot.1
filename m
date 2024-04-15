Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D80C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 18:44:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14B0F87B1A;
	Mon, 15 Apr 2024 20:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M/y07Sqo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33915880F8; Mon, 15 Apr 2024 20:44:50 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C7388657F
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 20:44:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41884f8f35bso2661485e9.0
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 11:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713206688; x=1713811488; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uytxUCkmBjUcKmJG02iY+UwP4hk8iZ8X9rAWJytmuN8=;
 b=M/y07Sqo6xuL4KG/bNsL2GFtWQd7vml5ifnoLQUU5NImkwK1Psw76rVEsVdOfp7H0l
 Ho8fByoBqRHB1x4ZzFniNlxTfO/w1dHAIUatQBQaMPeOTZ3kQ6KjDE2LaMHSsD0XVm0O
 OcX/1rzLcRNmNYCziGNdT/8g81x+BrLKbFszeXUucty6W00zKRGINgraICJGb1zn1xpo
 R8dXaYpTjYpR3c2HzMOvOAW+4UykYOHreB+xZRXR4Rt2u4bE8t9JTadfs4KtzLCI2crh
 /MRlzMAy/NfbA2CfBnf4g1kDA6tJwpUqpS1aDdJltQcQY/vrIhTLpsorm6FLxW5UYq6e
 4kNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713206688; x=1713811488;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uytxUCkmBjUcKmJG02iY+UwP4hk8iZ8X9rAWJytmuN8=;
 b=JFb2X50ZnL4tbFY6BAGYWVNWqfBv9fUAxe2OC+8zaAmz5LVck9qdVRRcPZmdtHn+NS
 wdmAfPH8KKGlbrvy8ik3JtjSob++Gwcm39Bx4rMjaW2FTcuxVH14tiFM7e5jKzmsS+LO
 HKPJoWkk6BsE5UWwM/5OUizYR7THTzEZiFVD/NTtVgx/UOThgjL+VXQuW4HtO7ZtoEH1
 v55OSaulQzTJn7WFz7PfGxXFNczppeIqyzVZaRvfeDKpUOjueMBU8auvcOJ95+ZWC1x8
 UaLH5yXxCopURBklblPxv1Ti58eXfCPUInD219fB7tiZUGb59CduXYcWauowrGmMWFH4
 OjtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmdGuWBHUnSRRiPyvdogFB1hTqX/mccO5Fjwt7KGOxGHyoBcnI+dN4kqxbJuoIKevvs04xvS1g4jBiXF5Df7ssgPqZKg==
X-Gm-Message-State: AOJu0YxnyBcuUq7QEiOB1RD6bKcq+0bYZYljTAmw133cloruW/azxmkv
 ZhMPSX1hxpgwrkuEt5ewyLdpTdB39q2l0x53BQG+9LF53R0GWIk5EUoNUHr6oWQ=
X-Google-Smtp-Source: AGHT+IE1Yir8qWiXM7bA9nJe0XEfspLiiV5zwaUtQEpoz7XQvd9Bo4NWyRx2yKG/dE8Q9DIlCY0VLA==
X-Received: by 2002:a05:600c:4689:b0:418:4590:2d3a with SMTP id
 p9-20020a05600c468900b0041845902d3amr3710366wmo.8.1713206687755; 
 Mon, 15 Apr 2024 11:44:47 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 a14-20020a05600c348e00b004188a8369d9sm294512wmq.47.2024.04.15.11.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 11:44:47 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@linaro.org, 
 sjg@chromium.org, bmeng.cn@gmail.com, marek.vasut+renesas@mailbox.org, 
 u-boot@lists.denx.de, Robert Marko <robert.marko@sartura.hr>
In-Reply-To: <20240415105028.432404-1-robert.marko@sartura.hr>
References: <20240415105028.432404-1-robert.marko@sartura.hr>
Subject: Re: (subset) [PATCH 1/3] serial: allow selecting MSM debug UART
 with ARCH_IPQ40XX
Message-Id: <171320668672.434664.16356200408384700559.b4-ty@linaro.org>
Date: Mon, 15 Apr 2024 19:44:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Mon, 15 Apr 2024 12:49:25 +0200, Robert Marko wrote:
> Currently, DEBUG_UART_MSM depends on ARCH_SNAPDRAGON only, but IPQ40XX
> devices also use the same UART HW so they can also use the debug UART.
> 
> So, allow selecting DEBUG_UART_MSM when using ARCH_IPQ40XX as well.
> 
> 

Applied, thanks!

[1/3] serial: allow selecting MSM debug UART with ARCH_IPQ40XX
      commit: aa7fdad4c87d5c665e0f1b74cf7986768d452a4e
[2/3] serial: msm_serial: remove .clk_rate from debug UART
      commit: aaba69b461ff7c3118272964d3a807a030277e28

Best regards,
-- 
// Caleb (they/them)


