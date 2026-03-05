Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C53BF33A78
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 14:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D831783F93;
	Thu,  5 Mar 2026 15:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RU4mqfwy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8F9B83F2D; Thu,  5 Mar 2026 15:49:47 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C357A83F61
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 15:49:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4648447c899so5044947b6e.0
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 06:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772722184; x=1773326984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WpKUdLKQvbOXJRBnQEgdd5m/xZwrJRJpPheq8vXRbwk=;
 b=RU4mqfwyyM5F0/8j7Ylu0C/BjBbiI61dwp2hTl8EYSGEwo71iB6W/2Ss/FmayRt98U
 pJUNge+Omvc88J5JuupvIGnT4hcbesA5B/y7ZlFCagACVbh7F0ev1tM34w0a803Ghuiv
 x601397pyoYd5w9gh5TQUuMTUWVxMK2L1P+iQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772722184; x=1773326984;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WpKUdLKQvbOXJRBnQEgdd5m/xZwrJRJpPheq8vXRbwk=;
 b=IFAKFN8LiXhzkaB1VhQhjAbZ5jzEdpW6Kj+I7yw6fShoxRQcizN+D994r56BP2kCj2
 iINSadWJK/w87xCB2o2Rl2AaazJPd/cOojxp5KFKIN4DajGGUVt7rBBnugNnP3Uptc9z
 clo/dAZGj0ESR2kuDXsrmtbKQt9cgHkOZimdA1atudg3rYTqfMmBPAEVvWStBuQpv8H7
 mYQSXTLs0iU2R6JY8SXrhXD4WFKCuwUN9O/+iE+q9jmF5rwiKYx1GseuBo1d4FcSdx/N
 bJUpPSSKtuRggY6S1FMqA+ATh3rYj/vRejmbJKQHmDHwq3OK8KtGo5l34KSsHu6CQNRz
 q6fQ==
X-Gm-Message-State: AOJu0YzBvCikmHaRQLH2U1ZsZuPJX0SEaVuL3CkdKhvVzPIyEUfCGuKm
 xB+P9qPjLyBTQDWRNJWTYEJ2Mvlw0VYixLpMzhQSzfT45oqTlEq2ex2/Y5om5Hhn3fkFtUwvMVa
 j6wXc2tw=
X-Gm-Gg: ATEYQzwNQJNwh/o4ubqVlsGQFcJ4qVkxBvdPdE+Qfc/wFxs2En72jjCrC0B/56ozn/K
 8KQlcRYycclZGK+1Jy/hNPlrGUqTsH+ql9GzgTS1UtWPfWX4IQ5riaLi0ymu7MiNSQ4xANyLpKG
 nzyoCHu9xf9Dvn+wFuceeM4UhneoX667PGBUy6uxRlOQN54bwRVsg3escTvoveBx55UvQUSxjoQ
 222/hYmyqz6WvQzVD9r116y2F29em6BRRdeCuxR2aSK+azthBOoE7hBVwcMted1UgkQknuSSkYM
 mqZiJe4nnCIJpoZro2lORzuAVdOQTzVSKlk/HMhn0ERxe+JGlMe2SlZWm9ZGVuIpvv9IfboLFlV
 /ZmZVczwarfs/NRkGrZUTFc8J5+BupnMzNmywBtqVMLlVDxxpaKnWRX2rucY/URSCfR6TE35Jnj
 ggYEuuYVxZ8urkEoX4GKFfh9aDVQ2V+pnAboB9dMicsvSu+GRNB6wqbSKQzVjJUD8+yP6d+G+XC
 ND40BROG99+8BX4v5kf8hk7Imv61Dj8kHKfa/8gGstCwySAmg==
X-Received: by 2002:a05:6808:4f0e:b0:450:4628:e3ce with SMTP id
 5614622812f47-4651ab995dcmr3150740b6e.15.1772722184411; 
 Thu, 05 Mar 2026 06:49:44 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cf2572bsm19246871fac.2.2026.03.05.06.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 06:49:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <d54cb34ded118c72997e68445144e44daab13570.1772157012.git.daniel@makrotopia.org>
References: <d54cb34ded118c72997e68445144e44daab13570.1772157012.git.daniel@makrotopia.org>
Subject: Re: [PATCH v2] tools/atmelimage: add const qualifier to fix
 compiler warning
Message-Id: <177272218385.529370.6025429978032580118.b4-ty@konsulko.com>
Date: Thu, 05 Mar 2026 08:49:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
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

On Fri, 27 Feb 2026 01:50:46 +0000, Daniel Golle wrote:

> More strict checks in GCC 15 expose a new warning:
> tools/atmelimage.c: In function ‘atmel_find_pmecc_parameter_in_token’:
> tools/atmelimage.c:64:31: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
> 64 |                         param = strstr(token, "=");
>    |                               ^
> cc1: all warnings being treated as errors
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] tools/atmelimage: add const qualifier to fix compiler warning
      commit: 35d9b9c70ea4998aebc723273dca123dd1c3953f
-- 
Tom


