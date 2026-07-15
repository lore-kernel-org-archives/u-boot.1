Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FA6C4450A
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 05:23:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24A7D84AD7;
	Wed, 15 Jul 2026 07:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=karo-electronics.de header.i=@karo-electronics.de header.b="fKNrRa1I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06BED84ADB; Wed, 15 Jul 2026 07:23:17 +0200 (CEST)
Received: from dd54918.kasserver.com (dd54918.kasserver.com [85.13.167.58])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51FC384AC5
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=LW@KARO-electronics.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karo-electronics.de;
 s=kas202603021246; t=1784092994;
 bh=Vl+I/NqvPtgwxOA5nnRTuknZRudW3KU9usSSgKMkNes=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=fKNrRa1IIb00GxcuFJ1qxaYaA51sm1teGgvNpZDcLh+4vzNmlvzgUGVWdUqLPskhz
 NEkuSG7DytAT9GjxsGLhAT5ShiPXnIG4M8lgKClfhv9EnloCoh2M6spssUHXAzS/ca
 UVyiBkOoBFdSLmHmyfEYzt48YJk/6EJ0uWMsGg+tEXAAD/3qtb0Hh6exl072kJ0VD1
 ZCaOtsaP/ay4fwwA2YK7mDBjKAwPmpzDP2hpr5GmfZ5/EISdbj760xLgfkxLjcpjur
 0hy0n8jAR6oZK1AlS7kJfpEFti4PdqqwOrVHG6KWz2aohWdy/3lpiQ9S8uVvK1L3Fm
 T6JRhb89NID6Q==
Received: from ipc1.ka-ro (unknown [89.1.81.74])
 by dd54918.kasserver.com (Postfix) with ESMTPSA id D114D772865F;
 Wed, 15 Jul 2026 07:23:13 +0200 (CEST)
Date: Wed, 15 Jul 2026 07:23:13 +0200
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Petr =?UTF-8?B?QmVuZcWh?= <Petr.Benes@ysoft.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: Regression in f_fastboot due to commit 6a92e9827650 ("usb:
 ci_udc: Check ci_ep->desc before use")
Message-ID: <20260715072313.44c3f2b1.LW@KARO-electronics.de>
In-Reply-To: <DB9PR04MB8219B75AE3A1D4D750B7C3B880FD2@DB9PR04MB8219.eurprd04.prod.outlook.com>
References: <20260708071255.13f58e98.LW@KARO-electronics.de>
 <875x2okxcs.fsf@kernel.org>
 <DB9PR04MB8219B75AE3A1D4D750B7C3B880FD2@DB9PR04MB8219.eurprd04.prod.outlook.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ---
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

Hi,

On Fri, 10 Jul 2026 21:27:48 +0000 Petr Bene=C5=A1 wrote:
> Hello Lothar and Mattijs,
>=20
> I hope web outlook doesn't render my response unreadable.
> ________________________________________
> From: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Sent: Thursday, July 9, 2026 17:15
> To: Lothar Wa=C3=9Fmann; u-boot@lists.denx.de
> Cc: Petr Bene=C5=A1
> Subject: Re: Regression in f_fastboot due to commit 6a92e9827650 ("usb: c=
i_udc: Check ci_ep->desc before use")
>=20
> Hi Lothar,
>=20
> On Wed, Jul 08, 2026 at 07:12, Lothar Wa=C3=9Fmann <LW@KARO-electronics.d=
e> wrote:
>=20
> > Hi,
> >
> > commit 6a92e9827650 ("usb: ci_udc: Check ci_ep->desc before use") has
> > the side effect that an empty buffer is being passed on to
> > rx_handler_command() in drivers/usb/gadget/f_fastboot.c upon
> > termination of a fastboot session which leads to a
> > 'command  not recognized' error message being printed on the console. =
=20
>=20
> Thank you for reporting this.
>=20
> >
> > Obviously without the commit the offending USB request had been silently
> > dropped but is now delivered to the upper levels. =20
>=20
> Well, it was not silently dropped in case of the ethernet gadget, it was =
silently corrupting memory.
>=20
> >
> > I'm not sure what the correct fix would be.
> > Should the fastboot driver ignore the empty command buffer or should
> > the "Moreover, the patch gets rid of possible outstanding requests
> > if the endpoint's state changes to disabled." part of the commit be
> > reverted? =20
>=20
> Hmm, maybe I got it wrong. The endpoint got disabled, so what should happ=
en with requests?
>=20
> linux/usb/gadget.h reads:
>=20
>  * @complete: Function called when request completes, so this request and
>  *      its buffer may be re-used.
>  *      Reads terminate with a short packet, or when the buffer fills,
>  *      whichever comes first.  When writes terminate, some data bytes
>  *      will usually still be in flight (often in a hardware fifo).
>  *      Errors (for reads or writes) stop the queue from advancing
>  *      until the completion function returns, so that any transfers
>  *      invalidated by the error may first be dequeued.
>=20
> Petr, did you observe similar behaviour with the ums gadget?
>=20
> I didn't see any wrongdoing of the ethernet gadget.
> >
> >
I found a solution for the problem. The ci_udc driver checks the req
status for -EINPROGRESS in several places, but does never initialize the
status to that value.

This patch alleviates the problem:
Index: a/drivers/usb/gadget/ci_udc.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -530,6 +530,9 @@ static void ci_ep_submit_next_request(st
 	head =3D ci_get_qh(num, in);
=20
 	ci_req =3D list_first_entry(&ci_ep->queue, struct ci_req, queue);
+
+	ci_req->req.status =3D -EINPROGRESS;
+
 	len =3D ci_req->req.length;
=20
 	head->next =3D (unsigned long)item;
@@ -753,6 +756,9 @@ static void handle_ep_complete(struct ci
 		ci_ep_submit_next_request(ci_ep);
=20
 	ci_req->req.actual =3D ci_req->req.length - len;
+	if (ci_req->req.status =3D=3D -EINPROGRESS)
+		ci_req->req.status =3D 0;
+
 	ci_debounce(ci_req, in);
=20
 	DBG("ept%d %s req %p, complete %x\n",

This is similar to how the Linux driver behaves.

I tested with fastboot and mass-storage gadget.


Lothar Wa=C3=9Fmann
