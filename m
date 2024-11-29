Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0ACBD6EBE0
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 07:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD6568938D;
	Fri, 29 Nov 2024 08:03:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vbv9k4X4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 782F2893B6; Fri, 29 Nov 2024 08:03:19 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31DBC89376
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 08:03:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3ea49150430so725310b6e.1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 23:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732863796; x=1733468596; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I0c6kXJwsOqQQHpk5JpYWl7O25+9cdBusXKIjBfJNWU=;
 b=vbv9k4X4Moy/GMuW8sEKmqvZBIM7ndddAslrbNdiK93kGVNVQh4HCOXb0tWas/Szb/
 TEZ7YM7ZlzC8AW/8zQGgvNLnbo6pG3Om+v0cK5rsaXSAEaJ+8Dt+MU9mywUXjXOq5V6e
 CMaJWMCgX/atTKUauG42gEAlIqTOnoEdbAEaeZmYKefI4Rof9ok/Wb6gpezIDT4OeAgm
 uDKHvrxwPlOAJmWmKmubcW2Zd6/9SslLpmw7qvZ2qshAGLTElT5WYEbm/ov2kkEDsTct
 Rj9mk2aKIkYV4L4Nx7nBuMumpQE2IeDnWI10mRpiX7Xd8Pclbvc/bV10ZHBD4vlrAdMH
 u17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732863796; x=1733468596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I0c6kXJwsOqQQHpk5JpYWl7O25+9cdBusXKIjBfJNWU=;
 b=tZbVWGrd1T5jpGg0fk2dnlV0l7hOmf03p+dtki4vImrX2J4VXAoF1TwuZgZVX43zKC
 DzEM0Ncf4Y9XIJnX/OiwJVEwvwhZDeiXENVp5C9gYDpiGjtxZ4L6zJdUHf9kjXz0ygm9
 4EyIIg3uwnSb4aTyk6xKvYmzVxcwDVA1/pnaz/nh04Vt7Guz5QL5LHGAXVKAbdNEJjyM
 1ZpT+/drXBJn4mXq0CBT3i/sR/Eb+yFQ1gTuCFvDXpNDYF4kH+6+lIAq7iO5iu8eZf4Q
 S+ANXgCqiZr12/8ssmkRwMsU/JCOsSoIWi+Nq1BDbbz8KGc1CcoGSI64oiEsJq9ySBXl
 SiiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbuKLH1ilv3hkV1CM6VZnyB/UmYYYtSURe7YpFPbUuyOzZEtZ2fIXGcc1vSfPTDci94JgWoc8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+XJFaKCEsvzV7lesTGv9O9pzTRJQEbT2GG8q13WaL28El5QRK
 aK9zAMxguprNJe+67MruwY+qUKdkx8Fi6PDwkK+qkReuDbEfg3M3dXWcjpi2WPxjWPKrgZ5XaQq
 R2/ASUkyPDAo21o62gOk0QK4yjLHMx7l/i/Hz8w==
X-Gm-Gg: ASbGncthoknsb4hzqQZkuoSGbtWWrSJf8BXi6uqyA492Scgm5+x3wNiOVQqhD4FQWFr
 qRNkB7FomQtIQe70j46T4TpRR16BRFHma
X-Google-Smtp-Source: AGHT+IHJAQzhpqW2GTE9zaMr0xirULCmLW7GamBkeipi4ZfZgaxHGMCfYj0/w5hLzswJ/OWaT5hezAFEupBlTjMvdzY=
X-Received: by 2002:a05:6808:138e:b0:3e6:61f0:4797 with SMTP id
 5614622812f47-3ea6dda89e8mr9043659b6e.40.1732863795999; Thu, 28 Nov 2024
 23:03:15 -0800 (PST)
MIME-Version: 1.0
References: <20241119100720.1297067-1-u-kumar1@ti.com>
 <20241123024219.GU3600562@bill-the-cat>
In-Reply-To: <20241123024219.GU3600562@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 29 Nov 2024 12:33:04 +0530
Message-ID: <CAFA6WYM9esX2VwGf91P9ics419OXq48zH_Taq_0xtHT19HmgUQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200: Fix OSPI boot
To: Tom Rini <trini@konsulko.com>
Cc: Udit Kumar <u-kumar1@ti.com>, vigneshr@ti.com, n-francis@ti.com, afd@ti.com,
 u-boot@lists.denx.de, nm@ti.com
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

Hi Tom,

On Sat, 23 Nov 2024 at 08:12, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Nov 19, 2024 at 03:37:20PM +0530, Udit Kumar wrote:
>
> > OSPI boot is broken due to missing bootph property
> > in pin mux of OSPI.
> > So add bootph to fix OSPI boot.
> >
> > Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>
> Applied to u-boot/master, thanks!
>

Please don't merge direct contributions to dts/upstream subtree. It
should rather have been a change via *-u-boot.dtsi or a cherry pick
from dts/upstream subtree. Otherwise, it is very likely it's going to
cause conflicts.

-Sumit

> --
> Tom
