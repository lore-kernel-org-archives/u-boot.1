Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15D4C3DA63
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 13:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC52E88A9B;
	Thu, 18 Jul 2024 15:41:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KVoYgJ7l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE25E88AA8; Thu, 18 Jul 2024 15:41:41 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8467D88A45
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 15:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-708e75d8d7cso452506a34.3
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 06:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721310098; x=1721914898; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9DlGzWBsUAY+06sWa1N3ooDq8vuysditlk0OQB3RYBY=;
 b=KVoYgJ7lurrGW8Vk1907EVrrwBKZ7aIDDggOU8ZKhj4cWoW+4517sFlj36G06tstPe
 VR1X0Gy4rxki/ynVpwWHaQbA2WDNeHnMqHQ9BRRJLk0StTPkNMxIKTCucGd/xX3QfOBT
 lInsIvecs4raw1dckNITP3aGkrM8e8J937kgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721310098; x=1721914898;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9DlGzWBsUAY+06sWa1N3ooDq8vuysditlk0OQB3RYBY=;
 b=htyjAgFhRjw+JkKvM3Uh8Ock5XlyQZyZjIPhYvaL+zyXAHTeRJma/LX1LUfB92KYk6
 sRT3VTxkGOR72Ulr77D1VYDbGZeV2DKOIHbWjlMNDLFWSxC74YHG8+OYi6sbBC0fAm9o
 2eu6Olj7xKduJ0Vc0vYEQdUPcd87D9k1lietJSB1/SjvmmU6LBcxDxci4LbURn0jhLH3
 xThd3WygKUmEme89lAWT6UjYR4atlQ/tY3+W6yaYo6JXuci7+1LQb08pZPz8wzUtP2IJ
 8VTuC20CllRAwhxK9wl+lzccAZsfX6CELK2OEfFVKqJB7oKuLsHb+nUFOSmM2AYd1j6k
 prow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWugyCHUbVuOhiSIY7Y/KEBzAkFtS3wgQYty0z1I2hfgoQbN3ORfxDOtB/RWVW7FZqw5Lws3pJMm7a2cvm1T0nNcbYrIQ==
X-Gm-Message-State: AOJu0Yy6oIsFcOx7m73sdK6BioXc9697oITNYWL6ZzrbmZmKInvaGMeE
 CNz1LGsezcpvtpzps/HM1v4gseFvV97F8189aGIfLn5+YAQFAnYeqT8SHUUnbq4=
X-Google-Smtp-Source: AGHT+IEOXCgPGftbfXbTmieED7I5NNpOnpSivzyOt+pwWDB0bomq8xCqTRVKlFa5/RcOpNInqPDXkw==
X-Received: by 2002:a05:6871:281:b0:25e:4399:56d0 with SMTP id
 586e51a60fabf-260d92347c8mr4183321fac.33.1721310098328; 
 Thu, 18 Jul 2024 06:41:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-260ee947f82sm355303fac.50.2024.07.18.06.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:41:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, raymond.mao@linaro.org, ilias.apalodimas@linaro.org, 
 bmeng.cn@gmail.com, Levi Yun <yeoreum.yun@arm.com>
Cc: nd@arm.com, u-boot@lists.denx.de
In-Reply-To: <20240710135320.2697805-1-yeoreum.yun@arm.com>
References: <20240710135320.2697805-1-yeoreum.yun@arm.com>
Subject: Re: [PATCH v4] bloblist: fix bloblist convention check.
Message-Id: <172131009747.1834634.7210057244943148257.b4-ty@konsulko.com>
Date: Thu, 18 Jul 2024 07:41:37 -0600
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

On Wed, 10 Jul 2024 14:53:20 +0100, Levi Yun wrote:

> According to recently firmware handsoff spec [1]'s "Register usage at handoff
> boundary", Transfer List's signature value was changed from 0x40_b10b
> (3 bytes) to 4a0f_b10b (4 bytes).
> 
> As updating of TL's signature, register value of x1/r1 should be:
> 
> In aarch32's r1 value should be
>     R1[23:0]: set to the TL signature (4a0f_b10b -> masked range value: 0f_b10b)
>     R1[31:24]: version of the register convention ==  1
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


