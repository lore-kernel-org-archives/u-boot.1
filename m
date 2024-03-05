Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58230C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 13:17:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB87188044;
	Tue,  5 Mar 2024 14:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PylQmbnH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EE5C87FA0; Tue,  5 Mar 2024 14:17:48 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 868FD88044
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 14:17:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-609acac53d0so18956307b3.1
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 05:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709644665; x=1710249465; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xSnwkos2S24QHacQFJM6OnA23AEQzsZPlWvK83QCUr4=;
 b=PylQmbnH3+9vXMkdULT+ngsNzM1HFHQapib3WHHlloLgDmFKYiPu7Y8h8e2WlrnnsM
 CsEG664yC5cKUqVQJGiAtT7La4guURzG4fTCaPOYtKoX/sOi0Jjd7D+kCzCkcb+rmg8+
 VmqkTHc5YSwSOl4d5eyq4mifmmOsZ1E+tKCZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709644665; x=1710249465;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xSnwkos2S24QHacQFJM6OnA23AEQzsZPlWvK83QCUr4=;
 b=SBD3ACe/7nNujlF51kEBufpfzS9vwxxDldQGUUM14rHu52BXDSq0r0wCK4gS+tOmPi
 EPQgZltVsqvbROFWhw6w4PIo2Ehkoud0Lhczl+lkGSotVnXDH6kRZR+tx10B1OEpOV9g
 ALhDPYEKKJ2Cxv4SyS6gCatjlEvyT/MFoI+D+9eEZ8acNrrPPZfzbsGKpAed1m1dsf9K
 1BTxUCWHo6U2gh4mqH04K+60qf0BW1TXMVyoD7NGF08liov00UvghVWMEtkzZ+6Zg7kn
 vPp7rrZWe9pFVGR09PCmz9TRqabUR74oT4OUUmTsoJ2NeBT/pp2qPUamC396P3SeA7XR
 T5Pg==
X-Gm-Message-State: AOJu0YxHRBPKWY3oy1xYq4ruB8qXH1Qae8gLFU8nh/0RhbH1U9FBNDX3
 u6tS2owpIanmxMSFsgBh7h8b66be42hucYRXDPuvkFEmL7ZZ0KvC+s2csSQidOI=
X-Google-Smtp-Source: AGHT+IEMqbp9FL+SSXJ0abib9/8a8m0seC9XreIYmXy2w25vOVtneJkxvsocuHH3IE4nf/X69Z9rbQ==
X-Received: by 2002:a81:a20e:0:b0:608:6ca9:abda with SMTP id
 w14-20020a81a20e000000b006086ca9abdamr12014800ywg.52.1709644665222; 
 Tue, 05 Mar 2024 05:17:45 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-007f-0000-0000-0000-1000.res6.spectrum.com.
 [2603:6081:7b00:7f::1000]) by smtp.gmail.com with ESMTPSA id
 u84-20020a814757000000b0060784b3bba8sm3169501ywa.35.2024.03.05.05.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 05:17:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 =?utf-8?q?Micha=C5=82_Barna=C5=9B?= <barnas@google.com>
In-Reply-To: <20240219163213.855667-1-barnas@google.com>
References: <20240219163213.855667-1-barnas@google.com>
Subject: Re: [PATCH 0/3] Fix driver for misc/atsha204a
Message-Id: <170964466455.2716579.1226354579442657631.b4-ty@konsulko.com>
Date: Tue, 05 Mar 2024 08:17:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Mon, 19 Feb 2024 16:32:01 +0000, Michał Barnaś wrote:

> Fix the driver to behave like the chip datasheet requires.
> Improve wake up function to send low signal on SDA line for at least
> 60us as chip requires to wake up. Fix sleep function to move the chip
> into sleep mode, not into idle mode. Remove unnecessary for loop,
> which would never run for more than one iteration.
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


