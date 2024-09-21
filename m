Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5F2CF9C69
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 02:39:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6263F8839A;
	Sat, 21 Sep 2024 04:39:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rhG1BpK8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E3DE88356; Sat, 21 Sep 2024 04:39:21 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD4208841E
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 04:39:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7a99e8c32c0so258806285a.3
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 19:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726886358; x=1727491158; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0g6d5QUietbvmIPZy0r3p+1GjnLbs/+WORfRdNB0G0=;
 b=rhG1BpK8zXUSSSf4HiBQuPvZdLOp2Tdm+UjB0ZMCp9Dz62VaPLqh14KHA4VqCulaof
 X7VCjhPAv7YnypWiMqHgM93TqjCcVkSaGqdsklyjP7u+F+egHB345+9IwSd8y0a9dXEB
 MMxhbFQFBZwn3LplCrIJ/9ABuI/znNwjxVAC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726886358; x=1727491158;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0g6d5QUietbvmIPZy0r3p+1GjnLbs/+WORfRdNB0G0=;
 b=sRwTXarj7DxMSyoQFWhW4J4vIwUuSgocMLBLclu6U0jZ+gRULCkrCU3OErPf056YsH
 extECJKZ01CzjYfhVryTEVH8Z6wHBenqKff4UxjpasAm3AOtPMNxbo0FBYMKkFPL6TBK
 +ZGrXl9ikpZ2SV6bXNl8Q5Fx+l7xxHxa+0ltJ4wpeVKK1ExcmEX1uuUgsxg4Ds0FpGfZ
 KWeM2WvFJozEg58KvgEdadya3OQkT6eIxViPlHGsTincTxfPpmL5XEqNgBcTVvGSvmQs
 vu/25ckiAYqPJW5Jw2n3em4nu1HVX4RpYeovXQgpJIwHcNnY3Zh8oi7mYejfU8R+NLAY
 +stw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZBlKU7spDHFG71fgzEXHhYh2T6bZApHw7tr9khv4SKKx4XB/UI+TyVZEum7aSAOpf9OsYBQw=@lists.denx.de
X-Gm-Message-State: AOJu0YzPBsn3ZDbZbRSW/x3mGT3mPBvvMIi01ie0RSJmSEX6j+UL+RPS
 56kpgBNjwfoxzjTK+4P815IZnEfhL6nkIpgARn14lSvbR+GdR+CGMF6fUfJ0rdc=
X-Google-Smtp-Source: AGHT+IH81E/I6TX4kq4EpbkniejdOS0QOtI/x7hCI95Dg6VHqspYWMw+Lsdr0/JQi3HrhlRSxqByKw==
X-Received: by 2002:a05:620a:400b:b0:7a9:d044:e83e with SMTP id
 af79cd13be357-7acb8e0fc19mr644258385a.57.1726886357623; 
 Fri, 20 Sep 2024 19:39:17 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acb07dfebasm250227985a.17.2024.09.20.19.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 19:39:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, u-boot@lists.denx.de, n-francis@ti.com, rogerq@kernel.org, 
 afd@ti.com, bb@ti.com, j-humphreys@ti.com, sumit.garg@linaro.org, 
 Robert Nelson <robertcnelson@gmail.com>
In-Reply-To: <20240917081329.370288-1-u-kumar1@ti.com>
References: <20240917081329.370288-1-u-kumar1@ti.com>
Subject: Re: [PATCH] dts: beagleboneai64: Add boothph in chipid node
Message-Id: <172688635501.2451723.15227577386354920986.b4-ty@konsulko.com>
Date: Fri, 20 Sep 2024 20:39:15 -0600
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

On Tue, 17 Sep 2024 13:43:29 +0530, Udit Kumar wrote:

> beagleboneai64 boot was broken after OF_UPSTREAM support for
> J721E SOC.
> So add bootph in chipid node similar to other boards of
> this SOC.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


