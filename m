Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACDAC77B7C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 23:52:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF41682E26;
	Thu, 26 Jun 2025 01:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Dk4yJo/v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C68D782E05; Thu, 26 Jun 2025 01:52:12 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF7FD82CFA
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 01:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6116d9bb6ecso263964eaf.3
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 16:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750895529; x=1751500329; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ivs41bKVxGm/ryt3E5RncTcJhjJkNXIRynM7nfuSm9g=;
 b=Dk4yJo/vL3rkphSKeLcxZkfScTTY193/zPLJ6z3mJDQexVFVSn9NvWVei/TlBLKzx2
 wQTx7IGzKyuwdhWDjO7ACSR7a9P12kPvmM9JA9ijRlJ9cNEWoPqUbpNj1tyWur2LK4Ql
 kYktulaZ0BRYeD7WGn17UFVORoJoxDtV6ei/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750895529; x=1751500329;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ivs41bKVxGm/ryt3E5RncTcJhjJkNXIRynM7nfuSm9g=;
 b=Ol8ycUWd1aDPjQ9sCknIwRORZqJ1T5QqDIIDyM0YepTo2pQd3ywB4Nj+l0PypFUi/C
 UUKRw+M1AsnRR6G3feny/CMR2o18zO1bmR3RX0HFAIhaPstmqFragKRXfoyWq5W8Khx8
 MO+15VdXgu0auuix369SFJquXRDkRRRvyJYNrp4fn/K91bLGejfFIQdwwN+QJFIpa2LI
 snum//xik5c3p8fpvHuNhyGQwJM7unirhgyNpmfar4p4rOjpbABQ8b1aTs0bYJnGxax2
 nACfZPa72t0xDHuLi8TekS8tdCIEM/aRI3O8xyVpNAkrT04AJnRwjOH1MQuZYA303BJG
 NlvA==
X-Gm-Message-State: AOJu0Yz8hvJsGr7tSou4wiPwgc9XUD3HDtcVG1KoCg/3L1k50kj/VlwR
 ia7pgr/ngNOnxZOoOef09rAK8j7giPQMvVufiiJyQ/nq2YEZC4QSlTE8T2NevQllJ/A=
X-Gm-Gg: ASbGncuJvQtpXDgLOUPuyT6sGv3AAEOPXdrY4P4h2HcYch7BQoY3/lQry4mT/9h+dF5
 PZqP4DXuxy17Sk7FrS/FkQD3a+qjUGZR/Kolck8BhWRe1rZb7ZudYtzxOzu35JiIKKArPaufFa3
 h9m3QWKT5KnomsQ+3fQx3HGNDkfhVCqzf18qf6tdV8QqNthAeS2C/R/8/AvXuo1Y3pZnSemoIKh
 yadv9BgQZN1pe5VjNGZ9KTzTpvbH1rLJ6Czi84jUCHcoLiTiqnfgn25qYY5PaY3thSELYKSuIKO
 TI7rt4tW1TNaEraIZbpooEqsGgcs/apBLdlbala/hXkX3eJUUeWiAcXZkSFCoBJr4IVCMP46Df0
 +u/DD4TPsLu2moKbjfs0mKQ==
X-Google-Smtp-Source: AGHT+IFGcPUfx1wv5ltYhK6hn+Nm3rhv6re0VIjOa+dWtnrBsaPPTE1t52gZZkENMmZOs37VK2QPTA==
X-Received: by 2002:a05:6820:1998:b0:611:9bc2:7cbd with SMTP id
 006d021491bc7-6119d6a582emr4239727eaf.1.1750895529368; 
 Wed, 25 Jun 2025 16:52:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6115b6b3052sm1751134eaf.10.2025.06.25.16.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 16:52:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <20250603045023.29630-2-mibodhi@gmail.com>
References: <20250603045023.29630-1-mibodhi@gmail.com>
 <20250603045023.29630-2-mibodhi@gmail.com>
Subject: Re: [PATCH 1/1] fs: ext4fs: Fix: Data abort in ext4fs_log_gdt()
Message-Id: <175089552796.1525333.4162371059173145728.b4-ty@konsulko.com>
Date: Wed, 25 Jun 2025 17:52:07 -0600
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

On Mon, 02 Jun 2025 21:50:22 -0700, Tony Dinh wrote:

> Return ENOMEM in ext4fs_log_gdt when number of blocks per gdt is more than
> number of allocated journal entries.
> 
> 

Applied to u-boot/next, thanks!

[1/1] fs: ext4fs: Fix: Data abort in ext4fs_log_gdt()
      commit: 29cb98d515f96c2330455af4b8cace0220abd00c
-- 
Tom


