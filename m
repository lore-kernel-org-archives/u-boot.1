Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43B6E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 12:55:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDF0F8022B;
	Thu, 19 Dec 2024 13:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="lDW/AR5I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F52C8021D; Thu, 19 Dec 2024 13:55:56 +0100 (CET)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FE08801F5
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 13:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j.ne@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 19DE6240104
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 13:55:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1734612953; bh=MmbixsXRxAgYlnKExRlYU08V62IEIp46RMkBPiUOGOY=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:From;
 b=lDW/AR5IbgU62MqJQRBBSKbyaopvxapWEm39PWww5+ZGakOd7Ln0by/r9lRyR2GhV
 at8jNvgVabC/C1pUh6cuEZAH8YQhLaWOyOEVrdLsuHh/ZBTU8cf4+hFqU4Ifr6JhIy
 ja89A661BDKw4Tad+cZJZtnfmbRG/PdTPZftyQ8S1LFprnCe9tRygYk+Lw1dU/5Q8m
 pBY2V2pp1Y9mcCLQEn5KkDC2OHtsiaJeBaCrUwpB7WW3J8l46p2gnnlDBh2C4p13Lz
 +1gVh9FWpx5uV3KdO2t1mg+VNSwjrYzD7TyeiCHNynnRYStJE+UbZcS7PsLBnVdtMy
 4arfpdVOwfrRg==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4YDVsN34qfz6twY;
 Thu, 19 Dec 2024 13:55:52 +0100 (CET)
Date: Thu, 19 Dec 2024 12:55:52 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Sinan Akman <sinan@writeme.com>
Cc: j.ne@posteo.net, Mario Six <mario.six@gdsys.cc>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/4] powerpc: mpc83xx: Allow including initreg.h into
 multiple files
Message-ID: <Z2QX2B911TzstWge@probook>
References: <20241215-mpc83xx-misc-v1-0-8cd6daae4f93@posteo.net>
 <20241215-mpc83xx-misc-v1-2-8cd6daae4f93@posteo.net>
 <8941d7ad-84d8-480b-be64-fcc0a3e48dd0@writeme.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8941d7ad-84d8-480b-be64-fcc0a3e48dd0@writeme.com>
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

On Wed, Dec 18, 2024 at 02:18:48PM -0500, Sinan Akman wrote:
> Hi
> 
> On 2024-12-15 10:18, J. Neuschäfer via B4 Relay wrote:
> > From: "J. Neuschäfer"<j.ne@posteo.net>
> > 
> > Globals defined in headers can result in multiple-definition errors
> > while linking, if they are visible beyond the current translation unit.
> 
> Is this happening anywhere ? It seems you introduced this in your other
> patch :
> [PATCH 3/4] powerpc: mpc83xx: Use defined constant for SPCR[TBEN]

Right, I should have mentioned it: The problem appears only due to the
next patch.

> If this is the only place you are seeing the problem, can we not protect
> that the file is not included multiple times ?

The problem here is the inclusion of initreg.h into multiple .c files,
rather than multiple times into the same .c file. I don't think there's
an easy guard pattern against that (the proprocessor won't help here).

I think the benefit of being able to use these constants is big enough
to justify this change.


Thanks for your review,
 -- jn



> 
> > 
> > Signed-off-by: J. Neuschäfer<j.ne@posteo.net>
> > ---
> >   arch/powerpc/cpu/mpc83xx/initreg/initreg.h | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/powerpc/cpu/mpc83xx/initreg/initreg.h b/arch/powerpc/cpu/mpc83xx/initreg/initreg.h
> > index 63aa5c946696ee0368bb3453b40ff0110f0fbcfd..ea1176e7fe10dbb549125ab6b2706fee05a92734 100644
> > --- a/arch/powerpc/cpu/mpc83xx/initreg/initreg.h
> > +++ b/arch/powerpc/cpu/mpc83xx/initreg/initreg.h
> > @@ -13,7 +13,7 @@
> >   #define SPCR_TSECBDP_MASK	0x00000C00
> >   #define SPCR_TSECEP_MASK	0x00000300
> > 
> > -	const __be32 spcr_mask =
> > +	static const __be32 spcr_mask =
[...]
