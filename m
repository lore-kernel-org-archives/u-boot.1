Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF882C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 15:21:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D9BE8857E;
	Wed, 22 May 2024 17:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="y2Bj5BMo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 791BE88836; Wed, 22 May 2024 17:21:41 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7BF787C75
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 17:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44MFLUXF034587;
 Wed, 22 May 2024 10:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716391290;
 bh=3/35BJ1NA6c2uCpQDXdoaOcd2XC+MBTgDZCYMyKqeQQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=y2Bj5BModGHBXc+jvvS6X9+kJTGz3TYDNUX+j/1GwKmAHF8xid8W1CY5/JvrxTS3P
 gaFmfRJMcYX6fWV5n8IhQyBDx8Wv23hK+EaS/lhEIP1SCh45i+tJISIl7rTnL7H1cX
 8oK3JFSYohpk77X/wG9sNp1YTJAJJGero/5/wOX0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44MFLUbO074565
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 May 2024 10:21:30 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 May 2024 10:21:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 May 2024 10:21:29 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44MFLTGY060897;
 Wed, 22 May 2024 10:21:29 -0500
Message-ID: <d444e122-59d2-44eb-9dde-fb8ec373920e@ti.com>
Date: Wed, 22 May 2024 10:21:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] arm: mach-k3: am62a_qos: Move common bit MACROS to
 k3_qos header file
To: Jayesh Choudhary <j-choudhary@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <u-kumar1@ti.com>
CC: <a-bhatia1@ti.com>, <nm@ti.com>, <n-francis@ti.com>,
 <joao.goncalves@toradex.com>, <j-humphreys@ti.com>,
 <d.haller@phytec.de>, <hnagalla@ti.com>, <bb@ti.com>,
 <seanga2@gmail.com>, <sjg@chromium.org>, <clamor95@gmail.com>,
 <martyn.welch@collabora.com>, <m-chawdhry@ti.com>, <a-limaye@ti.com>
References: <20240522113726.302908-1-j-choudhary@ti.com>
 <20240522113726.302908-2-j-choudhary@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240522113726.302908-2-j-choudhary@ti.com>
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

On 5/22/24 6:37 AM, Jayesh Choudhary wrote:
> QoS bit mapping are common across all K3 SoCs so move those defines
> to common header file (k3_qos.h).
> This ensures that we do not define these for each SoC.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>   arch/arm/mach-k3/include/mach/k3-qos.h | 74 ++++++++++++++++++++++++++
>   arch/arm/mach-k3/r5/am62ax/am62a_qos.h | 74 --------------------------
>   2 files changed, 74 insertions(+), 74 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/include/mach/k3-qos.h b/arch/arm/mach-k3/include/mach/k3-qos.h
> index e00e1de5b9..6ed5704803 100644
> --- a/arch/arm/mach-k3/include/mach/k3-qos.h
> +++ b/arch/arm/mach-k3/include/mach/k3-qos.h
> @@ -9,6 +9,80 @@
>   
>   #include <linux/kernel.h>
>   
> +#define QOS_0	(0 << 0)
> +#define QOS_1	(1 << 0)
> +#define QOS_2	(2 << 0)
> +#define QOS_3	(3 << 0)
> +#define QOS_4	(4 << 0)
> +#define QOS_5	(5 << 0)
> +#define QOS_6	(6 << 0)
> +#define QOS_7	(7 << 0)
> +
> +#define ORDERID_0	(0 << 4)
> +#define ORDERID_1	(1 << 4)
> +#define ORDERID_2	(2 << 4)
> +#define ORDERID_3	(3 << 4)
> +#define ORDERID_4	(4 << 4)
> +#define ORDERID_5	(5 << 4)
> +#define ORDERID_6	(6 << 4)
> +#define ORDERID_7	(7 << 4)
> +#define ORDERID_8	(8 << 4)
> +#define ORDERID_9	(9 << 4)
> +#define ORDERID_10	(10 << 4)
> +#define ORDERID_11	(11 << 4)
> +#define ORDERID_12	(12 << 4)
> +#define ORDERID_13	(13 << 4)
> +#define ORDERID_14	(14 << 4)
> +#define ORDERID_15	(15 << 4)
> +
> +#define ASEL_0	(0 << 8)
> +#define ASEL_1	(1 << 8)
> +#define ASEL_2	(2 << 8)
> +#define ASEL_3	(3 << 8)
> +#define ASEL_4	(4 << 8)
> +#define ASEL_5	(5 << 8)
> +#define ASEL_6	(6 << 8)
> +#define ASEL_7	(7 << 8)
> +#define ASEL_8	(8 << 8)
> +#define ASEL_9	(9 << 8)
> +#define ASEL_10	(10 << 8)
> +#define ASEL_11	(11 << 8)
> +#define ASEL_12	(12 << 8)
> +#define ASEL_13	(13 << 8)
> +#define ASEL_14	(14 << 8)
> +#define ASEL_15	(15 << 8)
> +
> +#define EPRIORITY_0	(0 << 12)
> +#define EPRIORITY_1	(1 << 12)
> +#define EPRIORITY_2	(2 << 12)
> +#define EPRIORITY_3	(3 << 12)
> +#define EPRIORITY_4	(4 << 12)
> +#define EPRIORITY_5	(5 << 12)
> +#define EPRIORITY_6	(6 << 12)
> +#define EPRIORITY_7	(7 << 12)
> +
> +#define VIRTID_0	(0 << 16)
> +#define VIRTID_1	(1 << 16)
> +#define VIRTID_2	(2 << 16)
> +#define VIRTID_3	(3 << 16)
> +#define VIRTID_4	(4 << 16)
> +#define VIRTID_5	(5 << 16)
> +#define VIRTID_6	(6 << 16)
> +#define VIRTID_7	(7 << 16)
> +#define VIRTID_8	(8 << 16)
> +#define VIRTID_9	(9 << 16)
> +#define VIRTID_10	(10 << 16)
> +#define VIRTID_11	(11 << 16)
> +#define VIRTID_12	(12 << 16)
> +#define VIRTID_13	(13 << 16)
> +#define VIRTID_14	(14 << 16)
> +#define VIRTID_15	(15 << 16)


This all seem like it could be made into some macro, something like

#define K3_QOS(qos, orderid, asel, epriority, virtid, atype) \
	(qos     << 0 | \
	 orderid << 4 | \
	 asel    << 8 | \
etc..

Then use that instead of raw values. That might also make it more clear
we are setting the other values to 0 when we are setting these registers:

.val = K3_QOS(0, 15, 0, 0, 0, 3),

Andrew


> +
> +#define ATYPE_0	(0 << 28)
> +#define ATYPE_1	(1 << 28)
> +#define ATYPE_2	(2 << 28)
> +#define ATYPE_3	(3 << 28)
> +
>   struct k3_qos_data {
>   	u32 reg;
>   	u32 val;
> diff --git a/arch/arm/mach-k3/r5/am62ax/am62a_qos.h b/arch/arm/mach-k3/r5/am62ax/am62a_qos.h
> index c74d69a28f..84a6dc7240 100644
> --- a/arch/arm/mach-k3/r5/am62ax/am62a_qos.h
> +++ b/arch/arm/mach-k3/r5/am62ax/am62a_qos.h
> @@ -6,80 +6,6 @@
>    * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
> -#define QOS_0	(0 << 0)
> -#define QOS_1	(1 << 0)
> -#define QOS_2	(2 << 0)
> -#define QOS_3	(3 << 0)
> -#define QOS_4	(4 << 0)
> -#define QOS_5	(5 << 0)
> -#define QOS_6	(6 << 0)
> -#define QOS_7	(7 << 0)
> -
> -#define ORDERID_0	(0 << 4)
> -#define ORDERID_1	(1 << 4)
> -#define ORDERID_2	(2 << 4)
> -#define ORDERID_3	(3 << 4)
> -#define ORDERID_4	(4 << 4)
> -#define ORDERID_5	(5 << 4)
> -#define ORDERID_6	(6 << 4)
> -#define ORDERID_7	(7 << 4)
> -#define ORDERID_8	(8 << 4)
> -#define ORDERID_9	(9 << 4)
> -#define ORDERID_10	(10 << 4)
> -#define ORDERID_11	(11 << 4)
> -#define ORDERID_12	(12 << 4)
> -#define ORDERID_13	(13 << 4)
> -#define ORDERID_14	(14 << 4)
> -#define ORDERID_15	(15 << 4)
> -
> -#define ASEL_0	(0 << 8)
> -#define ASEL_1	(1 << 8)
> -#define ASEL_2	(2 << 8)
> -#define ASEL_3	(3 << 8)
> -#define ASEL_4	(4 << 8)
> -#define ASEL_5	(5 << 8)
> -#define ASEL_6	(6 << 8)
> -#define ASEL_7	(7 << 8)
> -#define ASEL_8	(8 << 8)
> -#define ASEL_9	(9 << 8)
> -#define ASEL_10	(10 << 8)
> -#define ASEL_11	(11 << 8)
> -#define ASEL_12	(12 << 8)
> -#define ASEL_13	(13 << 8)
> -#define ASEL_14	(14 << 8)
> -#define ASEL_15	(15 << 8)
> -
> -#define EPRIORITY_0	(0 << 12)
> -#define EPRIORITY_1	(1 << 12)
> -#define EPRIORITY_2	(2 << 12)
> -#define EPRIORITY_3	(3 << 12)
> -#define EPRIORITY_4	(4 << 12)
> -#define EPRIORITY_5	(5 << 12)
> -#define EPRIORITY_6	(6 << 12)
> -#define EPRIORITY_7	(7 << 12)
> -
> -#define VIRTID_0	(0 << 16)
> -#define VIRTID_1	(1 << 16)
> -#define VIRTID_2	(2 << 16)
> -#define VIRTID_3	(3 << 16)
> -#define VIRTID_4	(4 << 16)
> -#define VIRTID_5	(5 << 16)
> -#define VIRTID_6	(6 << 16)
> -#define VIRTID_7	(7 << 16)
> -#define VIRTID_8	(8 << 16)
> -#define VIRTID_9	(9 << 16)
> -#define VIRTID_10	(10 << 16)
> -#define VIRTID_11	(11 << 16)
> -#define VIRTID_12	(12 << 16)
> -#define VIRTID_13	(13 << 16)
> -#define VIRTID_14	(14 << 16)
> -#define VIRTID_15	(15 << 16)
> -
> -#define ATYPE_0	(0 << 28)
> -#define ATYPE_1	(1 << 28)
> -#define ATYPE_2	(2 << 28)
> -#define ATYPE_3	(3 << 28)
> -
>   #define PULSAR_UL_WKUP_0_CPU0_RMST	0x45D14000
>   #define PULSAR_UL_WKUP_0_CPU0_WMST	0x45D14400
>   #define PULSAR_UL_WKUP_0_CPU0_PMST	0x45D14800
