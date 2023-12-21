Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25023C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 10:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 822758784A;
	Thu, 21 Dec 2023 11:03:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33DA787853; Thu, 21 Dec 2023 11:03:10 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34E14877C8
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 11:03:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3BLA2xYb093721;
 Thu, 21 Dec 2023 18:02:59 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Thu, 21 Dec 2023 18:02:59 +0800
Date: Thu, 21 Dec 2023 18:02:56 +0800
From: Leo Liang <ycliang@andestech.com>
To: Zong Li <zong.li@sifive.com>
CC: <rick@andestech.com>, <peterlin@andestech.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/2] cache: add sifive private L2 cache driver
Message-ID: <ZYQNPZ26huRiabQ6@swlinux02>
References: <20231214140937.27784-1-zong.li@sifive.com>
 <20231214140937.27784-2-zong.li@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231214140937.27784-2-zong.li@sifive.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3BLA2xYb093721
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

On Thu, Dec 14, 2023 at 02:09:36PM +0000, Zong Li wrote:
> This driver is currently responsible for enabling the clock gating
> feature of SiFive pre core's private L2 cache.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  drivers/cache/Kconfig            |  7 +++++
>  drivers/cache/Makefile           |  1 +
>  drivers/cache/cache-sifive-pl2.c | 44 ++++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+)
>  create mode 100644 drivers/cache/cache-sifive-pl2.c

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
