Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE09C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 03:35:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D61288019;
	Thu, 28 Mar 2024 04:35:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FD0C88035; Thu, 28 Mar 2024 04:35:38 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B64A087F95
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 04:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 42S3ZIgn065463;
 Thu, 28 Mar 2024 11:35:18 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Thu, 28 Mar 2024 11:35:15 +0800
Date: Thu, 28 Mar 2024 11:35:13 +0800
From: Leo Liang <ycliang@andestech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: Minda Chen <minda.chen@starfivetech.com>, Rick Chen <rick@andestech.com>, 
 Lukasz Tekieli <tekieli.lukasz@gmail.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Chanho Park <chanho61.park@samsung.com>, Shiji Yang
 <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>, Seung-Woo Kim
 <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 3/6] riscv: set fdtfile on Milk-V Mars
Message-ID: <ZgTlccEClT82B9uY@swlinux02>
References: <20240321181149.177356-1-heinrich.schuchardt@canonical.com>
 <20240321181149.177356-4-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240321181149.177356-4-heinrich.schuchardt@canonical.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 42S3ZIgn065463
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

On Thu, Mar 21, 2024 at 07:11:46PM +0100, Heinrich Schuchardt wrote:
> Set environment variable fdtfile to the correct value for the Milk-V Mars
> board.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	rebase patch
> ---
>  .../visionfive2/starfive_visionfive2.c        | 43 +++++++++++++------
>  1 file changed, 30 insertions(+), 13 deletions(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
