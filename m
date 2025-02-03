Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AFDC0218A
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 03:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1333980077;
	Mon,  3 Feb 2025 04:59:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5FCD801DE; Mon,  3 Feb 2025 04:59:11 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81EF98004F
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 04:59:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 5133wtMt023247
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 3 Feb 2025 11:58:55 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 11:58:54 +0800
Date: Mon, 3 Feb 2025 11:58:51 +0800
From: Leo Liang <ycliang@andestech.com>
To: Yu-Chien Peter Lin <peter.lin@sifive.com>
CC: <trini@konsulko.com>, <xypron.glpk@gmx.de>, <seashell11234455@gmail.com>, 
 <dan.carpenter@linaro.org>, <mchitale@ventanamicro.com>,
 <ben.dooks@codethink.co.uk>, <u-boot@lists.denx.de>
Subject: Re: [RFC PATCH 1/2] riscv: Add CONFIG_SPL_OPTEE_LOAD_ADDR
Message-ID: <Z6A--zmLCy0IVbaR@swlinux02>
References: <20250111015527.35528-1-peter.lin@sifive.com>
 <20250111015527.35528-2-peter.lin@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250111015527.35528-2-peter.lin@sifive.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 5133wtMt023247
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

On Sat, Jan 11, 2025 at 09:55:26AM +0800, Yu-Chien Peter Lin wrote:
> Allow specifying load address of OP-TEE binary. It is
> recommended that the specified address aligns with the
> base address of an PMP-protected NAPOT region and matches
> the CFG_TDDRAM_START configuration in OP-TEE.
> 
> Signed-off-by: Yu-Chien Peter Lin <peter.lin@sifive.com>
> ---
>  arch/riscv/Kconfig | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
