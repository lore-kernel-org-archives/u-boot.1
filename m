Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64396CF8864
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 15:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A41B383936;
	Thu, 20 Nov 2025 16:31:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mQP/L1w7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A01483968; Thu, 20 Nov 2025 16:31:32 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 593B78392C
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 16:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c6cc44ff62so715583a34.3
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 07:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763652689; x=1764257489; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2a0l4qZ0duj4CzE6CPU0w8xYP/2VKEBWvwI+Sicd918=;
 b=mQP/L1w75EkG8ifoCAGhmTe4V+81QDtcVh64VXpWTICCC8uuyBaVUHANIDQUnK+dXb
 p5vaZi6taKSlKSMm8ZodH96npsGEnW6SBo4LyQIvQXzD9ff1saIOQ0INmugtewQPTisl
 QBqIjAG+ZuqijKHZp2ht0/n7bHKwjr166VMqzm+eiQpP1/7k4N1QM67z7FzHRI+V30u1
 YcMB0xAbkZzu8jBbdsyhn7ClXZ0BLBewl1cnjFIJ4f4O/mXEOHUInBIUL5cNsdnG4En+
 LOCxpMvAeDXm+ALi3iMpBsvWQObatr/pRmrWJYzWxRoLtOEg5RvfSxSWtCWG4PLLUkkX
 622g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763652689; x=1764257489;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2a0l4qZ0duj4CzE6CPU0w8xYP/2VKEBWvwI+Sicd918=;
 b=WFjcWGxbFluyCtykh90tp1wxU0+WraUpes0d40RBspRo2Wrist5xC5GTvWkOFjmJIa
 cczrRIHyiJyXdiaSGT12pqVt0Atz90ubqRW+jGimwq3lkcHLIElX44qCQQm2i98FylEZ
 YlDvxDy8MWeVa2Q5zuy85Mo/Nlh61pXzahKk+Y6Q5EEziy/ldvypsrTTufVsUvvx1IBY
 gjEcDuyz8pfgl64CblDywjX6xqbGyj7lDFvumymgI9VAOkG6TK4kLr09icRQaBPgrN51
 faBZuXnuqDjn5HUc/GMMXbDv3i/VNSSc0hsAv8nlCJNvisDHP170rSTAn3ZiYoTrTdl+
 kLxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGL7EDvfsLkoYEGGymedjIvuy+7fTlq0/1czU8MVPsPsWjcukiF/BYcLJT9/4liGy8jq/Izrc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6DHs4ypytjsv8fNXnobxAvsCV9fwUdNGJdur7wnsn9TO1AzZ2
 Ab/WEmJIa3gG4Mf5oRHquL3Xi9lsh0rzQssk8v8uoZ0NPcABWrCLjLc60IGLr5V3U8m/tntJkeI
 yoB1cSFXXGPhMcs5c/8vaIsOPxx51CS3rXQLQ
X-Gm-Gg: ASbGncvjU/OuyPOQcPLMg9hDkdPr9RYZzlPE8KxkHmjMQpwqAzgZPYtJnnjzrJzwPi2
 e8QkELTOX+P5APlVogSd6oQu+T5CwUHAICiiuNXz7YZl2i8PzxVV0ukHZRP4DEzyXhIiJDtoH7d
 0PNwdpb0rHg4KPjQuX5pBJHDobew22gkjPjGGZ2+FQ0f/rf6K0rtq47Ox7PU7EKln8umVf8kelD
 TjpKHuNwxCUqoV/4LDVNKYa3ALIw9VvmIFalKnHee7skHICVmIzW65VYu9inhEehLRDA5c=
X-Google-Smtp-Source: AGHT+IEedBIuiHljt1fr24jBOa97zk8i+LOhoFQjH/FNXQUkbwN0uIU6yr/PJ/NpAnhu/4LTJKajgUUt8pq2WitzWzw=
X-Received: by 2002:a05:6830:3689:b0:7b7:59c5:766c with SMTP id
 46e09a7af769-7c78d32aa65mr2267273a34.33.1763652688712; Thu, 20 Nov 2025
 07:31:28 -0800 (PST)
MIME-Version: 1.0
References: <20251104223023.1613-1-briansune@gmail.com>
 <7e31b494-1ce1-4fb5-af49-d203830add7e@altera.com>
 <CAN7C2SCBqEajYv8v+meudRN439MeiEGnW5c+eUbMWFL0rcVoWg@mail.gmail.com>
 <eed1e1f9-b07a-4dd2-a7e5-195778889a55@altera.com>
In-Reply-To: <eed1e1f9-b07a-4dd2-a7e5-195778889a55@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 20 Nov 2025 23:31:17 +0800
X-Gm-Features: AWmQ_bleWM8ixGSCPg-Hujmi6t43ISLsSf8TEFGoNraDUyMu2vB_XpdNg-D2Ex4
Message-ID: <CAN7C2SAOM5pVqJfQZYAZRVqBXO0aR2z6vgpndYawznSOhEqhnQ@mail.gmail.com>
Subject: Re: [PATCH v7] Add optimized Makefile support for SoCFPGA handoff
To: "Chee, Tien Fong" <tienfong.chee@altera.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

> Thanks for the clarification.
>
> Understood on the removal of Arria 10 from this flow, since its handoff mechanism is different and not based on the .hiof format.
>
> Noted on your point about keeping the tooling consistent. We can keep this in mind during future clean-ups.
>
> All good from my side. Thanks for the update.
>
> Tien Fong

Hi T.F.

Can try to convert to python script but don't have actual A10
on hand. So may be a test folder with generated outputs
to diff the new script for sanity check.

Brian
