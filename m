Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F791CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10CD08460E;
	Thu, 18 Jun 2026 17:33:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Guj21P/H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A87D847C3; Thu, 18 Jun 2026 17:33:52 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2FFDE8063E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:33:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5C9548F7;
 Thu, 18 Jun 2026 08:33:44 -0700 (PDT)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.129.30])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F6013F62B;
 Thu, 18 Jun 2026 08:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1781796829; bh=mCrGkwtUm95BDI+7dm9YAZmTZ8SFPByUQMIVZB6ZTa4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Guj21P/HYtB6fSKpeKwQTYk+0v5ROjThv5DaeMc4yX8ycAU2uKni5HhwukIDws9V/
 7kLdreUlXRbQ59wyAGrw2XUq+JXrhQQPTzBsbUgqXetK6Za2xS0yNhJwmtp0tBx16K
 lNbQFN5ytUg4uDy7o6XUDfHWVjFVp7XPdKa454pc=
Date: Thu, 18 Jun 2026 17:33:45 +0200
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] efi_loader: add missing EFI_EXIT in
 efi_disconnect_controller
Message-ID: <ajQP2U30U4F2Fk-k@debian>
Mail-Followup-To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20260618150913.314507-1-vincent.stehle@arm.com>
 <CAFLszTh1p01CC8-1Or7AQhziLkNqzN4NKADJ+hKYSEVjM15t3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLszTh1p01CC8-1Or7AQhziLkNqzN4NKADJ+hKYSEVjM15t3A@mail.gmail.com>
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

On Thu, Jun 18, 2026 at 04:18:59PM +0100, Simon Glass wrote:
> Hi Vincent,
> 
> On Thu, 18 Jun 2026 at 16:09, Vincent Stehlé <vincent.stehle@arm.com> wrote:
> >
> > Make sure to call EFI_EXIT() in efi_disconnect_controller(), when returning
> > after having called EFI_ENTRY().
> >
> > This is inspired by a barebox fix. [1]
> 
> Hmm, does Barebox support EFI_LOADER now?

Hi Simon,

It does now: https://www.mail-archive.com/barebox@lists.infradead.org/msg56391.html

Best regards,
Vincent.

> I wish we could bring these
> projects back together :-)
> 
> >
> > Link: https://git.pengutronix.de/cgit/barebox/commit/?id=080db65e39a877b000baaf843c997a69821dfe69 [1]
> > Fixes: 314bed6c854e ("efi_loader: fix DisconnectController() for sole child")
> > Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > ---
> >  lib/efi_loader/efi_boottime.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> > index de57823bd44..b6966652d97 100644
> > --- a/lib/efi_loader/efi_boottime.c
> > +++ b/lib/efi_loader/efi_boottime.c
> > @@ -3895,7 +3895,7 @@ efi_status_t EFIAPI efi_disconnect_controller(
> >                                       &number_of_children,
> >                                       &child_handle_buffer);
> >         if (r != EFI_SUCCESS)
> > -               return r;
> > +               return EFI_EXIT(r);
> >         sole_child = (number_of_children == 1);
> >
> >         if (child_handle) {
> > --
> > 2.53.0
> >
> 
> Regards,
> Simon

-- 
Vincent.
