Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CD3C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 10:40:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFDC08803A;
	Thu, 16 May 2024 12:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="fEwJ6iTC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4812C8825A; Thu, 16 May 2024 12:40:51 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [217.70.183.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C90A287F65
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 12:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E076E240002;
 Thu, 16 May 2024 10:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1715856048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GUd1IIrTxnFEQqb0lkfzlNza+xGpU7PIM7N6SgUuF7U=;
 b=fEwJ6iTCy89a4vQstBb0h5/AjSC3t3K3r4tUAAI2mdlkLCUcPOjbnL5fsluKmxXQ2V1uZn
 E/CFkRzkBps3eafl6+YjhZzx8BQ0h2fYwzeIiJlTC63tsl7gGLhuApDMbpLQJUb3Y/KBBo
 tMlqpTJsQuZkM3bRrCMyGa576I/OcaFsrlRm/bDUmpfvgq0EHNBHWO6bECTyA6GUOlth+n
 Wduh7MWFwlcdfMNDycnXa1/li3Q+LU9odKhNAxwBkmyfZNp71Ts4BMFu9RjCejl9NEfYbO
 mgUy4xA1oCcDYltDvRqp9MAw6AGh9TM3Tt0qbIFQ/Vgl4/VamTO1ByaEzfrfCA==
Date: Thu, 16 May 2024 12:40:47 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Adam Ford <aford173@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v3] tpm: display warning if using gpio reset with TPM
Message-ID: <20240516124047.0fe6a6e9@xps-13>
In-Reply-To: <ZkXV6wBiN/oRfUH+@trex>
References: <20240515232138.3065987-1-tharvey@gateworks.com>
 <20240516090950.373d304c@xps-13> <ZkXNN4I/gFgjD3oP@trex>
 <20240516113414.49fe3b9f@xps-13> <ZkXV6wBiN/oRfUH+@trex>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
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


> > > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io> =20
> >=20
> > You cannot send your SoB like this. SoB means you are carrying some
> > code which complies with the license, etc.
> >=20
> > Either you were part of the original writing and want to be credited
> > for that (you can be the author and first SoB, or suggest Tim to use
> > Co-developed-by). Or you reviewed the change (Reviewed-by), you tested
> > the change (Tested-by), or you are maintainer/responsible for some part
> > that is touched and you agree with the change (Acked-by). =20
>=20
> right, however there is some lenience in the process: some projects accept
> the signed off, some others add the acked or reviewed and so on...
>=20
> but I agree with you and I certainly do not need/want/expect to be
> credited for this work. it is all good on my end :)
>=20
> >=20
> > Thanks,
> > Miqu=C3=A8l =20
>=20
> btw you could have simply ignored my note btw : notice the "if needed"
> part in my response. for reference, I noticed my name in CC, checked the
> change, thought it was a good idea and tried to move it a long - just
> chose the wrong tag for sure...

And this is likely a good habit :) But now you need to send your
Reviewed-by because these tags are usually collected by the tools. If
you don't write it properly, there are very little chances it will
ever be picked-up.

Thanks,
Miqu=C3=A8l
