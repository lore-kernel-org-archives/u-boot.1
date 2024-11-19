Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5782BD6C299
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 20:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5D18890D5;
	Tue, 19 Nov 2024 21:35:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="mfGHCCg/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 142968907E; Tue, 19 Nov 2024 21:35:37 +0100 (CET)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB622895A2
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 21:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.bonnefille@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A01FC20002;
 Tue, 19 Nov 2024 20:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1732048534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PjjmsR1/ziZ+Zo/VmmTcKpUZpXyzOlvgnKbGi4LjsDg=;
 b=mfGHCCg/LNKAL3yL+tKumHX05i5HFAkj8uoHEY1ym2H4lWqDpXSwubOXY47WkZTObsTCJr
 nh33CXfjxFffgnF51MUPOFrYOAOyWwd0rJlWDjjTHpOGLXosAbbC2QavHsx3NP2/fxUfVG
 c56F7iAtwQ7WGXCFO7LcuZ+fPYwkF8/ohc3X+Y9uyCiF8AYfrVWgbm1/LmIxS17uztqV3X
 gL+nBaXrpiv7IdgYIYSa1E3e6mqbuDxXN0uH+kGXsPy1p2UxbxwVpeWnUhFtfHNEE5uK0W
 eJKa+JhYrc7tLCGFMIEJB6PV0hZDXJvv77kvehGDrYB0vvZHMCKZtTbFcy5kAw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Nov 2024 21:35:32 +0100
Message-Id: <D5QFYNC0TNVT.11K9SURYSS7W1@bootlin.com>
Cc: "Peng Fan" <peng.fan@nxp.com>, "Jaehoon Chung" <jh80.chung@samsung.com>,
 "Tom Rini" <trini@konsulko.com>, "Rick Chen" <rick@andestech.com>,
 "Kongyang Liu" <seashell11234455@gmail.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, =?utf-8?q?Miqu=C3=A8l_Raynal?=
 <miquel.raynal@bootlin.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/3] riscv: dts: sophgo: add device tree for LicheeRV Nano
From: "Thomas Bonnefille" <thomas.bonnefille@bootlin.com>
To: "Leo Liang" <ycliang@andestech.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241112-licheerv-nano-v1-0-bf75d1eb560e@bootlin.com>
 <20241112-licheerv-nano-v1-2-bf75d1eb560e@bootlin.com>
 <ZzsQb-QO2YrffjeB@swlinux02>
In-Reply-To: <ZzsQb-QO2YrffjeB@swlinux02>
X-GND-Sasl: thomas.bonnefille@bootlin.com
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

On Mon Nov 18, 2024 at 11:01 AM CET, Leo Liang wrote:
> On Tue, Nov 12, 2024 at 03:57:37PM +0100, Thomas Bonnefille wrote:
> > [EXTERNAL MAIL]
> >=20
> > Import a slightly modified version of the LicheeRV Nano and SG2002
> > device trees from the Linux Kernel. The current supported IPs are UART,
> > MMC, Timer, PLIC and CLINT.
> >=20
> > Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > ---
> >  arch/riscv/dts/Makefile                   |  1 +
> >  arch/riscv/dts/sg2002-licheerv-nano-b.dts | 45 +++++++++++++++++++++++=
++++++++
> >  arch/riscv/dts/sg2002.dtsi                | 34 +++++++++++++++++++++++
> >  3 files changed, 80 insertions(+)
>
> Hi Thomas,
>
> Could we switch to use OF_UPSTREAM ?
>

Hello Leo,

Thank you for your review, I have a question though.

The LicheeRV Nano device tree isn't upstreamed yet. It's just in the
Sophgo SoC maintainer tree and should be merged in v6.13 so in ~10 weeks.
Can I keep it out of dts/upstream for the moment or should I merge it by
hand before ?
