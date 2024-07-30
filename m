Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017B8C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 09:20:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 673728870D;
	Tue, 30 Jul 2024 11:20:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="G9EBuQN8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B1A0883A9; Tue, 30 Jul 2024 11:20:54 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07CEF8870D
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 11:20:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f0271b0ae9so55277061fa.1
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 02:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722331251; x=1722936051;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=agzr5Tc8w7j95cJq+sIHaZwqeeFGqkcqEstmkh1sM24=;
 b=G9EBuQN88eOWzZ8u9B1PppzZmRDPNpSh502iUkmu3gkOcYUNWzJIF+A9Uo3FmDdz1v
 JB5ILJOzJVZcDW1DPeFoqlUNpruNOs9H1NXV6UbLibtwKMiTtbSFjhuChmv60uZ2nH0n
 OjQmNu4+/ju4kklEALJW1CD2RMi1cTGcu+fRQbhgYK1am2Hu7saegxYADVnIoeUahQDd
 LqM5+iL1nVagFHb5iHnDc0CoCWfcBaU4awFowEvJ9oHxHDOOcrp02a3G6PfV8gfhjB7I
 Ekro05lpJpFWvKEZ0vMZBYMC5CGfy+Je6hEakreXG48wGdkDxYyr/lhWxxleYkAAPUcl
 UYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722331251; x=1722936051;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=agzr5Tc8w7j95cJq+sIHaZwqeeFGqkcqEstmkh1sM24=;
 b=NIenbdXWsK5bJfab/uIOucnaZZ+Y1bChJ7KYLatijr7uzX3nc0WVAZ9IC1+WkFcdlw
 guXDobSGcF41gLCMB5VjvjJl+mQOUjH8hk64X1DkOA6pvhaFAoCojKkyn6s9OUqp1eSX
 JXZ5uzyN8lCCCQrxUywu4rXs2+FVQaF/PjEvaHDqaPX5E/iDJA9ZGPqPv+U68CrA4b4b
 jN0F8WliHrJxi+865quiujCwyd+zP74N2uzvyZvsmOFbuuDHOUa1QRH6LzbMdMw9OSjk
 Lg/mPG6UwHw4F1WLz90xeyj4NkJaR7MLREugJHmcwPogwnQQPcE8OZy3PAdLHZiyDS+I
 oIjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWthVf2+R9L+CWj/2fJliZ+Za7H1ybLhJ7xkjHbXwFJimXXOt+W3M45LltshnfTeoXUMxlj+tHv99ujoZvqUx7jZ8mqtQ==
X-Gm-Message-State: AOJu0Yx0Ro25dwgdm5SoTmHRBmEWfAu6J6PCcEA2rl5xWnztGj7tuH+5
 YRuyabWuWC1SH2aYh7m+vOisth3tRFr1ELZ5U4P2vQ8QndqX/uVUEwdXgKNn+sERnyaY0CJre0C
 6
X-Google-Smtp-Source: AGHT+IG2Uc1OC9Jr4M4N5TUfxV70fdnk7KXN9xcGAHOJqu9bMtuVPn7vhFvrX57mfJK+1O1H0v04WQ==
X-Received: by 2002:a2e:8508:0:b0:2ed:275d:aa44 with SMTP id
 38308e7fff4ca-2f12edd67f5mr64601601fa.28.1722331250852; 
 Tue, 30 Jul 2024 02:20:50 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280d37bad3sm150476945e9.13.2024.07.30.02.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 02:20:50 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Shantur Rathore <i@shantur.com>, Eddie
 James <eajames@linux.ibm.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH] usb: bootm: Drop old USB-device-removal code
In-Reply-To: <20240726123609.57191-1-sjg@chromium.org>
References: <20240726123609.57191-1-sjg@chromium.org>
Date: Tue, 30 Jul 2024 11:20:47 +0200
Message-ID: <87zfpzp768.fsf@baylibre.com>
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

Hi Simon,

Thank you for the patch.

On ven., juil. 26, 2024 at 06:36, Simon Glass <sjg@chromium.org> wrote:

> USB is stopped using driver model now, in dm_remove_devices_flags() in
> announce_and_cleanup() at the top of this file.
>
> The usb_stop() call actually unbinds devices.
>
> When a USB device is unbound, it causes any bootflows attached to it to
> be removed, via a call to bootdev_clear_bootflows() from
> bootdev_pre_unbind(). This obviously makes it impossible to boot the
> bootflow.
>
> However, when booting a bootflow that relies on USB, usb_stop() is
> called, which unbinds the device. At that point any information
> attached to the bootflow is dropped.
>
> This is quite risky since the contents of freed memory are not
> guaranteed to remain unchanged. Depending on what other options are
> done before boot, a hard-to-find bug may crop up.
>
> Drop the call to this old function.
>
> Leave the netconsole call there, since this needs conversion to
> driver model.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Shantur Rathore <i@shantur.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> The original patch was here:
> https://patchwork.ozlabs.org/project/uboot/patch/
> 20231119121144.v5.5.If206027372f73ce32480223e5626f4b944e281b7@changeid/
>
>  boot/bootm.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/boot/bootm.c b/boot/bootm.c
> index 376d63aafc9..480f8e6a0e6 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -740,18 +740,6 @@ ulong bootm_disable_interrupts(void)
>  	eth_halt();
>  #endif
>  
> -#if defined(CONFIG_CMD_USB)
> -	/*
> -	 * turn off USB to prevent the host controller from writing to the
> -	 * SDRAM while Linux is booting. This could happen (at least for OHCI
> -	 * controller), because the HCCA (Host Controller Communication Area)
> -	 * lies within the SDRAM and the host controller writes continously to
> -	 * this area (as busmaster!). The HccaFrameNumber is for example
> -	 * updated every 1 ms within the HCCA structure in SDRAM! For more
> -	 * details see the OpenHCI specification.
> -	 */
> -	usb_stop();
> -#endif
>  	return iflag;
>  }
>  
> -- 
> 2.34.1
