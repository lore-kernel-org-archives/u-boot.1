Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709C6D1F9D1
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 12:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E75D884011;
	Thu,  4 Dec 2025 13:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F02F084015; Thu,  4 Dec 2025 13:03:52 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4415583A94
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 13:03:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 5B4C2obq072710
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Thu, 4 Dec 2025 20:02:50 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Dec
 2025 20:02:50 +0800
Date: Thu, 4 Dec 2025 20:02:50 +0800
From: Leo Liang <ycliang@andestech.com>
To: E Shattow <e@freeshell.de>
CC: Minda Chen <minda.chen@starfivetech.com>, Hal Feng
 <hal.feng@starfivetech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom
 Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] configs: starfive: enable wget https
Message-ID: <aTF4al8T1pdf0NyR@swlinux02>
References: <20251112005451.41285-1-e@freeshell.de>
 <d9088cf7-07c0-4458-852d-e083fa0aeb8f@freeshell.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d9088cf7-07c0-4458-852d-e083fa0aeb8f@freeshell.de>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 5B4C2obq072710
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

Hi E,

On Sun, Nov 30, 2025 at 03:00:03AM -0800, E Shattow wrote:
> [EXTERNAL MAIL]
> 
> Hi to all,
> 
> On 11/11/25 16:54, E Shattow wrote:
> > Enable WGET_HTTPS (no CA verification; also enables dependency MBEDTLS_LIB)
> >
> > Signed-off-by: E Shattow <e@freeshell.de>
> > ---
> >  configs/starfive_visionfive2_defconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
> > index fa83ecfa10f..a754134a313 100644
> > --- a/configs/starfive_visionfive2_defconfig
> > +++ b/configs/starfive_visionfive2_defconfig
> > @@ -76,6 +76,7 @@ CONFIG_CMD_PCI=y
> >  CONFIG_CMD_USB=y
> >  CONFIG_CMD_WDT=y
> >  CONFIG_CMD_WGET=y
> > +CONFIG_WGET_HTTPS=y
> >  CONFIG_CMD_BOOTSTAGE=y
> >  CONFIG_OF_BOARD=y
> >  CONFIG_DEVICE_TREE_INCLUDES="starfive-visionfive2-u-boot.dtsi"
> > @@ -154,3 +155,4 @@ CONFIG_USB_GADGET=y
> >  # CONFIG_WATCHDOG_AUTOSTART is not set
> >  CONFIG_WDT=y
> >  CONFIG_WDT_STARFIVE=y
> > +CONFIG_MBEDTLS_LIB=y
> >
> > base-commit: caa740df9cae5ddc74b18b88a4fea43e27b2fdf6
> 
> If there are no objections then can this then be applied for the 2026.01
> release?
> 
> -E

Roger!

I will merge this patch after Heinrich's libgcc implementation patch is merged.

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>

Best regards,
Leo
