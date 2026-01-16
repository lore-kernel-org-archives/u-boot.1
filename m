Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C5DC982D1
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 17:33:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6B5283966;
	Fri, 16 Jan 2026 18:33:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sFjB7807";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEB7A8389A; Fri, 16 Jan 2026 18:33:00 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66F23838A5
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 18:32:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-40439fb8584so1326459fac.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 09:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768584777; x=1769189577; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7oth1tE7LtROqb1A94cfHYorJntOEXW+3wALNcgNiuk=;
 b=sFjB7807EaMo6FVrpi6KOGKMDIAG/rwU6wExHZZMBqQU01baVuxLSWG6wzieUwC9Y9
 na3SYiKAoNNyZGlCYWpbIaj7syhQU1/nP+/TPdJsJXtRPidR6WFOogB/Tsby0OVul9qh
 ANcX2IKZUuVjcQVCeIJsQUjujB8Si+icMnMvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768584777; x=1769189577;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7oth1tE7LtROqb1A94cfHYorJntOEXW+3wALNcgNiuk=;
 b=epEM4ogq8Z+f886Mm20L13WwIdfLzDTolA9YJpEQ6T49BZYB7lY4aeEIHV8aW9cNTu
 PYqoY54UJAL6K1sHbueHHDP0C53yGPBAj/q0C6a+biJJzP+EIQMpXHL5LAnipBjkFTnC
 vox1EbX9YTJD+hRHN+r1y6xmg8cF3F5Ui3hrrWvekqRqrU4WWCgpXDEQDFlVVW4AOYEc
 uVxseLxA5qeAZVIHoLob6NGBz1rCf2wfQRHWS8Niq0hi11yY+p/eXhroIkziBx9K4/fX
 JC4Nk9o35UONVkzFoqYa3+RJ5fxVcZshLvqeuUzKCv7g4X4Eb8pCyHg9NOEwAi8c16OP
 no3A==
X-Gm-Message-State: AOJu0YxzXwkAB0ymXYW0zf4D4sXFV76aUD+fJ5a7hd6TWkNMbIY6jgHm
 1i49J9BpmfAK504cEWNBl1L3Ygu2s4lePaFtGNlK6/08mkMxwnPQP6UfFCwk3LDl0Q+TbAOjIHv
 XzrnPIJA=
X-Gm-Gg: AY/fxX4Hs5tUurarp8xd7wss1vz1IzRPR9tTk2e1rpGNua5ua/q/I2a6iQ5SDBabHUB
 iORs0kcHQVse8G0UIi6/rNW8uHsktHHMX1lrYbklFhnWzC2PiXqFV7e01dRLdxc8a0DjItPc8tH
 DbaUkV5Cw2oYGrdjfLvLKuisW/791/yGIWHl55tRnFJzqd4MWmZPtpzDG+4e2xjFXEUVbtv7p76
 xPtK8tErIL8zZ/lOoJ7YEkYXiisfHeuO9CYDKvqzHoQiF57PhA6fJA63ecVyQuN0OhS6VpT1vDm
 9JZtpZuwHoKXksJHA0JL3XPcr6c4pwKvtvc8C8DIXDhoh0LXTe+AMMQwccPUqSB8+EF1ozPo6Ob
 Xt0rJX66kqqbTu6mNvfX6yHNUfIXXlxoivoJYzIArdOCK120gNNE+5NFKFnyOIGJwztBhxlQDeh
 DUGO2XKNCqOKhhFQmx3DOighRC5NRqCGgfrdgnzVrczbgZ0wPBmRAj43WPyPN1Lran4kyFN9Or7
 kPxOVbW3+RfXS2cYEqMM4KmNDNpbGQa6pGHuA==
X-Received: by 2002:a05:6820:440f:b0:65f:6562:e3af with SMTP id
 006d021491bc7-6611818a86emr1027070eaf.41.1768584777193; 
 Fri, 16 Jan 2026 09:32:57 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-661186ca7aasm1494068eaf.2.2026.01.16.09.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 09:32:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <BESP194MB28050FDFC3929BDBF71ED475DA86A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB28050FDFC3929BDBF71ED475DA86A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] bootstd: rauc: Free memory during error handling
Message-Id: <176858477658.4075554.16405810670818605505.b4-ty@konsulko.com>
Date: Fri, 16 Jan 2026 11:32:56 -0600
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

On Mon, 05 Jan 2026 21:26:14 +0100, Francois Berder wrote:

> While reading bootflow, memory was not released if an
> error occurred.
> 
> 

Applied to u-boot/master, thanks!

[1/1] bootstd: rauc: Free memory during error handling
      commit: 284855320282ccd3c6d0403e85c0e2ab8a566db1
-- 
Tom


