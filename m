Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B90BCDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 06:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D1FC86BE0;
	Tue, 17 Oct 2023 08:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0F3286BAA; Tue, 17 Oct 2023 08:54:24 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66FC286C66
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 08:54:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 39H6sExa055400;
 Tue, 17 Oct 2023 14:54:14 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Tue, 17 Oct 2023 14:54:13 +0800
Date: Tue, 17 Oct 2023 14:51:23 +0800
From: Leo Liang <ycliang@andestech.com>
To: Chanho Park <chanho61.park@samsung.com>
CC: Yanhong Wang <yanhong.wang@starfivetech.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] configs: visionfive2: enable bootstage configs
Message-ID: <ZS4u68AkBJohvZWm@swlinux02>
References: <CGME20231010084939epcas2p1aac03b2cfd5bb395cd4bd6f0faba86fb@epcas2p1.samsung.com>
 <20231010084918.2943894-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231010084918.2943894-1-chanho61.park@samsung.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 39H6sExa055400
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

On Tue, Oct 10, 2023 at 05:49:18PM +0900, Chanho Park wrote:
> Enable BOOTSTAGE configuration and its command for visionfive2 board.
> The feature can be useful for analyzing the elapsed time between boot
> stages.
> 
> TODO: define / reserve memory region for boot stage stash
> 
> StarFive # bootstage report
> Timer summary in microseconds (10 records):
>        Mark    Elapsed  Stage
>           0          0  reset
>   3,139,338  3,139,338  board_init_f
>   3,176,753     37,415  board_init_r
>   4,036,111    859,358  eth_common_init
>   4,101,599     65,488  eth_initialize
>   4,105,799      4,200  main_loop
>   4,145,207     39,408  usb_start
>   5,440,963  1,295,756  cli_loop
> 
> Accumulated time:
>                 10,093  dm_f
>                 15,867  dm_r
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>  configs/starfive_visionfive2_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
