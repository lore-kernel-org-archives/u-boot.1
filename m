Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93C6C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 06:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 301DC88CF6;
	Thu,  2 May 2024 08:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D87D88D00; Thu,  2 May 2024 08:33:45 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 197D888CCA
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 08:33:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 4426XJea028412;
 Thu, 2 May 2024 14:33:19 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Thu, 2 May 2024 14:33:17 +0800
Date: Thu, 2 May 2024 14:33:13 +0800
From: Leo Liang <ycliang@andestech.com>
To: Lukas Funke <lukas.funke-oss@weidmueller.com>
CC: <u-boot@lists.denx.de>, E Shattow <lucent@gmail.com>, Lukas Funke
 <lukas.funke@weidmueller.com>, Minda Chen <minda.chen@starfivetech.com>,
 Simon Glass <sjg@chromium.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 2/2] board: starfive: Rename spl_soc_init() to
 spl_dram_init()
Message-ID: <ZjMzqeOi-xHjfnmG@swlinux02>
References: <20240424074339.210851-1-lukas.funke-oss@weidmueller.com>
 <20240424074339.210851-3-lukas.funke-oss@weidmueller.com>
 <3707b3b7-8ded-4c97-93fe-491da21feb0f@gmx.de>
 <feb52626-c8ac-4ccd-939a-ea0d7495fe3c@weidmueller.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <feb52626-c8ac-4ccd-939a-ea0d7495fe3c@weidmueller.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 4426XJea028412
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

On Thu, May 02, 2024 at 08:06:43AM +0200, Lukas Funke wrote:
> [EXTERNAL MAIL]
> 
> On 24.04.2024 13:01, Heinrich Schuchardt wrote:
> > On 24.04.24 09:43, lukas.funke-oss@weidmueller.com wrote:
> > > From: Lukas Funke <lukas.funke@weidmueller.com>
> > > 
> > > Rename spl_soc_init() to spl_dram_init() because the generic function
> > > name does not reflect what the function actually does. Also
> > > spl_dram_init() is commonly used for dram initialization and should be
> > > called from board_init_f().
> > > 
> > > Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> > 
> > Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Any objection on this one?

Hi Lukas,

This patch has been merged to u-boot-riscv. Thanks!

Best regards,
Leo
