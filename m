Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760D6C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 19:13:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D6C487CF1;
	Fri, 19 Jan 2024 20:13:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Sc2fvdfe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69AA587CF0; Fri, 19 Jan 2024 20:13:49 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 558AD87CF0
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 20:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40JJDb7U084002;
 Fri, 19 Jan 2024 13:13:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705691617;
 bh=CdXZEMQj9hnZjPDIBIarMLDodjFYBdSzt8fjtQ5JjiY=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=Sc2fvdfeMcCXmeeJ2U/73d7NPEmEkrrqG7JQdVjMQ0kJpoAwdNV08MTiAjD017wuS
 +BT7B1ljXudxsIT91AFXMNDw6RKa1xIvmm2dUr2zP7Cb7yM0b/qapyScWXn1D3eClx
 StlM9+0c1Aln5QPPr84DI7Ci8/YuwfENGhfsNZNQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40JJDbda022491
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 19 Jan 2024 13:13:37 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Jan 2024 13:13:36 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Jan 2024 13:13:36 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40JJDZSA114908;
 Fri, 19 Jan 2024 13:13:35 -0600
Message-ID: <1e5c60a4-0200-4207-8485-c3fb26d87f3e@ti.com>
Date: Fri, 19 Jan 2024 13:13:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 15/16] configs: Add am69_sk_* defconfig fragments
Content-Language: en-US
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Dasnavis Sabiya <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Nishanth Menon <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Roger Quadros <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
References: <20240119175043.3904751-1-a-nandan@ti.com>
 <20240119175043.3904751-16-a-nandan@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240119175043.3904751-16-a-nandan@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 1/19/24 11:50 AM, Apurva Nandan wrote:
> From: Dasnavis Sabiya <sabiya.d@ti.com>
> 
> Add config fragments for am69_sk A72 and R5 configuration.
> 
> This applies on to:
> j784s4_evm_a72_defconfig -> am69_sk_a72.config
> j784s4_evm_r5_defconfig -> am69_sk_r5.config
> 
> The usage model (with the fragment) would be:
> make j784s4_evm_a72_defconfig am69_sk_a72.config
> make
> 
> OR
> 
> make j784s4_evm_r5_defconfig am69_sk_r5.config
> make
> 
> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>   board/ti/j784s4/MAINTAINERS | 2 ++
>   configs/am69_sk_a72.config  | 5 +++++
>   configs/am69_sk_r5.config   | 5 +++++
>   3 files changed, 12 insertions(+)
>   create mode 100644 configs/am69_sk_a72.config
>   create mode 100644 configs/am69_sk_r5.config
> 
> diff --git a/board/ti/j784s4/MAINTAINERS b/board/ti/j784s4/MAINTAINERS
> index 4433ead66b..69be13f533 100644
> --- a/board/ti/j784s4/MAINTAINERS
> +++ b/board/ti/j784s4/MAINTAINERS
> @@ -20,3 +20,5 @@ AM69 SK BOARD
>   F:	arch/arm/dts/k3-am69-sk.dts
>   F:	arch/arm/dts/k3-am69-sk-u-boot.dtsi
>   F:	arch/arm/dts/k3-am69-r5-sk.dts
> +F:	configs/am69_sk_r5.config
> +F:	configs/am69_sk_a72.config
> diff --git a/configs/am69_sk_a72.config b/configs/am69_sk_a72.config
> new file mode 100644
> index 0000000000..03e74a8a56
> --- /dev/null
> +++ b/configs/am69_sk_a72.config

Just going to ignore the comments on v7 about putting this
in board/ti/..?

Anyway, we can now do includes in defconfigs, so no config
fragments needed, you can just add `configs/am69_evm_a72_defconfig`
with the content:

```
#include <configs/j784s4_evm_a72_defconfig>

CONFIG_ARM=y
CONFIG_ARCH_K3=y
CONFIG_SOC_K3_J784S4=y
CONFIG_TARGET_J784S4_A72_EVM=y

CONFIG_DEFAULT_DEVICE_TREE="k3-am69-sk"
CONFIG_SPL_OF_LIST="k3-am69-sk"
CONFIG_OF_LIST="k3-am69-sk"
```

(note we need to duplicate the _ARM/_TARGET currently to
not confuse buildman which seems to directly parse the configs
for arch detection).

Andrew

> @@ -0,0 +1,5 @@
> +# Defconfig fragment to apply on top of j784s4_evm_a72_defconfig
> +
> +CONFIG_DEFAULT_DEVICE_TREE="k3-am69-sk"
> +CONFIG_SPL_OF_LIST="k3-am69-sk"
> +CONFIG_OF_LIST="k3-am69-sk"
> diff --git a/configs/am69_sk_r5.config b/configs/am69_sk_r5.config
> new file mode 100644
> index 0000000000..c42b6f3380
> --- /dev/null
> +++ b/configs/am69_sk_r5.config
> @@ -0,0 +1,5 @@
> +# Defconfig fragment to apply on top of j784s4_evm_r5_defconfig
> +
> +CONFIG_DEFAULT_DEVICE_TREE="k3-am69-sk"
> +CONFIG_SPL_OF_LIST="k3-am69-r5-sk"
> +CONFIG_OF_LIST="k3-am69-r5-sk"
