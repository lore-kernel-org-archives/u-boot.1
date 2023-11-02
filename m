Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54186C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 07:47:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C883787598;
	Thu,  2 Nov 2023 08:47:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1C9587597; Thu,  2 Nov 2023 08:47:47 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73B9C875A8
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 08:47:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3A27lckM019031;
 Thu, 2 Nov 2023 15:47:38 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Thu, 2 Nov 2023 15:47:35 +0800
Date: Thu, 2 Nov 2023 15:43:48 +0800
From: Leo Liang <ycliang@andestech.com>
To: Chanho Park <chanho61.park@samsung.com>
CC: Yanhong Wang <yanhong.wang@starfivetech.com>, Rick Chen
 <rick@andestech.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/2] board: starfive: spl: Support jtag for VisionFive2
 board
Message-ID: <ZUNTNK3xv5hYE5Rc@swlinux02>
References: <20231031085600.992544-1-chanho61.park@samsung.com>
 <CGME20231031085623epcas2p2db84ad3e0578fc0014b109edea4462b7@epcas2p2.samsung.com>
 <20231031085600.992544-3-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231031085600.992544-3-chanho61.park@samsung.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3A27lckM019031
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

On Tue, Oct 31, 2023 at 05:56:00PM +0900, Chanho Park wrote:
> JTAG pins are mapped as below. To access the JTAG pins, we need to
> control the GPIO pins from SPL which seems to be the earliest stage for
> JTAG.
> 
> - JTAG nTRST:	GPIO36 / Input
> - JTAG TDI:	GPIO61 / Input
> - JTAG TMS:	GPIO63 / Input
> - JTAG TCK:	GPIO60 / Input
> - JTAG TDO:	GPIO44 / Output
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>  board/starfive/visionfive2/spl.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
