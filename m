Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC1CC54E49
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 05:24:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7FC787DE8;
	Tue, 12 Mar 2024 06:24:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FBC287F00; Tue, 12 Mar 2024 06:24:08 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05B2787DE3
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 06:24:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 42C5NsFE095450;
 Tue, 12 Mar 2024 13:23:54 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Tue, 12 Mar 2024 13:23:52 +0800
Date: Tue, 12 Mar 2024 13:23:49 +0800
From: Leo Liang <ycliang@andestech.com>
To: <thomas.perrot@bootlin.com>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCH] riscv: sifive: fu740: reduce DDR speed from 1866MT/s to
 1600MT/s
Message-ID: <Ze_m5Zs1qmcSg_Zx@swlinux02>
References: <20240222145203.2659671-1-thomas.perrot@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240222145203.2659671-1-thomas.perrot@bootlin.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 42C5NsFE095450
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

On Thu, Feb 22, 2024 at 03:52:03PM +0100, thomas.perrot@bootlin.com wrote:
> From: Thomas Perrot <thomas.perrot@bootlin.com>
> 
> It appears that there is some timing marginality either in the
> board layout or the SoC that results in occasional data corruption
> on some boards.
> We observed this issue on some of the new HiFive Unmatched RevB
> boards during volume production as well as some of the original
> HiFive Unmatched boards from 2021 in our possession. This means
> that there are other boards out there that might have the issue
> too.
> 
> We have done some limited testing with DDR4 at 1600MT/s and
> faulty boards (failing at 1866MT/s) passed.
> We plan further testing after we procure a temperature chamber.
> 
> Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
> ---
>  arch/riscv/dts/fu740-c000-u-boot.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
