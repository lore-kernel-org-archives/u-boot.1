Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAE9C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 03:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7693380805;
	Thu,  6 Mar 2025 04:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 492AA808A2; Thu,  6 Mar 2025 04:38:23 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1645B80756
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 04:38:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 5263c6UI078317
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Thu, 6 Mar 2025 11:38:06 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 11:38:06 +0800
Date: Thu, 6 Mar 2025 11:38:02 +0800
From: Leo Liang <ycliang@andestech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>,
 Yong-Xuan Wang <yongxuan.wang@sifive.com>, <u-boot@lists.denx.de>,
 Yuri Zaporozhets <yuriz@vodafonemail.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 1/1] configs: SiFive Unmatched: add 'nvme scan' to
 preboot
Message-ID: <Z8kYmoMNMLWx1KcY@swlinux02>
References: <20241112102644.37459-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241112102644.37459-1-heinrich.schuchardt@canonical.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 5263c6UI078317
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

On Tue, Nov 12, 2024 at 11:26:44AM +0100, Heinrich Schuchardt wrote:
> Without 'nvme scan' the ESP on the NVMe drive is not found early.
> EFI variables cannot be persisted.
> 
>     Hit any key to stop autoboot:  0
>     Cannot persist EFI variables without system partition
>     ** Booting bootflow '<NULL>' with efi_mgr
>     Loading Boot0000 'mmc 0' failed
>     EFI boot manager: Cannot load any image
>     Boot failed (err=-14)
>     scanning bus for devices...
>     ** Booting bootflow 'nvme#1.blk#1.bootdev.part_1' with efi
>     Booting /\EFI\BOOT\BOOTRISCV64.EFI
>     error: no suitable video mode found.
>     GNU GRUB  version 2.12
> 
> With 'nmve scan' booting works as expected.
> 
>     Hit any key to stop autoboot:  0
>     ** Booting bootflow '<NULL>' with efi_mgr
>     Loading Boot0000 'mmc 0' failed
>     Loading Boot0001 'nvme 0' failed
>     Booting: nvme 1
>     error: no suitable video mode found.
>     GNU GRUB  version 2.12
> 
> Reported by Yuri Zaporozhets <yuriz@vodafonemail.de>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	mention board in subject
> ---
>  configs/sifive_unmatched_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
