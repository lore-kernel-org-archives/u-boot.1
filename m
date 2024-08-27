Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E925FC5473F
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 23:22:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3284E88A53;
	Wed, 28 Aug 2024 01:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fm6lkity";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83B5988A8B; Wed, 28 Aug 2024 01:22:49 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D0388875C
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 01:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6bf705959f1so503746d6.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 16:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724800966; x=1725405766; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J9GQE7zrPz0XY5X+IzJklR4qsooFADACy0JI6EXD8zc=;
 b=Fm6lkity8RTXF7Q2lqpMSfhlkodhyMcJJOPSL/ilAd6qB5W1sw+g8JYe1OQhQ4IiO2
 oeTzgQWBd6MoXpx5EYCfpV3V+BbTNSDE6GCNxo94iChUpIe/Zg9SurumpjXGKaAn0QAO
 CazcziRN1B5NShlTjafILUEafKoi8PyA99OPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724800966; x=1725405766;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J9GQE7zrPz0XY5X+IzJklR4qsooFADACy0JI6EXD8zc=;
 b=GKW6+ZADQiPLBiK/koA4EpPJD+59Ky6Op6mXvrhIXMGSNQ223AtjUb5eLb+tNxMQMo
 Gd/WTRTjXJzYUf/p8ah9qWXf6wMTg2gae/v4O1ckGf/mY5oi2DwYtnAgr+Qw8DZ432Kv
 OKXC0LIffBKRi0CBmqVLRM8buASNbcv8djI7vlmy/zINGykYOUsUkHNXNRhBwEf1JzFE
 +W1n1h40ooGu4tQkS0091cj5S2J2moqYy5h3WXvC6XZp/+Bs1aYeMykfFndTIBv+zdn2
 N+KhDu5ZuAnmSkRuKgfSutYeH3OevOu8qz7JiO2pdxZT/ICiTfBzfbik+e1JxcpzcmTm
 DEjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU91ac6q63adzZJHtogggyBB8RM8GB2AW2eZ9svL46sg+itICiWA6uHjCEufBXPCaHMl+MJkGo=@lists.denx.de
X-Gm-Message-State: AOJu0YwGVc+ScOYMmtGwcZLFWbFki11g0rZiZDI/Aye4XKfy4FeDagw2
 Pfn+ZpmFlENHN061G3NALCsn8cG1oPI0+T4tSQQarxFF/uwkZFtuq+8z59d18kk=
X-Google-Smtp-Source: AGHT+IG+apU2OiZO+S5w0RBle9AobBT5tY14tDJjlDdby1+L1nD/7tzevzqQ+VOWX+RvtrR2WUZpWQ==
X-Received: by 2002:a05:6214:440b:b0:6c1:7f5c:fa91 with SMTP id
 6a1803df08f44-6c335da41e7mr7003596d6.25.1724800966250; 
 Tue, 27 Aug 2024 16:22:46 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d494d5sm60486716d6.32.2024.08.27.16.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 16:22:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>, 
 William Zhang <william.zhang@broadcom.com>, 
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, s-k6@ti.com
In-Reply-To: <20240731145855.3122166-1-vigneshr@ti.com>
References: <20240731145855.3122166-1-vigneshr@ti.com>
Subject: Re: [PATCH] mtd: nand: raw: omap_gpmc: Check return value of
 gpmc_nand_init
Message-Id: <172480096431.2972894.12027347479310043926.b4-ty@konsulko.com>
Date: Tue, 27 Aug 2024 17:22:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 31 Jul 2024 20:28:55 +0530, Vignesh Raghavendra wrote:

> If the function is called with no NAND device attached, then this
> function can return error value, proceeding further ignoring the same
> can cause system crash. This is seen when "mtd list" is run with no NAND
> addon cards connected.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


