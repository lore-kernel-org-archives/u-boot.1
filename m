Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD5AE80A81
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 04:38:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86AC586A3A;
	Wed, 27 Sep 2023 06:38:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WvOqL4YU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D0AE86AEA; Wed, 27 Sep 2023 06:38:45 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66ECB8692B
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 06:38:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38R4cdlb067855;
 Tue, 26 Sep 2023 23:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695789519;
 bh=SNmqs1fT8WEp3tZPOuiKqkdflpg7i3avvfPA6vlPuow=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=WvOqL4YU6uYq0xXpgs05GfnqT2nr4AwC5Br9QieQVZO7dFYMMVuO5d6GZ1bK6a3qg
 pPOMSuLXOgVXOReFBYywv4qN3hGhJsFQ6nxNv9V13aowuCV0U5IpnBHk01XRfrARRP
 tOcuMGjbXi91SazZPWGZA2UfykPowHewpB4pNnIE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38R4cdDt014383
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Sep 2023 23:38:39 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 23:38:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 23:38:38 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38R4ccWP026187;
 Tue, 26 Sep 2023 23:38:38 -0500
Date: Wed, 27 Sep 2023 10:08:37 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, <u-boot@lists.denx.de>, Udit Kumar
 <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH v2 0/8] ATF and OP-TEE Firewalling for K3 devices.
Message-ID: <20230927043837.k5tz7nvjdj5dh5v6@ula0497581>
References: <20230926-binman-firewalling-v2-0-b1a084ec634d@ti.com>
 <bf0fb579-9e9d-ddba-8d72-74bc0a702c2f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bf0fb579-9e9d-ddba-8d72-74bc0a702c2f@ti.com>
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

On 09:25-20230926, Andrew Davis wrote:
> On 9/26/23 2:58 AM, Manorit Chawdhry wrote:
> > K3 devices have firewalls that are used to prevent illegal accesses to
> > memory regions that are deemed secure. The series prevents the illegal
> > accesses to ATF and OP-TEE regions that are present in different K3
> > devices.
> > 
> > AM62AX and AM64X are currently in hold due to some firewall
> > configurations that our System Controller (TIFS) needs to handle.
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> 
> You have mixed tabs and spaces in the .dtsi patches.

Thanks for this, would be sending a v3 with the fixes.

Regards,
Manorit

> 
> Andrew
> 
> > Changes in v2:
> > 
> > Andrew:
> >      - Make the firewall DTS more readable with CONSTANTS
> > 
> > Neha:
> >      - Move GetHexOctet to dtoc for common usage
> >      - Update the documentation in ti-secure
> >      - s/indentifier/identifier/
> >      - Add firewall binman test
> > 
> > - Remove slave firewall multiple background regions
> >    ( Single firewall region works fine )
> > - Add a check in the subnodes to check for the node.name 'firewall'
> > - Change firewall indexing with id and region number so that it is easy
> >    to purge out firewalls and we don't need to redo the numbering.
> > - Add information for all the firewalls.
> > - Link to v1: https://lore.kernel.org/u-boot/20230905-binman-firewalling-v1-0-3894520bff8a@ti.com/
> > 
> > ---
> > Manorit Chawdhry (8):
> >        dtoc: openssl: Add GetHexOctet method
> >        binman: ti-secure: Add support for firewalling entities
> >        binman: ftest: Add test for ti-secure firewall node
> >        binman: k3: add k3-security.h and include it in k3-binman.dtsi
> >        binman: j721e: Add firewall configurations for atf
> >        binman: am62x: Add firewalling configurations
> >        binman: j721s2: Add firewall configurations
> >        binman: j7200: Add firewall configurations
> > 
> >   arch/arm/dts/k3-am625-sk-binman.dtsi         |  49 +++++++
> >   arch/arm/dts/k3-binman.dtsi                  |   2 +
> >   arch/arm/dts/k3-j7200-binman.dtsi            | 137 ++++++++++++++++++
> >   arch/arm/dts/k3-j721e-binman.dtsi            | 183 ++++++++++++++++++++++++
> >   arch/arm/dts/k3-j721s2-binman.dtsi           | 206 +++++++++++++++++++++++++++
> >   arch/arm/dts/k3-security.h                   |  58 ++++++++
> >   tools/binman/btool/openssl.py                |  16 ++-
> >   tools/binman/etype/ti_secure.py              |  85 +++++++++++
> >   tools/binman/etype/x509_cert.py              |   3 +-
> >   tools/binman/ftest.py                        |  12 ++
> >   tools/binman/test/311_ti_secure_firewall.dts |  28 ++++
> >   tools/dtoc/fdt_util.py                       |  20 +++
> >   12 files changed, 796 insertions(+), 3 deletions(-)
> > ---
> > base-commit: 2fe4b54556ea6271237b35de68dc458bfceab94c
> > change-id: 20230724-binman-firewalling-65ecdb23ec0a
> > 
> > Best regards,
