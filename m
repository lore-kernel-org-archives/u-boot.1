Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2043CCF9EB
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 17:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A92183923;
	Tue, 28 Oct 2025 18:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mlhGC75v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E6EA83885; Tue, 28 Oct 2025 18:59:12 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AEBB80422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 18:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3d1bc63d5f0so2006570fac.0
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 10:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761674349; x=1762279149; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cOHq+3wzWeQERrGv42T+E255rsQvXIyBAHoRtml2/Hs=;
 b=mlhGC75vR2G0muXAWxUyD5C6M/8TOwMFdNq9WadBja7jDH7pGjjUaBdJFWHZBOPn1Z
 Y7T2ZfaXq+yR3FyTUnNQwzd1mS6xvxMrM1yZnGrBh30qxD+cmNtyaUL6VMfWH41FYPlF
 kh8AgkiZSriXP+G2Oe4Es67KBz0nS9NaWWKyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761674349; x=1762279149;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cOHq+3wzWeQERrGv42T+E255rsQvXIyBAHoRtml2/Hs=;
 b=orebIb+Atkaa77+MEfXfXntRs+EUaf+t24lUk04YSjIAEiGxS7TuBLi5qT4y/xZO97
 3PTwxwn2Z5mNlO/73rvmY63Nnv/YgeBJfA6xK+1pkDcDV4PRCSAxMApbNNl7QnZDmFpR
 SwCd3yrGgibfJZ4Pk+3gX0Jn960m8EzB5HkjeuNBd45u1WoyGsLWNzsVHnD2k9StK8Fq
 RixZ5hP9W4iLgc2niPxA9IzW8edS094ZBE2mZR8Q68JQ2W6IVn14h4+IKyiwJvo3TdGy
 BIENg/qwlCMtgot/GxeJsmw7OfxgycnPQima84BS+RsWwRsJo+dsj39qeO3dhbeLsSSd
 SxQw==
X-Gm-Message-State: AOJu0YxtZysbitaowB5Qu5rstFZv2P1BSM/ig8uX5tD1tcLgnBHM40yE
 vD4xBbOn6UaI41c/I9Lje8Q7jJ+Alr4xEY5SxPubUHMGu/fLa/DWsDpCUd+zYHtVKML1dj0TR4+
 JKwgiAFPK/mCV
X-Gm-Gg: ASbGncv8IYNahoczacqXXVa7niMeMOUuCNHvK7C9xKdnaTAh4jOh9HMq0gvS0d+kyCZ
 +LdWKaf1R8WKtgDUrgPyg2+oh4dcdING/6TP6AbUYUBg6leBQAMHlI8vdpxNcFla0jW5Z6Rv2yd
 DAwbljCQN1P85g3GW0ScY/thR1l/SIJWB9i5d6dT9ucdRfbTZKQ1r6r/Lz6KV4unqI8nuIxvybM
 YCH/MTjWTmezI1gqfj6sZm3pElhEb/GPtY92+VM+SAsbw0tIqa+R6XIevHOHEO//3t47y0jzTak
 z01PCr2ny8Bkzh8pbjRyoSWB+YcrolNynGl/L0v6nTVC2sNnBFombdA99xaVfzQ48VZu1yOqNLM
 eFrGIqBm6Fmlj+Vk2N+XkJgAQGt3eXyu4yRYIlEFKqCBsOR8Np9v5hVN7KkEETY7E6b1slLKbOB
 HavROKooVDO286KWI+/09l6jdyokraGlvBcjTIvg==
X-Google-Smtp-Source: AGHT+IHuIZ0qMgplRFPrZi1EBUDT9ike2u+4UCrWXcmOgePQyRR7YQAL4QVo7Vl7cyovWW7ykIIW2Q==
X-Received: by 2002:a05:6871:7413:b0:3c9:74fb:a719 with SMTP id
 586e51a60fabf-3d74760c448mr118634fac.39.1761674349206; 
 Tue, 28 Oct 2025 10:59:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654ef2e0d33sm2843926eaf.16.2025.10.28.10.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:59:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250725-intel_gpio-v1-1-20a917eb1cf6@linaro.org>
References: <20250725-intel_gpio-v1-1-20a917eb1cf6@linaro.org>
Subject: Re: [PATCH] gpio: intel_gpio: Initialise or0 and or1
Message-Id: <176167434814.2025892.657711348031753001.b4-ty@konsulko.com>
Date: Tue, 28 Oct 2025 11:59:08 -0600
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

On Fri, 25 Jul 2025 13:04:26 +0100, Andrew Goodbody wrote:

> In intel_gpio_set_flags the two variables or0 and or1 may be used
> uninitialised. Correct this by setting initial values in the
> declaration.
> Also there is no need to use '|=' when the initial value is 0 and there
> is only one assignment performed to each variable so just use '='
> instead.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] gpio: intel_gpio: Initialise or0 and or1
      commit: e8fd262fb3e2c2516610fac6389764e0dbfd98d7
-- 
Tom


