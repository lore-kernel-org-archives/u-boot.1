Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59A3CEFCE2
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 17:54:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC18583C08;
	Tue,  6 Jan 2026 18:54:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="0JO/TgtQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F236B83F98; Tue,  6 Jan 2026 15:40:43 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F8A383EB7
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 15:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.petazzoni@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 1C6031A264A;
 Tue,  6 Jan 2026 14:40:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E190360739;
 Tue,  6 Jan 2026 14:40:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9D0B2103C86AF; Tue,  6 Jan 2026 15:40:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1767710440; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=oTPzfEfwU1WZ27f86Uv4AORH+h2aBjXJH7ZF11Puhmc=;
 b=0JO/TgtQxKQFhaw4sA0Cuhv7+084T0BMhcReYWKmDdJVsTR3N1bAZEIMm+k9KuHWVh2OY+
 K8ETEH/nqU8w6wq3aXEhGQkdKGazRscm/WN1uUwn/Eo3O2TKFu5xN1ZXd+y/X5I6f6OzyB
 r+gq/CX3iFVW7utrzLuWPUxpNTsx0bdypBFAtKcHiesfm/e5AJFQjCWxJ/TzkUk7D1gnZK
 S+hUNXJJLmkZ342VfrE56LBNzuoGLyZ8f/nWpBVtj2jl4EncpfunaQJK6gaQFL9w4SpnuP
 pQH67MZPLNu+EUQ803Z8CKdXYSA5qVGwyrpi8XTl+bjOK+MKyAS6b5MGP83CiQ==
Date: Tue, 6 Jan 2026 15:40:37 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Francesco Valla <francesco@valla.it>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, Fabio
 Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>, Tom Rini
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Mathieu Dubois-Briand
 <mathieu.dubois-briand@bootlin.com>, Joseph Guo <qijian.guo@nxp.com>,
 Fabian Pflug <f.pflug@pengutronix.de>
Subject: Re: [PATCH] imx93_frdm: clear and mask TCPC interrupts
Message-ID: <20260106154037.27a9dfa8@windsurf>
In-Reply-To: <20260103-imx93_frdm_tcpc_fix-v1-1-d7ef892697eb@valla.it>
References: <20260103-imx93_frdm_tcpc_fix-v1-1-d7ef892697eb@valla.it>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 06 Jan 2026 18:54:23 +0100
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

Hello Francesco,

On Sat, 03 Jan 2026 22:22:12 +0100
Francesco Valla <francesco@valla.it> wrote:

> One of the two on-board PTN5110 TCPC USB Power Delivery controller on
> the i.MX93 FRDM board shares its interrupt line whith the PCAL6524 power
> controller (GPIO3-27). Since the PTN5110 starts after POR with the
> interrupts enabled, this can lead to an interrupt storm on OS startup if
> only the driver for the PCAL6524 is loaded, because none is servicing
> (and clearing) the interrupt requests from the PTN5110.
> 
> Maks and clear all interrupts as part uring board initialization; they
> can be re-enabled later by a proper OS driver if required.
> 
> Co-developed-by: Joseph Guo <qijian.guo@nxp.com>
> Signed-off-by: Francesco Valla <francesco@valla.it>

Thanks a lot for this patch, I confirm it fixes the issue I was having
with the kernel experiencing spurious IRQs. I don't really have any
comments on the technical approach: it's never nice to poke into a
device registers directly from a board file and outside of the driver
for that specific device, but I don't know if there's a better approach
for this specific problem.

So in any case:

Tested-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thanks again!

Thomas
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com
