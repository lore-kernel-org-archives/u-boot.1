Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EADC5AD49
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 17:55:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ED4782B34;
	Thu, 29 May 2025 19:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KPy8Bnz0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92B6B830F4; Thu, 29 May 2025 19:55:10 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B83E82B27
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 19:55:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-60402c94319so734965eaf.1
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 10:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748541307; x=1749146107; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwGglg2vCJsC9Fmixz+oL8uZpKyhYFuHesKTbFFAifY=;
 b=KPy8Bnz0yXkhf0SgNq8L70Bd/qzl5pFq1cLogsBo9K3+3/TOcZPasFp+JhMiIwznJM
 zpLPJEDpFgsJsYozVy6dYGiTuQdjLRWc9X6WXaL+btyE3B8qG7GllO4rX4kllnjR5iFo
 /sSh12mXoXJJrTB4CSYF4tDSDhho5qwwCoqaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748541307; x=1749146107;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HwGglg2vCJsC9Fmixz+oL8uZpKyhYFuHesKTbFFAifY=;
 b=glkVUDEYZOkXqK6j5n7oQjWNWQJXoiNjzcz+GRCETpu1wmNBa0HZ5c11uj9V81NYxa
 kRVY9+AOzdZIt7VRNUc5Dwsv6awXkgjl5o3B2Zp6d8usDjQBGCl86kPl7gNPt/kChOIv
 NIznfmNH8Zxe7e31LuFF/y64hBXDoj4CQ8DLao+MjmqgZc469GpbiL6K/7A19mzcmzOG
 8gl86yJJ10FYe3ARjVgTBBLp/hlGxBQ8qvE6IRuCN5yH301uqCz3EYHgU3UWdCG/VGoG
 g09n6LR7lNexe3jpZfs9aUOLNrQNzEIIP6vOO26nzhYoNjyOB6pmQWUIhjHx5VXZ1qqB
 wfnA==
X-Gm-Message-State: AOJu0YznfLuPKklOdb5JJmNVHjCX3nCY/0ONInXlgBBHwLN+prZnJA6K
 gH6Vmb5y2q0KKeC4mYGozK0FIqTo8R8VyAjZz+J0yot1k0IXbLjVlXu+gVu1wqHCC2c=
X-Gm-Gg: ASbGnctTRjWNZCxTT5yIrZZ1wmOvS4ZepcFEB/XkNGjX030yDUA6V2mdgOZmVpCGdcK
 fParW7IojOYWUkaqm1EnyvLrpxOUKJOmLg2l/ROrcg4FJ8IbtZhgXwDMQBWSQiYKpdjcqohTNpG
 puc0ENA6ES85aMGSN4ghITsVLlrBotNjZrbTKLfh4wX3ai6DeU8s8HZdFOzgpRTB/OvE4zxGsHh
 1O3NBdqcNoB9GRZOofmUblkCEWdz7ccyzCqww80wlMHV/3pr7OwweBVpSD6QYaOb8D+YQ05gqT6
 LEz+6+3RwWJud1bzquVaNOEzylhDUyviWsYxbEfY/1yAtMY0jrjoz6IuA6mGhWDtzn7zv7NkZn8
 kyvswhFhZtj/Iy/TzK9JXiA==
X-Google-Smtp-Source: AGHT+IGgvDNm7KNSFGZe125gKxe1WqyXan4EZuTyMiIMvLTR73Qr4WUU9v23nL+cIMhYrdwJrjOQQg==
X-Received: by 2002:a4a:ee86:0:b0:60b:ad9e:2bbf with SMTP id
 006d021491bc7-60c4d7b5a00mr429855eaf.8.1748541306968; 
 Thu, 29 May 2025 10:55:06 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60c14c42c16sm77455eaf.7.2025.05.29.10.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 10:55:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Wadim Egorov <w.egorov@phytec.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Garrett Giordano <ggiordano@phytec.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>
Cc: u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>, 
 Chandru Dhavamani <chandru@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250515-b4-upstream-k3-pll-miss-v1-0-e38b89f027b8@ti.com>
References: <20250515-b4-upstream-k3-pll-miss-v1-0-e38b89f027b8@ti.com>
Subject: Re: [PATCH 0/4] Remove clocks from R5 dtsi for missed boards.
Message-Id: <174854130594.3917659.12318910845038334879.b4-ty@konsulko.com>
Date: Thu, 29 May 2025 11:55:05 -0600
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

On Thu, 15 May 2025 17:08:33 +0530, Manorit Chawdhry wrote:

> Fix some of the boards that could be affected by the change done in [0].
> 
> I can't test the changes. Please give Tested-by.
> 
> [0]: https://lore.kernel.org/u-boot/20241121-b4-upstream-pll-fix-v1-0-904f618897a7@ti.com/T/#mecb70b415a364fdf322a94241438db7b5607e92b
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/4] arm: dts: k3-am625-beagleplay-r5*: Remove clocks from main_timer0
      commit: 53f42c564367c4f2ff645b6c080da62855ee11bc
[2/4] arm: dts: k3-am625-phycore-r5*: Remove clocks from main_timer0
      commit: 92f1347d7caafbcc03b67bc5eb131813c3ed2eb6
[3/4] arm: dts: k3-am625-verdin-r5*: Remove clocks from main_timer0
      commit: 2696d3baea5910c9fb9f93d14e2354eed05f4e15
[4/4] arm: dts: k3-am62a7-phycore-r5*: Remove clocks from main_timer0
      commit: 8668c6a3bd1aa1da9c02ac140b7dbf7b3266ab1e
-- 
Tom


