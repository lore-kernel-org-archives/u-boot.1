Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A25C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 09:40:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 749168715B;
	Tue,  7 Nov 2023 10:40:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="V7IC4K51";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BBB487166; Tue,  7 Nov 2023 10:40:11 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75C8E86DED
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 10:40:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A79e5hr096004;
 Tue, 7 Nov 2023 03:40:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699350005;
 bh=TF45xoCfjKCy+5DapNLFt7SXmXbEgGwHpanhhVxKslo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=V7IC4K51YgCOhuIzKlLp6D/m1I4BLs5S6/oxeO7Gvs77323iBkQzMGH7cu840DgKz
 urXDpGyocXn11u97W4U9gcMIcvLzzjE5tfNSMNU652v03918fud8Mr0gplIomYotJZ
 XDEPsByUJ5sTHaZDYA1pts3eOe1r61lhZZOLL30g=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A79e4QQ083227
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 7 Nov 2023 03:40:05 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 Nov 2023 03:40:04 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 Nov 2023 03:40:04 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A79e3a2075392;
 Tue, 7 Nov 2023 03:40:04 -0600
Date: Tue, 7 Nov 2023 15:10:03 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Simon Glass <sjg@chromium.org>
CC: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, <u-boot@lists.denx.de>,
 Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v4 1/8] binman: ti-secure: Add support for firewalling
 entities
Message-ID: <20231107094003.isopuizzblaaayp2@ula0497581>
References: <20231011-binman-firewalling-v4-0-a08085d300e9@ti.com>
 <20231011-binman-firewalling-v4-1-a08085d300e9@ti.com>
 <CAPnjgZ3NG+8-VLi5i7+h4t1aP_qa1Va1ZJdhiJzfVyd7jrHPmA@mail.gmail.com>
 <20231012054600.d26hx63xaedl3dsk@ula0497581>
 <CAPnjgZ0uw0AJC55F6hkrMZmwXt=VdKr21ngw_CSP-m_zzgJfmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0uw0AJC55F6hkrMZmwXt=VdKr21ngw_CSP-m_zzgJfmg@mail.gmail.com>
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

On 08:29-20231012, Simon Glass wrote:
> Hi Manorit,
> 
> On Wed, 11 Oct 2023 at 22:46, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
> >
> > Hi Simon,
> >
> > On 20:41-20231011, Simon Glass wrote:
> > > Hi Manorit,
> > >
> > > On Tue, 10 Oct 2023 at 23:25, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
> > > >
> > > > We can now firewall entities while loading them through our secure
> > > > entity TIFS, the required information should be present in the
> > > > certificate that is being parsed by TIFS.
> > > >
> > > > The following commit adds the support to enable the certificates to be
> > > > generated if the firewall configurations are present in the binman dtsi
> > > > nodes.
> > > >
> > > > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > > > ---
> > > >  tools/binman/btool/openssl.py   | 16 +++++++-
> > > >  tools/binman/etype/ti_secure.py | 90 +++++++++++++++++++++++++++++++++++++++++
> > > >  tools/binman/etype/x509_cert.py |  3 +-
> > > >  3 files changed, 106 insertions(+), 3 deletions(-)
> > > >
> > >
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > >
> > > I'm still a little worried about the error reporting if the user
> > > leaves out a property. Does it do the right thing?
> > >
> >
> > I did make a test also along the lines that would check all the
> > firewalling properties and just auth-in-place isn't checked at this
> > stage and people could end up adding the firewalling node without
> > auth-in-place. Do you want to cover that test case as well? Regarding
> > the other firewalling properties ( immitating the test by removing
> > "id"), We get this:
> >
> > [..]
> >   AR      spl/common/spl/built-in.o
> >   LD      spl/u-boot-spl
> >   OBJCOPY spl/u-boot-spl-nodtb.bin
> >   SYM     spl/u-boot-spl.sym
> >   CAT     spl/u-boot-spl-dtb.bin
> >   COPY    spl/u-boot-spl.bin
> >   BINMAN  .binman_stamp
> > binman: id can't be None in firewall node
> 
> That's a bit vague...at least it should show the full path to the node
> that failure, e.g. use self.Raise(). Also, I assume the property is
> missing and the None refers to the Python value for the var. Better to
> provide a nice error.

I was working on this so I realised that Firewall class that I have is
not an etype so I have hacked a bit around to get that self.Raise in but
hoping that shouldn't be much of a problem..

Does this error look okay now?

[..]
  COPY    spl/u-boot-spl.bin
  BINMAN  .binman_stamp
binman: Node '/binman/ti-spl/fit/images/atf/ti-secure': Subnode 'firewall' is missing properties: id,region

> 
> Any possible user error should ideally be checked, to avoid later confusion.
> 
> See Entry.ensure_props()

I was thinking of using this as well but I noticed that this gets called
in the beginning itself and since the Firewall class that I have is not
an etype then I won't be getting the information that all this is
failing in firewalling related node and might be confused with debugging
in ti-secure hence thought of updating the dataclass only with the
function only as you suggested below. Thanks for the suggestions!

Regards,
Manorit

> 
> You could add an optional argument - the list of props to check. If
> present it could use that instead of self.required_props
> 
> Hmm better might be to have a new function which tells the user that
> since the firewall property is present, it needs these others ones
> too.
> 
> Regards,
> Simon
