Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2911BE80AAB
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 13:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C79186DD6;
	Wed, 27 Sep 2023 15:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="jhOX10KI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16AEE86DB9; Wed, 27 Sep 2023 15:59:11 +0200 (CEST)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82B9C86DD6
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 15:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 090681C000C;
 Wed, 27 Sep 2023 13:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1695823147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TlqrE/+3UrYSu7aXS2SFlilWNCOVPTsKaVE+2WiGRm8=;
 b=jhOX10KIRQJnx0g72JCy4duidIIHNFwqfPNMq8klZZbHKmuXKB4x8j7In/eNUntNB5ceLt
 kBHh/Zv6iXQVs2TsDdh7LM/amwsa6jAC7EzPbLsxbRmQos7IUs7k2b7esYvt1i11yzPe/A
 /vdPxi209/v1YC+smvjHf2SLGRhOM/pXhe72xE1Wf6mzU1VH7mx+oQVkeaQx8aowgklYDL
 qUrwqFct/pKgsjV5oUILmLXYno36iI6wATIzXKdT5Nd7pylGoKWyK1IKPZmn1jin4g3w2w
 uQtNSTwhVxBPgK5cwvB0KdDKacUjcvbpLeFO38HYofdzIv9ZnZeykvFLu1tU7w==
Date: Wed, 27 Sep 2023 15:59:01 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Angus Ainslie <angus@akkea.ca>, Dmitrii Merkurev <dimorinny@google.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>, Kever Yang
 <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, Nishanth
 Menon <nm@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>, Stefan Roese
 <sr@denx.de>, kernel@puri.sm
Subject: Re: [PATCH v2 01/17] dm: usb: udc: Factor out plain udevice handler
 functions
Message-ID: <20230927155901.10c5d520@xps-13>
In-Reply-To: <20230922120012.6e24645f@xps-13>
References: <20230901095003.352930-1-marex@denx.de>
 <20230922120012.6e24645f@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
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

Hi Marek,

miquel.raynal@bootlin.com wrote on Fri, 22 Sep 2023 12:00:12 +0200:

> Hi Marek,
>=20
> I'm answering here as there is no cover letter. Just to let you know
> I'm still concerned by the series and want to test it but did not had
> the time to do so recently. Hopefully next week.

The series looks good to me and works as well on a Beagle Bone Black
with no visible functional changes regarding the use of the UDC. The
whole series is:

Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>

By the way, following your initial series there have been three
followup patches trying to improve a little bit the doc, one got merged
and two others were delegated to you:
https://patchwork.ozlabs.org/project/uboot/list/?series=3D367635

They are almost 2 months old now, would you mind acking or merging
them so both your initial USB gadget rework and the additional
(related) doc can be in the same release please?

Thanks,
Miqu=C3=A8l
