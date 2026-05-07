Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0524CCD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 20:18:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9086384C00;
	Thu,  7 May 2026 22:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="vHWcIM72";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="aGLJeEAU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6029E84BFD; Thu,  7 May 2026 22:18:47 +0200 (CEST)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00B3B84BB7
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 22:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-1q29.prod.antispam.mailspamprotection.com;
 s=arckey; t=1778185125; 
 b=HX5BIv23Y2Rw7+RHOO5r2qeI1lWoztcWMgExhA3GDm9t0Zj3kxE19KDSWjC4t7NRq7yCWichca
 Pp2pmYL++FyJpOlBG3hvz8dvOGDsResUseRnqNCo42kICehTMCDvkrn52sToCgHcqkTqfamzu9
 4r36EqrilffdXtabz6IrqAW/t7SKtFQe5MJXpyjW+MeQo+or4xQbaFNe/VhXX3Ppeq8+URjBM8
 ECt1NN3VuM9Dbfu3Y3OTQHPzjNtPpZGDuog/zCKHDZ1F0SKiN1KDuwUCghLHbChaIwUMf2g5sf
 WtIjn+7Sn5k5IZk8xIhDbHoT44KHtsFP2dP68K5q7z20zg==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-1q29.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-1q29.prod.antispam.mailspamprotection.com;
 s=arckey; t=1778185125; 
 bh=Kw9X7utPTHTcd09pbwGxiM88Y6twkk1GIzV/E9pIRGc=;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
 From:Date:DKIM-Signature:DKIM-Signature;
 b=kPCwT7Zk5zXExV5JRaTgUmQPkQbzkZpIr4tSFVxzWJ2yU9E5nxi6oQFOe9yGV/VOgvkphNKrQF
 KcRaU2Oicq8aDsX+QgbsfdEah1RQdF03fX1nmPDBl1yP8BHXYYwKXdkAWSYfeozkKaYqHGVv0J
 5+1SCJfbE6MRTpEjRmX+OVmVDhnZ19Zt41GDh9gA6jlvXejFk9/mQnWQ0prn+n8DXRryz3ueiA
 THo34H54LaO9J6GKG/WByHCTMCyuUTFbbw+L9wHGBfwQGD60mHedDw7x7pYiuNA3h4ebt043M1
 OscQgC8YLBm594n5hw4i+wpyWbFuVgvWsfpmhAlm5OqXIw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 List-Unsubscribe:Content-Transfer-Encoding;
 bh=hGqH13jmhAYAJGIKI0+Fg7av42eZhlqRSxuvMlQ0MZA=; b=vHWcIM72RJK9f4EBi25L51z4Ru
 HL7PGDT85Ev5AKKoQoCSkDQ2zCYtxQLNVzHVTivd86f6vtEFuEIhWS6NudVUAkngJTYByxIjVZ868
 9EfF5SVR0aN4w4m/DXLCmgS8471YI2JAPSnW8vwFCLc8t1KIaCUSgtueiHELtIVWU4xI=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-1q29.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.1)
 (envelope-from <francesco@valla.it>) id 1wL5BC-00000000hEe-0OpO
 for u-boot@lists.denx.de; Thu, 07 May 2026 20:18:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=hGqH13jmhAYAJGIKI0+Fg7av42eZhlqRSxuvMlQ0MZA=; b=aGLJeEAUU3r/Nhpmy4wbNGtaBM
 Kn+pTEUvdr55siy3VEdiwzXl60uq/ndNVmdhN2lrGZirSooKak0ZsoTTNBrccced/GhW56Ry137mO
 DXcPxhAUqTTJPCJBVM4uyXAFlp2P/4+9zvUpSLQ397n768OKQSUUIVEP66b0EytKMIHQ=;
Received: from [79.26.42.213] (port=61660 helo=bywater)
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <francesco@valla.it>)
 id 1wL5B4-00000000Pem-42nG; Thu, 07 May 2026 20:18:35 +0000
Date: Thu, 7 May 2026 22:18:32 +0200
From: Francesco Valla <francesco@valla.it>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Anshul Dalal <anshuld@ti.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ronald Wahl <ronald.wahl@legrand.com>, 
 Simon Glass <sjg@chromium.org>, Dhruva Gole <d-gole@ti.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Michael Walle <mwalle@kernel.org>, Marek Vasut <marek.vasut@mailbox.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 3/5] boot: fit: enable FIT image post-processing in SPL
Message-ID: <afzzakAEtOauxSEw@bywater>
References: <20260428-spl_fit_full-v1-0-dde63beeaab1@valla.it>
 <20260428-spl_fit_full-v1-3-dde63beeaab1@valla.it>
 <bcef111f-56a8-4935-b234-0e9558cf13e6@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcef111f-56a8-4935-b234-0e9558cf13e6@cherry.de>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 6958e4d2176d7a3d502c719e89fdbc2e
X-AntiAbuse: ID - 6958e4d2176d7a3d502c719e89fdbc2e
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wL5BC-00000000hEe-0OpO-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-1q29.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

Hi Quentin

On Thu, May 07, 2026 at 06:17:34PM +0200, Quentin Schulz wrote:
> Hi Francesco,
> 
> On 4/28/26 10:24 PM, Francesco Valla wrote:
> > Since CONFIG_SPL_FIT_IMAGE_POST_PROCESS is a valid configuration, allow
> > it to be used when using the "full" FIT loading logic in SPL.
> > 
> > Signed-off-by: Francesco Valla <francesco@valla.it>
> > ---
> >   boot/image-fit.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/boot/image-fit.c b/boot/image-fit.c
> > index f3ddee940dbd..347304956a99 100644
> > --- a/boot/image-fit.c
> > +++ b/boot/image-fit.c
> > @@ -2243,7 +2243,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
> >   	}
> >   	/* perform any post-processing on the image data */
> > -	if (!tools_build() && IS_ENABLED(CONFIG_FIT_IMAGE_POST_PROCESS))
> > +	if (!tools_build() && CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS))
> 
> I think this can be reduced to
> 
> if (CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS))
> 
> as tools_build() is true when building for the host (tools), and
> CONFIG_IS_ENABLED prepends CONFIG_TOOLS_ when building for the host (tools)
> and we don't have a TOOLS_FIT_IMAGE_POST_PROCESS.
> 

Thanks, I'll check and add this to the v2.

> Cheers,
> Quentin

Regards,
Francesco

