Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A733BCDB471
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 08:43:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA30784832;
	Mon, 22 Jun 2026 10:43:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="nI9ePjSE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7644E848DC; Mon, 22 Jun 2026 10:43:39 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A67CA800AE
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 10:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1493D1BA8;
 Mon, 22 Jun 2026 01:43:30 -0700 (PDT)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.125.35])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3DB13F632;
 Mon, 22 Jun 2026 01:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782117814; bh=08bz7g6VnjiLIP/7/FXYo49GCKWpAEPeuM3+i3H6Kuk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nI9ePjSEGheFDJlhtaEVizzyjNMj/nxpkM4gAnIQKN8QKD9VeAmCSGrTDsOZT+M+Z
 4Qid/lo0WJIniyZ4Jk5N2QURPnJpHMtoGllC9KXbV6B7S3NHi8YA0a+XNSrMqTovDv
 pbtQr92ksCFs4zvemPVSD0Ci3EcMEJUlxgTjMcUQ=
Date: Mon, 22 Jun 2026 10:43:31 +0200
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] efi_loader: fix missing EFI_EXIT in
 efi_disconnect_controller
Message-ID: <ajj1s_tAXNtVO_GM@debian>
Mail-Followup-To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
References: <20260618150913.314507-1-vincent.stehle@arm.com>
 <20260618160930.345040-1-vincent.stehle@arm.com>
 <CAC_iWjL+A5qcrJPEiR-f3__P_3z5DQApJWVANS+DNUga-vB2Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_iWjL+A5qcrJPEiR-f3__P_3z5DQApJWVANS+DNUga-vB2Fw@mail.gmail.com>
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

On Fri, Jun 19, 2026 at 11:22:22AM +0300, Ilias Apalodimas wrote:
> Thanks Vincent, 
> On Thu, 18 Jun 2026 at 19:09, Vincent Stehlé <[1]vincent.stehle@arm.com> wrote:
> 
> > We are missing a call to EFI_EXIT() when returning from
> > efi_disconnect_controller(), which we need after having called EFI_ENTRY().
> 
> > Fix this by jumping to the common error path, which does call EFI_EXIT().
> 
> > Even though the common error path may try to free child_handle_buffer, this
> > cannot harm in our case as it always NULL.
> 
> > This is inspired by a barebox fix. [1]
> 
> There's more in that link and some of them are still valid. Do you plan to send
> more?

Hi Ilias,

I am trying to, but... I have looked at the barebox fixes and I think they
necessitate a triaging and verification effort.

- Some fixes are not applicable to U-Boot (e.g. [1]).
- Some fixes look applicable to U-Boot but in fact are not (I tried to reproduce
  [2] on U-Boot with a unit test for example, but I could not make the test
  fail).
- Some fixes look applicable but I would like to verify completeness (I am
  looking at [3] for example).
- And last but not least, some fixes are difficult for me to review.

This makes me think that we should try to create a "reproducer" in
lib/efi_selftest/ systematically for each fix to the EFI Loader.

Best regards,
Vincent.

[1] https://git.pengutronix.de/cgit/barebox/commit/efi/loader?id=f34f05ff87cf3a0a9f7345227f9a080ddcf3ec48
[2] https://git.pengutronix.de/cgit/barebox/commit/efi/loader?id=cbe4bd04edec9c1d3c843fcc22e1a7ae5c9c4551
[3] https://git.pengutronix.de/cgit/barebox/commit/efi/loader?id=4e9944e5cd1170cb5c54f97f4e12ddeccba53e55

> 
> > Link:
> > [2]https://git.pengutronix.de/cgit/barebox/commit/?id=080db65e39a877b000baaf843c997a69821dfe69
> > [1]
> > Fixes: 314bed6c854e ("efi_loader: fix DisconnectController() for sole child")
> > Signed-off-by: Vincent Stehlé <[3]vincent.stehle@arm.com>
> > Cc: Heinrich Schuchardt <[4]xypron.glpk@gmx.de>
> > Cc: Ilias Apalodimas <[5]ilias.apalodimas@linaro.org>
> > Cc: Tom Rini <[6]trini@konsulko.com>
> > ---
> 
> Reviewed-by: Ilias Apalodimas <[7]ilias.apalodimas@linaro.org>
>  
> 
> > Changes for v2:
> > - Drop the return and jump to the common error path with a goto instead
> 
> >  lib/efi_loader/efi_boottime.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> > diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> > index de57823bd44..bcb01c92cf4 100644
> > --- a/lib/efi_loader/efi_boottime.c
> > +++ b/lib/efi_loader/efi_boottime.c
> > @@ -3895,7 +3895,7 @@ efi_status_t EFIAPI efi_disconnect_controller(
> >                                       &number_of_children,
> >                                       &child_handle_buffer);
> >         if (r != EFI_SUCCESS)
> > -               return r;
> > +               goto out;
> >         sole_child = (number_of_children == 1);
> 
> >         if (child_handle) {
> > --
> > 2.53.0
> 
> References
> 
>    Visible links
>    1. mailto:vincent.stehle@arm.com
>    2. https://git.pengutronix.de/cgit/barebox/commit/?id=080db65e39a877b000baaf843c997a69821dfe69
>    3. mailto:vincent.stehle@arm.com
>    4. mailto:xypron.glpk@gmx.de
>    5. mailto:ilias.apalodimas@linaro.org
>    6. mailto:trini@konsulko.com
>    7. mailto:ilias.apalodimas@linaro.org

-- 
Vincent.
