Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FCAC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 09:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4A1288AD3;
	Fri,  2 Aug 2024 11:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722590621;
	bh=7bjx1iESAgDmUad/oygiXkCjWN7S1XUjr8z70wf4UCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l10XJnglSQ4hMCfKoPalJdEmjGvBGrwpFQju+KBDIUoJ03q75+yGgPpacEczXNVgf
	 xhWefG4/uEFHWZ7fLGk+mMWaDMSrGs5SNkkPHiyHxpDafSX5JvacnlIA56NvzV92VO
	 xDFAFNfziJoDkcaM8BF14e6RpKU8NP3IA+k+iJT8a+7HaQ0Pk8AI9fpUUVvOAZs3kF
	 qV0DflCZ3rc4do4Ts28OIAXF62JUAGgeFDn4+CGryHfUtk8Se3e2pXUiATTb4crAyJ
	 nglkd+paKJe999YG2aBvB7+GwKlUd6wki7tvmycdIp0LEItMLnVLf1QoFoEjQVo6h7
	 4mgeW5vmt7U5A==
Received: from eryximachos (unknown
 [IPv6:2001:861:52:5f60:7f4c:42be:fdf8:3b8a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8A3B5881BA;
 Fri,  2 Aug 2024 11:23:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722590619;
 bh=7bjx1iESAgDmUad/oygiXkCjWN7S1XUjr8z70wf4UCc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XYZ83Q8RrLEHUeAhrSK6tMuJGzVmh3NFs5m7b1Q4pf2AZO47+A3DGzlbcpC23vMeZ
 4Dk8k++foCoTLXao5dI7fVc6bRSq1jN3VI8IKasu8z/LUUgDr5C5VfFoTF/8EFnTg3
 GAi9rylJ+mDvGoI+JhVCRbKPsJt2JQmqcgD64RGftRsANWcOt5RiwrK553vv6nzwhb
 PiqTM5qajNFko2sQjpg5nKmkHHTKdgBeYn6QEiLbF8Elm0g5HN1f5o8/h9qIzuahfG
 BzdD+6ieILvJ9lycqJN0TaSi8zZC3ylTCie+fQVGux5VNwK6u6DUxRrCe+o6lb6TIC
 ytLqxOHozxjUg==
Date: Fri, 2 Aug 2024 11:23:37 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, bmeng.cn@gmail.com, caleb.connolly@linaro.org,
 christophe.roullier@foss.st.com, epsi@gmx.de,
 eugen.hristev@collabora.com, festevam@gmail.com,
 forbidden405@outlook.com, ivprusov@salutedevices.com,
 joe.hershberger@ni.com, jonas@kwiboo.se, kever.yang@rock-chips.com,
 leyfoon.tan@starfivetech.com, marek.vasut+renesas@mailbox.org,
 marjolaine.amate@odyssee-systemes.fr, neil.armstrong@linaro.org,
 n-francis@ti.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, philipp.tomsich@vrull.eu,
 rfried.dev@gmail.com, seanga2@gmail.com,
 sebastian.reichel@collabora.com, sebastien.szymanski@armadeus.com,
 sjg@chromium.org, sumit.garg@linaro.org, xypron.glpk@gmx.de, marex@denx.de
Subject: Re: [PATCH v3 0/5] net: dwc_eth_qos: Add glue driver for Intel MAC
Message-ID: <ZqylmfTneSu6h6Cx@eryximachos>
References: <20240717122906.117861-1-pro@denx.de>
 <20240801142017.GA4041738@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801142017.GA4041738@bill-the-cat>
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

On Thu, Aug 01, 2024 at 08:20:17AM -0600, Tom Rini wrote:
> On Wed, Jul 17, 2024 at 02:29:01PM +0200, Philip Oberfichtner wrote:
> 
> > This patch series implements the dwc_eth_qos glue driver for Intel SOCs.
> > Before doing that, a few general adaptions to the dwc_eth_qos.c main
> > driver are required. Most notably, the preparation for PCI based driver
> > instances, which do not necessarily use a device tree.
> > 
> > This patch series depends on: "net: dwc_eth_qos: mdio: Implement clause 45":
> > https://patchwork.ozlabs.org/project/uboot/patch/20240507094237.168238-1-pro@denx.de/
> > 
> > Changes in V3:
> > 	- Replace mfence() with mb()
> > 	- Clean-up eqos_get_base_addr()
> > 	- Several style fixes for dwc_eth_qos_intel
> 
> This adds a failure to build on stm32mp15_dhcor_basic and all of the

Thanks for the feedback!

I added some #if CONFIG_IS_ENABLED(FDT_64BIT) to catch this case. It
should be fine in V4 then.


Best regards,
Philip

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-22  Fax: +49-8142-66989-80   Email: pro@denx.de
=====================================================================
