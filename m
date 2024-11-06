Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123ECD44D50
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 11:25:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7976288D54;
	Wed,  6 Nov 2024 12:25:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 195F288FA8; Wed,  6 Nov 2024 12:25:37 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 138DA88D51
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 12:25:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 4A6BPLew080234
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Wed, 6 Nov 2024 19:25:21 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 19:25:21 +0800
Date: Wed, 6 Nov 2024 19:25:19 +0800
From: Leo Liang <ycliang@andestech.com>
To: Michal Simek <michal.simek@amd.com>
CC: <u-boot@lists.denx.de>, <git@xilinx.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/2] xilinx: mbv: Align smode_defconfig with upstream QEMU
Message-ID: <ZytSH1Tszdj77Gqp@swlinux02>
References: <e0109cec6a81163f213684758a5b2d67d927ea26.1730454591.git.michal.simek@amd.com>
 <f7da41aa5222bda46ff6cf869cd45f3088e677ed.1730454591.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f7da41aa5222bda46ff6cf869cd45f3088e677ed.1730454591.git.michal.simek@amd.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 4A6BPLew080234
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

On Fri, Nov 01, 2024 at 10:49:54AM +0100, Michal Simek wrote:
> Align smode defconfig with upstream QEMU. It could be the part of commit
> 9d688e6da5c9 ("riscv: mbv: Align DT with QEMU").
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  configs/xilinx_mbv32_smode_defconfig | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
