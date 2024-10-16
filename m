Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B8FD2A538
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 18:31:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 153EC88DA0;
	Wed, 16 Oct 2024 20:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="nhuoq+ru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FCC888D14; Wed, 16 Oct 2024 20:31:51 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 765B888DA0
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 20:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0019cf4dfa=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GCuhSg018118;
 Wed, 16 Oct 2024 20:31:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 p7qUFhfXXVBMd26t63cvSfH/zibPnkiW6bkampo7SOA=; b=nhuoq+ruUQZ2NyZ4
 Xkv4kuIdXYO64nsQmOf61Q7ac/zSYHSYhw+lNXGEh5cxtGjmMiNh2PMxmKQMM8ej
 Zf+yGtw59w9SR4p8VM+XTQwaEJk9Ybl7T1mRmkEbnalwc1YdncSO0biQyi64oX6O
 pX+xq/9bUavzBWxtAu3eF79E+LvAeKYJsr/1k/MZzLteYESniEyABR+OTFANPaRU
 gECn64GM2w8hNjKzr2OIGP7bwVPyv4RmHVP4iQ1X5i5n69Yfxb8PJRjfKyDbkS2x
 voxcyH8hKB6Kq4a5I62Vk0gtXlxvigGK2h3ZxPqZk+56knabZFzpPJ1EfDxv1eNv
 C8kCFA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42842jh93u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2024 20:31:36 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DD6E240047;
 Wed, 16 Oct 2024 20:30:31 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 268E526F251;
 Wed, 16 Oct 2024 20:30:03 +0200 (CEST)
Received: from [10.48.86.243] (10.48.86.243) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 16 Oct
 2024 20:30:02 +0200
Message-ID: <9207c905-e7b7-4fcb-832f-7412927f684c@foss.st.com>
Date: Wed, 16 Oct 2024 20:30:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ARM: stm32mp: enable data cache after LMB
 configuration for STM32MP1
To: <u-boot@lists.denx.de>
CC: Etienne CARRIERE <etienne.carriere@foss.st.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Igor Opaniuk <igor.opaniuk@foundries.io>, Marek
 Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20241011153152.1637303-1-patrick.delaunay@foss.st.com>
 <20241011173140.2.I898b6c22e3abfc31ee4efa0ff426f77640768faa@changeid>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20241011173140.2.I898b6c22e3abfc31ee4efa0ff426f77640768faa@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.243]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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

On 10/11/24 17:31, Patrick Delaunay wrote:
> Move the stm32mp1 data cache reconfiguration after the lmb init call
> board_r::initr_lmb to allow parsing of the reserved region with
> no-map tag.
>
> After this patch the DDR is not fully mapped up to arch_early_init_r()
> call, only the relocation region is mapped, but it is enough for
> the first board_r initialization phases; later, when arch_early_init_r()
> is called, the LMB is already initialized and the function
> lmb_is_reserved_flags() function is functional, this LMB function
> is called in the weak function dram_bank_mmu_setup() when
> dcache_enable() is executed.
>
> Without this change, as LMB is not initialized when it is used in
> dram_bank_mmu_setup, the OP-TEE region is mapped cache-able by U-Boot
> and we have some firewall violation since "LMB memory map global and
> persistent" series.
>
> Fixes: ed17a33fed29 ("lmb: make LMB memory map persistent and global")
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
>
>   arch/arm/mach-stm32mp/Kconfig        | 2 ++
>   arch/arm/mach-stm32mp/stm32mp1/cpu.c | 7 +++++++
>   2 files changed, 9 insertions(+)
>

Applied to u-boot-stm/master, thanks!

Regards
Patrick

