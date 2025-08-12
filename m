Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E4AC87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 09:51:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F381832C8;
	Tue, 12 Aug 2025 11:51:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754992316;
	bh=cSnAikQeSfWm1LfnXMIv7TsaznR63i7JtAfbE2grXTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TjV0TVsy0uBCzr13eLt/QFdRiplR1BE5nTKy5sG5aLvomvi9jwTHMMeYjDF2zcEeA
	 hO2yKVgi9aRph9DP4sY7dEqBU/MnUSgVwFkdsRCPHfrwiolHZs67B2wg/O7rc6RQzJ
	 ufeBJ73lg+MtVl1JnXsjBCcKmCcxSdB3jObOtBK8BKQJ0Vw0d4rLTFIReHoH1LNkgF
	 yrQsqtdtoNK1jLtt2yrPdDdurEmKpVK2SVR1a5hmTwgAlgr7zHFuozZYfv5LP1dPkZ
	 4/EHL/+Dr0Lfxix7Y9QWqO7uLPVw5HIElr4arbyOdyJplWbkaYGUVm1ui8YUqy3FE+
	 /btelugFgI7RA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBE6983323; Tue, 12 Aug 2025 11:51:55 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB9218317B
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 11:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="eLnn8jow"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 17A0A1038C11C; 
 Tue, 12 Aug 2025 11:51:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754992312; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=cSnAikQeSfWm1LfnXMIv7TsaznR63i7JtAfbE2grXTE=;
 b=eLnn8jowINODrtifEyzQdKlHPg4FESDuu9Af3aJkWtIndlfmd8sO2XtzwfW3u/3IezUtmg
 HCYLwerYHAWMDGQ9QpKgO8llLg/9mmr3chM2Auy33RJIcLGybf6wHOQ3LPOB7aPtcy4Wcl
 Yzi36N7wQ456lRsrqDGmXON9XprEuvf6VXUbSMoejC9lN6tynlQ7nPEj9z6peHEjxMzJFL
 SYr8Cf4ScXUVnCq+iOprmBAgRgsxGMh7nSK+d/bIMtnjj0TCpCbpvc2zpnnG09NmgzcEu6
 uelKb9hDAUztJmemF/R6noRbCq0pB90INDepk8t1vKUegKr587vFfzfWGyDnPw==
Date: Tue, 12 Aug 2025 11:51:44 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Gary Bisson <bisson.gary@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v2 3/3] Image size checks: Simplify help text
Message-ID: <aJsOsEqa912RQUzg@antares>
References: <20250807102436.452691-1-pro@denx.de>
 <20250807102436.452691-4-pro@denx.de>
 <1d3e5573-7e36-4050-88e8-90d31e5253a9@mailbox.org>
 <aJmwfBL48AzuFra8@antares>
 <63434f64-3633-49a7-91cf-69f52b43c0e7@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63434f64-3633-49a7-91cf-69f52b43c0e7@mailbox.org>
X-Last-TLS-Session-Version: TLSv1.3
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

On Mon, Aug 11, 2025 at 04:25:03PM +0200, Marek Vasut wrote:
> On 8/11/25 10:57 AM, Philip Oberfichtner wrote:
> > On Thu, Aug 07, 2025 at 03:41:57PM +0200, Marek Vasut wrote:
> > > On 8/7/25 12:24 PM, Philip Oberfichtner wrote:
> > > > For coherency, use the same help text for all related size checks
> > > > options. Furthermore, simplify the depends-on logic.
> > > > 
> > > > Signed-off-by: Philip Oberfichtner <pro@denx.de>
> > > > ---
> > > > 
> > > > Notes:
> > > >       Changes in v2: new
> > > > 
> > > >    Kconfig | 8 +++-----
> > > >    1 file changed, 3 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/Kconfig b/Kconfig
> > > > index ec20603883b..490a706101a 100644
> > > > --- a/Kconfig
> > > > +++ b/Kconfig
> > > > @@ -543,10 +543,8 @@ config BOARD_SIZE_LIMIT
> > > >    	default 1048576 if RCAR_64
> > > >    	default 0
> > > >    	help
> > > > -	  Maximum size of the U-Boot image. When defined, the build system
> > > > -	  checks that the actual size does not exceed it.  This does not
> > > > -	  include SPL nor TPL, on platforms that use that functionality, they
> > > > -	  have separate options to restrict size.
> > > > +	  Specifies the maximum length of the U-Boot image.
> > > > +	  If this value is zero, it is ignored.
> > > 
> > > This makes the description less accurate, sorry, NAK.
> > 
> > What about using just the first half:
> > 
> > 	Maximum size of the U-Boot image. When defined, the build system
> > 	checks that the actual size does not exceed it.
> > 	[plus/minus treatment of the value zero]
> > 
> > And dropping the remainder "This does not include ..."?
> Why would removing the SPL/TPL clarification be any improvement ?

This statement used to be sensible, as long as all those size limit
options were spread out over many different Kconfig files. Now having
them all together in on place, I find it rather obvious.

Furthermore, if you want maximum accuracy, you'd have to extend the text
to also include a reference to VPL and u-boot-with-spl config options.
But even then, you still won't be able to fully grasp the functioning of
BOARD_SIZE_LIMIT without consulting the Makefile.

Well, that's what I thought. If you don't agree, I'm also fine to just
leave it as is.
