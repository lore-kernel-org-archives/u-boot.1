Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3CDC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 12:46:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07A9A87A2A;
	Thu, 14 Dec 2023 13:46:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC82A87A42; Thu, 14 Dec 2023 13:46:30 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7AD287A25
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 13:46:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3BECkJHR032519;
 Thu, 14 Dec 2023 20:46:19 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Thu, 14 Dec 2023 20:46:16 +0800
Date: Thu, 14 Dec 2023 20:46:14 +0800
From: Leo Liang <ycliang@andestech.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Rick Jian-Zhi
 =?utf-8?B?Q2hlbijpmbPlu7rlv5cp?= <rick@andestech.com>
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <ZXr5FhMwRT4gpwsK@swlinux02>
References: <KL1PR03MB6059E8E8F10CAE683A330D1FA58DA@KL1PR03MB6059.apcprd03.prod.outlook.com>
 <20231214121902.GW2513409@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231214121902.GW2513409@bill-the-cat>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3BECkJHR032519
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

Hi Tom,

On Thu, Dec 14, 2023 at 07:19:02AM -0500, Tom Rini wrote:
> On Thu, Dec 14, 2023 at 10:38:07AM +0800, Leo Yu-Chi Liang(梁育齊) wrote:
> 
> > Hi Tom,
> > 
> > The following changes since commit 20d0464300c25db673cfb5e4539aa3767606d151:
> > 
> >   Merge tag 'u-boot-imx-20231212' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2023-12-12 16:33:57 -0500)
> > 
> > are available in the Git repository at:
> > 
> >   https://source.denx.de/u-boot/custodians/u-boot-riscv.git 
> > 
> > for you to fetch changes up to 8c785ddb7ae8d675faf558c81a29938cb0ec2b35:
> > 
> >   riscv: sifive: unmatched: migrate to text environment (2023-12-13 16:19:43 +0800)
> > 
> > CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/18889
> > ----------------------------------------------------------------
> > - VisionFive2: Enable CONFIG_SYSRESET
> > - StarFive: Modify starfive timer driver
> > - AMD/Xilinx: Add MicroBlaze V support
> > - Unmatched: Migrate to text environment
> > ----------------------------------------------------------------
> 
> Are all of these really appropriate for a release less than a month away
> or should I take this to -next? Thanks.

Ah! You're right!
I think merging to -next seems to be more appropriate!
Thanks for the reminder!

Best regards,
Leo

> -- 
> Tom


