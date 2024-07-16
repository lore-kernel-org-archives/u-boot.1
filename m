Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA439C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 23:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9050B88A1E;
	Wed, 17 Jul 2024 01:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hXJ895uH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 849BF88A1E; Wed, 17 Jul 2024 01:01:00 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BEE7887D4
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 01:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-704156d0e0dso3234231a34.1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 16:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721170857; x=1721775657; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ulHKdc0B0Vdp5MKs9GFT8MviVK86LyzteKqsRi6rz9o=;
 b=hXJ895uHk7LNIEKHn3ihwK8+h/ybZ8XljyGPO3ctL5IBysaafQ+NZ7vzcO3L16/mGt
 Rgepdm4rSjaveDoyHOvLHs1UlJkFeVYVoqMnvQ5ZEJHHVSWorbO8TZLBF8XDgLZIeekz
 X3BURXGLbgV8h0QLh8TKbdQINuUefV2SHDZ4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721170857; x=1721775657;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ulHKdc0B0Vdp5MKs9GFT8MviVK86LyzteKqsRi6rz9o=;
 b=U8NLybBztsIJdAJDtHzdmDxNoCgmA4eBADqZo7M6gn8dzi0DqKNLS55MypBPz13uLE
 TkhcCp7C07IaTnaPmARpk1NgAk8rXLJiRlgvgnj8seTVuqBkH/bpv0q/W3WifFMmU/4I
 pc/XAyIKhtqaTORFRyycmSO/mKEflZgg77C0+q3/Kd8A3hYbxulqM79C3mYAwC4q7ndH
 /29wyWfu6NKcl3/7AFjbnyor242hEQgFypYyuB37KHc1tmdWySHVDZiY5eA4nazbBWZk
 nJZpz3BhRd34ztN1mFZy6yAPq5uqRnJMQkCFp2vqOX46fjoklfRHd4oQUGBVDO4uk9cP
 9AQg==
X-Gm-Message-State: AOJu0YwSN4Ez/fKwORBoKknso2jo1qN/hJYh8TPBHbhmqCaXz5t9lfVr
 v7g4j9x9M8L9YaKGfGn4RJFgd+aiJvescWiF9uQ6ynE1h9hrCip+hIiLaiYW78w=
X-Google-Smtp-Source: AGHT+IFuPuEKUpWbWBsHRBNU9BZy0NqZ9KLBZb97PoQ5kfMhuIWr4+kc+zPhlWDTdDMsM2JdljxTkg==
X-Received: by 2002:a05:6830:440a:b0:704:7c75:b13b with SMTP id
 46e09a7af769-708d99605dbmr4638407a34.6.1721170855674; 
 Tue, 16 Jul 2024 16:00:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708c0d2fcc2sm1510063a34.77.2024.07.16.16.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 16:00:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, 
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>, 
 Nishanth Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
 Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20240702-b4-upstream-streamline-platform-v3-0-0ebd7bbd31d5@ti.com>
References: <20240702-b4-upstream-streamline-platform-v3-0-0ebd7bbd31d5@ti.com>
Subject: Re: [PATCH v3 0/4] Fix fdtfile for j722s and am62p
Message-Id: <172117085456.763145.4796228306126984599.b4-ty@konsulko.com>
Date: Tue, 16 Jul 2024 17:00:54 -0600
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

On Tue, 02 Jul 2024 10:50:00 +0530, Manorit Chawdhry wrote:

> fdtfile wasn't being populated in these boards in legacy boot using
> bootcmd_ti_mmc, migrate these platforms to ti_set_fdt_env.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


