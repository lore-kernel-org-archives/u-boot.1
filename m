Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F147C021B5
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 17:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C04780FF2;
	Fri, 21 Feb 2025 18:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TB6l5g4f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52A6C807C4; Fri, 21 Feb 2025 18:38:25 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59A2F80F92
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 18:38:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-220ca204d04so37514235ad.0
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 09:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740159498; x=1740764298; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JPwLKXY0vwULZO33SFPOqM0MqQHd3PQbXe4/wXUDTiM=;
 b=TB6l5g4fUN6hwzen18RODcRM1js03Iog4C+VzkvpMcHCT4Fn3fDso7n0AQtYCp4189
 AfaQD2D1KwibS0eocU9wocalhECcx/4kp0FSgObDycsO0bmi90osFljLqFoGcGGrTKt2
 Pl+UoWQxNIvu2699Y/FEafUQWyzOGzV3zgXPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740159498; x=1740764298;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JPwLKXY0vwULZO33SFPOqM0MqQHd3PQbXe4/wXUDTiM=;
 b=pbOE8vW07ynJ527g48sbX8EwKMw4MFbuxb4r3Pq79NTx/AWssUTQ21wog7o9ObCHGf
 4iJyFAt+lQ9iocFrgGRn/4gFdmjNAsqIvM3vO8WMT1GVpk4SblcLLERaqtgfHpygVC4l
 mu3kcLTUvGXKNLAx3TzYF15HWN332Q9r1cWb/twrOTQTbWPWwtVitJWvdw+VVSz8qkcJ
 tupzB5Fx0X4OIDbtQTlKqXcGWBy/iw0iLUeEr1qOWk/tZbZ9rbqvZQ49x18EbX2v5TKO
 gJ2RLgZhmZHv7/DBT8RtQCYMToDsIExR522Z83HsZuQuTWZ/WkIszHxaxJ2KVJuyDyxw
 AI4A==
X-Gm-Message-State: AOJu0YyALWwJ2JtU2weqaVeQ5pxmykD3AxsPr+u+g27SKNuN88Hddmxo
 DasTY/ZvQHOPd+RsLvTA39tAdkGfL//SonbIefv7WQN7N8HNILs5/wrTs3p3pIiUWmKoxtYeR3e
 PLK0=
X-Gm-Gg: ASbGnctoHZPRSi97lBWdetDyOX8iAQxvj2OVHfGbN4ivLlE2TwF0pu0EkuKCBAcw1Rt
 wntn3/cpDnHKsK0ZCQm8PMIPhapA4DJTkqpA7YVLL/9CcW4iy1jTgZX9HZ5fNW295wHG+G5q4I2
 xeiBNojlgXkd0+aXYHUxgPw6PS22L9/Nx7uCITLqNtZSwvs2vvW/qKiD6K+vvIJrHus5NAxa88m
 1AmsEat8WUleiWWQRnJzAYBWjmnWz0H16FQJFXFLsv6id7F2Ot/A2QDr3N9nVtNYs1gDQh4OwTz
 1LTL59kG2anJIb6JY76Wjgc=
X-Google-Smtp-Source: AGHT+IHR3TN1OTQZcJ2QLtfeFDNqT5FKnJO/gmJjt73MrrHPM7yTKh3nzRTw9i+JhUHQkYiqnSU48A==
X-Received: by 2002:a05:6a20:a105:b0:1ee:7d95:c674 with SMTP id
 adf61e73a8af0-1eef3dcc2e6mr7500764637.39.1740159497907; 
 Fri, 21 Feb 2025 09:38:17 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adec4756d0csm8792554a12.55.2025.02.21.09.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:38:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250220212239.2954325-1-trini@konsulko.com>
References: <20250220212239.2954325-1-trini@konsulko.com>
Subject: Re: [PATCH] CI: Update to pylint 3.3.4
Message-Id: <174015949713.3526942.3781521991007331837.b4-ty@konsulko.com>
Date: Fri, 21 Feb 2025 11:38:17 -0600
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

On Thu, 20 Feb 2025 15:22:39 -0600, Tom Rini wrote:

> With all of the reported warnings now fixed, update to current pylint
> version.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


