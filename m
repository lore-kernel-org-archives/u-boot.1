Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41F3CAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 10:44:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEE818319C;
	Fri, 19 Sep 2025 12:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E60988319C; Fri, 19 Sep 2025 12:44:00 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E19083071
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 12:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 58JAhnMU067993
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Fri, 19 Sep 2025 18:43:49 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 19 Sep
 2025 18:43:49 +0800
Date: Fri, 19 Sep 2025 18:43:46 +0800
From: Leo Liang <ycliang@andestech.com>
To: Jamie Gibbons <jamie.gibbons@microchip.com>
CC: <u-boot@lists.denx.de>, Conor Dooley <conor.dooley@microchip.com>,
 Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>, Cyril
 Jean <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/6] board: microchip: icicle: rename all icicle files to
 generic
Message-ID: <aM0z4jdzLkk7KAGr@swlinux02>
References: <20250902101105.3218793-1-jamie.gibbons@microchip.com>
 <20250902101105.3218793-2-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250902101105.3218793-2-jamie.gibbons@microchip.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 58JAhnMU067993
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

On Tue, Sep 02, 2025 at 11:10:58AM +0100, Jamie Gibbons wrote:
> Make all Icicle Kit files generic. This supports the addition of
> upcoming support for other MPFS boards.
> 
> Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
> ---
>  arch/riscv/Kconfig                                         | 6 +++---
>  board/microchip/{mpfs_icicle => mpfs_generic}/Kconfig      | 6 +++---
>  board/microchip/mpfs_generic/MAINTAINERS                   | 7 +++++++
>  board/microchip/{mpfs_icicle => mpfs_generic}/Makefile     | 2 +-
>  .../mpfs_icicle.c => mpfs_generic/mpfs_generic.c}          | 0
>  board/microchip/mpfs_icicle/MAINTAINERS                    | 7 -------
>  ...s_icicle_defconfig => microchip_mpfs_generic_defconfig} | 2 +-
>  .../{microchip_mpfs_icicle.h => microchip_mpfs_generic.h}  | 0
>  8 files changed, 15 insertions(+), 15 deletions(-)
>  rename board/microchip/{mpfs_icicle => mpfs_generic}/Kconfig (92%)
>  create mode 100644 board/microchip/mpfs_generic/MAINTAINERS
>  rename board/microchip/{mpfs_icicle => mpfs_generic}/Makefile (85%)
>  rename board/microchip/{mpfs_icicle/mpfs_icicle.c => mpfs_generic/mpfs_generic.c} (100%)
>  delete mode 100644 board/microchip/mpfs_icicle/MAINTAINERS
>  rename configs/{microchip_mpfs_icicle_defconfig => microchip_mpfs_generic_defconfig} (95%)
>  rename include/configs/{microchip_mpfs_icicle.h => microchip_mpfs_generic.h} (100%)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
