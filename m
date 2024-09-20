Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7943CF9C59
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:04:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E3C888CB8;
	Fri, 20 Sep 2024 18:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q0h5OdEB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 388DB88D25; Fri, 20 Sep 2024 18:04:14 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1067688B59
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-718d6ad6050so1638518b3a.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726848250; x=1727453050; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JvJ31T4kkvWCH4DZ/TKblOrOFV00W5K9zqn91mtU8F0=;
 b=Q0h5OdEBDCunNvhsdD4p9fbYBUh546vS+dnBFm1o5m9Kx412uIIXB2DpTQRnk0f8Ir
 L2cBCb60cJqfLDVX/d/GohssBfqbxSnvWoZF7G9IKHA6ADyljzYHPqBe+oMzF5msaYDS
 QS89/DOmplOaNpaBxw6pUQQwAavSSYWOrk2GE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726848250; x=1727453050;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JvJ31T4kkvWCH4DZ/TKblOrOFV00W5K9zqn91mtU8F0=;
 b=ontr5y8SKUZGTaJSpsRHHeYZO39Jgl8Ae2k15gfXz+Vur2nwhJdfVP4pgIHBML++ey
 2A5BWOifF/P5z0wJwgfVI/nvU9Ny+sMYVPHmEmXwOUWXagqaXL8QZeMlwb7bk+zfzqPv
 9yA7NqjSn6EHPoL059RxJxG7+QndCG5zoRJww9At6jexgGnRxAwgB3HmiO4PNMIKyQm/
 sCmrKuccrstDISrvgI+ZdWRHPYzWiwd7prR4TU7jvpfAc3gKGgMYtGmeDxjvmsnzArF9
 RulHlSCWvFGwrhraKrlW8M7XdYOnRBB1dTR8x3B2tC8loL2wlo/IIrZ45sMN9EbuTtnb
 rXFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY9+6IDIXlQWOTpyAXhc1x2VDBqoqPEx8No+Ct8pubBY1THrJ6MlPq8YLKvYlb2SDyD8/lqsg=@lists.denx.de
X-Gm-Message-State: AOJu0YyX/v59lFPzXGqaLqpp6OIrXy0pVHU5zzgWInBH9gjXU2ZxjezJ
 vpp4WNu9oufz7GNlDas3reASzpsCyvZViE2rZQw5UNrxjV8UEpa0DaIsbfbR3ZkekX61MPp5fpy
 9C0G0m/IKLqWOaSUi0HbFOTP6RR+7yw/1vCy8
X-Google-Smtp-Source: AGHT+IHK0zrC05gjW0ll9x5PzEAdgJcbONIOmx0I/a4zur4JfTV3M2CSQhWFdZOoqto5Rvku8ZB06I2y1JM17aqXD+s=
X-Received: by 2002:a05:6a00:2389:b0:706:74be:686e with SMTP id
 d2e1a72fcca58-7199ca03f8fmr4635793b3a.26.1726848249445; Fri, 20 Sep 2024
 09:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240824092716.1042696-1-mikhail.kshevetskiy@iopsys.eu>
 <20240824092716.1042696-11-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240824092716.1042696-11-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 18:03:52 +0200
Message-ID: <CAFLszTje3H9h_y5da5T9yD-cY8AT7ZPh6iibqeo2aDu7qxJ-dw@mail.gmail.com>
Subject: Re: [PATCH v5 10/11] net/httpd: add httpd common code
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
 Baruch Siach <baruch@tkos.co.il>, Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 u-boot@lists.denx.de
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

On Sat, 24 Aug 2024 at 11:27, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> This patch adds HTTP/1.1 compatible web-server that can be used
> by other. Server supports GET, POST, and HEAD requests. On client
> request it will call user specified GET/POST callback. Then results
> will be transmitted to client.
>
> The following restrictions exist on the POST request
> at the moment:
>   * only multipart/form-data with a single file object
>   * object will be stored to a memory area specified in
>     image_load_addr variable
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  include/net.h       |   2 +-
>  include/net/httpd.h |  64 ++++
>  net/Kconfig         |  14 +
>  net/Makefile        |   1 +
>  net/httpd.c         | 692 ++++++++++++++++++++++++++++++++++++++++++++
>  net/net.c           |   6 +
>  6 files changed, 778 insertions(+), 1 deletion(-)
>  create mode 100644 include/net/httpd.h
>  create mode 100644 net/httpd.c

Reviewed-by: Simon Glass <sjg@chromium.org>

If you are going to memset() something after using malloc(), you may
as well use calloc()
