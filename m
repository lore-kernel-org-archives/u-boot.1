Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E69C4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 15:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B15E8803E;
	Thu, 11 Apr 2024 17:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="TuQS1gID";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88CEB87FED; Thu, 11 Apr 2024 17:11:50 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BD5B8758B
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 17:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: a7a9acef-f815-11ee-99a6-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id a7a9acef-f815-11ee-99a6-005056999439;
 Thu, 11 Apr 2024 17:10:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=TghoWTH6tI6uckEBhMtPJJYx0LM5DPqUlX/gXvOi2HQ=;
 b=TuQS1gIDZ6Z8eVvGIrA8N7wiC7iEizKv6XAWHnaSUF/cpsKS1PWRCcdjr7xChp3kLleZNtxl3BdiQ
 12noXaAF3z4fJ6TcObc52uN4uZdGP3PE468RNPnhUUT04XsrEAXQK4pg1xz/O8apdXKipJyRDQK5ig
 6aGa2Am/nkIO/9uD6WoFx3Gc9DXq0QANMqJqf/ZBDFg8EUl1/btIk6xcRfDnWcPQaC1jsoXGYiA5JH
 Vw4VxObxr2T7ilVmmvmlPKWmecNW+2FFa8sGydoGjIuPkxc3Lq6TahHYXwfZDfUde32+57yXyOPs3t
 8PE3noeuBjHgw0v3xOb+ww6CG4tr2Sg==
X-KPN-MID: 33|amiacTXLMC3bgDRGfsuF3gq4ClvekR+piNojkhVlMPeP/FvYilLAY0LQplHNsl1
 FbopCrTFLOzCmtvxZcyA4NrOoAR9dJtOqqsiyYlqh9b4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|T7vRMpKQeDxU95HE/B10pgplLvohmiCt7vPgr515kKe1DtjI88X/WAdUCDFb1Iz
 6uNBXOEHd1F99Cd0B+/AwLA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id d02d3896-f815-11ee-9b3e-005056998788;
 Thu, 11 Apr 2024 17:11:47 +0200 (CEST)
Date: Thu, 11 Apr 2024 17:11:46 +0200
Message-Id: <87r0fcgci5.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: John Watts <contact@jookia.org>
Cc: trini@konsulko.com, u-boot@lists.denx.de, contact@jookia.org
In-Reply-To: <20240411-stdout-v1-1-66ebe5bb152f@jookia.org> (message from John
 Watts on Thu, 11 Apr 2024 15:03:20 +1000)
Subject: Re: [PATCH] boot: Pass baud rate to stdout-path
References: <20240411-stdout-v1-1-66ebe5bb152f@jookia.org>
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

> From: John Watts <contact@jookia.org>
> Date: Thu, 11 Apr 2024 15:03:20 +1000
> 
> Linux might use the wrong baud rate such as 9600 by default, make sure
> to specify it when passing the serial port over.
> 
> Signed-off-by: John Watts <contact@jookia.org>
> ---
> On my board at least (a sunxi T113) the serial console will initialize
> as 9600 baud instead of the set baud. Pass the baud with the serial
> device to Linux to solve this issue.

You probably should fix this by making sure the device tree you're
using has the appropriate stdout-path node.  Because I think the
functionality you're trying to use here is deprecated:

* The linux,stdout-path property has been superseded by the
  stdout-path property.

* The description of the OF_STDOUT_VIA_ALIAS option suggests that it
  is seprecated as well:

    This option currently references CONFIG_CONS_INDEX, which is
    incorrect when used with device tree as this option does not
    exist / should not be used.

  It just happens that sunxi is one of the few remaining "modenr"
  platforms that still uses CONFIG_CONS_INDEX.

That said, the diff is interesting.  To me it doesn't really make
sense that you can change the serial port and its parameters in
U-Boot, but that this choice doesn't always make it into the device
tree that is passed to the OS.

A particular case that I'm dealing with is the default speed of
1500000 that the various Rockchip SoCs use.  This doesn't work with
many of the USB-to-serial interfaces on the market and is also rather
susceptible to line noise.  So for OpenBSD packages I've decide to use
115200 instead.  But that means I have to patch all the device trees
in addition to changing the CONFIG_BAUDRATE setting.  If U-Boot would
tweak the stdout-path property based on CONFIG_BAUDRATE that would
make things easier.

Cheers,

Mark

> ---
>  boot/fdt_support.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 090d82ee80..83e62f47b5 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -153,9 +153,9 @@ static int fdt_fixup_stdout(void *fdt, int chosenoff)
>  	}
>  
>  	/* fdt_setprop may break "path" so we copy it to tmp buffer */
> -	memcpy(tmp, path, len);
> +	len = sprintf(tmp, "%.*s:%d", len, (char *)path, CONFIG_BAUDRATE);
>  
> -	err = fdt_setprop(fdt, chosenoff, "linux,stdout-path", tmp, len);
> +	err = fdt_setprop(fdt, chosenoff, "linux,stdout-path", tmp, len + 1);
>  	if (err < 0)
>  		printf("WARNING: could not set linux,stdout-path %s.\n",
>  		       fdt_strerror(err));
> 
> ---
> base-commit: 777c28460947371ada40868dc994dfe8537d7115
> change-id: 20240411-stdout-4f91b566a0f2
> 
> Best regards,
> -- 
> John Watts <contact@jookia.org>
> 
> 
