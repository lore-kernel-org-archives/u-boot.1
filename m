Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715A8C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 15:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF6BD86F67;
	Mon, 15 Jan 2024 16:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="U/9X8QT2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 092FD8743A; Mon, 15 Jan 2024 16:45:43 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C0AB86EF1
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 16:45:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1744d49635=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40FDWaw5002788; Mon, 15 Jan 2024 16:45:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=lnDqovMO+d6vo44Yg652zMBP9dI7y06/6AyMPVyllmQ=; b=U/
 9X8QT2/Rz9iZ2gkqETokwu+VUsjta/HraJciSNXmsQ5Ol12F33MCSmgftH8DfK7K
 sNvy1Hnc/oQJbJ5i3oLlh6nMFPdFDSyR1BLweaJcpGQ5Krj1P4udqpXFPLPX/9TX
 y/neQPpxTW1mPfJnCg3bnn/4U2op+3aM9h9DNwVx6IJMra4cdt573TazgOMUDs2Z
 /Q28MB+SVh3bhvTF8Dr15BUa9x1p9R+R7oQuPvY5ZOeY36zkthi9QC9sbHBUTLkb
 AbAyLPvFzh5JRfBnpDxcfEW5VDmJjmRy8zNLd5HSmt0sXk1ol2fLvYRCbAYzvRPz
 RX9rewtDdd0nyPlN3VGA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vm6bny17w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 16:45:40 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 62D4410002A;
 Mon, 15 Jan 2024 16:45:40 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 599AC2BE2E9;
 Mon, 15 Jan 2024 16:45:40 +0100 (CET)
Received: from [10.201.20.205] (10.201.20.205) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Jan
 2024 16:45:39 +0100
Message-ID: <1c7597c1-0da7-42bd-b728-da088d02a2f5@foss.st.com>
Date: Mon, 15 Jan 2024 16:45:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smt32mp: Add dependencies on CMDLINE for command stm32key
Content-Language: en-US
To: Patrick Delaunay <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240115143048.1.I808ca7780ec7f1ca146b47adae52ef1060a276c9@changeid>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240115143048.1.I808ca7780ec7f1ca146b47adae52ef1060a276c9@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.205]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
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



On 1/15/24 14:30, Patrick Delaunay wrote:
> We cannot use stm32key commands without CONFIG_CMDLINE so add the
> required condition.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
>  arch/arm/mach-stm32mp/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-stm32mp/Kconfig b/arch/arm/mach-stm32mp/Kconfig
> index 5fc92d07fe6d..c6c89883f2b0 100644
> --- a/arch/arm/mach-stm32mp/Kconfig
> +++ b/arch/arm/mach-stm32mp/Kconfig
> @@ -144,6 +144,7 @@ config STM32_ECDSA_VERIFY
>  
>  config CMD_STM32KEY
>  	bool "command stm32key to fuse public key hash"
> +	depends on CMDLINE
>  	help
>  		fuse public key hash in corresponding fuse used to authenticate
>  		binary.
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
