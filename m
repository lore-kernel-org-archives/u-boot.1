Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DE9D1F9AE
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 10:39:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90A0283F9C;
	Thu,  4 Dec 2025 11:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC01B83FCD; Thu,  4 Dec 2025 11:38:58 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FD8683B4A
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 11:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 5B4AbrAO037965
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Thu, 4 Dec 2025 18:37:53 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Dec
 2025 18:37:53 +0800
Date: Thu, 4 Dec 2025 18:37:53 +0800
From: Leo Liang <ycliang@andestech.com>
To: Conor Dooley <conor@kernel.org>
CC: Hal Feng <hal.feng@starfivetech.com>, E Shattow <e@freeshell.de>, Tom Rini
 <trini@konsulko.com>, Rick Chen <rick@andestech.com>, Sumit Garg
 <sumit.garg@kernel.org>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v1 2/9] riscv: dts: starfive: Add VisionFive 2 Lite board
 device tree
Message-ID: <aTFkgSMcRONFGI_X@swlinux02>
References: <20251024085932.83596-1-hal.feng@starfivetech.com>
 <20251024085932.83596-3-hal.feng@starfivetech.com>
 <ff0313ed-5d43-4603-aed4-6e41b2abed37@freeshell.de>
 <ZQ2PR01MB13075E9B291AF6D313AF347DE6FC2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <aTFWSF-MFs40a37w@swlinux02>
 <20251204-exemplify-tribunal-bae6a028909e@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251204-exemplify-tribunal-bae6a028909e@spud>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 5B4AbrAO037965
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

On Thu, Dec 04, 2025 at 09:46:19AM +0000, Conor Dooley wrote:
> [EXTERNAL MAIL]

> Date: Thu, 4 Dec 2025 09:46:19 +0000
> From: Conor Dooley <conor@kernel.org>
> To: Leo Liang <ycliang@andestech.com>
> Cc: Hal Feng <hal.feng@starfivetech.com>, E Shattow <e@freeshell.de>, Tom
>  Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>, Sumit Garg
>  <sumit.garg@kernel.org>, Emil Renner Berthing
>  <emil.renner.berthing@canonical.com>, Heinrich Schuchardt
>  <heinrich.schuchardt@canonical.com>, "u-boot@lists.denx.de"
>  <u-boot@lists.denx.de>
> Subject: Re: [PATCH v1 2/9] riscv: dts: starfive: Add VisionFive 2 Lite
>  board device tree
> 
> On Thu, Dec 04, 2025 at 05:37:22PM +0800, Leo Liang wrote:
> > 
> > Got it. I have learned that the patchset is still being reviewed.
> > (https://lore.kernel.org/linux-riscv/20251125075604.69370-1-hal.feng@starfivetech.com/T/#t)
> > I will merge this patchset after the dts/upstream/ is sync'ed with Linux device tree.
> 
> Something must have gone wrong, because I applied those and sent a mail
> (via b4) that I had done so. They should appear in v6.19-rc1.

Hi Conor,

Understood! thank you for the clarification.
I'll wait for the dts to be sync'ed with linux after v6.19-rc1 before merging the patchset.

Best regards,
Leo
