Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BEAC52D7F
	for <u-boot@archiver.kernel.org>; Sat, 17 Aug 2024 15:59:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8312F88853;
	Sat, 17 Aug 2024 17:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="guFShe2V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12FF588898; Sat, 17 Aug 2024 17:58:33 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F137B886F9
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 17:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6bf7ba05f75so16685406d6.0
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723910310; x=1724515110; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wJ1El7YF4SHtk0w2qLIBduYAkjM83B0EeEYDCg+ZChE=;
 b=guFShe2VtiD7c+aI6m1YIQeUI00Bem2WZ2g0BR110rKRzUnluhon0RxRNT5SC+CzEF
 LGJB4CRrp6mw/KYAk4WMC4ro5r2tRIOh0Ey+OTR3yxnBqHjQlSWww4/RPM4nP9USLrlU
 NKraP1iENFd5/7+9YypueDPAKx+s3KbAw8DTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723910310; x=1724515110;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wJ1El7YF4SHtk0w2qLIBduYAkjM83B0EeEYDCg+ZChE=;
 b=jlWI+K9Tx29khycpGDt3A6Yx4KskLeFAperTNzmfMCCO2A/0wjGxetxcRFxCPY6iGE
 gLe+ihCgXupdcB7UnZD1QBPfVASd4MMj9XVd4eR2+vgKbu5DLtyXrbrJwkYHzlA+6QHc
 C1WTfUCGVEWhVyAe9bljE0Af+/6Jkl7+XN0fsfwM40njeqxH+fcmqi2YsDMJtNiyOj8/
 IeCINL/PkWLrTT6C7RFOlNR/22M3cLJHadvzlpPdQC5hxeyAkCkFW+DDlXO45cTiR3+C
 eMpPYGOIQADfVyFlRXK9w7IkMMu/H1b34NoBKavwtH665mAVsBEYAOOr8KBNgpH4xuO4
 cUnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUucP348u+ZaRb6ulDjjjK4SLgt0WmszXOIGjvpFqSJjTwj7dOgwLuZBNxZrO6j18CLbA5QHQ8=@lists.denx.de
X-Gm-Message-State: AOJu0YxadtHJf0HJJsBd0t1c3UBOhOu0B9VrZX4fdKYqym5vVaV0k1gy
 b5Bomk9DqfOBPc5HPk2noje0fv3A0H6lmv5Zin5Rko0SoiyReG8pe8ImrMfvIG0/tI3jfFJpnmC
 WzgiFbBGIIkZndSY60p3zZO1fqyPQ7bLMXQH5
X-Google-Smtp-Source: AGHT+IES0Wmsgdkds3rn6ZmIZr/GVrG37HgRq8Yzr8mVwg2O62/I2fsS9MZGcHs1c+NQBMyW+99kwKPIUpYTFh1R8D4=
X-Received: by 2002:a05:6214:4347:b0:6bf:960e:3d9a with SMTP id
 6a1803df08f44-6bf960e460emr12900596d6.12.1723910309931; Sat, 17 Aug 2024
 08:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
 <20240814103145.1347645-3-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240814103145.1347645-3-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 17 Aug 2024 09:58:18 -0600
Message-ID: <CAFLszTiKorxnt4d1UVRyHdtdj17ay1phHv2uLtGd9_K9HuOu9A@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 2/9] net/tcp: fix selective acknowledge
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
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

On Wed, 14 Aug 2024 at 04:32, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> Current code assume that all (except last) packets are of the same size.
> This is definitely wrong. Replace SACK code with a new one, that does
> not rely on this assumption. Also this code uses less memory.
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  net/tcp.c | 200 +++++++++++++++++++++++-------------------------------
>  1 file changed, 86 insertions(+), 114 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Are there no tests for TCP in U-Boot?
