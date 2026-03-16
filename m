Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D136DD58B07
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 12:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E71A83FED;
	Mon, 16 Mar 2026 13:23:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EAB68400F; Mon, 16 Mar 2026 13:23:45 +0100 (CET)
Received: from Atcsqr.andestech.com (unknown [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 490A983FEC
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 13:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 62GCNYdI084801;
 Mon, 16 Mar 2026 20:23:34 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Mar
 2026 20:23:34 +0800
Date: Mon, 16 Mar 2026 20:23:31 +0800
From: Leo Liang <ycliang@andestech.com>
To: E Shattow <e@freeshell.de>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>,
 <rick@andestech.com>, <nick.hu@sifive.com>, <jimmy.ho@sifive.com>,
 <schwab@suse.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [GIT,PULL] u-boot-riscv/next
Message-ID: <abf2QyGifRhAs9yI@swlinux02>
References: <abNxIFSAFWMgeEEf@swlinux02>
 <177342068508.1062380.5101081635850084640.b4-ty@konsulko.com>
 <5cbcf317-f36e-4c57-9a97-0b5f27bf17df@freeshell.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5cbcf317-f36e-4c57-9a97-0b5f27bf17df@freeshell.de>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 62GCNYdI084801
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

On Fri, Mar 13, 2026 at 03:59:59PM -0700, E Shattow wrote:
> [EXTERNAL MAIL]
> 
> Hi Leo, and Tom,
> 
> On 3/13/26 09:52, Tom Rini wrote:
> > On Fri, 13 Mar 2026 10:06:24 +0800, Leo Liang wrote:
> >
> >> The following changes since commit 8bc2a5196c1c0bb5dbdaca073323da0015a0de37:
> >>
> >>   arm: k3: Kconfig: Enable fTPM and RPMB support (2026-03-10 12:35:18 -0600)
> >>
> >> are available in the Git repository at:
> >>
> >>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git next
> >>
> >> [...]
> >
> > Merged into u-boot/next, thanks!
> >
> 
> Did we get a resolution on applying Hal's series to add support for
> VisionFive 2 Lite ?  ref.:
> https://lore.kernel.org/u-boot/20260214145634.GQ2747538@bill-the-cat/
> 
> -E

Hi E,

The previous mistake was made when resolving the conflicts.
I am preparing PRs now for all the "board support" patchsets,
and still see some minor issues.
I will send out those PRs once the issues are resolved.
Thanks for the reminder!

Best regards,
Leo
