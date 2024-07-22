Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7BEC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 19:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF0E7884B2;
	Mon, 22 Jul 2024 21:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H1lHU4oy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A4A18851B; Mon, 22 Jul 2024 21:32:02 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CCE088511
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 21:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7044bda722fso2754563a34.2
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721676711; x=1722281511; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WtjTWdr0HQ6SdY4/yh6SLfFhhAp/A6NensKVUDKtc4M=;
 b=H1lHU4oy61be0Kfw8192/wVO6TWZgV/4EYc69DP8oQCMD1ROdXbDVT8Xbt6A3Pjxs6
 eSe8AOmT3gUHzOiZoB8q3EWDF+wGpgV+aXyleaqApXD3rnOvqk5TuA9joVBXkHZ484hO
 1m/iTvoJFylmKOeCJ8g0szANjytTkAvJJLzKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721676711; x=1722281511;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WtjTWdr0HQ6SdY4/yh6SLfFhhAp/A6NensKVUDKtc4M=;
 b=wMFxRaNiT7GsJNMN21jC6uMRHBLx3RhR4sG0Uyc7858DxfbPHQWO07EQ/cLJ3ItXmK
 /CBMx3pMO8Oxyw9QMhWYF7bWQmKbQGybhC++gTzmpPi+GlKVvqb7Xv6HBFA8szApQdYW
 yO6EGCDqC/Ou8/ypd/sjw/a0T0I887728RmvrLPx3FuLUkr4ptBBy1HqMlNfHotrzAH1
 CwDiQEMnQXxDu9+Rlurus963jXpM4SiYzY6xdP3BNCvcg5AvrfgcNlg/tHZK9gKqTVS6
 o6KKiPWYmPo9Y/P8FbnRGwUQOcw7zeyNZbM+pNLkTpfYvoE9tCCL96lAGuxvLgRef1lA
 WdPQ==
X-Gm-Message-State: AOJu0YzrgWT2SP5Xw1lFRW+dYtvM+AGpgDQ27W5UXQZmik0n/a5LgTCL
 Xo0A1x59yusLRUXrDP9AELOquBcqNp/OKd4yuy3fsm1IEUDLiOUGPKexgvtIwcU=
X-Google-Smtp-Source: AGHT+IGdaQA6wUt6Etf6TI7pZ3UMfPYzqm2gMtIc3TBLlNi4N2LNUALhQtWk5MvqjhIpUF3h8jUjCw==
X-Received: by 2002:a05:6830:4910:b0:703:5f86:5e68 with SMTP id
 46e09a7af769-70900880e5bmr10524295a34.3.1721676710730; 
 Mon, 22 Jul 2024 12:31:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f60d68c2sm1651550a34.36.2024.07.22.12.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 12:31:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 01/37] board: BuS: Remove duplicate newlines
Message-Id: <172167670992.1260831.12298195784383616647.b4-ty@konsulko.com>
Date: Mon, 22 Jul 2024 13:31:49 -0600
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

On Fri, 19 Jul 2024 12:48:38 +0200, Marek Vasut wrote:

> Drop all duplicate newlines. No functional change.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


