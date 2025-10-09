Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDECCCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE28184308;
	Thu,  9 Oct 2025 16:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h4UVXHzk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 332B784307; Thu,  9 Oct 2025 16:18:53 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14E7D840D5
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7b4f7a855baso742127a34.3
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760019530; x=1760624330; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yOPhijlZe2XSt7NYMKmDJtALWoZsqs6yFMxHZw1Ndqk=;
 b=h4UVXHzkPKHRgHKAT6WBj6+yCLitUOUUheH3eAV+aJEEYfC6IpB14CLcGkiT02Rbod
 49Dz+SztO3fC2YA2XSXxqOhLrPu6wXFB+2+F0UwTrYiSHtVgEq9dMiY4yH/OS5a+131W
 enVUYtexcBGDdxPc0njiLpn6CMeT1swK0U6l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760019530; x=1760624330;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yOPhijlZe2XSt7NYMKmDJtALWoZsqs6yFMxHZw1Ndqk=;
 b=J7CELUp84ulV+jbuK4y/0tTQJl0QsoypXCjCB40ugB0nKXJM833FH3FGLS0MXcc8Kq
 uW/60kcyRM0gahmg91GYGLUNJFzY8diYpdvPoWkl53Clzk0kc0qlL8fjWlDzb9bMGTIM
 L85KbUspYMLaU+hXSd51F6a/ED6YoT0SWWtRiHhlcBBavbk/XNlaz8faBs3GOWif4NLO
 gXS23085OMXZeS61RPl0aPk5PdOK1/E/Th/0nknZxi/REWRuZNOe4yU0pbbM8coDYBFh
 vSqzVWSlxPUx/4+7nF0vxK+Jz4AEtylGkuwcM+FK+15sc+ohZzNIt+KbFxaJa+IiIhOP
 xa2Q==
X-Gm-Message-State: AOJu0Yx7IoBNuCCon+RfPVtgCkYWqjqFr0wvO9Vw0V4WRDrWBUt/T0k1
 c8lvmKmL8uwcld+R3C2Y4+mi3pnAK4SgNCyVwO8KcsIobXKYmBBtLJJNhGo+cS3cMyo=
X-Gm-Gg: ASbGnctl66KVA/cRh0vbuCcUdztmAgFh3r+uh4lyRt4h7JvPA4J5Qdr0cB/l47aqluc
 YA1Ciw/3hP9FUAbfFlaQgnNbN+4KsmttmchM8EJiiF35BmymNEYLdUH6CLmusNiOo7/mvDlhuPU
 qBo8L6LWbnMQAcvP0WmV6Rkem2Xc4ARXk2bvHk/dlxvOcCd6Bbk6DhswABc8QEduNPlTW5iMO8C
 78n5UYNLHXD9JBTH6x7w974w1LIQwfKHPLh5cGRUSwk1K4ed2fBZ3fQoLsWwUu8IzycuAX3Vzjr
 ntI/B/tC5M3ch/tg5kYXDfl318Jy1cd7IlXpn5QdxG0jJr7vmGhdn/Imj9G2t7TnTbhFXvgCqET
 3ELKxBvM3u76ffBz53b1BXMDEDXyoeuswql62fbs4fqWxqZ10emeBcSgT+3ZVuVwZMGhXk0IOAa
 JtdEYqF50z
X-Google-Smtp-Source: AGHT+IEtLjCl+gbSx3n7sbuMXiVq/R3+rFMKZLYgOmjdNTZ36EFa9eattR7/V7Fb5qrx8wn44pGWUg==
X-Received: by 2002:a05:6830:6c09:b0:7b5:6246:833 with SMTP id
 46e09a7af769-7c0df69ecadmr3753695a34.3.1760019529702; 
 Thu, 09 Oct 2025 07:18:49 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0e333b875sm1221258a34.17.2025.10.09.07.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 07:18:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, praneeth@ti.com, nm@ti.com, 
 Paresh Bhagat <p-bhagat@ti.com>
Cc: u-boot@lists.denx.de, bb@ti.com, khasim@ti.com, v-singh1@ti.com, 
 afd@ti.com, anshuld@ti.com
In-Reply-To: <20250923032801.569032-1-p-bhagat@ti.com>
References: <20250923032801.569032-1-p-bhagat@ti.com>
Subject: Re: [RFC PATCH v4 0/1] Add initial support for AM62D2-EVM
Message-Id: <176001952854.3159859.18054160716232724210.b4-ty@konsulko.com>
Date: Thu, 09 Oct 2025 08:18:48 -0600
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

On Tue, 23 Sep 2025 08:58:00 +0530, Paresh Bhagat wrote:

> The AM62D2 SoC, part of the K3 architecture, is built for high-performance
> DSP tasks in automotive audio, pro audio, radar, sonar, and medical
> imaging. It features up to four Cortex-A53 cores (1.4GHz), two Cortex-R5F
> cores, and a C7x DSP with 2 TOPS MMA. Key interfaces include multi-channel
> McASP audio, TSN-capable Gigabit Ethernet, and a range of peripherals
> (UART, SPI, I2C, CAN, USB, eMMC/SD, OSPI, CSI). It supports LPDDR4/DDR4,
> secure boot with hardware security, and low-power modes with
> CAN/GPIO/UART wakeup.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Add initial support for AM62D2-EVM
      commit: 14dfa6b861876275e0c2015a1013bf3bdd17a1d7
-- 
Tom


