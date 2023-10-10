Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFF5CD68EC
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 05:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE8CC864E7;
	Tue, 10 Oct 2023 07:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jXp1uboh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98AD686A02; Tue, 10 Oct 2023 07:00:04 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A97B864D4
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 06:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39A4xsrT065726;
 Mon, 9 Oct 2023 23:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696913994;
 bh=r+Pkl7fHUfdNFpDFyNoAij5riaa8EBjvUuLKasCeQU8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=jXp1ubohmQryegLAPH5WRjNo2MLfOYHE0SrbUgG/V1kB+em5atXI+ZowJD1mYWP0j
 8IFppDsk0r9tosVhZ+8thJ9JEqGGnq904rYrfKL4D9VE7yV+L4dYqVvhLOUyLgKTvg
 uByBwblBr/AYHG0+UwAYmEEW8adpRAb2qFEZKJUM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39A4xsNC100785
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 9 Oct 2023 23:59:54 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Oct 2023 23:59:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Oct 2023 23:59:54 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39A4xrdn021894;
 Mon, 9 Oct 2023 23:59:54 -0500
Date: Tue, 10 Oct 2023 10:29:53 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Simon Glass <sjg@chromium.org>
CC: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>, Udit Kumar
 <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3 1/6] binman: ti-secure: Add support for firewalling
 entities
Message-ID: <20231010045953.6wuwi77ql22plicv@ula0497581>
References: <20231004-binman-firewalling-v3-0-e4a102324e1f@ti.com>
 <20231004-binman-firewalling-v3-1-e4a102324e1f@ti.com>
 <CAPnjgZ0zULhGofQvoThH1i1Ynjg1r1fT1U6reimbysfAxfNo9Q@mail.gmail.com>
 <20231009074348.ghpkwvnc4q52ha55@ula0497581>
 <CAPnjgZ25EEKsjpq63v2Buk=NjCqvF9YQ2+9iGndoxmk9PeB_4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ25EEKsjpq63v2Buk=NjCqvF9YQ2+9iGndoxmk9PeB_4A@mail.gmail.com>
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

On 11:56-20231009, Simon Glass wrote:
> Hi Manorit,
> 
> On Mon, 9 Oct 2023 at 01:43, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
> >
> > Hi Simon,
> >
> > On 17:10-20231007, Simon Glass wrote:
> > > Hi Manorit,
> > >
> > > On Wed, 4 Oct 2023 at 06:32, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
> > > >
> > > > We can now firewall entities while loading them through our secure
> > > > entity TIFS, the required information should be present in the
> > > > certificate that is being parsed by TIFS.
> > > >
> > > > The following commit adds the support to enable the certificates to be
> > > > generated if the firewall configurations are present in the binman
> dtsi
> > > > nodes.
> > > >
> > > > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > > > ---
> > > >  tools/binman/btool/openssl.py   | 16 +++++++-
> > > >  tools/binman/etype/ti_secure.py | 85
> +++++++++++++++++++++++++++++++++++++++++
> > > >  tools/binman/etype/x509_cert.py |  3 +-
> > > >  3 files changed, 101 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/tools/binman/btool/openssl.py
> b/tools/binman/btool/openssl.py
> > > > index aad3b61ae27c..dff439df211f 100644
> > > > --- a/tools/binman/btool/openssl.py
> > > > +++ b/tools/binman/btool/openssl.py
> > > > @@ -82,7 +82,7 @@ imageSize              = INTEGER:{len(indata)}
> > > >          return self.run_cmd(*args)
> > > >
> > > >      def x509_cert_sysfw(self, cert_fname, input_fname, key_fname,
> sw_rev,
> > > > -                  config_fname, req_dist_name_dict):
> > > > +                  config_fname, req_dist_name_dict,
> firewall_cert_data):
> > > >          """Create a certificate to be booted by system firmware
> > > >
> > > >          Args:
> > > > @@ -94,6 +94,13 @@ imageSize              = INTEGER:{len(indata)}
> > > >              req_dist_name_dict (dict): Dictionary containing
> key-value pairs of
> > > >              req_distinguished_name section extensions, must contain
> extensions for
> > > >              C, ST, L, O, OU, CN and emailAddress
> > > > +            firewall_cert_data (dict):
> > > > +              - auth_in_place (int): The Priv ID for copying as the
> > > > +                specific host in firewall protected region
> > > > +              - num_firewalls (int): The number of firewalls in the
> > > > +                extended certificate
> > > > +              - certificate (str): Extended firewall certificate with
> > > > +                the information for the firewall configurations.
> > > >
> > > >          Returns:
> > > >              str: Tool output
> > > > @@ -121,6 +128,7 @@ basicConstraints       = CA:true
> > > >  1.3.6.1.4.1.294.1.3    = ASN1:SEQUENCE:swrv
> > > >  1.3.6.1.4.1.294.1.34   = ASN1:SEQUENCE:sysfw_image_integrity
> > > >  1.3.6.1.4.1.294.1.35   = ASN1:SEQUENCE:sysfw_image_load
> > > > +1.3.6.1.4.1.294.1.37   = ASN1:SEQUENCE:firewall
> > > >
> > > >  [ swrv ]
> > > >  swrv = INTEGER:{sw_rev}
> > > > @@ -132,7 +140,11 @@ imageSize              = INTEGER:{len(indata)}
> > > >
> > > >  [ sysfw_image_load ]
> > > >  destAddr = FORMAT:HEX,OCT:00000000
> > > > -authInPlace = INTEGER:2
> > > > +authInPlace = INTEGER:{hex(firewall_cert_data['auth_in_place'])}
> > > > +
> > > > +[ firewall ]
> > > > +numFirewallRegions = INTEGER:{firewall_cert_data['num_firewalls']}
> > > > +{firewall_cert_data['certificate']}
> > >
> > > Do we want the text above if there is no firewall info?
> > >
> >
> > Yes, keeping numFirewallRegions = INTEGER:0 is valid. The other way would
> be
> > to remove OIDs and everything that we have kept in the certificate when
> > firewall nodes are not present but that seems a bit more difficult given
> > that we have an easy fix keeping the numFirewallRegions as 0.
> 
> OK
> 
> >
> > > >  ''', file=outf)
> > > >          args = ['req', '-new', '-x509', '-key', key_fname, '-nodes',
> > > >                  '-outform', 'DER', '-out', cert_fname, '-config',
> config_fname,
> > > > diff --git a/tools/binman/etype/ti_secure.py
> b/tools/binman/etype/ti_secure.py
> > > > index d939dce57139..a7409023fa55 100644
> > > > --- a/tools/binman/etype/ti_secure.py
> > > > +++ b/tools/binman/etype/ti_secure.py
> > > > @@ -7,9 +7,35 @@
> > > >
> > > >  from binman.entry import EntryArg
> > > >  from binman.etype.x509_cert import Entry_x509_cert
> > > > +from dataclasses import dataclass
> > > >
> > > >  from dtoc import fdt_util
> > > >
> > > > +@dataclass
> > > > +class Firewall():
> > > > +    id: int
> > > > +    region: int
> > > > +    control : int
> > > > +    permissions: list[hex]
> > > > +    start_address: str
> > > > +    end_address: str
> > > > +
> > > > +    def get_certificate(self) -> str:
> > > > +        unique_identifier = f"{self.id}{self.region}"
> > > > +        cert = f"""
> > > > +firewallID{unique_identifier} = INTEGER:{self.id}
> > > > +region{unique_identifier} = INTEGER:{self.region}
> > > > +control{unique_identifier} = INTEGER:{hex(self.control)}
> > > > +nPermissionRegs{unique_identifier} = INTEGER:{len(self.permissions)}
> > > > +"""
> > > > +        for index, permission in enumerate(self.permissions):
> > > > +            cert += f"""permissions{unique_identifier}{index} =
> INTEGER:{hex(permission)}
> > > > +"""
> > > > +        cert += f"""startAddress{unique_identifier} =
> FORMAT:HEX,OCT:{self.start_address:02x}
> > > > +endAddress{unique_identifier} = FORMAT:HEX,OCT:{self.end_address:02x}
> > > > +"""
> > > > +        return cert
> > > > +
> > > >  class Entry_ti_secure(Entry_x509_cert):
> > > >      """Entry containing a TI x509 certificate binary
> > > >
> > > > @@ -17,6 +43,11 @@ class Entry_ti_secure(Entry_x509_cert):
> > > >          - content: List of phandles to entries to sign
> > > >          - keyfile: Filename of file containing key to sign binary
> with
> > > >          - sha: Hash function to be used for signing
> > > > +        - auth_in_place: This is an integer field that contains two
> pieces
> > > > +          of information
> > > > +            Lower Byte - Remains 0x02 as per our use case
> > > > +            ( 0x02: Move the authenticated binary back to the header
> )
> > > > +            Upper Byte - The Host ID of the core owning the firewall
> > > >
> > > >      Output files:
> > > >          - input.<unique_name> - input file passed to openssl
> > > > @@ -25,6 +56,35 @@ class Entry_ti_secure(Entry_x509_cert):
> > > >          - cert.<unique_name> - output file generated by openssl
> (which is
> > > >            used as the entry contents)
> > > >
> > > > +    Depending on auth_in_place information in the inputs, we read the
> > > > +    firewall nodes that describe the configurations of firewall that
> TIFS
> > > > +    will be doing after reading the certificate.
> > > > +
> > > > +    The syntax of the firewall nodes are as such:
> > > > +
> > > > +    firewall-257-0 {
> > > > +        id = <257>;           /* The ID of the firewall being
> configured */
> > > > +        region = <0>;         /* Region number to configure */
> > > > +
> > > > +        control =             /* The control register */
> > > > +            <(FWCTRL_EN | FWCTRL_LOCK | FWCTRL_BG | FWCTRL_CACHE)>;
> > > > +
> > > > +        permissions =         /* The permission registers */
> > > > +            <((FWPRIVID_ALL << FWPRIVID_SHIFT) |
> > > > +                        FWPERM_SECURE_PRIV_RWCD |
> > > > +                        FWPERM_SECURE_USER_RWCD |
> > > > +                        FWPERM_NON_SECURE_PRIV_RWCD |
> > > > +                        FWPERM_NON_SECURE_USER_RWCD)>;
> > > > +
> > > > +        /* More defines can be found in k3-security.h */
> > > > +
> > > > +        start_address =        /* The Start Address of the firewall
> */
> > > > +            <0x0 0x0>;
> > > > +        end_address =          /* The End Address of the firewall */
> > > > +            <0xff 0xffffffff>;
> > > > +    };
> > > > +
> > > > +
> > > >      openssl signs the provided data, using the TI templated config
> file and
> > > >      writes the signature in this entry. This allows verification
> that the
> > > >      data is genuine.
> > > > @@ -32,11 +92,20 @@ class Entry_ti_secure(Entry_x509_cert):
> > > >      def __init__(self, section, etype, node):
> > > >          super().__init__(section, etype, node)
> > > >          self.openssl = None
> > > > +        self.firewall_cert_data: dict = {
> > > > +            'auth_in_place': 0x02,
> > > > +            'num_firewalls': 0,
> > > > +            'certificate': "",
> > > > +        }
> > > >
> > > >      def ReadNode(self):
> > > >          super().ReadNode()
> > > >          self.key_fname = self.GetEntryArgsOrProps([
> > > >              EntryArg('keyfile', str)], required=True)[0]
> > > > +        auth_in_place = fdt_util.GetInt(self._node, "auth_in_place")
> > >
> > > Please use hyphens in properties. If that is a bool, use GetBool()
> >
> > I will use hyphens, the property is supposed to be int. Maybe doesn't
> > convey what it really is by the name but hoping the documentation around
> > it makes it clear.
> 
> No, but you can't use a property name in the DT called 'auth_in_place'
> (please use single quotes BTW). It should have hyphens. Of course the
> Python var will have underscore. but not the property.
> 

I think there has been some miscommunication but I believe we are both
in agreement for the change unless I understood something incorrectly,
would be sending a v4 with the change.

Thanks and Regards,
Manorit

> >
> > >
> > >
> > > > +        if auth_in_place:
> > > > +            self.firewall_cert_data['auth_in_place'] = auth_in_place
> > > > +            self.ReadFirewallNode()
> > > >          self.sha = fdt_util.GetInt(self._node, 'sha', 512)
> > > >          self.req_dist_name = {'C': 'US',
> > > >                  'ST': 'TX',
> > > > @@ -46,6 +115,22 @@ class Entry_ti_secure(Entry_x509_cert):
> > > >                  'CN': 'TI Support',
> > > >                  'emailAddress': 'support@ti.com'}
> > > >
> > > > +    def ReadFirewallNode(self):
> > > > +        self.firewall_cert_data['certificate'] = ""
> > > > +        self.firewall_cert_data['num_firewalls'] = 0
> > > > +        for node in self._node.subnodes:
> > > > +            if 'firewall' in node.name:
> > > > +                firewall = Firewall(
> > > > +                     fdt_util.GetInt(node, 'id'),
> > > > +                     fdt_util.GetInt(node, 'region'),
> > > > +                     fdt_util.GetInt(node, 'control'),
> > > > +                     fdt_util.GetPhandleList(node, 'permissions'),
> > > > +                     fdt_util.GetInt64(node, 'start_address'),
> > > > +                     fdt_util.GetInt64(node, 'end_address'),
> > >
> > > What happens if some of these properties are missing?
> >
> > Should be an error as the firewall would'nt be configurable without
> > these properties. Though am not sure why am not getting an error while
> > passing None to the dataclass, ideally it should..
> >
> > Regards,
> > Manorit
> > >
> > > > +                )
> > > > +                self.firewall_cert_data['num_firewalls'] += 1
> > > > +                self.firewall_cert_data['certificate'] +=
> firewall.get_certificate()
> > > > +
> > > >      def GetCertificate(self, required):
> > > >          """Get the contents of this entry
> > > >
> > > > diff --git a/tools/binman/etype/x509_cert.py
> b/tools/binman/etype/x509_cert.py
> > > > index d028cfe38cd9..9e1cf479023b 100644
> > > > --- a/tools/binman/etype/x509_cert.py
> > > > +++ b/tools/binman/etype/x509_cert.py
> > > > @@ -98,7 +98,8 @@ class Entry_x509_cert(Entry_collection):
> > > >                  key_fname=self.key_fname,
> > > >                  config_fname=config_fname,
> > > >                  sw_rev=self.sw_rev,
> > > > -                req_dist_name_dict=self.req_dist_name)
> > > > +                req_dist_name_dict=self.req_dist_name,
> > > > +                firewall_cert_data=self.firewall_cert_data)
> > > >          elif type == 'rom':
> > > >              stdout = self.openssl.x509_cert_rom(
> > > >                  cert_fname=output_fname,
> > > >
> > > > --
> > > > 2.41.0
> > > >
> > >
> > > Regards,
> > > Simon
> 
> Regards,
> Simon
