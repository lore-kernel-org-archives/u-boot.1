Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC44CCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 19:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 826238426E;
	Fri, 10 Oct 2025 21:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o6hbNv7r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FA688427F; Fri, 10 Oct 2025 21:23:25 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2650584047
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-64439bef307so705077eaf.3
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 12:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760124202; x=1760729002; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhmLxgQ6gbYSrZyNjdb1nXaelEZJOxITfoSH2W/ZrPU=;
 b=o6hbNv7rWjiUynqr/VkBmivZEYH4jgabzxcH7C522mP5xuzIk6u4TjzmZlzjqzx6xn
 AsuF8H4QXSZdCl7g3GH1JY4f8C6xs6zVv5leCvjz+IPw0jTY7yZjaI+NJ4/x7RZPVmc5
 2iBnHQS3dcePpkj/3BWFtMnILuWYPbWQ+riAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760124202; x=1760729002;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhmLxgQ6gbYSrZyNjdb1nXaelEZJOxITfoSH2W/ZrPU=;
 b=FpMO2l0tgKgs8vm5NhM33KTlBlldjyRuTY+oCFpE0deLOzdvciojXssut1dz81/hKU
 hgIXopavteojgwckmo19lesyAZKuqjSEHvmASRYjHj0IrNaW8DQA2Wod1wBSxUN86eYw
 d3hXxLdBVVu16++YnhFM0smhBWeDil0QOUruq6j0oLwgJu9998DC3vpw/ZSS99nuwtIF
 o72LP3AGfXCgUwqEFiSRjI6+9YDW5OULv+zZF8Tz9svdm/pwhAKtO3nJ4Myafa6i+jO7
 ld/Nir2nPjyPBs79p16DP8iTQ1GPckEZ0gAgG5AzFrkL9goaj+ru06oMr98/uT5Mb/Gq
 vMMw==
X-Gm-Message-State: AOJu0YzDNiUIj3nGxCA14rfA85bnKyrHDb5kSKNPZG4/pfBGuaVq9Rmj
 V6/Cce+thAf/4cf0+hVrG6c1RzIuQC94OMj5XawGVLjHE5RjwoauB7uZ52R5DHO3CWA=
X-Gm-Gg: ASbGncubuuQ+y+ISbRxwrbvG8tn1XEkjqVQz9so9ByUcaM8uqw6FE2386G+MNC3m7lU
 1W1HjfyjK2POd1oitvMF3l6xOjXGu30NP5sWBNatIqJzuCxTofAlQuetVhIUasHc5SF8ov/fWEZ
 iBRwkFN++/0AL6+Dn39ZGE4olbluJcIfYC71IVguVXBnjTGOB+6/e8g5NMi+RJREpH1dM8ELwsB
 KN143L6tQ2kJ3Sc+H+O5S/Dlm6npaxO1CnsRSccmlgaM4ohLD1u6hsamb3iM4dWxMn1JewDDMEx
 G8fUprD2leOW4nGpSIsZ/P8vxGDH6S8tpMofpfzF8sVjPUunjiDhOMj1jF4/mT0Uva7TCKwjSrc
 A0J1Wz8j7e6heViXU9kTsMepinkdqIvWUm0kMOfltjvBmSpUz2oj+CjgjlbTAfrVZWNagbaAb9z
 LWgGQ=
X-Google-Smtp-Source: AGHT+IEF+gYXlN3cBDDT8WUllu+eHaBIVRbwRDaMsEwcLvxDPn0dEj6uq5cQjSIZnk6yN6uCyLSBhw==
X-Received: by 2002:a05:6870:c18f:b0:369:c7ae:6425 with SMTP id
 586e51a60fabf-3c0f81e5e7amr6063450fac.28.1760124201795; 
 Fri, 10 Oct 2025 12:23:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8f581ecsm1155832fac.25.2025.10.10.12.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 12:23:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Durai Manickam KR <durai.manickamkr@microchip.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Ryan Wanner <ryan.wanner@microchip.com>, 
 Mihai Sain <mihai.sain@microchip.com>
In-Reply-To: <20251001203037.2828258-1-trini@konsulko.com>
References: <20251001203037.2828258-1-trini@konsulko.com>
Subject: Re: [PATCH] timer: Tighten dependencies on MCHP_PIT64B_TIMER
Message-Id: <176012420067.1180358.13032814421789469630.b4-ty@konsulko.com>
Date: Fri, 10 Oct 2025 13:23:20 -0600
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

On Wed, 01 Oct 2025 14:30:37 -0600, Tom Rini wrote:

> The MCHP_PIT64B_TIMER driver is not safe to compile on 64bit platforms
> such as allyesconfig on a 64bit host. Tighten the dependencies here to
> the platforms which use it today.
> 
> 

Applied to u-boot/master, thanks!

[1/1] timer: Tighten dependencies on MCHP_PIT64B_TIMER
      commit: 1d34d80881c4bc60a158c31c718abc23b3835423
-- 
Tom


