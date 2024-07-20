Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D2BC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 17:10:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 996538883F;
	Sat, 20 Jul 2024 19:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bJUCDRnh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79973887F3; Sat, 20 Jul 2024 19:10:15 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60E8C887FD
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 19:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7044c085338so1587172a34.2
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 10:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721495412; x=1722100212; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7qmmVmfhXISqGxpEqF1TKuTu7HMKTNl589hEpUWJcxE=;
 b=bJUCDRnh2et/ua87ADd7J7WClToyM35xjzXnN8KQakeHXxFilMyv3Y02u/Ab1bSC/q
 /QZKOjuoH5oSpNyvzsyKZJdXf0mgx32QI0Y3kP3cJfCpl6xMLOUcWLP9p88wMKEFWq3f
 bqQvg+mU0gcrMdYhu/EveyW0Nuy+Mc9n0BEwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721495412; x=1722100212;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7qmmVmfhXISqGxpEqF1TKuTu7HMKTNl589hEpUWJcxE=;
 b=Z//+Hm7NsnSbIHsZVGPCtfgbNh7BTFYIxVK4eZlTALNQ2fxJnyePfxqAPgKhZjl4yA
 1N0Ztk6/RZtlzDm1Iqv96Tv+9aO3mv66hrsIEyWG5RVsH0Taex3oe10gaUbgC8VUHJaf
 dGjkkG6LRFIxbu9GE4F8o+l5JcUyC2I8jBJGlskw0mSFbm8UGAjxn04MvN2Hr86TBDcM
 vy1YhLBQuJqoPo8bI+dYRW0wp9nAkVAE36vHv8vmLnsrJ3r7uNPp8msaJ/w+zaKQal92
 dzXXuqjd6ssYTeyasTYWu6YFezWn9ZHpaHwXgn3aF9QM8qiu12Wxtk0QTmy1l/6+l5Wr
 +QnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVGuPZdE3C2qwbKu/zioXx96PkdZCRBd5k905ICzgSfS7xnyqwm8jJRARD6I0UWbxgMS9I4fBkveblG7EeWQN2EZGwew==
X-Gm-Message-State: AOJu0Yw8d5kQYi/AivRa714SGXjJkWIhpzTB2OaomOZGMdiVFKR2RpB8
 3xnCnMiFd3FrI/90VHN7Ow6JtXCJkju37DKCkUGmbH0JpQ/ARbai7pfDwgAPN04=
X-Google-Smtp-Source: AGHT+IEF196w2qetQ1ocZLbWEy2Rcrnq5kq4FbKjpzegJpWLyflzqvpAAenmil9Q7Y1fHj9w5nWcrg==
X-Received: by 2002:a05:6830:3c05:b0:703:6b2a:2af9 with SMTP id
 46e09a7af769-70900908d13mr3078502a34.10.1721495412233; 
 Sat, 20 Jul 2024 10:10:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f6189bd5sm773037a34.65.2024.07.20.10.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 10:10:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 William Zhang <william.zhang@broadcom.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20240715131950.180562-1-heinrich.schuchardt@canonical.com>
References: <20240715131950.180562-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] drivers/mtd/nvmxip: nvmxip.h is a global include
Message-Id: <172149541087.3268377.14129415590231939428.b4-ty@konsulko.com>
Date: Sat, 20 Jul 2024 11:10:10 -0600
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

On Mon, 15 Jul 2024 15:19:50 +0200, Heinrich Schuchardt wrote:

> include/nvmxip.h is a global and not a local include.
> So we should use angle brackets.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


