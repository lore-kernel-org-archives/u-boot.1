Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A87EC3DA4A
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 13:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04D1D8887A;
	Sat, 10 Aug 2024 15:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OOV7TZfl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6726F8860D; Sat, 10 Aug 2024 08:52:52 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F8B1885C5
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 08:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kimth0312@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52f04b4abdcso3999951e87.2
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 23:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723272769; x=1723877569; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=E3qZTo9ZlceunSGdNZJxiD4DoDBryqdci1bQDaggjxs=;
 b=OOV7TZfleZSMTAqHpqWZVZsFpir0R4/Uv6pSRnNBwRAYUzZAQW3J3DDFEDZNU8Wpj6
 szH8N2GPNPKgP+NTr2SjLJ/W8fWjFIKVftKEwoqTz9g4+2amkpIOQmjfk/E/T+yqQYYi
 +4nD5hfD8iJWTe/ZSzmqGXbwNZ+BpPpeipEfgB8sgUKGfXk6ksEL6R/C1h2Hl2WPbU70
 tk4I0GPVq5IrONfcthFs9C6QzrvsxbvtGcFgs9xKKUsKjTTDXtsTkAPcSuPm3l+pQxan
 /5dgGmLE9S0+bG5oCQQp7aNMY9Vv3U2fimD1Dh/Akunme+pNS+uozFxuzaE1uaLPZyzn
 G0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723272769; x=1723877569;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E3qZTo9ZlceunSGdNZJxiD4DoDBryqdci1bQDaggjxs=;
 b=fXkoIImsEKh9umD1ROtU2vjHuAwddD7o7KlE8tgkhEBh2bu0SK6LuEnvADrcNwOTgP
 Lc9vmPdF7RCwdSAoUgzKAi5+7T4OuRyKAfUQ7LXuCgU9NCKm7WrFew5RzSTwAJ209iFR
 nhQ/PCy0mRIERb9NwPzhSt2Vehut2EB66R0EzZnLOJsDi3MKLfEEoMx6M95IAPr3X6r8
 m0h7dpCpM10BCJvkYqfym0YRG9PeVJ3XmdV5mPrBobAv4MXm907kqSBxIFLCu71jbZrt
 asgsmUMuNZg5EfWjAHOcvCVGv3xB+u6xT6arD39APN6SVjZtGfaXgAq9cIhIvjS6AgeO
 83Iw==
X-Gm-Message-State: AOJu0Yzw5IjaC/X/oBFOwRHi1YucS62R/zPBipIycD63tiM5F18o4knl
 o1GwWxvtZAUPE7HP/easkilZX2JxKZQ11RDT4DMqoUcsLFZaMV4Zfg5Ac6TS5uP4Iai49unQY4o
 ofWpxGnKVSdeBNLeaDePU4Cu/Mh4zFg==
X-Google-Smtp-Source: AGHT+IEArACWEDqk8Yf7UehHKU2mOgYVjC/q2hFycf/xLLRIQn6ywLffyb96Y21VGIAfFLoVDQ4WLRSySYzVSzeWr1M=
X-Received: by 2002:a05:6512:2354:b0:52c:e05e:849b with SMTP id
 2adb3069b0e04-530ee9e0416mr2632432e87.39.1723272769177; Fri, 09 Aug 2024
 23:52:49 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?6rmA7YOc7ZiE?= <kimth0312@gmail.com>
Date: Sat, 10 Aug 2024 15:52:38 +0900
Message-ID: <CAEttap-5P=x0WMjVNwVUVhYe8eHtuQKyzbWcSOFjTahOLbZYgA@mail.gmail.com>
Subject: I think I found a typographical error
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Sat, 10 Aug 2024 15:40:19 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi, I was looking in the 'arch > arm > cpu > armv7 > start.S' and I think I
found a typographical error.

On line 45, 'This allows U-Boot to loaded to ...' should be 'This allows
U-Boot to *be* loaded to ...'

Please check if it's right or not.

Best regards,
Tae Hyun Kim
