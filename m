Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6B9C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 17:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C98358191C;
	Tue, 18 Mar 2025 18:01:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WSxtvsql";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9DA18197D; Tue, 18 Mar 2025 18:01:41 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F146E800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 18:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-30155bbbeaeso4954491a91.2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 10:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742317297; x=1742922097; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBAobsmxMfqcna8FzPZDMuAglM95YtXIYxwfZ3fd75M=;
 b=WSxtvsqlc/4CoZ2jzcETjbXsB+kabi/pMXgErknWPElkhUmnHFdmw2BhCX7wIlH2or
 lUWYZuka0ZjLjwaLNwCo58x8imWBT+s4ItoWp1vFFO0UmRAyvPVKauv7Cwaogf0bfNgO
 GRWySe/MxmTBHe8FCZ6nAXuDDD0rErLuNN+10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742317297; x=1742922097;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wBAobsmxMfqcna8FzPZDMuAglM95YtXIYxwfZ3fd75M=;
 b=vQvT+vpkEjE8Ug7enQi7ibWGSMZ8LVIUc3J+jmyWQwCGNvne3u/4x/SvuDNDeQrNCR
 If/9ihrNwnfsPe4N6gP3k9nC1+aJlxKxlbRmm7m+sjXLjloxoJiSwYdBxGhdAPHoblFf
 M0xDjnTwq+sEhp5tzhg5vVo+hg+/0wR/qPwt4P5ayxpmXRMiv9t8+hdwnaFwi/QnPsPM
 i5FlqHxhfRlZyd6bWUyBQbhbcUQrX4LRwdxf6nUBZHUsRsnJ9ju/JzHin6DEkg8Z80bB
 owjN27g9CR8Mvc8DiYEFVBIVoC9CxoW3b99tU77llb3Uil/i53HHH/T2J4cwRBa6qfZC
 px5A==
X-Gm-Message-State: AOJu0YwWYH226z4HZCwdy+wQkOWiEhqDgLQ2+iFdAfvs2NfIdue+C7nK
 ef51KB6sB21fgomYoPEFR4AH8WB57t7kEq8DKSWdWDvBkp8GQR8uouoRbUX/ltc=
X-Gm-Gg: ASbGncso1Oj9z/TPGZAPHoSPYQMxYZqzIL4XgYhLMeIhjhKvptuAQTh4WDHj8mwQ/XB
 zATr0/NBvs67irbdVmONLxYuGgzlF6qEYgc4TKwNVyTA6NOa35dJewMYZhNuEv8gGyMZhyGAc3t
 XJESAKCmqf1oSJngTz2x5EdZRMaaQatrrN7ZbH9M36TPLagkyyEIheFeeqCUX+iYE2A7p+0vM4k
 lenKvh9UNLhq+DGAtLvgFhvvN4w/as068jJP14puMph2DyE4Zp1lFMJgUfojAEIj+3CA0DDT9WD
 qC7nXpIY3zpxha7lDyTLu+VofdXxVtErLKxRIlQEXvNt
X-Google-Smtp-Source: AGHT+IE0ETzlFjaq271buGUnf4tdhU72ZrXbDgjETi7gPRzuXk1hH8jh5/b8xGPwXMpwYpKHS4oSaA==
X-Received: by 2002:a17:90b:3b46:b0:2ee:e518:c1cb with SMTP id
 98e67ed59e1d1-301a5b0410fmr4691497a91.7.1742317297323; 
 Tue, 18 Mar 2025 10:01:37 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3015363273fsm8458551a91.34.2025.03.18.10.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 10:01:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>, 
 Andrew Davis <afd@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250303191515.776188-1-afd@ti.com>
References: <20250303191515.776188-1-afd@ti.com>
Subject: Re: [PATCH] board: beagle: Add support for BeagleY-AI
Message-Id: <174231729604.1761337.12501234643634943760.b4-ty@konsulko.com>
Date: Tue, 18 Mar 2025 11:01:36 -0600
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

On Mon, 03 Mar 2025 13:15:15 -0600, Andrew Davis wrote:

> Basic board support for BeagleY-AI. Information on this
> board can be found at https://beagleboard.org/beagley-ai
> 
> 

Applied to u-boot/next, thanks!

[1/1] board: beagle: Add support for BeagleY-AI
      commit: b27c94958b976213e3f21e53943a699ffa53f16e
-- 
Tom


