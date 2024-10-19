Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85759D3C90B
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 11:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 736FD892C6;
	Sat, 19 Oct 2024 13:50:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XlJlPaUA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4563489242; Sat, 19 Oct 2024 13:50:52 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21EEA88B23
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 13:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cbd57cc35bso32598976d6.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 04:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729338649; x=1729943449; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cMWKEPKRyudoNVWvEiq27qcNGIQ5iXXLCIlVkROcs54=;
 b=XlJlPaUAuWNXRt773VvqpXfi3+ax16TUSOiy427L1ReX+NKnXmeu/V1fv3S5pGRvdc
 4vvP3U5cPc2erIMdmSVkii5lrxIUQx4rjdcIPxoJDYHhA/MgPqaA6m7USh8JN8ta0QBJ
 22NXm2ME4m/09PcUp1yXzeveSctqqOM1Xuczo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729338649; x=1729943449;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cMWKEPKRyudoNVWvEiq27qcNGIQ5iXXLCIlVkROcs54=;
 b=J9ZNWV7sAAUsq79nqp/HEItn0syPACjv+pq6k+CSat8honT3EBcq2kFg093CqJaXil
 pytHHKP8bplkcRKzqiVEvmFHLzoxF4YiOkadsnaFuwiU+QP5pXMkM4NFWKkSt+YscleZ
 xNYcDT32xAu+VNVF0VcTRFLgkAQ0dLyrOH3sB7qxw7azjYH1Dlr2QVNcuJxJH1sxR7E2
 OYYuebA6j+6u5a2GHJDOjMy+bLQnxEIH4sWlXguhEDpaqXm+/vtjwjaCKtiKSx7FYIUg
 M6NhtTe2v111fnqlXuGbuzhmCumfKJ7NtLujXMnuEdQiw7YQTtR8e1JImViKOPEA+kCr
 5wIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8rhUUPe8r3rIs8t3HTIeN/P5L0I/a5rve9bYTA1dXqozH8vQX6Hu+BsadoDVxYPTfbP5uNYU=@lists.denx.de
X-Gm-Message-State: AOJu0YzMBnPAoQitd5yJjdNsHbr5WIa77ZoF3B9QpzQL9zh7m3b4+ExZ
 O7fTWebs2fJru8qmxcxrJekDAwNoZGB1/QtNuEEFLjybIff3x+m+79MnudXLBRZ+YLzCuCdEGO0
 S4arhlC5fEMn/3fxu9smR/DnJvORM4pC+leC2
X-Google-Smtp-Source: AGHT+IHpOw3oHszjcLrd0CN5x0CazcFwWc7I1Cc0ajeelaE7ZkNv2wSEfy8eaXP66uuVoxQNDTmAyF0qri6pr+snd9s=
X-Received: by 2002:a05:6214:3c88:b0:6cb:d0a3:35ac with SMTP id
 6a1803df08f44-6cde18bd4f7mr102152906d6.8.1729338649063; Sat, 19 Oct 2024
 04:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20241018142235.715571-1-ilias.apalodimas@linaro.org>
 <20241018142235.715571-7-ilias.apalodimas@linaro.org>
In-Reply-To: <20241018142235.715571-7-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 19 Oct 2024 05:50:38 -0600
Message-ID: <CAFLszTjcYX1ETnm4hf9jhv=pBQu+_0Vhe+ddg-zOOYkYbNXFkA@mail.gmail.com>
Subject: Re: [PATCH 6/6] doc: uefi: Describe UEFI HTTPs boot
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: jerome.forissier@linaro.org, raymond.mao@linaro.org, xypron.glpk@gmx.de, 
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Wei Ming Chen <jj251510319013@gmail.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
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

On Fri, 18 Oct 2024 at 08:23, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> We now can use a combination og lwIP & mbedTLS and download from
> https://. Describe the config options needed to enable it as well
> as some limitations
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  doc/develop/uefi/uefi.rst | 45 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index 0760ca91d4fc..198288a6889f 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -681,8 +681,8 @@ UEFI variables. Booting according to these variables is possible via::
>  As of U-Boot v2020.10 UEFI variables cannot be set at runtime. The U-Boot
>  command 'efidebug' can be used to set the variables.
>
> -UEFI HTTP Boot
> -~~~~~~~~~~~~~~
> +UEFI HTTP Boot using the legacy TCP stack
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>  HTTP Boot provides the capability for system deployment and configuration
>  over the network. HTTP Boot can be activated by specifying::
> @@ -715,6 +715,47 @@ We need to preset the "httpserverip" environment variable to proceed the wget::
>
>      setenv httpserverip 192.168.1.1
>
> +UEFI HTTP(s) Boot using lwIP
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Similar to the above U-Boot can do EFI HTTP boot using lwIP. If we combine this
> +with mbedTLS we can also download from https://
> +
> +HTTP(s) Boot can be activated by specifying::
> +
> +    CONFIG_EFI_HTTP_BOOT
> +    CONFIG_NET_LWIP
> +    CONFIG_MBEDTLS_LIB_TLS
> +
> +For QEMU targets there's a Kconfig that supports this by default::
> +
> +    make qemu_arm64_lwip_defconfig
> +
> +The commands and functionality are similar to the legacy stack, with the notable
> +exception of not having to define an "httpserverip" if you are trying to resolve
> +an IP. However, lwIP code doesn't yet support redirects::
> +
> +    => efidebug boot add -u 1 netinst https://cdimage.debian.org/cdimage/weekly-builds/arm64/iso-cd/debian-testing-arm64-netinst.iso
> +    => dhcp
> +    DHCP client bound to address 10.0.2.15 (3 ms)
> +    => efidebug boot order 1
> +    => bootefi bootmgr
> +
> +    HTTP server error 302
> +    Loading Boot0001 'netinst' failed
> +    EFI boot manager: Cannot load any image
> +
> +If the url you specified isn't a redirect::
> +
> +    => efidebug boot add -u 1 netinst https://download.rockylinux.org/pub/rocky/9/isos/aarch64/Rocky-9.4-aarch64-minimal.iso
> +    => dhcp
> +    => bootefi bootmgr
> +    #######################################
> +
> +If the downloaded file extension is .iso or .img file, efibootmgr tries to
> +mount the image and boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
> +If the downloaded file is PE-COFF image, load the downloaded file and
> +start it.
> +
>  Executing the built in hello world application
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> --
> 2.45.2
>
