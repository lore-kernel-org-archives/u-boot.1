Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECD3C67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 10:10:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7E8587F07;
	Mon,  8 Apr 2024 12:10:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE21487F78; Mon,  8 Apr 2024 12:10:33 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C327D87EA9
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 12:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 438AABiZ067675;
 Mon, 8 Apr 2024 18:10:11 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Mon, 8 Apr 2024 18:10:09 +0800
Date: Mon, 8 Apr 2024 18:10:06 +0800
From: Leo Liang <ycliang@andestech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: Minda Chen <minda.chen@starfivetech.com>, Hal Feng
 <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 1/6] riscv: do not set default fdt for VisionFive 2
Message-ID: <ZhPCfs3-q8Ury5p2@swlinux02>
References: <20240402084912.43228-1-heinrich.schuchardt@canonical.com>
 <20240402084912.43228-2-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240402084912.43228-2-heinrich.schuchardt@canonical.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 438AABiZ067675
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

On Tue, Apr 02, 2024 at 10:49:07AM +0200, Heinrich Schuchardt wrote:
> Currently in set_fdtfile() we set the value of environment variable fdtfile
> unconditionally. The implies that a value in the environment will be
> ignored.
> 
> With the patch environment variable fdtfile will only be set if it does not
> yet exist. This requires that CONFIG_DEFAULT_FDT_FILE is not set.
> 
> Now the user can either set and save fdtfile interactively or in the U-Boot
> configuration to overrule the device-tree name chosen based on the
> hardware in set_fdtfile().
> 
> Reported-by: E Shattow <lucent@gmail.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v3:
> 	Rephrase last added sentence in doc/board/starfive/visionfive2.rst
> v2:
> 	new patch
> ---
>  .../visionfive2/starfive_visionfive2.c         |  4 ++++
>  configs/starfive_visionfive2_defconfig         |  1 -
>  doc/board/starfive/visionfive2.rst             | 18 ++++++++++++++++++
>  3 files changed, 22 insertions(+), 1 deletion(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
