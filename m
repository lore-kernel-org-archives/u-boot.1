Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33442C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 12:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE3A9801FB;
	Tue, 11 Mar 2025 13:44:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FRRa8XFR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CCFE807D7; Tue, 11 Mar 2025 13:44:42 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66C02801BE
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 13:44:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e6341e4d0b4so4890631276.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 05:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741697078; x=1742301878; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dbe4r4rVBxsAq/npUM2saUCb3+lq0+l4latdxvj34Dc=;
 b=FRRa8XFR13dpKgl7+uOCAsMbm9DJYusY0Tzm57tix7qkdUkpE66bkQMK/3ibbUcHnG
 2Pr+K6sDD4BisZ+4mZUaj8hfXqt32GcI/ALk5HMc3GEMZuh6Xz4+glqlT/EC3oy4JvQM
 kPQIMN73Sy6ycW5LFvNsa47hsuZg7uu5MQeCiGkCpwgo+o/droZnV4icrFTHuFM4/m2a
 be0j7wgcjhRC9t8id17qM3964pw90wbtlyiof9mGwyo2dKDcmlk5NcJcM9TR051FrNoI
 IglmQoTJQfAevMCvxBqrGFb4etPD1hZ5Jr5jkBzdRFjxPg3cOh6RnS9ZNVxZG2EPqLDL
 6LuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697078; x=1742301878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dbe4r4rVBxsAq/npUM2saUCb3+lq0+l4latdxvj34Dc=;
 b=ZtWmEco5YfiK/8ZltPkeb/CvZptdjjZRQzHD2Fqod3ISeJdH16xpIDvcCG59sZDQvk
 5k04cRowLc+5iHluA4yrHbYhBTDxvl089OIJ+CFveLoo25G6oMyv03sfSYXytgY07DJo
 e/dJL8d4iF9MtNxJTqvJDPJYSTxrNlWGqY15xqBJ8AN1tj0yX9llDvWvGKrEqZHDZmL2
 ib6vKMHgqXS8ZBRQrfTTakY+VeCjlrCn9aN39uaEvKBQP3bn+TWG44vf/w5jgvK95Dsf
 zTsXT7XMsuGd2be++RaUbTJYwXLvxzPa54qvS5BTLqPC4mtg7OopOAVfQUulg8ejwC3k
 71xA==
X-Gm-Message-State: AOJu0YzKzIyyf0m89UOFSsF7Ig9xKq1mkSmaltOHQ+60ZYA32gwQvz2k
 /HZTO8wDamyyReVKBQUyh1nW53gBZPNmTNLRY5vvoARjhphfj5/yVlYXpASyG2d9F5e8SAGnYsS
 YLSAQjRbKY0H/9gchtciVpz51vZRR2UJo7fimGQ==
X-Gm-Gg: ASbGncvJVg9IVWH70y+i9lulix2xgyU67KyZGLjw4Fum+jIcAWj7vnv7Kqu0WPv95s/
 8Px6xA0/KJ7DzWzLFNP4CqhnnuuqdwlygXsvuSfaOMmpDspxil5eGVQiRj6CIU5G3EPdiuAQMUS
 wqDsqOqKxy+LEQX6Gx32V+H4gWrXg=
X-Google-Smtp-Source: AGHT+IEfC/dZBvNcMa/ljMRjpPD5pVowUTD+GMKD7fcrrE9yLuBdJrECylIHkE8zPW+X9+3GWXkK6QZSnJF5N1qwJJg=
X-Received: by 2002:a05:6902:480a:b0:e5d:ffca:7062 with SMTP id
 3f1490d57ef6-e63b51641demr4484952276.7.1741697078174; Tue, 11 Mar 2025
 05:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250304152510.2832340-1-jerome.forissier@linaro.org>
 <20250304152510.2832340-15-jerome.forissier@linaro.org>
In-Reply-To: <20250304152510.2832340-15-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Mar 2025 14:44:02 +0200
X-Gm-Features: AQ5f1Jow1togYUECZkY9pjLbuRe9SFN8mjTZvxMrG-xuuGZ2-frFJ82TLDnO3gk
Message-ID: <CAC_iWjL0JO6d2TcaAwVaxorrBjHncGTTyr34uKUa7nm4Zuok2A@mail.gmail.com>
Subject: Re: [PATCH v3 14/14] MAINTAINERS: add UTHREAD
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>
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

On Tue, 4 Mar 2025 at 17:31, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Add myself as the maintainer for the UTHREAD framework, the spawn/wait
> commands and the associated tests.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c1851280e6e..27887bca55d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1800,6 +1800,15 @@ T:       git https://source.denx.de/u-boot/custodians/u-boot-usb.git topic-xhci
>  F:     drivers/usb/host/xhci*
>  F:     include/usb/xhci.h
>
> +UTHREAD
> +M:     Jerome Forissier <jerome.forissier@linaro.org>
> +S:     Maintained
> +F:     lib/uthread.c
> +F:     include/uthread.h
> +F:     test/lib/uthread.c
> +F:     cmd/spawn.c
> +F:     test/cmd/spawn.c
> +
>  UUID testing
>  M:     Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>  S:     Maintained
> --
> 2.43.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
