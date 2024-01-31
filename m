Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D19AC47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 08:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77DAA876EA;
	Wed, 31 Jan 2024 09:49:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A81D0876F4; Wed, 31 Jan 2024 09:49:34 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CD3586F80
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 09:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 40V8n9Xu051909;
 Wed, 31 Jan 2024 16:49:09 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Wed, 31 Jan 2024 16:49:08 +0800
Date: Wed, 31 Jan 2024 16:49:06 +0800
From: Leo Liang <ycliang@andestech.com>
To: Nam Cao <namcao@linutronix.de>
CC: Rick Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>, "Yanhong
 Wang" <yanhong.wang@starfivetech.com>, Minda Chen
 <minda.chen@starfivetech.com>, Torsten Duwe <duwe@suse.de>, Xingyu Wu
 <xingyu.wu@starfivetech.com>, Mason Huo <mason.huo@starfivetech.com>, "Hal
 Feng" <hal.feng@starfivetech.com>,
 Chanho Park <chanho61.park@samsung.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 1/2] riscv: dts: jh7110: add power management unit
 controller node
Message-ID: <ZboJgqX6MZeJhox9@swlinux02>
References: <cover.1706517351.git.namcao@linutronix.de>
 <05a8be865b0686a916d7ec7ba8fbc64ecb33ad14.1706517351.git.namcao@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <05a8be865b0686a916d7ec7ba8fbc64ecb33ad14.1706517351.git.namcao@linutronix.de>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 40V8n9Xu051909
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

On Mon, Jan 29, 2024 at 09:43:08AM +0100, Nam Cao wrote:
> JH7110 has a power management unit controller node. Add this node.
> 
> This device is used by OpenSBI during board reset/shutdown.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  arch/riscv/dts/jh7110.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
