Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DD7C27C79
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 14:55:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F8B188A25;
	Fri, 14 Jun 2024 16:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="htZfOQqG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80D3A88A2A; Fri, 14 Jun 2024 16:54:33 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7323288A1B
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 16:54:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-24c9f628e71so1058910fac.1
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 07:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718376869; x=1718981669; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=psMrcb6nb7zLU4WBFrv7D0OMBm6Gd3a67vajpB8+xEA=;
 b=htZfOQqGA41zkW4N201KQkiavMd/mEjO8T+xW+43EN7ZRED1CdhAPOfwirNd7+Mtfg
 H8t/z968erSORN5NR/S5+D5GwwGAz6r34C3PJemGyQx1Jg6vRxsUDb7UWvXe1jE/TkiV
 BPClb5XtKH81xougFAAyRPrp0zMUVnM/KIqe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718376869; x=1718981669;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=psMrcb6nb7zLU4WBFrv7D0OMBm6Gd3a67vajpB8+xEA=;
 b=Lo8kLIO/xyJpzZB6WA8E6lXbltguqBmDR5OLTOZsp07iVmXV4ZcChG10eOwJI7m++d
 +88glkzMUI3+X/hWgiE4a99eK3EbLYKO8R3tI9Jez2YBVphZnoS05aUfV+yPaUtBnF16
 YNIx2bqLtdzfiyL0zYg4o0FYSo8syuG3Q7YFqqfVr9QVvGVLbQcpl5o6KW5fVKjFKudl
 OvxrMRBLk75C5j4pVWHw/xuvstkBijdmbkJEc1ntxQiZs/EwFwd3t9Bh99m68LjddbLk
 PaiBph5ot7hKV6EX3+toFYfDbQiuQaa1Tc2M3UaGW6s9Jw3Wnkuaf59Hj293rxZpLdnl
 lOEA==
X-Gm-Message-State: AOJu0Yz8rKJ/q9msMk67ute+ZnIvpLNl4TC3GgiPIKspvOEoJVSq11Zd
 uvS/aTvwGDq7b6mNIs4N+D6xFYAJdM0OxXXkclnUbOhvtPyPXFs1lcKsDswJW9k=
X-Google-Smtp-Source: AGHT+IGsANRBprPn8S3s885OWTPNh3ZFwB55Oh1kw1fleUXNUiPWrrhtOXk1MfGMuyPtpQe5i0fsFA==
X-Received: by 2002:a05:6871:295:b0:255:1819:b458 with SMTP id
 586e51a60fabf-258428536admr3237105fac.8.1718376867649; 
 Fri, 14 Jun 2024 07:54:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567aa2fbe8sm986898fac.28.2024.06.14.07.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 07:54:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Yasuharu Shibata <yasuharu.shibata@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240602082403.17508-1-yasuharu.shibata@gmail.com>
References: <20240602082403.17508-1-yasuharu.shibata@gmail.com>
Subject: Re: [PATCH] bcmgenet: fix Rx buffer corruption caused by lack of
 cache flush
Message-Id: <171837686702.2655592.7108570934184418174.b4-ty@konsulko.com>
Date: Fri, 14 Jun 2024 08:54:27 -0600
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

On Sun, 02 Jun 2024 17:24:03 +0900, Yasuharu Shibata wrote:

> When bcmgenet complete to write Rx buffer with the DMA,
> some U-Boot commands write data to the buffer directly.
> Those write data will become dirty in CPU cache.
> After this driver calls free_pkt to the buffer,
> the buffer is assigned as the future Rx buffer.
> At some point, if bcmgenet writes to a buffer with DMA
> and CPU cache flushes dirty data to the buffer,
> the buffer is corrupted.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


