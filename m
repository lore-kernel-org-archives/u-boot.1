Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A27D43360
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 13:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1847892A4;
	Thu,  7 Nov 2024 14:58:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="XVpqMJdR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HcnRM95S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E4C889248; Thu,  7 Nov 2024 14:57:25 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A57F88D51
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 14:57:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=namcao@linutronix.de
Date: Thu, 7 Nov 2024 14:57:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1730987843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qTIqSmwLsk/iuVFE107v3nz4HyQ27WWDWCB/ToSOLmQ=;
 b=XVpqMJdRsMYJDiIiyZPW2BxPTeAl4+t1VqjhgKfOJ555iQW0Ppzy0Utdiiow1sgjkiOC0d
 KDom4a0ign5y+G0opHjY0WQgpJrJDJN4fXqnVSlTtA1Qq+GIX26s/p1EkH7mNIDCaYOYhu
 VFvaSW/kWnCFEJo4V+CWXXYj11idXyEa86dDjpDCFNB8mhbynUuKK3AySuGkHqnN+7GCyU
 tUBH1ugVmoiR+9stemICZQCss8FA2WzG1vmj77FRjTJGOZgp1UOJOycsULbqPzy3TmR4hk
 DC8kRppLOApbndvh4q45UlZtiUUd/WkrKFYHXzvf9Sn2lI+jJVUh/etyt1I8XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1730987843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qTIqSmwLsk/iuVFE107v3nz4HyQ27WWDWCB/ToSOLmQ=;
 b=HcnRM95SyTjO2zfokE0nAs74v9HM/PHquLPUrPPMbO7iyo5F+RU6EyNgozsX25rjNUwIw9
 BGIqCTz9m5WOzCAw==
From: Nam Cao <namcao@linutronix.de>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Sean Anderson <seanga2@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Javier Fernandez Pastrana <javier.pastrana@linutronix.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] boot: extlinux: Fix unaligned buffer for reading
 data from file system
Message-ID: <20241107135721.Ysrcbase@linutronix.de>
References: <cover.1730909884.git.namcao@linutronix.de>
 <fc389bd029264da3ac37de28a1881cfb6fd95988.1730909884.git.namcao@linutronix.de>
 <CAFLszThMD+Gh6M8B7eqDSDRCSPOgDM25SY6qANHBhh50HFz5Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLszThMD+Gh6M8B7eqDSDRCSPOgDM25SY6qANHBhh50HFz5Lg@mail.gmail.com>
X-Mailman-Approved-At: Thu, 07 Nov 2024 14:58:46 +0100
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

On Thu, Nov 07, 2024 at 06:44:30AM -0700, Simon Glass wrote:
> On Wed, 6 Nov 2024 at 09:34, Nam Cao <namcao@linutronix.de> wrote:
> >
> > extlinux_read_bootflow() allocates a buffer to read from file system
> > without any alignment.
> >
> > But for some block devices which transfer data via DMA, ARCH_DMA_MINALIGN
> > alignment is required. For example, due to misaligned buffer, the below
> > boot failure is observed.
> >
> > => boot
> > CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
> > CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
> > CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
> > CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
> > ** Booting bootflow 'mmc@2194000.bootdev.part_1' with extlinux
> > Ignoring unknown command: �D���D��
> > Boot failed (err=-14)
> >
> > Change the alignment to default (which is ARCH_DMA_MINALIGN).
> >
> > Fixes: 31aefaf89a5b ("bootstd: Add an implementation of distro boot")
> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > Tested-by: Javier Fernandez Pastrana <javier.pastrana@linutronix.de>
> > ---
> >  boot/bootmeth_extlinux.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
> > index ae0ad1d53e3..5424d179bf8 100644
> > --- a/boot/bootmeth_extlinux.c
> > +++ b/boot/bootmeth_extlinux.c
> > @@ -127,7 +127,7 @@ static int extlinux_read_bootflow(struct udevice *dev, struct bootflow *bflow)
> >                 return log_msg_ret("try", ret);
> >         size = bflow->size;
> >
> > -       ret = bootmeth_alloc_file(bflow, 0x10000, 1);
> > +       ret = bootmeth_alloc_file(bflow, 0x10000, 0);
> 
> Can you please use ARCH_DMA_MINALIGN here? Either that or update
> bootmeth_script to do the same  as here.

No preference from me. Let's just use ARCH_DMA_MINALIGN here.

Thanks for the comments,
Nam
