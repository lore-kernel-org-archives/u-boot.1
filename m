Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210F9C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 21:33:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 600FA81E72;
	Mon,  2 Jun 2025 23:33:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PyscSGN8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B886381F0D; Mon,  2 Jun 2025 23:33:37 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6755810EB
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 23:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 552LXWaL347544;
 Mon, 2 Jun 2025 16:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748900012;
 bh=Pwb5olNHTfCsB0XZJppnCNrl33dgxKhrZrPHGOan/Hw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=PyscSGN8MppgCOsynaWCIkA5m2aMm0edWGJuo4sNAwpIBVKtQl4jSZWOAelrsKW8i
 KpCeG1InvMeJqiOvTs4hKWCMKOKW8g+ZgfoByDd+WNdow1/wV2SVsEKlKv9UuLSmw+
 7cGSxpwgfngSTEmKFeGCdCNgPRz2moS4aNbKs4RA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 552LXWCs3071567
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 2 Jun 2025 16:33:32 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Jun 2025 16:33:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Jun 2025 16:33:31 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 552LXVJY3637617;
 Mon, 2 Jun 2025 16:33:31 -0500
Date: Mon, 2 Jun 2025 16:33:31 -0500
From: Bryan Brattlof <bb@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>,
 Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH tiU2025.01 2/2] binman: openssl: disable JTAG access by
 default
Message-ID: <20250602213331.6oqvcb5twjtps3rs@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250602-am62xsip-v1-0-ae8aa62b4b6e@ti.com>
 <20250602-am62xsip-v1-2-ae8aa62b4b6e@ti.com>
 <d347cb7e-4b59-4f3e-8dc4-307db7027b63@ti.com>
 <b1214fad-72b9-4055-b368-de2bc05130e5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1214fad-72b9-4055-b368-de2bc05130e5@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On June  2, 2025 thus sayeth Andrew Davis:
> On 6/2/25 12:28 PM, Andrew Davis wrote:
> > On 6/2/25 11:56 AM, Bryan Brattlof wrote:
> > > Typically for boards operating in production environments will not be
> > > monitored and so will not need JTAG access unlocked. Disable the debug
> > > extension unless asked for in the binman configs.
> > > 
> > > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > > ---
> > >   tools/binman/btool/openssl.py       | 16 ++++++++++++----
> > >   tools/binman/etype/ti_secure.py     |  1 +
> > >   tools/binman/etype/ti_secure_rom.py |  1 +
> > >   tools/binman/etype/x509_cert.py     |  7 +++++--
> > >   4 files changed, 19 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
> > > index 2e128e477bce87568b6d9647bbf2666f9770d732..c91d8990a1dc9151bb8fc831c0f1bff2d91b014e 100644
> > > --- a/tools/binman/btool/openssl.py
> > > +++ b/tools/binman/btool/openssl.py
> > > @@ -153,7 +153,7 @@ numFirewallRegions = INTEGER:{firewall_cert_data['num_firewalls']}
> > >       def x509_cert_rom(self, cert_fname, input_fname, key_fname, sw_rev,
> > >                     config_fname, req_dist_name_dict, cert_type, bootcore,
> > > -                  bootcore_opts, load_addr, sha):
> > > +                  bootcore_opts, load_addr, sha, debug):
> > >           """Create a certificate
> > >           Args:
> > > @@ -214,9 +214,13 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
> > >    [ swrv ]
> > >    swrv = INTEGER:{sw_rev}
> > > + # When debugging low level boot firmware it can be useful to have ROM or TIFS
> > > + # unlock JTAG access to the misbehaving CPUs. However in a production setting
> > > + # this can lead to code modification after it's been authenticated by outside
> > > + # parties. To gain JTAG access add the 'debug' flag to the binman configuration
> > 
> > Stating that adding the debug flag gets you JTAG access seems a bit misleading.
> > Having the debugType is a necessary but not sufficient condition for JTAG unlock.
> > 
> 
> I have to walk this back a little, this might only be true for TIFS which processes
> the debug certificates after it takes over the SMS from secure ROM. Secure ROM may
> have a different set of rules. Since this patch is updating both ROM and TIFS
> certificates boot images we should focus on the ROM side.
> 
> > This only sets the upper-bound on what a later supplied JTAG unlock certificate
> > can do, unless coreDbg* is set this should not by itself open JTAG on HS-SE
> > devices. For HS-FS devices I'll have to double check and if it does we should
> > decide if we want this unlocked by default or not.
> > 
> 
> Seems HS-FS devices are default unlocked, and so I'm not sure why we set this to
> unlock for the rest of the device types here in the first place. It only seems
> to be a really big foot-gun for HS-SE users :/
> 
> Let's flip the default,
> 
> Acked-by: Andrew Davis <afd@ti.com>
> 
> Also could you send v2 of this as a stand-alone patch? This change should be
> independent of the encryption extension in patch [1/2].

Yep I'll drop the encryption extension patch until I can poke around 
binman a little more. 

Thanks for double checking all this Andrew
~Bryan
