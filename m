Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A10C49EA1
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 01:04:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAF6888B07;
	Wed,  7 Aug 2024 03:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="PvuGnitg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BDEF88B42; Wed,  7 Aug 2024 03:04:16 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F2C488A9E
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 03:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1722992652; x=1723597452; i=xypron.glpk@gmx.de;
 bh=5HvGShoKawQfAV5cKaTFSlsFiDdqai8Y8BfQ4YZszZA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=PvuGnitgbT8oOXNwX5To82oS0zwDE1+JEe7lW1yLA8u+RBTz4fdZ1ZFF1nhSDm2m
 Kpc0XlkciMCG7BwBoFUrhQrp8VpvWM8SjXEj2yEjEDslL/pEAkhc3jt71LlqSBpEw
 nxGSOfmI3Erv9bCpDeQVU2GpDmZnsh47OWzo9mfmPiWM3vwaxe5fvQNKDFSO3duIt
 +wCp+5P08aTlPKD7iD7XoF9EKxX04Dqt376Rh/iH/NVLDq9J8SAgxyv9ISzmBZZob
 QJnsEAZRvNQEg1p0X4AZGKS8pPrRUPcZVFWsBoZHhnfaziHnd/FgB8Z43BZ8XraiM
 J9HxH1f4tWElCVeYKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([46.114.197.150]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsZ3-1sRNQZ0nMd-004dlS; Wed, 07
 Aug 2024 03:04:12 +0200
Message-ID: <490a4411-3829-4459-968a-5ea8cdf8b94d@gmx.de>
Date: Wed, 7 Aug 2024 03:04:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/39] efi_loader: Shorten the app rules
To: Simon Glass <sjg@chromium.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-29-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240806125850.2316956-29-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XqoIqANoM4gCXvY1yIUU5VU/ylWfV4fIwlFcHvvjZzJSk7QvoNR
 lOh5YEMEMSa7n+1RKPmpQOPi8Fzj1ZoVt5bHMwk6gO1U+CyEYMj6ZeETbtH5xj5NWFnAdvi
 G8jwZ7FWwDkEsNk7V+GHvLNhjZot6byIYAnQNJoAduzFH/cV6aR/W4aD7usBlvFD8mhI6Ag
 ofxAQKu+A4+47G/WJt89w==
UI-OutboundReport: notjunk:1;M01:P0:MTMkhvHj6Ps=;RkW+Z81o8wpk3TKhzg7yJnonGqf
 GWqY5/Fkb3+dav53DnT4vIuA1U74g1/ct6M8uDpkM74HsJjaqPnG2FVzfELp3qizpPW2G7+VM
 rQlCyND1zf28p8p3PuqDPqAJKYzl+o9eK//zByEF/Xta3IWPaqQpQPRc6930jx0TAHGZutBNj
 rbYT8Hj5O8sbaSMKB2xFQcQw6jQBL9aDjPO+USYuYQ6O/HKHtRfD/XsVg46LALrZYpcFiNAKT
 cGZRRX70SJKx7qKtKok+6WNBjEeTk3wwTAAA0nElxWpgap0XaUPotWU+gcHZvc8Arson7XOoX
 avPPiJguACIQREdw2twtCv/K5b9Td1juHq3xxiX+8///HLiwtwL3chfVQaJBcknhrcaOHd5F4
 rbQuqNtnGh/f6es2Q56K8SrMgJwBRMVSX+h2L1F3YFy6+yKz4phEG+IpU+YXKmoN0qxQEJ0TN
 JFksLzBeacAeQDPTytza6Gi6Q9lVzEPYqDp1HxONzVhaklZPc8e+bNAQhpvQRdYaLewwiZRdk
 ovNaYudGU8c3uVl/5WKk5/gNkFfKQa2h5x11geh2R/zPqRcBAqJfzzt7hSCYSwNgthovu237x
 lqRh/iaO2HkjBIZD+5lUxg6aI03bT0MeAn57T9aRRoB9jCHgDrPfpRQ+Og9bgj+iZJ4jb6uyX
 QKxVkOKO7hUubdbM2XaniDxd6q0yHCxGhcTv5VPiTCtwvrfyh8xkKc8OT8ZgREerJ+pxoov5c
 hnEeG1nqThFECW8Bp4fHJQKgKXtOolaccnHf3HPc9TcqWmPmz6/DewCNe6kQ7XNKHoy+srDSB
 pPg1mDm5ipsD+jNQe8FO0H8w==
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

On 06.08.24 14:58, Simon Glass wrote:
> We have quite a few apps now, so create a way to specify them as a list
> rather than repeating the same rules again and again.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
> (no changes since v1)
>
>   lib/efi_loader/Makefile | 31 +++++++++----------------------
>   1 file changed, 9 insertions(+), 22 deletions(-)
>
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 27dbd9e760d..660368b9d8f 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -22,29 +22,13 @@ CFLAGS_REMOVE_dtbdump.o :=3D $(CFLAGS_NON_EFI)
>   CFLAGS_initrddump.o :=3D $(CFLAGS_EFI) -Os -ffreestanding
>   CFLAGS_REMOVE_initrddump.o :=3D $(CFLAGS_NON_EFI)
>
> -ifdef CONFIG_RISCV
> -always +=3D boothart.efi
> -targets +=3D boothart.o
> -endif
> -
> -ifneq ($(CONFIG_BOOTEFI_HELLO_COMPILE),)
> -always +=3D helloworld.efi
> -targets +=3D helloworld.o
> -endif
> -
> -ifneq ($(CONFIG_GENERATE_SMBIOS_TABLE),)
> -always +=3D smbiosdump.efi
> -targets +=3D smbiosdump.o
> -endif
> -
> +# These are the apps that are built
> +apps-$(CONFIG_RISCV) +=3D boothart
> +apps-$(CONFIG_BOOTEFI_HELLO_COMPILE) +=3D helloworld
> +apps-$(CONFIG_GENERATE_SMBIOS_TABLE) +=3D smbiosdump
> +apps-$(CONFIG_EFI_LOAD_FILE2_INITRD) +=3D initrddump
>   ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
> -always +=3D dtbdump.efi
> -targets +=3D dtbdump.o
> -endif
> -
> -ifdef CONFIG_EFI_LOAD_FILE2_INITRD
> -always +=3D initrddump.efi
> -targets +=3D initrddump.o
> +apps-y +=3D dtbdump
>   endif
>
>   obj-$(CONFIG_CMD_BOOTEFI_HELLO) +=3D helloworld_efi.o
> @@ -95,3 +79,6 @@ obj-$(CONFIG_EFI_ECPT) +=3D efi_conformance.o
>
>   EFI_VAR_SEED_FILE :=3D $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
>   $(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
> +
> +always +=3D $(foreach f,$(apps-y),$(f).efi)
> +targets +=3D $(foreach f,$(apps-y),$(f).o)

