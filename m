Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028A7E7544B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 11:21:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32AEA86E40;
	Tue,  3 Oct 2023 13:21:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dQ01u8QF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CB7F8701E; Tue,  3 Oct 2023 13:21:13 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ED0986E29
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 13:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 393BL80w051362;
 Tue, 3 Oct 2023 06:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696332068;
 bh=+RrVpCo4NdDOurDh3serSUTR7O6jYobqFZVXuIIisig=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=dQ01u8QFXYeU4Rr71wIVx+d1gbuDasSqrC3ed3lfGaskOLuKsm1eVJeUSxHbdxlSb
 1ZqrPVnpd1Ggy/Ey7SHOqA+erLqOrVDJjoIqa3cxZP8qhEDZRkTxO8YIoBrs/7QgQ+
 lgLPF6M/VYp+p/lKUNfjg6SojIwR1+7grq/IDk1A=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 393BL8De010413
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 3 Oct 2023 06:21:08 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 06:21:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 06:21:08 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 393BL70N014011;
 Tue, 3 Oct 2023 06:21:08 -0500
Date: Tue, 3 Oct 2023 16:51:07 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Simon Glass <sjg@chromium.org>
CC: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, <u-boot@lists.denx.de>,
 Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH v2 2/8] binman: ti-secure: Add support for
 firewalling entities
Message-ID: <20231003112107.qxyzl2uyle2lhspz@ula0497581>
References: <20230926-binman-firewalling-v2-0-b1a084ec634d@ti.com>
 <20230926-binman-firewalling-v2-2-b1a084ec634d@ti.com>
 <CAPnjgZ14Uy+gBC8kgqVA7m9NXN_WiXFffu5Ob=vz=E76rMDMPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ14Uy+gBC8kgqVA7m9NXN_WiXFffu5Ob=vz=E76rMDMPQ@mail.gmail.com>
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

On 19:17-20231001, Simon Glass wrote:
> Hi Manorit,
> 
> On Tue, 26 Sept 2023 at 01:58, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
> >
> > We can now firewall entities while loading them through our secure
> > entity TIFS, the required information should be present in the
> > certificate that is being parsed by TIFS.
> >
> > The following commit adds the support to enable the certificates to be
> > generated if the firewall configurations are present in the binman dtsi
> > nodes.
> >
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >  tools/binman/btool/openssl.py   | 16 +++++++-
> >  tools/binman/etype/ti_secure.py | 85 +++++++++++++++++++++++++++++++++++++++++
> >  tools/binman/etype/x509_cert.py |  3 +-
> >  3 files changed, 101 insertions(+), 3 deletions(-)
> >
> 
> Please do check that you have 100% test coverage here (binman test -T)
> 

Name                                                    Stmts   Miss  Cover
---------------------------------------------------------------------------
[snip]
tools/binman/btool/openssl.py                              42      0   100%
tools/binman/etype/ti_secure.py                            57      0   100%
tools/binman/etype/x509_cert.py                            70      0   100%
[snip]
---------------------------------------------------------------------------
TOTAL                                                    5588    134    98%

I did check that, did you notice something else that I might've missed?
I just checked for the files that I have changed, I am not sure if there
are any dependencies that I also have to keep in mind. Do let me know if
I missed something.

Regards,
Manorit

> Regards,
> Simon
