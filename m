Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7663ED43FF8
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 09:24:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2F5C8943E;
	Mon, 18 Nov 2024 10:24:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 510B68943E; Mon, 18 Nov 2024 10:24:45 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 471C38857C
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 10:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 4AI9OZpo087838
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 18 Nov 2024 17:24:35 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 17:24:36 +0800
Date: Mon, 18 Nov 2024 17:24:34 +0800
From: Leo Liang <ycliang@andestech.com>
To: Andreas Schwab <schwab@suse.de>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCH] configs: visionfive2: re-enable SPL_SYS_MMCSD_RAW_MODE
Message-ID: <ZzsH0kyq1Pe33FJr@swlinux02>
References: <mvmy11ov2mt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <mvmy11ov2mt.fsf@suse.de>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 4AI9OZpo087838
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

On Tue, Nov 12, 2024 at 05:27:22PM +0100, Andreas Schwab wrote:
> To restore MMC boot, enable SPL_SYS_MMCSD_RAW_MODE and recover
> SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION and
> SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION.
> 
> Fixes: 2a00d73d081 ("spl: mmc: Try to clean up raw-mode options")
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  configs/starfive_visionfive2_defconfig | 3 +++
>  1 file changed, 3 insertions(+)

Applied to u-boot-riscv/master, thanks!

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
