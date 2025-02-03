Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA53CC0218A
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 04:00:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65A588022E;
	Mon,  3 Feb 2025 05:00:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38B0880243; Mon,  3 Feb 2025 05:00:05 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37BCC80214
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 05:00:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 5133xod0023978
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 3 Feb 2025 11:59:50 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 11:59:50 +0800
Date: Mon, 3 Feb 2025 11:59:46 +0800
From: Leo Liang <ycliang@andestech.com>
To: Yu-Chien Peter Lin <peter.lin@sifive.com>
CC: <trini@konsulko.com>, <xypron.glpk@gmx.de>, <seashell11234455@gmail.com>, 
 <dan.carpenter@linaro.org>, <mchitale@ventanamicro.com>,
 <ben.dooks@codethink.co.uk>, <u-boot@lists.denx.de>
Subject: Re: [RFC PATCH 2/2] riscv: dts: binman.dtsi: Include OP-TEE OS image
Message-ID: <Z6A_MufA_iK62XKq@swlinux02>
References: <20250111015527.35528-1-peter.lin@sifive.com>
 <20250111015527.35528-3-peter.lin@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250111015527.35528-3-peter.lin@sifive.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 5133xod0023978
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

On Sat, Jan 11, 2025 at 09:55:27AM +0800, Yu-Chien Peter Lin wrote:
> The following diagram illustrates the boot flow for OP-TEE OS
> initialization on RISC-V.
> 
>     (1)-----------+
>      | U-Boot SPL |
>      +------------+
>          |
>          v
>     (2)-------------------------------------------------------------+
>      | OpenSBI (fw_dynamic.bin)                                     |
>      |                (4)------------------------+                  |
>      |                 | optee dispatcher driver |                  |
>      +-----------------+-------^---------|-------+------------------+
> M-mode   |                     |         |
> ---------+--[trusted domain]---+----.----+--[untrusted domain]-------
> S-mode   |  (coldboot domain)  |    |    |
>          v                     |    |    v
>     (3)---------------------------+ |(5)----------------------------+
>      | OP-TEE OS (tee.bin)        | | | U-Boot (u-boot-nodtb.bin)   |
>      +----------------------------+ | +-----------------------------+
>                                     |    |
>                                     |    v
>                                     |(6)----------------------------+
>                                     | | Linux                       |
>                                     | +-----------------------------+
> 
> This patch enables the inclusion of the OP-TEE binary within the
> U-Boot ITB, allowing it to be loaded to a platform defined address
> by U-Boot SPL.
> 
> Signed-off-by: Yu-Chien Peter Lin <peter.lin@sifive.com>
> ---
>  arch/riscv/dts/binman.dtsi | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
