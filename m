Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C6FC43458
	for <u-boot@archiver.kernel.org>; Sun, 28 Jun 2026 13:25:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF1E68498C;
	Sun, 28 Jun 2026 15:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eRHQyhyV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SNPZUDuI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95B9684105; Sun, 28 Jun 2026 15:12:44 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AEC18056B
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 15:12:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65S9OsrY3594516
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 13:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lqVg+ThCTMLIlv+g55+0jtNrO1GxLXhpUaSp87zcfvA=; b=eRHQyhyVQJbJxD8b
 OGiKqpRfVUbho+Ydmq76dX21OYRBjCRBmdkXPhN43qnC/G650t0T+BIL9qxKfek4
 ctI+BOxbb9vY5+ueoPi63GO7JjfVnRvgFRsjfE7P6jplVpstGnQKKueUvmy6vjAI
 sn7qkwDqYQ7wEZulq3vfe/k16X5b90y8SQxKThbr2lUrRwxutnyRvCbWoPwv74ob
 2d8sr4vYdYP/DpCiaPowKkLLj6TFAxW4TRqM4pUicmBbgbt/lDy505/4xuHDHvsX
 56345zGmVwuF6ewImkTeF99PA5S/XFqImOWL4yIgY+HFK/0RQzHOxXG77aSJ5k8x
 IKh4vw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f2734axpf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 13:12:40 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0a27ad86so5072349eec.0
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 06:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782652360; x=1783257160; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lqVg+ThCTMLIlv+g55+0jtNrO1GxLXhpUaSp87zcfvA=;
 b=SNPZUDuIGFcXncjQMvwvSVH+a30QEqtMAMvE3e32to3HQX8yhgFHRVapNFrbQ25doe
 g8YnnK82uE+d0rllSv+xVmkeyKNDBm8M8aWsAvmEb2wP8wGojgBZcTp06sj+qLjDZZdt
 ooT7/a8YsHYWQ+unpZi03wkz36BasASEUugxnsYEJuVUTvuAWRnWB72ZIhLaF0VtI+JX
 aCTSwsvp5B0dLmIMLJ78TlhWV40E2noaL+ElLBGQ9x2Rz+Ek8wY8Scx98KqegRTd8F4e
 YfwpnlReYJQP6KCsALjts+tD3hf/7zD87nshRgBBC6eIaM0FHaszOdHKO1FEsX6Ybkgc
 4pBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782652360; x=1783257160;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lqVg+ThCTMLIlv+g55+0jtNrO1GxLXhpUaSp87zcfvA=;
 b=VSrpifSZzfic3wNnpMDsUDwfEKq9Tp2YA+aGQBSzgSdYqqpD1HuXVtzdKlXuhcz8sX
 hGZpKK1Q+TQBHii9bnvzXLgpTgGQSHfKR/tkyO27pR0JXKXIMtN3yX2s53Bp9Nx0DZzG
 w+HQvuX/ldXSbcPbb4WWup/xkaRb/XonnF0CT6cUmjtYcRmK4YsgauL0zStyOonfUNDV
 Dvf4SQjpHfEf33Dyh7Mys0QK4XxvAltFDaEWLAYS8xRtikeESJFXk0k3yrSE+xD47n5I
 iU9yu0iTiuPyZHztozjrO03HuZxYSX6c+zwtjjRcW+KDpkiNimNqupVfTuWEPNByTnt3
 DeCA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrk1moRLzDS7m26rfAqHm7fesT88q6orGw6P99nkNIfsKV60m1fMMuM8ymWDDBhviHCFWlX4PI=@lists.denx.de
X-Gm-Message-State: AOJu0Ywy5j8yG9VmCHOWaX8kcomZ8Hd/m15/OkBzsp85CFrzQ0kym5g+
 Peu3OzcTE+CNbKsaNbbjj1EuBgtGmZlItlcH4/Hf/JDdQzPsoC5tLpVByJXO4uoH8zXejMLrAxU
 uNMcF12P9h3WfV4uqfWO4WVNRzHiejU8TaKXaAoKqkH0n9Iod/sPVJjF65v1xDO2D
X-Gm-Gg: AfdE7cmorQUWVYuf9pKRysEQLBrhlJwF854mglxoHfwJ+4Zc5RvzgcKmhjiu31sRVfq
 ENlKozV1iFlbFQNULTulPYBjjjQ3KwtlgsDu0x24uvCivtptst1++d0vyXvD87qYO5oYncfBL+S
 5SybK8QB1AkqX6bdEmF8G9Jxj4iZ9+OkaqzwFIHSGvSYp0xtxuSD7CdCr0JYJPSKM7HcS8Ac7MI
 LmbspX9+ECsc59Ks3irk+clPNmnkYzfC2+Oy9VcwE3pPgfSwNrbju155w53of3SbTlF4V4bquzj
 hUelXVdgCRbdrXLXsF8Di8qP6Ww7RZw95NBvkJmFVmwMXVqQPn1A8TeWnqy0LtSyJLhCi0A4XET
 mhmzyCiCOiKXNtjntC9GhPN3QVSUsGp8c3BafxaMheXHXUWI=
X-Received: by 2002:a05:7300:7c21:b0:30c:6847:c2ec with SMTP id
 5a478bee46e88-30c850a9096mr14201729eec.32.1782652359626; 
 Sun, 28 Jun 2026 06:12:39 -0700 (PDT)
X-Received: by 2002:a05:7300:7c21:b0:30c:6847:c2ec with SMTP id
 5a478bee46e88-30c850a9096mr14201673eec.32.1782652359055; 
 Sun, 28 Jun 2026 06:12:39 -0700 (PDT)
Received: from [192.168.0.5] ([49.206.99.179])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm48383261eec.7.2026.06.28.06.12.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jun 2026 06:12:38 -0700 (PDT)
Message-ID: <f970b453-9649-42ed-a71f-d5dee9131aff@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 18:42:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/11] mach-snapdragon: Add commands to create wrapper
 ELF
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
 <20260623064804.3988799-10-varadarajan.narayanan@oss.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260623064804.3988799-10-varadarajan.narayanan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _m24hJnVBE9LxK8h76wpppX4FXqXBSzF
X-Proofpoint-ORIG-GUID: _m24hJnVBE9LxK8h76wpppX4FXqXBSzF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDExNiBTYWx0ZWRfX8rG8LiCLQ8+D
 aaMF4FkdL2skUSEjzv7z4mUHtRFtfQOWucCAHW4Hd43K9rR9KA5QUBMC/EhuEI0iS42jV5y0bOa
 ztu7lyV+dy+gGtB/bYyl4skQPNUWecw=
X-Authority-Analysis: v=2.4 cv=HYokiCE8 c=1 sm=1 tr=0 ts=6a411dc8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=8fNwSSZIJDewi4B+fYJmHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Ss4p5GqXVVCeHq1W3dAA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDExNiBTYWx0ZWRfX2WjgcCnxaxYn
 PzbIJlsHbBAFeDnZqYiH5bB+nW9s6gldSmyqt9AayYKlDf2lhHxbbIo25ESzi2V90gKeEVvO6Xb
 LHchBdGM62bHzE9A15yJxPfvDEwKQhPtbqZqVeQLy7vIbasZ8/ZTCOOs/wHT+v5q71xax+fk1vd
 iSzgtq1LhDicS1wF8DYB/yYhocMPphUBtxRYk7N+cGAF/DmAMKxO1nIRPtUr24OGUjfHpqaST2g
 D4oBXThtHR5iVhuIyxeb8oUlcIjUvA67+16Nzuo1GxdsOSp7JvOvAn8y+M8o9/phBeiGOQnuEft
 /+OD+22r2S9LbZd+j85apaK5MNIhYPz+pyWlHf/p7oi1OQ6PKk2Q4glEV/oBp5lSDsL/vUHb7O+
 8ZQGn994yiRZhBqByL1lu7Bjj95uENFOZDYO90oUgD8byRhDdVcr+I/09gtODpj+NWm3orRHhVq
 4v9O+B95GVjB64LcSLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606280116
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
> The IPQ5210 boot ROM expects the SPL binary image to be embedded within
> an ELF along with additional binaries. Hence add the relevant commands
> and linker script needed to convert u-boot-spl.bin to the expected
> format.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Regards,

Balaji

> ---
> v4: Use $(obj) for u-boot-spl.wrap-elf
>
> v3: s/a image/an image/
>      Add SPDX header to linker script
>      Pre-process linker script to use IMAGE_TEXT_BASE instead of hard coding it
> ---
>   arch/arm/mach-snapdragon/Kconfig              |  7 ++++++
>   .../mach-snapdragon/ipq5210-spl-wrap-elf.lds  | 18 ++++++++++++++
>   scripts/Makefile.xpl                          | 24 +++++++++++++++++++
>   3 files changed, 49 insertions(+)
>   create mode 100644 arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds
>
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index d3de8693b5a..d94cb6206e8 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -42,4 +42,11 @@ config SYS_CONFIG_NAME
>   	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
>   	  will be used for board configuration.
>   
> +config SPL_WRAPPER_ELF
> +	bool "Create wrapper ELF for applicable platforms"
> +	depends on SPL
> +	help
> +	  Some platforms embed the U-Boot SPL binary within an ELF as a segment.
> +	  Additional tools are used to convert this ELF into an image that is
> +	  usable for the boot ROM.
>   endif
> diff --git a/arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds b/arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds
> new file mode 100644
> index 00000000000..5a582e65ca0
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds
> @@ -0,0 +1,18 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +PHDRS {
> +	ptype PT_LOAD FLAGS(0x7);
> +}
> +
> +ENTRY(_entry)
> +
> +SECTIONS {
> +	. = IMAGE_TEXT_BASE;
> +	_entry = . ;
> +	data : {
> +		*(.data)
> +		. = ALIGN(4);
> +	} :ptype
> +}
> diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
> index a3fd3e1375f..6e9f24b748a 100644
> --- a/scripts/Makefile.xpl
> +++ b/scripts/Makefile.xpl
> @@ -256,6 +256,26 @@ MKIMAGEFLAGS_boot.bin = -T zynqmpimage -R $(srctree)/$(CONFIG_BOOT_INIT_FILE) \
>   	-n "$(shell cd $(srctree); readlink -f $(CONFIG_PMUFW_INIT_FILE))"
>   endif
>   
> +ifeq ($(CONFIG_SPL_WRAPPER_ELF),y)
> +# Convert ELF to object file
> +OBJCOPYFLAGS_$(SPL_BIN).bin.o = -I binary -O elf64-littleaarch64
> +
> +# Wrap the object file inside a ELF
> +QCOM_SPL_SOC = $(shell echo $(notdir "$(CONFIG_DEFAULT_DEVICE_TREE)") | cut -f1 -d-)
> +QCOM_SPL_WRAP_LDS = $(srctree)/arch/arm/mach-snapdragon/$(QCOM_SPL_SOC)-spl-wrap-elf.lds
> +LDFLAGS_$(SPL_BIN).wrap-elf = -T $(obj)/$(SPL_BIN).wrap-elf.lds
> +
> +$(obj)/$(SPL_BIN).wrap-elf.lds: $(QCOM_SPL_WRAP_LDS) FORCE
> +	$(call if_changed_dep,cpp_lds)
> +
> +$(obj)/$(SPL_BIN).bin.o: $(obj)/$(SPL_BIN).bin $(obj)/$(SPL_BIN).wrap-elf.lds FORCE
> +	$(call if_changed,objcopy)
> +
> +$(obj)/$(SPL_BIN).wrap-elf: $(obj)/$(SPL_BIN).bin.o FORCE
> +	$(call if_changed,ld)
> +
> +endif
> +
>   $(obj)/$(SPL_BIN)-align.bin: $(obj)/$(SPL_BIN).bin
>   	@dd if=$< of=$@ conv=sync bs=4 2>/dev/null;
>   
> @@ -302,6 +322,10 @@ INPUTS-$(CONFIG_ARCH_ZYNQMP)	+= $(obj)/boot.bin
>   
>   INPUTS-$(CONFIG_ARCH_MEDIATEK)	+= $(obj)/u-boot-spl-mtk.bin
>   
> +ifeq ($(CONFIG_ARCH_SNAPDRAGON),y)
> +INPUTS-$(CONFIG_SPL_WRAPPER_ELF) += $(obj)/u-boot-spl.wrap-elf
> +endif
> +
>   all:	$(INPUTS-y)
>   
>   quiet_cmd_cat = CAT     $@
