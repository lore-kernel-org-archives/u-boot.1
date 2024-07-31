Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BB7C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 19:38:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41EE088A7F;
	Wed, 31 Jul 2024 21:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HLipzQXx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7155788A7F; Wed, 31 Jul 2024 21:38:46 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59C6F88644
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 21:38:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3db18842a4dso716281b6e.0
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722454723; x=1723059523; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jXdTonOVHBxSG+LassHd2Koj/3DFWAe6M0ZmNeW59eo=;
 b=HLipzQXxlri/JqEPjSzo1FA27FD97zBAe/KZqJWXsVUcwhQTdQCNCDhfzSI/5h8k6p
 qRwWjn70ly+A+hYsZ0EoCUUpmwy5hWqew5qovhc0H7fV5ysuUxzZyqNVcJERbLCJqCk8
 nl+dw+WWXqnQ6M3mnokU8fwmb6LfKSP3X0WJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722454723; x=1723059523;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jXdTonOVHBxSG+LassHd2Koj/3DFWAe6M0ZmNeW59eo=;
 b=UKCHiXv0xivwRl5e/Mv7/oQl7P0/in64UjrPCZwN2ECioknZe5Urxbau97MEQfwB6C
 Iql5YyLGhYmmmSxYylIBvuMglAikMn8q/vpVuxAQn1xSzGDyK4JvzLUFNxwwC4qkv4Be
 pC1rUlEpJEu3Avyyyf/7pvbqCLeB5UXcBrHAtHxhu5/mkPhnU9INMJqPi9c8v+i2eRSZ
 LmTiJV0fDcbJ4j7j8v4zzG5f8AmDlnUAL4tl9Cb2KF3H9fES8UdpVK8zBAYrIvirITBs
 ZIjisAYSVfmvNW1bo6LXVziiTAHp3dv7wV7cUnJ6q1fztvSqbmgQUTqjEi9ENj3uemc9
 E9Eg==
X-Gm-Message-State: AOJu0YzoB+1E1rTGZKz9v51p+U3+Kg4eWKO2tqcXARcBnkBFfGKZXVJK
 sEtDXTl39lPFQjttZqJIMuhhgPLjx2vGk9HNTTWM56eEDQPkLdSPkoPdX9pEcL4=
X-Google-Smtp-Source: AGHT+IEKc1D3LNBz1pa+R8rf5heEJ7sN0Vd/ZnFt1QlRDoGd5dMR90dWTaD4cyj/RYMHFO/Ij+eKhA==
X-Received: by 2002:a05:6808:148d:b0:3db:1646:e958 with SMTP id
 5614622812f47-3db42cd88c6mr3333713b6e.13.1722454723107; 
 Wed, 31 Jul 2024 12:38:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db41806da0sm817377b6e.31.2024.07.31.12.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 12:38:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, uboot-snps-arc@synopsys.com, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Ezequiel Garcia <ezequiel@collabora.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>
In-Reply-To: <20240717-edian-v1-0-3cd4896edf2d@flygoat.com>
References: <20240717-edian-v1-0-3cd4896edf2d@flygoat.com>
Subject: Re: [PATCH 0/2] Endian Kconfig improvements
Message-Id: <172245472040.3951333.12476335428392783288.b4-ty@konsulko.com>
Date: Wed, 31 Jul 2024 13:38:40 -0600
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

On Wed, 17 Jul 2024 16:07:01 +0800, Jiaxun Yang wrote:

> This is a subset of my previous arm64_be work.
> 
> I wish this could be merged first so it would be easier to work
> against xtensa and arm64 be support.
> 
> Thanks
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


