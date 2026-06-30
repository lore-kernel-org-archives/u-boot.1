Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4CFC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:50:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92A8884A7B;
	Tue, 30 Jun 2026 14:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U8eD0Hby";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27C6184A3E; Tue, 30 Jun 2026 14:01:21 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB8208484C
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 14:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-493b7612475so8228675e9.3
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 05:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782820876; x=1783425676; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oYIdUiWB7GOMBubgCL+7KAjk9wbrIrAVbHgYSCAJ4uA=;
 b=U8eD0Hbyqh3VnZAAHEQ0XvZORTWHxoP6ds490DcRps8++LzEmztebu+Z3OxvnK6XAH
 /tNKb0r3NROs0LSuRfkBQLxt3p8Q57uki3y0qL2JkqBiNwFaff/aaEHU1QxrXYVc5LbV
 yy8HWR639mhvM+pc/EgczOWF/PBNB1jqohZ2eq8VJZhDEBmzOKIoj0rEDWULUhlqWkzM
 5MfPy/ExDlU052k7eNmyI2LgHcbFi5YMDWOnwi8G0AQkmXxWnLIDRLjsFXNPYjPcG1vj
 dZ6DOsN/HYdeRyfkyS/+wwXKQ/bxVbX3OvkxTJR6JiNBybZQyVSG+Lt4IghnS/VO9J3H
 i64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782820876; x=1783425676;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oYIdUiWB7GOMBubgCL+7KAjk9wbrIrAVbHgYSCAJ4uA=;
 b=hy/ICnycQDzSLH2arQ4vs+hCQNGFKI9lUIUGotICQ4JBgoZsqu4SNX8AnsZT5RdexW
 dzvbzQaork6sVL4nO8L230UMZW0i6ZZ1jYbazNAml2NXWYtA6fZOxvBOp7/WN23yRaup
 4ZSSaVW68qyzYtRLkHzhSJXXBiUjjC+wb594qiHH1x2uKNl7CRiAgotFyJKEVHzDdpG5
 4UIkvyACDgeQG4IwapZHBzDK3AIdF1LK+4tpXzXEWwxA3EFbsu7XcmettAaFSJP2FYBK
 ioe4gh9G19o3b90Ynx1wq0Uoi2wf85q4ms2hyvph9OqYlDism0pcWKRPvpuiLbSyuis9
 rq9w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GP+AP+dO0QG4WXGTPF3jHBh3m1+eREaNsaWlo7yv3MqlZJBOSCe7gl4gXdjyNBHrL5CmoG8k=@lists.denx.de
X-Gm-Message-State: AOJu0Yyl5TogmOmdSMqr4QIs3iMswYN7FGnu3Lkp69jCEwfW/46GRaWN
 ka2AhRQnxHhQS/LYigbi/UtzHCGX8XN68L8+5046wixiGyylzNg8onJylmDP54uJ/M8=
X-Gm-Gg: AfdE7cnNrtFCAnNqmi0WYqcWssE4kAKKG4Cr0DTswYYUmekCknJBg5saRg1brV2U+9V
 CGSx0AuCsYie5Go8jkCobDs567zpJn4mtJEnBvHmh48EOVW0LckfHy1K1vQYuppLophFah1L8rY
 M2PKW0dugPUpHbc34XpZP47hJcBB0sLTuy9hpSf2wL076ZT3YLO3LuJbyyohMHMPKGg6SU5HSaU
 9R7paUwk0AyloTUIyd800qA1QfUsuZce6VPfIkfUrEFXB95IeDk37wPdTgqvgcY3r49MaBA5eL3
 ulwveL+lPpkqin9GXpL22RmO/FIUkywEyx5RJJ1lYPq/8ZaiJr1m5JFi0eJobiSkov1x9WHMYYT
 DbGnYMm+SonDX/nz+V9UuGAwo9JbtLjQWtV0mT/IbWX+8foGFJ7f2uQ9kmnicOcg4uUckT5RZbE
 VNpyn/h2opN8VWOa/QnAFNzbL33Zz/5Xkmzur5Qg==
X-Received: by 2002:a05:600c:4f8b:b0:493:b7ca:4b32 with SMTP id
 5b1f17b1804b1-493b827cb5emr51752275e9.1.1782820874909; 
 Tue, 30 Jun 2026 05:01:14 -0700 (PDT)
Received: from [172.16.185.106] ([195.76.196.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8c79baasm65987715e9.7.2026.06.30.05.01.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 05:01:13 -0700 (PDT)
Message-ID: <78ff6a8d-5c63-4bc2-bf1e-6b71b8f9c6cf@linaro.org>
Date: Tue, 30 Jun 2026 14:01:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/11] doc: board/qualcomm: Update RDP build
 instructions
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, lukma@denx.de, tien.fong.chee@altera.com,
 anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, marek.vasut+renesas@mailbox.org,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com, alchark@gmail.com,
 mkorpershoek@kernel.org, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com, ycliang@andestech.com,
 n-francis@ti.com, mateuslima.ti@gmail.com, jamie.gibbons@microchip.com,
 david.wronek@mainlining.org, james.hilliard1@gmail.com,
 philip.molloy@analog.com, ravi@prevas.dk, sughosh.ganu@arm.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260623064804.3988799-12-varadarajan.narayanan@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260623064804.3988799-12-varadarajan.narayanan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:13 +0200
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



On 6/23/26 08:48, Varadarajan Narayanan wrote:
> Add details about the SPL & U-Boot proper build steps, converting to
> flashable images, source URLs for the needed binaries and scripts.

Additionally, this should be updated to use mkmbn.py which includes mbn 
v7 support.... As for create_multielf.py, does it do anything that "cat" 
doesn't ????

I think it would be pretty simple to expand the match table in mkmbn.py 
and have it check for the TME elf and append it when building for this 
platform (so it would output a u-boot-spl.mbn AND u-boot-spl.melf), just 
add another build target in board/qualcomm/config.mk.

Thanks,
// Casey>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
> v5: Fix documentation related build errors
> 
> v4: Replace script based image creation with binman based command
> 
> v3: Use '-' for sub heading instead of '='
>      Add location for template.its and sort the list alphabetically
> ---
>   doc/board/qualcomm/rdp.rst | 98 ++++++++++++++++++++++++++++++++++++--
>   1 file changed, 93 insertions(+), 5 deletions(-)
> 
> diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
> index 99cf8eba57c..5a0ce92e310 100644
> --- a/doc/board/qualcomm/rdp.rst
> +++ b/doc/board/qualcomm/rdp.rst
> @@ -24,13 +24,17 @@ This will build ``u-boot.elf`` in the configured output directory.
>   The firmware expects the ELF images to be in MBN format. The `elftombn.py` tool
>   can be used to convert the ELF images to MBN format.
>   
> -	IPQ9574: (MBN version 6)
> +IPQ9574: (MBN version 6)
>   
> -		$ python elftombn.py -f u-boot.elf -o u-boot.mbn -v6
> +.. code-block:: bash
>   
> -	IPQ5424: (MBN version 7)
> +    python elftombn.py -f u-boot.elf -o u-boot.mbn -v6
>   
> -		$ python elftombn.py -f u-boot.elf -o u-boot.mbn -v7
> +IPQ5424: (MBN version 7)
> +
> +.. code-block:: bash
> +
> +    python elftombn.py -f u-boot.elf -o u-boot.mbn -v7
>   
>   Then install the resulting ``u-boot.mbn`` to the ``0:APPSBL`` partition
>   on your device with::
> @@ -42,17 +46,101 @@ on your device with::
>   
>   U-Boot should be running after a reboot (``reset``).
>   
> +Build steps for IPQ5210 based Qualcomm Dragonwing F8 & N8 Platforms:
> +--------------------------------------------------------------------
> +
> +Please refer to the following URLs for more details about the platforms.
> +
> +	F8: https://www.qualcomm.com/networking-infrastructure/products/f-series/f8-platform
> +
> +	N8: https://www.qualcomm.com/networking-infrastructure/products/n-series/n8-platform
> +
> +1. Since U-Boot SPL is enabled on these platforms, the build command generates
> +   both the U-Boot SPL and U-Boot proper images. Assuming ${uboot_dir} is the
> +   top of the U-Boot sources and ${out_dir} as the output directory,
> +
> +.. code-block:: bash
> +
> +    cd ${uboot_dir}
> +    export CROSS_COMPILE=<aarch64 toolchain prefix>
> +    make -j8 O=${out_dir} qcom_ipq5210_mmc_defconfig
> +    make -j8 O=${out_dir}
> +
> +U-Boot SPL image:	${out_dir}/spl/u-boot-spl.wrap-elf
> +U-Boot image:	${out_dir}/u-boot.elf
> +
> +2. Convert the SPL image to multi ELF
> +
> +.. code-block:: bash
> +
> +    cd ${out_dir}/spl
> +    python elftombn.py -f u-boot-spl.wrap-elf -o u-boot-spl.mbn -v7
> +    python `create_multielf.py` -f u-boot-spl.mbn,tmel-ipq52xx-patch.elf \
> +					-o u-boot-spl.melf
> +
> +This u-boot-spl.melf should be flashed into 0:SPL partition.
> +Please see below for the location of `tmel-ipq52xx-patch.elf`
> +
> +3. Convert the U-Boot image to bootloader image
> +
> +.. code-block:: bash
> +
> +    cd ${out_dir}
> +    python elftombn.py -f u-boot.elf -o u-boot.mbn -v7
> +
> +The u-boot.mbn has to be combined with `qc_config.elf`, `QCLib.elf`, `TFA`
> +and `OPTEE`. Please see below for the location for these ELFs. TFA and OPTEE
> +can be built from the sources using the following commands
> +
> +TFA:
> +
> +.. code-block:: bash
> +
> +    make PLAT=ipq52xx QTISECLIB_PATH=path/to/`libqtisec_dbg.a` SPD=opteed
> +
> +OPTEE:
> +
> +.. code-block:: bash
> +
> +    make PLATFORM=qcom-ipq52xx -j16
> +
> +These binaries can be combined into a flashable image using `gen_its.py`.
> +
> +.. code-block:: bash
> +
> +	python gen_its.py --arch ipq5210		\
> +		--qclib_path `QCLib.elf`		\
> +		--qcconfig_path `qc_config.elf`		\
> +		--tfa_bl31_path bl31.mbn		\
> +		--uboot_path u-boot.mbn			\
> +		--optee_path tee-raw.mbn		\
> +		-p qcconfig qclib			\
> +		-P tfa_bl31 uboot optee			\
> +		-o output/hm_503_test_uboot.img		\
> +		--template `template.its`
> +
> +This should be flashed into 0:BOOTLDR partition.
> +
>   .. WARNING
>   	Boards with newer software versions would automatically go the emergency
>   	download (EDL) mode if U-Boot is not functioning as expected. If its a
>   	runtime failure at Uboot, the system will get reset (due to watchdog)
>   	and XBL will try to boot from next bank and if Bank B also doesn't have
>   	a functional image and is not booting fine, then the system will enter
> -	EDL.  A tool like bkerler's `edl`_ can be used for flashing with the
> +	EDL.  A tool like bkerler's `edl` can be used for flashing with the
>   	firehose loader binary appropriate for the board.
>   
>   	Note that the support added is very basic. Restoring the original U-Boot
>   	on boards with older version of the software requires a debugger.
>   
> +.. _create_multielf.py: https://raw.githubusercontent.com/coreboot/coreboot/refs/heads/main/util/qualcomm/create_multielf.py
>   .. _elftombn.py: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/NHSS.QSDK.13.0.5.r2/scripts?ref_type=heads
>   .. _edl: https://github.com/bkerler/edl
> +.. _gen_its.py: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/win.platform_tools.1.0.r34/scripts?ref_type=heads
> +.. _libqtisec_dbg.a: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/WIN.TFA.1.0.R4/apss_proc/out/proprietary/qtiseclib/output/ipq52xx/release/libqtisec_dbg.a
> +.. _OPTEE: https://git.codelinaro.org/clo/trusted-firmware/optee_os/optee_os/-/tree/win.optee.1.0?ref_type=heads
> +.. _qc_config.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/BOOT.MXF.2.3.1.1/boot_images/boot/QcomPkg/SocPkg/Hermosa/Bin/LC/RELEASE/qc_config.elf
> +.. _QCLib.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/BOOT.MXF.2.3.1.1/boot_images/boot/QcomPkg/SocPkg/Hermosa/Bin/LC/RELEASE/QCLib.elf
> +.. _template.its: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/win.platform_tools.1.0.r34/scripts?ref_type=heads
> +.. _TFA: https://git.codelinaro.org/clo/trusted-firmware/tf-a/trusted-firmware-a/-/tree/win.tfa.1.0.r4?ref_type=heads
> +.. _tmel-ipq52xx-patch.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/TMEL.WNS.2.4/tmel-ipq52xx-patch.elf

