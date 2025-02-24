Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50814C021BB
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 20:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BDB880F56;
	Mon, 24 Feb 2025 21:27:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m3W5JgAo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E920780F53; Mon, 24 Feb 2025 21:27:19 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AADBF80977
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 21:27:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-220ca204d04so78744265ad.0
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 12:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740428836; x=1741033636; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uBgW73WB/8cQhfs8MCxaOp5h7vE3Pj8PIbTrr+Iq/28=;
 b=m3W5JgAoYIap/PjUt5Q69aq0PaXpTNl2lUpgx+KGUoREZ+YEdaricBlBzCAcy41fPc
 6Ipc2E/6B/pwa4p+ZGLkQpzjazfd62K/7zJjT905hLJ73QZ1ANty1JlQoJb7BvTeqjea
 dwhgb+CdrjtFDp1G8zRWqM4EZuD3WWnVctBTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740428836; x=1741033636;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uBgW73WB/8cQhfs8MCxaOp5h7vE3Pj8PIbTrr+Iq/28=;
 b=kmxhxn/mPrXg1b1UQCZ9BgA00zEyvUmgSXT9Yi0JJwnK26ErgIdnNsupA+yfAkwSkR
 LLJrilNzgHhZLgnB7uOPv2w8WFUHP6i+UdMNpC1S32EWIfYjOrQRVNFheWDLdIFxZcz5
 /a2WGjIpprNpgyV49/IckK6ZLcrOPZ9dJvtwlB0npf9D0n/s4LA/fyHh+I2Og5yzMSL0
 VsHn3Gkyc1acFsuZ/JNS7f5JM3pvr/dUWG05LQWRuFM+7nVqRTREBXy8nmZkSX+IdII7
 ahJTOa7TNHjXGN1LwE2q/O/y9/l6bQEWBHBG+gR2dYbVb2VJAuZcJ0fgclXYBl0Fm9Nb
 Jogg==
X-Gm-Message-State: AOJu0YwhfRZej8dL6xZP9Xg9KDpCQ7MbGqrb31rKHoJCslmpbfesjJyn
 ob5SXA3kxG0JM5xba/uwwJPZ9qrZgqNMCmaVR40W4juyr5h2Sht15QrLdYdV2bU=
X-Gm-Gg: ASbGncsq386pE+cuXqlfJLAOMNRJv5tsinG5drKz841n1rAx0duUUTLO3Qqnvz9jls1
 1EuaKC1P7Clglfv7ktS6iX67iVq6J3k+LaUuNMdEcMwXRklTDDxoquzi1/e5cx4bs1pK4JZXRb8
 RhJHsQwVM3Rmhh1wqq7OPnU6CCLWnIQHrgum6t5ExaZCGaw8wbnyFoBqhVvU+p5xMrjOWokYRVJ
 YwxZx8BtBp+D8m7hUOPrZwy9bXegYUUyAAzlYfZ/J2JdDDp4nN1duft2fftIQlBBw8l/sPKB41K
 NtEA5ADR4/A9eh1jpY4MvLg=
X-Google-Smtp-Source: AGHT+IG5zZhu5Ss0FW5rbeibBdDU9MUvXP3W/SI0QzmnAFlCf7NHAStS9JO8dUk9bNQzvuGgeT/XtQ==
X-Received: by 2002:a17:902:cec1:b0:21f:8c08:94d2 with SMTP id
 d9443c01a7336-2219ff2626fmr203067995ad.8.1740428836213; 
 Mon, 24 Feb 2025 12:27:16 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a00abb5sm254095ad.74.2025.02.24.12.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 12:27:15 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, joaomarcos.costa@bootlin.com
Cc: thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, 
 jonathanbaror@gmail.com
In-Reply-To: <20250219101633.1655153-1-joaomarcos.costa@bootlin.com>
References: <20250219101633.1655153-1-joaomarcos.costa@bootlin.com>
Subject: Re: [PATCH] fs/squashfs: fix potential integer overflows
Message-Id: <174042883506.2441145.4810095392743542247.b4-ty@konsulko.com>
Date: Mon, 24 Feb 2025 14:27:15 -0600
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

On Wed, 19 Feb 2025 11:16:33 +0100, joaomarcos.costa@bootlin.com wrote:

> The length of buffers used to read inode tables, directory tables, and
> reading a file are calculated as: number of blocks * block size, and
> such plain multiplication is prone to overflowing (thus unsafe).
> 
> Replace it by __builtin_mul_overflow, i.e. safe math.
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


