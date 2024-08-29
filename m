Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EF8C87FCD
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 18:10:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80662886CC;
	Thu, 29 Aug 2024 20:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OAVqUIF/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC04A88BEF; Thu, 29 Aug 2024 20:10:09 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E08688481
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 20:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47TIA5f0119017;
 Thu, 29 Aug 2024 13:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1724955005;
 bh=V+wUPnSiwYMJF6hsdWC+asFEqOM6vNtl6bEBAK5LI0I=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=OAVqUIF/B7x+yw3e/Pac/3Zi0j96BOTCo4qqbp0PZEWFgKFKxL8t04AkvIb7LwUBS
 jpggV3ZBJbEQEsWTDAWPmm3OXPOvWzXYTlGD82jaAZtmZXY0eHRQrBdvoT8LeByNLR
 gG/r5Irbm1mFpgBuz+0L/ZgNoR+h89GoXW01OkiQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47TIA52w075094
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 29 Aug 2024 13:10:05 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Aug 2024 13:10:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Aug 2024 13:10:04 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47TIA48Q070737;
 Thu, 29 Aug 2024 13:10:04 -0500
Date: Thu, 29 Aug 2024 13:10:04 -0500
From: Nishanth Menon <nm@ti.com>
To: "Limaye, Aniket" <a-limaye@ti.com>
CC: Tom Rini <trini@konsulko.com>, "Kumar, Udit" <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>, <n-francis@ti.com>, <m-chawdhry@ti.com>
Subject: Re: [EXTERNAL] Re: [PATCH 1/6] arm: dts: k3-j7200-r5: Add the pmic
 node in R5 dt
Message-ID: <20240829181004.kux7akxy5hn5tmek@lucid>
References: <20240531130823.646311-1-a-limaye@ti.com>
 <20240531130823.646311-2-a-limaye@ti.com>
 <ace9596b-4fa6-4eb6-9ef8-35a545a2a022@ti.com>
 <30131b07-9368-46b7-b526-55c3af0a9c28@ti.com>
 <20240614145503.GQ68077@bill-the-cat>
 <0963146f-c050-4a37-b0ea-bc6f62663832@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0963146f-c050-4a37-b0ea-bc6f62663832@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 14:02-20240829, Limaye, Aniket wrote:
> 
> 
> On 6/14/2024 8:25 PM, Tom Rini wrote:
> > On Fri, May 31, 2024 at 10:24:30PM +0530, Limaye, Aniket wrote:
> > > 
> > > 
> > > On 5/31/2024 7:25 PM, Kumar, Udit wrote:
> > > > 
> > > > On 5/31/2024 6:38 PM, Aniket Limaye wrote:
> > > > > Add bootph-pre-ram property to the buck node in the pmic needed for
> > > > > ESM error event handling.
> > > > > 
> > > > > Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> > > > > ---
> > > > >    arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 9 +++++++++
> > > > >    1 file changed, 9 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > > > > b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > > > > index fb7e2e50239..78d07ff4e70 100644
> > > > > --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > > > > +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > > > > @@ -96,3 +96,12 @@
> > > > >    &mcu_udmap {
> > > > >        ti,sci = <&dm_tifs>;
> > > > >    };
> > > > > +
> > > > > +&tps659414 {
> > > > > +    regulators {
> > > > > +        bucka1: buck1 {
> > > > > +            bootph-pre-ram;
> > > > > +        };
> > > > 
> > > > 
> > > > why not to add this in kernel DT
> > > 
> > > Manorit has already posted a series to kernel to add bootph- properties
> > > across platforms... Specifically the patch here [0] addresses this.
> > > 
> > > Once that is merged, and goes through the rebasing tree in u-boot we will
> > > need to send patches to remove the bootph properties from the -u-boot and
> > > -r5 files. Until then we need this patch for the ESM to work. Else we can
> > > wait till the kernel dt patches make it through to u-boot for me to roll out
> > > a v2.
> > 
> > Yes, we'll wait until we can get this all in via OF_UPSTREAM.
> > 
> 
> Tom, Udit,
> 
> The patch in Kernel DT here [0] seems to be taking longer to go through.
> In the meantime, does it make sense for me to send this current series in
> u-boot with the bootph patch above, to unblock ESM support for j7200-evm?

NAK! This is why there is a review process in upstream. Lack of ESM
survived in j7200 for years now - there is no urgency to carry that
stuff and then have someone to start tracking and cleaning up behind.
Please DO NOT. The only exception we have permitted now is for you to
add patches in dts/ which *have* been upstreamed and accepted by
maintainers but it is a couple of months away for OF_UPSTREAM to sync
(aka for the next rebase, those changes will be dropped).

This policy has been asserted over and over again on these platforms.
Please focus instead on helping getting kernel changes upstream by
helping support engineers in that effort.

> 
> When the Kernel DT patch is merged and taken through OF_UPSTREAM, I will
> anyway send a patch to remove all of the bootph from the u-boot DT files.
> With that, I can take care of removing the above bootph property too.
> 
> Let me know what you think, and I'll rebase this series and resend it then.
> 
> [0]: https://lore.kernel.org/all/20240814-b4-upstream-bootph-all-v4-0-f2b462000f25@ti.com/
> 
> Thanks,
> Aniket


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
