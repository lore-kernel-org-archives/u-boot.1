Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5C6C54E68
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 22:23:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BB3F87EA8;
	Tue, 19 Mar 2024 23:23:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=wetterwald.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wetterwald-eu.20230601.gappssmtp.com header.i=@wetterwald-eu.20230601.gappssmtp.com header.b="pbvRqGiM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90CEE87FE8; Tue, 19 Mar 2024 23:23:33 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 135F0871C7
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 23:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=wetterwald.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martin@wetterwald.eu
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56899d9bf52so7854812a12.2
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 15:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wetterwald-eu.20230601.gappssmtp.com; s=20230601; t=1710887010; x=1711491810;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ugLvVQeakGUZYE1tfHuRZT6Sy+1LD0NW9HW1fVI7Opk=;
 b=pbvRqGiMl4xFLzqRw/GQxMCKh9XhNz8zKq1NlECpMSymC5NeXmgyyjsAujDCjlzye+
 Lb6R4mQz1nBoRDJ/B9GdbU60OjbvWoSm3qgUHeSb9OqXZTvJG2ZThCwFBf1aHBHDRXP4
 /9Ml+ue3oCdtI/Mb1a5943qDLMuyTHgzneq4t0Djl4/JF9v8sHVZ00CCQ9LLb9FxSclq
 PmfpfvTdA2cdX9RXLI1IRfRkXiCIBSJsBY+DPtGmjTfmfbL2bQXhqttY8ZN4li5CmOtp
 3Npmrb9OfDiGPikb0kz8C7NvMypeWnlqleI/TC/OxjS+prIfBsuy8vtYZQcVt8V9HW7W
 g1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710887010; x=1711491810;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ugLvVQeakGUZYE1tfHuRZT6Sy+1LD0NW9HW1fVI7Opk=;
 b=lnoe6nD03mynGUaF0hifNwG6l4ddXTR6opIYhgltKSdLnVEwBrRGUO1Hy3nhiE3Z2Q
 aOnHyAQMT1u9nK5d2TPTPv+7M8h4JWJznSDniRrCZ4o2vrNZXqB424KxqF+lxVL1Uq5e
 19L2sShiKD09ZZa4i3T3gyJSaQrrL3B1jZQAam/EC04bmWuFAn/bIDzhMkgzk04jRjdp
 xVzkx1U0n8uvpmRKbIIHP/kj13hY1juMlDcgXBkwfmZ/vuyjFbamCqhlBsgicvUBJbEa
 bl3Jailyy1RXtr8Og/DDxHwjemD+tMLL1jUj6sPGqrPB/fOamX1aKi1A6SPGFqYdE03v
 8xUw==
X-Gm-Message-State: AOJu0Yya7uQXBE+ldeBoNvHlvoPRxv+KHY+64RMVHRJgOaF4QKmEY7Mo
 h5HzPXmew0Dr+kiGCjoFive5YAMwG35mxtaRLanRy54RVbu3oMV4sesUj+hpGdwiPvSHDogYIVk
 94iyqn2BKXn9YwLuZQuflwxUu7ylOwBu9Z0gejIt5q9M0B3ahdlE=
X-Google-Smtp-Source: AGHT+IHneOeXNzMe7rB5vCvi5Yp39i85PPJuepcTKzkBldFmhmJk2ZfkM44D4YorkKlTQVP4RGddz17PTkrdxWv+usI=
X-Received: by 2002:a05:6402:4342:b0:565:faf5:225d with SMTP id
 n2-20020a056402434200b00565faf5225dmr159482edc.29.1710887010347; Tue, 19 Mar
 2024 15:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240317183029.7450-1-martin@wetterwald.eu>
 <20240319215836.48178-1-martin@wetterwald.eu>
In-Reply-To: <20240319215836.48178-1-martin@wetterwald.eu>
From: Martin Wetterwald <martin@wetterwald.eu>
Date: Tue, 19 Mar 2024 23:23:18 +0100
Message-ID: <CAFERDQ233hBSp9p8sqhTR3XCuvtaDyxq8mQcOfwYWZPEEHViPw@mail.gmail.com>
Subject: Re: [PATCH v2] rpi: Copy eth MAC address from fw DT to loaded DT
To: u-boot@lists.denx.de
Cc: Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>,
 Antoine Mazeas <antoine@karthanis.net>
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

I reworked the commit message because I noticed the upstream Linux kernel has a
difference with the Raspberry Pi fork of the kernel regarding the algorithm
used to determine the MAC address of the smsc95xx.
There is no smsc95xx.macaddr in the upstream kernel, and using the upstream
kernel is actually the real use case for the patch.

I'm now wondering whether some users are using the module parameter
smsc95xx.macaddr of the Raspberry Pi fork of the kernel to try to change the
MAC, and put one which is not the factory default?
Does this use case exists? If this is the case, the current algorithm in the
forked kernel would mean that, the FDT-provided MAC would have priority over
anything set in the module parameter.
This is already the case anyway when people give to the forked kernel the
firmware-provided FDT (smsc95xx.macaddr is ignored). So this patch aligns
behaviors.
But we should be aware that applying this patch would change the behavior in
the following situation (all conditions need to be true):
- Forked kernel is used
- Fresh FDT (not firmware one) is provided to the kernel
- Custom (not factory) MAC was set in smsc95xx.macaddr parameter

Martin
