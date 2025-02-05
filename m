Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DD7C02199
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 23:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41DC3807E4;
	Thu,  6 Feb 2025 00:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rCH/+Ijz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F371E807E0; Thu,  6 Feb 2025 00:15:25 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CFD0806FB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 00:15:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2f441791e40so333293a91.3
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 15:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738797321; x=1739402121; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91jTwJ5LG4OO+OBNgpmGsalCxm3ETxCcI8djFnv0ubQ=;
 b=rCH/+IjzmWLah0R2kW33CZe0AGycb/jzVuSZ1/VfbxD4E74xlZtzeDYRHcUa7etw3Y
 jp7QQ3gscfV7yMMvwrk+4aTf5XbvwkoSiQ9/s5Kk9Xh5FRT234WgAZEuryNs1C1FX9ji
 n/JuPwzis8rUJKXoCFu2SGiGJudmLBSWvTqvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738797321; x=1739402121;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=91jTwJ5LG4OO+OBNgpmGsalCxm3ETxCcI8djFnv0ubQ=;
 b=mF7zDSLydZz2vNKWo9f9gkZvIgHgZTna3cyc1lRMLCmQyrihrCjBGKX/07qeqyYmx+
 ffynqZnnaCP6ETHCnM0OK7LAsjICF71bkpSr2BN+QSvhL7e57ZxBKAZ4YeLECvGAYEck
 gVW7PDVuKE4kx/I1LOghKKEuXAOGWnj9njyCPPvXBsst8iaafVdKx0p8pWYBFIxv+tn8
 6NwszrVN55TcljbTSczEFDDJp46asAraR/ASsumXfOmoK2kDF7lPCd1r/QIhf/tyYo8c
 LLyeyz0k+LcZydJuxyD4shEU9pa8yf8K2hNJger06B54n/88eT5Xf/9+1uLxFwf7DTzm
 V3zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO/Z1Vk2nCEg4YLwuo6oZ+Lclcypzf6K5Cytldtn2pw4J8ZcW2vupGrbptQdqpG+yJf0GIZ4Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5spAd1JBXXw4aewB1b8IjWehKZ3ZQzvjghl+gUcUUETYf7R9S
 ZCf1eZ1Yh+NXBtOzJds3dVyiVZU609X5aq0qSwMSm2dgkqYiXUXfiV8S37j3Wpw=
X-Gm-Gg: ASbGnctTtgjJs9Juwpfpiu4+XJYpSMZHTnZ/k3+bAzebqYx9uxv9fd03ujYvpJVJ7p1
 8Rml5lbh8jShJhJoB6Lih7oOQYhG8BYbD6lhd8Azfcm08ZWY8er59dQM3ahygob1EOA/Vn7StFZ
 Qj7pBtwrLRSGH6RO7wFKsP6VLQt83wC/qNn1n0tir8l8U0kmBs+JSdmkaNNUb3gm4M7/AA+uDj7
 hphU8vggJNtn8a/HA3EmxExHkBXD08g5iyPn7PoqIVWyqcznKrCAMLBKlzuVIRsZX4C7tjUkFF+
 uKp1IyjyVh0v7Q==
X-Google-Smtp-Source: AGHT+IFt6fxwdQY7TQR4nV3mLP/TENkGXjB415z/cevhJ3QU/Rt8BgCDIGPNpl7SmKfPgFeg8xiM6Q==
X-Received: by 2002:a17:90b:35c9:b0:2ee:90a1:5d42 with SMTP id
 98e67ed59e1d1-2f9e06a04d6mr9300809a91.0.1738797321269; 
 Wed, 05 Feb 2025 15:15:21 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9bf6f26e5sm2622901a91.0.2025.02.05.15.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 15:15:20 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: 1425075683@qq.com
Cc: Caleb Connolly <caleb.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
In-Reply-To: <tencent_607C0C7A7607E3D8AC82FF80743097266109@qq.com>
References: <tencent_607C0C7A7607E3D8AC82FF80743097266109@qq.com>
Subject: Re: [PATCH] armv7m: kconfig adds the NVIC option and masks the GIC
 option when NVIC is selected
Message-Id: <173879731945.2019786.50662508175709202.b4-ty@konsulko.com>
Date: Wed, 05 Feb 2025 17:15:19 -0600
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

On Tue, 28 Jan 2025 21:22:15 +0800, 1425075683@qq.com wrote:

> ARMv7-M architecture uses NVIC instead of GIC.
> NVIC is an interrupt controller specially designed for
> ARM Cortex-M series processors.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


