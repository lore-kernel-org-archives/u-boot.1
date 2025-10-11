Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696CACCA476
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 17:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3571A83A26;
	Sat, 11 Oct 2025 19:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Co80x2oq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A99A83965; Sat, 11 Oct 2025 19:07:29 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4170F8386D
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 19:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-30cce892b7dso1602221fac.1
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 10:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760202446; x=1760807246; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aG817T3KCHOd41RkgBzA3b7aVUNV+W1QC8hpmVgihsw=;
 b=Co80x2oq6o2M9y+v5zGRu8q7oxtIJeXaEohzVvOuqLos/4FBJ4Ax9bYKSpUb676wyc
 wdWhHNZqU61BLcagW5NOnPMjYPy2v7LDVhQGgJOrgqg/GnY1zNLTB2jpYXXdEeBG2nDO
 xht/GOUSm6gxipnA+Z6MSqjCyYqbopUk8D8f8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760202446; x=1760807246;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aG817T3KCHOd41RkgBzA3b7aVUNV+W1QC8hpmVgihsw=;
 b=tt8R8bKWAUFDlvaCt7uLNJtd9iKDa929ZINKHJXn+SJh+iYxaNfdpHolW3NZr2MH8F
 3AHMwXa/KoICpIai2ZopdP7YbgxfC4gdhmzTBW2jEZuXAp7Z3wOKvWvqE3iE7i98E/uB
 t6ygLEVsq7jxdei2n+VnLcX+9jmE/JMd9eEdzhtn1P4Ps8CTpnI/fbzmwJRWKclXEurI
 CFBuVkezzoX/YrUZ3zT6eQ4nxuBHPmrflWSev4viK/i+UHYP7Du31lW01Xa3CTjUweXm
 ccKdwhuVJwmklNLMvKVTVQAi/QFuxxKaxXUiiEQRjH1NIkouRmaKmt99FXVWQs2QUJIA
 6VCQ==
X-Gm-Message-State: AOJu0YxPcrTRK2DmEXJr4Kc9V1NoyBO0lu1cE848m8t2ID9WmG13HoJO
 9J9EpYX7U47gsc3COhc1YDgdjyjDREyw7y4XyiF4bAuKxDBVGem9cVl7+PCDTSgtswYSTO9DIZY
 ssZ9WgaE=
X-Gm-Gg: ASbGncta5IlVYDNQaL+LP7GgmTVro3FbrvZjfDu6ZsvAg3A6qZ//RV5udMNTpHMrCxr
 RPBRQnLXHaHeNoCaMLHwtkDtRgv/cheMybainc+/OrZXNiQ9IscSmeacYVK6sG4OXxEB5/wKL7H
 YxN5QRVubqyUevSvfMXcvVZEAC3AEByj1uKmTjktMyAYnqJF/vEmf5B1A1LqxXGl/S4U5to50qn
 eBsyYiK0m6Dig6awb/GZihRpKhkj3m3TtgVCxfb7EPY5xx1fmBT2kL1n0b0Xy0xFKd7SJqnL7IM
 K2n3V/O4TCcIkMwu09VX/6b0mf8QN+oS6v62opi9jGBSgeoAprLrCVvtVIKxk93kAfepRokJLHc
 yAmE9F7Fzu22/5JVPMbebw0cJIMhrgI2IBHK3J0ev5NJIcA463SK8Hy9GPOiSsRKZGmOPz6Te34
 kMkL+SVY2j8Ov/0w==
X-Google-Smtp-Source: AGHT+IG+a7nAaK78Nt1DNaC+MgrKYQ+S6yYeU8rhTXAKW9sfSoaLA1hp6hZWU4hX0F5+1X0NNqHC5Q==
X-Received: by 2002:a05:6871:1d5:b0:321:2ad1:941a with SMTP id
 586e51a60fabf-3c0fa36c05bmr8010045fac.45.1760202446002; 
 Sat, 11 Oct 2025 10:07:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8adcdfesm1970991fac.1.2025.10.11.10.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 10:07:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251001203052.2828467-1-trini@konsulko.com>
References: <20251001203052.2828467-1-trini@konsulko.com>
Subject: Re: [PATCH] iotrace: Finish migrating this to Kconfig
Message-Id: <176020244523.1312138.16699446304318310685.b4-ty@konsulko.com>
Date: Sat, 11 Oct 2025 11:07:25 -0600
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

On Wed, 01 Oct 2025 14:30:52 -0600, Tom Rini wrote:

> When I migrated this to Kconfig in commit 68e54040ccc3 ("sandbox: Move
> CONFIG_IO_TRACE to Kconfig") I didn't look hard enough for other
> details. As explained in the README, this is valid for ARM too. So start
> by making this be a prompted question and CMD_IOTRACE depend on IO_TRACE
> being enabled.  Next, migrate the information out of README and in to
> the appropriate help text for existing options in Kconfig. Finally, make
> this option be default y on SANDBOX but not selected as it's valid to
> build without it.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] iotrace: Finish migrating this to Kconfig
      commit: 16bbc225fed7931988616ba4e223954ae5ccc06b
-- 
Tom


