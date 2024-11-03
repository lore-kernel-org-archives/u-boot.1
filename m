Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8042AE6B252
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 10:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4F5F8909F;
	Sun,  3 Nov 2024 11:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5DCB890F8; Sun,  3 Nov 2024 11:36:43 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4CD4B88ECB
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 11:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A0A7FEC;
 Sun,  3 Nov 2024 02:37:10 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C53D93F66E;
 Sun,  3 Nov 2024 02:36:38 -0800 (PST)
Date: Sun, 3 Nov 2024 10:36:26 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Jagan Teki
 <jagan@amarulasolutions.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?B?Q3PDs2vDoXM=?= Bence <csokas.bence@prolan.hu>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Peter Robinson
 <pbrobinson@gmail.com>, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>, Sumit Garg <sumit.garg@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH v4 5/8] sunxi: Move to bootstd
Message-ID: <20241103103626.0d5c76a6@minigeek.lan>
In-Reply-To: <CAFLszTihCzaut1MCtQJ=LTzYrhwyT+3On8hM2GMgSd0g6dqKBw@mail.gmail.com>
References: <20241017232531.726559-1-sjg@chromium.org>
 <20241017232531.726559-6-sjg@chromium.org>
 <CAFLszTihCzaut1MCtQJ=LTzYrhwyT+3On8hM2GMgSd0g6dqKBw@mail.gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sat, 2 Nov 2024 11:35:31 -0600
Simon Glass <sjg@chromium.org> wrote:

Hi Simon,

> On Thu, 17 Oct 2024 at 17:25, Simon Glass <sjg@chromium.org> wrote:
> >
> > Drop support for distroboot and move to using bootstd instead.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v2)
> >
> > Changes in v2:
> > - Convert the other DISTRO_DEFAULTS in the Kconfig too
> >
> >  arch/arm/Kconfig | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)  
> 
> Could this series be applied, please?

So I played with that a bit:
- The FEL script boot method works: it has the highest priority, which
  is what we want, because the script would be deliberately injected by
  the user to be executed. So thanks for the changes!
- However the other global boot method (efimgr) takes precedence over
  other, *higher* priority methods (extlinux.conf/boot.scr). This
  leads to behavioural regressions, I think, like:
  - Say there is a bootaa64.efi on some ESP on the eMMC. If you now
    boot from SD card, with boot.scr or extlinux.conf on there, U-Boot
    will still find the EFI app first and execute that. I don't think
    that's what we want?
  - Similar, if you have a boot script on the eMMC, and boot from
    there, but with a USB stick carrying a bootaa64.efi plugged in.
    Then EFI would win as well. This might be intended, but maybe not,
    and I don't see how one would influence that?

Is there a way to change the bootflow to look for any boot payload on
the *boot* media first? So when I boot from SD, it checks this first for
EFI, boot.scr, extlinux.conf, then goes to eMMC and USB. Similarly, when
booting from eMMC, check there first before considering SD and USB.
Maybe I am missing something obvious here?

So while I am personally happy with EFI being a prominent citizen, I
think many sunxi users would still expect more traditional boot methods
to at least work - at the moment they might be permanently "shadowed" by
some bootaa64.efi sitting *somewhere*. That actually bites me at the
moment when working on a new SoC port, where I use an extlinux.conf as
an override, to load a custom dev kernel and DTB, but bootstd still
finds that grub on that SD card and uses that first :-(

So I feel like EFI should still be the preferred boot method, but the
more custom ways should be allowed to override that.

Do you have any ideas how to solve that, or am I holding it wrong?

Cheers,
Andre
