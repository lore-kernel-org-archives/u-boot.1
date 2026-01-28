Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052EFD25B7E
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 13:55:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49A3F83DDF;
	Wed, 28 Jan 2026 14:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="w73msLT3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D729F83DEB; Wed, 28 Jan 2026 14:55:46 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 888F283CEA
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 14:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 2B2381A2ABC;
 Wed, 28 Jan 2026 13:55:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E342C6071F;
 Wed, 28 Jan 2026 13:55:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 41B96119A880E; Wed, 28 Jan 2026 14:55:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769608543; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=d6K3Tj2aUhZsN5HZuTE3z/ljesq2qeBCUsovFJwJhp4=;
 b=w73msLT3aKEOVV/+dRlFfS8oSm1F3uEw/rQ1OgDa9LFmfF2YMeNoXFEPR747ui5JSkKOtf
 CVeAbKTdd9lQ5PtjrJhDZk5OpB0jK9sKa/r3C+SGAtmAcZKyzVLzXny2E6x/aeFAV8osqz
 NxIkbpYx2fWyuXLQOsi+sLktBKTU6pGdQtpC3CDwzgSoLAtKBGqBXm6vXL5OiqWYEntfGm
 mec7qSRimcB7OVB4s5Mv38Jwo0NwFR3UJ8pAIiX7l/C0t754vPJEkiwXPRgFZt0rSuU37r
 mKLFO5COkCkY7GdGIGD9WbSK310hnhECUWx9mPyRzwT7/YmNafYVxKHJLEiJvA==
Date: Wed, 28 Jan 2026 14:55:37 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>, Tom Rini
 <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Parvathi Pudi <parvathi@couthit.com>,
 Basharath Hussain Khaja <basharath@couthit.com>, Paul Barker
 <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v4 04/10] configs: am335x_evm: Enable SPL_OPTIMIZE_INLINING
Message-ID: <20260128145537.0d0a3db2@kmaincent-XPS-13-7390>
In-Reply-To: <20260127-topic-am33-evm-oftree-v2026-01-v4-4-0dadb0710ce7@baylibre.com>
References: <20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com>
 <20260127-topic-am33-evm-oftree-v2026-01-v4-4-0dadb0710ce7@baylibre.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Tue, 27 Jan 2026 17:48:18 +0100
"Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com> wrote:

> Enable SPL inline optimization to shrink the size. After enabling
> OF_UPSTREAM the size is otherwise too big. Enable it before enabling
> OF_UPSTREAM to maintain bisect ability.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
