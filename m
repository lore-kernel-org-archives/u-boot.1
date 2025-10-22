Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E5BCCD1BB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 17:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11963835FD;
	Wed, 22 Oct 2025 19:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KnqRQDyA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85AC38357F; Wed, 22 Oct 2025 19:26:22 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2E308334F
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 19:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4491510f005so540119b6e.2
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 10:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761153978; x=1761758778; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AY2TeoPfYpkE1b43n9JqO1PCCj/fBmZnuXjgPlED0ck=;
 b=KnqRQDyAHvECYhZG+os0qGnHVSRU2SCaWvUzI10XHfAEU7R1076SD10bZJveFyOex5
 S/FDTTS3zUFV/vJKgl8Dmdmsn9aOG2Ffz2FWrjVe0OInQ0KibvMHd5KZ0hg1RDgp9Hiz
 gwd44iPt9YwVOLLyIlqZl3Vx2L5RmhIL2bpOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761153978; x=1761758778;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AY2TeoPfYpkE1b43n9JqO1PCCj/fBmZnuXjgPlED0ck=;
 b=nVZrs9Kvjp2s7AeYxxT7FlJwkKDbum+ZhO0L5JoVDTfwd85+Pz2Ydc664zV/q9KSTv
 Q0tvidkFpWkqga8R8iU5erdFPp7LQc8K04T8dovmWr//yFZ8vgrg6GXDt3IHDs4chRI6
 OPjNNcSf/taf1A0tnhRB6kVIPeMrWRSnFnoNzews6B+tdKEBF2y3e1ajANh2WBKe4Z0f
 lIT554dvSoJbElfGEmeZeRWCbc2pFcZETdYyeFHjyY7I643EKmkh1jk4ZmSd414psKYP
 h2YT59HPZHqLfWnzfWduw6hx5P+NW/FJHnBeqvoZnl3bc6MqjCOtx4GpWRw5Uovzf/zm
 QB4g==
X-Gm-Message-State: AOJu0Yy4k9CI5bdrI8yMh0cQBv2Xx6yRE4O0CL8WvvnW9BwogstXurNE
 xbah1bdSJpfZiECGaAPkNqUR640IiOVY+kv00DYMAL6Dg630x0WkXKhHOsVlWGQSRthXolz5STY
 Rm5IsHATv/g==
X-Gm-Gg: ASbGncvR6aDaX8PLycWrc8RcoRUZg74JneDR1BfN6DqMMbwxV8h8/GVCINKICHHbmq4
 zICrqfrm/S4fWwSeIDpr7EOg3Kv8PqVpa8CXJCaY5o3VwrYDk9afhT7bEIqmK32rt32TdJGSQsL
 a4yvuljmsBU7Mz4jJrdq66swAuWTBfMmPT62Jxsc7KKQ/1Z9ftEogAu01O4G+lIwz3tpupZfZm/
 mzo6NbvmL6k2Cd4h+ADBfHI0d9Q9UKh1d2rAB6dQ18Kdv/eur6is9hq3f4eBFOh7WZbIhTXCIc0
 VcBRoNbnBYlRuwNG8kNlCTwEx01cWESJAwA7Uu0PEKnN9XW4lZS0FtxnJc2aANWCuphbwzoOTRv
 +xldf/gldIZUCVvSDZ1+DS9oZ0E3kOHyGrdF8GggMa2rCi3Le+0bzg8iDOjUelLh/VfrzGwUL+y
 BBLMWVfZaeN9gY4a/SgHfiKW0AL7jT+FIeCTVyZWezpZ9AxV0L
X-Google-Smtp-Source: AGHT+IHULFp55/xtXMqv/L2MxRvrL6u8XzYy2njA9h2Z6rtXAEzNZhKIERho2DydrAOcqo9zt69Ufg==
X-Received: by 2002:a05:6808:1a17:b0:441:8f74:f47 with SMTP id
 5614622812f47-443a31ba620mr10546502b6e.65.1761153978475; 
 Wed, 22 Oct 2025 10:26:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-443df20786fsm3453493b6e.18.2025.10.22.10.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 10:26:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <308fa89f-6e2c-4804-b806-71fd8bfbedda@linaro.org>
References: <308fa89f-6e2c-4804-b806-71fd8bfbedda@linaro.org>
Subject: Re: Please pull net-20251022
Message-Id: <176115397780.1634412.10172891892638200658.b4-ty@konsulko.com>
Date: Wed, 22 Oct 2025 11:26:17 -0600
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

On Wed, 22 Oct 2025 15:47:06 +0200, Jerome Forissier wrote:

> The following changes since commit 813a0df27a8af587bd25a6a4719f68066b370091:
> 
>   env: Invert gd->env_valid for env_mmc_save (2025-10-21 13:18:46 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20251022
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


