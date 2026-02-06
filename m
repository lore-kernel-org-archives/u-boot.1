Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B9BEE20A6
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 14:19:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 398BF838FA;
	Fri,  6 Feb 2026 15:19:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="C8oPxOKT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51E36836D3; Fri,  6 Feb 2026 15:19:52 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F15F7836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 15:19:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 77F4D4E4243B;
 Fri,  6 Feb 2026 14:19:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4ED3160729;
 Fri,  6 Feb 2026 14:19:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8A765119D1EBA; Fri,  6 Feb 2026 15:19:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1770387588; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=DVKUmYAUxq034c0s+hjp+sNrZ8BUvzPqMUjGSTDcR+A=;
 b=C8oPxOKT81McSUwED8VVB2ID1LGnZBCyajWGBMDduJd/hf4osH1Cf09ZZ1MBnOkYccaoJB
 2xSg1ZpY/p1iMbZBo84mF2AI/xRf3mNDU+zXe8HURZi5Qj02tf+hV50NX/bydcZ2vhdejl
 yC6orMegSq66Dfs/T7FbEAwpc0P0JOjEvESqEWzl+uaTcxMGsxJJvecvlRvXikAqw51LYv
 6zFt3VFc9kDhKLH4SBATDw9Orn9B7xao80pEWY3qNC054AnQDJEj0E13FQHwdUrdtg5qba
 p6lJwJ7MCXKOPATlb3hscTqlBgSM4pycautJ7w0myd2hBpggX3gCBgOP6vM8pw==
Date: Fri, 6 Feb 2026 15:19:45 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 thomas.petazzoni@bootlin.com, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH] fwu-mdata: Allow multiple metadata storage drivers to
 be enabled
Message-ID: <20260206151945.4448af9d@kmaincent-XPS-13-7390>
In-Reply-To: <20260114144918.GC3416603@bill-the-cat>
References: <20260114095654.736511-1-kory.maincent@bootlin.com>
 <20260114144918.GC3416603@bill-the-cat>
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

On Wed, 14 Jan 2026 08:49:18 -0600
Tom Rini <trini@konsulko.com> wrote:

> On Wed, Jan 14, 2026 at 10:56:53AM +0100, Kory Maincent wrote:
>=20
> > Change the Kconfig from a "choice" to a conditional block, allowing
> > multiple FWU metadata storage drivers to be selected simultaneously
> > instead of being mutually exclusive.
> >=20
> > This enables systems with FWU metadata on different storage types
> > (e.g., both GPT-partitioned block devices and MTD devices) to have
> > both drivers compiled in. The board can then select the appropriate
> > driver at runtime based on the devicetree description.
> >=20
> > The change converts FWU_MDATA to a menuconfig and replaces the
> > "choice/endchoice" block with "if FWU_MDATA/endif", making
> > FWU_MDATA_GPT_BLK default to 'y' for backward compatibility.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =20
>=20
> Reviewed-by: Tom Rini <trini@konsulko.com>

Hello,

Any news on this patch? Does something prevent it to be merged?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
