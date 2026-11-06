Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21966082BC0
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WK/aL2K5;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=iJLPRewm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A1CD4099D;
	Fri,  6 Nov 2026 20:52:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dEDfv9ztqLkv; Fri,  6 Nov 2026 20:52:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 977DE408FD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793998336;
	b=OzFhmJKOB2QxuXDECFKltm/WbDKH6qCD+9hUAErw3gBUakkw51T7EHiENZO61N7iqX0s
	 dDD5XZqM6Vw5V3k+zQdgsqTvBXKfcdrcmVudwG2+x4dmfxejJiQH+z6FwA9lVBXnXVQor
	 jB42C2FriTdBGSKvG+jL7EbD3ov0R0ukGqfyo39ZXEZKiSKb69kCKQ6x/qYZd7DR3GVTY
	 3Pw7vcQRhNuBHiYRGztBfsaRsmHAtwXycP98tpwJewUIn3e0hBSfAXkCfgbpG+tLIGnqZ
	 swz8KrObiaTbVjBBngCvjRMafjK0WB46ozRHCmIhXNY3W7FhtLChiHT9m/ynsPqOF8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793998336;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JuraSlszjGbmX+gyQk4NIJQ8ixoW27oEp2WockBG+nM=;
	b=mEkXTuth7X/NIFSpPrXo0nnI6bBGOFLxGhtY7AZCA+CYj5+A/pJQfioAP8uqKRdXX0r7
	 ku9Gy4ce3gzpPL5Ye6nLyjItP55NLRzNQ/CBNUz9qiWfKr4cBQfgLeUCKRxejHDPhHlh1
	 pNjP7W6H55wbZHDgop/KTJMh8CvYtxcKE7oIOxrfEotWwvUmaX3CM4Gj3i5x/iT9KixCx
	 OZ8ViXr0qSRgE4f1CTFgKSZUhbRkz4Rx5ZyJREMu5gzATKBaIWAK4+Vy4EDzNWBTwXSyP
	 e5bnok9zZSNFlaP6rwFGSwhNBBxEvpZRIUoSrKS1nK2fm8wSEzJIaTbb9X+Gb8MqFeQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=iJLPRewm;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793998336;
	bh=JuraSlszjGbmX+gyQk4NIJQ8ixoW27oEp2WockBG+nM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WK/aL2K5rEg4+i26gU+fpbG3xXMtCQIpzwatDkwUHk0fm1/zJgJpWGFmwW9599Si+
	 LT8cyhbiQwDvE0P0/rh8Ge4mhkrsgiBu6aCinIYnE0WuGZ0FGoQWs+I611PCr3gB9v
	 odiUZmPdcjXWERAoOFnZ2SlwOWz0sBQUyTXLhBClvZeGzKyV/bkrvDItYiSIhHXDU0
	 dQv1Z2WXdAAYnN/wcK2vSf87ilQuusIs3lPIglpJmrcJCUe+k8SOy9BtBEbVMcb85S
	 h0rR5wY+aIcNQnk2l6JiDazcZg/U1aG9GByXBYKdL7V61DE9CoRm086XCwUZymfn8m
	 AiD8RwP8uKA9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 977DE408FD;
	Fri,  6 Nov 2026 20:52:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C97C235
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 20:52:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0DD6A408FD
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 20:52:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id opFq964XXLYt for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 20:52:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3556F408E0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=iJLPRewm
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3556F408E0
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 20:52:13 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-8479f46ecd8so522314a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 12:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793998333; x=1794603133;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JuraSlszjGbmX+gyQk4NIJQ8ixoW27oEp2WockBG+nM=;
 b=iJLPRewmb2eeLsqlIAJO5TblWjpUXReSdCfwIj29sX44IZAIlWJGCyQ16aZdixrEkW
 W61GSHmVgT9gPNEiG/qENNYKPDHSXUeF8ian1DcInbV+/EjhZqFiuHnXmFS+2BUNZVPC
 tCDE9NCSAabstWB2mYbry/eQijrD55AGGVICI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793998333; x=1794603133;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JuraSlszjGbmX+gyQk4NIJQ8ixoW27oEp2WockBG+nM=;
 b=dgFcjiBW4rB3t7rtPVNWn68R2tFjaCP/VtcEZCfL5GIa9GpgD4aUIgOlJr9uHcejPN
 DNJoCJ4eKVemiQFKxGz7oUeFSDeikVOoVitm8IgKPvwy0ts2HuFKfkPUHmxZliebCKf6
 XqHnByY1791yfZ2SkKfkIngIWZc4HtlVzYcKNB3PkpNytgI8doawyTtRV4hQRyDysVi1
 VmygnfMgZSXBPg8RuXjiSDXxVMLxdQJNERPSB56+lA+0l75YRbxizZpH95ZE3Yawy0Hg
 5YtfD2MSZW7GaEwoACtDH9ljD8WKu89/opSr0AXRhvqaWPXZc3DlZ9OTloSWsybLBXMV
 RdiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByw/1p/LxoZcG1DQbfXdsnIpb+DTN9pLOxExrjMZwnhVZlXWXBc9gm/Bojqb53+Vj31dkRYL7E=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8xykCA5Mhcw8KbvLlaLdW6UAdcmIYb42GRtKjEc4KZvSU/17wu
 AGFPlJSN8gSen5SDekY7xTi4nS+BG5WA6C1iEnHZpCpB0hXaPbueaoOHyAEu4q1Ki5U=
X-Gm-Gg: AYBFou3Zu683X+iat7X/1d0dvP/fN/joTxk0nCMQoqZ4oo0sQOzcBxog754IrM4Sinh
 LrlWP3DQDy8YVXFJfFX7NWjYlP7sTNgXQdIwIyzJqSrUC3tzo9krujCW40qgB6kJoUDsfxrtstV
 uJDw6D44aoY2QHZ30OU2LcKGh+fIYDUV5FUVSb0Qpn2ZUaT4a7QDjpWADFagcAWWPCQIdqyIMqc
 gn/zIqfLblyIeaAxhbs7uWarP6AcyRvZJfArjm1YIzvj2M+uN8zsM+Rpy7N3OGS3jWxycvJTuDi
 siaeYccvhlvTB6seMr1rS4Yyb6cCv7kz3AAbN0tmQLK6j2L//+pjj7iOZj0TbInrALJAwn4KRq0
 UxWQzXee4pVF49RsMVONWeFbWQPfOtIBLDaRszS+8+Oc3tREFa5mbxZdiOprbnKm1Rclr6ZDFnx
 LgJKnCWt6m80CQeNNzj3wkUEqLNMqKgyKut7KFTACaeqMPU6hzGMn7ijL1KY63zod+WHqzEI6JI
 7Vv0hoZ9DBe3FKkrdYI7WRsMQU/htJVPQ6HuJujkJLbspoi/K3FJ4BD9c22rhgBTwH5LnYNshEU
 2HA6SCncR1x1W0st2FC/UPNt/0gdd4SUuRucsaTCLh47M5/J2UoNb0REgXr8q3wi23btdJTV5Se
 q00+kDy3q8Xrl4a7xFLntrkQHbw+BroLaLWnM7fFfiIJq2zG7HLnsO0c4PMdHCpG0pVpo8Zy77o
 u3jJm2JGs2WGhBhaARZAd3+KUknkLdVg==
X-Received: by 2002:a05:6830:314f:b0:805:620e:4d40 with SMTP id
 46e09a7af769-85f1cd690cbmr4702997a34.2.1793998332677; 
 Fri, 06 Nov 2026 12:52:12 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1de8fdebsm2761368a34.25.2026.11.06.12.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 12:52:11 -0800 (PST)
Date: Fri, 6 Nov 2026 14:52:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] usb: musb-new: mt85xx: Free the controller if the host
 probe fails
Message-ID: <20261106205209.GE3741582@bill-the-cat>
References: <20261106193807.507911-1-oss.patchbox@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0Zeyvr+TE+ex6PKC"
Content-Disposition: inline
In-Reply-To: <20261106193807.507911-1-oss.patchbox@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--0Zeyvr+TE+ex6PKC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2026 at 02:37:52PM -0500, Yuho Choi wrote:

> In host mode, musb_usb_probe() allocates the struct musb with
> musb_init_controller() and returns the error when musb_lowlevel_init()
> fails, for example when no device is connected. The struct musb is not
> freed on this path, and the driver core then frees the private data that
> holds the only pointer to it. Each 'usb reset', or 'usb start' after
> 'usb stop', probes the controller again and leaks another one.
>=20
> Free the struct musb when musb_lowlevel_init() fails.
>=20
> Fixes: 7d017d607eaa ("usb: musb-new: mt85xx: add musb-new gadget driver.")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
> Build-tested only, with mt8518_ap1_emmc_defconfig and
> CONFIG_USB_MUSB_HOST=3Dy.
>=20
>  drivers/usb/musb-new/mt85xx.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/usb/musb-new/mt85xx.c b/drivers/usb/musb-new/mt85xx.c
> index 14b28bbae6b..2e13b2a30d8 100644
> --- a/drivers/usb/musb-new/mt85xx.c
> +++ b/drivers/usb/musb-new/mt85xx.c
> @@ -365,6 +365,8 @@ static int musb_usb_probe(struct udevice *dev)
>  	ret =3D musb_lowlevel_init(host);
>  	if (!ret)
>  		printf("MTK MUSB OTG (Host)\n");
> +	else
> +		free(host->host);
>  #else
>  	pdata.mode =3D MUSB_PERIPHERAL;
>  	host->host =3D musb_register(&pdata, &glue->dev, base);

As your test notes, nothing builds like this normally today. And in the
failure case we have more to worry about than just a resource leak. We
shouldn't bother doing this until someone is going to handle the error
case correctly.

--=20
Tom

--0Zeyvr+TE+ex6PKC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCau499QAKCRAr4qD1Cr/k
Cu3SAP43CyIi2XMDtu14SI/PWnItkoyF02gyWMJ8UzalfH3JeAD+K3DMbPbPgQWU
PaT957VqNNYdBdSh8P4LHrTAnwqSSQY=
=Oo9h
-----END PGP SIGNATURE-----

--0Zeyvr+TE+ex6PKC--
