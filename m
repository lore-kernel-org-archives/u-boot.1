Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1970FD4F3F
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 20:45:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FA0084088;
	Tue, 10 Mar 2026 21:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FAh/PpWg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72A9183F9B; Tue, 10 Mar 2026 21:45:30 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B4BC83FA6
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 21:45:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4645dde00a7so291142b6e.1
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 13:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773175527; x=1773780327; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZTgooiUEOk9ZTR4BNsaTu7wnl0eDAtyLg4DrDD23SOE=;
 b=FAh/PpWga47S0RTsEVw6d4MJQWNfNHPirg1dSL7+UZwT66Uy8TSEX3LuX8AtssJzeV
 4aCSLASuVfA6pHS1/RDQKAEBl40ocTZSKf3705BMp3Sgr4oPQDhzraIIcmdp1yvsp9oQ
 LgA4XAGyhhc5Sryl/SFQ72XVlIl/xspZ/0HMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773175527; x=1773780327;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZTgooiUEOk9ZTR4BNsaTu7wnl0eDAtyLg4DrDD23SOE=;
 b=BTFgf2wqpxBIWdrL/CarZFBSoNtWre0WqzA5VFIGM9zILMG6dGI58pjB79DzNWBReQ
 Pdk2pzf20NxXZVxm72Ag+PgzTqAcNsnWGOC5q/nZVCywpc4wdJU8iKGhvSLzy/IVhQ4s
 P/LLFmTUY41Ye8Hvjd4cqBoR9wx2H2BuNrQkGKlkNuiqMdeeu6RPYE2vWaYwOP3uW2JI
 bPH4uje1GDWochGJmBNxxtis2qy3q26vagEK5MPXtOzZvcE+td5CdYDPFPWNeJOH+SiQ
 h4OVn3k5liQNN3LOjxe/iILg7pDIJLvx/+W12XhINHEpD3HaRriHtbJU4NEE47sumLaD
 qnCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvAvV4BheARUJqEW4sK8Cz5pzT55R0HEvlXTVNnqkVJaaMWlOSlQeNAIjkN5KIh5CrXJkLShQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwaTlJmhAfVVBHalw5vJYuSauUlspb0PIFyEhpxLPJfNDyVNOwC
 Abu6oa8Fh+zugx0Ebv7Y8p/QnLYGMMKGkj7nziPtyHfaZzmd3C68r3B6MhyZEgnsh9M=
X-Gm-Gg: ATEYQzwBJusLCL/mr23uFQQa6PVveP7euE+zBUNAyDDwASOrmqwM/cYAgFRSy1xQb1n
 oHsUkndmhB1oHoL16FEMFy91zMUdsYSUn9EeCqMUI3JPXLi0Lq3s9O5QZNVpE70hqWIrWA4FFGu
 7tZ7DjQ9Kpk8tohFWI37FyM/iTUWeEaHqfMM5ydLHgAnQhonbHmOerS+NR6JoZynnwbNFS+n5lX
 AfYdOwYDtzLAENS5i0uXA1nJLcurIcgAiI8gKRm3BUlp7ElVB7crUK5gWCkjMb5EZP6dQlXxiNm
 IbqzJcvp5iG+X3LKxVZnv9+XMmNu8oCXUvg154hlTj24rpdOu7BKNonVtm0eEZbz8y4wnv7Ikzq
 DMtjGU4zUbLaiMPQ9BWdoggKMjhaf0VaTWdClAmGnYF2xSkZoZ1Xovav5hEIozSHVvUYbS2gD+j
 nbim7dzt51DEIumbDyOZ2gczgFAFPS6BrXogWnsrv7jfqhB5usfnymoZe4yOxFS1n9By7wvuvUU
 NijxobMcgD5ZctaD08RDg63K/XwW+cHMnGq31bQwhNq
X-Received: by 2002:a05:6808:4f54:b0:462:e390:cf3f with SMTP id
 5614622812f47-46733567679mr41596b6e.28.1773175526906; 
 Tue, 10 Mar 2026 13:45:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466dfac3acfsm8256086b6e.16.2026.03.10.13.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 13:45:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: adsp-linux@analog.com, u-boot@lists.denx.de
In-Reply-To: <20260225061951.46329-1-heinrich.schuchardt@canonical.com>
References: <20260225061951.46329-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] arm/mach-sc5xx: don't select non-existent
 GIC_600_CLEAR_RDPD
Message-Id: <177317552603.23044.8701003867940949435.b4-ty@konsulko.com>
Date: Tue, 10 Mar 2026 14:45:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Wed, 25 Feb 2026 07:19:51 +0100, Heinrich Schuchardt wrote:

> The symbol CONFIG_GIC_600_CLEAR_RDPD does not exist.
> Don't select it.
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm/mach-sc5xx: don't select non-existent GIC_600_CLEAR_RDPD
      commit: a98c640845626f42234abfd0c0af68a28b39199f
-- 
Tom


