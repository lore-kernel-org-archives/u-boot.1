Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534F6C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 06:23:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9305A864F5;
	Mon,  4 Sep 2023 08:22:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D67E08648F; Mon,  4 Sep 2023 08:22:58 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3199886828
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 08:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3846Mn85004773;
 Mon, 4 Sep 2023 14:22:49 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Mon, 4 Sep 2023 14:22:47 +0800
Date: Mon, 4 Sep 2023 14:21:51 +0800
From: Leo Liang <ycliang@andestech.com>
To: Seung-Woo Kim <sw0312.kim@samsung.com>
CC: <yanhong.wang@starfivetech.com>, <u-boot@lists.denx.de>,
 <jh80.chung@samsung.com>, <l.stelmach@samsung.com>
Subject: Re: [PATCH] eeprom: starfive: set eth0 mac address properly
Message-ID: <ZPV3fw4Uv22TrtXH@swlinux02>
References: <CGME20230811071231epcas1p3688e154cfefd5579e3b71ec27a2964c2@epcas1p3.samsung.com>
 <20230811071225.22142-1-sw0312.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230811071225.22142-1-sw0312.kim@samsung.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3846Mn85004773
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

On Fri, Aug 11, 2023 at 04:12:25PM +0900, Seung-Woo Kim wrote:
> fdt_fixup_ethernet() sets eth0 mac address from ethaddr. Set
> ethaddr to environment instead of eth0addr.
> 
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> ---
>  board/starfive/visionfive2/visionfive2-i2c-eeprom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
