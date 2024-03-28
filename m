Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C89C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 07:37:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0DE2880A7;
	Thu, 28 Mar 2024 08:37:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2942880BB; Thu, 28 Mar 2024 08:37:23 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3129083346
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 08:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 42S7awbr069187;
 Thu, 28 Mar 2024 15:36:58 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Thu, 28 Mar 2024 15:36:57 +0800
Date: Thu, 28 Mar 2024 15:36:54 +0800
From: Leo Liang <ycliang@andestech.com>
To: Ben Dooks <ben.dooks@codethink.co.uk>
CC: <u-boot@lists.denx.de>, <ganboing@gmail.com>, <rick@andestech.com>
Subject: Re: [[PATCH v2]] riscv: add backtrace support
Message-ID: <ZgUeFgh2IMpg19uZ@swlinux02>
References: <20230905121253.269941-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230905121253.269941-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 42S7awbr069187
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

On Tue, Sep 05, 2023 at 01:12:53PM +0100, Ben Dooks wrote:
> When debugging, it is useful to have a backtrace to find
> out what is in the call stack as the previous function (RA)
> may not have been the culprit.
> 
> Since this adds size to the build, do not add it by default
> and avoid putting it in the SPL build if not needed.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> v2:
>   - back to codethink email as sifive account is now gone
>   - add option to build SPL with frame pointer
>     (as suggested by Bo Gan <ganboing@gmail.com>
> ---
>  arch/riscv/Kconfig          | 20 ++++++++++++++++++++
>  arch/riscv/Makefile         |  4 ++++
>  arch/riscv/cpu/start.S      |  1 +
>  arch/riscv/lib/interrupts.c | 35 +++++++++++++++++++++++++++++++++++
>  4 files changed, 60 insertions(+)

Tested-by: Leo Yu-Chi Liang <ycliang@andestech.com>
