Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE0ED116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 16:03:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25C3D83BDD;
	Mon,  1 Dec 2025 17:03:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UiIl9UsI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C900183B7E; Mon,  1 Dec 2025 17:03:37 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EA4983B7F
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 17:03:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c7545310b8so2079702a34.1
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 08:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764605014; x=1765209814; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T7iHcVJvZFAMwuErFErHimPOo6FZS4WyBJAWOzVZvus=;
 b=UiIl9UsIeNEuXYXX/92OQR69LNq2KMwKzjh9cc4n7AHWtzW5aUYtpByMJbc0CvNdR3
 ocjIppEjNCYErPEmG/IZNvtmMZpsWK0Ai3i6ihmHtYeHUJAHdobRVcdi3zXuZkeXkf2U
 Mr/DJpxNQlFi8CigPClFNjEZGiUwu/0p5H0RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764605014; x=1765209814;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T7iHcVJvZFAMwuErFErHimPOo6FZS4WyBJAWOzVZvus=;
 b=tyFrH5Nca5oIef2+LxAEjQOsEHQs5zNM0C4C3KPsbEEWJc+EJhk3E/UfhGuY6oJ7CG
 oeiC2NVGTx46yYjOrjAerfinT2FdUOwFEA3HmQAEL2/DO/BEBn3QD586m3viCW/puBuy
 GyqLvsVYD6mZXpHHvTICq/6ZwfCqe5jthJTEqAUILDh+FkPXV5occcbGqIzbcSNI5rFr
 I+IiTuEOb7xHQ1s9Mo7Pr2f3ZmD7urLYD7FebBG9FstGKg81jfOiE0akY5PFv4rbEWMM
 fg6g+oZ1si7bJYptI7FAWLtXUJW86s0hzW7vZhk52GMf8dnJWvppf29yagzduk9qJs03
 gzTg==
X-Gm-Message-State: AOJu0Yx1Y49pONWDTRAvic98xYxazwEEoXAJ5FJX+rUx/9D6SZZDf/Xi
 9+op1/FLmFLTFIb/Gb4ymL3zbc9FOSRr/YqEE5lpmDn8EhLEtMWsftxb6soYeu5/JoNE8HonV41
 4aH+B7ew=
X-Gm-Gg: ASbGncuK4Zbx9B8XNE2J2gjqG+oTdHw+IxP1hzYe+MrwmOfoc4zamjw7ReuDxNG+tWl
 bec0ZSAwO7Rrst1+3wvBqdl0VGy/NC5ed4wCJhoyQ6XKdlGP0Uy7hNcf0Oqup8OP+9Mf1Kc4jSH
 j+MMUvMqkZj9nSokBcOOtOFT/lv93nVIdhcjPSoL+FNzu7pDzNeNktBcvL3qPiPvrEJUKtY19Gp
 65pJCzQeWXa83KcnkpjiN2j4Q9Hg/nqTYe+dt/6cFlXVEP8XoMaZXf0p823rZV/Lneoc05r98YP
 b84KH/V2zwWFtOp/EfY/Lg/eBX/OcAR5B8j/A/ZKXEeGRIIARJzLWO35eZGr1NCH0c1dIQW8zK4
 Cce7wYam0HfRrAjIVXBZMlwT1XuAyTM5CSlO0jYIrlDl92KrEMwgWANuBmvfuUteKKyoxkLHZ37
 GcnT4SLIeRHw+t3ckcdJaWmzyCzA6rmQZNUh8N6UfufQGsSlu5
X-Google-Smtp-Source: AGHT+IFm4pRImzPMDJuqaYuOnG+QOWZMec1/TOO30sNGMGbH4NCUJD+jmhm+aGneIhe6MYNSfRJEoQ==
X-Received: by 2002:a05:6830:368b:b0:7c7:1f5:28a with SMTP id
 46e09a7af769-7c7c412b81dmr15912078a34.12.1764605012778; 
 Mon, 01 Dec 2025 08:03:32 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90f5d811asm4708061a34.1.2025.12.01.08.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 08:03:32 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251118210015.624758-1-trini@konsulko.com>
References: <20251118210015.624758-1-trini@konsulko.com>
Subject: Re: [PATCH v2 1/4] Gitlab: Add a "sage-lab" stage to access a
 board farm
Message-Id: <176460501185.1117748.4957176611485743251.b4-ty@konsulko.com>
Date: Mon, 01 Dec 2025 10:03:31 -0600
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

On Tue, 18 Nov 2025 15:00:12 -0600, Tom Rini wrote:

> This is the Gitlab side of adding support for the board lab connected to
> the "konsulko-sage" runner. On the software side, this lab uses only
> upstream labgrid. On the hardware side, each device under test is
> connected to its own exporter (typically a Raspberry Pi 4) that must be
> turned on (and cleanly turned off) as part of a given test cycle.
> 
> Add support for testing on a SolidRun Hummingboard 2 (imx6), Raspberry
> Pi 3 and Raspberry Pi 4. In all cases, we enable additional options to
> run more tests on the board. As we have some networking tests, we test
> both the legacy network stack and lwIP. In the case of Pi platforms, we
> test all of 32bit configuration, plain configuration and rpi_arm64, and
> again with and without lwIP.
> 
> [...]

Applied to u-boot/next, thanks!

[1/4] Gitlab: Add a "sage-lab" stage to access a board farm
      commit: 39c717dad8caa31567aae8473386f41097e725bc
[2/4] Docker: Add building TF-A for pine64_plus
      commit: 0c4990c5b84431db53f88292905b5aedd7d1ff28
[3/4] Gitlab: sage: Add Pine64+ platform
      commit: 04c913a3672848c95c15c0fb560e0f6de2fdd220
[4/4] Gitlab sage, Docker: Add snmp and rsync
      commit: f84a6d94c7bd28f5d450f997b395e94b1cff36ae
-- 
Tom


