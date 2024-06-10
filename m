Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31518C27C65
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 09:46:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C40288239;
	Mon, 10 Jun 2024 11:46:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vc3OnbNg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2555388470; Mon, 10 Jun 2024 11:46:38 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 284EC87EBD
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 11:46:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmasson@baylibre.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57a1fe63a96so5214235a12.0
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718012795; x=1718617595;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:in-reply-to:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L9s/Sf2EJ/XlUR8aUY+0lzqkCxABQj+Knhg3i+tGHPc=;
 b=Vc3OnbNgfgvGTN/yZMldHk+86eQ915pSnVK4yIyJpZHAb0MrdgLdDe/adY+BwtVucD
 FH16G0mUbEXEooozNV98uk+XKbf91/wZU019mD7ye/ir10Q704Ij6KJ2f8S2v1Y7lV9c
 6UzLJ3Pvbppok/F9Y5tbAXugerlzQ2WbTpIDd6msmfUkZ01DvljhsjH1k+AvpJgqRknx
 dWksOtjUHv2P9Q3jFwZXduu5OihePfnuOpDNhDxBhoSHJ/4nrYbrXAMRMGMOQO8XI+7b
 na4gIZABPr4PyKFeKGVllWspa4kNAZBkBROEPf0pWhrU0D4sOoHyZ0+/oX+H4Sx+fEaB
 WJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718012795; x=1718617595;
 h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L9s/Sf2EJ/XlUR8aUY+0lzqkCxABQj+Knhg3i+tGHPc=;
 b=GWYrEFUJbaxjyyB/9JCmhUF72CmiWIDjtdprt2mKJ2my4TMpuw6jl5ybfzqUXAXYJ1
 DllzlmaBWVPebhVds73trhYpzx4pXwrp+RQ7KAO4S25UyZaHNSbIfbXViivBqIEU5P49
 HiXQclvYvMzHKVzXzdRx1GBBB+b15uIwXin2tDc7v428/M+/CXcOK8E4r5nm0nD4rRlC
 DjyGx7pjWDPE5FSp4Ei4IJ42vuNaDktnaBn1F3eoGhp0fyj/RW9dR69dORL4szWoidca
 022k6opRxtxEueWvx9/hvApS21H0U8oYYo0XnfgYb0H6W/IeNJaBV2lorJ3ZO8cGq4iv
 Qyxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRYZ3gAPOKNtO1oGumcN+/lzxK8qcnIR1/JSYwzNLc2UDrGUxZPliRNikHf83ZNQSjZuPELcCt5qtQi1SGrRRwxCzIsA==
X-Gm-Message-State: AOJu0YzaJGCgZ0YJqKxY/5oxseMcu9Eb5AEIoW0MZSt0QOzbdha2E0NQ
 fgPINbMX/DRsEDpWaVnV19/R/cs6yGa+pwzLqXbOOtlaxjkPpvgaSwn+3nr8eR0=
X-Google-Smtp-Source: AGHT+IFh0OMVkdECpnYEyYVYXBrbPTeW+P/xaYB8lmnn22CQ1xezVXWJgaeO9RfvmbFvZKeFzMFigQ==
X-Received: by 2002:a50:d5c2:0:b0:57c:748e:8c56 with SMTP id
 4fb4d7f45d1cf-57c748e8dabmr2315777a12.33.1718012795454; 
 Mon, 10 Jun 2024 02:46:35 -0700 (PDT)
Received: from localhost ([2a04:cec2:b:49d2:7655:6cc3:de57:63b7])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae0caa84sm7268231a12.29.2024.06.10.02.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 02:46:35 -0700 (PDT)
From: Julien Masson <jmasson@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Mario Six <mario.six@gdsys.cc>, Quentin Schulz
 <quentin.schulz@cherry.de>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 1/2] bootstd: Fix a handful of doc typos in bootmeth
In-Reply-To: <20240604-bootmeth-typos-v2-1-821683a95aaf@baylibre.com>
Date: Mon, 10 Jun 2024 11:46:33 +0200
Message-ID: <87ikyhi0zq.fsf@fedora.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
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


On Mon 10 Jun 2024 at 11:46, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> Fix some trivial typos found by browsing the code.
> Done with flyspell.
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  include/bootmeth.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/bootmeth.h b/include/bootmeth.h
> index 0fc36104ece0..529c4d813d82 100644
> --- a/include/bootmeth.h
> +++ b/include/bootmeth.h
> @@ -40,7 +40,7 @@ struct bootmeth_ops {
>  	/**
>  	 * get_state_desc() - get detailed state information
>  	 *
> -	 * Prodecues a textual description of the state of the bootmeth. This
> +	 * Produces a textual description of the state of the bootmeth. This
>  	 * can include newline characters if it extends to multiple lines. It
>  	 * must be a nul-terminated string.
>  	 *
> @@ -138,7 +138,7 @@ struct bootmeth_ops {
>  	 * @dev:	Bootmethod device to boot
>  	 * @bflow:	Bootflow to boot
>  	 * Return: does not return on success, since it should boot the
> -	 *	Operating Systemn. Returns -EFAULT if that fails, -ENOTSUPP if
> +	 *	Operating System. Returns -EFAULT if that fails, -ENOTSUPP if
>  	 *	trying method resulted in finding out that is not actually
>  	 *	supported for this boot and should not be tried again unless
>  	 *	something changes, other -ve on other error
> @@ -151,7 +151,7 @@ struct bootmeth_ops {
>  /**
>   * bootmeth_get_state_desc() - get detailed state information
>   *
> - * Prodecues a textual description of the state of the bootmeth. This
> + * Produces a textual description of the state of the bootmeth. This
>   * can include newline characters if it extends to multiple lines. It
>   * must be a nul-terminated string.
>   *
> @@ -244,7 +244,7 @@ int bootmeth_read_file(struct udevice *dev, struct bootflow *bflow,
>   * @dev:	Bootmethod device to use
>   * @bflow:	Bootflow to read
>   * Return: does not return on success, since it should boot the
> - *	Operating Systemn. Returns -EFAULT if that fails, other -ve on
> + *	Operating System. Returns -EFAULT if that fails, other -ve on
>   *	other error
>   */
>  int bootmeth_read_all(struct udevice *dev, struct bootflow *bflow);
> @@ -255,7 +255,7 @@ int bootmeth_read_all(struct udevice *dev, struct bootflow *bflow);
>   * @dev:	Bootmethod device to boot
>   * @bflow:	Bootflow to boot
>   * Return: does not return on success, since it should boot the
> - *	Operating Systemn. Returns -EFAULT if that fails, other -ve on
> + *	Operating System. Returns -EFAULT if that fails, other -ve on
>   *	other error
>   */
>  int bootmeth_boot(struct udevice *dev, struct bootflow *bflow);
> @@ -264,7 +264,7 @@ int bootmeth_boot(struct udevice *dev, struct bootflow *bflow);
>   * bootmeth_setup_iter_order() - Set up the ordering of bootmeths to scan
>   *
>   * This sets up the ordering information in @iter, based on the selected
> - * ordering of the bootmethds in bootstd_priv->bootmeth_order. If there is no
> + * ordering of the bootmeths in bootstd_priv->bootmeth_order. If there is no
>   * ordering there, then all bootmethods are added
>   *
>   * @iter: Iterator to update with the order
> 
> -- 
> 2.45.0
> 
> 

Reviewed-by: Julien Masson <jmasson@baylibre.com>
-- 
Julien Masson
