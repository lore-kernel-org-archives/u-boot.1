Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87D1D6DDCB
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 04:29:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AFEB896B2;
	Fri, 15 Nov 2024 05:28:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZRqJJzhz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0247896B8; Fri, 15 Nov 2024 05:28:01 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC70089689
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:27:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4609c96b2e5so9124041cf.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 20:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731644879; x=1732249679; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3+AsNQux9MXozT7uhh2KUcnahC/QK1dyG6AOXPkx+kI=;
 b=ZRqJJzhz+2d5nnFyEwWtU/sx5ypdpVcTdVQxqXSSOJyWvZJp1fqJc/cWpG5epW7pjL
 sXcMSEdYyXN/odrlEPRWRE6KOM3CXnM/TBpgkeNtR8IiogOzbUbRC6K4Fx+Oxu1Thj1d
 LD6cRp5Upi5N/XBy5IyMMBZ58d9ybFHtppUsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731644879; x=1732249679;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3+AsNQux9MXozT7uhh2KUcnahC/QK1dyG6AOXPkx+kI=;
 b=Xy6lbjfaldM1AtYeZ26PEIGu+QFoi8Q146GzwpLpeVr46huuElI8TTvsqh4kJ5T+88
 /4r7EYG2WqaKhyWMoFg5qnpNaLnp6c6pr9bzRU7XUW9QNGb6eGCmVczbz1Zz8MLn/14h
 Wl6qGNbu95CJiA945ZHnQ7vQS7E2GlWiq88IUIw9AfMVYOVJm+FUYFhyO7fKJDVpoXah
 ZortYBRI6vLBpHntNuwS7ULRib8vJEJ36CarSyhzMSZJ4Y/GCua7bthbGorYb8CwLJdd
 dvQSabxei7Z5IjOdq+7e49nawGPPdGRvbQ7DTKI/vngym4XCj6JvQKicZfo0OwFFPqPm
 oklA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7oQ4bC3SE60x2NhyXj5DhoTRmPgQWiz3DGPx/JTaE1Qy4ANcp90+mdNqmL79BzrF0Dp/ehvo=@lists.denx.de
X-Gm-Message-State: AOJu0YzlRN/75pmBJinWfa+9ukNEYbg/jwX0KiV5WdCpns5UjFrfsq5W
 iFq/5hHlMiJrUIzNQc5TRuO3USuest8jUgRr2gD8RnGMBFp980RCRgp6LsSlGN67kEbcSHuzjXx
 HvDY=
X-Google-Smtp-Source: AGHT+IE/LktR7LvDkRKBQ0slqUNIj1m8yJw4sLnNs9OFSjXQYLZ0CH4FcuUS8T2Lg8r+nrerI/r7eA==
X-Received: by 2002:a05:622a:4815:b0:463:17d2:4b7b with SMTP id
 d75a77b69052e-46363ec0ab5mr19841771cf.48.1731644878582; 
 Thu, 14 Nov 2024 20:27:58 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635ab24bbcsm14415041cf.58.2024.11.14.20.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 20:27:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Kalen Brunham <kalen.brunham@intel.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
In-Reply-To: <20241103053551.52715-1-heinrich.schuchardt@canonical.com>
References: <20241103053551.52715-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 0/3] examples: fix building on arm64
Message-Id: <173164487673.1205089.9454317745838484395.b4-ty@konsulko.com>
Date: Thu, 14 Nov 2024 22:27:56 -0600
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

On Sun, 03 Nov 2024 06:35:48 +0100, Heinrich Schuchardt wrote:

> Commit f9886bc60f42 ("Added arm64 assembly for examples/api crt0") added
> the arm64 architecture but the code does not even build.
> 
> With the changes the 'demo' program runs on qemu_arm64_defconfig using
> 
>     setenv autostart no
>     dhcp demo
>     setenv autostart yes
>     bootelf $loadaddr
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


