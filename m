Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440E6C46CD3
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 10:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD5CF87A54;
	Fri, 29 Dec 2023 11:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tVz9t0z/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E8A487ADE; Fri, 29 Dec 2023 11:49:51 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBECC87A01
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 11:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTAnior059879;
 Fri, 29 Dec 2023 04:49:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703846984;
 bh=QXqu+5SeGNu9sUqk4uTla26cIvHHSDG8hem5ztfbEfo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=tVz9t0z/5X+nodPLDqq2wcc8C6OMHiQvexeNlIuR/bu/OCpr9cCGHu8VolZ/eXcgV
 2HHB/KW3j3sfXNmFbS37fz5mlSYt7nBvws3UMMot9bk6RfneMbbr0THCom7P0V16lV
 pus0qec6VZC5N+0qHRDm4J6pc1oC5p26TxP+wGNc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTAniik018208
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 04:49:44 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 04:49:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 04:49:44 -0600
Received: from localhost (uda0497581.dhcp.ti.com [10.24.69.44])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTAnhvR075525;
 Fri, 29 Dec 2023 04:49:44 -0600
Date: Fri, 29 Dec 2023 16:19:43 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, <u-boot@lists.denx.de>, Udit Kumar
 <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>, Thomas Richard
 <thomas.richard@bootlin.com>, Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH v6 8/8] docs: k3: Add secure booting documentation
Message-ID: <20231229104943.t7nsdwkaab7mqvpx@uda0497581>
References: <20231206-binman-firewalling-v6-0-e7fce13a6dc1@ti.com>
 <20231206-binman-firewalling-v6-8-e7fce13a6dc1@ti.com>
 <23ba39ff-87e9-4e19-944f-64939297abd4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <23ba39ff-87e9-4e19-944f-64939297abd4@ti.com>
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

On 10:41-20231206, Andrew Davis wrote:
> On 12/6/23 3:51 AM, Manorit Chawdhry wrote:
> > This commit adds a general flow to explain the usage of firewalls and
> > the chain of trust in K3 devices.
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >   doc/board/ti/k3.rst | 45 +++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 45 insertions(+)
> > 
> > diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> > index 947b86ba8292..60d04c5708be 100644
> > --- a/doc/board/ti/k3.rst
> > +++ b/doc/board/ti/k3.rst
> > @@ -104,6 +104,51 @@ firmware can be loaded on the now free core in the wakeup domain.
> >   For more information on the bootup process of your SoC, consult the
> >   device specific boot flow documentation.
> > +Secure Boot
> > +^^^^^^^^^^^
> > +
> > +K3 HS-SE devices are used for authenticated boot flow with secure boot.
> 
> How about:
> 
> K3 HS-SE devices enforce an authenticated boot flow for secure boot.
> 
> > +HS-FS devices have optional authentication in the flow and doesn't "require"
> > +authentication unless converted to HS-SE devices.
> 
> HS-FS is the state of a K3 device before it has been eFused with
> customer security keys. In the HS-FS state the authentication still
> can function as in HS-SE but as there are no customer keys to verify
> the signatures against the authentication will pass for certificates
> signed with any key.
> 
> > +
> > +Chain of trust
> > +""""""""""""""
> > +
> > +1) SMS starts up and loads the authenticated ROM code in Wakeup Domain
> > +2) ROM code starts up and loads the authenticated tiboot3.bin in Wakeup
> > +   Domain
> > +3) Wakeup SPL (tiboot3.bin) would authenticate the next set of binaries
> > +   (ATF,OP-TEE,DM,SPL,etc.)
> > +4) After ATF and OP-TEE load, ARMV8 U-boot authenticates the next set of
> > +   binaries (Linux and DTBs) if using FIT Image authentication and having a
> > +   signature node in U-boot.
> 
> 
> This might be better said like this:
> 
> 1) Public ROM loads the tiboot3.bin (R5 SPL, TIFS)
> 2) R5 SPL loads tispl.bin (ATF, OP-TEE, DM, SPL)
> 3) SPL loads u-boot.img (U-Boot)
> 4) U-Boot loads fitImage (Linux and DTBs)
> 
> Each stage authenticating (and optionally decrypting) while loading is
> implied by the following sentences below, no need to repeat each time.
> 
> Plus the use of "ROM" is confusing, we have two ROMs in K3 (Secure ROM
> and Public ROM), you should always be specific.
> 
> > +
> > +Steps 1-3 are all authenticated by either the ROM code or TIFS as the
> 
> s/ROM code/Secure ROM
> 
> > +authenticating entity and step 4 uses U-boot standard mechanism for
> > +authenticating.
> > +
> > +All the authentication that are done for ROM/TIFS are done through x509
> > +certificates that are signed.
> > +
> > +Firewalls
> > +"""""""""
> > +
> > +1) ROM comes up and sets up firewalls that are needed by itself
> 
> Secure ROM
> 
> > +2) TIFS (in multicertificate will setup it's own firewalls)
> 
> TIFS sets up it's own firewalls in either case.
> 
> > +3) R5 SPL comes along and opens up other firewalls ( that are not owned by
> > +   anyone - essentially firewalls that were setup by ROM but are not needed
> > +   anymore)
> 
> How about:
> 
> 3) R5 SPL will remove any firewalls that are leftover from the Secure ROM stage
> that are no longer required.
> 
> > +4) Each stage beyond this: such as tispl.bin containing TFA/OPTEE uses OIDs to
> > +   set up firewalls to protect themselves (enforced by TIFS)
> > +5) TFA/OP-TEE can configure other firewalls at runtime if required as they
> > +   are already authenticated and firewalled off from illegal access.
> > +6) A53 SPL and U-boot itself startups but has no ability to change the
> > +   protection firewalls enforced by x509 OIDs or any other firewalls
> > +   configured by ROM/TIFS in the beginning.
> 
> 6) All later stages can setup or remove firewalls that have not been already
> configured by previous stages, such as those created by TIFS, TFA, and OP-TEE.
> 
> > +
> > +Futhur, firewalls have a lockdown bit in hardware that enforces the setting
> > +(and cannot be over-ridden) till the full system is resetted.
> 
> s/till/until
> s/resetted/reset
> 

Have incorporated the suggested changes, Thanks!

Regards,
Manorit

> Andrew
> 
> > +
> >   Software Sources
> >   ----------------
> > 
