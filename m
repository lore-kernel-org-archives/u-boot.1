Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7270FC71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 06:30:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D1F586886;
	Mon,  4 Sep 2023 08:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C3478689A; Mon,  4 Sep 2023 08:30:05 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFEA586867
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 08:30:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3846Tefq010462;
 Mon, 4 Sep 2023 14:29:40 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Mon, 4 Sep 2023 14:29:35 +0800
Date: Mon, 4 Sep 2023 14:28:43 +0800
From: Leo Liang <ycliang@andestech.com>
To: Shengyu Qu <wiagn233@outlook.com>
CC: <rick@andestech.com>, <yanhong.wang@starfivetech.com>, <sjg@chromium.org>, 
 <andre.przywara@arm.com>, <xypron.glpk@gmx.de>, <michal.simek@amd.com>,
 <marek.vasut+renesas@mailbox.org>, <jbx6244@gmail.com>,
 <bmeng@tinylab.org>, <ganboing@gmail.com>,
 <minda.chen@starfivetech.com>, <seanga2@gmail.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 4/4] configs: starfive: Disable
 SYS_MALLOC_CLEAR_ON_INIT by default
Message-ID: <ZPV5G9D0ioO1OAS3@swlinux02>
References: <20230824162521.22240-1-wiagn233@outlook.com>
 <TY3P286MB2611C8919347A7E4B420FF54981DA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <TY3P286MB2611C8919347A7E4B420FF54981DA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3846Tefq010462
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

On Fri, Aug 25, 2023 at 12:25:21AM +0800, Shengyu Qu wrote:
> SPL_SYS_MALLOC_CLEAR_ON_INIT would enable SYS_MALLOC_CLEAR_ON_INIT by
> default, but that's not need on JH7110, so disable that.
> 
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> ---
>  configs/starfive_visionfive2_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
