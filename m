Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06E5FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 17:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A5D78466C;
	Mon,  4 May 2026 19:47:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="Jrarbi6w";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="IGl83k1g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D8F184669; Mon,  4 May 2026 19:47:27 +0200 (CEST)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D2438466C
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 19:47:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-dzr6.prod.antispam.mailspamprotection.com;
 s=arckey; t=1777916844; 
 b=yWlhXGsQ9BKybHcyVo7XAd/W/eOp5c6gX0JVokly8TZRhPm/Cev0+aWtI0s9Z+xdnwBWTGIF1P
 bhjF9eBRYdt8tK2bKCT/1t6QJ2xehU2bgM9TjsOsy9FKFJz/1b2u05xbE4VHb/jb0vrknVZGsP
 A7076gWlRYf6bQJSxVbpL5T81ie3PYYcMAxwwi6LcjTe3UehxEotTEHaZC8Qjqwg+2fD/TUbbn
 QSVLvrtGzccKEKacy4gPSIURFQDy7EwcKD7WRsPAdIlozu/mLjtMV5YIUx2Gg3lzpMs8MJ3zvq
 sCccL0da9hXcHOlx3SSNwyjg/i8xG4izjjg7TULJNBZcgQ==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-dzr6.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-dzr6.prod.antispam.mailspamprotection.com;
 s=arckey; t=1777916844; 
 bh=ji2JuKnFzJb0dKs8MhZKZv5CNZoEbqT6Um+Y3GeLxSg=;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
 From:Date:DKIM-Signature:DKIM-Signature;
 b=D60mDAJPLrKiRwXPe0FtZ27OkXA0wQy4BRI3RYyOA9WdRPErdRFiCO4Om5mRFDVXPl8VGgkYOl
 eUMntYbIjkM1IAFXkulpG7xVacCEA0ElkZpv5rY/nHQYLxoJdmOdPxQgEe2BTZyjr24ZkTXlsi
 OM+C5soFL94nGzix2WIfbI9OPtNngBWChq+3AJD1k0vlNOFvw40llr0m/kF0bFf3EWUPtEBmEi
 zE6KRcQJtGI8nlXf+drzNLE3+NzK81zgOXFimE69A9GH7gGB3SwoKNKTKfqXWU6uyrAy+QV1cm
 HUNbXUG2a/6KXe/dj8cTDvl5ZQnz4GlKC/mNFOxKcsJSXg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 List-Unsubscribe:Content-Transfer-Encoding;
 bh=kx2bH6Yd+TFsxCIUKK5ox2HKqocrAxp7nQ9RGUt2Vm8=; b=Jrarbi6w853LXkrV6Olo99Scft
 1TrMjJGsXSn4sbFxKPEHE9UlLq9HJ73ekwa/q6uPGAZ3fMPJx2hEZPkkWNBcFZ8FbHVNKiuD5xb3r
 5v0NS7aj+2I38se1iF1k+N0Fmv8V/8pw5q62XEmnIswqKxZa7Hpii8UbM/6rGpSpjI90=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-dzr6.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.1)
 (envelope-from <francesco@valla.it>) id 1wJxO4-0000000Begn-0Yja
 for u-boot@lists.denx.de; Mon, 04 May 2026 17:47:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=kx2bH6Yd+TFsxCIUKK5ox2HKqocrAxp7nQ9RGUt2Vm8=; b=IGl83k1gi3LsbL7k5v/RFEm74f
 imxK3M1YCmdpsgvSMjqtNHPvNxVIjKAc+Y5nPcsPEogoxD4NTfuUamRXA6wzSFa6t4hbAbOT4i53L
 2WVIe5aixbZIRsYJYTKx1C2z9rdp9z8gOcc33ZPXXpSZpEu8zYmHI/wJBBtNuPq5LiGk=;
Received: from [95.248.129.24] (port=61372 helo=bywater)
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <francesco@valla.it>)
 id 1wJxNx-00000000Ebz-1LWl; Mon, 04 May 2026 17:47:13 +0000
Date: Mon, 4 May 2026 19:47:10 +0200
From: Francesco Valla <francesco@valla.it>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>, 
 Frank Wunderlich <frank-w@public-files.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Anshul Dalal <anshuld@ti.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Ronald Wahl <ronald.wahl@legrand.com>, Dhruva Gole <d-gole@ti.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Michael Walle <mwalle@kernel.org>, Marek Vasut <marek.vasut@mailbox.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 5/5] spl: fit: add ramdisk load
Message-ID: <afjZ4__QY137OrWF@bywater>
References: <20260428-spl_fit_full-v1-0-dde63beeaab1@valla.it>
 <20260428-spl_fit_full-v1-5-dde63beeaab1@valla.it>
 <CAFLszTh2CFomDvn4u6HAo_2mT+2GyvqHfo_y8-agOH-KoCvjPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTh2CFomDvn4u6HAo_2mT+2GyvqHfo_y8-agOH-KoCvjPg@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 16ea9c928d5fee2e9ada345b33453b41
X-AntiAbuse: ID - 16ea9c928d5fee2e9ada345b33453b41
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wJxO4-0000000Begn-0Yja-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-dzr6.prod.antispam.mailspamprotection.com; 
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

Hi Simon,

On Mon, May 04, 2026 at 06:09:31AM -0600, Simon Glass wrote:
> Hi Francesco,
> 
> On 2026-04-28T20:24:41, Francesco Valla <francesco@valla.it> wrote:
> > spl: fit: add ramdisk load
> >
> > Add ramdisk loading logic to the 'full' SPL FIT loader, as well as the
> > corresponding FDT fixup. This is required for proper support of falcon
> > boot using FIT images, but is useless for a U-Boot launch, so make it
> > depend on SPL_OS_BOOT.
> >
> > Signed-off-by: Francesco Valla <francesco@valla.it>
> >
> > common/spl/spl.c     | 17 ++++++++++++++---
> >  common/spl/spl_fit.c | 18 ++++++++++++++++--
> >  include/spl.h        | 20 ++++++++++++++++++++
> >  3 files changed, 50 insertions(+), 5 deletions(-)
> 
> > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > @@ -172,6 +172,14 @@ void spl_fixup_fdt(void *fdt_blob)
> >                       return;
> >               }
> >       }
> > +
> > +#if IS_ENABLED(CONFIG_SPL_OS_BOOT)
> > +     err = fdt_initrd(fdt_blob, initrd_start, initrd_end);
> > +     if (err) {
> > +             printf(PHASE_PROMPT "fdt_initrd err - %d\n", err);
> > +             return;
> > +     }
> > +#endif
> >  #endif
> >  }
> 
> Please us 'if (IS_ENABLED(CONFIG_SPL_OS_BOOT))' - we try to avoid #if
> in C files for better build-coverage.
> 

Ok.

> > diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> > @@ -1011,6 +1011,20 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
> >               }
> >       }
> >
> > +     if (spl_image->os != IH_OS_U_BOOT) {
> > +#ifdef CONFIG_SPL_FIT_SIGNATURE
> > +             images.verify = 1;
> > +#endif
> > +             ret = fit_image_load(&images, virt_to_phys((void *)header), NULL,
> > +                                  &fit_uname_config, IH_ARCH_DEFAULT,
> > +                                  IH_TYPE_RAMDISK, -1, FIT_LOAD_OPTIONAL,
> > +                                  &rd_data, &rd_len);
> > +             if (ret >= 0) {
> > +                     spl_image->ramdisk_addr = rd_data;
> > +                     spl_image->ramdisk_size = rd_len;
> > +             }
> > +     }
> > +
> 
> There is no SPL_OS_BOOT guard here, so the ramdisk lookup is attempted
> for any non-U-Boot OS (ATF, OP-TEE, OpenSBI, Linux). Is that
> intentional? With FIT_LOAD_OPTIONAL it is harmless when no ramdisk
> node exists, but gating on CONFIG_IS_ENABLED(OS_BOOT) would match the
> consumer side in spl_fixup_fdt()
> 

It _was_ intentional, since when I wrote initially this patch I was
experimenting with different options for the FIT image format (including
e.g. having TF-A instead of Linux marked as the OS).

But in the end a guard is probably a better option, I agree. 

> > diff --git a/include/spl.h b/include/spl.h
> > @@ -288,6 +288,8 @@ struct spl_image_info {
> >       ulong entry_point;
> >  #if CONFIG_IS_ENABLED(LOAD_FIT) || CONFIG_IS_ENABLED(LOAD_FIT_FULL)
> >       void *fdt_addr;
> > +     ulong ramdisk_addr;
> > +     ulong ramdisk_size;
> >  #endif
> 
> Only the LOAD_FIT_FULL path populates these (spl_load_simple_fit()
> does not load a ramdisk), so they could be gated on LOAD_FIT_FULL
> only. Please also add a kernel-doc comment to the new
> spl_image_ramdisk_start()/spl_image_ramdisk_end() helpers describing
> the units and what they return when the FIT loader is not enabled -
> 'end' in particular is ambiguous (inclusive vs exclusive), so please
> state that it is the exclusive end address expected by fdt_initrd().
> 

Ok.

> Regards,
> Simon

Thank you!

Regards,
Francesco

