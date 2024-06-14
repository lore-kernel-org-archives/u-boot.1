Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD31CC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 14:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C9BC88A16;
	Fri, 14 Jun 2024 16:54:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oO0AVFmz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7887A88A09; Fri, 14 Jun 2024 16:54:29 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9C4188A08
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 16:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3c9c36db8eeso1156332b6e.0
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 07:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718376865; x=1718981665; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JOvk+rCL3duUF+GuXz0n2lr2A2jx4H69HbzrmSCwhPU=;
 b=oO0AVFmzkn7PflkNr6wudxcZRUI4GBgNej0RYPFoJ4DMa5gvtzpcqy3LZxCPVjnKsi
 ngQzdMJUMGq6+RcGF0dpyWRq2jSEv6aOZwfFgJxCrWi/Yps9RWoGbZyqB97Cvtk6hS/6
 veqoA4rwWjULqEko5mir+DCxv2Ykd/+Nsn6Hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718376865; x=1718981665;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JOvk+rCL3duUF+GuXz0n2lr2A2jx4H69HbzrmSCwhPU=;
 b=pq3meajowZzVtCuywJvHrRX4y4O4e1XTg1tLraUP+bhOsSteqSXA6jhRMASaW1d4Zh
 0/w084t5oH7eJrkggZJe2MjVwc7zM0auVuygH3nngeXV44yQ1wLsHU5l6u471lX9wx3f
 V/1nFA8Ed0U/ExiSeCAej6+dUtH7EKsodLEnmSIi7+DGgUunpt1uVQFj1zguphPihcXO
 10438vgHGBMp1tYaPjuObgWMhHd5owg2nOH3k5ghn9cOlyYrKvA5CRVS3Lq3ggL6IqNJ
 ohKoTwjaOv+IyXEDc9zf1u7I/vV2AbCXqykCWBCWsY7Ai9vZCoVhdHpw8RGU1sHZ84jU
 73Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJkmz+YAsVpx3gLv0+9eLiMlTEU/+gfpUUUGvW9us5VypLItpr6DwlfZP2YSoqP92p65qmWdvnDVC7mp2RdRuzekRGxw==
X-Gm-Message-State: AOJu0YxqhK1E0KRjUBulzpIrQJL54Xf7yVFtxrd3LrxiRNqqw3YIDi3c
 0q5ui0CAFY5lxS3CkpYWVGfnr98gU0N1KYbW5AlLLtYJMBfrMXvGEd2Zyx81Q+k=
X-Google-Smtp-Source: AGHT+IGJgSnQLBtsxBKoRpxbJaUDZy3oXVDYEHp9CBj3GWIkeokhT7UChLJOjFXKGRePcbu7WvD9hA==
X-Received: by 2002:a05:6870:164b:b0:24f:dc76:f6d2 with SMTP id
 586e51a60fabf-25842b79b66mr3021247fac.45.1718376864590; 
 Fri, 14 Jun 2024 07:54:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567aa2fbe8sm986898fac.28.2024.06.14.07.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 07:54:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: c-shilwant@ti.com, afd@ti.com, kamlesh@ti.com, m-chawdhry@ti.com, 
 nm@ti.com, bb@ti.com, u-boot@lists.denx.de, sjg@chromium.org, 
 u-kumar1@ti.com
In-Reply-To: <20240529074849.363281-1-n-francis@ti.com>
References: <20240529074849.363281-1-n-francis@ti.com>
Subject: Re: [PATCH] arm: dts: k3-*-binman: Make default DM file optional
Message-Id: <171837686375.2655592.15890751839507989773.b4-ty@konsulko.com>
Date: Fri, 14 Jun 2024 08:54:23 -0600
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

On Wed, 29 May 2024 13:18:49 +0530, Neha Malcom Francis wrote:

> The default DM firmware path is non-optional as of now. Make it
> optional so that users that choose to provide DM via TI_DM argument
> instead of BINMAN_INDIRS can do so without build errors.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


