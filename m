Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B85DC0218F
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 13:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9345820B7;
	Thu, 30 Jan 2025 14:30:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="MOLi+P4T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13BE9820F1; Thu, 30 Jan 2025 14:30:18 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C73180805
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 14:30:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4125fc93c8=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UCexRl006943;
 Thu, 30 Jan 2025 14:30:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 vH8hGVMQL5lWpuPktStkdFAPdVnkZOv5lMk0sQ3xo1k=; b=MOLi+P4T+TW5KamK
 TV0R0HQfJbgyaMkCyUl1/jhufRyCADHrujIu/eseNAD/3IkjUOgdbpUhSqhep5k/
 aMgk6IQ9gich3cASkbfewPO8l/MacsjipYbfufEESALzNPHGG1cM9PC5Wd9aHrjB
 cMcLBlBi79ObM3f9hPJ9yPl6nm6/I7omUEHol6xJMtbD3YkrA2BWocNF+43zXoXO
 XDOas2ziiCQhTQeA4JPIr6pnEoqP0kvUB953l7Ufb3dcTDb2PIWMU4PHorocdhXQ
 QOkpQ6IOfkSbo0sloRBMdnizAKZITdwIq1yj1QpvBIqStiIGOxoCnRqHKTJjoWFg
 jwtzXg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44g64shc4c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jan 2025 14:30:12 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C9C754005B;
 Thu, 30 Jan 2025 14:29:17 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B7E6F2D1CC5;
 Thu, 30 Jan 2025 14:26:45 +0100 (CET)
Received: from [10.48.87.126] (10.48.87.126) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 14:26:45 +0100
Message-ID: <fc626e50-a73b-460e-8eba-8853bab627ca@foss.st.com>
Date: Thu, 30 Jan 2025 14:26:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] configs: stih410-b2260: Enable
 CMD_USB_MASS_STORAGE flag
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Marek Vasut
 <marex@denx.de>, Tom Rini <trini@konsulko.com>
References: <20250123144718.1139824-1-patrice.chotard@foss.st.com>
 <20250123144718.1139824-10-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250123144718.1139824-10-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.126]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01
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

Hi,

On 1/23/25 15:47, Patrice Chotard wrote:
> Enable CMD_USB_MASS_STORAGE flag.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>
> Cc: Marek Vasut <marex@denx.de>
>
> ---
>
> (no changes since v1)
>
>   configs/stih410-b2260_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/stih410-b2260_defconfig b/configs/stih410-b2260_defconfig
> index 5641fd1d8d7..1e5190dc828 100644
> --- a/configs/stih410-b2260_defconfig
> +++ b/configs/stih410-b2260_defconfig
> @@ -25,6 +25,7 @@ CONFIG_CMD_ASKENV=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
>   CONFIG_CMD_TIME=y
>   CONFIG_CMD_TIMER=y
>   CONFIG_CMD_EXT4_WRITE=y


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

