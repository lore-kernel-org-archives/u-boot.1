Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6D4606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fj4xx5lD;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=oAT5ezRD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C857607DE;
	Mon,  9 Nov 2026 15:40:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VC722wD1vArC; Mon,  9 Nov 2026 15:40:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C3EF8607C5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794238832;
	b=B7yvsTz0kO4RhfKlRiJoyaAzZnNpar3gjQ1JEnwOXoDYemW7uT0ztR4kI032Y7bjeprz
	 nG3/f3ovnVlBhKvi1NjUNjNCgJLOabNUWrKXSf6wA8vjlXp6cYAkeBW1gh2wwGJ3CrRBF
	 w1Jb6b6+jQXrpMsjvUwr+oT3X2aytnkh9zbvP4NT/E1nrM8pwbQhTpfakAlqs4jlLgkZj
	 NY50x8qSqim1MybIw7QIpQpSgwGumhyqJZfce7v++XEWDsFdj2ZEYya/Gr0tqS1UiH/xx
	 jTwsMK+wsregJljHBq5D35nbQN2OGvZP8MLfC+n2ou+/TfR5/xCS1LDek6ztrJFNVMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794238832;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=+uyrvuFHf8wGcmC7fRkH4E8EwvQEyNHWQC3vkdTAxAI=;
	b=UDYfPtH8rtPCqDjOSgVvf7VmZ3yfxKSDxsCBL0uyErOtYp8SOnQHxWDy+Yx6z7I0/7Ys
	 hpLvza5FZXMegXzU4YlwNdiAcTN+DBKk1J51+L9Yu6E0k+WY3Az8SCe2UANbIjRwgbQiN
	 MkoOqfGKu5423ds/mPdlapQ42CSrFY7IkIjm44uLv+p9aevxZoOTKBz1ouKwAgtoJdfpd
	 FQAoDYNeyZtZpuxHX4AmNVYe+/A77pKjId2MYBCACZvYny8m2HlagK50es3z/y5TqePJo
	 KekUPCBIq3JohYO/zcty+EhW8Ll4PKH8PHuf6qXB6UWG45WAJ39h7y16yQ/aAhwxFlQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmx.de;
	dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=oAT5ezRD;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794238832;
	bh=+uyrvuFHf8wGcmC7fRkH4E8EwvQEyNHWQC3vkdTAxAI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fj4xx5lDRWX4RiHbsedP2gaM/MUJnlPEYwDRuZ+3WcChx0OOQmqW3mRyF9GZs6jH1
	 fdaDRl8bYuJVGGdNOs6f1wVlsb7kWdAHx70B/NS0Zkf1sLsGfddYcws80v/zL2wJJo
	 6b64DERonbPMAo6mjyMHJpisCuxkQVni+DdqFaycyS4VGv7I9nvbPc38aqurKzVHqP
	 dyniVie/4fsEN3l8gKEelvRCPzbEJ0Yqsmnp6L+BJIXcgyOTMRlXNdT6eQmfe8fOH2
	 AAw9/Wp57xzlsnrDNrZXmW/AjCtzmVo+s9x4U9uNnBB9BOZlwMcRPtWUJ5ShSIFNr6
	 TLl7PpcaRvTZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3EF8607C5;
	Mon,  9 Nov 2026 15:40:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 698F7932
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:40:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F78A607CB
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:40:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pEHZWWT-ggyw for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 15:40:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 669BC60703
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.227.17.20
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.20;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=oAT5ezRD
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 669BC60703
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1794238823; x=1794843623; i=xypron.glpk@gmx.de;
 bh=+uyrvuFHf8wGcmC7fRkH4E8EwvQEyNHWQC3vkdTAxAI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=oAT5ezRDjxGpc4QyPc/E4oogDPYbr34kFyBbuLCGM6djG5kUzi1N6woY5kuTISle
 m9zArMQk5M2bjDz7PjoVtb3ryGbTRUtJ0U2//4XSEIHzdWhnq2GrF3TygIu7ELnBZ
 nYX1gIIX1THcISC4uRZjbIlQi38M5zCX2thrK5JFUY0ZGXXb3JaXSoFTsu23GOELN
 0rdR59TfDLhohWdHEqsPGPoBJBJ6LymJV98ZgI4l+ezo/06QdCEYeZ/GjIzftgyYK
 5tL1m1k0d9XxRnPr7pN+hMh1ghQRGIcBYcG/Ppw1Rs7CyqpMFlJy/jUWxA1xxXTr1
 rMMl2vUsRCmGrKRxMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZktj-1wwwEK1leJ-00SbUv; Mon, 09
 Nov 2026 16:40:23 +0100
Message-ID: <7c93eb2f-f00a-4219-83aa-c2863c94a356@gmx.de>
Date: Mon, 9 Nov 2026 16:40:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] efi_loader: implement EFI_TIMESTAMP_PROTOCOL
To: Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: ilias.apalodimas@linaro.org, jan.kiszka@siemens.com, sjg@chromium.org,
 u-boot@lists.u-boot-project.org
References: <20261103093338.963328-1-felix.moessbauer@siemens.com>
 <20261103093338.963328-2-felix.moessbauer@siemens.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20261103093338.963328-2-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M85LL1+Uy/T3t206LAHTpQ0pc9j2zWpT3PUn7QX7arflXuoDsF6
 RlPy3gD9z0ipVxp0/IPt4GsMFUll04ZjRVPmXUEEOY5OjZCioId0F2/CHG7kxDXOzI5g02h
 /orxlvIxCuQxUYsSQBv5xkFoVEsGqGxNsy0kiN610fKaN+LYhlW12FcTlmD7R2Za2p51f7p
 veBYA1A9Gz68U0/g/BjOw==
UI-OutboundReport: notjunk:1;M01:P0:snBr554kbaE=;xYs7+CCA+e0Byu2WlI3MzFO9CQN
 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
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 10:33, Felix Moessbauer wrote:
> EFI applications such as boot loaders (e.g systemd-boot, efibootguard)
> measure the time spent inside the bootloader prior to loading the next
> stage. These values are then forwarded via efi variables to systemd,
> which exposes them via systemd-analyze. This helps to identify where in
> the boot chain delays are happening.
>=20
> Without having the protocol, bootloaders have to fall back to direct
> reads of the time counters, which are architecture specific. Implement
> EFI_TIMESTAMP_PROTOCOL in the EFI loader so that applications have an
> architecture-independent interface.
>=20
> As the implementation of the protocol is tiny, enable it by default. If
> this is not desired, set CONFIG_EFI_TIMESTAMP_PROTOCOL=3Dn.
>=20
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>   include/efi_api.h              |  4 ++
>   include/efi_loader.h           |  4 ++
>   include/efi_timestamp.h        | 35 +++++++++++++++
>   lib/efi_loader/Kconfig         |  8 ++++
>   lib/efi_loader/Makefile        |  1 +
>   lib/efi_loader/efi_setup.c     |  7 +++
>   lib/efi_loader/efi_timestamp.c | 79 ++++++++++++++++++++++++++++++++++
>   lib/uuid.c                     |  4 ++
>   8 files changed, 142 insertions(+)
>   create mode 100644 include/efi_timestamp.h
>   create mode 100644 lib/efi_loader/efi_timestamp.c
>=20
> diff --git a/include/efi_api.h b/include/efi_api.h
> index d4fdd50c49e..9789237b025 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -475,6 +475,10 @@ struct efi_runtime_services {
>   	EFI_GUID(0x3152bca5, 0xeade, 0x433d, 0x86, 0x2e, \
>   		 0xc0, 0x1c, 0xdc, 0x29, 0x1f, 0x44)
>  =20
> +#define EFI_TIMESTAMP_PROTOCOL_GUID \
> +	EFI_GUID(0xafbfde41, 0x2e6e, 0x4262, 0xba, 0x65, \
> +		 0x62, 0xb9, 0x23, 0x6e, 0x54, 0x95)
> +
>   #define EFI_DT_FIXUP_PROTOCOL_GUID \
>   	EFI_GUID(0xe617d64c, 0xfe08, 0x46da, 0xf4, 0xdc, \
>   		 0xbb, 0xd5, 0x87, 0x0c, 0x73, 0x00)
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 7b865fe900a..dd91c953776 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -384,6 +384,8 @@ extern const efi_guid_t efi_guid_cert_type_pkcs7;
>  =20
>   /* GUID of RNG protocol */
>   extern const efi_guid_t efi_guid_rng_protocol;
> +/* GUID of timestamp protocol */
> +extern const efi_guid_t efi_guid_timestamp_protocol;
>   /* GUID of capsule update result */
>   extern const efi_guid_t efi_guid_capsule_report;
>   /* GUID of firmware management protocol */
> @@ -674,6 +676,8 @@ efi_status_t efi_console_register(void);
>   efi_status_t efi_disks_register(void);
>   /* Called by efi_init_obj_list() to install EFI_RNG_PROTOCOL */
>   efi_status_t efi_rng_register(void);
> +/* Called by efi_init_obj_list() to install EFI_TIMESTAMP_PROTOCOL */
> +efi_status_t efi_timestamp_register(void);
>   /* Called by efi_init_obj_list() to install EFI_TCG2_PROTOCOL */
>   efi_status_t efi_tcg2_register(void);
>   /* Called by efi_init_obj_list() to install RISCV_EFI_BOOT_PROTOCOL */
> diff --git a/include/efi_timestamp.h b/include/efi_timestamp.h
> new file mode 100644
> index 00000000000..0fe0c41b62d
> --- /dev/null
> +++ b/include/efi_timestamp.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2026, Siemens AG
> + */
> +
> +#if !defined _EFI_TIMESTAMP_H_
> +#define _EFI_TIMESTAMP_H_
> +
> +#include <efi.h>
> +#include <efi_api.h>
> +
> +/**
> + * struct efi_timestamp_properties - properties of the timestamp counte=
r
> + *
> + * @frequency:	frequency of the timestamp counter in Hz
> + * @end_value:	value at which the counter rolls over to zero
> + */
> +struct efi_timestamp_properties {
> +	u64 frequency;
> +	u64 end_value;
> +};
> +
> +/**
> + * struct efi_timestamp_protocol - EFI_TIMESTAMP_PROTOCOL
> + *
> + * @get_timestamp:	retrieve the current value of the timestamp counter
> + * @get_properties:	retrieve the properties of the timestamp counter
> + */
> +struct efi_timestamp_protocol {
> +	u64 (EFIAPI *get_timestamp)(void);
> +	efi_status_t (EFIAPI *get_properties)
> +		(struct efi_timestamp_properties *properties);
> +};
> +
> +#endif /* _EFI_TIMESTAMP_H_ */
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index c4b0c2137b8..25e2c4b1144 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -469,6 +469,14 @@ config EFI_RNG_PROTOCOL
>   	  Provide a EFI_RNG_PROTOCOL implementation using the hardware random
>   	  number generator of the platform.
>  =20
> +config EFI_TIMESTAMP_PROTOCOL
> +	bool "EFI_TIMESTAMP_PROTOCOL support"
> +	default y
> +	help
> +	  Provide an EFI_TIMESTAMP_PROTOCOL implementation giving EFI
> +	  applications access to a monotonic 64-bit timestamp counter and
> +	  its frequency.
> +
>   config EFI_TCG2_PROTOCOL
>   	bool "EFI_TCG2_PROTOCOL support"
>   	default y
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 567db518a8f..8ff5468ae9a 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -67,6 +67,7 @@ obj-$(CONFIG_EFI_HTTP_PROTOCOL) +=3D efi_http.o
>   obj-$(CONFIG_ACPI) +=3D efi_acpi.o
>   obj-$(CONFIG_SMBIOS) +=3D efi_smbios.o
>   obj-$(CONFIG_EFI_RNG_PROTOCOL) +=3D efi_rng.o
> +obj-$(CONFIG_EFI_TIMESTAMP_PROTOCOL) +=3D efi_timestamp.o
>   obj-$(CONFIG_EFI_TCG2_PROTOCOL) +=3D efi_tcg2.o
>   obj-$(CONFIG_EFI_RISCV_BOOT_PROTOCOL) +=3D efi_riscv.o
>   obj-$(CONFIG_EFI_LOAD_FILE2_INITRD) +=3D efi_load_initrd.o
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index f302bb62ab9..f0b3e59c3e7 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -325,6 +325,13 @@ efi_status_t efi_init_obj_list(void)
>   			goto out;
>   	}
>  =20
> +	/* Install EFI_TIMESTAMP_PROTOCOL */
> +	if (IS_ENABLED(CONFIG_EFI_TIMESTAMP_PROTOCOL)) {
> +		ret =3D efi_timestamp_register();
> +		if (ret !=3D EFI_SUCCESS)
> +			goto out;
> +	}
> +
>   	if (IS_ENABLED(CONFIG_EFI_RISCV_BOOT_PROTOCOL)) {
>   		ret =3D efi_riscv_register();
>   		if (ret !=3D EFI_SUCCESS)
> diff --git a/lib/efi_loader/efi_timestamp.c b/lib/efi_loader/efi_timesta=
mp.c
> new file mode 100644
> index 00000000000..78cefd7a8c1
> --- /dev/null
> +++ b/lib/efi_loader/efi_timestamp.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2026, Siemens AG
> + *
> + * Provides access to a monotonic 64-bit timestamp counter.
> + */
> +
> +#define LOG_CATEGORY LOGC_EFI
> +
> +#include <efi_loader.h>
> +#include <efi_timestamp.h>
> +#include <log.h>
> +#include <time.h>
> +#include <linux/kernel.h>
> +
> +const efi_guid_t efi_guid_timestamp_protocol =3D EFI_TIMESTAMP_PROTOCOL=
_GUID;
> +
> +/**
> + * get_timestamp() - retrieve the current value of the timestamp counte=
r
> + *
> + * This function implements the GetTimestamp() service of the
> + * EFI_TIMESTAMP_PROTOCOL.
> + *
> + * Return:	current value of the timestamp counter
> + */
> +static u64 EFIAPI get_timestamp(void)
> +{
> +	EFI_ENTRY("");
> +
> +	return EFI_EXIT(get_ticks());
> +}
> +
> +/**
> + * get_properties() - retrieve the properties of the timestamp counter
> + *
> + * This function implements the GetProperties() service of the
> + * EFI_TIMESTAMP_PROTOCOL.
> + *
> + * @properties:	buffer receiving the properties
> + * Return:	status code
> + */
> +static efi_status_t EFIAPI
> +get_properties(struct efi_timestamp_properties *properties)
> +{
> +	EFI_ENTRY("%p", properties);
> +
> +	if (!properties)
> +		return EFI_EXIT(EFI_INVALID_PARAMETER);
> +
> +	properties->frequency =3D get_tbclk();
> +	/* get_ticks() extends narrower hardware counters to 64 bits */
> +	properties->end_value =3D U64_MAX;

Hello Felix,

As already mentioned in my mail

https://lore.kernel.org/u-boot/e54103ec-10c1-4342-8a2b-0e639ac0f6c1@gmx.de=
/

the end value is driver dependent.

Please, consider this in your v3. I am setting the status for this v2=20
series to "Changes requested" in patchwork.

Reviewing becomes easier if you add a change log to each individual=20
patch, e.g.

=2D--
v3:
	Make end_value driver dependent.
v2:
	no change
=2D--

Best regards

Heinrich


> +
> +	return EFI_EXIT(EFI_SUCCESS);
> +}
> +
> +static const struct efi_timestamp_protocol efi_timestamp_protocol =3D {
> +	.get_timestamp =3D get_timestamp,
> +	.get_properties =3D get_properties,
> +};
> +
> +/**
> + * efi_timestamp_register() - install the EFI_TIMESTAMP_PROTOCOL
> + *
> + * The protocol is installed on the root node.
> + *
> + * Return:	status code
> + */
> +efi_status_t efi_timestamp_register(void)
> +{
> +	efi_status_t ret;
> +
> +	ret =3D efi_add_protocol(efi_root, &efi_guid_timestamp_protocol,
> +			       (void *)&efi_timestamp_protocol);
> +	if (ret !=3D EFI_SUCCESS)
> +		log_err("Cannot install EFI_TIMESTAMP_PROTOCOL\n");
> +
> +	return ret;
> +}
> diff --git a/lib/uuid.c b/lib/uuid.c
> index 16ca8f37751..d7022519f0e 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -189,6 +189,10 @@ static const struct {
>   		NULL, "Random Number Generator",
>   		EFI_RNG_PROTOCOL_GUID,
>   	},
> +	{
> +		NULL, "Timestamp",
> +		EFI_TIMESTAMP_PROTOCOL_GUID,
> +	},
>   	{
>   		NULL, "Simple Network",
>   		EFI_SIMPLE_NETWORK_PROTOCOL_GUID,

