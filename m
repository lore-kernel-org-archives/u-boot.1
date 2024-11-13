Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C01D462A8
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 14:13:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51F5789001;
	Wed, 13 Nov 2024 15:13:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ba1WaWs6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70F688936F; Wed, 13 Nov 2024 15:13:37 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61B9888EE0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 15:13:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cbf340fccaso6447016d6.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 06:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731507214; x=1732112014; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TIYfSDWjnP4EXeiXJwTP0Q63dTvyr5t469+FNeWDp/4=;
 b=Ba1WaWs6M8ZvOz3AfuGRVWDX0ymceCStwogbpf5fhPtAaD6jYdvod77Tmq/wXG0Jtl
 IWSa3lT/iAoqgCzyR4fn3CMM4bG0Ok6HycVvJAv12bsoupru47svIRkIPKB5XP/kq0G1
 FptaJLKHGXzpLf+z6YuNeAbfAjwK2foWIQKX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731507214; x=1732112014;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TIYfSDWjnP4EXeiXJwTP0Q63dTvyr5t469+FNeWDp/4=;
 b=MNOwxxhm7ybIQJCj/RnsO3hAX2GGSial1lDIQxwiylgp1gQ3Rt4XsXc/ZXS66hqhV4
 FSOZK9cImHVffauNyqB2ldN3UuOLr5TMG55ypLYgJDGCzYu+IutZk/1Q2Dm1p9V7P9WU
 WhSoWeIJa7ILld0/646NL9cIrFh3PzxqOOlUGHJidFIu1T8m4w1MYyslCSWiwAZXsqTg
 ODYNCvGutgfCDw4ydcT2s2X/WuDOwmLm58KwKSwEzb8cCo/fc5SIRzFuI9Ey+Gsa6ZAD
 VP6zXpvq52PBjQs9Ubne5nHBnVLDMmSeva2+U1G7bq56WIg9MpbV73XKl0uPjX1Lu+wQ
 YgqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWULUeX0AZ2uzvxrcVMCjnFoVHo7P93vKA8qQ/0O4meJBwp1ypxtnqZGZqxs1G+lRlVba+7tO4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/txuosGaiIo7uIFKi1zYdLXsYCjY8hesznEkRPEs7JfuJ7YRI
 v8wHIWWB7Pc9MMpXdOWYDNxuOeNpT9/FXHAh3EH/Jc64Lwr0ZXr4sbdh8t9TNEE=
X-Google-Smtp-Source: AGHT+IEfIwDEY/6G5hfA/LXCSQcCsN2ecWbDGGP/eakh0HwDFxYnrP3gjUDR9oTm9rbT2jjSqV8dCg==
X-Received: by 2002:a05:6214:3d0d:b0:6cc:255:2038 with SMTP id
 6a1803df08f44-6d39e4d24a3mr355978066d6.4.1731507214304; 
 Wed, 13 Nov 2024 06:13:34 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d396208436sm84270956d6.56.2024.11.13.06.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 06:13:33 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: jerome.forissier@linaro.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Anton.Antonov@arm.com, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Wei Ming Chen <jj251510319013@gmail.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 u-boot@lists.denx.de
In-Reply-To: <20241110083017.367565-1-ilias.apalodimas@linaro.org>
References: <20241110083017.367565-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v3 0/6]
Message-Id: <173150721183.1102530.13360087435467720310.b4-ty@konsulko.com>
Date: Wed, 13 Nov 2024 08:13:31 -0600
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

On Sun, 10 Nov 2024 10:28:36 +0200, Ilias Apalodimas wrote:

> This is a respin of [1] adding https support to wget. In short
> 
> patch#1 enables the crypto algorithms we need in mbedTLS
> patches#2, #3 enable anf fix the lwIP part we need
> patch#4 is adding https:// parsing support in our wget
> patch#5 is making https:// the default for QEMU lwip defconfig so
> people can easily test
> and finaly patch#6 updates our documentation
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


