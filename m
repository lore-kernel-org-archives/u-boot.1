Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4FACAC5A8
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 18:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0BC582AE1;
	Sat, 20 Sep 2025 20:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uqWPCIeG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F88A8317B; Sat, 20 Sep 2025 20:05:47 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D58F802C1
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 20:05:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-32ac35837cfso1127617fac.3
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 11:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758391544; x=1758996344; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XbGMPbdWmTb4mDjsnfODMSbJvycs31wXTyXeOetwnFA=;
 b=uqWPCIeGtN5bsWQv5f4YpxWIDf5d7hGoLO3l8KA1+gSFysh69CWig92/2Q1X587Eey
 i5Ymw+j3jiEhTZZaY0iINOAxY6lhMVWskuPWppXAmdo/3cKmAjsMcm8AAzd5Y0KaL+lX
 uBF/BCf2Va36K0P65lKz/8liKfdBh43rM0x88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758391544; x=1758996344;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XbGMPbdWmTb4mDjsnfODMSbJvycs31wXTyXeOetwnFA=;
 b=ocVBaw0aAZlo9VuVCbi4Y1aLOU/pSmqvjDOgmWtmtB6hCsFmewitnlAAd/ZOlr6XO5
 sbXTeZn1fMItmcVrDxhKF4r8qkw3AisqcHXA+lF4jJbkAeoEcc/k55r/cDVfwHCdIBTC
 x3mOWR94nqcAcyrTcslaGxpfMU0nkGtPEwZ0+gHEpF7C3lcyW0Oa1cx89xrId6YgVC6j
 KEU2tZdSxe/VlBGr+9drgIIVBiUlTko9KJw/3UhHXs06u61J94aJnKKpc6h+uGNPhL6Z
 yqdz8O+C7fWKxA5nsz3YnGmvh3JfGyh0yyy1eOWqgCjL1PZXpQk0ID5vT+JliM0Z4Ef5
 BQ0A==
X-Gm-Message-State: AOJu0YzO1bArKssKcQsR99yAcy0TP12iUAo+fms0su/dSkbpmRyCY7/b
 kMjAGzEBMSo4STvxFUrUEqXPYX36hUWUe/yLSYbdw9RkIXlkZH8A/aJUP4BGG5ALHQ41MTFOlAl
 ZVa/8Iv0=
X-Gm-Gg: ASbGncvALMi9AdlnBBWca63pfo7uvfryXNCu6xD324i5pZ04EVOTrvuuIsqxnd6MOJ7
 Awm4PWtpf/QmTk1cmmkdVBAc6zNUfvlX5jwJ8wa6rlcczhT1PnzN4hyzN3A6xOxAyealqkpDIP5
 i7a4YcbeQRA+XYaHBfdPJv9oLaRIc8yEWqpKsqbkqO3cXQxt66U0kPjX4fjyrxeZR10Y2ppieRT
 1q6NwKJ2SEw/C21s5ppnVKNDl+bsMf7leNAhIV8XRcnnvprjUaaQmXw7yaidn/T3A82Xd5vI82R
 3wkOQ6hci9YEMhaQyB4QjQG6kykp9kCuHrBsy+DuYFWa7FU4dP1zD2eFLeZvO7jNrI85GOwDs/6
 5szSOOTUsHIpob+CIBRWcxduxPKqKi+s5EALeZiGg2RYRldMbzGdVdaU=
X-Google-Smtp-Source: AGHT+IGXr0jOHKOcZiMk5tgCUV+OmgViILxMxBC+MkGfB/fXdHEVHJPjJSCvQ3viuHF1QF3ACEYRag==
X-Received: by 2002:a05:6871:342a:b0:315:b527:eac5 with SMTP id
 586e51a60fabf-33bb3aba0cemr3378006fac.8.1758391543797; 
 Sat, 20 Sep 2025 11:05:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-336e3afa775sm5035470fac.7.2025.09.20.11.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 11:05:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
In-Reply-To: <20250910092501.279817-1-hayashi.kunihiko@socionext.com>
References: <20250910092501.279817-1-hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH] ARM: Remove mistyped GICV3 definition from ARCH_SYNQUACER
Message-Id: <175839154298.1382003.2818808749801983071.b4-ty@konsulko.com>
Date: Sat, 20 Sep 2025 12:05:42 -0600
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

On Wed, 10 Sep 2025 18:25:01 +0900, Kunihiko Hayashi wrote:

> The config "GIC_V3" seems to be typo, and currently "GICV3" remains
> disabled. This should be removed until needed.
> 
> 

Applied to u-boot/master, thanks!

[1/1] ARM: Remove mistyped GICV3 definition from ARCH_SYNQUACER
      commit: d33b21b7e261691e8d6613a24cc9b0ececba3b01
-- 
Tom


