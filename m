Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7823C0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 17:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FE1B82163;
	Fri, 31 Jan 2025 18:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Hj/QaZN5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5D0682786; Fri, 31 Jan 2025 18:26:27 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DDAE82163
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 18:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7bcf33f698dso213391085a.2
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 09:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738344384; x=1738949184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jh8TBeKpP47Y/FEe5Z3hlsbgkLpt0lfp46SuBzXJSeE=;
 b=Hj/QaZN55UaQdNYqjlJZKJOHBo4xMkfNsnWUfKwGPKBLbZA7pik/pv+LQK/IyfosZe
 hdhALjZmzClGTrTcLciR08x6XtfVaGT73IIWYizpIsiopElmryUYOxGcz9Rx2HhjhzB7
 B6sh7hE3UJL0MYTWhGvm72Rz9VkXD3KUWXaL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738344384; x=1738949184;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jh8TBeKpP47Y/FEe5Z3hlsbgkLpt0lfp46SuBzXJSeE=;
 b=R3NBWAUAVz5UTmfrWGSKJIlq5l5T+631YxJxMEJSEvtkf0F2mlLuL9XlnUHrdtu9XW
 5MT5n/HNcfmqAGXfT/5YahMfy+qVv55qdSBe0AFfLcdFi+/Pa59QrQ4A0u+R7xTril9Y
 IsQyfGT70Kenf6SAp8xLY18M29r1DARzLd0l1LpFPwOZn4c0UH+R/d8ywqozkdageBL/
 673d+vZfosD/UDHKmtn3ny/axTggW0gnHeZRhjKoe0WfXq1JtHt5HoM6XAqxoXdQVQrg
 EbM4V+Xi7ZvHCGr2snK2F4hPAi4JbSbhMOU9+wtGg+WAyBM+rpt7RuMgmP1DXunlgYsa
 UlIQ==
X-Gm-Message-State: AOJu0Yzpf8ujsEEFcmYNvfwgDAZCHqSsxbcxXo2vC+6k13qEfgBqwHmp
 wWSrAP/b4M+tk58xxYen+HSHWCFfn3OGjVu6BwcTyrGXJXSVD7Xcdx++fHF1IUZTEzVzxDL6dCU
 z
X-Gm-Gg: ASbGncsPSnz8XjXnrXlRaHhWpsM8hCskQ1VE0FIgpA9tCJ6tDBaz12nYNSlS3MpdOCh
 j3A9Kkq7nDu+PQrlhkQfRVli8nMDxZDAPyk5Ze/x4p63IxW/R5L3QeyV0iUbwNRjGt2BRG2/B7w
 YLKrYbvdYNHCmiflgtbA3GVcj0wT/WCg1a+D1dJaOY8eVYCDcOHxCRQLdZwD1AELUBt4o4M8QKY
 A9qyHHOjNme6lXUJTkCOHoF+KHObPgS3XgvFcJI1ci3J9Whju66sUyZoIMgYEs2a7YyutF6eGQD
 G3vB1xYNWXSODw==
X-Google-Smtp-Source: AGHT+IF2hIljRekQYQ5qpifmHCt37YgYP1XRjrqa1dvvr6Vg53v/fLuNoJNMMua5a75yYvgvymlfnA==
X-Received: by 2002:a05:620a:2a03:b0:7bc:dec0:2bed with SMTP id
 af79cd13be357-7bffcccaa49mr1870487685a.7.1738344384402; 
 Fri, 31 Jan 2025 09:26:24 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8d9757sm213391585a.63.2025.01.31.09.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 09:26:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
In-Reply-To: <20241229205402.157529-1-marex@denx.de>
References: <20241229205402.157529-1-marex@denx.de>
Subject: Re: [PATCH] net: phy: Add RGMII RX/TX delay handling to DP83822
 PHY
Message-Id: <173834438339.3013010.7107786049013460271.b4-ty@konsulko.com>
Date: Fri, 31 Jan 2025 11:26:23 -0600
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

On Sun, 29 Dec 2024 21:53:26 +0100, Marek Vasut wrote:

> The TI DP83822 does have support for configurable RGMII RX/TX clock
> shift, add support for parsing DT properties which describe the RX/TX
> clock shift configuration and configuration of the matching bits in
> RCSR register.
> 
> The shift is only configurable on DP83822, the other PHYs supported
> by this PHY driver, namely DP83825/DP83826 variants, do not implement
> this functionality and the RCSR bits used to configure the clock shift
> are missing from those PHYs.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


