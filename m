Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9A2CD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 13:40:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E950F848FC;
	Tue,  5 May 2026 15:40:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eEpRB/LL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E04918491D; Tue,  5 May 2026 15:40:30 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 343AE848B9
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 15:40:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso50858305e9.2
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 06:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777988427; x=1778593227; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S4Eu69201fNfOjAELpTOw1mOFWua5oEV1qIfHDfONKA=;
 b=eEpRB/LLBBfwXC3ks4IYjfIGxCfFhash+/e7mWyys4ldnp1oM5rXXnPnVDwu6unimB
 awKqRXsgMPQxtaowLhRPrpMGnhelciOPDtgHE+eB54EPI+eGRFKQTLXTjwWGvSSqU/Nj
 wZWNX4oJUtaiuOETADd1dZLHJvOUnGrKX0nuHeCxDvxxEh+KOZSpFhmfJO9We9GILXUF
 5EKQoPHAYUQUWh6mfafKj+Vu/hNd2p/6nKuMI/PLm3i6VRjHE5XOaSqUARTMkhTks6MM
 VNj2rR7gYwTsSWRl4Qxb6D+nAVrNfCVN5nxAUaDR8UilYBvJXv0En6z2IS+xwLEOcpVW
 nQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777988427; x=1778593227;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S4Eu69201fNfOjAELpTOw1mOFWua5oEV1qIfHDfONKA=;
 b=bL0eXkVqlmKLoi2MCjWPjagWHKs0QMEkvaDDIyETGhnmDq+vKTLOy0QVQYHdG3LLzH
 SeWziA5bqgUte9RAYKAztgyt4mHdeY5WmZSwudlwPcezI43cny5xyyHXN1UTDW2k5TDn
 MRvipgLkl+A/jx4vXWWyp3qX4XqFtUY3BKm87hSbT6sLNqXAEBU8U5oGJaV/v+DgkrUV
 AxQ+llfl8+N9vqABjyKs0cSpHS8JiI2PCLx7g+yAGbVb+noaOAXUAkQM44d/Cx2HKxQs
 BHzuLB3TTPVJa1/8rHsI/mzGinyg+uafsYj6yX0fIotrc3Oyo3p6HHf47e3jNjaoQUne
 XREw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8164U8HCDfZgG5Xgu5+gjgltciP7VK0Q5l1KuaumYi4HCZX4OPy9RXUIyK65+Sf2EkTNfoXjc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+CIYiF+nfi2kb4hbl/+acdwJSR3nTzADTKw6VgvLTIscdLjwd
 gfLtcKXqGTRVRzSPxy21eF/mvVyLfhc8xmGbcnQCtND9cNh+CZ1Vi35+99XnTBGRFoHJIv7Ecjo
 1QI7du6M=
X-Gm-Gg: AeBDietmsdrDVfImgamghjpuT8uMImH5aqYhsikbugLUACRpyCql6pmzuRHJ8LC16LN
 EUMyiYJL2Io/CJHJFhG9SNeoMsXsZrAtNPlC6GZOqmq6or8h0tQ1NFd+AHpjLfeAEc6dkY7rJP3
 Qoe8JQdvsqImVZfnYNLHAn99nMK8FXAgcsP3p41LA43tXqY8+1ksw3VRSJGZrjuTr5Su4B45JRj
 +64BDp1h/x6Gu5HXRSNX65EJaeqMK4RgIsUH2BHqVDGDY3OFIAoKfKDfXfzY6CB0Y7O8nZR86jJ
 9sFSRa9tGts3vEIDNrAjYmcC0ykTswNURZpf+IqfWUkW5oOqW7hyknRwD/mOGiUDcatkZTE24RF
 CQ581HZ81C8yhn3tbxvyNj5asHSLyh23+VkcgwU0X9Oc0F/UxgBoqfsxxYdblVPKObqDurMMzMR
 1m+U9B4lae/i+Gqh028i+a9kc8K5MFnniz8KpcjwcOl9pPrh6ySVLvd0+dTzGAJmHkmYtNw7xrw
 5g8WvsPe3xuGxk=
X-Received: by 2002:a05:600c:a309:b0:48a:563c:c8c0 with SMTP id
 5b1f17b1804b1-48d187d869emr41317715e9.7.1777988426555; 
 Tue, 05 May 2026 06:40:26 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb6fffcsm374000705e9.4.2026.05.05.06.40.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 06:40:25 -0700 (PDT)
Message-ID: <0a09d8bc-c140-4e49-b83e-e2d592837191@linaro.org>
Date: Tue, 5 May 2026 15:40:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: qcom: dragonwing: Improve build and installation
 documentation
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260503-iq9-v1-1-0eb29e4f8dc8@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260503-iq9-v1-1-0eb29e4f8dc8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 03/05/2026 06:34, Balaji Selvanathan wrote:
> Enhance the Qualcomm DragonWing board documentation with clearer
> and more detailed build instructions.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  doc/board/qualcomm/dragonwing.rst | 112 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 98 insertions(+), 14 deletions(-)
> 
> diff --git a/doc/board/qualcomm/dragonwing.rst b/doc/board/qualcomm/dragonwing.rst
> index d4899415309..fbb50a90290 100644
> --- a/doc/board/qualcomm/dragonwing.rst
> +++ b/doc/board/qualcomm/dragonwing.rst
> @@ -4,9 +4,11 @@
>  Qualcomm DragonWing
>  ========================================
>  
> -Qualcomm DragonWing are industrial-grade boards that provides various series
> -of processors such as IQ6 (QCS615), IQ8 (QCS8300) and IQ9 (QCS9100).
> -These SoCs are used for factory/industry based applications.
> +Qualcomm DragonWing boards are industrial-grade platforms targeting factory
> +and edge applications. They span multiple product families, including
> +IQ6, IQ8, and IQ9, which are based on Qualcomm QCS615, QCS8300, and
> +QCS9100 series SoCs respectively
> +
>  More information can be found on the `Qualcomm's IQ6 product page`_,
>  `Qualcomm's IQ8 product page`_ and `Qualcomm's IQ9 product page`_.
>  
> @@ -16,33 +18,115 @@ More information can be found on the `Qualcomm's IQ6 product page`_,
>  
>  Installation
>  ------------
> -First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``QCS615``, ``QCS8300`` or ``QCS9100``::
> +
> +Prerequisites
> +~~~~~~~~~~~~~
> +
> +Download the qtestsign utility:
> +
> +.. code-block:: bash
> +
> +  $ git clone https://github.com/msm8916-mainline/qtestsign qtestsign
> +
> +Build Steps
> +~~~~~~~~~~~
> +
> +Download the U-Boot source code. See the :doc:`../../build/source` documentation
> +for instructions on obtaining the U-Boot source.
> +
> +Go to the U-Boot source directory:
> +
> +.. code-block:: bash
> +
> +  $ cd u-boot
> +
> +Configure the build for desired platform. This command creates the required
> +configuration files in the .output directory. Following gives command for each
> +platform (choose based on your platform):
> +
> +Generate the default configuration for the IQ-615 platform:
> +
> +.. code-block:: bash
> +
> +  $ make O=.output qcom_qcs615_defconfig
> +
> +Generate the default configuration for the IQ-8 platform:
> +
> +.. code-block:: bash
> +
> +  $ make O=.output qcom_qcs8300_defconfig
> +
> +Generate the default configuration for the IQ-9 platform:
> +
> +.. code-block:: bash
> +
> +  $ make O=.output qcom_qcs9100_defconfig

Could you update this to lemans and fold it in with the rename patch?

> +
> +Build U-Boot using the cross compile toolchain. First, setup ``CROSS_COMPILE``
> +for aarch64:
> +
> +.. code-block:: bash
>  
>    $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> -  $ make qcom_qcs8300_defconfig
> -  $ make -j8 u-boot.mbn
> +
> +Compile the U-Boot source using the GCC cross compile toolchain:
> +
> +.. code-block:: bash
> +
> +  $ make -j8 CROSS_COMPILE=<aarch64 toolchain prefix> O=.output
> +
> +.. note::
> +   Some toolchains may treat incompatible pointer types as errors.
> +   The extra KCFLAGS argument can be used to work around this when needed:
> +
> +   .. code-block:: bash
> +
> +     $ make -j8 KCFLAGS+=" -Wno-error=incompatible-pointer-types" CROSS_COMPILE=<aarch64 toolchain prefix> O=.output

Does this happen with any compiler that U-Boot supports or is it
specific to something you have internally? If there are compile errors
with some recent GCC please send fixes for that and keep stuff like this
in your internal documentation.

> +
> +Expected result:
> +
> +- The U-Boot build completes without errors.
> +- The ``u-boot.elf`` file is available in the ``.output`` directory and is ready for further packaging or flashing.
> +
> +Convert U-Boot image (ELF to MBN)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  Although the board does not have secure boot set up by default,
>  the firmware still expects firmware ELF images to be "signed". The signature
>  does not provide any security in this case, but it provides the firmware with
>  some required metadata.
>  
> -To "sign" ``u-boot.elf`` you can use e.g. `qtestsign`_::
> +Move to .output folder:
>  
> -  $ qtestsign -v6 aboot -o u-boot.mbn u-boot.elf
> +.. code-block:: bash
> +
> +  $ cd .output
> +
> +Generate the signed MBN image. To "sign" ``u-boot.elf`` you can use e.g. `qtestsign`_:
> +
> +.. code-block:: bash
> +
> +  $ python <qtestsign path>/qtestsign.py -v6 aboot -o u-boot.mbn u-boot.elf
> +
> +This command generates the signed u-boot.mbn file required for flashing.
>  
>  Then flash the resulting ``u-boot.mbn`` to the ``uefi_a`` partition
> -on your device with ``fastboot flash uefi_a u-boot.mbn``.
> +(or the appropriate UEFI partition for your board):
>  
> -U-Boot should be running after a reboot (``fastboot reboot``).
> +.. code-block:: bash
> +
> +  $ fastboot flash uefi_a u-boot.mbn
>  
> -Note that fastboot is not yet supported in U-Boot on Dragonwing boards, as a result, to flash
> -back the original firmware, or new versoins of the U-Boot, EDL mode must be used.
> +U-Boot should be running after a reboot (``fastboot reboot``).
>  
>  A tool like bkerler's `edl`_ can be used for flashing with the firehose loader (for example, for QCS9100
> -the firehose loader can be obtained from `dragonwing IQ9 bootbinaries`.) ::
> +the firehose loader can be obtained from `dragonwing IQ9 bootbinaries`).
> +
> +For example:
> +
> +.. code-block:: bash
>  
> -$ edl.py --loader /path/to/prog_firehose_ddr.elf w uefi_a u-boot.mbn
> +  $ edl.py --loader /path/to/prog_firehose_ddr.elf w uefi_a u-boot.mbn
>  
>  .. _qtestsign: https://github.com/msm8916-mainline/qtestsign
>  .. _edl: https://github.com/bkerler/edl
> 
> ---
> base-commit: bb0f3eebb3c196d9b6efbbd1e5aa9b16abbb9ad6
> change-id: 20260503-iq9-868091a47496
> 
> Best regards,

-- 
// Casey (she/her)

