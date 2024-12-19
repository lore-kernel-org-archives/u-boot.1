Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0C0E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 21:43:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8664B80379;
	Thu, 19 Dec 2024 22:43:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GsWj4zyQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D32BF8033E; Thu, 19 Dec 2024 22:43:25 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A99780196
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 22:43:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6d933736380so13690296d6.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 13:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734644602; x=1735249402; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XlvyoVPWX3n6zycdO4q+zdSGSq59nKcXCtxC5pdXOjs=;
 b=GsWj4zyQDXdPLin2Bwa8Ks58Wz+RQFgtveIJvDsdGmzSUFszXdwbtU/2wFvbgiBDk+
 dMakc2mjO1nlUxcNxZi+Avpb5dnZYcUxljewaA7gPRk570/EDgkseTsFMbnP/+GYCGVY
 +ePe8B/1Q1uRBh9/BDH16s6W181rVtC5AAy5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734644602; x=1735249402;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XlvyoVPWX3n6zycdO4q+zdSGSq59nKcXCtxC5pdXOjs=;
 b=WEI9t/zBd0WU0rPKVFbAN9QOAKH+//brGnXYWlseeqXI/NAnKip48FHp57Ll7VfC5Z
 4uavbYPtpHq3384nUKH1jdXa/aQyCE+eIRjcwELWyYmY4kd+u1JVWM86gXvfk0gjs33j
 kq5LA1/QNv00+Al3klv4Fc1kBrcnWKJenuSHvieEmAqIOcL2T08NxiS6s8j/8uDfZ9U1
 TWEGejNue7Wk9TvhWi6GcjZXWBhJJqO/tZ4DEyVpnjcKiof4OIN56V75C0K4y2SXiZRn
 oBs0cryiBRVC/bPsYT7oVNFse9yu9nWCjPBd29727sq0QRUISS44Y1otvBUAq/h9s8/L
 x1sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp7nybg++qmyKJeUSugetFDWkxVQcw6YlXmyzDs3gGTBxQY35caqczEefXtMcJm583UXDagyI=@lists.denx.de
X-Gm-Message-State: AOJu0YxZm72316xtBCXDe1wvfvmFACbLYcTmIO7YK7aXrqyryGZ5X2cS
 7dGiGrDcz6/Pzoe4VBaI0Zroz3SWJQxiXU8A013b3NdkDvEcD6w588D3sqXJj8w=
X-Gm-Gg: ASbGncvEiQFiFLidMIKeIwMp2FGdH7R2Wd0RWzB2Zny/tSwe71GnIKfzhJr8lSCaw2Y
 4UwZxdxx0BZv9h1oNUvVMgRm/b91SFGbPh7eKI1+C4OT6Hhh206F1atz70G8I2EHh6+a5Ue/bOX
 s6VP4DyR4Rjng2rRZQm0XIMYNSIYNwK0CC4HNL6R5iAe+TmffZl/eR8akuoY8GX0Ean87Wbmo8/
 7VJ5l8awZC2AyDUboGXJlmVj2YmK+RtNoTOwI39E7euiL8/BLEz2pQ=
X-Google-Smtp-Source: AGHT+IHR0XUCh7sUw0iZ92crK253cuQjYy8sXuuWo1DKxbyzdq1Io0F/Mu7znVxA5u+CU2RoEz50/g==
X-Received: by 2002:a05:6214:3c8c:b0:6d8:8874:2127 with SMTP id
 6a1803df08f44-6dd23318093mr11861676d6.5.1734644602280; 
 Thu, 19 Dec 2024 13:43:22 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd180ea824sm10410196d6.4.2024.12.19.13.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 13:43:20 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20241205191736.21503-1-heinrich.schuchardt@canonical.com>
References: <20241205191736.21503-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] net: lwip: check if network device is available in
 do_dhcp
Message-Id: <173464459991.3661439.11794080261351677826.b4-ty@konsulko.com>
Date: Thu, 19 Dec 2024 15:43:19 -0600
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

On Thu, 05 Dec 2024 20:17:36 +0100, Heinrich Schuchardt wrote:

> eth_get_dev() returns NULL if no network device is available.
> Not checking the return value leads to a crash when the device
> pointer is dereferenced.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


