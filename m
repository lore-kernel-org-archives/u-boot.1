Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862D2C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 23:19:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23A7282B07;
	Wed,  4 Jun 2025 01:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YmK0sZ2g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAA9082B37; Wed,  4 Jun 2025 01:19:18 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AB7782103
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 01:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-407a6c6a6d4so1054551b6e.1
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 16:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748992755; x=1749597555; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2dg9tq99TR3ZST+SbhDvKHH7f0a2B94lKsZQuB6pbQY=;
 b=YmK0sZ2gi/v49VN8deMKIaEymB+1VDt8pcyszOAGNMe9yhKJrJ/cB6mwK5mOqVHF8e
 OHwj8B73AJkSBBHdQ02/FjYlZdc0ocDeCSiXt7DTrkjs4NZ1RW6Gk7UMPXGn/8WJo8W4
 +n/n5zvIdKm2URh8vm0gMOhVXeghkEWkChybo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748992755; x=1749597555;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2dg9tq99TR3ZST+SbhDvKHH7f0a2B94lKsZQuB6pbQY=;
 b=Sd+EMJd06TDxmgitkhPYsfODBTdXt1KiuRVMdciyYd7a9Nk4DVMfJ6TP9FQX/BvTu8
 L7RDKnxOL75760r8kw4ownXVNeJIKVxNz30FIRVr+fOWFCfMrLjbk6sqv+NHHNN4FWJP
 igTfW+Cwics8o4ePKQDsIDVenE13II3dxdaQQ0B1eaqWMcAvXd0JCz7CQpFTPneXLPDw
 tqCYhl3mhVsKQrGxGmCugOEWMEWN5oXWmPoSMMzJKz0eHSsKjFcGL3+FHeW1RuuEhwSe
 FqG9f/6lbRh1RyP/J0JqH+TzSp9M7E8gNUqPnXqZiOj2AmH4K5Mx1xCtc2UTy1eBtE8g
 w27g==
X-Gm-Message-State: AOJu0YxItyrDAF23r77s8CnM0/tdQuXdQIX60VZEYcSv9k3VZu0KBWQI
 vrXo9NJGYb3x69Y667YmP1CVivuIV6pZqHYL1kUJUpNyb0VeceH4wftME0GlTLWE8CdWvpPMrtc
 CL+n/I3w=
X-Gm-Gg: ASbGncscGGXKfL5cTbSuQnv28pwIeiz74oUv6tghEsgDFOPogtzgy7UGtlY7uvaqAfT
 B2y1mMRhXK6D1oxfZWhz3Qmmd+/Pkaz9J6JUNuJ4AfvmHMFT2XvYidhSjfXEzCCaI8PMINZ5cGV
 aN+7BoEFPxbrUBztWuCVyZRpMoSOgAKaIigwJMsiPAwEUGoGnMe0gQc2jP0PZWQxCI35pa2wYn+
 alcDTM/90xqOcweAhPFzZQIqiggrUuDXiEZRvZfcXB9i+bcjkpBsLse/dT6aFr+DghwTNEjFBdO
 NeHBIByOS8C1/IgiTQx5RB+IFYyOuyLpwqDagVly9BZ3pIhz0Q/+2TQ6toTeDjU7jObIXdDotmQ
 37U+1igZfNvo=
X-Google-Smtp-Source: AGHT+IG3qs/zjNz/lxPvf/EHJrd0of71FYbmTCGXAqabYsohexryhb05pkcYpFrBHmqpPdGXvZryTQ==
X-Received: by 2002:a05:6808:6a83:b0:406:6e86:683e with SMTP id
 5614622812f47-408f0ecf7efmr711930b6e.14.1748992754789; 
 Tue, 03 Jun 2025 16:19:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678c1db4asm1990941b6e.12.2025.06.03.16.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 16:19:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, chalianis1@gmail.com
In-Reply-To: <20250518212524.137534-1-chalianis1@gmail.com>
References: <20250518212524.137534-1-chalianis1@gmail.com>
Subject: Re: [PATCH] pinctrl: gpio: sx150x: add Semtech SX150x I2C GPIO
 expander and pinctrl driver
Message-Id: <174899275338.1527530.16332183618630503148.b4-ty@konsulko.com>
Date: Tue, 03 Jun 2025 17:19:13 -0600
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

On Sun, 18 May 2025 17:25:24 -0400, chalianis1@gmail.com wrote:

>  implement a driver to use semtech pinctrl and
>  gpio expander, this driver is adapted from a
>  existent linux driver that is written by
>  Gregory Bean <gbean@codeaurora.org>.
> 
> 

Applied to u-boot/next, thanks!

[1/1] pinctrl: gpio: sx150x: add Semtech SX150x I2C GPIO expander and pinctrl driver
      commit: 5451504256d34dca5b810a512d3c8dec84ebb49c
-- 
Tom


