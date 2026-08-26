Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0F5C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 16:11:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C1C960769;
	Wed, 26 Aug 2026 16:11:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f1C6rFuckV-v; Wed, 26 Aug 2026 16:11:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787760670;
	bh=ZLNAMK2i3vsjmwmUgVeK0sgpf7FGm8A4GKJuGwyKp8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LWqbFsMYH4prIXcO40t9Se/QONhvrxGdTfvHSaCw1bAEQWFAcw93h2IIYlAgc2ZjL
	 Q8qgG/eLCHU8nnwZ+3g/bI8xvk3fIUh9VhQ5TrOY4pbZwi+JNuhXIg9L+zAFwl6PL8
	 0IRk1NEvot+9jXEjcUKFq6lNKRwW8im1dtQoiMGXTVFyXcMcbmthOxiEQ0FhMKFkuF
	 IVljUMtQj/pNWHe57yRUtTi709+6sSf/uoCc9Bvy6Q4BBJMdduxezIZP2Zl4zKKhDI
	 huJCPFTJIPMLCKFMKsyWsM6Su7PycFOHDZ55i+/MDHpz3Qt+YyEanFE82JNCmegDir
	 Ouh0ZwW1GmbHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D877760758;
	Wed, 26 Aug 2026 16:11:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E917839E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:11:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DADEB80B40
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:11:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HvWjzE7BkRAb for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 16:11:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gYliC1Qi
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9A7A780B32
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:11:07 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7e9ecb1e13cso2068700a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787760666; x=1788365466;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZLNAMK2i3vsjmwmUgVeK0sgpf7FGm8A4GKJuGwyKp8E=;
 b=gYliC1QiUwXOWRKlanOsudVWc7QerUHrZgCsCQtrMNaRtYqOaLd0XhTvyCseWG68YA
 IUOEszUhm9nt/2BIeg5iRFmj3ec1AtDFocDs7m1BBBaAp3mHln0BKnSNAbS0qh81xK/r
 3XzGJiMjbJAOPvLE97xauwUjEzxvYq3taS92w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787760666; x=1788365466;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZLNAMK2i3vsjmwmUgVeK0sgpf7FGm8A4GKJuGwyKp8E=;
 b=bmSpqxT3HnNYpsgEmvzdl3cL3QDURAvN8B81NADGPNp5RUKjzK6sjq8KjsGPkccZiB
 U67nSql8J+lGAIaZdCHxdyqDAf8p3LHmyfgfJx8lWDrZOSwyTkNrtz4z0dZFYAXrjWPi
 3LWFkGLN7h+m2Xo/P5jnQVXZ4NvsA/IhBtqTDjhDlOeEyZU97ACNqIuPA+RxpTqSfNvh
 d2cf1ICdhT2GBxUgjVhBUqySOGLa5T6CuJbgC9CfW1CgjHtwp4l/g3YZNsl4OrLmTJBt
 RN+6vPC6wSARlaPmjO0XhALNfWQT5FuTN3pnrJLoTyV5nfJDeRDpKmOYlduBmZiYHBeP
 Cu+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrZwjXH34id6qx44qKT8GIpEmX5HNwrcoc2eLjsUCO416jVPBsnULynKj+HMMBAlrrA+P9R+rY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n9lZpQfoqKcWXxwTvP0eBvWxjBAYWyu9HJviQ2vtrwJXvkRvEt
 hQ9vryjAQaYwnqTgNOQFOnzsk/st3dvbcc3t7CHEATgjqrkqqH95VvFdpQGFAKhDWIs=
X-Gm-Gg: AR+sD13vIdZsZj49HCYhKqMqQcoLyE64Mkqz+F+XO5j1mEccBU0aBOtBG3mMi93f+Vk
 svC/NowHLiSqxsNiKd+ZA5JPguNQD3WgOtHdRs/26COpxFQgrCTwiPNE+G1p7xqJG/VJhzWo7JJ
 orTumGkqtlM92ziOELmfoJzaDiT+wBXu/tcx6mVwigHIPGloaYV1zmrNCxjeAhttKtet0G9+kEm
 jsup+MD7LnI5LAOyrggj1yGlva0sqc52n/9uw2Oz66nwJe0b+oWPtTaykMqoF+GCUoNU5/0UHNc
 CN5WbCliZpbB6Gph7aPJKYLJ1mI6JjS4YXNAIlPo1sIx7ind9dEIEHBvR9CaxCGKqWDg3acCyLm
 Y9e+KxN9Mg4ob4Qh++4tpN+htafGu0CNOWTClvcQOrcQNadwj5LJrgrXAZz5V8Oa8t9cHkkJ6d/
 RHN4P02cNzThhIV5Woc4N6VlpZhPZqbMIQMFtuhUlQESjqCP7cXDKHH8SWLRvrF/Yo2F7LysVW5
 CTT6XDGX1efSSFhYKszi5IRZY0mWAzLEhvibKMKk1sUUhHwRVYsvnE4AMSMqaBREOU6vrXPtcM9
 dJWAnqxx0Q==
X-Received: by 2002:a05:6830:6616:b0:7e6:efb8:fe66 with SMTP id
 46e09a7af769-7f4c4fcb429mr8471143a34.12.1787760666365; 
 Wed, 26 Aug 2026 09:11:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4c818355csm2006916a34.6.2026.08.26.09.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:11:05 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:11:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.u-boot-project.org,
 francesco.dolcini@toradex.com, ilias.apalodimas@linaro.org,
 sbabic@nabladev.com, festevam@gmail.com, uboot-imx@nxp.com,
 marek.vasut+usb@mailbox.org, alice.guo@nxp.com,
 antoine.gouby@toradex.com, stefan.eichenberger@toradex.com,
 emanuele.ghidoli@toradex.com, franz.schnyder@toradex.com,
 balaji.selvanathan@oss.qualcomm.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, mkorpershoek@kernel.org,
 xypron.glpk@gmx.de, casey.connolly@linaro.org,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev,
 sjg@chromium.org, ernest.vanhoecke@toradex.com
Subject: Re: [PATCH v1 1/6] usb: dwc3: core: only provide legacy gadget IRQ
 handler when USB_DWC3_GADGET
Message-ID: <20260826161102.GO523975@bill-the-cat>
References: <20260824183048.419198-1-eichest@gmail.com>
 <20260824183048.419198-2-eichest@gmail.com>
 <ab7c860e-2f59-4c60-96dc-0c510a63d64c@mailbox.org>
 <ao6SdYSOzJGKtgIa@eichest-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vYyMtkYwoQQ0cuOj"
Content-Disposition: inline
In-Reply-To: <ao6SdYSOzJGKtgIa@eichest-laptop>
X-Clacks-Overhead: GNU Terry Pratchett
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
Errors-To: u-boot-bounces@lists.u-boot-project.org


--vYyMtkYwoQQ0cuOj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 09:15:01AM +0200, Stefan Eichenberger wrote:
> On Tue, Aug 25, 2026 at 01:33:27AM +0200, Marek Vasut wrote:
> > On 8/24/26 8:29 PM, Stefan Eichenberger wrote:
> > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > >=20
> > > Building a board with USB_DWC3=3Dy (DWC3 used purely as an XHCI host
> > > controller), USB_DWC3_GADGET unset, and DM_USB_GADGET disabled (e.g.
> > > to use CONFIG_CI_UDC for a separate ChipIdea gadget/OTG controller)
> > > fails to link:
> > >=20
> > > drivers/usb/gadget/ci_udc.o: in function `dm_usb_gadget_handle_interr=
upts':
> > > drivers/usb/gadget/ci_udc.c:983: multiple definition of `dm_usb_gadge=
t_handle_interrupts';
> > > drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.c:1034: first defined h=
ere
> > > drivers/usb/dwc3/core.o: in function `dm_usb_gadget_handle_interrupts=
':
> > > drivers/usb/dwc3/core.c:1044: undefined reference to `dwc3_gadget_ubo=
ot_handle_interrupt'
> > >=20
> > > Add "&& CONFIG_IS_ENABLED(USB_DWC3_GADGET)" to the guard so this code
> > > is only compiled when the DWC3 gadget driver it depends on is actually
> > > present, matching the Makefile dependency. Boards that combine DWC3
> > > (host) with a separate legacy gadget driver like CI_UDC, with
> > > DM_USB_GADGET disabled, now link correctly. Boards that already use
> > > DWC3 in gadget mode without DM_USB_GADGET are unaffected since
> > > USB_DWC3_GADGET is set for them.
> > >=20
> > > Fixes: 4d1589808970 ("usb: udc: dwc3: Fold board dm_usb_gadget_handle=
_interrupts() into DWC3 gadget")
> > > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > ---
> > >   drivers/usb/dwc3/core.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > index be198041f08..9bff5149c5f 100644
> > > --- a/drivers/usb/dwc3/core.c
> > > +++ b/drivers/usb/dwc3/core.c
> > > @@ -1016,7 +1016,7 @@ MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
> > >   MODULE_LICENSE("GPL v2");
> > >   MODULE_DESCRIPTION("DesignWare USB3 DRD Controller Driver");
> > > -#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
> > > +#if !CONFIG_IS_ENABLED(DM_USB_GADGET) && CONFIG_IS_ENABLED(USB_DWC3_=
GADGET)
> > >   __weak int dwc3_uboot_interrupt_status(struct udevice *dev)
> > Simply enable DM_USB_GADGET , then the drivers/usb/gadget/udc/udc-uclas=
s.c
> > dm_usb_gadget_handle_interrupts() is used which correctly invokes the
> > per-controller IRQ handler. DWC3_GADGET should likely depend on
> > DM_USB_GADGET.
>=20
> Unfortunately, CI_UDC is not a DM driver yet and it depends on
> !DM_USB_GADGET that's why I can't enable DM_USB_GADGET in that specific
> case. I think NXP is working on changing that driver to DM (at least
> they did that in their BSP). So my hope was to have this as intermediate
> solution. Also in our case we use the DWC3 controller in host mode only,
> so we don't need DWC3_GADGET at all.

So the NXP downstream tree has a DM_USB_GADGET driver that needs to be
upstreamed, to solve this? We're quite a ways past where enhancing the
non-DM side things is the normal workflow.

--=20
Tom

--vYyMtkYwoQQ0cuOj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao8QDAAKCRAr4qD1Cr/k
CoUFAP9S8+xhUqTYm/mFedP7lCmO2X520eQLmB94bi5oQ7rb0QEA+S7ZnnExqRiU
GGheKVfIv2UzalrzXatku1m48ftcagQ=
=ZQbH
-----END PGP SIGNATURE-----

--vYyMtkYwoQQ0cuOj--
