Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6CEC4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 07:27:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B04886FB6;
	Thu,  7 Dec 2023 08:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wLi6Ai8H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECC138706F; Thu,  7 Dec 2023 08:27:17 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBD6B8657F
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 08:27:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B77R9iR061092;
 Thu, 7 Dec 2023 01:27:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701934029;
 bh=jGhh3TNF2/tBOQIuWHdXqdE4LkqZfDV57KPI0DK0pn0=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=wLi6Ai8HdYltbYg1x62HY0hI3d4cwaQE02bjIqIlaJi22dfzeFjJyhehfXONMs7/S
 qfjYA5miM2doFumtEOIQeS8+f7Av2IM83ocwShbqhzf+5nIjvmhE5onOlkYGOnb9rG
 j+cIK2GhERMsdUYrG6zl3dCfZqe401Sk9zJ9NXZw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B77R83D110255
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Dec 2023 01:27:08 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Dec 2023 01:27:08 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Dec 2023 01:27:08 -0600
Received: from localhost (uda0497581.dhcp.ti.com [10.24.69.44])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B77R7uN047927;
 Thu, 7 Dec 2023 01:27:07 -0600
Date: Thu, 7 Dec 2023 12:57:06 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, <u-boot@lists.denx.de>, Udit Kumar
 <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>, Thomas Richard
 <thomas.richard@bootlin.com>, Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH v6 4/8] binman: j721e: Add firewall configurations
Message-ID: <20231207072706.ztvn7mczhowklake@uda0497581>
References: <20231206-binman-firewalling-v6-0-e7fce13a6dc1@ti.com>
 <20231206-binman-firewalling-v6-4-e7fce13a6dc1@ti.com>
 <b1a71eef-1464-4b33-8f43-f72f11ed59f7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b1a71eef-1464-4b33-8f43-f72f11ed59f7@ti.com>
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

Hi Andrew,

On 10:23-20231206, Andrew Davis wrote:
> On 12/6/23 3:51 AM, Manorit Chawdhry wrote:
> > The following commits adds the configuration of firewalls required to
> > protect ATF and OP-TEE memory region from non-secure reads and
> > writes using master and slave firewalls present in our K3 SOCs.
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >   arch/arm/dts/k3-j721e-binman.dtsi | 196 ++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 196 insertions(+)
> > 
> > diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
> > index 5ddb474e3a41..f428aa81a6c1 100644
> > --- a/arch/arm/dts/k3-j721e-binman.dtsi
> > +++ b/arch/arm/dts/k3-j721e-binman.dtsi
> > @@ -146,6 +146,202 @@
> >   		fit {
> >   			images {
> > +				atf {
> > +					ti-secure {
> > +						auth-in-place = <0xa02>;
> > +
> > +						firewall-257-0 {
> > +							/* cpu_0_cpu_0_msmc Background Firewall */
> > +							id = <257>;
> > +							region = <0>;
> > +							control = <(FWCTRL_EN | FWCTRL_LOCK |
> > +										FWCTRL_BG | FWCTRL_CACHE)>;
> > +							permissions = <((FWPRIVID_ALL << FWPRIVID_SHIFT) |
> > +											FWPERM_SECURE_PRIV_RWCD |
> > +											FWPERM_SECURE_USER_RWCD |
> > +											FWPERM_NON_SECURE_PRIV_RWCD |
> > +											FWPERM_NON_SECURE_USER_RWCD)>;
> > +							start_address = <0x0 0x0>;
> > +							end_address = <0xff 0xffffffff>;
> > +						};
> > +
> > +						firewall-257-1 {
> > +							/* cpu_0_cpu_0_msmc Foreground Firewall */
> > +							id = <257>;
> > +							region = <1>;
> > +							control = <(FWCTRL_EN | FWCTRL_LOCK |
> > +										FWCTRL_CACHE)>;
> > +							permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
> > +											FWPERM_SECURE_PRIV_RWCD |
> > +											FWPERM_SECURE_USER_RWCD)>;
> > +							start_address = <0x0 0x70000000>;
> 
> 7 levels of indentation, impressive :)

Couldn't figure out a better way..

> 
> This start address should always match CONFIG_K3_ATF_LOAD_ADDR, any way
> you can just use that here?

I am hesitant to use that tbh... slave firewalls are also being
configured and changing the ATF address just directly and thinking
everything can work as is is not the way firewalling is going forward
with, any other better suggestion as to how I can handle that?

> 
> Also this seems like a lot to add for each SoC, and much of it looks similar
> (at least for Jacinto class devices), could be an opportunity for templating.
> 

Just talked to Neha about this, have some insights and will try them for
next revision if they work well. Thanks!

Regards,
Manorit

> Andrew
> 
> > +							end_address = <0x0 0x7001ffff>;
> > +						};
