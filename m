Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68596D149D6
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 17:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5142589017;
	Fri, 25 Oct 2024 19:04:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f2vWoXCj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B70C089017; Fri, 25 Oct 2024 19:04:09 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1509B88D4F
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 19:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71e6cec7227so1776346b3a.0
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 10:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729875838; x=1730480638; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S/M+tLNLHTX54ThV5f0fq9PybNve8he02GOMk6tc+K4=;
 b=f2vWoXCjxgeSBsaxvqdQWU0eoiwzC6joNtaUrICaQ2FJ/INjDHuhghAwAOefmygM6j
 HpbWGwq4/0YytgBboyiGJVTIjx9I83+FTTW+PTj2VGr7FJqz7I9opgDIgMnpOSjmbg4o
 5t8n4do/chKOhbWQflJUR3bQCg3Y9MN1wERtgLnidNp79Z4vK4V9u2LyM15Z51WfEw4X
 UPvhn4D3gXqxq+EzHQhzSzqdVOUKkiWxNI0F0t1K/3KASSJg7UjY7uMkLzmhMEmcVEo/
 u2xC9+YALuxXBQzVbezTQ0MJ7yozLG/4AtL4R2+VtALN6PwhKOSFH69Q3iIh1eCiDOAm
 aggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729875838; x=1730480638;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S/M+tLNLHTX54ThV5f0fq9PybNve8he02GOMk6tc+K4=;
 b=cqLa6xELfQs1h7G2B1W+4Ysq9e9kiI7wA3q2ZkZ/yHdYJ87iij+7J4DhhJGmEgMgj9
 FJdGW6zjQc+WQ9TJi7ecWpAXJl5D5TfKHNK+pqx1vCPEvt40L72fMloowRfp9+T74VcN
 G8Sskp4N3c8leVboL1XM/SDx2zL14KfLdkt2yMQ5Bey3xbU+lbUd+fUz6OKN+O++WCZL
 Jkf2BkcmwvoDPXvGghAp3KxTf+59G5afNB3TXLoBeZ/HpaymX10i+OsVJUUtimgFw2ZE
 qoGPfo/74KFdYpiB12c/3zToG1SIsLcEWg2BlP/hkeDamna/6u8AvGRaMdLdk6lHQovg
 i/8Q==
X-Gm-Message-State: AOJu0YzaJxl65cha7oK7lKFj2mVdPTkPR2qLiTbpfYnctX4JC23AQXZT
 exdEBUgVjxxvjoyn3VY6OibP4Ao+i08arw1eUAvuSq2XFRJ7Y8cgLnPCxfMLVvB1bLEj7j588lE
 cBzHOvw6lNtzy/p0HR6RhoYx1i8kyLFFCTj21Pw==
X-Google-Smtp-Source: AGHT+IG5W1pDV0pz1z0uOewxJTAHm7M6oykT0dtv8k7R5vF/QgKyUDYU1Y5uIBQqdWU76rR7xrRz7fZlpdZBODkWddM=
X-Received: by 2002:a05:6a00:2e04:b0:71e:6728:72d5 with SMTP id
 d2e1a72fcca58-72062fd8f30mr287565b3a.15.1729875838556; Fri, 25 Oct 2024
 10:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20241025164732.73121-1-andrew.goodbody@linaro.org>
In-Reply-To: <20241025164732.73121-1-andrew.goodbody@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 25 Oct 2024 20:03:21 +0300
Message-ID: <CAC_iWjL5_42kb8dOb=muRR=2Go5G9GGi=TAHX84d8wThAg0mUA@mail.gmail.com>
Subject: Re: [PATCH] test: efi_loader: Fix dependency for http test
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

Thanks, Andrew

On Fri, 25 Oct 2024 at 19:47, Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> The config setting CMD_BOOTEFI_HELLO_COMPILE was removed in favour
> of BOOTEFI_HELLO_COMPILE but the dependency for
> test_efi_helloworld_net_http was not updated and so is now incorrect
> preventing the test from ever running. Fix it.
>
> Fixes: 6fe80876dcc7 ("efi_loader: Rename and move CMD_BOOTEFI_HELLO_COMPILE")
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>
>  test/py/tests/test_efi_loader.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_loader.py
> index 707b2c9e79..33434935fe 100644
> --- a/test/py/tests/test_efi_loader.py
> +++ b/test/py/tests/test_efi_loader.py
> @@ -182,7 +182,7 @@ def test_efi_helloworld_net_tftp(u_boot_console):
>      do_test_efi_helloworld_net(u_boot_console, PROTO_TFTP);
>
>  @pytest.mark.buildconfigspec('of_control')
> -@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
> +@pytest.mark.buildconfigspec('bootefi_hello_compile')
>  @pytest.mark.buildconfigspec('cmd_wget')
>  def test_efi_helloworld_net_http(u_boot_console):
>      """Run the helloworld.efi binary via HTTP.
> --
> 2.39.5
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
