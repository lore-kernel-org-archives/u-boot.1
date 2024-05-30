Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82688C25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 15:21:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5AD1882F0;
	Thu, 30 May 2024 17:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yrWwgAru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4382886D4; Thu, 30 May 2024 17:21:28 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 926DA87C69
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 17:21:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2c19bba897bso791913a91.2
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 08:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717082485; x=1717687285; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sFW2zerlvkVwumnoR992HES+kWt2gAdix0rNgbeTsFo=;
 b=yrWwgAruGr3cRn95vy+xXxO5/C0qpMM6nQY4oSTAF/xOMCau9CN85TeK88JavWpQqZ
 Y+PdwO6cB+rJ/cyqkDIoWId+Sm0UJWg+ewy5aA1I4l+oIIC2EESBLmf6zpwI3wzGZGBB
 2gMLrTM4N9u1eStVb+HvkXxjck+n+T4reFT1HnFxWJnpFIxG5SDAMmvn3Vc948Eein7/
 Mp22sHjg77QkjN7VtjMBhdz4h2jpYwXSlqKeDMxEP03fRSfvA0Xd70sjiB81ISFojiYr
 T2fHRk+ZmXJQ9CukcMH0CyKu0qLWBd+Z3bAR3KWZYeawTil5y7Ss5EsaPdBGNWdnjyyD
 SzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717082485; x=1717687285;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sFW2zerlvkVwumnoR992HES+kWt2gAdix0rNgbeTsFo=;
 b=uHrbWFOzADl0lww0DdBEqkqwJVd9pk2T5yTqs2+882Y3DjATGMF+UMniEmM1YHxYHc
 qe05G/8sJ5LTN5FIc+vImJ6hFw2AuoBOVNo3eYb5cUKe/UWNez0Wz/5tdGNG923dT+yz
 d8YE8m+V+8WkHkp+fHxyQ8SvbR/rch+AcKr/Qh9eoBP1KD6s2/qIyX8Dmtybu4i0JEP0
 rx3iBmVRkimi/h8FJTmKTDrYSOkCwAWFQpaxg5eazV+geixuj/qiBlfLEFqG6oflz9lX
 ulkNiJnXrXoFI4/3GOTGuXZwdxR/xG7jIldLYa6wo/Aox8wiCTTU6WeHzcZIJiki9el3
 OyaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG/KPY+DEyAd/68yAHBQybKZIjVlAKG2PS1XJ15Ip+bkM0bJaNv0CjVjsPJ0AFdJMbGbp770yM2OCWzClLRWg/BjMidw==
X-Gm-Message-State: AOJu0YxAoVQhzaYEGCwc/DoR6xzRAg2amBhB5oQrOkPmQ2tlFQ/YAmKA
 QS5+j4gZfQTQKIAEWX86uflwXyfKluNZVZVgeY+D3b8QPhVHir2WIjI4I0Gsj2MU1eG8MG0Bmas
 f0rkPUL8TI5goZmx63s2XuNSYpSdWmSN+U0KlXQ==
X-Google-Smtp-Source: AGHT+IHNvEvLbIc/cs7p7EVazXeoSHp+I5mPz+VbO0pMKARx69RT0xfCVul9iQ7ws2U7jx3+bHdwEAXHTOolt/D10qQ=
X-Received: by 2002:a17:90a:a389:b0:2bd:fa57:b361 with SMTP id
 98e67ed59e1d1-2c1abc1c77amr2496857a91.11.1717082485118; Thu, 30 May 2024
 08:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
 <20240529-b4-dynamic-uuid-v2-7-c26f31057bbe@linaro.org>
In-Reply-To: <20240529-b4-dynamic-uuid-v2-7-c26f31057bbe@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 30 May 2024 18:20:48 +0300
Message-ID: <CAC_iWjKnjFeGdCrmeSXWsNHoSrsekH=uGz8e1gWKhAA7Q0vgBA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] test: lib/uuid: add unit tests for dynamic UUIDs
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

[...]

> +static int lib_test_dynamic_uuid(struct unit_test_state *uts)
> +{
> +       int ret, i;
> +
> +       ut_unsilence_console(uts);
> +       static const struct dynamic_uuid_test_data test_data[] = {

You pass this a function ptr, I guess the static is a typo?

> +               {
> +                       .compatible = "sandbox",
> +                       .namespace = SANDBOX_NAMESPACE_UUID,
> +                       .images = {
> +                               u"SANDBOX-UBOOT",
> +                               u"SANDBOX-UBOOT-ENV",
> +                               u"SANDBOX-FIT",
> +                               NULL,
> +                       },

[...]

Cheers
/Ilias
