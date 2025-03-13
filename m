Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22F1C35FF1
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 22:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3507B81A0E;
	Thu, 13 Mar 2025 23:44:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cTJIATp/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 696718198A; Thu, 13 Mar 2025 23:44:22 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E283C8168B
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 23:44:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7c0a159ded2so159831385a.0
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 15:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741905859; x=1742510659; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wsm3paYy/SMJ18WOJp0p2KJj5ARAGAIMAoX5CwKjwQA=;
 b=cTJIATp/IgjLID4sYTHORjwvLAdP4FbYHtYbTLLzgT3iB1T7iRiGHX9WOhdpkF8Vw4
 aiIyuKsy6c9Pv2b5OryspUuljyST9jx/C2AAtMofEF34iflGpiRRJ+c91cFdjkcE0V4E
 6OO1gfiW5wJq3C+ADytz7r09NlxF2PhII/bpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741905859; x=1742510659;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wsm3paYy/SMJ18WOJp0p2KJj5ARAGAIMAoX5CwKjwQA=;
 b=Zh0dYDhAD/o6vzGCdvviOPzjvaTdfzPh6xAzTW4QnRUFIjnKI5RFPO886crpHVD0dI
 9+rLydJAylIt6KhIqo5K7MfIkIM5B3LUSa0kCCHj7/4t+U5fNPz300l5rk0YzXZY5OXv
 qxQGWtjvzzc31Fo1PpBoFHb/i9crDj0Ae0sQmqvFaVNMQ4Fl3hzL/JQTmDJf5s1HUT+4
 A4g5R1X0MLSX76PJi6iM7EqP3bWYFqDe2gdoJ4C1Pe016WfaNWRz2F6ILDf3TrQMKpXi
 LrR1HyFEU6qAfPG6JynnSpqS0QNw09iUZKS+x5xf1y4Xu7o0nep6ACUoopROFJoRmy0m
 numg==
X-Gm-Message-State: AOJu0Yy4mjFmfeOTu9KtEs8Dq6Lo7b6PHZLkNux30QEryZbiu6YLGPaZ
 Ru10hiFrPjC2+9EDoG+5AxsFEEQC6xxwV/np61N4umd9bAw20NYTH3ApiFuEIE0+wwcekSKZP1p
 M
X-Gm-Gg: ASbGncssjq5oMu9GnuPphfYmXnSlsNPTHlC5UM4WAac97ywx+Y6jEG3vAJ+6eRjDwOT
 J7OOgOO2meyJzmU/tFgHLGdPE4TnaQp44pbkMQdllKT+yTSPvIo6G8fz9eVcSdXeTfWC88Hmvci
 9J/hLemISvMGBnpH7jORq++WoheoXbPCkSOL7zet25+Xy6Q+CYqoZh0Dx/sjTO2AXyDvySxavoJ
 Zv6ZQmdRMnt5PfJxSp8No1akqtP/1+2nppoNovMy8fPAvj4TbfE5Q+JM1+kXr9iAHRyEQm0fmXZ
 7Yq9rvX45lE+WaiuyqZG1kj82ZgM1T8QkDrAPu3nvXxG
X-Google-Smtp-Source: AGHT+IHDBSsH3xK5XyRqY9tlYqORK2F2RiyxE8dZ3zkTjQ6caWs/8xpivRGJo80QD6XHxZT4rJTv1A==
X-Received: by 2002:a05:620a:40d0:b0:7c3:d7ef:f7f5 with SMTP id
 af79cd13be357-7c57c7e22c9mr13461185a.18.1741905858899; 
 Thu, 13 Mar 2025 15:44:18 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c98225sm154508585a.49.2025.03.13.15.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 15:44:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250227-reserved-memory-v1-1-638a6328884c@ti.com>
References: <20250227-reserved-memory-v1-1-638a6328884c@ti.com>
Subject: Re: [PATCH] mach-k3: common_fdt: create a reserved memory node
Message-Id: <174190585699.2150240.2845430924794022918.b4-ty@konsulko.com>
Date: Thu, 13 Mar 2025 16:44:16 -0600
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

On Thu, 27 Feb 2025 11:14:41 -0600, Bryan Brattlof wrote:

> Some device trees may not have a reserved-memory node. Rather than
> exiting early we should create a new reserved-memory node along with
> the memory carveout for the firmware we (U-Boot) have placed.
> 
> 

Applied to u-boot/next, thanks!

[1/1] mach-k3: common_fdt: create a reserved memory node
      commit: 096aa229a9e5909e40865454208a6a009dc0c02b
-- 
Tom


