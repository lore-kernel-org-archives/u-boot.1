Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103D010F995F
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 16:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99D5483F98;
	Wed,  8 Apr 2026 18:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="TBa9bk+q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ACB08404A; Wed,  8 Apr 2026 18:36:32 +0200 (CEST)
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F4CB83D8A
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 18:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Date: Wed, 08 Apr 2026 16:35:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1775666189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HW3QIYzuVGmnr2iYCGDvI5LijokJlKu7maSj1UUAJ7g=;
 b=TBa9bk+qok9G3lu3pq7OvRtb/4DBiBhbuqinLOQchX6zOoFNouhTWZSiBUuLdW9G5/ATiR
 P/YaqGbqVWNJwy3CDE17QhtQApUi9lK0dgWB/inH/feN2Lb+Jip7j+sA9lmVj/6NI5xHx1
 xcFS+zT6dU/kXwWsPauND/kaRVur881pv5S7sY/B8nbrSSFATBPrhVGkVxtpyNhG/KvgvF
 MEjF0zHouKyotujVcNFlvEr2rglsEsXw4PfDhMxmdI1el5E7B3mJun0hSRvP1hH0y8ongp
 z2eff78nD6zfyEg4JWBddlK0zZRp5e1L90BHGOkqnTF0Lbx0CaH4nBxyDKazoQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin Schwan <m.schwan@phytec.de>,
 David Zang <davidzangcs@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH 1/2] autoboot: allow custom prompt without requiring
 AUTOBOOT_KEYED
References: <20260405-ui-cosmetics-v1-0-bffec3cac741@postmarketos.org>
 <20260405-ui-cosmetics-v1-1-bffec3cac741@postmarketos.org>
 <20260406153000.GP41863@bill-the-cat> <td2xjd.37hr0tkamw99c@postmarketos.org>
 <20260406161057.GS41863@bill-the-cat> <td32mt.vpwrp72jgt4m@postmarketos.org>
In-Reply-To: <td32mt.vpwrp72jgt4m@postmarketos.org>
Message-ID: <td6osk.387waa70kc9gn@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
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

Hi Tom,

On Mon, 06 Apr 2026 17:41, Ferass El Hafidi <funderscore@postmarketos.org> wrote:
>On Mon, 06 Apr 2026 16:10, Tom Rini <trini@konsulko.com> wrote:
>>On Mon, Apr 06, 2026 at 03:39:38PM +0000, Ferass El Hafidi wrote:
>>> On Mon, 06 Apr 2026 15:30, Tom Rini <trini@konsulko.com> wrote:
>>> > On Sun, Apr 05, 2026 at 10:49:04AM +0000, Ferass El Hafidi wrote:
>>> > 
>>> > > The autoboot prompt used to only be customizable in Kconfig when
>>> > > AUTOBOOT_KEYED was enabled. For a usecase such as having a nicer
>>> > > autoboot prompt alongside a splash screen, there is no reason for
>>> > > AUTOBOOT_KEYED to be required for this.
>>> > > 
>>> > > Remove the dependency to AUTOBOOT_KEYED, and use AUTOBOOT_PROMPT in
>>> > > print_boot_delay() instead of a hardcoded string.
>>> > > 
>>> > > Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
>>> > > ---
>>> > >  boot/Kconfig      | 31 ++++++++++++++++---------------
>>> > >  common/autoboot.c |  4 +++-
>>> > >  2 files changed, 19 insertions(+), 16 deletions(-)
>>> > > 
>>> > > diff --git a/boot/Kconfig b/boot/Kconfig
>>> > > index bfed452d77e..6c8ec356996 100644
>>> > > --- a/boot/Kconfig
>>> > > +++ b/boot/Kconfig
>>> > > @@ -1560,6 +1560,22 @@ config AUTOBOOT
>>> > >  	help
>>> > >  	  This enables the autoboot.  See doc/README.autoboot for detail.
>>> > > +config AUTOBOOT_PROMPT
>>> > > +	string "Autoboot stop prompt"
>>> > > +	default "Autoboot in %d seconds\\n" if AUTOBOOT_KEYED
>>> > > +	default "\\rHit any key to stop autoboot: %d"
>>> > > +	help
>>> > > +	  This string is displayed before the boot delay selected by
>>> > > +	  CONFIG_BOOTDELAY starts. If it is not defined	there is no
>>> > > +	  output indicating that autoboot is in progress.
>>> > > +
>>> > > +	  Note that this define is used as the (only) argument to a
>>> > > +	  printf() call, so it may contain '%' format specifications,
>>> > > +	  provided that it also includes, separated by commas exactly
>>> > > +	  like in a printf statement, the required arguments. It is
>>> > > +	  the responsibility of the user to select only such arguments
>>> > > +	  that are valid in the given context.
>>> > > +
>>> > >  if AUTOBOOT
>>> > >  config BOOTDELAY
>>> > > @@ -1597,21 +1613,6 @@ config AUTOBOOT_FLUSH_STDIN
>>> > >  	  This can't be enabled for the sandbox as flushing stdin would
>>> > >  	  break the autoboot unit tests.
>>> > > -config AUTOBOOT_PROMPT
>>> > > -	string "Autoboot stop prompt"
>>> > > -	default "Autoboot in %d seconds\\n"
>>> > > -	help
>>> > > -	  This string is displayed before the boot delay selected by
>>> > > -	  CONFIG_BOOTDELAY starts. If it is not defined	there is no
>>> > > -	  output indicating that autoboot is in progress.
>>> > > -
>>> > > -	  Note that this define is used as the (only) argument to a
>>> > > -	  printf() call, so it may contain '%' format specifications,
>>> > > -	  provided that it also includes, separated by commas exactly
>>> > > -	  like in a printf statement, the required arguments. It is
>>> > > -	  the responsibility of the user to select only such arguments
>>> > > -	  that are valid in the given context.
>>> > > -
>>> > >  config AUTOBOOT_ENCRYPTION
>>> > >  	bool "Enable encryption in autoboot stopping"
>>> > >  	help
>>> > > diff --git a/common/autoboot.c b/common/autoboot.c
>>> > > index 1783ef92c94..d12d618fea3 100644
>>> > > --- a/common/autoboot.c
>>> > > +++ b/common/autoboot.c
>>> > > @@ -379,7 +379,9 @@ static int abortboot_key_sequence(int bootdelay)
>>> > >  static void print_boot_delay(int bootdelay)
>>> > >  {
>>> > > -	printf(ANSI_CLEAR_LINE "\rHit any key to stop autoboot: %d", bootdelay);
>>> > > +#ifdef CONFIG_AUTOBOOT_PROMPT
>>> > > +	printf(ANSI_CLEAR_LINE CONFIG_AUTOBOOT_PROMPT, bootdelay);
>>> > > +#endif
>>> > >  }
>>> > >  static int abortboot_single_key(int bootdelay)
>>> > 
>>> > We shouldn't need to guard this, as it's always prompted for now during
>>> > configuration, yes?
>>> > 
>>> 
>>> I did this in case it happened to be unset, and also to provide a way to
>>> silence the prompt entirely.
>>
>>I believe it must be set (there may or may not be some fun around
>>CMDLINE=n), but this doesn't allow for the prompt to be unset, if I'm
>>recalling some of the fun around Kconfig -> defines works (defined to ""
>>is not the same as undefined, we would need to add a new bool Kconfig
>>option, that's why there's USE_PREBOOT and PREBOOT for example).
>>

Thanks, I sent a v2 removing these.

Best regards,
Ferass
