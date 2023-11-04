Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FE1C4167B
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 12:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEBBB87116;
	Sat,  4 Nov 2023 13:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="length tag value exceeds body size" (2048-bit key; unprotected) header.d=freemail.hu header.i=@freemail.hu header.b="yUTXI7Dv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A07870A4; Sat,  4 Nov 2023 11:45:27 +0100 (CET)
Received: from web-out.onbox.hu (fmfe37.freemail.hu [46.107.16.242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C3978708D
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 11:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=egyszeregy@freemail.hu
X-fm-smtp-source: yes
Received: from localhost (localhost [80.98.74.198])
 by web-out.onbox.hu (Postfix) with SMTP id 4SMvQH2zrJznNq;
 Sat,  4 Nov 2023 11:45:11 +0100 (CET)
Date: Sat, 4 Nov 2023 10:45:11 +0000 (GMT)
From: =?utf-8?Q?Sz=C5=91ke_K=C3=A1lm=C3=A1n_Benjamin?= <egyszeregy@freemail.hu>
Message-ID: <A2A0QA.IjxBof9kZfpi.ROrtIN5Y6l3bqrOxHBXX@freemail.hu>
MIME-Version: 1.0
Subject: Re: [PATCH] pico-imx7d: Remove board_phy_config()
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@gmail.com>
X-AccountId: 2510275
X-Originating-Ip: 80.98.74.198
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1699094711; 
 s=20181004; d=freemail.hu;
 h=Date:From:Message-ID:MIME-Version:Content-Type:Subject:To;
 l=1585; bh=vGcHpsthJB7UmSVG6E9YvsJkhUG2guvNDcUd0W6D0xs=;
 b=yUTXI7DvDAHl7bi0/Tdt/YCzcRJBr6BFhb1gkxZ56yaXZyv7ZBmY+PMF6X9FeNa1
 8z54GZj+g+5i73mTbA20dX4s93OZk29b+kIvQeIxIYxdyN8Eh03SsdGVivOAjO68hE4
 cMk+aI0oUApL/s3Obrl6h3O3VhzTwvu1AOnK/KyGCMTq9gX3bDvqa159oh7e8eRFbu+
 4qRfRyx2DhsnikzE690A98Fwe3bsAnJhlCZvB2TyKlJ7HIl7Q3HJ/uhg9WzfK5tsFRo
 VvrnycFMQYOGEieWSl/JvTG1+QRgpor6s/9oht+vQksk8QZIOfHH5fFFr1Yn/FftDb0
 ananGXNzFw==
X-Mailman-Approved-At: Sat, 04 Nov 2023 13:20:38 +0100
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Other pico SoMs still has board_phy_config() also, you should remove it fro=
m them, too.pico-imx8mq:=C2=A0https://github.com/u-boot/u-boot/blob/master/=
board/technexion/pico-imx8mq/pico-imx8mq.c#L111pico-imx6ul:=C2=A0https://gi=
thub.com/u-boot/u-boot/blob/master/board/technexion/pico-imx6ul/pico-imx6ul=
.c#L110pico-imx6:=C2=A0https://github.com/u-boot/u-boot/blob/master/board/t=
echnexion/pico-imx6/pico-imx6.c#L314
