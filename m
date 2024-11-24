Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C26E668BC
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 19:35:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACA3E895A4;
	Sun, 24 Nov 2024 20:35:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4189388D9B; Sun, 24 Nov 2024 20:29:25 +0100 (CET)
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24D9888CC7
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 20:29:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mjg59@codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
 id 7407D40A0A; Sun, 24 Nov 2024 19:29:22 +0000 (GMT)
Date: Sun, 24 Nov 2024 19:29:22 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Matthew Garrett <mgarrett@aurora.tech>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 01/10] Add EFI handover support to bootm
Message-ID: <Z0N+kmEb9eYr8oBZ@srcf.ucam.org>
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-2-mjg59@srcf.ucam.org>
 <e1592ca0-03aa-4f83-848a-70c8979a9b2a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1592ca0-03aa-4f83-848a-70c8979a9b2a@gmx.de>
X-Mailman-Approved-At: Sun, 24 Nov 2024 20:35:51 +0100
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

On Sun, Nov 24, 2024 at 03:43:12PM +0100, Heinrich Schuchardt wrote:
> > +	/* That failed, so try allocating anywhere there's enough room */
> > +	status = boot->allocate_pages(EFI_ALLOCATE_ANY_PAGES, EFI_LOADER_DATA, pages, &addr);
> > +	if (status == EFI_SUCCESS) {
> > +		/* Make sure bootm knows where we loaded the image */
> > +		os->load = addr;
> > +		return;
> > +	}
> 
> Why don't you simply call LoadImage()?

With secure boot that requires that the kernel image have a trusted 
signature, whereas we're relying on a signed FIT.
