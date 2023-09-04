Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79D3C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 06:25:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11B8F86828;
	Mon,  4 Sep 2023 08:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74404867F7; Mon,  4 Sep 2023 08:25:51 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A395867F7
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 08:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3846PVGX007425;
 Mon, 4 Sep 2023 14:25:31 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Mon, 4 Sep 2023 14:25:27 +0800
Date: Mon, 4 Sep 2023 14:24:30 +0800
From: Leo Liang <ycliang@andestech.com>
To: Shengyu Qu <wiagn233@outlook.com>
CC: <rick@andestech.com>, <yanhong.wang@starfivetech.com>, <sjg@chromium.org>, 
 <andre.przywara@arm.com>, <xypron.glpk@gmx.de>, <michal.simek@amd.com>,
 <marek.vasut+renesas@mailbox.org>, <jbx6244@gmail.com>,
 <bmeng@tinylab.org>, <ganboing@gmail.com>,
 <minda.chen@starfivetech.com>, <seanga2@gmail.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 3/4] riscv: cpu: jh7110: Imply
 SPL_SYS_MALLOC_CLEAR_ON_INIT
Message-ID: <ZPV4HidwSuWuNugk@swlinux02>
References: <20230824162521.22240-1-wiagn233@outlook.com>
 <TY3P286MB261133B2CDB503E8F45DD39F981DA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <TY3P286MB261133B2CDB503E8F45DD39F981DA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3846PVGX007425
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

On Fri, Aug 25, 2023 at 12:25:20AM +0800, Shengyu Qu wrote:
> Starfive JH7110 needs to clear L2 LIM to zero before use or ECC error
> would be triggered. Currently, we use DDR ram for SPL malloc arena on
> Visionfive 2 board in defconfig, but it's also possible to use L2 LIM as
> SPL malloc arena. To avoid triggering ECC error in this scenario, we
> imply SPL_SYS_MALLOC_CLEAR_ON_INIT as default.
> 
> Signed-off-by: Bo Gan <ganboing@gmail.com>
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> ---
>  arch/riscv/cpu/jh7110/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
