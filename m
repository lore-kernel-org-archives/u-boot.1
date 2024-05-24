Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A105C25B7C
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 17:00:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC41F888ED;
	Fri, 24 May 2024 19:00:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EwP7FeeN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51C7388647; Fri, 24 May 2024 18:05:37 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5115D8800C
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-df77223e0f1so815106276.1
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1716566733; x=1717171533;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7yC7SYnFTf0dAMMJrD1B/hoK/Oqzk+WRCTg+EEdEeGQ=;
 b=EwP7FeeN7Ew2yYIGZgy4f8QAQ8ZfwFQPOVncs2II1vC6LOjoQTXGtDnReVahYWxXDL
 8oZASl55nO7vmb5xX+76gwRVoucVMsjOZDc5J5dnFXbv2cIbyoUZ78nWFizQE23bj/+1
 DhA60v+S0uow5YtWJ/TjxONdBJwUrRiaWQ2pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716566733; x=1717171533;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7yC7SYnFTf0dAMMJrD1B/hoK/Oqzk+WRCTg+EEdEeGQ=;
 b=YfLAQKsV4fIEackVuIBRe+80V0wO5WYdSWoTsr04UmPkoJUTL/wcnjJHvc0gQEIBcX
 sJxq1o8qDJ4kBt8NZ3JYnRZa7cUcfEPFYCz6W+QsNjIzn2/WnCW8jo7N6NKuS2uLsDio
 E89ClyCArRyXbWdzObUM1qpooJZVwQP3YmDwk7M1MB0+4LZTaTyBpu69Hq74kQ7LDMYe
 URteEjP6bfyM/xrTcILovl11Y0BR4Lk8vJDGNuil0iWg9yjUO9kVKh7jAZXt/hGxidGA
 cFOGoXP08mRIVkm/5FDf6L00c5bJ/j2gI4osOGtQLVEz+VvXxxODoTj0Bkpvp4mR/0Na
 lDAw==
X-Gm-Message-State: AOJu0YwN6iRBvmWHOYvxKkb/eOhoCKukxGMRJXCukulEc2qk92ckF0Ms
 XJRDS6V8YA3yT9emtzib6tj3oKAQH1Kvx+6TipdZ6Cb6TCbnmvAYtMhzfBU4kCWV0oKS4hS18tj
 DzU/Mkb+0YtHFJO4BVhmN5nK56ONoqH4JDUajjw==
X-Google-Smtp-Source: AGHT+IHrKIy1o/A4Rs3nZc+QU5Yzypk4ssuwqzztzJ/wKYoLMD7rVx3WLjKVpZVGJAty1zmLjsN7vfb8ES16f3JKyiE=
X-Received: by 2002:a25:be13:0:b0:de7:e977:4e4a with SMTP id
 3f1490d57ef6-df542266f16mr4114820276.19.1716566732361; Fri, 24 May 2024
 09:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240304161607.82759-1-marex@denx.de>
In-Reply-To: <20240304161607.82759-1-marex@denx.de>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Fri, 24 May 2024 21:35:21 +0530
Message-ID: <CAMty3ZB=s5ZNhgHZ2Q8vbzcvFCdO=62xHSY+dAeyr=y3ujkgWA@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: Clear Winbond SR3 WPS bit on boot
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Hai Pham <hai.pham.ud@renesas.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Johann Neuhauser <jneuhauser@dh-electronics.com>, 
 Simon Glass <sjg@chromium.org>, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 24 May 2024 19:00:29 +0200
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

On Mon, Mar 4, 2024 at 9:46=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Some Winbond SPI NORs have special SR3 register which is
> used among other things to control whether non-standard
> "Individual Block/Sector Write Protection" (WPS bit)
> locking scheme is activated. This non-standard locking
> scheme is not supported by either U-Boot or Linux SPI
> NOR stack so make sure it is disabled, otherwise the
> SPI NOR may appear locked for no obvious reason.
>
> This SR3 WPS appears e.g. on W25Q16FW which has the same ID as
> W25Q16DW, but the W25Q16DW does not implement the SR3 WPS bit.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---

Applied to u-boot-spi/master
