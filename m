Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C867F9D0FB
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 00:40:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E51CC83E36;
	Wed, 15 Apr 2026 02:40:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SVSMV9/a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4604E838BB; Wed, 15 Apr 2026 02:40:10 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FA2983B99
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 02:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-4138136f02eso3875949fac.2
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 17:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776213606; x=1776818406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lgtXENVT7PBC8keyGvAoNJmtzHhHGALcR22ba2Tx3ng=;
 b=SVSMV9/aFYiWI4NcXeJFtKL6CmkSRbEKL0M3zAH4l5iwUbm9X1MoQorfeUfxNxmim1
 ASPbmv/8L58AHpHHlTtkU4dUIu60EHpQ1XuUfudM44SdKAA+8ijNpkdjoz3nxY7zH+TZ
 n0w+BxzZPcu4awUlIkdD45g0aJcvRESu6BeVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776213606; x=1776818406;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lgtXENVT7PBC8keyGvAoNJmtzHhHGALcR22ba2Tx3ng=;
 b=goDLaQzLvGVnR0/mkeUtlj6rSXCtXw82KTD6IqAeMi7anh3r75mPI/rd2q+E+QWF7m
 fOrYqva/4RNyqZnvd3uyS1reV4KkqeW9k9ZuXqBQQlT0X+Q4bL5YW2yeez/6oMhQoVZM
 9DdE/cO2kA6uJ8Dj1dcKi+ribMq9wD/r/Hg4UxZu5+GpIKjLnX0qQBjB+CDYF12BkN0F
 1zihwfxMpIbp5ALbq4utgNMYEzWOeuic8bfYm9E5qIov++Vi/D64Ajyajq/8tgMAPBdm
 fyHN3SpwqgKQ5xc2cWJKkjqng6Uxp5uOthukP4Qm1k4hpmavi6+GQXL2EAqSObO9v7v8
 zFjA==
X-Gm-Message-State: AOJu0YwfbJFmaW3ppSz3/nw8Ve2Hk169h/j9f+aiirYgF3jiNGYO5Cdo
 kCj3Owl4gDg5jp+LOoYE0w2WPq5/9BLMEekcxcxb+Gqp1DPW/tB557sRKx7Md0wvKyM=
X-Gm-Gg: AeBDieu6bdXv9lzjKv0Ky+F2wnaRNXAHP8TJnV+s69EHHiaTAVlgm14Z6RuQ6qEJODX
 lYO99WUiiYs/a8Upx4BU77LO3PU/Ere3ULcBbhRofJNETaoXAbBfeRgp1oJHyLnb2HMOiYyZG6A
 7H6Ze8XKWdpbt+nh3UTKlbfAr1rH+a2ZmAbAjpVKebjZQ5x64G9MzjJzymIEACS2EyEScY0h6x6
 xBe85gW//1o9HZJ8OHb3bn/IEyVIXK+EyBFeIzfTdUl3KlT3NafmD2SF8HSGnAvStDS6qnTxO+L
 x64Oj2wgfKA/UFVye9I0xn5JTPEPtxtIebpymLXkorgBR6jRIyzdmPmokord6bGHKvXbUHAb/Wl
 tE3pKYM4ex/iyBbsJEkEsQQNp2M5gPSXmOKtyR0LL8xYuFxCm+LytWsRESOsFztLeTDuDuPUju5
 7BzK78IiLC1vDGzI0yK996yWiTcN7t7DiE6Vt8gWavALXro+La0Qrsol1aaANATBF498eI5WRPZ
 xugKDtI1xprirbFJe9WmvtsURHltg7+DkEdNWI8PxDE504mTIL5rwUrO4HK
X-Received: by 2002:a05:6871:8908:b0:36e:8381:db00 with SMTP id
 586e51a60fabf-423e0db87cemr12056743fac.9.1776213606289; 
 Tue, 14 Apr 2026 17:40:06 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42666bcb977sm193085fac.6.2026.04.14.17.40.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 17:40:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260225062301.46540-1-heinrich.schuchardt@canonical.com>
References: <20260225062301.46540-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] x86/apollolake: don't select non-existent
 INTEL_PMC
Message-Id: <177621360532.2899116.18430453232771622033.b4-ty@konsulko.com>
Date: Tue, 14 Apr 2026 18:40:05 -0600
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

On Wed, 25 Feb 2026 07:23:01 +0100, Heinrich Schuchardt wrote:

> Symbol CONFIG_INTEL_PMC does not exist.
> Don't select it.
> 
> 

Applied to u-boot/master, thanks!

[1/1] x86/apollolake: don't select non-existent INTEL_PMC
      commit: dc8f56e008744a40718291f94090fd0598cf325a
-- 
Tom


