Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772B8C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 15:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2D9884B88;
	Thu,  9 Jul 2026 17:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ERQwyti0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 663A784B8D; Thu,  9 Jul 2026 17:15:54 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E337584B77
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 17:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 24774429DA;
 Thu,  9 Jul 2026 15:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA911F000E9;
 Thu,  9 Jul 2026 15:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783610150;
 bh=FeCvKEfiosY4DqhXX8tVKTx7ktJsK9xNBs+aCX1cxXg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=ERQwyti0DIgQrNotKBsZfe4UbnOvEPPfnu/YbZSW3KpY5+xNMii02iZZFvRYUcVAi
 jrF0z8ZQrr1pKRBxchO+uBjpnioJ3anC4GicrGEE3xruuubulDlB5ayxYGm92jKZZv
 du7wcMPcGP3yBdHm+UylE8KsyMuCu/AQPm+6LWapx+cr/hzIBjW2R5eaoouAa6zc7u
 O20qxg9wE/sAB3PdelcXTKugw8FszEzfAAuREma0TKTR9NyrhiiSaCycFc+cgDc1Zg
 F1rGeeXMGRYlRLqsiFY+Uj7o1XPk4DgkXK5+yFe6jHmtmlc8e8uMC3SuMmSZhqLnE2
 nzve14qud6kEg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@KARO-electronics.de>,
 u-boot@lists.denx.de
Cc: Petr =?utf-8?Q?Bene=C5=A1?= <petr.benes@ysoft.com>
Subject: Re: Regression in f_fastboot due to commit 6a92e9827650 ("usb:
 ci_udc: Check ci_ep->desc before use")
In-Reply-To: <20260708071255.13f58e98.LW@KARO-electronics.de>
References: <20260708071255.13f58e98.LW@KARO-electronics.de>
Date: Thu, 09 Jul 2026 17:15:47 +0200
Message-ID: <875x2okxcs.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Lothar,

On Wed, Jul 08, 2026 at 07:12, Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>=
 wrote:

> Hi,
>
> commit 6a92e9827650 ("usb: ci_udc: Check ci_ep->desc before use") has
> the side effect that an empty buffer is being passed on to
> rx_handler_command() in drivers/usb/gadget/f_fastboot.c upon
> termination of a fastboot session which leads to a
> 'command  not recognized' error message being printed on the console.

Thank you for reporting this.

>
> Obviously without the commit the offending USB request had been silently
> dropped but is now delivered to the upper levels.
>
> I'm not sure what the correct fix would be.
> Should the fastboot driver ignore the empty command buffer or should
> the "Moreover, the patch gets rid of possible outstanding requests
> if the endpoint's state changes to disabled." part of the commit be
> reverted?

Petr, did you observe similar behaviour with the ums gadget?

>
>
> Lothar Wa=C3=9Fmann
