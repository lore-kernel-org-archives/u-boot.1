Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EA4CFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 10:12:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D296C84332;
	Thu, 27 Nov 2025 11:12:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g8OWyIoD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C77C84335; Thu, 27 Nov 2025 11:12:36 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE6528432D
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 11:12:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B9115600B0;
 Thu, 27 Nov 2025 10:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15603C4CEF8;
 Thu, 27 Nov 2025 10:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764238352;
 bh=R6+dMIOgM6BfcpPRAyVmvoGFJtx3AdrZx1gRNf8f5uI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=g8OWyIoDzKrdXzVgT8p3ZiJIGKIoSKOOGB5Oe2bptuB1YOv/3AEu2LqTkONOHSODI
 rTQMVjKYdlp5gFTaG+UQi41vQ7TmqtM8giTC3sDcmBs1qYZnm7BijyAVwxdXInnJ0I
 qI7e0L1hckjSiiQ0+zrcjAhWhJPwW+JdkNfNFCvbjw3YzxlBTt3DoBXfbsDb0Yw/Dg
 1N+AVUXODxoOl49y6tocvMHR2eoTKEpg8gRNUy0HuRsfawO39UV03CijgTWVsV8b2k
 lCthGifPWDtmiMinVAK4jT3fLBgGL3SpdlrDu7Cda+mkgUM4e3HOZjsepgt2pfq32e
 zQqlVCzYzdT2A==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>, Marek Vasut
 <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, u-boot@lists.denx.de, Petr =?utf-8?Q?Bene?=
 =?utf-8?Q?=C5=A1?= <petr.benes@ysoft.com>, Michal =?utf-8?B?Vm9rw6HEjQ==?=
 <michal.vokac@ysoft.com>
Subject: Re: [PATCH 1/2] usb: ci_udc: Check ci_ep->desc before use
In-Reply-To: <20251125085846.507591-1-michal.vokac@ysoft.com>
References: <20251125085846.507591-1-michal.vokac@ysoft.com>
Date: Thu, 27 Nov 2025 11:12:29 +0100
Message-ID: <87fr9zss1e.fsf@kernel.org>
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

Hi Michal,

Thank you for the patch.

On Tue, Nov 25, 2025 at 09:58, Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.c=
om> wrote:

> From: Petr Bene=C5=A1 <petr.benes@ysoft.com>
>
> There are two places where ci_ep->desc could be accessed despite it is
> not valid at that moment. Either the endpoint has not been enabled yet
> or it has been disabled meanwhile (The ethernet gadged behaves this way
> at least.). That results in dereferencing a null pointer.

I wonder if this is not a generic problem (that ep->desc) is reused.

Looking at usb_ep_enable() in include/linux/usb/gadget.h:

"""
static inline int usb_ep_enable(struct usb_ep *ep,
				const struct usb_endpoint_descriptor *desc)
{
	int ret;

	if (ep->enabled)
		return 0;

	ret =3D ep->ops->enable(ep, desc);
	if (ret)
		return ret;
"""

Can you please explain why the generic code is not enough to handle
this?

>
> Moreover, the patch gets rid of possible outstanding requests if the
> endpoint's state changes to disabled.
>
> Signed-off-by: Petr Bene=C5=A1 <petr.benes@ysoft.com>
> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
> ---
>  drivers/usb/gadget/ci_udc.c | 43 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
> index 4bff75da759d..b3bbbb6ad32c 100644
> --- a/drivers/usb/gadget/ci_udc.c
> +++ b/drivers/usb/gadget/ci_udc.c
> @@ -308,6 +308,27 @@ static void ci_ep_free_request(struct usb_ep *ep, st=
ruct usb_request *req)
>  	free(ci_req);
>  }
>=20=20
> +static void request_complete(struct usb_ep *ep, struct ci_req *req, int =
status)
> +{
> +	if (req->req.status =3D=3D -EINPROGRESS)
> +		req->req.status =3D status;
> +
> +	DBG("%s: req %p complete: status %d, actual %u\n",
> +	    ep->name, req, req->req.status, req->req.actual);
> +
> +	req->req.complete(ep, &req->req);
> +}
> +
> +static void request_complete_list(struct usb_ep *ep, struct list_head *l=
ist, int status)
> +{
> +	struct ci_req *req, *tmp_req;
> +
> +	list_for_each_entry_safe(req, tmp_req, list, queue) {
> +		list_del_init(&req->queue);
> +		request_complete(ep, req, status);
> +	}
> +}
> +
>  static void ep_enable(int num, int in, int maxpacket)
>  {
>  	struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->hcor;
> @@ -335,6 +356,12 @@ static int ci_ep_enable(struct usb_ep *ep,
>  	int num, in;
>  	num =3D desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
>  	in =3D (desc->bEndpointAddress & USB_DIR_IN) !=3D 0;
> +
> +	if (ci_ep->desc) {
> +		DBG("%s: endpoint num %d in %d already enabled\n", __func__, num, in);
> +		return 0;
> +	}
> +
>  	ci_ep->desc =3D desc;
>  	ep->desc =3D desc;
>=20=20
> @@ -385,16 +412,27 @@ static int ep_disable(int num, int in)
>  static int ci_ep_disable(struct usb_ep *ep)
>  {
>  	struct ci_ep *ci_ep =3D container_of(ep, struct ci_ep, ep);
> +	LIST_HEAD(req_list);
>  	int num, in, err;
>=20=20
> +	if (!ci_ep->desc) {
> +		DBG("%s: attempt to disable a not enabled yet endpoint\n", __func__);
> +		goto nodesc;
> +	}
> +
>  	num =3D ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
>  	in =3D (ci_ep->desc->bEndpointAddress & USB_DIR_IN) !=3D 0;
>=20=20
> +	list_splice_init(&ci_ep->queue, &req_list);
> +	request_complete_list(ep, &req_list, -ESHUTDOWN);
> +
>  	err =3D ep_disable(num, in);
>  	if (err)
>  		return err;
>=20=20
>  	ci_ep->desc =3D NULL;
> +
> +nodesc:
>  	ep->desc =3D NULL;
>  	ci_ep->req_primed =3D false;
>  	return 0;
> @@ -606,6 +644,11 @@ static int ci_ep_queue(struct usb_ep *ep,
>  	int in, ret;
>  	int __maybe_unused num;
>=20=20
> +	if (!ci_ep->desc) {
> +		DBG("%s: ci_ep->desc =3D=3D NULL, nothing to do!\n", __func__);
> +		return -EINVAL;
> +	}
> +
>  	num =3D ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
>  	in =3D (ci_ep->desc->bEndpointAddress & USB_DIR_IN) !=3D 0;
>=20=20
> --=20
> 2.43.0
