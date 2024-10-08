Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C17CEF174
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 13:44:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32C0D88E91;
	Tue,  8 Oct 2024 15:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ts+LuL/P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BB1888E7B; Tue,  8 Oct 2024 15:44:29 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 944E388DD1
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 15:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7afc67e9447so45544685a.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 06:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728395066; x=1728999866; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yiq8mF6h0oIAH8qFwZW/RGrMkt8Fh+jnkPNKcOUyjkQ=;
 b=ts+LuL/PZ2L3S2JepNPP5+CU12mE3T0gKnTfE2TE7cLDhAlaNvNUnYCPjWSOpdJ/SA
 ujnNTS1bWyp4mvQ6MlysWZx5krfj1eEZs+rzjTj+F/6KjlH3yVGc8bYCr1mXBo3Xsq/h
 KjQQvnoN5BzOVoGWZo8vXrbK9lUTCVD40DLHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728395066; x=1728999866;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yiq8mF6h0oIAH8qFwZW/RGrMkt8Fh+jnkPNKcOUyjkQ=;
 b=LkVMuJoWDg0QNoibKd0zAht10UX3LkzH8v89z/wlmm2U2QKCYHm+m3zMqANo+aAr3q
 OykpGuE80+UTyv8msgpapfM+ZRQvlT3gRSKDvmHL181CiqQyzlCqaHoeuyA9ejW9XdZ0
 k980t5F8Fj582ld4PoNXCKymOwQJkKI2GVQv9txtFTAiJ1pQKSoYUpdHZvE6/jdTsBJ4
 jXXRNzgLxxSUEJqo5Iw6Z59jwmc8VRpgN4++szr1TCeaNa7E03D8FuY/+kkwISG429pD
 xJAwqQQoqt5gJKYSjY+tRwpGGKdYQdPuuuJ6Qxu+60QIHS+iw/5eh76k/orajYg2eRd1
 g9Jw==
X-Gm-Message-State: AOJu0Yw4vrHWvu+xWoOyy2YWisYMxNyrj2Nd/dPhFYsPIXeYe5gaa9h+
 x6Fs9Cn9lJf0p26w/DBSGwIRazzCdR8yhDuVbAzhXQkUqquxXL338DGTtlP94/0=
X-Google-Smtp-Source: AGHT+IFmzJ6Fe3bfEBmTGHypCW6we6Ymke0s7eS36CX9XazKHaZTkLnqawPD+tPFYObm5N2KiXMYUw==
X-Received: by 2002:a05:620a:472a:b0:7a6:601c:c827 with SMTP id
 af79cd13be357-7afcf08a7dfmr23920885a.27.1728395066292; 
 Tue, 08 Oct 2024 06:44:26 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae7562cbf9sm354028685a.41.2024.10.08.06.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 06:44:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240804150955.3521296-1-jonas@kwiboo.se>
References: <20240804150955.3521296-1-jonas@kwiboo.se>
Subject: Re: [PATCH] serial: ns16550: Try get serial clock rate from DT
 before CLK
Message-Id: <172839506548.112860.16927790822358226002.b4-ty@konsulko.com>
Date: Tue, 08 Oct 2024 07:44:25 -0600
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

On Sun, 04 Aug 2024 15:09:52 +0000, Jonas Karlman wrote:

> Initializing a clock driver to read a known static clock rate can take
> some time at U-Boot proper pre-reloc phase.
> 
> Change to first try and read clock rate from DT to speed up boot time,
> fall back to getting the clock rate from clock driver.
> 
> This help reduce boot time by around:
> - ~35ms on a Radxa ROCK Pi 4 (RK3399)
> - ~15ms on a Radxa ZERO 3W (RK3566)
> Time that is wasted getting a static rate known at compile time.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


