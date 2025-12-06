Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BAED3B7D1
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 14:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF78283A03;
	Sat,  6 Dec 2025 15:11:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jbUHLAGJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E50783A97; Sat,  6 Dec 2025 15:11:06 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DECC683A03
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 15:10:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c52fa75cd3so2970441a34.3
 for <u-boot@lists.denx.de>; Sat, 06 Dec 2025 06:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765030251; x=1765635051; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09S4MvYNkLeQL3OFJiojpCoalnREOFG4Vmor4hUC4aA=;
 b=jbUHLAGJJVM/K0Sma9mOlZ6W2bM+hVvXBwoSz8W7vyHD8RX4prOnv9jbGLk38LJY55
 yZpEz1BUXJ/oXlICbElD+ydk77xUwPIK4VaBj7Co5TKmkq53NrTYkSmAE7dpcABklYj4
 lr4Ov5zvRrefCRtFHAFOXYCNwRE7buKERgwq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765030251; x=1765635051;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=09S4MvYNkLeQL3OFJiojpCoalnREOFG4Vmor4hUC4aA=;
 b=tbK72jTd+JWvvJJq5n/SAVDFg88sWjdpdGcKr9VSbBDZpUBOzcpDaKSwRNuoHqw7P4
 P6LW+Kz7N4xnUcYSNvu9Fg5EygWM8QYI74DTGXZ/hXCQGbsc7e2HsmYbfWohcqHkSmkC
 YKst87dCYuABIlSXHOgnpY2KcOJ2B39Z1/JTV+VssH7rnNt5fdscvzG1il9Vk/eNJf9U
 6w6KrXME/o5Y72i70reAYP+lUElbhMQBDdk7lisYHlsm6SkxBGwq6jMWfY/vLCOpe7su
 WIWFeO7YsI591W3fyFfiDQLXZnqtyLXnRKtCPDz26mTnFSoEuH3uij49zIzKThXgMOz0
 MySg==
X-Gm-Message-State: AOJu0YxFPy7zdAeKIZDKhQiNojzV5TtzzCHpf14E5I7JTwaVmWsyitFo
 O8U7exkFms3RxEGE9EZVHkCwhx1KeFze2oVopfM8obIJbGbmobFOIH7ozYRMMakP8iM=
X-Gm-Gg: ASbGncvc/qpqI+OKyg1Eyp+9qUKlnvsqlitA15n9GtWHtLYf+T3FrlmSvboidTpuxml
 j/b4gYP/tBPXazyYreLhAmzL7tdWB2XuswF1PtNDtCKUwypbRPfn237yaV3F+yB4er+8Quk+Frh
 Dy1zhxHXNSP27UisE2zaM3caPLeG2Bp0lkGR87XcHZT71fI8VNawvICGHb0HUw5Csf1GFU6E2ro
 mTp5W1y2T0jG+oXQhoRiptB1tkb/2ovnOiXUCKvS3TIKzVlhG3i+5flcdHchFTW4hTJq/ODE8xv
 AEpj2hMWof1DDbbqHKuXi4GcNoSoNZofPaCswmuI5MiCGbaYXGv+7V50I676uDcsKdO0MCg/JaF
 wxufdj4JBDx1vif0xcyr4eYn4DZOtweTYahKtvgKnsjI2WEhr1dZLnjXvHrgXFweVVH8Ah+um5l
 lzA42X+9JPWs21whm7ZHzJmYDw5ryWcnTsx+C6Kydlex8Yv6dq
X-Google-Smtp-Source: AGHT+IG8VpQmyasme9C7dwyLOoQmXNcw0lWlFS8k0wq0n/LjauSAVjK97Wwyr6LqpShFTMCoMiKXwQ==
X-Received: by 2002:a05:6808:1514:b0:450:1de0:87e9 with SMTP id
 5614622812f47-4539ded85ffmr1069376b6e.13.1765030251585; 
 Sat, 06 Dec 2025 06:10:51 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acd733bsm6078499a34.26.2025.12.06.06.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 06:10:50 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>
In-Reply-To: <20250926153140.3680901-1-trini@konsulko.com>
References: <20250926153140.3680901-1-trini@konsulko.com>
Subject: Re: [PATCH] mtd: Tighten some driver dependencies
Message-Id: <176503025037.2523567.17827288427264616144.b4-ty@konsulko.com>
Date: Sat, 06 Dec 2025 08:10:50 -0600
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

On Fri, 26 Sep 2025 09:31:40 -0600, Tom Rini wrote:

> The ALTERA_QSPI driver conflicts with the regular FLASH_CFI_DRIVER as
> both implement the same high level functionality and so use the same
> global namespace. In a similar fashion, all NAND drivers are mutually
> exclusive due to namespace collisions. For the remaining drivers which
> did not already have some architecture specific dependency, add them.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] mtd: Tighten some driver dependencies
      commit: 272e356b179fc68335298a6088f698bf034a4f55
-- 
Tom


