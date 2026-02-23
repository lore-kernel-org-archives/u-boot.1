Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82CBEC1116
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 17:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81B2083E21;
	Mon, 23 Feb 2026 18:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UD9Rhjx+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B18A380077; Mon, 23 Feb 2026 18:51:29 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C319F83E21
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 18:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-658b6757f7fso56878a12.1
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 09:51:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771869087; cv=none;
 d=google.com; s=arc-20240605;
 b=X1IJs2LKOOHxdf7qSXgRpvhk7zC+Fg5MxVebYaiqhJzcoo66qsVfvhqy9gyuNS7Tli
 LjvHXoekpZMfpoOhcCWx3w3YRxjodh/E1i4qICV8XZM74wOzlnGDOBUg+xkQyo3QFlON
 Y3CK/q0RVRPCuH2XnLQWp7gz9Pko9q43uM1easG7nz0xDCVHS1rsMn0ZZCSyqME8Sbok
 ipFwGR4g79U0wYpFzRYyw/+0gGgCypLk5wM1SZIdMkIhiekuRTtIzYAeC3cGzP0PGlmW
 vbhZMuJXH1RsXcTehNZOZvG+bGd+zfz/0We4NxM6j1r92pujneOIrqlKILZcFGnVHX3U
 lI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=38PEh6czaC7OGivm4Pw2r2HPFU4htEMj11zDxVjT6Lk=;
 fh=HnsLlpVhzwN7uih7Ak2yI4wYc3mQPSEfV2n79G1UCUM=;
 b=PASeZfoRHQwQM9YBHjmP1zA3ZS7/Ld78OSMg5aLaQNw/pO8++ME2xmXto5HqTq2ow/
 5rS2L8Gb/SMxoeaUGEaJMFECExExuno5tCd7ApWtN9Zhlx4tCGrWTlPxiqbAA9rq77yE
 RQ4VJJLFmt+D87poP4U1yZYABgx/QywXBd9J3KnbDDPLj3fVmhkWQf1dKxs6m8Cc0Afg
 TkE89ZS2IYVBLfXiQSpO4S5Bd4zI+almeXrbG9UItsVYx97gGyEf1UoNIrIfoPBZSu3m
 6bdTIhYW5xzhruIApS7gGQR6RwLqel7J8dgNf0Q1ZAHQxLtdm0EDTcdebrqHObxxPooe
 PzQA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771869087; x=1772473887; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=38PEh6czaC7OGivm4Pw2r2HPFU4htEMj11zDxVjT6Lk=;
 b=UD9Rhjx++nL+nghvhyVTBQcSs4I30BChuhpzteq27pr+uCnzGfNWAaxu8XVk+nkw67
 Tlo/QIHFoFyISR9sTvJb5XIHmu7uEtPbaR7Yzw+vwW/rT6MmSGA9CpzkO+SjtYr/kxxV
 phTCxHTNUsSfLNfsnUWY5F5zwIBOCgmE3pZp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771869087; x=1772473887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38PEh6czaC7OGivm4Pw2r2HPFU4htEMj11zDxVjT6Lk=;
 b=A7Qlc3Z/7eW8B05JAwzCRv0Zdl811C8k80FoyrDXmPGXP17HRGbAGJIGiANs+eU9/m
 bCCfE51EARzfiVFgPDBc/8iIKHMuixGszj9oh4CbMLa+qEcSbE0cDSv9JKhxm+EkQKi4
 HcEdgZFzFPBI6Dbg41lXTvghVNZoGbgFVWW4MXGgQ71+O7mod+BzEHkegBfOijesYA6n
 YzPmrGDgztVlPduv0aUG+LIcVoOzdzVwek6xb/zFJjQ9yx6CdOSE92J2TLROh3KMDibu
 AdhkczfVTtFkkQcLwJokyA1H2Wh3OftcvM0/6Off4WHlXHSOa7xc1yfe88LmmpC/8clr
 qFSA==
X-Gm-Message-State: AOJu0YyPEVOSkY9GPKsRjE28UOatRXGoiObCb1MVZOKb+dIZIO1PPAzL
 rMQj9IJUT8dPBwgyrlhewZXtY5he3Cpicva8EkdkbMoayErebDYygqqKeM1N8FYrTCuxqJf2BLG
 eRkg8LKrgUEgKKQWfGzZVfdjT/sLJjw+3S7AChuPe
X-Gm-Gg: ATEYQzzoRG3iXwxy0BC/Li3HWUUxj0m+QOSvK14Aqpcxg8ppT+ciZ1FyZBQsZlyWSJ/
 GknJ3nfY/y62GkHtWbxIy5G2lgOWzekQSLzfxhC6m7rX8Fg9n8BHIrXP64JrGyvXuqgGNkDD7F6
 TAnJlFWi+szjQXtQLTs0HUtNuMGeZIu7mjdz1ml6//yse2VHiufwyWqpyO/rnEbh225Vbymy5S7
 8K8GX9APvX30HNgl4hefd9g30sWmzykGd8M0sO4GaNzhAlq7NhrSr68ZifPerVgxY43FYEffcA5
 7+Km1A==
X-Received: by 2002:a05:6402:27c7:b0:64b:5d42:52f4 with SMTP id
 4fb4d7f45d1cf-65ea4ec5bebmr5512137a12.15.1771869087222; Mon, 23 Feb 2026
 09:51:27 -0800 (PST)
MIME-Version: 1.0
References: <20260221094252.3103034-1-dario.binacchi@amarulasolutions.com>
 <20260221094252.3103034-4-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20260221094252.3103034-4-dario.binacchi@amarulasolutions.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Feb 2026 10:51:04 -0700
X-Gm-Features: AaiRm51sZB2QH-ay_tA1SCsorFbxyGKaqI1z6qL9wyMqPtfGTktlOeS0fs53_is
Message-ID: <CAFLszTiYbfDHMisAa2nAOaB+P1pu54=no1h78d3LtiAdQZOM3Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] test: spi: add sandbox_spi_get_wordlen interface
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 linux-amarula@amarulasolutions.com, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
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

On Sat, 21 Feb 2026 at 02:43, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> Add the sandbox_spi_get_wordlen() public interface to retrieve the
> internal word length state of the sandbox SPI device.
>
> This is intended for use in sandbox SPI test cases to verify that
> the word length is correctly propagated from the SPI uclass to
> the driver.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>
> (no changes since v1)
>
>  arch/sandbox/include/asm/test.h | 8 ++++++++
>  drivers/spi/sandbox_spi.c       | 8 ++++++++
>  2 files changed, 16 insertions(+)
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>

But I think it is better to store this in the uclass-plat data rather
than in each individual SPI driver.


> diff --git a/arch/sandbox/include/asm/test.h b/arch/sandbox/include/asm/test.h
> index 0e8d19ce2325..0438790028b9 100644
> --- a/arch/sandbox/include/asm/test.h
> +++ b/arch/sandbox/include/asm/test.h
> @@ -243,6 +243,14 @@ uint sandbox_spi_get_speed(struct udevice *dev);
>   */
>  uint sandbox_spi_get_mode(struct udevice *dev);
>
> +/**
> + * sandbox_spi_get_wordlen() - Get current wordlen setting of a sandbox spi slave
> + *
> + * @dev: Device to check
> + * Return: current wordlen
> + */
> +uint sandbox_spi_get_wordlen(struct udevice *dev);
> +
>  /**
>   * sandbox_get_pch_spi_protect() - Get the PCI SPI protection status
>   *
> diff --git a/drivers/spi/sandbox_spi.c b/drivers/spi/sandbox_spi.c
> index 8eed56140f6a..b035a60ef43a 100644
> --- a/drivers/spi/sandbox_spi.c
> +++ b/drivers/spi/sandbox_spi.c
> @@ -63,6 +63,14 @@ uint sandbox_spi_get_mode(struct udevice *dev)
>         return priv->mode;
>  }
>
> +uint sandbox_spi_get_wordlen(struct udevice *slave)
> +{
> +       struct udevice *bus = slave->parent;
> +       struct sandbox_spi_priv *priv = dev_get_priv(bus);
> +
> +       return priv->wordlen;
> +}
> +
>  static int sandbox_spi_set_wordlen(struct udevice *slave, unsigned int wordlen)
>  {
>         struct udevice *bus = slave->parent;
> --
> 2.43.0
>
