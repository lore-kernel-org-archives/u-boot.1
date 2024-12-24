Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407A0E77188
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 13:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CFFB807DC;
	Tue, 24 Dec 2024 14:59:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=munisense.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=munisense.com header.i=@munisense.com header.b="LpSBa18c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 117C5807A7; Tue, 24 Dec 2024 13:45:29 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84BE380711
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 13:45:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=munisense.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gijs.peskens@munisense.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aaedd529ba1so225255766b.1
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 04:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=munisense.com; s=c12e0d22-ac12-44f1-aa93-b49ab5265a0e; t=1735044325;
 x=1735649125; darn=lists.denx.de; 
 h=content-transfer-encoding:subject:from:content-language:to
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bTKsJW94hQkOa1gcYFyZI6bDXR9XpGXNNhSxbGkfFy0=;
 b=LpSBa18cU/RAWYce59/Nsfp+IFaitgw4DvEEXrhZ9LAoX2ty+vDrQHO1WoKtQZWQaV
 KMBQD7rkc0mGrEyN9D+CQul/NodJh1NNsR0ahTydkN9t1SeQzhY2vUXNROD5hzHWd5U6
 VOU+nIRXACiKxM0iAwJgBZDm5lafHicR9X/PEz8WikkbbWeq/CUlyApBgEHBe/xFLMrD
 lPNgpmvvi96Oj1b1sMbg0rOF/bByxgpiKQfj4d9mOYdRDpwEt1Jda6sSFQJ7pwNv/bD4
 WJUVhnyyNGGp7niJKWPMLDmuYlOyxQV762h+pdEGZ5mCaAgLNI4sPjMeUoZKbDLR/T5c
 R8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735044325; x=1735649125;
 h=content-transfer-encoding:subject:from:content-language:to
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bTKsJW94hQkOa1gcYFyZI6bDXR9XpGXNNhSxbGkfFy0=;
 b=ZVgRzCOItTjS9qZ8Pzkhf8Xv2ilNlNoXc0u48LjLckoeX2F6vNeUfVCsHT6i08spHs
 n4vjTuP+QW4fkIlry4T8ACtT2VPxc+A16tz+KAuSvqCBtEg2rFf2VLzYESgUM4UZ1QGQ
 AyY3nOygj4JEByzdA3xhInoTN41iE/tWzKMmd5Z/sdw20MsGL+9sbJ3Pe+ZhLbXv45EQ
 /V/R3BjxGiso4Qm1zhRZLgao0FC63GskA334uIRSgxrAW2aj5UPkYZKNcZOQyupWuw9l
 +TU0dPwb1WaveOXcDwGTQLYoKcgR7dXtIbj/xojOWT/guURyrHbPiNM5rShLmD3MpF4i
 Re+Q==
X-Gm-Message-State: AOJu0Yy0rfMn5LxGgmAiGQHhTFlCtXuedu5vxq54+freXa8TkClFBPAp
 b1hRQM3nhAgtDpFjml0HqffrsNxSvBLPxbevF3zOL9nQ435ZW8kxu8f+PuuEQfEXI3FNiEhxOgg
 RJoQ=
X-Gm-Gg: ASbGncuRBW6qwzGjY0zloYY9hPvP4BTUjWjrbDUAF8Fkxokh18qHBOOKOqda1DgpO7y
 Ut7wX6XQwP4RdcA1i4Ujy2NUmRdWY9JYkfGqffo/HMTBWhIPxLXMRL0tEN+ULFPMytMiz1MPF/9
 9BbXia065XCEJODJXWK2f+se0WyhajExJ0rJqrbthbtxGlbsR+cheNEufkBNWB3WOhb1Ar78HpQ
 xQ46n+Sv1UGj+89k5L6zbUX3OmUNXtyli4mGtoYOHj85MVpr/EyIkbvx0KPDr522i1U0kch8opB
 pyUKP21nEODEn91+rLNTaUVnUvnbffJtOxR/hQ==
X-Google-Smtp-Source: AGHT+IHM2UQbb17eOw5iMhsHRF1L6dHCx9sO8l1+7syHDhBWDX144TmpgAsZ88GjWMJ5hAg1KFb1GA==
X-Received: by 2002:a05:6402:2802:b0:5d3:cff5:635e with SMTP id
 4fb4d7f45d1cf-5d81de065b8mr38364153a12.26.1735044325196; 
 Tue, 24 Dec 2024 04:45:25 -0800 (PST)
Received: from ?IPV6:2a00:1708:3ba6:500:665a:5cd8:228e:7323?
 ([2a00:1708:3ba6:500:665a:5cd8:228e:7323])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0f011efdsm647336466b.134.2024.12.24.04.45.24
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Dec 2024 04:45:24 -0800 (PST)
Message-ID: <cd71682e-33c9-4e38-829a-a540a53bacad@munisense.com>
Date: Tue, 24 Dec 2024 13:45:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: u-boot@lists.denx.de
Content-Language: en-US
From: Gijs Peskens <gijs.peskens@munisense.com>
Subject: rpi: Compute Module 5 doesn't autoboot without debug UART
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 24 Dec 2024 14:59:49 +0100
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

I'm working on getting a compute module working with Yocto using U-Boot 
as bootloader, which mostly works thanks to previous work to get RPi 5 
working.
However I'm running into a strange issue: if I turn on the CM5 without 
the debug UART (which requires soldering a header onto the CM5) 
attached, the Pi doesn't boot beyond showing the submarine splash 
screen, if I boot it with the console attached it autoboots correctly.
If I attach the UART after the boot halted and press enter I get a 
U-Boot console, and giving the boot command boots it normally.
And setting bootdelay=-2 in the env allows it to correctly boot.

Which leads me to believe there is perhaps a spurious input registered 
by U-Boot which interrupts autobooting.

Is there a command that allows me to extract why U-Boot didn't continue 
autobooting?

And anyone have a hint how this could perhaps be fixed in a more elegant 
way (allowing interruptable autoboot).

The hardware I'm testing on is the CM5 devkit, I needed to make small 
changes to yocto to get it working:
https://github.com/agherzan/meta-raspberrypi/pull/1397

No changes were needed in U-Boot to get it to boot

Thanks,

Gijs
