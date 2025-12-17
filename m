Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CD9D65C7C
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 16:20:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 985AA83B32;
	Wed, 17 Dec 2025 17:20:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arturia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=arturia.com header.i=@arturia.com header.b="VTKYQR34";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BC4F83B95; Wed, 17 Dec 2025 17:10:03 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33E6083AA0
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 17:10:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arturia.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=victor.krawiec@arturia.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso52276105e9.3
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 08:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arturia.com; s=arturia; t=1765987799; x=1766592599; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0hEpsGuxPHQrewl36Q/v878nLi0AoFZXWqC5DjOrzZY=;
 b=VTKYQR34keKHdx1aiIkrtTUpuLhzk1baEwUtivFs/6QqvQcue6/Kqga8Na5CBqv0wb
 2MeUU9DG/XdtFpBNrNzWeTKQsd5JC6SX5vaJFJ4QNbw0ZTLq1N1SzfWwGlxnf8O1kk5l
 WQtZuC3S/p+Wl8MlMr/euKlDUPLO6YWC447zTuMQd9XVuMjGVK3KvCDdwnL8FoLP5KJD
 GrnzomjC/WPMPbgSCiFwmT+SPHH9Hn4/8ynSHxzIqyMgDyBvTSXEvPP0r2kVfPH2JXIv
 T5G5I3UAi0xyCobl/QYUU9hc6TbG35CC0f+qBYIe98o4CLdxhuktx9CfdX2QHNa/n/uf
 jNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765987799; x=1766592599;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0hEpsGuxPHQrewl36Q/v878nLi0AoFZXWqC5DjOrzZY=;
 b=gfW9XK8DBCJTXrGAw59ZY3GCeyoSRC9jUF7BBrcRSUFYY3DZXlzFMH+S52RvXllfvk
 +u2NF2kysnVb4xO0GXXkP5KZlXwfdr1uWeatgL6g78tvNQbXoLJiUZEFrzMPIaySYnTE
 bq2jFJjB+vX3BiI1ITb1J8ZXPS0VAnixYCbRgLjMfu4LQJd/+vN9KQp41JJsVx9BahTS
 1hB4CDWQ4A7mzlxXDlq251J+SlkaolwpC6lnbCVLV5AvJ3Nml9mIa6gaCT8r7ZJ1/hbN
 GptHbiCeSb7JTtMYw1nn7GzFsiiEVASBsa5uejzoyO6bif5tl5ZtpPn7ANR3hJ1PF/D5
 flzA==
X-Gm-Message-State: AOJu0YyHqP5RKMU8OCci8CpKhiTYlvnODqYrZORaIjDSnV6rCCArkyaw
 VK1f7jQH8g+GtCOEJl6E9c2ZiMr31p6qa37UDmPCJiA+CeUUMp5HzLC0sY878aVxGoBbQczcm0E
 ZFJjIz9yDf02fvkmdiqMjCzijLFcRggkrH/+MRozORBRYYANc8z5sEMUFaZ66QCLCrby/zIkBKy
 yDaGG2LjYDr2P9ccry6Lw6Am5INNilyYPf76Uaoin9vOjAo7e+
X-Gm-Gg: AY/fxX5vTLVSJhQO8i3UHA8Vr7LD+XWF1H295jEAVsHyZoC75x34zyoK7GfDzGIgZAn
 ansRw8gENyW5zgjfVo+zcb225s4RXvsAQwJ8ghxRF1LMwUXR4tdsD5wCCJyDSBt6Bk27oAx6yHR
 47SNLyFtF45mS8G0/MUOJk6tkCPIay01ZloLzSAdGI9YI177N36uYYNHjIoqP2hYcYeof77wUsT
 DWMNaXSwqNo3ysQTbrqH4KndpqSaVlSmJlWDUxsFT6y1KIaNrF+q7CVOeToZoGsIWCq4H7gN6ky
 8XTaQGUC5ZYaFai5khrfYKn4XuLCW1jhSTPNFQ0t/XA3rgBIGzkuJtpawXlHIKLirKTk/YessNe
 BU4+nLEITAioqnYFnQfB6DDiuwE4AZAjaBnCq0mk93CZ+lPSvcjCAfLQapELMy/o9uijctlKDbc
 ny+PyBjw7TOxT5DG8/iBrkeag7cVh57Gn1uQ0M3Pa4BMup9FB3ZeWrNUbMlQVn1g==
X-Google-Smtp-Source: AGHT+IGhE9NXIjFpO1iooh1XxV1+fi59IfB2zk/S9sFiOKpUjclDrERZzDAdUeMYtO2mtRoyufMZvg==
X-Received: by 2002:a05:600c:4e09:b0:477:9c73:267f with SMTP id
 5b1f17b1804b1-47a8f914a25mr220593925e9.33.1765987799026; 
 Wed, 17 Dec 2025 08:09:59 -0800 (PST)
Received: from [192.168.32.21] (226.142.197.77.rev.sfr.net. [77.197.142.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47bd995d52csm31490175e9.17.2025.12.17.08.09.58
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 08:09:58 -0800 (PST)
Message-ID: <0d8cb0a2-5581-4885-b7bc-34402a4ec3c8@arturia.com>
Date: Wed, 17 Dec 2025 17:09:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
From: Victor Krawiec <victor.krawiec@arturia.com>
Subject: Rockchip RK3399 SOC is very slow
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 17 Dec 2025 17:20:56 +0100
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

Hello U-Boot community,

I recently moved from Rockchip's vendor U-Boot to mainline U-Boot. I noticed that the boot time on RK3399 is very slow compared to the vendor version. It takes around 8 seconds from power up to kernel start while the vendor one takes 2 seconds.

In README.rockchip "Future work" section it is written "Run CPU at full speed (code exists but we only see ~60 DMIPS maximum)" which implies that the current mainline implementation lacks CPU configuration to make it fast.

I'm very interested in a fix for this problem. The vendor Rockchip tree is based on U-Boot 2017 and its getting more and more difficult to use it. 

Therefore I have some questions to start working on this topic:
- Could anyone point me in which part of the code to start digging for a potential fix ? Is it related to the PMIC or another subsystem ?
- Has anyone tried to fix this problem and if yes why was the development abandoned ?

Best regards
Victor
