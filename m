Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A06C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 10:44:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29BB782B37;
	Thu, 15 May 2025 12:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="FmWnVByq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B2E682B39; Thu, 15 May 2025 12:44:05 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F191C82B2F
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 12:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4B2BC148AC25; Thu, 15 May 2025 12:44:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1747305841; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=p0u71t2sqmrOpXcMTEJZbbDD2qeM0DxMYdvQPsqG4dE=;
 b=FmWnVByqr3vySQGMrHen9h11LmG8Z+SmrZ9Nb/LmAjRwtGAyMiZ+vfIy2NMO5qH2sua+GN
 jHDCwNNR0cmFjYBF+lBM3UQ4FnwYth1jJneEXvLnsMsgeI4gyc6AE6emQBMXQXXISBvdc1
 of9vg6euhxuFZEgHkn5CWIOyOw19+X90K2qwK04UI0RZyK4VHxCJvGRVzeGOtwB0l6Pu15
 cI0LXgC49cWDzRPp9LqZvpv6oNI6LKPyIan1iFgWbpNQgfTd/3fv2Zuey+77bey2cyA+8/
 92iN3X9tswbojI98gbvkrVWyTWllUUiOQyea90HTdrWDNEAp6K/7c9GujKMAAg==
Date: Thu, 15 May 2025 12:43:55 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>, Aristo Chen <jj251510319013@gmail.com>,
 u-boot@lists.denx.de, trini@konsulko.com,
 carlos.lopezr4096@gmail.com, aristo.chen@canonical.com
Subject: Re: [PATCH 1/1] tools: mkimage: validate image references in FIT
 configurations
Message-ID: <20250515-contently-headlock-12cc2640f050@thorsis.com>
Mail-Followup-To: Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>,
 Aristo Chen <jj251510319013@gmail.com>, u-boot@lists.denx.de,
 trini@konsulko.com, carlos.lopezr4096@gmail.com,
 aristo.chen@canonical.com
References: <20250505100852.9364-1-aristo.chen@canonical.com>
 <0cb64c56-8f11-4cff-b1a6-a1b6a4194c86@cherry.de>
 <CAFLszTg-4HKF0ZD9h0h2LVSGsSv0adX_=6B84EX6wuGP=oQxzg@mail.gmail.com>
 <c91a8565-7bbc-43c2-8aab-fdb32fbe995f@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c91a8565-7bbc-43c2-8aab-fdb32fbe995f@cherry.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
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

Hei hei,

Am Thu, May 15, 2025 at 09:35:34AM +0200 schrieb Quentin Schulz:
> Hi Simon,
> 
> On 5/14/25 9:44 PM, Simon Glass wrote:
> > Hi,
> > 
> > On Tue, 13 May 2025 at 17:28, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > > 
> > > Hi Aristo,
> > > 
> > > On 5/5/25 12:08 PM, Aristo Chen wrote:
> > > > When parsing a FIT image source (ITS), mkimage does not currently check
> > > > whether the image names referenced in the /configurations section (e.g.
> > > > "kernel", "fdt", "ramdisk", "loadables") actually exist in the /images
> > > > node.
> > > > 
> > > > This patch introduces a validation step during FIT import that iterates
> > > > over each configuration and verifies that all referenced image names are
> > > > defined under /images. If a missing image is detected, an appropriate
> > > > error is reported and mkimage exits with FDT_ERR_NOTFOUND.
> > > > 
> > 
> > One option (for boards which use Binman) would be to put these sorts
> > of checks in there, since it might be easier to code? But having it in
> > mkimage as well seems reasonable to me.
> > 
> 
> mkimage can be used to generate images from outside of U-Boot. I believe
> this is what Yocto does for example to generate kernel FIT (see
> UBOOT_MKIMAGE and others), so having an additional check in mkimage is
> probably a good idea.

Not sure about Yocto, but ptxdist [1] does exactly this: using mkimage
to build signed FIT images, even if U-Boot is not used as bootloader.

(ptxdist also uses mkimage when optionally packing U-Boot scripts.
Those need to be put into an image so U-Boot can execute it.)

Greets
Alex

[1] https://www.ptxdist.org/
