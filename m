Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C5BE7E0C7
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 11:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 960FF839A5;
	Mon,  9 Feb 2026 12:19:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C683583C29; Mon,  9 Feb 2026 12:19:26 +0100 (CET)
Received: from Atcsqr.andestech.com (exmail.andestech.com [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F1C08341A
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 12:19:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 619BJFpm047720;
 Mon, 9 Feb 2026 19:19:15 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Feb
 2026 19:19:15 +0800
Date: Mon, 9 Feb 2026 19:19:12 +0800
From: Leo Liang <ycliang@andestech.com>
To: Jimmy Ho <jimmy.ho@sifive.com>
CC: <u-boot@lists.denx.de>, <greentime.hu@sifive.com>, <nick.hu@sifive.com>
Subject: Re: [PATCH] driver: cache: Remove SiFive PL2 driver
Message-ID: <aYnCoctRzE-DZyuT@swlinux02>
References: <20260119055523.13460-1-jimmy.ho@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260119055523.13460-1-jimmy.ho@sifive.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 619BJFpm047720
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

On Mon, Jan 19, 2026 at 01:55:23PM +0800, Jimmy Ho wrote:
> From: Nick Hu <nick.hu@sifive.com>
> 
> Under single core boot platform, the secondary cores won't enter the
> u-boot spl. Therefore we move the pl2 driver from u-boot to the Opensbi.
> 
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> Signed-off-by: Jimmy Ho <jimmy.ho@sifive.com>
> ---
>  arch/riscv/lib/sifive_cache.c | 3 ---
>  drivers/cache/Kconfig         | 6 ------
>  drivers/cache/Makefile        | 1 -
>  3 files changed, 10 deletions(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
