Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E424BC4451C
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 07:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F4E6808C0;
	Wed, 22 Jul 2026 07:24:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GgD-d2HoUfDP; Wed, 22 Jul 2026 07:24:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B34180D2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784705091;
	bh=riSNxDUOV6de6/6EkBaDE+dYVxew+n5q6WCBlRYZEAo=;
	h=To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=lCrt67bKD9ZMyaHwWdV7EOWIClKWi2v159lNdFIJiZlwJNeQtWQPKmYq3yvsxxz8X
	 VOXDvUeDQG5wC/coXv/t3RXmOrPxrrHeq8IEbc1wzvfudaZyITKlaVp0xx3W5zOqbQ
	 vbNjUkAKlVq7oq11Eg7OVtTEFYyHmO3AfG24/BnfqaWQe85f2NQRMl/qrircU2T/qW
	 LvPEsi7M0FZdmM9IQ65ZyIc5vJ4GE2ZUwKCZI+ZbirRbtV7T4BMWeEa9Dvkjtix8Cz
	 aw4k/VOGU5qL6G4wVha+b57dJyP5sqEoQmXLlMw71crPfbDTLx79jQbfTTLMu50ImL
	 EaYAWJdkLKBcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B34180D2D;
	Wed, 22 Jul 2026 07:24:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F0FF10A3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:24:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 40FF1808C0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:24:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BXJrS3goAY8b for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:24:49 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 05FC880C79
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 05FC880C79
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 05FC880C79
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:24:48 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7458D848BA; Wed, 22 Jul 2026 09:24:47 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEDC1803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 09:24:44 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4557340A2D;
 Wed, 22 Jul 2026 07:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856251F000E9;
 Wed, 22 Jul 2026 07:24:42 +0000 (UTC)
To: Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Petr
 =?utf-8?Q?Bene=C5=A1?= <Petr.Benes@ysoft.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Regression in f_fastboot due to commit 6a92e9827650 ("usb:
 ci_udc: Check ci_ep->desc before use")
In-Reply-To: <20260715072313.44c3f2b1.LW@KARO-electronics.de>
References: <20260708071255.13f58e98.LW@KARO-electronics.de>
 <875x2okxcs.fsf@kernel.org>
 <DB9PR04MB8219B75AE3A1D4D750B7C3B880FD2@DB9PR04MB8219.eurprd04.prod.outlook.com>
 <20260715072313.44c3f2b1.LW@KARO-electronics.de>
Date: Wed, 22 Jul 2026 09:24:40 +0200
Message-ID: <87ecgvij0n.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784705083;
 bh=riSNxDUOV6de6/6EkBaDE+dYVxew+n5q6WCBlRYZEAo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=dGQYme+KgPlWWJGpRWh5QS5KhPV0hADDjSVgT0Y9h7NW1YRdByUJm76gI8I3kx9IQ
 7Qu4DFU5PWYpk4zlhZ6P+AhFgwA2/g77dDVYSsFj0hbZ2xaZz9w8wa+1HlAIkEw/xk
 ptbxJMXzwsox66aFHfvI5oS7nEMgV6IXJRKWTBXGP2a0Haa9PU7nqiXBmIBTVZpMR8
 1XV92C4UZoL+qQTObZTp6xcERjBvKi35b0OJdwK6zdQVU9eydXL7BimKFkbIAWhDvo
 5/8h576XlMycF5VtNQC1h8P6fajc03toCKewN8S2EAecQAQUKFC0Vu5iZMhOpLe+Yw
 6a6ojbm1Za+Fw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dGQYme+K
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="dGQYme+K"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Mattijs Korpershoek via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Lothar,

On Wed, Jul 15, 2026 at 07:23, Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>=
 wrote:

> Hi,
>
> On Fri, 10 Jul 2026 21:27:48 +0000 Petr Bene=C5=A1 wrote:
>> Hello Lothar and Mattijs,
>>=20
>> I hope web outlook doesn't render my response unreadable.
>> ________________________________________
>> From: Mattijs Korpershoek <mkorpershoek@kernel.org>
>> Sent: Thursday, July 9, 2026 17:15
>> To: Lothar Wa=C3=9Fmann; u-boot@lists.denx.de
>> Cc: Petr Bene=C5=A1
>> Subject: Re: Regression in f_fastboot due to commit 6a92e9827650 ("usb: =
ci_udc: Check ci_ep->desc before use")
>>=20
>> Hi Lothar,
>>=20
>> On Wed, Jul 08, 2026 at 07:12, Lothar Wa=C3=9Fmann <LW@KARO-electronics.=
de> wrote:
>>=20
>> > Hi,
>> >
>> > commit 6a92e9827650 ("usb: ci_udc: Check ci_ep->desc before use") has
>> > the side effect that an empty buffer is being passed on to
>> > rx_handler_command() in drivers/usb/gadget/f_fastboot.c upon
>> > termination of a fastboot session which leads to a
>> > 'command  not recognized' error message being printed on the console.=
=20=20
>>=20
>> Thank you for reporting this.
>>=20
>> >
>> > Obviously without the commit the offending USB request had been silent=
ly
>> > dropped but is now delivered to the upper levels.=20=20
>>=20
>> Well, it was not silently dropped in case of the ethernet gadget, it was=
 silently corrupting memory.
>>=20
>> >
>> > I'm not sure what the correct fix would be.
>> > Should the fastboot driver ignore the empty command buffer or should
>> > the "Moreover, the patch gets rid of possible outstanding requests
>> > if the endpoint's state changes to disabled." part of the commit be
>> > reverted?=20=20
>>=20
>> Hmm, maybe I got it wrong. The endpoint got disabled, so what should hap=
pen with requests?
>>=20
>> linux/usb/gadget.h reads:
>>=20
>>  * @complete: Function called when request completes, so this request and
>>  *      its buffer may be re-used.
>>  *      Reads terminate with a short packet, or when the buffer fills,
>>  *      whichever comes first.  When writes terminate, some data bytes
>>  *      will usually still be in flight (often in a hardware fifo).
>>  *      Errors (for reads or writes) stop the queue from advancing
>>  *      until the completion function returns, so that any transfers
>>  *      invalidated by the error may first be dequeued.
>>=20
>> Petr, did you observe similar behaviour with the ums gadget?
>>=20
>> I didn't see any wrongdoing of the ethernet gadget.
>> >
>> >
> I found a solution for the problem. The ci_udc driver checks the req
> status for -EINPROGRESS in several places, but does never initialize the
> status to that value.
>
> This patch alleviates the problem:
> Index: a/drivers/usb/gadget/ci_udc.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/usb/gadget/ci_udc.c
> +++ b/drivers/usb/gadget/ci_udc.c
> @@ -530,6 +530,9 @@ static void ci_ep_submit_next_request(st
>  	head =3D ci_get_qh(num, in);
>=20=20
>  	ci_req =3D list_first_entry(&ci_ep->queue, struct ci_req, queue);
> +
> +	ci_req->req.status =3D -EINPROGRESS;
> +
>  	len =3D ci_req->req.length;
>=20=20
>  	head->next =3D (unsigned long)item;
> @@ -753,6 +756,9 @@ static void handle_ep_complete(struct ci
>  		ci_ep_submit_next_request(ci_ep);
>=20=20
>  	ci_req->req.actual =3D ci_req->req.length - len;
> +	if (ci_req->req.status =3D=3D -EINPROGRESS)
> +		ci_req->req.status =3D 0;
> +
>  	ci_debounce(ci_req, in);
>=20=20
>  	DBG("ept%d %s req %p, complete %x\n",
>
> This is similar to how the Linux driver behaves.
>
> I tested with fastboot and mass-storage gadget.

Thank you for investigating this further.

Ye Li <ye.li@nxp.com> has send a similar patch which just got applied here:

      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/=
b79147bbd47cd2d50836dc0a57376f4820663637

Can you please check if that works for you as well?

>
>
> Lothar Wa=C3=9Fmann
