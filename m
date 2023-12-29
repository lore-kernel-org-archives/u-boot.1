Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AE1C46CD4
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 06:50:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5C5187A54;
	Fri, 29 Dec 2023 07:50:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="diD3qmNq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9C8487A72; Fri, 29 Dec 2023 07:50:03 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAC1287A17
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 07:50:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BT6ntC7035100;
 Fri, 29 Dec 2023 00:49:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703832595;
 bh=lUQNbLW2DMjpiyfOZQEdvPLup5N2hDwxk73+5rqzozg=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=diD3qmNqt4zgtv+aT0TMH6pWpWI1sOf/7TWbhi5jdXrsDuyudZ1GDmMsaRE3Vzwoj
 gB0g79UBibljTo0Aixv6iFcFtGZtXboCaWkn5VKrY4s89HQExWLhMZ0H7V6Ca6EUPr
 zowuXMsGBMgIzUuTLS3A7QYAuxo1OFT9DMD6Bbis=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BT6ntUF024075
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 00:49:55 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 00:49:54 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 00:49:54 -0600
Received: from localhost (uda0497581.dhcp.ti.com [10.24.69.44])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BT6nsex051419;
 Fri, 29 Dec 2023 00:49:54 -0600
Date: Fri, 29 Dec 2023 12:19:53 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Simon Glass <sjg@chromium.org>
CC: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, <u-boot@lists.denx.de>,
 Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH v6 5/8] binman: j721s2: Add firewall configurations
Message-ID: <20231229064953.hapxb32hn3alcey5@uda0497581>
References: <20231206-binman-firewalling-v6-0-e7fce13a6dc1@ti.com>
 <20231206-binman-firewalling-v6-5-e7fce13a6dc1@ti.com>
 <CAFLszTi2tnbHz_5Dsb7Q3H3NrB_KXq4zWL7fbYcOnF81xCv4xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLszTi2tnbHz_5Dsb7Q3H3NrB_KXq4zWL7fbYcOnF81xCv4xA@mail.gmail.com>
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

Hi Simon,

On 09:50-20231226, Simon Glass wrote:
> Hi Manorit,
> 
> On Wed, Dec 6, 2023 at 9:51 AM Manorit Chawdhry <m-chawdhry@ti.com> wrote:
> >
> > The following commits adds the configuration of firewalls required to
> > protect ATF and OP-TEE memory region from non-secure reads and
> > writes using master and slave firewalls present in our K3 SOCs.
> >
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >  arch/arm/dts/k3-j721s2-binman.dtsi | 217 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 217 insertions(+)
> >
> 
> Just a minor point, but could you please reserve the 'binman' tag for
> patches in tools/binman ?

Sure, would do the needful! 

Thanks and regards,
Manorit

> 
> Thanks,
> Simon
