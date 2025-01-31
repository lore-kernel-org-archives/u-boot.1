Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888E3C02192
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 22:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01F6E80FB5;
	Fri, 31 Jan 2025 23:07:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B7GvWVFD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ED8F80FA4; Fri, 31 Jan 2025 23:07:01 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58219807D9
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 23:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6d8f75b31bfso19124126d6.3
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 14:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738361218; x=1738966018; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJ2cYK7O2Zdij2obqktnhJ9rIFvCa9aBD7IV8hNDoeY=;
 b=B7GvWVFDSK1Z+n1gguLxHEkzFVB6lrIB9cQnqV5mAmFYJH+2uJXkosOhSirrhPO4+O
 iBV02nJuCCrk5suoCujMHdBJQppfF6Hcs0EOi/C0fpaaTrqVieIg5Ph/7Su89WULr/7E
 qTNIyUYl5wCn3ytLGo4CtqQmBsAjK6kUc/e6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738361218; x=1738966018;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJ2cYK7O2Zdij2obqktnhJ9rIFvCa9aBD7IV8hNDoeY=;
 b=TABe1ktHRVLjw2dK2yzPFvg95HPX4FyhuI9klsMgQ6H+6aQ6iPa/N3ZyspOrKensPz
 v/YmW9qAj/3mkfvUXSPkG2LimKn/STpXwBeftmfIbBeCXyMffmeEDZdC1cMakJI6ZorI
 67L36t2zUDDHxED9mH45oGyOgJdllYTYqN5bKgZYXF441WCNyYYe0rauBbeTxcMD32dN
 OQzQrofJuXL3wD3OFsPtF0JFsPDbROB6sdWTdz8lY5LbwHCxjg6fZ14ZWSKnltnRlbf8
 vIfcfAFB1TtRc1cwnCXNmX3A/b6Z0cJ9rAUgQQCOZ/CVSmh6HYBTLpdSPibDOV65v4M2
 gLeA==
X-Gm-Message-State: AOJu0YzJo2lH9a+coVBGnLrbNmWsV+ec1O0tPcdLJmh0Ca350tD20KTt
 PWDytq7N/PsD5KJvAlxx/FSu1dMBXKTk5uHWJ9ACoYzzzxs6PKkW+Nho0vUSI07R4u2PDaTqqbs
 h
X-Gm-Gg: ASbGncuCUQEvwxmavgQZB3WXLytlwXBNbtCf1w0eW5cMm/WDIF4MYKQQMs5BM5qFAy3
 v+eGgauGZcZoReCgl3rQ10Bh7zyoyW22Wh4cCcUzSDOPxVWKoFaAjIa4sy3epqHG2j71nCJVOXi
 nxTiZh2FcTZXpURgzYbTS/sRlgAOe1XSI5g++RNWIXXRJ6pwGsISzOR8j7QaNhC067AjeFvALw2
 zhUvWaXWnvenzJAPQLGoiesDrXK7Q/T+K9FQ8DtaMw7MhNtbtBj1audZaFuy226jDG+1RSSLIFJ
 c0VZUajQUo6rGw==
X-Google-Smtp-Source: AGHT+IEWVLVFa7dc5Bxa2zYm7MWo0/FTRI9QAhmwrvHodUjwMgI6LPk+m1vNRpZmXXq/D8q79pVKWA==
X-Received: by 2002:a05:6214:20cf:b0:6d4:2806:1765 with SMTP id
 6a1803df08f44-6e243c63ca0mr209489836d6.34.1738361218283; 
 Fri, 31 Jan 2025 14:06:58 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e254819a57sm22141986d6.45.2025.01.31.14.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 14:06:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: francesco.dolcini@toradex.com, stefan.eichenberger@toradex.com, 
 emanuele.ghidoli@toradex.com, joao.goncalves@toradex.com, 
 vitor.soares@toradex.com, igor.opaniuk@foundries.io, 
 max.krummenacher@toradex.com, Stefan Eichenberger <eichest@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250124151443.576075-1-eichest@gmail.com>
References: <20250124151443.576075-1-eichest@gmail.com>
Subject: Re: [PATCH v1] toradex: tdx-cfg-block: fix switch to user
 partition
Message-Id: <173836121633.3060818.16664719405162668000.b4-ty@konsulko.com>
Date: Fri, 31 Jan 2025 16:06:56 -0600
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

On Fri, 24 Jan 2025 16:14:30 +0100, Stefan Eichenberger wrote:

> The Toradex configuration block is stored in the first boot partition of
> the eMMC. After reading the configuration block, U-Boot switches back to
> the user partition. Currently, this operation always targets mmc device
> 0, even when the configuration block is stored on mmc device 2.
> 
> This patch addresses the issue by switching the mmc device set in
> CONFIG_TDX_CFG_BLOCK_DEV to the user partition, rather than using the
> hardcoded device 0.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


