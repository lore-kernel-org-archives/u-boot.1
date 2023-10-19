Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD21CDB484
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 18:25:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE9688749F;
	Thu, 19 Oct 2023 20:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="PHgho3oD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5CD0874AB; Thu, 19 Oct 2023 20:25:53 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E65318746F
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 20:25:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697739739; x=1698344539; i=xypron.glpk@gmx.de;
 bh=GMUecOtrut1xJbIWcj4MhsbRk2eDU5GtA/yCEGgiB8Q=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=PHgho3oDIgNRIN74NLYAc8HSJ3txWAJBaFNTSCXQqkseT3Hzf6ddT+uWht9vRFEl
 On5GlLnLB4+BOHlPZz+Sa7qed5xSzEtDL1R80T4W0NwBgYZTrMbMQ4ygASsa6rRw3
 rrGdLAT0O45Ih6AskYPedN6DNVLRfZI1JkFnd/R0bU12L4cq53qymfbq7s3A82ALw
 jBwZZ/sUzjkO6OePaB8GOqUlAvuf5ix3goKf7nyiF2176GLR/n4+qOHXIES7pLsav
 /z1Xn6b3MjK38mWWmBE+Kes3C2qIyibTy8zVKsBi0kO7uGoagbN0rWM52G0XrZeix
 uAOZNbyeorArsm0YEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNsw4-1r8ra72vhQ-00ODgi; Thu, 19
 Oct 2023 20:22:19 +0200
Message-ID: <ad33807d-815a-401d-a258-ae43d21c6aad@gmx.de>
Date: Thu, 19 Oct 2023 20:22:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 6/8] doc: Add measured boot documentation
Content-Language: en-US, de-DE
To: Eddie James <eajames@linux.ibm.com>, ilias.apalodimas@linaro.org
Cc: sjg@chromium.org, u-boot@lists.denx.de
References: <20231019162156.80982-1-eajames@linux.ibm.com>
 <20231019162156.80982-7-eajames@linux.ibm.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231019162156.80982-7-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v7jooymdAY3L+EIhiE+pkgboWa0MInU8sVlkatqzY6ySwW2uuT/
 8iVN8nV4OjLsCMP/BbBOiPhag39L0NLWrBQlphScB0bzglxogBU6ZsHc5r4DD5lsArbbITG
 cN9vUCNrE8nbNKWotCiYSZXXQEvMEXTx5JC9AcdmAL0QcW3do5FqFXtidybtfNOOoDGfd0p
 WQFg9ZfphdbcNftVscdlg==
UI-OutboundReport: notjunk:1;M01:P0:3bR1ceXXexs=;9hlMG1hI/pxi1JggktaY1EGwrZB
 wZUq5A33SFWAXMsDf92fXGGvM4Af58IladkWolI6PmuA+WGG5AeoS2k2caT7oEmPYG1HQunbk
 QrRouoTizp7jB9iwdv1Q76ZU1cqgJl0AhLt9DqC5TD5lhgW2E6Wg1l4Y0rJW++pE541wCDHue
 s2vQMrF8zQDPu3RzspSulO7DViPhct6PG8JZkO5bTstOkX3P/0S1qIz6hj+XlJfeEnbJqbIvV
 3DcuV0kGnPm+m4GmhPPotQNUzzOeMdxRo+tYNzKyYRsxZWZsEFgKmXLxYH7mRGx0o5laPl+35
 pAjm5aOOp9nnwP6cStaVSinVbYg7HoLaLiBz2iJppYMG3s7Nhb8JQjOCarEagSfh9MlxCYT3a
 rGclYBQwt+AD62VuIAmGaYs0rhCbzN104w7ITLV6wqia3PLJ5gKCv5Mzm3+vpudHEzUUPKPsK
 NItu7M816BhKTU222YgHuIi2+4Hm/5PzrZGrk7z52XAIYbcmMP4tLqcl1O7596/mgCd9NVPCv
 MryIXkVmqkUQH0L/mfz+ZPgQeHeaLCO759eNTqu3/W9QlQtTdZccv9gPfVG+cA9M6YA3w+Spo
 LN691nQe81KkwtyosZizWOZDuwH23LnMO2Rj1bMgUGMGu+Og88gXDvWL8tXDPy+mUMlNbkx2s
 wmh0PP/sfz0R/W8JO8k9PDH1RY2zpG3bG0mj83FZJQQJYNYzJXzco5tqV0ZklT/qe1Ouug3T4
 oAIoYsf7L0HOoDS1XN1Qro1uxC7TIzEX5gfu1Y/gaPLeHLMvu4C7tufcWZ9QjK6e1A3Bsvo+P
 oiGijwz5xW3IARohIpPF/GN7EhaboqVulRiFfO7mblw/FAz3+K8iZncouwmohBfHHofKl+Q4J
 zvNdmJNUU2574H8Q+5XGytYZwPJGJqcwuzX8oJ78oYnXiARArMod1hDL9gDi85gynTGs75X0N
 dX66IA==
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

On 10/19/23 18:21, Eddie James wrote:
> Briefly describe the feature and specify the requirements.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Changes since v12:
>   - Add a bit of detail about OS usage and what pieces are measured
>
>   doc/usage/index.rst         |  1 +
>   doc/usage/measured_boot.rst | 31 +++++++++++++++++++++++++++++++
>   2 files changed, 32 insertions(+)
>   create mode 100644 doc/usage/measured_boot.rst
>
> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
> index 98b4719c40..bf53bb6bda 100644
> --- a/doc/usage/index.rst
> +++ b/doc/usage/index.rst
> @@ -14,6 +14,7 @@ Use U-Boot
>      partitions
>      cmdline
>      semihosting
> +   measured_boot
>
>   Shell commands
>   --------------
> diff --git a/doc/usage/measured_boot.rst b/doc/usage/measured_boot.rst
> new file mode 100644
> index 0000000000..0aad590859
> --- /dev/null
> +++ b/doc/usage/measured_boot.rst
> @@ -0,0 +1,31 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Measured Boot
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +U-Boot can perform a measured boot, the process of hashing various comp=
onents
> +of the boot process, extending the results in the TPM and logging the
> +component's measurement in memory for the operating system to consume.
> +
> +By default, U-Boot will measure the operating system (linux) image, the

The OS image would mean the root file system? I guess you mean the
loaded EFI binary here. Measured boot is not Linux specific.

We should consider different scenarios:

* U-Boot loading kernel, initrd, device-tree
* U-Boot loading GRUB (or another boot manager), device-tree,
   GRUB loading initrd
* U-Boot loading GRUB and passing a device-tree to GRUB,
   GRUB loading initrd and a new device-tree

With the documentation the user should be enabled to understand what
U-Boot measures in each of these cases. Please, observe that upstream
GRUB uses LoadImage() while distros (e.g. Debian and Ubuntu) tend to
bypass LoadImage().

Arent't there some other objects measured?

- SMBIOS table
- ACPI tables (still to be implemented)
- EFI variables

Best regards

Heinrich

> +initrd image, and the "bootargs" environment variable. By enabling
> +CONFIG_MEASURE_DEVICETREE, U-Boot will also measure the devicetree imag=
e.
> +
> +The operating system typically would verify that the hashes found in th=
e
> +TPM PCRs match the contents of the event log. This can further be check=
ed
> +against the hash results of previous boots.
> +
> +Requirements
> +---------------------
> +
> +* A hardware TPM 2.0 supported by the U-Boot drivers
> +* CONFIG_TPM=3Dy
> +* CONFIG_MEASURED_BOOT=3Dy
> +* Device-tree configuration of the TPM device to specify the memory are=
a
> +  for event logging. The TPM device node must either contain a phandle =
to
> +  a reserved memory region or "linux,sml-base" and "linux,sml-size"
> +  indicating the address and size of the memory region. An example can =
be
> +  found in arch/sandbox/dts/test.dts
> +* The operating system must also be configured to use the memory region=
s
> +  specified in the U-Boot device-tree in order to make use of the event
> +  log.

