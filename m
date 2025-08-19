Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD226CA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 15:25:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75CF7809A5;
	Tue, 19 Aug 2025 17:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qt0c1OEU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 172D882D88; Tue, 19 Aug 2025 17:25:29 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86A72802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 17:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-74381fdbdbeso2799272a34.2
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 08:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755617125; x=1756221925; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q8PQGbc1PXUGaVNyofGSY8799j9uX9y5kLnF8uPLgVM=;
 b=Qt0c1OEUs8uxlxx5V5SR92h/mKUsRu8L4zZzVBChfawtbi1NQNdROoLYtacIsL46gW
 G3d1AFaJ6XFvWint4RwFOwwpmWRrikBUjFZ0c2zrMMfuH0bD9JNPV+lMNNkB6Nnh+y41
 vFgyXZfIpL1pXhLy0/T1p7r6mNj2MlmW6lQM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755617125; x=1756221925;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q8PQGbc1PXUGaVNyofGSY8799j9uX9y5kLnF8uPLgVM=;
 b=bZ+hy3XlcxpkskVdyXALi3iI/wEieqUmOrnrvmkPGo/kMWq8YoOZJFpVnyw74S1WwW
 0aJNM+wyGEBxY22ZAmThMjmB/SG+aJaulrsRQhxkkyPUSG19yIvyq/RMd4Vc4sfdMY0+
 y74BmhuBzYNIurKRZrR3SL/FinN6cmfua+EqS3cjkjj6Z1Aa6r6J09cMNwaxAp4QfJvw
 lF0WdHMttCWnZtmeJMHESnE260wTjhsTihAYGu0LzqDOfdWgj2u/hu/MXoHqfpctlJQA
 2Vfwu3hgrux0B7ePKphqtfT8rQ9wttUD2cLebhj81ccwha8h5mXIoByweHyGH8G+T2up
 P+ow==
X-Gm-Message-State: AOJu0YwCb7eqgKfNL5eOcQlR6u6JshDEiHsh+OZHlfUjYbbWGILYYemr
 hiX66xWr8Kdh6Pe5glPIqC+OWkdk3yV6mWWJoOr3gs5qFD+OeNgc0/MbiFB89Vv9SOo=
X-Gm-Gg: ASbGncsxqrqkHMzCb/df3ZZvZf0dZCWEtLH+2BrhcjQyStvU/tYJlkpXy5qLuO/4XpW
 DaZJ26c32Oglee6Pd1CqMoi1UiEzBmqkJMbCKLP/N78NJiL0q7I1JSySLf9Tfrld85qEchAzNZ3
 u3Mz6Los8rgXAtosVTQhAqq0mI1AUPLka9hFJt6sVUzHPbuaPhlfdcx9jQ2CqQUjuaOBGJn9rHk
 Vw7TKF6/IoiWO4hd0PkpGF2JF5UWR2iuX4wC59rmJavHuU9jv9x9vRO2dxIZlXAeWrb1t5BxFnx
 NBtom/jFlysiQ2ofgh9KBu57q/1otNWxLlR0otyOKib5/al7V4PXD6eLWAfEgJZSBpfo4t9BseL
 VgOBVW5Oekxix02ppN2lZKVYC1t6mC8Crvlra7r59cBQzBhglh/9tR3rruiHdxHhRWQ==
X-Google-Smtp-Source: AGHT+IHyjr0Zz+LXTyF70KSbpuML+NtvPWTSOzQZPqES1UtEN0jdIAaWTTH1iiDKZYW4MnbG6N+flA==
X-Received: by 2002:a05:6830:378e:b0:727:439c:d18b with SMTP id
 46e09a7af769-744e0aa17e8mr2023209a34.15.1755617125191; 
 Tue, 19 Aug 2025 08:25:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-310abb34366sm3459731fac.23.2025.08.19.08.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 08:25:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, Jim Liu <jim.t90615@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250807053224.2169557-1-JJLIU0@nuvoton.com>
References: <20250807053224.2169557-1-JJLIU0@nuvoton.com>
Subject: Re: [PATCH v2 0/7] modify npcm7xx/8xx feature and bug fixed
Message-Id: <175561712393.3333765.5755767529907583203.b4-ty@konsulko.com>
Date: Tue, 19 Aug 2025 09:25:23 -0600
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

On Thu, 07 Aug 2025 13:32:17 +0800, Jim Liu wrote:

> modify npcm7xx/8xx feature and bug fixed
> 
> Jim Liu (4):
>   arm: dts: nuvoton: Change timer node
>   misc: npcm_host_intf: Add Arbel eSPI workaround
>   misc: npcm_host_intf: Disable pending KCS/BPC interrupts
>   configs: npcm: remove CONFIG_SYS_SKIP_UART_INIT
> 
> [...]

Applied to u-boot/next, thanks!

[1/7] arm: dts: npcm8xx: add pinmux for VCD input
      commit: 6e212f32aaf312002a1ab1f3c18925e7c053f694
[2/7] pinctrl: npcm8xx: add support for setting VCD input source
      commit: ad3a33e57742bab08a8ca1a9e34c262b6fbf0268
[3/7] i2c: npcm: fix consecutive dm_i2c_read/write error
      commit: 3c632fc090dab1838cedb525e09d049a903c37a6
[4/7] arm: dts: nuvoton: Change timer node
      commit: 59a1c2875597c234eb2cde3ba2e48880523ab92e
[5/7] misc: npcm_host_intf: Add Arbel eSPI workaround
      commit: 121927e37be0725139d5b07d08361ac266685808
[6/7] misc: npcm_host_intf: Disable pending KCS/BPC interrupts
      commit: 987880581646d5836d2485e5f7a5af6ce8600da1
[7/7] configs: npcm: remove CONFIG_SYS_SKIP_UART_INIT
      commit: 58fa3b5159cf4090ed926507d7778ebd1dc0686f
-- 
Tom


