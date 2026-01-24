Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6626D7237B
	for <u-boot@archiver.kernel.org>; Sun, 25 Jan 2026 01:36:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F049D83AEE;
	Sun, 25 Jan 2026 02:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="cBuY4NLd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F63D83BFE; Sat, 24 Jan 2026 19:35:35 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCB4783B72
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 19:35:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPA id 8008310DB2C; Sat, 24 Jan 2026 19:35:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1769279731;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=hXtPPcz6p6yaRtohnYpV5HvrYniwH+d+mWXUCwQquHg=;
 b=cBuY4NLdG/QcQZfjRaHBYsUGQTDUQYxDZpSREDKP0IMK1IHy+tBGYoNQ1Co+ct9FtS4NOi
 1oZjYj42CF55rYQsymQKTk+EpuITn2DNIH/zoTmrjYkAXwYJsaD9bwrPSmFm5S4GgN56zs
 m+O4U1S6kehqcF/ooOM2SXeOLEYFzv+V0r0glzvAxLasphWe6Fl6NMliE1GZyzz/lyKB9h
 FdG8i4OpAIwo503WhpP3oB/m5B6lzZU6qxM2jx0/DutQCOpIi9r+wMeuMmQWaIQPe6K4gR
 F+RpSDygGvdqklk8EAK5JPOM/CMEdJJQ/E+0TwNf/dbL0XNJc1iCqDDXo8E+bg==
From: "Fabio Estevam" <festevam@nabladev.com>
In-Reply-To: <06bd1e1cee6a2c3d8fc408330279e093c734f487.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
References: <d7d22e35540857e9726f4b435a73a1435aa4fe37.camel@gmail.com>
 <20260123150129.GK3416603@bill-the-cat>
 <06bd1e1cee6a2c3d8fc408330279e093c734f487.camel@gmail.com>
Date: Sat, 24 Jan 2026 19:35:30 +0100
Cc: "Tom Rini" <trini@konsulko.com>, u-boot@lists.denx.de,
 vitor.soares@toradex.com, n-francis@ti.com, b-padhi@ti.com, afd@ti.com,
 anshuld@ti.com, festevam@denx.de
To: "Vitor Soares" <ivitro@gmail.com>
MIME-Version: 1.0
Message-ID: <8a18cf34-7f00-f909-4094-0a498d9e5922@nabladev.com>
Subject: =?utf-8?q?Re=3A?= Toradex Verdin AM62 boot failure on recent master
User-Agent: SOGoMail 5.12.4
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None
X-Mailman-Approved-At: Sun, 25 Jan 2026 02:36:18 +0100
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

Hi Vitor,

On Saturday, January 24, 2026 13:36 -03, Vitor Soares <ivitro@gmail.com=
> wrote:
=20
> +Cc Fabio - this should resolve your boot failure as well.
>=20
> [1]
> https://lore.kernel.org/u-boot/1e1f2e09-bfb7-4c7d-abd6-25a79271f256@m=
ailbox.org/

Thanks for the suggestion, but this does not fix the boot failure on RV=
1103.

Tom's proposal fixes it:

https://lore.kernel.org/u-boot/CAOMZO5DVFO=3DA6g1CWOrRbqy4VNgL+VcUw0Q5p=
gELXm30puGz4w@mail.gmail.com/

Thanks,

Fabio Estevam
--=20
Nabla Software Engineering GmbH	Managing Director: Stefano Babic
Phone: +49 821 45592596 	E-Mail: festevam@nabladev.com

