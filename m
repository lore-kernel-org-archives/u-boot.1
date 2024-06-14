Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5358C27C75
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 10:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47E5F88335;
	Fri, 14 Jun 2024 12:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="JozdOpMG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0347F8871F; Fri, 14 Jun 2024 12:11:44 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC7BA88256
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 12:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718359895; x=1718964695; i=xypron.glpk@gmx.de;
 bh=P7fzPn/DXIETHFQIGCSiQ55SYBZbABBDdwNoTMNRhE0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=JozdOpMGPhhQUyCepLXkzuIcvYyrbgC975eWYZoVePaAxMVoIeJBTuevmrmXSSVR
 jExbLz5RtkxQEHyelSOjPI+d3BalmQXlNlQmgocK/bIiQPm9q8jE7oof/oJbyyz1P
 oI/+gXiW69Sp+TJ0NDinrgbFMYbYXKfY0zoWX/NJ5kqHeYUvgGwH+C7FpjmnG3JkO
 L1FZftE0ZWwhZ7rU0XswoICaVZ9IQk9XKX1EzEDLCjH6Zd6YDJNy3glaV3ikzQIlh
 jrCGFWdUyFpFZYbRw6TpqlJy55L+tGWwWSMoiyszMYDkxOSClOamtlS9zU93hUVft
 RXOP7T2Z8aUN6hWTyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([178.202.41.25]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8hV5-1sMibG0TyL-00BskA; Fri, 14
 Jun 2024 12:11:35 +0200
Message-ID: <ab7c6516-8d03-4561-b4e7-f619799416ba@gmx.de>
Date: Fri, 14 Jun 2024 12:11:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: describe UEFI measured boot
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Eddie James <eajames@linux.ibm.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 heinrich.schuchardt@canonical.com
References: <20240614094031.6013-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240614094031.6013-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k9XfKDsA3qJA4fo74fGy7gbXWxmPE2/RYWJyN9t4/ST1eDYr9+R
 7CWhO5wLOaNo5ChX49H4lTIb2I5NHKnNwbQWyl6P9+WUVmS8ysKXwyDJ4fGs+2fqoRe56rC
 9Dx+RohF+n9jUGjuFnMfS9RUGoqIktFRcXx0wWRbG81EszkKDKy5en3LDd1GxCg7FWNHKbA
 /r1e0T9HAZf5p50B3xaDw==
UI-OutboundReport: notjunk:1;M01:P0:e0/88Ul+QmE=;pRjcRZYPr4VQvTPfYowsapY1D6N
 gpRHoL74kGjQJzMzITaYVkebWJBjujQzdaDfBn8GbUoICMjdFPl9NCBB090QpNPEOH5kTG4+p
 CVxIq4bWRGd0COV3FL28PG7aLpYpdUhn8yh3S+M0eKoFW9Z/jTFHbR2KfcvtzpBgo+R10CLlz
 wgnIhMMYIv1Xrt88k0ltDJhuxrMYvaR792lk8oGnUT8R7s4kaieFccwdjXwIudZraUxMYSYkH
 FMHczh2URlYO6LM+6orf+8/74oubvmsFcCbrgK3VoTm2JjO/ba/DyA1BudI+m1RiJQiok8q7G
 g4n5I9T9EhQldeqb9m9r7kaIjnJslniIGS22lGhMczvGQp2y4W036sDJJ5poBPLqoyIxjBbDC
 ISWOJ8mxi1GHiC4AKMouVAh7t1UMv86Y/Lb+xJCLILF5zyGGAfIq71kF6Gz43eASM44h8sNDc
 X5GOAdLfIo2Qas53N8TYFb7SsxbPdkUAiGQ3qgTHi6sQx8CtVRvw1pjKnVNVhEFV+ddUPhsYN
 deFLpnp3bkg08jw6zNod84UhPcXIxClEMFB+LYQLUW0+9yPIqECk6htAb1g12W9oJAIS22GIv
 VgMKSjYhIJzEYo2kF0aAh53RfYejHPwq7PonbeoTELQjvPgVQETkpOm7eA5rp+GI81UtAAEw+
 iuAU+v35Cfr9985BfOsR78gdV4Ak/Gjx3/U9iMcXLgnWDQr7wo2+tv3B0NHPxd7n4p20PqkHN
 SlZWru5R3V/N9JZe82xXn1feiM3mYfJ7ur1HfT5PAj1ZDLsPSlF0WTingck3jx0nMAgnrJ7xT
 lttbggRnkTqALV1b0muMRX0f14cuxCvXucXq4CM9H+Dsk=
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

On 14.06.24 11:40, Ilias Apalodimas wrote:
> We currently only describe the process to enable measured boot using
> bootm. Describe the UEFI requirements as well which predate bootm.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   doc/usage/measured_boot.rst | 24 ++++++++++++++++++++++--
>   1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/doc/usage/measured_boot.rst b/doc/usage/measured_boot.rst
> index 9691904a9d8a..1b5dd1dcc438 100644
> --- a/doc/usage/measured_boot.rst
> +++ b/doc/usage/measured_boot.rst
> @@ -7,6 +7,26 @@ U-Boot can perform a measured boot, the process of hash=
ing various components
>   of the boot process, extending the results in the TPM and logging the
>   component's measurement in memory for the operating system to consume.
>
> +The functionality is available when booting via the EFI subsystem or 'b=
ootm'

Thanks for adding a description for legacy measured boot.

@Eddie
Is it really only the bootm command? How about booti and bootz? Not
measuring there would be quite inconsistent.

Please, add a document link to doc/usage/cmd/bootm.rst.

> +command.
> +
> +UEFI subsystem

UEFI measured boot

> +--------------
> +The EFI subsystem implements the `EFI TCG protocol
> +<https://trustedcomputinggroup.org/resource/tcg-efi-protocol-specificat=
ion/>`_
> +and the `TCG PC Client Specific Platform Firmware Profile Specification
> +<https://trustedcomputinggroup.org/resource/pc-client-specific-platform=
-firmware-profile-specification/>`_
> +which defines the binaries to be measured and the corresponding PCRs us=
ed.

to be used.

> +
> +UEFI requirements
> +~~~~~~~~~~~~~~~~~
> +* A hardware TPM 2.0 supported by the U-Boot drivers

by an enabled U-Boot driver.

> +* CONFIG_EFI_TCG2_PROTOCOL=3Dy
> +* CONFIG_EFI_TCG2_PROTOCOL_EVENTLOG_SIZE=3Dy
> +* optional CONFIG_EFI_TCG2_PROTOCOL_MEASURE_DTB=3Dy will measure the lo=
aded DTB in PCR 0

Why does this setting not default to yes?

Should EFI_TCG2_PROTOCOL_MEASURE_DTB depend on !GENERATE_ACPI_TABLE as
we won't load the device-tree in this case?

I can't find any reference to device-trees in `TCG PC Client Platform
Firmware Profile Specification`. Where is PCR 0 for the device-tree
specified? I read:

"In general, the platform firmware measures into PCR[1] the
configuration data that is associated with the code that measured into
PCR[0]".

This looks like PCR 1 should be the target for the device-tree.

Do we already measure ACPI and SMBIOS tables into PCR1 as required by
the specification.

> +
> +bootm

Measured legacy boot with bootm command

Please, consider in your description that the bootm command may be used
to load a FIT image with an EFI binary.

> +-----
>   By default, U-Boot will measure the operating system (linux) image, th=
e
>   initrd image, and the "bootargs" environment variable. By enabling
>   CONFIG_MEASURE_DEVICETREE, U-Boot will also measure the devicetree ima=
ge.
> @@ -15,8 +35,8 @@ The operating system typically would verify that the h=
ashes found in the
>   TPM PCRs match the contents of the event log. This can further be chec=
ked
>   against the hash results of previous boots.
>
> -Requirements
> -------------
> +bootm requirements

This is already a sub-section of bootm. No need to repeat it.

> +~~~~~~~~~~~~~~~~~~
>
>   * A hardware TPM 2.0 supported by the U-Boot drivers

by an enabled U-Boot driver.

>   * CONFIG_TPM=3Dy

CONFIG_TPM_V2=3Dy is required?

Best regards

Heinrich



