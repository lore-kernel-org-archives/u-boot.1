Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6772C27C79
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08CF388641;
	Fri, 14 Jun 2024 14:35:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="lQvr6suT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB851888F6; Fri, 14 Jun 2024 14:35:35 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69625883F6
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718368528; x=1718973328; i=xypron.glpk@gmx.de;
 bh=mN0nPDeHAsGZISHkg+fJIm9Jf658NniaSXHeHWlS2dc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=lQvr6suTbsEyR9wqYvfI4pzewn0bNQJZoOop1Humo1wRsIAfe9WvsghvHWqgVMo6
 3YTw27awrZ5GZU1jtVAaBH9akUJte5XYYdXZFDiTCFEhWlzaN1BRriz8M2VCLg6GM
 MZE3Vo/Buapk6CDadi1X0W077dXA7GM+sU0iFvRIUCEV31P+y0paPVtI60NBLDWSR
 v7FkURTGwb0Hvzrlexzoj8qmjv/9cYxqHCUqYjuecPhi6IsyeVsbev0qOvD1WfNcq
 CV3yrOvXrCbiPqWxH1cRCKqbm7fwd3p0R/YGDLO3b7Z+MR4yS+3FysIhZVGaT37CY
 /bIogggFwDCaiVFbTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([178.202.41.25]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgvvT-1ssmoX0Yfd-00gkfk; Fri, 14
 Jun 2024 14:35:28 +0200
Message-ID: <b9307a87-5c4b-4ef3-b635-86879b2a9742@gmx.de>
Date: Fri, 14 Jun 2024 14:35:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: describe UEFI measured boot
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>, u-boot@lists.denx.de
References: <20240614121404.16952-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240614121404.16952-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1Yj1YBpZJUny9BsDPn4vpVqjuDlIGsXqbEaWMROZc/QUS9HHdCf
 4Q6/spprk/EcfCH65SkX7J7MG4mQ6CbHzaYuQSm2NSxR88Gl62SPUDTVXGyD6fFXY4BTl5+
 BbaxsvcnaoTOYH1pC9K+c/1IqpXtR0IB7nVsP7dJPVUw9s04iIwSdxRN0UnQPrz+ypvGLoF
 p5Zq6e53htfW9sLzXkRlA==
UI-OutboundReport: notjunk:1;M01:P0:mTc67++QslQ=;u/vU3uvN3q+wsoC1ElQwcJLEG5t
 8QC/oIKZ2iuz+Q40zQofsFeLztMLA43cE5MnSlwL1hAlZOrFXMFJlGED5Xme7Zq2nIj+0ZOfl
 WLG5HGYu0P9fDnWsmERL4Aj97ifVTJsLFsXOfqU6YZxiCD4dZISTmAM9nsK47C4z+93H7utfJ
 +01M/fynIjC57IVNh33FEBruXfUvsrg889NRoOfMGgkpdL9tU5P/IfwV0iYUJ60gvlT46n896
 B3bCTXFQjldRNsdq/IqE1Pdhq2nK/1QSdrMg0RQ9GrbgAivj9bG7X7y91GLpT7eS+yfpFHgPe
 IrQBE/RqiVkonix5VQFc8q2N4QHYIG37MGkWMMzzgHIEcNGeurRbbnDjvruXMD7f4CgwfWI/P
 w/4oEBtS7CaK4htBG3l9J241jp9nFYktwJkFpr0XZfGdu0/1VD/cOU8OE1ykI6aEgXhQPs9Mh
 oClVAqTNIYh5x9UMkaaHBgZhbAy9KTOpjhjr7FmC3QQhfhgiy/eOKrAgNu3/HV7uuPSLjaqQB
 mT0PWsPXDqVBujFjtC+uIBtL1EB7eJRztqBtoenM6E2YdytPcg/I0SfTNuJRjreGMMQg4U9m9
 uw/k87KXbhYGmTCn2NF+CVB8hTKCd/mugoWECmVs33zqiWCA8qMnjesahzRtWyVW1XjpByGAU
 QqjJr8slHXLvYxBfsVXcheL/QnUrXWPgYcbH7JPQKn4PA5tul5pCrKs8NILL4wnw/2/YH+kVh
 cA3TotLFN27lpgomRM4oR3M/l7EAXF/xWIEQoK/VBre+flR1PVuhDQ7N8xB614nngLULjyYqB
 RfTml9ELit//+zXOFF6x/z8Cu1lWX4rFBWb/aetREO+nI=
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

On 14.06.24 14:14, Ilias Apalodimas wrote:
> We currently only describe the process to enable measured boot using
> bootm. Describe the UEFI requirements as well which predate bootm.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes since v1:
> - fixed remarks from Heinrich on titling and DTB measured PCR
>   doc/usage/measured_boot.rst | 28 ++++++++++++++++++++++++----
>   1 file changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/doc/usage/measured_boot.rst b/doc/usage/measured_boot.rst
> index 9691904a9d8a..b5f7b05aeb02 100644
> --- a/doc/usage/measured_boot.rst
> +++ b/doc/usage/measured_boot.rst
> @@ -7,19 +7,39 @@ U-Boot can perform a measured boot, the process of has=
hing various components
>   of the boot process, extending the results in the TPM and logging the
>   component's measurement in memory for the operating system to consume.
>
> +The functionality is available when booting via the EFI subsystem or 'b=
ootm'
> +command.
> +
> +UEFI measured boot
> +------------------
> +The EFI subsystem implements the `EFI TCG protocol
> +<https://trustedcomputinggroup.org/resource/tcg-efi-protocol-specificat=
ion/>`_
> +and the `TCG PC Client Specific Platform Firmware Profile Specification
> +<https://trustedcomputinggroup.org/resource/pc-client-specific-platform=
-firmware-profile-specification/>`_
> +which defines the binaries to be measured and the corresponding PCRs to=
 be used.
> +
> +Requirements
> +~~~~~~~~~~~~
> +* A hardware TPM 2.0 supported by an enabled U-Boot driver
> +* CONFIG_EFI_TCG2_PROTOCOL=3Dy
> +* CONFIG_EFI_TCG2_PROTOCOL_EVENTLOG_SIZE=3Dy
> +* optional CONFIG_EFI_TCG2_PROTOCOL_MEASURE_DTB=3Dy will measure the lo=
aded DTB in PCR 1
> +
> +Measured legacy boot with bootm command
> +----------------------------------------

nits:
The length of the underline should match.

All of bootm, booti, and bootz invoke bootm_run_states() which calls
bootm_measure():

   Measured legacy boot
   --------------------

   The commands booti, bootm, and bootz can be used for measured boot
   using the legacy entry point of the Linux kernel.

Otherwise looks good to me.

Best regards

Heinrich

>   By default, U-Boot will measure the operating system (linux) image, th=
e
>   initrd image, and the "bootargs" environment variable. By enabling
> -CONFIG_MEASURE_DEVICETREE, U-Boot will also measure the devicetree imag=
e.
> +CONFIG_MEASURE_DEVICETREE, U-Boot will also measure the devicetree imag=
e in PCR1.
>
>   The operating system typically would verify that the hashes found in t=
he
>   TPM PCRs match the contents of the event log. This can further be chec=
ked
>   against the hash results of previous boots.
>
>   Requirements
> -------------
> +~~~~~~~~~~~~
>
> -* A hardware TPM 2.0 supported by the U-Boot drivers
> -* CONFIG_TPM=3Dy
> +* A hardware TPM 2.0 supported by an enabled U-Boot driver
> +* CONFIG_TPMv2=3Dy
>   * CONFIG_MEASURED_BOOT=3Dy
>   * Device-tree configuration of the TPM device to specify the memory ar=
ea
>     for event logging. The TPM device node must either contain a phandle=
 to
> --
> 2.45.1
>

