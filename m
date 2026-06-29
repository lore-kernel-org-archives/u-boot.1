Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1B2C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 21:34:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFCF984AB5;
	Mon, 29 Jun 2026 23:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sNMxDxal";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F6FF849C5; Mon, 29 Jun 2026 23:34:47 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F6A3849C5
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 23:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e9ecb1e13bso154572a34.2
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 14:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782768884; x=1783373684; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FJF7P7sjQEaAm+wKWgAnj4/QAMA0Q5ljS7/2zevGhh0=;
 b=sNMxDxalt2aZP15qCk6n5Tatr5LKqXPooTGkFUIUseNKh8RO1SlD43BFVBD8wr4zKx
 StdAOrcYdkYOGe48hubaZgmSRSwlH9JMu4ZjTxsQn19F5Bxupio8SrkviKg2BQIU8Njj
 SrmcUz5bfQsWFh7bygir746fHL4AW+rwmOs1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782768884; x=1783373684;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FJF7P7sjQEaAm+wKWgAnj4/QAMA0Q5ljS7/2zevGhh0=;
 b=tKb9h6G9KTBlEkemuKHNE2xjQZQKmwKXU51r6XjHbWDpkAG60lMk0I/YjX8Bs4OgnK
 FpyhkXBfB9ix0jgybSB9Zjhdwhc2h1CGFs0o46Rd4p6skj7ntdm6MvKxDLQCDg9IzPVU
 97JbVzI3TsStVm8t86Nf/OSpkIhiJB2B2nWUCEuB+65wMWekFYC8l7CCbF81EY9EaR2t
 6B1LgBqS1fYcyFim2h9aD5eH/k6OBv+RBevPaL/vwvUeWas13qCUXWphFNY/vQSVSylI
 IYjnl7pyB+kA2qKES42FtOwcSOBMmHL2d7Lw6KLud6uB7K3ZJGvAZUNQkWaJksZv56kV
 fkQw==
X-Gm-Message-State: AOJu0YwnVdvyO5bKiz9XodIWy/IVtwSiR0eJwb/063zb3kbLxmQVmhY7
 wfExoD8750xgoYTxi6M976ekYZZ7IM3GlK1JwHV2b5t0ZNvc4BlfMiI7Iiir+Ztiws4=
X-Gm-Gg: AfdE7cmqnELPEAIrMBnRZ+4n/rIIzNF7PzOafiQB32sKJu8zVjVDlGxW/Ogcl6dQqSi
 nzTvaR8t2cFZqNdQwQY1yq5TyfjLZhl3E99ZUKIIBZ4N709AntWT60IWpGjq1X5rxVwPoeciqjC
 MCNswManLGzxnd4UV/7vncCUMBxzklXBXHTcQYyFfEXRtEiehgvUOprbC+AWIEP7AEJuMDoQ+n3
 38emBsMbZnpCz9rCCgbYuBnHak+4xsIawxua96UN+Q0RGju+yeeeOivXjKRlH7K/nmr5mTh6R7H
 jAPK1vTaRV4qglCljxOCOT5VRQiWOpvtAPje+PNc/JYfq+fF8QK7fuio+pQD7QuQCZbSsZVhJyE
 EQ91S7vyPW8e+8Wvj+9xljGEgKRsP25Wevf8lKixVL5rQTzk/ERMJCkrmK6jt/XuwZV/GjqjjRG
 gtFPnnrzAZSiUmMzxMrwpqOfkU5fk+UJaTYjDoTghK/Y8KEmQb0W60EgAqK4/52uC+/OxHKvcRl
 RoITYzwjNvt9sFW6P83X7dgXAHfQTVLfpIBu50=
X-Received: by 2002:a05:6808:3384:b0:495:5799:f4ae with SMTP id
 5614622812f47-495eb2c598bmr1105600b6e.23.1782768884072; 
 Mon, 29 Jun 2026 14:34:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-494c3766f3esm5454697b6e.8.2026.06.29.14.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 14:34:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@nabladev.com>
Cc: Alexander Koch <akoch@initse.com>, David Lechner <dlechner@baylibre.com>, 
 Flaviu Nistor <flaviu.nistor@gmail.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Vignesh R <vigneshr@ti.com>
In-Reply-To: <20260611224856.213757-1-marex@nabladev.com>
References: <20260611224856.213757-1-marex@nabladev.com>
Subject: Re: [PATCH] env: Avoid mixing of environment and driver prints on
 env load
Message-Id: <178276888297.793204.1924348520921336918.b4-ty@konsulko.com>
Date: Mon, 29 Jun 2026 15:34:42 -0600
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

On Fri, 12 Jun 2026 00:48:34 +0200, Marek Vasut wrote:

> The current environment loading code prints a partial string
> "Loading Environment from %s..." and then triggers env driver
> loading function. That env driver loading function may trigger
> further prints, either from the env driver itself or from any
> other driver that gets probed at that time. The result is a
> print which mixed environment loading code prints and driver
> code prints, as follows:
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] env: Avoid mixing of environment and driver prints on env load
      commit: a51f24ac31fbb910afc66824e8299a417b297536
-- 
Tom


