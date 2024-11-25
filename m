Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117D7D59D64
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 22:59:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4243489A00;
	Mon, 25 Nov 2024 23:59:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hBsi2TL5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CF6E894DE; Mon, 25 Nov 2024 23:59:49 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAFB5885F4
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 23:59:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b6662bc408so147089485a.1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 14:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732575586; x=1733180386; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JniaGCWpZmie4JaPnrltU/KX1s4ri3HlQfHg8Wfom/w=;
 b=hBsi2TL5jxIaUy4kyp0jh2Pc9DZIKKrbqD2wtuRoi16NoQUq0yBQnL/sXx/vHBIge9
 BvjvImDxLyemaxqBduU89t2DimnWGaREefoykdvQ0GDbPOt1fvWzz4rpzY501zbF7WHo
 qwYlRZtvblJlEfUy9PNjEBod/oaheGAQDfeGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732575586; x=1733180386;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JniaGCWpZmie4JaPnrltU/KX1s4ri3HlQfHg8Wfom/w=;
 b=L3KFDYbkCm48yKXlMgmawS7aNR3Eo+ObXQpdkJU8YP6+ViJ9Rk6O4uzYZLHZKFFM95
 ZjDXdRtHaFtIzbMXkPIB/jXyWo6xWo8Io98pRhdyJFN0FmunxG2+V4Cjf+jj/+0wwEZ/
 DfnSAMCDjHz1VWIE7nm6STkglZBUUMNlNx6DQGpUSc9Y2dkSi7nUkTPmw65Czkf5NYmF
 F5gKm51pceQcyn+4Cg6uVPQBuwA2R2T1pylKMkHjLgnyA/PcN4SNdRHUSCT8xUr/aDSz
 AdDwOKEy7Wom8k9yHfE7MU7ea/zRrpLmgWTY0Pi3tDHe20MQ7FLFgmDgIOWesjL+RlQP
 vlSQ==
X-Gm-Message-State: AOJu0YwXDbcrRr9GTZY2czzBH2IcrhDnaB7Jyqn13d/Qwqc8uPfQuF1a
 3LDn5DpeZRHp+4iZnXkoF59brUQ1QCP1OWoFssKENY79QovYL5Sbrm1+2eNcZKk=
X-Gm-Gg: ASbGncujz15p8zpB7dVBl1YuyoE6L0RwvFGLr+X+FEYB8cZcO70kh5Wmy6E1X61vahq
 3jHb3bGVvJVqLb6G1JUKDKoy3JeNC3tv+9snOypRyBigzZahl4/DANi7Lb3uRk9MEsUTXFDmeqF
 FRzxczI/vGm3j2uE/kt1sePu+JqGnFhGF+2UgYoC5lPnkUABLCmIqwqtzLgYHNTqZjCb0OvHg0s
 4vAbQ7Jea8zlOczZgYoCqy+ZzTR2RpFWok1CMtAenClO2Gh
X-Google-Smtp-Source: AGHT+IHpPg+pOREnWeA4hURUNt0WdfMf8dq7PbNL7YkCS+WCNZ9H741AnqnhTn6mLcgwubXdBNjjqA==
X-Received: by 2002:a05:620a:1a21:b0:7af:c60d:a0a7 with SMTP id
 af79cd13be357-7b5145d2688mr1877628085a.50.1732575585783; 
 Mon, 25 Nov 2024 14:59:45 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b513fa4f85sm399797285a.28.2024.11.25.14.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 14:59:45 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Dominik Wernberger <dominik.wernberger@gmx.de>
Cc: marek.vasut+renesas@mailbox.org, jagan@amarulasolutions.com, 
 michal.simek@amd.com, tudor.ambarus@linaro.org, venkatesh.abbarapu@amd.com
In-Reply-To: <20241125212152.29397-1-dominik.wernberger@gmx.de>
References: <20241125212152.29397-1-dominik.wernberger@gmx.de>
Subject: Re: [PATCH] spi: Fix missed rename from SPI_ADVANCE to
 SPI_STACKED_PARALLEL
Message-Id: <173257558417.3968756.13981230371765750095.b4-ty@konsulko.com>
Date: Mon, 25 Nov 2024 16:59:44 -0600
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

On Mon, 25 Nov 2024 22:21:52 +0100, Dominik Wernberger wrote:

> Fix missed rename from SPI_ADVANCE to SPI_STACKED_PARALLEL. This fixes an issue encountered while testing the Zynq-7000 QSPI parallel Flash implementation.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


