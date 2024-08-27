Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81763C54744
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 23:23:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B35188A74;
	Wed, 28 Aug 2024 01:23:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lIelsQhE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B3BC8875C; Wed, 28 Aug 2024 01:22:56 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06B6C88A74
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 01:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6bf89e59ff8so32334726d6.0
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 16:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724800973; x=1725405773; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TKnjqBnFBKlxD29sdgit+h+1UnlezBL45dIpVOGzVBY=;
 b=lIelsQhE+DXsbs45LwJAt0ImifBvngss7QiWfxKPDG2CqMbRCi15G4K/99tU4t67A8
 oaVdR16JmZLSjELGBkNUWZofFfS1K4Ir7DkH0LZR7TX74pKhpqb5R5rvlJ2mLnXjrMLv
 9hoyviHfOaafD7WPtme897MnLF4cxPJr7cVzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724800973; x=1725405773;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TKnjqBnFBKlxD29sdgit+h+1UnlezBL45dIpVOGzVBY=;
 b=AgZTeYTb/TnFmqOMHiYEzRJKC2Llb510snZKQMY0VoFEplhp+lkV6x5pagbc3yzpQ5
 qy5B4bn+ZF4JYfzlC9gmBMU17cheWEXwFWFSFa39m5ysCnunmNDyvw57gsF7/9jIoY1O
 sVkD0g8R7j4NzlmRBDfqcQsmNJ5VieHxJM+Qf142Kfv+AAxRvVFZJM7Y20pnVvss4qZr
 Pv+Fdg+Z5kRhh9Q0oZmKSXEa3YnAydNZ4X2LPDsHsWyltXLK3lwkgywHKb/znBJSsj0D
 KKPWXMp58D7xaYIm1Fed5IU4azk7BLugF3qdad+bUOmM/bspNXmVGa836pGoRncS/eCg
 bB7w==
X-Gm-Message-State: AOJu0YzJE6bihbOfBP625DBzDJcY/aGc/AkFz5PWLlkyqVxXfXqkxUy5
 QbkWxIlZpDE/2kZV/eRWEoq1kC7v/MKsWX9b8YjOrnOvwqG/rWTdPZwE8PJtEE0=
X-Google-Smtp-Source: AGHT+IEESQi+y4KacWynzGP2sfK2Q+gQRSEevlej+M+w8vOoqffE7By0b/T7CXUBA5cIukxyg2E0JQ==
X-Received: by 2002:a05:6214:3281:b0:6c1:57a8:d251 with SMTP id
 6a1803df08f44-6c16dcbd049mr183061676d6.36.1724800972794; 
 Tue, 27 Aug 2024 16:22:52 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d494d5sm60486716d6.32.2024.08.27.16.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 16:22:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: JJLIU0@nuvoton.com, clamor95@gmail.com, marek.vasut+renesas@mailbox.org, 
 Jim Liu <jim.t90615@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240729085103.3723592-1-JJLIU0@nuvoton.com>
References: <20240729085103.3723592-1-JJLIU0@nuvoton.com>
Subject: Re: [PATCH v1] gpio: npcm: Add SGPIO support for Nuvoton NPCM SoCs
Message-Id: <172480097154.2972894.17248327349402185860.b4-ty@konsulko.com>
Date: Tue, 27 Aug 2024 17:22:51 -0600
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

On Mon, 29 Jul 2024 16:51:03 +0800, Jim Liu wrote:

> Add Nuvoton BMC NPCM7xx/NPCM8xx sgpio driver.
> BMC can use this driver to increase 64 GPI pins and 64 GPO pins to use.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


