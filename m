Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA451E77188
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 03:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D3788033D;
	Thu, 16 Jan 2025 04:21:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9791C80658; Thu, 16 Jan 2025 04:21:55 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B208980214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 04:21:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 50G3LSZG074808
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Thu, 16 Jan 2025 11:21:28 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 16 Jan
 2025 11:21:27 +0800
Date: Thu, 16 Jan 2025 11:21:23 +0800
From: Leo Liang <ycliang@andestech.com>
To: Yu-Chien Peter Lin <peter.lin@sifive.com>
CC: <zong.li@sifive.com>, <greentime.hu@sifive.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <xypron.glpk@gmx.de>, <jiaxun.yang@flygoat.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] Kconfig: Add a default cache line size for RISC-V
Message-ID: <Z4h7IsrhZWIg99pH@swlinux02>
References: <20250110085308.20760-1-peter.lin@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250110085308.20760-1-peter.lin@sifive.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 50G3LSZG074808
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

On Fri, Jan 10, 2025 at 04:53:08PM +0800, Yu-Chien Peter Lin wrote:
> [EXTERNAL MAIL]
> 
> Some RISC-V platforms do not define the d-cache line size
> through SYS_CACHE_SHIFT_n. Set a default value of 64 bytes
> for such cases.
> 
> Signed-off-by: Yu-Chien Peter Lin <peter.lin@sifive.com>
> ---
> This patch resolves compilation errors that occurs when
> the TEE driver is enabled:
> 
>   drivers/tee/tee-uclass.c:247:41: error: 'CONFIG_SYS_CACHELINE_SIZE' undeclared (first use in this function); did you mean 'CONFIG_SYS_CBSIZE'?
>     247 |                                         CONFIG_SYS_CACHELINE_SIZE);
>         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~
>   drivers/tee/optee/core.c: In function 'flush_shm_dcache':
>   drivers/tee/optee/core.c:505:50: error: 'CONFIG_SYS_CACHELINE_SIZE' undeclared (first use in this function); did you mean 'CONFIG_SYS_CBSIZE'?
>     505 |         flush_dcache_range(rounddown((ulong)arg, CONFIG_SYS_CACHELINE_SIZE),
>         |                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~
> ---
>  arch/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
