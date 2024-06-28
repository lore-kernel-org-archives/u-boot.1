Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B297BC2BBCA
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 10:05:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 358FE88254;
	Fri, 28 Jun 2024 12:05:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gLSI+czZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69BC58825E; Fri, 28 Jun 2024 12:05:20 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EE0788254
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 12:05:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2c9357a2647so24919a91.0
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 03:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719569116; x=1720173916; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QZFy0RQHHAZqtONjaHgivIUom//BmM9TvqTe6YrQRN8=;
 b=gLSI+czZa8KS9+B2IeJ3PSrrebyaXFFf1hgknpqubruxD6Hm+amkdK60xLTh62WuNu
 fS5+Dz7hOjcgRMRfVqOD/ior+9nEWrCHfRaIX1hExOSGU4ch+rrPYgCiyqLxygiQh/fx
 zgUqmzvuPaHxk5KUXIaivYKz/PAfpqYP54gsXNOKwA9PFb1/cFEZsAirNiJqUBNO4mRm
 JtMGCnw/DIHMgOLsRi2jelHwqm0IddUdqXnPkqTIzfja58edbwAPrbb2oIYoyiTvBFBx
 NFFJq5xmOG8iIW2oMcvtAc8CfM2Q0LOnncQK/gbbNIfM0oqpLH/vztWW1kYAmjzVfe+Q
 4AeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719569116; x=1720173916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QZFy0RQHHAZqtONjaHgivIUom//BmM9TvqTe6YrQRN8=;
 b=q7b5sjnAPupZscZ602xBOVY3SSJRQolOa9Iv4IjpC0jSs7+0DCM5iP74+cEhxD9XUl
 ezSdbwxTPP+1govzATaHn1n4PGH4F0HXp0FjRuCRUn9BuRD3QehUlS4t35bffPW3IFB+
 Ciag/RxecHJJx9DQ0TGtcdYlGm14HBBjwM5D439VhEwguT+I13O4nx+J3uA9SJ4MOtA/
 mwFZVyh5fgkWWOhhj0kGeeowarcRgrJqzbAa1YB+cAvWSikGi3H8Ok+UPqv42JsZxEeO
 eoovkdMQl80WcxVtcDdF4UPnWZHDxsI7TtmuzeN4UWSSw6htfv8RjaiffQWRJ3cg/VsH
 uhEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV81PlGC+dFdHxp9AWGNiL+w8UG3biiaKZpMKKQScqBRXfU5JR3hIdzFXVrNxaajAzKUEesBOlqEEhMeaLfJrCV8HBnjA==
X-Gm-Message-State: AOJu0YyJz4lRRWGoRUgu98EssIbAvrMy6ODQF33D25O8BQPlBvwfYpgU
 /XgsFimfV5XlvPR4KHTK82QgT1H3cp69FGO7itanPJQAkv2NKhPSkPKCuM4/CBxx4+M8vyNYxxA
 b9Rj338r5/RXGWzvp3hzqXT/aQhiab7NmjzM6hQ==
X-Google-Smtp-Source: AGHT+IF11PxvO5eAOTSMI1bs4u38al6yb6NCRp4nQm7XJ7kuXyJ5d7T+8M+ldPoWT62a+4YLppCID5S4pyigbOjPnTs=
X-Received: by 2002:a17:90a:4cc3:b0:2c7:c7e6:eb89 with SMTP id
 98e67ed59e1d1-2c861430cdfmr14927159a91.23.1719569115871; Fri, 28 Jun 2024
 03:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240527-b4-clk-stub-v2-0-29013855e343@linaro.org>
In-Reply-To: <20240527-b4-clk-stub-v2-0-29013855e343@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Jun 2024 13:04:39 +0300
Message-ID: <CAC_iWj+J3TO2g+Po4Oc3tOoWV=fU46WA9iS9JSNKKVY3xHzQyg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] clk: add a stub clock driver
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
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

On Mon, 27 May 2024 at 20:12, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> As U-Boot works to align itself with upstream devicetrees, there are
> some common issues we start to run into, that of hardware blocks which
> might be important for an OS like Linux, but which aren't useful in
> U-Boot.
>
> For example, the Resource Power Manager found on Qualcomm platforms
> includes clock controllers and power domains which are only useful for
> managing power consumption and enabling low power states.
>
> As this is not at all relevant for U-Boot, we can safely ignore these
> devices, but we don't have a good way to communicate that to U-Boot.
>
> As an initial step, implement a "stub" clock driver which can be bound
> to these devices so that drivers will work as expected. Make the
> Qualcomm SM6115 RPMCC the first user of this, and enable the driver for
> Qualcomm platforms.
>
> To: Tom Rini <trini@konsulko.com>
> To: Lukasz Majewski <lukma@denx.de>
> To: Sean Anderson <seanga2@gmail.com>
> To: Caleb Connolly <caleb.connolly@linaro.org>
> To: Neil Armstrong <neil.armstrong@linaro.org>
> To: Sumit Garg <sumit.garg@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: u-boot@lists.denx.de
> Cc: u-boot-qcom@groups.io
>
> Changes in v2:
> - Take the other discussed approach of just implementing a stub driver.
> - Link to v1: https://lore.kernel.org/r/20240410-b4-stub-drivers-v1-0-6935bd2c07d1@linaro.org
>
> ---
> Caleb Connolly (2):
>       clk: add stub clock driver
>       qcom_defconfig: enable stub clock
>
>  configs/qcom_defconfig |  1 +
>  drivers/clk/Kconfig    |  7 ++++++
>  drivers/clk/Makefile   |  1 +
>  drivers/clk/clk-stub.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 72 insertions(+)
> ---
> change-id: 20240527-b4-clk-stub-9698797a65ef
> base-commit: 7e52d6ccfb76e2afc2d183b357abe2a2e2f948cf
>
> // Caleb (they/them)
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
