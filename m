Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E35E7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 01:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29AA380137;
	Fri, 13 Dec 2024 02:11:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i+TwwdyR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40E5880192; Fri, 13 Dec 2024 02:11:58 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19766800D6
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 02:11:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-46772a0f8fbso10840161cf.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 17:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734052315; x=1734657115; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VsKEV1l+GrZ31i6avEUCSpxWiVlLN7j8BzN8WX/NpCI=;
 b=i+TwwdyRsf9O2ywpq9ESg2G0Hl3Q8Be3bKjkOrHOma1AusRYMYJt6+AfwBrtaHGQf9
 PrfQczyLPO81ylTZhrE4PYRARgT0JUXgMzbaSXUSJ58JF0pPMtXtA6C+24jyIkPM/PBU
 JZee8q40hNKsxoYu73/Gp3+xCrLqhN4ECW/0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734052315; x=1734657115;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VsKEV1l+GrZ31i6avEUCSpxWiVlLN7j8BzN8WX/NpCI=;
 b=Vufc+r1BgLJExCy7g/56+A5+jWeS1TmiKHZXv242nOKnwSIvRDwxNn0icqP6PWIXfv
 1E/L7ME7FUcEhNA5vxLujPRgZN+jIxtt5l5IP1scFA1b1S9j0Hc+qVpJMAhBQINr55St
 4q9dTar4AhcetHKg1Kc41DDFlZ6j4RvkoXTbXnEr/t45VrqlUHAZh+qKj6Fns+3Y3IS/
 EMuJF/inj5zxRcMlEZDeYC3/zwI4v6Wka7hJCKtaYymkD+6PoSsRviuuO3qNElELac5m
 1dRLqPrmnKKDuUborFJVJBXJlgv9cLgqYz0IBMXJnJ8Yy3whVfNlxRWUIySP1DxRv9E+
 GTEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6/jdneiLpjxlwMWhgasI6plCKqu9dFxOrXBM/eVOy5U1Fi1hhOBGfEQ4KBdkOLo6d8BxQS0s=@lists.denx.de
X-Gm-Message-State: AOJu0YyQXH6fJetJ+B5Z3lUPxFds7fvyqXMGP2nTMUviUd9hXX/JdDK/
 62cuySbhDB1ShjN3yEjP9mt8hbXu9qYYVD3JQe2Kb0zXd1M9xvV4GW6bE1or6hY=
X-Gm-Gg: ASbGnctrUBRjiLkqAvOy6k/X9WUZZA8vJAicuc5UKmSEm/8x/DsyGrElpo8EY9BcaXX
 sNqv7ZdibOm4fd+0PThqPQtOtnW/Ikyd0dhUzklXxX6CT9TQfviYdhaH5UkNSufabPFZfiKWAyL
 SBE+lwdVMIa1IXnnY5jc0Lnb3A+Hea6eJXELCnkMdQzgaohEUMeeHE+ZFmHdl3i0dalicr1Chym
 wwSUaiGr8UECKJ0Iy/CM/bVwbYx9HIsKtbCZ6AJxj+uCet1efvWhoo=
X-Google-Smtp-Source: AGHT+IHmZ/AIPAOkTf7ftkuXgaKPdPciNshVDW0/R4VCFvaZqxsKxOLwqtXxu78KGvqZ0qw8MIMPig==
X-Received: by 2002:a05:622a:18a7:b0:467:451b:eb99 with SMTP id
 d75a77b69052e-467a57a95e4mr12761831cf.29.1734052315007; 
 Thu, 12 Dec 2024 17:11:55 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4672978dc20sm90148181cf.71.2024.12.12.17.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 17:11:53 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Yang Xiwen <forbidden405@outlook.com>, Julien Masson <jmasson@baylibre.com>, 
 u-boot@lists.denx.de, Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20240308000432.32369-1-semen.protsenko@linaro.org>
References: <20240308000432.32369-1-semen.protsenko@linaro.org>
Subject: Re: [PATCH] clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE
 present
Message-Id: <173405231246.1635625.8070306930792525634.b4-ty@konsulko.com>
Date: Thu, 12 Dec 2024 19:11:52 -0600
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

On Thu, 07 Mar 2024 18:04:32 -0600, Sam Protsenko wrote:

> Sometimes clocks provided to a consumer might not have .set_rate
> operation (like gate or mux clocks), but have CLK_SET_PARENT_RATE flag
> set. In that case it's usually possible to find a parent up the tree
> which is capable of setting the rate (div, pll, etc). Implement a simple
> lookup procedure for such cases, to traverse the clock tree until
> .set_rate capable parent is found, and use that parent to actually
> change the rate. The search will stop once the first .set_rate capable
> clock is found, which is usually enough to handle most cases.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


