Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B34C43458
	for <u-boot@archiver.kernel.org>; Sun, 28 Jun 2026 13:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAC13849EE;
	Sun, 28 Jun 2026 15:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qj0JU/Bv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eHTaUDun";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 286028056B; Sun, 28 Jun 2026 15:17:48 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CB9B8056B
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 15:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65S9xFq63661675
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 13:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5GaJ2gIhXUpQlfGNndPn65U30CqybVLQbNq/PxZFaPQ=; b=Qj0JU/BvvxocMu6T
 nkkeH/U+tNqbzDHdtnuPPWC5jLjoFaaNX6GLqg4bb/oD34WPPpK/OkrbuFszMEru
 AVzbR3G6WIMA69jismkRigAOGvhLkpGxkESnf7jxFgwSG6D5keuXfA/OVwQM7Uvl
 exf9c8CQVQrO3fTu6iT5VLoTNZ8WOmAi0niLHj6yqFQgwiD2i+MqFnaJz83ZAkZ1
 Lx5TO7Pknb6ZbbqwRyYvjWRo/3AUz2TVFddtdK8ACluLT+vEG3bA2KQzuSbOP1tP
 C4FOTei5VZ5bJHuQbyUz1GL+AXRE0m9ApXk1Aj2jWi0WqPcFtZb5KTQxVP0WlM51
 JMrdWw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26w6jxkm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 13:17:43 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139871a52c2so3567697c88.1
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 06:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782652663; x=1783257463; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5GaJ2gIhXUpQlfGNndPn65U30CqybVLQbNq/PxZFaPQ=;
 b=eHTaUDunDNav0EPFW728TWcTpLUOvlr83eSesHzw5Gsvym6FWEjoSWMbpJcrW3sqaN
 S1AtrDB/OyLDg8TKsj3C50Bj6Klk2WbRbYjwq/aZHzjNwi5M+knyh8gXWxLM1aOai/sU
 DUVCIWx2me/Iy/y0NE29zhbdW8cJkbHWn1M1uBpBSxG5FKwqvOu9eaKqSASheCZFe9RF
 r2GRNlC9sE8TI47FJ3psQm7F3n+I2m2OWUmzY7+crD5rO9ZiRFPihzMRQDrq5iYoqTIc
 7k5rbqZfQNMjNDwMjt2zG+fSk9ijb+VVBkLdFKJoJPCUXyL3H436Mm3b5ZI4YJG/P6tx
 bSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782652663; x=1783257463;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5GaJ2gIhXUpQlfGNndPn65U30CqybVLQbNq/PxZFaPQ=;
 b=Faln+gBIlvhRzIPujFIJnNWar/ElEjVcH6GVXPqfp1ehMJ8OLE3q0yuXFSvAV2/Gd3
 Hms+Rib6LTFkmnrI8s0wOKauUJwI54Rm/qdQhgiaIZgdAtDOlwAygUeSjrV04hi9fB8t
 tsa5Sxec5jZSsoWW+sOYrzOpi2qiSFdV6sTDsmzQ11Bolq1LfE2Td4fCY7IH5E3Lgaa8
 FD50YhMuoCMG0j84V9GyItSldCV+KpwW8G58uRwU4DtnrU4x0eH8sqrEZA6mHQPVqgXI
 OHQcHL/AAn3L21YqX47PojZNECAL3uByU+KRwy8fAjrmywEmOya4S0DhMek3S+Dj2Xan
 un8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+W9X5I2g4YSTcDbvNxglprsV62OxPJ7rrJJFIYH3L3aqQwYtBtQLHxjpTyUtz5LSUKr3cUUJs=@lists.denx.de
X-Gm-Message-State: AOJu0Yzzr6YAZLgvpR97FmTvF9O0RP9/gYQ5Oaq0AgCvrxNxI3n1vWYp
 iyBuGl6wkAsMFBA/JXPapu6mOpxbWLC+/9IBP3RLBwL3GOzUnKsvmuK+85wwbk505w1Nbasmx23
 j40vOH12ud+NsL36YC5aMClHwbKm9Mef2gIu2zxgTZEqZOfuyIrRqQe+a
X-Gm-Gg: AfdE7cmWlzIBHgomRolwhaDxZqwALx73HXZXFeOR16Mx6Wl0gN33bWIzV90Oky6uNvN
 6DOr2c0igQ2ODBXzWwH+CIoRT7m9R+XymXFDWv/00DfQgQ61Z3jTWfBAZsg/sbIaCPwy+V4Gcvf
 mvOVljE3/XU3mLgT+fjuSl1eEy+ogIu8KcfHRrEHngFa7b1/wK9m2NwqhwfNUhxcjkF715kPjKY
 eEhn4fDq7SR5jCPiKXsBwEWcujwgCYdGcOGGBIRfYBQcdLR7zB+bAW8Jm0eBBkSKYAkvTqGEcvX
 hib9zwOZIJqBYBtoBG4catf4WDOTSLZMa8EdAJ5aeyU5lgRkwDAogELcDqzhSvEIW8LXGxb++2r
 IyAbT3UUSlxZ284EEQ1zupgGBr7nkOkHC7HZK0+hyyXEf0kc=
X-Received: by 2002:a05:7022:10c:b0:135:dc2b:57e1 with SMTP id
 a92af1059eb24-139db9e6408mr11633080c88.6.1782652662723; 
 Sun, 28 Jun 2026 06:17:42 -0700 (PDT)
X-Received: by 2002:a05:7022:10c:b0:135:dc2b:57e1 with SMTP id
 a92af1059eb24-139db9e6408mr11633026c88.6.1782652662057; 
 Sun, 28 Jun 2026 06:17:42 -0700 (PDT)
Received: from [192.168.0.5] ([49.206.99.179])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d91006afsm45559191c88.12.2026.06.28.06.17.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jun 2026 06:17:41 -0700 (PDT)
Message-ID: <1605086a-876e-43e6-831c-6579bb2a6deb@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 18:47:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/11] doc: board/qualcomm: Update RDP build
 instructions
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, marek.vasut+renesas@mailbox.org,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org, andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com,
 alchark@gmail.com, mkorpershoek@kernel.org, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, ycliang@andestech.com,
 n-francis@ti.com, mateuslima.ti@gmail.com, jamie.gibbons@microchip.com,
 david.wronek@mainlining.org, james.hilliard1@gmail.com,
 philip.molloy@analog.com, ravi@prevas.dk, sughosh.ganu@arm.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260623064804.3988799-12-varadarajan.narayanan@oss.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260623064804.3988799-12-varadarajan.narayanan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: uukc8eO8l42ZZVrJYg-92mPTMOglBDzu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDExNiBTYWx0ZWRfX3YnpOr9wn7Bo
 +Q57F17A5OAxZPnxXSRa3LkolXN4THktMqXwyjuqukbROLjgsaeAL9LF13B34YW0kAxJrs0drJ4
 Wygvb9D0XHqH9Ig/X5IumZIcvHahDjk=
X-Proofpoint-GUID: uukc8eO8l42ZZVrJYg-92mPTMOglBDzu
X-Authority-Analysis: v=2.4 cv=SuugLvO0 c=1 sm=1 tr=0 ts=6a411ef7 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=8fNwSSZIJDewi4B+fYJmHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=1FHRc4FDAAAA:20 a=qC_FGOx9AAAA:8 a=NEAV23lmAAAA:8
 a=3avKqCElbSkC4DZG6s4A:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
 a=fsdK_YakeE02zTmptMdW:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDExNiBTYWx0ZWRfX2sVA7Cap2SfZ
 k4UvvF/++KU1LvrkZ3N08nXxoK+rmH/zz9zEho6QMIHq+bw/CIiP2VL8LSfAW3XexoCROjQaL0k
 lX7lTHxD8pgiisFHMPuaYrQcY9WdalVQO3teNbgdYVSfPVMP9zuqPcZJkubyXF6xYlqh5WR//ie
 JvxPujKWB5qnm84tmz0jJ+8jbJ/QBNPJtZ3lxZjE0qz3ZNW6cgNfBvitVAL5eFdg6z2RkfX/dPD
 IF0gBwIE2964+OQjUhNdB1XSe+e463cTm3sNQ+ea0MQyj5v+YPliE8JS6fy9JiMUg4K3mowpPuf
 TOJ7mslluMI14Ox2Ag5wBW4mJB9C6eRDyECpqK0MY1hE94H+Ov68Z/Yhdm35LcIi912JAMjvsL1
 J3bcfwgB124CiuhKCGXmvPlsXd4b0/o7LByCeknxE8O1SUZkxEcKBa1Whaf6M2wJqtmS5qyuaXi
 n0wKbN2rC/U1BTNPvvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280116
X-Mailman-Approved-At: Sun, 28 Jun 2026 15:25:03 +0200
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

Hi Varada,

On 6/23/2026 12:18 PM, Varadarajan Narayanan wrote:
> Add details about the SPL & U-Boot proper build steps, converting to
> flashable images, source URLs for the needed binaries and scripts.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Regards,

Balaji

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
