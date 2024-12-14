Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145E0E7716A
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 14:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40D4180081;
	Sat, 14 Dec 2024 15:23:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a8PTGpFc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 913C58007D; Sat, 14 Dec 2024 15:23:49 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52E8E8007D
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 15:23:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b6ed9ed5b9so300674485a.2
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 06:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734186226; x=1734791026; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OnMegUoHfWWi82MvJZTpoCYNQDKrHcOOOnw8367zjY4=;
 b=a8PTGpFc8cy5hPTixvMjGq9r/p13x0ezpkSUqI2J08Wh7kVAa5OTjfCcVLMpt2gZtS
 5e2oLJc7U2EXq468s7AXkNV1C9wNJczK7/3XvOFWFrNLijjm2ltOdKOI8Gli9NenIki7
 C7KVr9pTGUNhdXJeQLdCh8M6PfelQvl999zP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734186226; x=1734791026;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OnMegUoHfWWi82MvJZTpoCYNQDKrHcOOOnw8367zjY4=;
 b=C1/eC3z8NlSFQt64b0Vk1i8xWSpmt50PnM2jFCSMLtNVW8GVqP1/y+oHli2R0WC5NR
 4WawHqEn4t5/51+M7tusp+fcglyljBshY/r05dFw2LhFvbyUATAfvW7p1Sp3b32RZer4
 BD7pc3lwkfoHSX8Hs4EiaSM7l7r8l0zH5k8Ak1Qieo3XxEWOCw2HqT/eymEP7FSQ/AIq
 2fatb099eedBS09gzwFi//3GcqoN34KNpYRoQW4cJ4/Vejs1L2V/MHsh4LVlHgWgRaIS
 oVQ88jsSy90+xM+Uu+oyPDTH3JFMlZU+xUl8emJBqD+fHqfEiekED2aQpY5MAnbXrGgD
 sbxA==
X-Gm-Message-State: AOJu0YwyRhkLKyloUxw/M0ICC3HsNny4YudnIEcbPgaWdIKBcjcfpaEb
 /e0wyeMGwNtPCDSoBh6xbBd4hvKGSXxevLutbAWVS3s7FI5Xh0FxjczD8bjfENY=
X-Gm-Gg: ASbGnctkVpvB9+OSPuUF8ZzHTAf1J/XDJmXNjVwy0SdKrIR9VWWzo83l6v9iIvtqDtV
 sBDkJBa9/AZ1Q0rELER3T2NbVBXxCz5Gmx8F6CxV1tLYQz5v9PZVGUBP9BVTpUdVff99V3Yd951
 VWfw9yOO7jwY1TjZtkgxq52jBPBCLDK8wECCpKA8oOIV1uBRp37FyCs2hobqJdNpbmNBNGjNTIC
 MBIerG0Yjhj9veGuXG8USh7Mz7KPtNnJrLbhHetGFgN8enP1JRnqgQ=
X-Google-Smtp-Source: AGHT+IGo+wcPIUm5G0/jtXBLqH5ca+Dli7gnyEH9W2lp1SOKF1Wreawcz2LrHEB+G2Cpo2/89YL5nA==
X-Received: by 2002:a05:620a:4014:b0:7b6:d9f6:ec37 with SMTP id
 af79cd13be357-7b6fbf453femr1036926485a.61.1734186225999; 
 Sat, 14 Dec 2024 06:23:45 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7047aa729sm71973385a.12.2024.12.14.06.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Dec 2024 06:23:45 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: w.egorov@phytec.de, t.remmet@phytec.de, sumit.garg@linaro.org, 
 kever.yang@rock-chips.com, marex@denx.de, festevam@denx.de, jonas@kwiboo.se, 
 Oliver.Gaskell@analog.com, aford173@gmail.com, prasad.kummari@amd.com, 
 neil.armstrong@linaro.org, mibodhi@gmail.com, n-francis@ti.com, 
 d-gole@ti.com, afd@ti.com, sjg@chromium.org, bb@ti.com, nm@ti.com, 
 d.schultz@phytec.de, nmorrisson@phytec.com, francesco.dolcini@toradex.com, 
 vishalm@ti.com, vigneshr@ti.com, y.moog@phytec.de, othacehe@gnu.org, 
 m-chawdhry@ti.com, j-humphreys@ti.com, j-choudhary@ti.com, 
 Garrett Giordano <ggiordano@phytec.com>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
In-Reply-To: <20241118231606.3161665-1-ggiordano@phytec.com>
References: <20241118231606.3161665-1-ggiordano@phytec.com>
Subject: Re: [PATCH v2 0/2] Add phyCORE AM62Ax
Message-Id: <173418622238.1834185.4539686149479413292.b4-ty@konsulko.com>
Date: Sat, 14 Dec 2024 08:23:42 -0600
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

On Mon, 18 Nov 2024 15:16:04 -0800, Garrett Giordano wrote:

> This patch set adds the phyCORE AM62Ax board support and documenation to
> u-boot.
> 
> The phyCORE-AM62Ax is a SoM (System on Module) featuring TI's AM62Ax SoC. It can
> be used in combination with different carrier boards. This module can come
> with different sizes and models for DDR, eMMC, SPI NOR Flash and various SoCs
> from the AM62x family.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


