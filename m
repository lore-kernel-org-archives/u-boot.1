Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785C2C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 15:14:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 053AD80AE3;
	Wed, 26 Aug 2026 15:14:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1nOZdyx1Hssn; Wed, 26 Aug 2026 15:14:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787757282;
	bh=8hfGwRjKu1hzfvmkjWWwhSTD62Rxi3cOCwZBD9Ru7PI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=af7fQFVC4g0O39NCSnuze/mqFOaIOIv8qOhKBmlTIJGw4NdnaEd5Pxv5XCA2jkehk
	 /Fy1Zq3mcow7jLifNDsQAp23Q67Dkchbz8ft7U+AXvXxVFxvoLMdO3clBUJp8vXCO8
	 cogVL/D4wIz24Lw1WzRHK+jKK1JRyOGjl6TzfmVbbK75yeSc2uI10PndEm11yK7m1b
	 Aw1uAVfW6CAcUEsNB/6JD+c7Eqiib/NH3Ybtxr3+XmcAfn87I2N4YeHqPYGpVp8jNR
	 flpqDIx7EkSTWuOWWtjW9ZhcYcPdFQGNcZxRSn2Fwed9xenZAEliia4rMIdHhSeSOw
	 CWhcupZy33fYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF05380AC5;
	Wed, 26 Aug 2026 15:14:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1420F118
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 15:14:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 061736062B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 15:14:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a86i6mF98xPY for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 15:14:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nf645Mra
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4F194605F4
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 15:14:39 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4b28d965adcso826965b6e.0
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 08:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787757278; x=1788362078;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8hfGwRjKu1hzfvmkjWWwhSTD62Rxi3cOCwZBD9Ru7PI=;
 b=nf645MraaEl5isO08eT2wBmsoD7dbhk5gun21yNZ/W5VymV+94mrwaifly+SKKUWOS
 BpU4hPkLc3JHrAHv+t5bimx74Ip/pxRP0r9M7tTZjrq08OXfF/q+Xj+L1u2RKjFUGt8t
 OjqFgI1zXCgi0Wo/hoHzIITd4QGmgL4jDMfE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787757278; x=1788362078;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8hfGwRjKu1hzfvmkjWWwhSTD62Rxi3cOCwZBD9Ru7PI=;
 b=L1oTHLpuWTAvFDb8vVUPgaABNNyR0MUWaD0sBkCrTa7dveL3upXakbhW2ymfKxb0MZ
 K4/VEkCl790svL9TETb+Cl0OT7EoYNKA1PNIrY7TPZReRhMyV60LDPM2xDPaeUEhZoc9
 uPdNz49+T1m/qf2OYIEngdeQFb0TX+BemX1S/C/Y2L8Q/zRnSSfFNC32vJg2SKdhLplD
 3S8zmUtq61Ms8yap9rSIvr6XMfFS+e+gp9S75cI3ugSjKsJjb5J7clRFtiRJcPuwYSsR
 hye8FGNEKmdfruNVeb5L3gb9EQqJlR/z02FK+VcU9DSKNejHVvWUrEtfmgfkMU3novY+
 uaUA==
X-Gm-Message-State: AFuF++kRAvD1yt+qZImsqmAY0N1JxMqVC3dMrRfN/IL8eLMeNweHMA80
 PpFSLCcYk2h+uRd+IdQdb1IM17HgdkxEnm/sFWTQXsXOhw/hTfvsL6VycMWXFoQZHixz9DFneO8
 FgSk7WaSQhzkH
X-Gm-Gg: AR+sD13wH/C/BlwNaLcXW/Nq1q9JqYXSoSlsSfzXjsODESrGZ3J5g0NngbpeImHZoCh
 W8nrOZNTpiLLXCIqoSdVC5FnqgtcBgwpExGv0jz/Q+C0FriwD3Rl5BvaK/jzGD2KhJiHuDlt3LE
 uEO4bcoezeCaLahYhOHF04MaaUDzVTK+BQ4YKag9fLTOo8wsqvNxKXHAiJ3OOxocmzsW82RFFy7
 haJ1vW7el2OvYXXXiGlxJhShwwEzqstm1uKILBUYUtp35KCqEkBvvzUv8n7AlPCawU0CqSwBiMf
 mIc8K6ejk8ZBTZsYQo3UKO2Y5O+T8XTBHbbp0og0NY7qVxHHWpnaY4JlMZRqSmwNfdLL9OC9EIW
 k10JxYO1wzdf0GfOQzsfOnRs2veaiJngBSU3fASk1POnVOtvs/V7NpibmIVPWyR+08mst+YZGbz
 prrNQ9pl/sCqanYiSOW42BySkBW5QxsAUkVFjXZfeZ9DpVqKT4J4RmBGiL0CgR4kB3kDvGtFNLN
 ZN8p8O4qf7yTpU0KTEIBWaH4DntLdk7E/nt84EOWWWQqgtLE2cMpL1PofZA5h7cWIeOd8K+YwNp
 RyvvrgPvwA==
X-Received: by 2002:a05:6808:2383:b0:486:45c7:34c5 with SMTP id
 5614622812f47-4b366b29476mr7289121b6e.17.1787757278433; 
 Wed, 26 Aug 2026 08:14:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b36a7ae550sm1868247b6e.6.2026.08.26.08.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 08:14:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 James Hilliard <james.hilliard1@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 Ludwig Nussel <ludwig.nussel@siemens.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Randolph Sapp <rs@ti.com>, 
 Anton Ivanov <anton@binarly.io>
In-Reply-To: <20260810234318.119255-1-james.hilliard1@gmail.com>
References: <20260810234318.119255-1-james.hilliard1@gmail.com>
Subject: Re: [PATCH v3] tools: fit: sign all config image references
Message-Id: <178775727736.3915256.8569589479578865001.b4-ty@konsulko.com>
Date: Wed, 26 Aug 2026 09:14:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Mon, 10 Aug 2026 17:43:07 -0600, James Hilliard wrote:

> Target-side configuration verification builds the signed-region list from
> every image-reference property in the selected configuration. Host-side
> signing still uses either the signature node sign-images property or the
> legacy kernel/fdt/script default list.
> 
> This lets mkimage generate configuration signatures which U-Boot cannot
> verify when the configuration references other image types, such as
> firmware, loadables or ramdisk entries. It also lets the host and target
> disagree when sign-images names only a subset of the configuration images.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] tools: fit: sign all config image references
      commit: f252d228be2b2d180737ad0a851f91749273cbd9
-- 
Tom


