Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3F3C71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 22:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16CCC82C8D;
	Fri, 13 Jun 2025 00:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Hzku5oIk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CCF882C30; Fri, 13 Jun 2025 00:15:27 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5857482BD9
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 00:15:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-735ac221670so781980a34.0
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 15:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749766524; x=1750371324; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cKS0kHsgvre+vdGZWQex292k14mAYFQy6WVeYItz9Mo=;
 b=Hzku5oIkfJG5yqTisbgNepVpTCRonxwIEBxYXyowqq4WqkE/KuEWAVG1CLCYeE+N9h
 0mPGIlsKCfkYgxOlVviZqUODritZ63scdp0HS7XDNZsthcskNtnQykIHlAc2t550AKmz
 pjnc1ZaqqW/lbQ6SV+EJ2Zm2SWRStnFDCFU98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749766524; x=1750371324;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cKS0kHsgvre+vdGZWQex292k14mAYFQy6WVeYItz9Mo=;
 b=w0f0rTU62wgHpSLsH5plcwqsVDNYwQ92SkxB2aTMLsqYIRidcWKWekyxPEigeFeYSu
 Mx8hXDeVeLle/fV9++eX3DYCXzqBla3CW1WuOjSqHiYALVZulNpBQKbW5LS0fDf0mse7
 dVY9sKPU2lf175mHSmGZx6iWbDHgUngetP7bwWjVhsd3i56rUchn2D5dXOHlzEnfQ2nt
 mlMawvWdCxytBnsqhDc7Hj5acH0xC64ZeV+7/QuFpscy40x6ET1PBg4y3A/TLf7uvEHi
 +6Qyc/w7zk6wuoEjUXwYILhNgIwL2wHAmHWMwWe0eti5bGHyDv+3tneUFgC+pLxpC/gp
 Unkg==
X-Gm-Message-State: AOJu0YypBXdsHdsOJPhdOclmXD+3xbVJGJRlWxYhSLldtQCK2Ces3kTM
 MUkMHjvC2QPf7JG4fD+JXQIMypKY+O99PZlOddtA9yuwmgTbXGeu6L4y7vVpaRXzHiE=
X-Gm-Gg: ASbGncvkFntlRz/Rlw9j5hyDMmlPh78NfZXD9rAygJVbl2PBopHogrMCmda4dAC9q7B
 VDB9ji40posk50ifk9ntSW/SFVRPBFOaRupGwIz7qHncKYo+qEu3LMGSI5OEHbgj3I9LALbF4gu
 ke7p0hgEySXQ/d5uD1wVvjsuSLEI5XFMbxDB1KAc0Gt71LKVzAZ5PMSPXCENRWLUtU/Wm04SJ+E
 YZ0uR6lxm6AGclopevYCRpuxFlAW+PHZ8N5lyfBTCx88E6Ja9QY/8N38jUQA7CFe7qVW09y2DVK
 I1LRHER/bu74aeSg4XTdJq0rBM8LBGM3ZZgLHJU0rNZw/5WbKLtZcEkFrcje2RAc7ByXDKh0D/V
 48WWI5POUb8Z7/yBRHKvCwg==
X-Google-Smtp-Source: AGHT+IGDT5G29D1MElE9IA9uRVbdSHGP2bR+J/TLBfkycTxVP9aR0TW0aHpwy2EMP1snsHtNScV4XQ==
X-Received: by 2002:a05:6830:2811:b0:72b:80a3:e65e with SMTP id
 46e09a7af769-73a27a47443mr184382a34.8.1749766524111; 
 Thu, 12 Jun 2025 15:15:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a283e3198sm7145a34.10.2025.06.12.15.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 15:15:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250515-bl1-support-v1-1-fd4365542877@ti.com>
References: <20250515-bl1-support-v1-1-fd4365542877@ti.com>
Subject: Re: [PATCH] binman: add atf-bl1 to etypes
Message-Id: <174976652319.365589.1535985507712844578.b4-ty@konsulko.com>
Date: Thu, 12 Jun 2025 16:15:23 -0600
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

On Thu, 15 May 2025 10:16:19 -0500, Bryan Brattlof wrote:

> Some SoCs require a Trusted Firmware-A (TF-A) AP Trusted ROM (BL1) to
> initialize the SoC before U-Boot can run properly. Add an atf-bl1 etype
> so we can properly package BL1 into a final binary
> 
> 

Applied to u-boot/next, thanks!

[1/1] binman: add atf-bl1 to etypes
      commit: 52c0290526ce58d55099deb4a1a52bac40a3b0a0
-- 
Tom


