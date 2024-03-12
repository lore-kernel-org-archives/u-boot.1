Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A62C54E49
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 05:12:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9DAB87D70;
	Tue, 12 Mar 2024 06:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7D9687DE3; Tue, 12 Mar 2024 06:12:48 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA9F18758B
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 06:12:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 42C5CKSc052824;
 Tue, 12 Mar 2024 13:12:20 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Tue, 12 Mar 2024 13:12:16 +0800
Date: Tue, 12 Mar 2024 13:12:13 +0800
From: Leo Liang <ycliang@andestech.com>
To: Bo Gan <ganboing@gmail.com>
CC: <rick@andestech.com>, <trini@konsulko.com>,
 <yanhong.wang@starfivetech.com>, <minda.chen@starfivetech.com>,
 <duwe@suse.de>, <namcao@linutronix.de>, <xingyu.wu@starfivetech.com>,
 <mason.huo@starfivetech.com>, <hal.feng@starfivetech.com>,
 <chanho61.park@samsung.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] riscv: dts: jh7110: Enable PLL node in SPL
Message-ID: <Ze_kLShwfoZ8TS88@swlinux02>
References: <1709694011-683-1-git-send-email-ganboing@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1709694011-683-1-git-send-email-ganboing@gmail.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 42C5CKSc052824
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

On Tue, Mar 05, 2024 at 07:00:11PM -0800, Bo Gan wrote:
> Previously PLL node was missing from SPL dts. This caused BUS_ROOT
> to stay on OSC clock (24Mhz). As a result, all peripherals have to
> run at a much lower frequency, and loading from sdcard/emmc is slow.
> Thus, enabling PLL node in dts to fix this.
> 
> Signed-off-by: Bo Gan <ganboing@gmail.com>
> ---
>  arch/riscv/dts/jh7110-u-boot.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
