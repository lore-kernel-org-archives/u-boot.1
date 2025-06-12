Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72231C71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 11:15:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA04182B7C;
	Thu, 12 Jun 2025 13:15:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WQtIgmNB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE3A082B97; Thu, 12 Jun 2025 13:15:39 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C0EE828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 13:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55CBFY3a2904214;
 Thu, 12 Jun 2025 06:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749726934;
 bh=B0HoVUmUgKQssbhSREy4iDpXRgEdErYFsTwwurTGx3M=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=WQtIgmNB71R/LAwxNj63iZwF725kY+Pas7Zmf+NdA2uFcsuBd2JuoXcEEXHb9dBin
 /j1JfVs2hLTSw5whFWjKyr6u6bxQpQoeTs6+X7GMrAXs6xmwtrN0e2kSAJv75LTTlM
 hxXr7AbWvFI4wRsd5z42d8IxsxLT/WapphNNmiZ4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55CBFYsC1892476
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 12 Jun 2025 06:15:34 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 12
 Jun 2025 06:15:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 12 Jun 2025 06:15:34 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55CBFYj42072795;
 Thu, 12 Jun 2025 06:15:34 -0500
Date: Thu, 12 Jun 2025 06:15:34 -0500
From: Bryan Brattlof <bb@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>,
 Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH -next 3/5] binman: add sysfw-inner-cert to
 missing-blob-help
Message-ID: <20250612111534.4xwqhv6rzeeuzou3@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250611-missing-blob-help-entries-v1-0-c6de1844117f@ti.com>
 <20250611-missing-blob-help-entries-v1-3-c6de1844117f@ti.com>
 <DAKAF5YRCY2T.39SSJYUIINTK7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <DAKAF5YRCY2T.39SSJYUIINTK7@ti.com>
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

On June 12, 2025 thus sayeth Anshul Dalal:
> On Wed Jun 11, 2025 at 11:47 PM IST, Bryan Brattlof wrote:
> > Now that the inner certificate for TI' Foundation Security TIFS firmware
> > is mandatory to a successful build, provide some guidance on what it is
> > and links to the documentation on how to obtain the firmware blobs.
> >
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > ---
> >  tools/binman/missing-blob-help | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/tools/binman/missing-blob-help b/tools/binman/missing-blob-help
> > index e28eaa2015443f256a469df4ead87793e23ba219..fcc989ed757e0d0a8d5bc8238c3d013da98aa390 100644
> > --- a/tools/binman/missing-blob-help
> > +++ b/tools/binman/missing-blob-help
> > @@ -60,3 +60,13 @@ Have a look at your board's documentation to find the latest version of
> >  the DM firmware binary and how to include it in the build.
> >  
> >      https://docs.u-boot.org/en/latest/board/ti/k3.html
> > +
> > +sysfw-inner-cert:
> > +You are missing the inner certificate for TI's Foundational Security (TIFS)
> > +firmware which is critical to authenticating the TIFS firmware during boot.
> > +HS-FS and HS-SE parts will not boot without this certificate.
> > +
> > +Have a look at your board's documentation to find and include the latest
> > +TIFS certificate blobs and how to include them in the build.
> > +
> > +    https://docs.u-boot.org/en/latest/board/ti/k3.html
> 
> Nit: With the entries ordered alphabetically in the 1st patch, the entry
> `sysfw-inner-cert` should go after `scp-sunxi` instead.
> 

Oops you're right. Thanks for the review

~Bryan
