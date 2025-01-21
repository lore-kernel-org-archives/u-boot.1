Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CD1C02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 17:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 319E18076E;
	Tue, 21 Jan 2025 18:34:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D6qKoRkZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75407807E0; Tue, 21 Jan 2025 18:34:22 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C55C801F5
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 18:34:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b6e9db19c8so535833785a.3
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 09:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737480859; x=1738085659; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XWip3MYYlsRQv+Ay3mBO6ZEm6MeneYw4GbU0Fb96Kp0=;
 b=D6qKoRkZ8+//CU8n9otjGu3+LuSvL0d8PpYkXgk9pzhcXhJrar5BfwVoMyNqPWtBM2
 uIlBdvXfhLcey/MOURSJQW32uqKQiMaxBV7WftexU0Tdmikyp0ldCzvggSnNMihyCDxU
 uWLSC7MEKXbq+5TaRUKHNY/XYJN5T2CX+nHV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737480859; x=1738085659;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XWip3MYYlsRQv+Ay3mBO6ZEm6MeneYw4GbU0Fb96Kp0=;
 b=o4N0mSUNgi30x0PNxT1Tb7W8mPXeEfr1G35BHbbGGQKeFq4jYIFigBXbMzXla6OZcO
 VLohcbHl2UQqnt8ID54dk8M3p0LtAfnbSCN8GuhPsxTmEnXYUw+pziTPg6iOywKI8wQA
 5In1243KAB9Q//5CxY11wtaEuJjLoq3pg+gBkXBo1a7+JAcfSSHRNj5DBNAsEFAF36Hc
 +aCxXxjNG1qfK4Bawpw8uQNRrc3rmv+kaUcOQkr3FCQgPlo9RzBHiRvcm250mo+47/J0
 QAVDaF3nDSRlFku9F3DF/lBod2Yt2D7mOjNblq2l1j6zZV9ry0oAvC4ymw9O+j6dwHfP
 IP2g==
X-Gm-Message-State: AOJu0YytEIBb2ahu5JFxH35F4vpqx0PF8HqCG8Pgamj5tOMjOEfHSEeS
 dy79JWUUuyQYehBtCKy7En8wbj2IQiM1EvkmX3SDpL62Av9JF7run3otC0xgBS8=
X-Gm-Gg: ASbGnctZPUT+Yl6c9oGF0PPStVKa6iZfLQfV5+rENEVsmW5+fSgPXDWtIrfM2XX7p7d
 YITn9Mfgc+TH+lRDnKX8vsFMCIkrFW6td2d+33cNV4Cyr7buax9Cqve0QLKb62i0OW0kAbMdk24
 ML+2rcqHW7SpxOvSzW3KSINkhViS+IdLkevChNHQLRg5yKbcobG/SLbqEXY8lwzThuhnKspu33I
 X8jmNrt8u62oJMprG+9c1WeRldBeHdpVlRzJ3JUKV/853hO4buqjwYMQ57g8cJKmQ==
X-Google-Smtp-Source: AGHT+IHp/ErA4K5jvyxHr+syXbhf0ZLgsDM4XVk3fTI15BnO3gS74bfdAVOnNA6GL5oG976Zaqtcag==
X-Received: by 2002:a05:620a:4396:b0:7b7:2e7:7a88 with SMTP id
 af79cd13be357-7be6327cf0amr2833131785a.44.1737480859298; 
 Tue, 21 Jan 2025 09:34:19 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614746f7sm578462085a.9.2025.01.21.09.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 09:34:18 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Naresh Solanki <naresh.solanki@9elements.com>
Cc: Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@denx.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Tony Dinh <mibodhi@gmail.com>
In-Reply-To: <20250114053218.911825-1-naresh.solanki@9elements.com>
References: <20250114053218.911825-1-naresh.solanki@9elements.com>
Subject: Re: [PATCH v3] sbp1: Add support for IBM SBP1 board
Message-Id: <173748085704.2982616.5578072281322269680.b4-ty@konsulko.com>
Date: Tue, 21 Jan 2025 11:34:17 -0600
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

On Tue, 14 Jan 2025 11:01:53 +0530, Naresh Solanki wrote:

> Add defconfig & devicetree for IBM SBP1 board BMC based on AST2600 SoC.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


