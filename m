Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA2EC3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 17:44:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E421828A2;
	Thu,  8 May 2025 19:44:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AX9h+wqO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AB6782952; Thu,  8 May 2025 19:44:44 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB2148283E
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 19:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-401c43671ecso779445b6e.0
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 10:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746726280; x=1747331080; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4dD3YwbyGFE24hI6m9WKa+LLXJZN76e4zBhh9C44Vzc=;
 b=AX9h+wqOh71huvxzU2MFfDgO0H7C5X/CpjP+GN5ScVHVeiZ/wz2Jn2T+iWOAy+l1Zr
 Bs1u40BSkslLqJXzfEqecF2ivXWPohnl5xe2F4clyDL1aUSbyHTXNhOEiXFjFApu2FGP
 q8f1ILGTD3TkPB6tpmyh05Y2H7spPNBc6FBpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746726280; x=1747331080;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4dD3YwbyGFE24hI6m9WKa+LLXJZN76e4zBhh9C44Vzc=;
 b=OUnNYfqhQR5SiDOxuuixaf6hOIHzTX9NPCR1CM1L3S9R9nkKS4MkM8ddEauRPul9ro
 26SvLMskVXfHrgFe9ITH9FxudWS51uH1vb1nXEMiehKUzm9HiOUKlLuWgzBzCjeCv/ZN
 FYRvHD0al0UsVocJZ1wknLl6E6B9ArEgNDTz2e7F44qsf9pSzEzP0+fdBMEtcRxxjmR7
 ahMouju/mwMK2BJUU5q42i9lzsctQjQDjqYIbAcIszyQOHVqrT3mrlU9yoldNhs1NC/b
 H8rlDJQvXs/PHUlbZHhvUnSHzTCYkoCt1wLXOGEbpL9w45+5cJM++8dlnti5xewBRkGP
 Z8Mg==
X-Gm-Message-State: AOJu0Yx2020MgrpR/sn7knzbV/UIYyxyTOzenJ7/ktXc0M/lEO2LujSU
 93tI69ZfeX5A4n8yN722p/vOD6l9KwBaTOHr1mZIGq6uled5DumYo/ux/gjkl1tiwTLJpnFfk8e
 i
X-Gm-Gg: ASbGncs5WOZlFqzAl7rtFzfqRLnJ1qFAtbre+o0me9BbmwK6cPDZtGckcbr8ABeeby0
 q0rTMmTA5EaJ0Z/Jh5mKZgYfL7uqE4aZrQb/biS0EFiCX6wW+Fz7cOc91YJdmfp2Yhjc+QHAOY6
 xRsUentTgLNGOgBeCjOvzzbnG/Q+6x1zPvRO/jFqeLohBbCd3BlzlsbYzk8oB0O+19sW0g1DB7X
 4t9CKtYiRVXS5XWRmY+BYqNJsWNmfhRbt+e40OZcm7u7naoIPfi6wrkDenwi8sRO1kETunFlC8k
 olRbuHC2A4TLMtfme5aNNxQVUBpB7MOh1RNCfDtgjpXjk5nBNxroKcQNWqhrlwtaFqz2Urvp6GU
 g
X-Google-Smtp-Source: AGHT+IH4xTwU2QiF74O+JS+uuPTBoLeivwzwjn/waZ/tAJhWrXUfSzF/HBVSMqF8iDIQO1axW2jz9w==
X-Received: by 2002:a05:6808:d53:b0:3f9:176a:3958 with SMTP id
 5614622812f47-40377983b84mr2461179b6e.11.1746726280283; 
 Thu, 08 May 2025 10:44:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40380398aecsm50482b6e.43.2025.05.08.10.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 10:44:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250508072951.538794-1-kever.yang@rock-chips.com>
References: <20250508072951.538794-1-kever.yang@rock-chips.com>
Subject: Re: Pull request: u-boot-rockchip-20250508
Message-Id: <174672627962.621629.5205728279044955820.b4-ty@konsulko.com>
Date: Thu, 08 May 2025 11:44:39 -0600
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

On Thu, 08 May 2025 15:29:51 +0800, Kever Yang wrote:

> Please pull the updates for rockchip platform:
> - New Board support: rk3566 LCKFB TaishanPi, rk3588 Xunlong Orange Pi 5 Max;
> - Add rk3288 rmii support;
> - pinctrl driver fix;
> - binman description update;
> 
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/26117
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


