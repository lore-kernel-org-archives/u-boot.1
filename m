Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E952EB8FAF
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 04:45:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45F2486519;
	Wed,  6 Sep 2023 06:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lnc5C2zr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6832486546; Wed,  6 Sep 2023 06:45:00 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EFC6864AA
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 06:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3864is7B111930;
 Tue, 5 Sep 2023 23:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693975494;
 bh=lofFB5hwRLcW2kqvnzrs3UpS/V+VffZmYLNEaThM40Y=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=lnc5C2zrUYvoaDDesJqu+2E55CUVr5fR15pFQVaOREKAuLKiUJe/SJUGXQaErve8E
 3rU/Gp+6RcwF/TuhigKXx2Xgu7Rc+iTjDHrK7OMrJGqhkh+kSJaarEvQ3Li/Mv+rPQ
 83/lWs/Xxr673Kp46Ukcva7XOXJQXybXs7tucVLU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3864isgo025047
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Sep 2023 23:44:54 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Sep 2023 23:44:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Sep 2023 23:44:52 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3864ip51127110;
 Tue, 5 Sep 2023 23:44:52 -0500
Date: Wed, 6 Sep 2023 10:14:50 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>,
 Praneeth Bajjuri <praneeth@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 1/2] binman: ti-secure: Add support for firewalling
 entities
Message-ID: <20230906044450.q67jk573zer23rwj@ula0497581>
References: <20230905-binman-firewalling-v1-0-3894520bff8a@ti.com>
 <20230905-binman-firewalling-v1-1-3894520bff8a@ti.com>
 <19380316-a46a-b281-9e1b-43cd7d10b639@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <19380316-a46a-b281-9e1b-43cd7d10b639@ti.com>
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

Hi Neha,

On 09:16-20230906, Neha Malcom Francis wrote:
> Hi Manorit
> 
> On 05/09/23 13:51, Manorit Chawdhry wrote:
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
> >   tools/binman/btool/openssl.py   | 16 ++++++++++--
> >   tools/binman/etype/ti_secure.py | 54 +++++++++++++++++++++++++++++++++++++++++
> >   tools/binman/etype/x509_cert.py |  3 ++-
> >   3 files changed, 70 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
> > index aad3b61ae27c..dff439df211f 100644
> > --- a/tools/binman/btool/openssl.py
> > +++ b/tools/binman/btool/openssl.py
> > @@ -82,7 +82,7 @@ imageSize              = INTEGER:{len(indata)}
> >           return self.run_cmd(*args)
> >       def x509_cert_sysfw(self, cert_fname, input_fname, key_fname, sw_rev,
> > -                  config_fname, req_dist_name_dict):
> > +                  config_fname, req_dist_name_dict, firewall_cert_data):
> >           """Create a certificate to be booted by system firmware
> >           Args:
> > @@ -94,6 +94,13 @@ imageSize              = INTEGER:{len(indata)}
> >               req_dist_name_dict (dict): Dictionary containing key-value pairs of
> >               req_distinguished_name section extensions, must contain extensions for
> >               C, ST, L, O, OU, CN and emailAddress
> > +            firewall_cert_data (dict):
> > +              - auth_in_place (int): The Priv ID for copying as the
> > +                specific host in firewall protected region
> > +              - num_firewalls (int): The number of firewalls in the
> > +                extended certificate
> > +              - certificate (str): Extended firewall certificate with
> > +                the information for the firewall configurations.
> >           Returns:
> >               str: Tool output
> > @@ -121,6 +128,7 @@ basicConstraints       = CA:true
> >   1.3.6.1.4.1.294.1.3    = ASN1:SEQUENCE:swrv
> >   1.3.6.1.4.1.294.1.34   = ASN1:SEQUENCE:sysfw_image_integrity
> >   1.3.6.1.4.1.294.1.35   = ASN1:SEQUENCE:sysfw_image_load
> > +1.3.6.1.4.1.294.1.37   = ASN1:SEQUENCE:firewall
> >   [ swrv ]
> >   swrv = INTEGER:{sw_rev}
> > @@ -132,7 +140,11 @@ imageSize              = INTEGER:{len(indata)}
> >   [ sysfw_image_load ]
> >   destAddr = FORMAT:HEX,OCT:00000000
> > -authInPlace = INTEGER:2
> > +authInPlace = INTEGER:{hex(firewall_cert_data['auth_in_place'])}
> > +
> > +[ firewall ]
> > +numFirewallRegions = INTEGER:{firewall_cert_data['num_firewalls']}
> > +{firewall_cert_data['certificate']}
> >   ''', file=outf)
> >           args = ['req', '-new', '-x509', '-key', key_fname, '-nodes',
> >                   '-outform', 'DER', '-out', cert_fname, '-config', config_fname,
> > diff --git a/tools/binman/etype/ti_secure.py b/tools/binman/etype/ti_secure.py
> > index d939dce57139..a980d10f4197 100644
> > --- a/tools/binman/etype/ti_secure.py
> > +++ b/tools/binman/etype/ti_secure.py
> > @@ -7,9 +7,39 @@
> >   from binman.entry import EntryArg
> >   from binman.etype.x509_cert import Entry_x509_cert
> > +from dataclasses import dataclass
> >   from dtoc import fdt_util
> > +def hex_octet(n):
> > +  x = '%x' % (n,)
> > +  return ('0' * (len(x) % 2)) + x
> > +
> 
> If this was the only way to grab the address this way, maybe consider adding
> this as a common fdt_util function?
> 

Ah yes, I believe it can come helpful to other people using openssl too
as openssl gets the input in this hex_octet form. Will be moving there
as you mentioned. Thanks for the suggestion!

> > +@dataclass
> > +class Firewall():
> > +    id: int
> > +    region: int
> > +    control : int
> > +    permissions: list[hex]
> > +    start_address: str
> > +    end_address: str
> > +
> > +    def get_certificate(self) -> str:
> > +        unique_indentifier = f"{self.id}{self.region}"
> > +        cert = f"""
> > +firewallID{unique_indentifier} = INTEGER:{self.id}
> > +region{unique_indentifier} = INTEGER:{self.region}
> > +control{unique_indentifier} = INTEGER:{hex(self.control)}
> > +nPermissionRegs{unique_indentifier} = INTEGER:{len(self.permissions)}
> > +"""
> 
> s/indentifier/identifier ?
> 

Ah yes, a typo.

> > +        for index, permission in enumerate(self.permissions):
> > +            cert += f"""permissions{unique_indentifier}{index} = INTEGER:{hex(permission)}
> > +"""
> > +        cert += f"""startAddress{unique_indentifier} = FORMAT:HEX,OCT:{hex_octet(self.start_address)}
> > +endAddress{unique_indentifier} = FORMAT:HEX,OCT:{hex_octet(self.end_address)}
> > +"""
> > +        return cert
> > +
> >   class Entry_ti_secure(Entry_x509_cert):
> >       """Entry containing a TI x509 certificate binary
> > @@ -32,11 +62,20 @@ class Entry_ti_secure(Entry_x509_cert):
> >       def __init__(self, section, etype, node):
> >           super().__init__(section, etype, node)
> >           self.openssl = None
> > +        self.firewall_cert_data: dict = {
> > +            'auth_in_place': 0x02,
> > +            'num_firewalls': 0,
> > +            'certificate': "",
> > +        }
> >       def ReadNode(self):
> >           super().ReadNode()
> >           self.key_fname = self.GetEntryArgsOrProps([
> >               EntryArg('keyfile', str)], required=True)[0]
> > +        auth_in_place = fdt_util.GetInt(self._node, "auth_in_place")
> > +        if auth_in_place:
> > +            self.firewall_cert_data['auth_in_place'] = auth_in_place
> > +            self.ReadFirewallNode()
> >           self.sha = fdt_util.GetInt(self._node, 'sha', 512)
> >           self.req_dist_name = {'C': 'US',
> >                   'ST': 'TX',
> > @@ -46,6 +85,21 @@ class Entry_ti_secure(Entry_x509_cert):
> >                   'CN': 'TI Support',
> >                   'emailAddress': 'support@ti.com'}
> > +    def ReadFirewallNode(self):
> > +        self.firewall_cert_data['certificate'] = ""
> > +        self.firewall_cert_data['num_firewalls'] = 0
> > +        for node in self._node.subnodes:
> > +            firewall = Firewall(
> > +                 fdt_util.GetInt(node, 'id'),
> > +                 fdt_util.GetInt(node, 'region'),
> > +                 fdt_util.GetInt(node, 'control'),
> > +                 fdt_util.GetPhandleList(node, 'permissions'),
> > +                 fdt_util.GetInt64(node, 'start_address'),
> > +                 fdt_util.GetInt64(node, 'end_address'),
> > +            )
> > +            self.firewall_cert_data['num_firewalls'] += 1
> > +            self.firewall_cert_data['certificate'] += firewall.get_certificate()
> > +
> >       def GetCertificate(self, required):
> >           """Get the contents of this entry
> > diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
> > index d028cfe38cd9..9e1cf479023b 100644
> > --- a/tools/binman/etype/x509_cert.py
> > +++ b/tools/binman/etype/x509_cert.py
> > @@ -98,7 +98,8 @@ class Entry_x509_cert(Entry_collection):
> >                   key_fname=self.key_fname,
> >                   config_fname=config_fname,
> >                   sw_rev=self.sw_rev,
> > -                req_dist_name_dict=self.req_dist_name)
> > +                req_dist_name_dict=self.req_dist_name,
> > +                firewall_cert_data=self.firewall_cert_data)
> >           elif type == 'rom':
> >               stdout = self.openssl.x509_cert_rom(
> >                   cert_fname=output_fname,
> > 
> For v1:
> - ti-secure node should contain the documentation of how to use this
> firewall sub-node, basically whatever you've put in x509_cert_sysfw()
> - add test(s) for complete test coverage

Sure, would keep these in mind. Thanks for reviewing!

Regards,
Manorit

> 
> -- 
> Thanking You
> Neha Malcom Francis
