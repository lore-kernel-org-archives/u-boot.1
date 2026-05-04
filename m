Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF1AFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 17:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B02FD8394E;
	Mon,  4 May 2026 19:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="QbgIBiXw";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="rJnwhBf0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 366A9845E3; Mon,  4 May 2026 19:34:38 +0200 (CEST)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E81B80F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 19:34:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-ln25.prod.antispam.mailspamprotection.com;
 s=arckey; t=1777916075; 
 b=Bhr1xUedQ3nB4aDu3TpicWTbUoRmB93j2/cEIEOXcIjx0mkgN3kKUuqF6ILdq5/0rF0+8VxCBf
 0EUvIk5nQzhPODIciBVB/tmOnO3X3+6Xsc3YMV0sjgIh/RMwmShp85hRCjtB4U1Cns2DHk8WZE
 xfzpyMmrSzXZmx+aezZywoC7i6n+tse6+EuTJ4849xR1d2N3poSfIiyK/FtLwbA/59CeDkMBv5
 s8+TClSxYLnL0/J/wpM6GHxZhGN7+yXR0jMU9d4l6b5vjLxPj+O7AcIdzPo5oU0EqJ3Kz1AZ1V
 h/IvQf0ASDPxdIEUZsrPjfrS5NgrKxWADRSV7AK/BsBX+g==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-ln25.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-ln25.prod.antispam.mailspamprotection.com;
 s=arckey; t=1777916075; 
 bh=69veVHKBo7ZzPiak5Wd2l7tCqOSbSdCrTigVL9h8mJM=;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
 From:Date:DKIM-Signature:DKIM-Signature;
 b=iILdg/zD5nRGZb0IGYwEcEKodhw1U3pZ+3CYjQ1Zh+QblH/g6edXgh2KB73YA4u8ThoWi5UmAY
 k02gaTSPGwccmWuZ9+K1JkTVbnYSRGO5HH3Fr5W+EWcjPUBW2ZdoFUKEfwyL+QE3Ob935hEEug
 t3VCwSDQ04uqFsIT1wDcnWLEWXuX8adESHG4vphVuPLV1mb9kwXF3lcrJ211EsNapw7yZXeib4
 qrzP0Wiq4/DdXfIlnG70fzvLvvInQn1rn/01l91NyUG4yNweR1XjSGdPfeNQ7uyA+RjBzWhq+w
 K6j4/xauPKDd93ijVrq+eokQQBStirs6DZzyNApxoiL78w==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 List-Unsubscribe:Content-Transfer-Encoding;
 bh=FmGkJavwHVj5aU79e0k5J5urZ8uT/jYz0Olb8dIZOy8=; b=QbgIBiXwPLdLLJAdea2L09n2t/
 rfeQ0sScv7JHNslQIPsCe8t9chVQPjKqjJgW6+dmVCfPC9qYF46IJzpgHfqn5APePeY8pdHX/WyKt
 t4RL6VfvdezzuLv+oqXm3WftFq6Rxq7yIWnzi7mofGhE7lzfM1Le9k5d7a5flB/otl3E=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-ln25.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.1)
 (envelope-from <francesco@valla.it>) id 1wJxBf-0000000DzOK-0mcs
 for u-boot@lists.denx.de; Mon, 04 May 2026 17:34:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=FmGkJavwHVj5aU79e0k5J5urZ8uT/jYz0Olb8dIZOy8=; b=rJnwhBf03HWdpwVTQuij1l0mbz
 7p91bDpTuzLbuG7dose3YfQwGsHYQQXHjXk6/75l/VAV6CrprsS5HtpSV8qCE8DuNJRY6vzuSZBBi
 3adVevQDxuGvFkFwHMVxLNxqjtJViWFRhSBBekIytDyUsXZer4Pqq/t2Sv2v+cTZlPjs=;
Received: from [95.248.129.24] (port=60449 helo=bywater)
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <francesco@valla.it>)
 id 1wJxBX-000000005eX-3Vi6; Mon, 04 May 2026 17:34:23 +0000
Date: Mon, 4 May 2026 19:34:21 +0200
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
Subject: Re: [PATCH 2/5] boot: fit: decompress kernel when in SPL
Message-ID: <afjYP8Pdwj0aeIWF@bywater>
References: <20260428-spl_fit_full-v1-0-dde63beeaab1@valla.it>
 <20260428-spl_fit_full-v1-2-dde63beeaab1@valla.it>
 <CAFLszThh9zfED4VdR=vfkTisGMqdmRm26JtrJhh7rjQiLSn1VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszThh9zfED4VdR=vfkTisGMqdmRm26JtrJhh7rjQiLSn1VQ@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: b1058c58d6c8f418bd9cba85393d17d6
X-AntiAbuse: ID - b1058c58d6c8f418bd9cba85393d17d6
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wJxBf-0000000DzOK-0mcs-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-ln25.prod.antispam.mailspamprotection.com; 
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

On Mon, May 04, 2026 at 06:08:40AM -0600, Simon Glass wrote:
> Hi Francesco,
> 
> On 2026-04-28T20:24:41, Francesco Valla <francesco@valla.it> wrote:
> > boot: fit: decompress kernel when in SPL
> >
> > During the esecution of fit_image_load() in full U-Boot, the kernel is
> > not decompressed as this step is typically performed by the bootm
> > command logic afterward. This is not however true when doing a falcon
> > boot from SPL; enable the decompression in this case (i.e., if
> > CONFIG_SPL_OS_BOOT is set).
> >
> > Signed-off-by: Francesco Valla <francesco@valla.it>
> >
> > boot/image-fit.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> > diff --git a/boot/image-fit.c b/boot/image-fit.c
> > @@ -2291,9 +2291,10 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
> > +         image_type != IH_TYPE_RAMDISK &&
> > +         (CONFIG_IS_ENABLED(OS_BOOT) ||
> > +          image_type != IH_TYPE_KERNEL ||
> > +          image_type != IH_TYPE_KERNEL_NOLOAD)) {
> 
> Since image_type can never be both IH_TYPE_KERNEL and
> IH_TYPE_KERNEL_NOLOAD at the same time, (image_type != IH_TYPE_KERNEL
> || image_type != IH_TYPE_KERNEL_NOLOAD) is always true, the kernel is
> decompressed unconditionally, including in U-Boot proper, which is
> what the original code was trying to avoid.
> 
> I think you want:
> 
>     (CONFIG_IS_ENABLED(OS_BOOT) ||
>      (image_type != IH_TYPE_KERNEL &&
>       image_type != IH_TYPE_KERNEL_NOLOAD))
>

This was exactly the first version, then I tried to simplify the logic
and quite obviously failed. I'll fix it for v2.

> Can you see a way to add a test that exercises this path so the
> regression would be caught?
> 
> > During the esecution of fit_image_load() in full U-Boot, the kernel is
> 
> execution
> 
> It is worth mentioning mention in the commit message that you rely on
> CONFIG_IS_ENABLED(OS_BOOT) being false in U-Boot proper (since only
> CONFIG_SPL_OS_BOOT exists), so existing behaviour is preserved there.
> 

Ok

> Regards,
> Simon

Thank you

Regards,
Francesco
