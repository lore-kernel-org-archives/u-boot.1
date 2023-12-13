Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F6DC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 06:36:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A4B9876CC;
	Wed, 13 Dec 2023 07:36:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78DC38747A; Wed, 13 Dec 2023 07:36:08 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27CAA86EEB
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 07:36:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3BD6Zx2P017687;
 Wed, 13 Dec 2023 14:35:59 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Wed, 13 Dec 2023 14:35:56 +0800
Date: Wed, 13 Dec 2023 14:35:54 +0800
From: Leo Liang <ycliang@andestech.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, <yanhong.wang@starfivetech.com>,
 <minda.chen@starfivetech.com>, <xingyu.wu@starfivetech.com>
Subject: Re: [PATCH 1/2] riscv: dts: jh7110: Add a gpio-restart node
Message-ID: <ZXlQyj_rRFqTTxcb@swlinux02>
References: <CGME20231031082448epcas1p33a8ff166d2e48df3dcd6c0b1f0132efc@epcas1p3.samsung.com>
 <20231031082439.395320-1-jh80.chung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231031082439.395320-1-jh80.chung@samsung.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3BD6Zx2P017687
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

On Tue, Oct 31, 2023 at 05:24:38PM +0900, Jaehoon Chung wrote:
> Add gpio-restart node to do reset.
> 
> Before applied this patch, System Reset Extension doesn't appear with
> sbi command.
> 
> OpenSBI 1.3
> Machine:
>   Vendor ID 489
>   Architecture ID 8000000000000007
>   Implementation ID 4210427
> Extensions:
>   sbi_set_timer
>   sbi_console_putchar
> ...[snip]...
>   IPI Extension
>   RFENCE Extension
>   Hart State Management Extension
>   Performance Monitoring Unit Extension
> 
> After applied this patch, System Reset Extension is supported from SBI.
> 
> OpenSBI 1.3
> Machine:
>   Vendor ID 489
>   Architecture ID 8000000000000007
>   Implementation ID 4210427
> Extensions:
>   sbi_set_timer
>   sbi_console_putchar
> ...[snip]...
>   IPI Extension
>   RFENCE Extension
>   Hart State Management Extension
>   System Reset Extension
>   Performance Monitoring Unit Extension
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
