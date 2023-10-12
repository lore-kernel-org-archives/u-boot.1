Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE4ECDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 05:46:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A254B86DC7;
	Thu, 12 Oct 2023 07:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AqIoPujq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 260F286D3D; Thu, 12 Oct 2023 07:46:22 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6BF086DC7
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 07:46:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39C5k1co101333;
 Thu, 12 Oct 2023 00:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697089561;
 bh=ahp+NzXTYH0kfNrp7Sj+kTAkA+vYijcBgaGcJvTdjPw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=AqIoPujqCRU3uRg0Av5FgJDRjsI3F9yWTJKuippGboXFy22AE0NN0JY+6u4v3erqZ
 Ji4N40wyTNw0nCx8Uvz3RjxfghPE77YIKnjVVWUHxOJOcb1BnKX41T21EURd9bnGze
 QeH7cy0gkIUxe21hp8GRvVOKobdzn7GiCB1N/2Cc=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39C5k1Mh032104
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 12 Oct 2023 00:46:01 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Oct 2023 00:46:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Oct 2023 00:46:01 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39C5k0G6114446;
 Thu, 12 Oct 2023 00:46:01 -0500
Date: Thu, 12 Oct 2023 11:16:00 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Simon Glass <sjg@chromium.org>
CC: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, <u-boot@lists.denx.de>,
 Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v4 1/8] binman: ti-secure: Add support for firewalling
 entities
Message-ID: <20231012054600.d26hx63xaedl3dsk@ula0497581>
References: <20231011-binman-firewalling-v4-0-a08085d300e9@ti.com>
 <20231011-binman-firewalling-v4-1-a08085d300e9@ti.com>
 <CAPnjgZ3NG+8-VLi5i7+h4t1aP_qa1Va1ZJdhiJzfVyd7jrHPmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3NG+8-VLi5i7+h4t1aP_qa1Va1ZJdhiJzfVyd7jrHPmA@mail.gmail.com>
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

On 20:41-20231011, Simon Glass wrote:
> Hi Manorit,
> 
> On Tue, 10 Oct 2023 at 23:25, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
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
> >  tools/binman/etype/ti_secure.py | 90 +++++++++++++++++++++++++++++++++++++++++
> >  tools/binman/etype/x509_cert.py |  3 +-
> >  3 files changed, 106 insertions(+), 3 deletions(-)
> >
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> I'm still a little worried about the error reporting if the user
> leaves out a property. Does it do the right thing?
> 

I did make a test also along the lines that would check all the
firewalling properties and just auth-in-place isn't checked at this
stage and people could end up adding the firewalling node without
auth-in-place. Do you want to cover that test case as well? Regarding
the other firewalling properties ( immitating the test by removing
"id"), We get this: 

[..]
  AR      spl/common/spl/built-in.o
  LD      spl/u-boot-spl
  OBJCOPY spl/u-boot-spl-nodtb.bin
  SYM     spl/u-boot-spl.sym
  CAT     spl/u-boot-spl-dtb.bin
  COPY    spl/u-boot-spl.bin
  BINMAN  .binman_stamp
binman: id can't be None in firewall node

> Regards,
> Simon
