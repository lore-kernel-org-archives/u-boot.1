Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF08E75449
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 10:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B125486CBA;
	Tue,  3 Oct 2023 12:41:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Uxa0RzaY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2780F86D7B; Tue,  3 Oct 2023 12:41:35 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70FE286B73
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 12:41:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 393AfTSf055876;
 Tue, 3 Oct 2023 05:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696329689;
 bh=VppPPmKrCOEYje/e8AWso04Vf2d11a/fLRZ2g6Xuezk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Uxa0RzaY47TLim25ca0SIYSUF8jFKiwEa4LgRg/1hOAoTopfsdAx3YsURY3fUZcZl
 0Mj/mgkpCnmyk4rfOrYrbGmEOVvP4hu4ecqWz1GeQkSadO20mj/CFXTq1Rn2OUH7QF
 MDhcxEDy6SqQv6b0/2gbjf1guVi0kVFvjAdsLlMw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 393AfTkK085768
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 3 Oct 2023 05:41:29 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 05:41:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 05:41:29 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 393AfS2r112292;
 Tue, 3 Oct 2023 05:41:29 -0500
Date: Tue, 3 Oct 2023 16:11:28 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Simon Glass <sjg@chromium.org>
CC: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, <u-boot@lists.denx.de>,
 Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH v2 1/8] dtoc: openssl: Add GetHexOctet method
Message-ID: <20231003104128.nspj2soy7a5wez64@ula0497581>
References: <20230926-binman-firewalling-v2-0-b1a084ec634d@ti.com>
 <20230926-binman-firewalling-v2-1-b1a084ec634d@ti.com>
 <CAPnjgZ3nbg+NQU4CnMUQdwrwRru2AKXwGWNpgXO2cQfaEoP04g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3nbg+NQU4CnMUQdwrwRru2AKXwGWNpgXO2cQfaEoP04g@mail.gmail.com>
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
> > HexOctet format is used by openssl for FORMAT:HEX,OCT property in x509
> > certificates. Add a helper function to extract the integer numbers in
> > HEX,OCT format to pass to openssl directly.
> >
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >  tools/dtoc/fdt_util.py | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/tools/dtoc/fdt_util.py b/tools/dtoc/fdt_util.py
> > index f1f70568cfef..d51dbf5633d0 100644
> > --- a/tools/dtoc/fdt_util.py
> > +++ b/tools/dtoc/fdt_util.py
> > @@ -100,6 +100,26 @@ def EnsureCompiled(fname, tmpdir=None, capture_stderr=False):
> >      command.run(dtc, *args, capture_stderr=capture_stderr)
> >      return dtb_output
> >
> > +def GetHexOctet(node, propname, default=None):
> 
> What is a hex octet?
> 

It is actually a Hex number in Octet form, basically using 0x0a instead
of 0xa type of thing. 

OpenSSL has complained when we use FORMAT:HEX,OCT:0 type of string
instead of FORMAT:HEX,OCT:00. Tbvh I still haven't been able to find a
clear documentation for this but this is what I have been able to figure
out based on my tests.

> > +    """Get an integer from a property in hex octet form required by openssl
> > +
> 
> You should mention what size property is permitted.
> 
> > +    Args:
> > +        node: Node object to read from
> > +        propname: property name to read
> > +        default: Default value to use if the node/property do not exist
> > +
> > +    Returns:
> > +        Integer value read as a String in Hex Octet Form
> > +    """
> > +    prop = node.props.get(propname)
> > +    if not isinstance(prop.value, list) or len(prop.value) != 2:
> > +        value = GetInt(node, propname)
> > +    elif isinstance(prop.value, list) and len(prop.value) == 2:
> > +        value = GetInt64(node, propname)
> 
> What if it is neither of those?
> 
> > +
> > +    hex_value = '%x' % (value)
> > +    return ('0' * (len(hex_value) & 1)) + hex_value
> 
> Can you do:
> 
> return f'{value:02x}'
> 

With the following suggestion I don't think I need the patch at all
anymore given that no one else seems to be requiring this HEX,OCT just
yet and am still in the process of finding a clear documentation for it.

Will be dropping that patch after testing if not required to be generic.
Thanks!

Regards,
Manorit

> ?
> 
> 
> > +
> >  def GetInt(node, propname, default=None):
> >      """Get an integer from a property
> >
> >
> > --
> > 2.41.0
> >
