Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9C8CD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 17:39:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 791FB8394E;
	Mon,  4 May 2026 19:39:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="lOV/PDMV";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="U3Jg9lqm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41FB484662; Mon,  4 May 2026 19:39:28 +0200 (CEST)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E9BB80F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 19:39:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-dzr6.prod.antispam.mailspamprotection.com;
 s=arckey; t=1777916365; 
 b=GiunqwcAXb8+lLZZJvTyxXmIUozHh5yRPWd81ypnwfBXN/yZH/sMY5ABktThjPDWqZWGafv4DQ
 qrBvn9nBnN3ZZt3GQldniR+yn7eWt9902ZQIn4lq9RWq7OlJ3ukpXQn8e6fPYykoNrJ+C2Uz6K
 1n2zU6qmGQ8Atyq40d4Ft29w1o4rlk52LMLXCx3mwjDv0nV3hiGafRAy9SGK8Epg7bZ4Ge2y2+
 0rB5S8bEDAHhYrgD4xf/JmPay5w3s+fqGC1BeIao9KUbRL3O3CENhETvJf94LXPCeRHY+OfuoF
 FiARyLxZkVDx4Rb6PI0Jle+dt+ZvZmLJ8WySWiXlBGOCiA==;
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
 s=arckey; t=1777916365; 
 bh=VmFZQ/kSYmumRv6oPmOQz732Vdj6pPUmIIM+jeFjVdc=;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
 From:Date:DKIM-Signature:DKIM-Signature;
 b=l3w9jLgYBRaBW+lmlRhIVooi357JlOodXslfIuRnUr/4/14XHgMczApAy4p/w09cy/gy40Xsql
 Kue1njdCCxW6obK+sO2vzr7fGWb3Fg5XlSzcscgqy8JxtCuoBMaLuab2BoKneQpNWuC5ckGTB0
 w3600etiuMMekYKaGw20BKUKeyye4sq61/O4cOHxeBmZsOHlVt2m6wuvIRNo8HtcYOE2pFoQgS
 D5rI5+VV1rQ3n5oAQlRDTfedkPrzaWhtfmU4Y6LEbxHLcFW+Tu2kL500bvaAzU1A+V9Gd4NXNB
 rtxLeVL6XZ2Exu1UktY7T0nTY9PvcP/zFBbPMsDkfBTqtg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 List-Unsubscribe:Content-Transfer-Encoding;
 bh=aN8XKHSKl6SnzHpJSiWxUuOXmhO3W2Ngt5ViV/u+9IE=; b=lOV/PDMV3DGq6JMPD8xTmJJBo1
 IgVSJ6vVabMbG/TEmZy2WM0k2Kei8GLtA7JLOiis5q3d9m9RIx0TMYz5fbW5Jq72FK8Er4Bg30HJW
 Qi7PZa5HeS26d72Y0/ylwiTTUrDUYS+fztZ0jcwaAicM3KLunwyKYT3aasxboYaQwFJ4=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-dzr6.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.1)
 (envelope-from <francesco@valla.it>) id 1wJxGL-0000000BW5h-12Yp
 for u-boot@lists.denx.de; Mon, 04 May 2026 17:39:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=aN8XKHSKl6SnzHpJSiWxUuOXmhO3W2Ngt5ViV/u+9IE=; b=U3Jg9lqmtdxgOs+zmXnrSvdQfJ
 WiMgAO1UmuDvqvEaIWQGGRGyiOusMJRh2ENwXjFRD8JGI3/Uh+yYkxZBAcnufxQJDx1aSjooA6tzg
 WpzpHL3DsHhvQEEm2rKqwnX4fZk3shlWYoent9Cfj0BQdUGIgvijE7ZUop0it8H75Nho=;
Received: from [95.248.129.24] (port=63753 helo=bywater)
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <francesco@valla.it>)
 id 1wJxGD-000000009V4-1j0J; Mon, 04 May 2026 17:39:13 +0000
Date: Mon, 4 May 2026 19:39:11 +0200
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
Subject: Re: [PATCH 4/5] spl: call ft_board_setup() and ft_system_setup() if
 enabled
Message-ID: <afjYrn-vCis3CPBu@bywater>
References: <20260428-spl_fit_full-v1-0-dde63beeaab1@valla.it>
 <20260428-spl_fit_full-v1-4-dde63beeaab1@valla.it>
 <CAFLszTiJefn22TX_svrwuj+dP_ytsPCz19Vxgkp_B1f2p5t1VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTiJefn22TX_svrwuj+dP_ytsPCz19Vxgkp_B1f2p5t1VQ@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 4a0198cb1ca4412f58f1ab11da7612db
X-AntiAbuse: ID - 4a0198cb1ca4412f58f1ab11da7612db
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wJxGL-0000000BW5h-12Yp-feedback@antispam.mailspamprotection.com
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

On Mon, May 04, 2026 at 06:09:01AM -0600, Simon Glass wrote:
> Hi Francesco,
> 
> On 2026-04-28T20:24:41, Francesco Valla <francesco@valla.it> wrote:
> > spl: call ft_board_setup() and ft_system_setup() if enabled
> >
> > If board and system FDT setups are enabled by the corresponding
> > configuration options, perform them also in SPL. This aligns the
> > behavior of FIT loading from SPL and U-Boot proper in this aspect,
> > reducing the need for custom code in falcon boot setups.
> >
> > Signed-off-by: Francesco Valla <francesco@valla.it>
> >
> > common/spl/spl.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> 
> > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > @@ -156,6 +156,22 @@ void spl_fixup_fdt(void *fdt_blob)
> > +     if (IS_ENABLED(CONFIG_OF_BOARD_SETUP)) {
> > +             err = ft_board_setup(fdt_blob, gd->bd);
> > +             if (err) {
> > +                     printf(PHASE_PROMPT "ft_board_setup err - %d\n", err);
> > +                     return;
> > +             }
> > +     }
> > +
> > +     if (IS_ENABLED(CONFIG_OF_SYSTEM_SETUP)) {
> > +             err = ft_system_setup(fdt_blob, gd->bd);
> > +             if (err) {
> > +                     printf(PHASE_PROMPT "ft_system_setup err - %d\n", err);
> > +                     return;
> > +             }
> > +     }
> 
> CONFIG_OF_BOARD_SETUP / CONFIG_OF_SYSTEM_SETUP are not SPL-aware, so
> any board that has them set today will start call ft_board_setup() /
> ft_system_setup() in SPL with this patch. Can you use
> CONFIG_IS_ENABLED() and add new SPL_... options for your board to
> enable?
>

Ok, I was not sure new config options would have been accepted here.
I'll do this on the V2.

> If we're aligning with image_setup_libfdt(),
> CONFIG_OF_BOARD_SETUP_EXTENDED / ft_board_setup_ex() is also part of
> that flow. Is leaving it out deliberate, or should it be handled here
> too? A note in the commit message would help.
> 

I missed ft_board_setup_ex() TBH. I'll take a look and do the
evaluation.

> Regards,
> Simon

Regards,
Francesco
