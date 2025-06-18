Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7E5C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 09:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50FA682C2F;
	Wed, 18 Jun 2025 11:36:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="ZAsJEy4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FE9682C55; Wed, 18 Jun 2025 11:36:35 +0200 (CEST)
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk
 [188.40.203.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F2DB82BCD
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 11:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=codethink.co.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
 :Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=saOBxq4WpGNGEp9h1AgKINA2sNmmx90JVCvURzVMYL8=; b=ZAsJEy4ld2icq0zXrhw/2URby8
 JO4xbU4bp7gQ141S2Y4HXxZY2bc/3+kdZnVV9C1+RpL5HQqlAPvLB7rPrLxYTqWuA05Q9wTbpzMbw
 MRQFCeAI/X9i3Paqa1AOzfJ62iSPCA85XzoEqL0e9MzOY+fBWa1jV2ELMcAWBX+4QovoRllQZYg/E
 72MRf7079+YyA7Cfno0Z9NNHYMlfCgcrG/4rO8mHMJo1SAEMR0JATcqKXyMklQjORG19sqbspuJGj
 tCnRzh+RZmpr5IQbERYXAeJE1m/2ult2HLzupHUrVGKkQt5QhY8CROEmbkDi+Ie9JsaXxJILUhzJs
 1nN+8APQ==;
Received: from [167.98.27.226] (helo=[10.35.4.135])
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uRpDU-00GDvu-0W; Wed, 18 Jun 2025 10:36:24 +0100
Message-ID: <43d431db9b68b9fffff160abba13b894b2340ad4.camel@codethink.co.uk>
Subject: Re: [PATCH v2 0/4] USB-PD TCPM improvements
From: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
To: Sebastian Reichel <sebastian.reichel@collabora.com>, Marek Vasut	
 <marex@denx.de>, u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Soeren Moch <smoch@web.de>
Cc: Tim Harvey <tharvey@gateworks.com>, Philipp Tomsich	
 <philipp.tomsich@vrull.eu>, Anand Moon <linux.amoon@gmail.com>, Maxim
 Kiselev	 <bigunclemax@gmail.com>
Date: Wed, 18 Jun 2025 10:36:23 +0100
In-Reply-To: <20250226184506.64114-1-sebastian.reichel@collabora.com>
References: <20250226184506.64114-1-sebastian.reichel@collabora.com>
Organization: Codethink
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
MIME-Version: 1.0
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

Hi folks

On Wed, 2025-02-26 at 19:44 +0100, Sebastian Reichel wrote:
> Hi,
>=20
> I have a couple of fixes/improvements for the TCPM code. Three are fixing
> actual problems I noticed on the Rock 5B, which prevented booting up the
> system. One of them simply adds an error print before potentially committ=
ing
> hara-kiri by triggering a hard reset, which helps people understanding
> why their boards reset themself in case there are more problems. I've
> recently added the same print to the kernel TCPM code.

Thanks, any reason this series hasn't landed yet?

Anyway, I can confirm this tremendously improves the situation.

Whole series:

Tested-by: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk> # rock5b

> Changes since PATCHv1:
> =C2=A0* https://lore.kernel.org/u-boot/20241031175404.114773-5-sebastian.=
reichel@collabora.com/
> =C2=A0* rebased to v2025.04-rc3 (no changes needed)
>=20
> Greetings,
>=20
> -- Sebastian
>=20
> Sebastian Reichel (4):
> =C2=A0 usb: tcpm: improve handling of some power-supplies
> =C2=A0 usb: tcpm: avoid resets for missing source capability messages
> =C2=A0 usb: tcpm: print error on hard reset
> =C2=A0 usb: tcpm: improve data role mismatch error recovery
>=20
> =C2=A0drivers/usb/tcpm/tcpm-internal.h |=C2=A0 1 +
> =C2=A0drivers/usb/tcpm/tcpm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 95 ++++++++++++++++++++++++++++----
> =C2=A02 files changed, 85 insertions(+), 11 deletions(-)

Cheers

Marcel
