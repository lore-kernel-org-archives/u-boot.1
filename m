Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4E0CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 22:14:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9900E84BC7;
	Fri,  8 May 2026 00:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="YnqAW3lD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 182DE84BF6; Fri,  8 May 2026 00:14:33 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CD65849E0
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 00:14:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 1e6c4e36-4a62-11f1-bea8-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 1e6c4e36-4a62-11f1-bea8-005056992ed3;
 Fri, 08 May 2026 00:14:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=iPAG/tMRBzwHF9ojHAiosopYVxtrI+ssnh1msF9sITc=;
 b=YnqAW3lDmZ2t9n2Jn8HPE0XTh3AtKWAGaJtphnxaZLj+DFCBUYxlF77ijMRQ24pOdABt0gQVENSwm
 eZZuGmSkp64Zb1q2rAgGUMCaRasGCvvqscYcHLc/kp75suPvPKGWk264gU9va+v0S4fX8J2D0p5lji
 ncK3+yJ2ZMjFa4BDTwZ1HyLVpDmu5sUh8dzf2eF8cJGwdC2zajTeQHBkjbH8qtkvMn+agFfZR1S81D
 wDpkHQt/fLGUf2O/Yvd/dsPEsZqJ+vzmEULFKi1m8Zj1AQZmGptug9q1Qt9+LxoJcK/bmbA/lOsnIo
 repPJ7ZhZqxy6CVj8NJi9kddOcizg8A==
X-KPN-MID: 33|JPDOhIjS+XL9ex/xbtzrP1pEfePs5mtWVqlY7bblF9XZHphxTy41VZsOm6sKSy5
 DcobY8Qwyp93jx5qedvGMiJRwZvQcXynV8nz5WaMc5eE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Em95mMF4+2rLojycq1Xd985x/t5COQO1ecKUx341LzVAUf3wzrcN+hffG9SL3Bx
 vvGP41kvix1vS9CEgUPA17g==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 1df7ea2b-4a62-11f1-9c0c-00505699d6e5;
 Fri, 08 May 2026 00:14:30 +0200 (CEST)
Date: Fri, 08 May 2026 00:14:29 +0200
Message-Id: <87o6iqc1fe.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, marek.vasut+renesas@mailbox.org, trini@konsulko.com
In-Reply-To: <20260507220651.209168-1-marek.vasut+renesas@mailbox.org>
 (message from Marek Vasut on Fri, 8 May 2026 00:06:28 +0200)
Subject: Re: [PATCH 1/6] mailbox: apple: Staticize and constify driver ops
References: <20260507220651.209168-1-marek.vasut+renesas@mailbox.org>
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

> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Date: Fri,  8 May 2026 00:06:28 +0200
> 
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Acked-by: Mark Kettenis <kettenis@openbsd.org>

> ---
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/mailbox/apple-mbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/apple-mbox.c b/drivers/mailbox/apple-mbox.c
> index 2ee49734f40..39a7edc0285 100644
> --- a/drivers/mailbox/apple-mbox.c
> +++ b/drivers/mailbox/apple-mbox.c
> @@ -59,7 +59,7 @@ static int apple_mbox_recv(struct mbox_chan *chan, void *data)
>  	return 0;
>  }
>  
> -struct mbox_ops apple_mbox_ops = {
> +static const struct mbox_ops apple_mbox_ops = {
>  	.of_xlate = apple_mbox_of_xlate,
>  	.send = apple_mbox_send,
>  	.recv = apple_mbox_recv,
> -- 
> 2.53.0
> 
> 
