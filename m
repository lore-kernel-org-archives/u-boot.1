Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8E6C47DDB
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 02:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D5BA875A0;
	Wed, 31 Jan 2024 03:59:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 604B5875E9; Wed, 31 Jan 2024 03:59:22 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 325B087579
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 03:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 40V2xEfb009337;
 Wed, 31 Jan 2024 10:59:14 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Wed, 31 Jan 2024 10:59:13 +0800
Date: Wed, 31 Jan 2024 10:58:50 +0800
From: Leo Liang <ycliang@andestech.com>
To: Nylon Chen <nylon.chen@sifive.com>
CC: <u-boot@lists.denx.de>, <rick@andestech.com>, <paul.walmsley@sifive.com>, 
 <green.wan@sifive.com>, <vincent.chen@sifive.com>, <zong.li@sifve.com>,
 <nylon7717@gmail.com>
Subject: Re: [PATCH] board: sifive: spl: Initialized the PWM setting in the
 SPL stage
Message-ID: <Zbm3amqp-iV5-ZG_@swlinux02>
References: <20240116063557.28763-1-nylon.chen@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240116063557.28763-1-nylon.chen@sifive.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 40V2xEfb009337
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

On Tue, Jan 16, 2024 at 02:35:57PM +0800, Nylon Chen wrote:
> From: Vincent Chen <vincent.chen@sifive.com>
> 
> LEDs and multiple fans can be controlled by SPL. This patch ensures
> that all fans have been enabled in the SPL stage. In addition, the
> LED's color will be set to yellow.
> 
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> Co-developed-by: Nylon Chen <nylon.chen@sifive.com>
> Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> Co-developed-by: Zong Li <zong.li@sifve.com>
> Signed-off-by: Zong Li <zong.li@sifve.com>
> ---
>  arch/riscv/include/asm/arch-fu740/eeprom.h | 15 +++++++
>  board/sifive/unmatched/spl.c               | 52 ++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
>  create mode 100644 arch/riscv/include/asm/arch-fu740/eeprom.h

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
