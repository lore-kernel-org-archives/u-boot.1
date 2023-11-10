Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3C9C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 15:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D98BB87815;
	Fri, 10 Nov 2023 16:01:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="E92Me+lv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20D7687817; Fri, 10 Nov 2023 16:01:47 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D26D87799
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 16:01:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9678822151=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3AAAPvxg010191; Fri, 10 Nov 2023 16:01:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:from:to:cc:references
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=REfEAKPcftRPl9cKrLkSLvac9nTpivt5rICMwAHgtZI=; b=E9
 2Me+lv49FGra2bHFKnwPE3xbbasa7zAubSxGUNk4eGF0wFcSTdBogxXBCGbXhxwE
 v2/Gs5r2GxwyaKpHqc9sDQhgmZlc9y1uaq9AIGFSxTRjej7jemGmTsTIcQSszU4l
 iMJOWDYxkwrQ/3roUKLw54hSaoXpMItCaLNv4mZsu1o2+a4DHla2VCJjeu04Hs3n
 4rv2rHLoZc85lvA2xFwAm0UeI39jdZfObQlifC2TninEuCsObI5Ax74PiPp0PTcG
 fYHJF9KnAZMAnB0pnPm7rWUacfkAbxjJDucNFviAlBmuzys3QpLp1QtJNLb889sM
 0TQFVcFzw6egWMC6EIbg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u7w26pu8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 16:01:40 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2E89E100056;
 Fri, 10 Nov 2023 16:01:39 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1E6DA2C38C4;
 Fri, 10 Nov 2023 16:01:39 +0100 (CET)
Received: from [10.201.20.54] (10.201.20.54) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 10 Nov
 2023 16:01:38 +0100
Message-ID: <f8647181-10d0-4828-b952-22ec7fccca9d@foss.st.com>
Date: Fri, 10 Nov 2023 16:01:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL] Pull request for u-boot master / v2024.01 =
 u-boot-stm32-20231110
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Tom Rini <trini@konsulko.com>
CC: Marek Vasut <marex@denx.de>, bhupesh Sharma <bhupesh.sharma@linaro.org>,
 Igor Opaniuk <igor.opaniuk@foundries.io>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Patrick DELAUNAY <patrick.delaunay@foss.st.com>
References: <514cda49-ae67-4cd8-b953-32d89a4ebaca@foss.st.com>
In-Reply-To: <514cda49-ae67-4cd8-b953-32d89a4ebaca@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.54]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_12,2023-11-09_01,2023-05-22_02
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

Add missing u-boot@lists.denx.de and patrick.delaunay@foss.st.com

On 11/10/23 14:48, Patrice CHOTARD wrote:
> Hi Tom
> 
> Please pull the STM32 related patches for u-boot/master, v2024.01: u-boot-stm32-20231110
> 
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/18503
> 
> The following changes since commit e17d174773e9ba9447596708e702b7382e47a6cf:
> 
>   Merge tag 'xilinx-for-v2024.01-rc3' of https://source.denx.de/u-boot/custodians/u-boot-microblaze (2023-11-07 10:36:23 -0500)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20231110
> 
> for you to fetch changes up to c205fe979ebc1961cf28555c00e24a9004761366:
> 
>   stm32mp1: read auth stats and boot_partition from tamp (2023-11-10 13:34:10 +0100)
> 
> ----------------------------------------------------------------
> _ Fix compilation issue when SYS_DCACHE_OFF and/or SYS_DCACHE_SYS are enabled
> _ Fix issue following DT sync with kernel 6.3 for stm32mp15xx-ev1 and DHSOM SoM
> _ Enable TCP, IPv6, wget on DH STM32MP15 DHSOM
> _ Limit u-boot.itb size to 0x160000 bytes on DH STM32MP15 DHSOM
> _ Read auth stats and boot_partition from tamp
> 
> ----------------------------------------------------------------
> Bhupesh Sharma (1):
>       arm: stm32mp: Really fix compilation issue when SYS_DCACHE_OFF and/or SYS_DCACHE_SYS are enabled
> 
> Igor Opaniuk (1):
>       stm32mp1: read auth stats and boot_partition from tamp
> 
> Marek Vasut (3):
>       ARM: dts: stm32mp: Repair damage from alignment with v6.3
>       arm: stm32: Enable TCP, IPv6, wget on DH STM32MP15 DHSOM
>       arm: stm32: Limit u-boot.itb size to 0x160000 bytes on DH STM32MP15 DHSOM
> 
>  arch/arm/dts/stm32mp157c-ev1-u-boot.dtsi       | 16 ++++++++++++----
>  arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi     | 12 +++---------
>  arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi     |  8 ++++++--
>  arch/arm/mach-stm32mp/cpu.c                    | 27 +++++++++++++++++++++++++--
>  arch/arm/mach-stm32mp/include/mach/stm32.h     |  4 ++++
>  arch/arm/mach-stm32mp/include/mach/sys_proto.h |  3 +++
>  configs/stm32mp15_dhcom_basic_defconfig        |  7 +++++++
>  configs/stm32mp15_dhcor_basic_defconfig        |  7 +++++++
>  8 files changed, 67 insertions(+), 17 deletions(-)
