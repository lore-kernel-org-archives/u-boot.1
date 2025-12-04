Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9ECD1F9CF
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 11:55:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4D938405B;
	Thu,  4 Dec 2025 12:55:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0955809A5; Thu,  4 Dec 2025 12:55:19 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FB2383A84
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 12:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 5B4BsA2P066959
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Thu, 4 Dec 2025 19:54:10 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Dec
 2025 19:54:10 +0800
Date: Thu, 4 Dec 2025 19:54:10 +0800
From: Leo Liang <ycliang@andestech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: Rick Chen <rick@andestech.com>, Yao Zi <ziyao@disroot.org>, E Shattow
 <e@freeshell.de>, Hal Feng <hal.feng@starfivetech.com>, Mayuresh Chitale
 <mchitale@ventanamicro.com>,
 Minda Chen <minda.chen@starfivetech.com>, <u-boot@lists.denx.de>,
 Heinrich Schuchardt <zfsdt@canonical.com>
Subject: Re: [PATCH 1/2] RISC-V: implement private GCC library
Message-ID: <aTF2YsjAwDB58eBL@swlinux02>
References: <20251201174705.652626-1-zfsdt@canonical.com>
 <20251201174705.652626-2-zfsdt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251201174705.652626-2-zfsdt@canonical.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 5B4BsA2P066959
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

On Mon, Dec 01, 2025 at 06:47:04PM +0100, Heinrich Schuchardt wrote:
> [EXTERNAL MAIL]
> 
> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> 
> The following functions are provided:
> 
> Count leading zero bits
> 
> * int __clzsi2 (unsigned int a)
> * int __clzdi2 (unsigned long a)
> * int __clzti2 (unsigned long long a)
> 
> Count trailing zero bits
> 
> * int __ctzsi2 (unsigned int a)
> * int __ctzdi2 (unsigned long a)
> * int __ctzti2 (unsigned long long a)
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Signed-off-by: Heinrich Schuchardt <zfsdt@canonical.com>
> ---
>  arch/Kconfig            |   1 +
>  arch/riscv/lib/Makefile |   2 +
>  arch/riscv/lib/clz.c    | 105 ++++++++++++++++++++++++++++++++++++++++
>  arch/riscv/lib/ctz.c    |  95 ++++++++++++++++++++++++++++++++++++
>  lib/Kconfig             |   2 +-
>  5 files changed, 204 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/lib/clz.c
>  create mode 100644 arch/riscv/lib/ctz.c

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
