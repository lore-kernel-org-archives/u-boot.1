Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21298EE8016
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 15:21:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C13E86A4F;
	Fri,  8 Sep 2023 17:21:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gNtE2q51";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79F5486569; Fri,  8 Sep 2023 17:21:21 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA0FD86569
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 17:21:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-579de633419so21710877b3.3
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 08:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694186477; x=1694791277; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WsH+Igm5GsD8yL8QSOj2E5JqNfyyJbnJuT7jZZ15EuU=;
 b=gNtE2q51MRBcOe1PjaUXFCidL99+8O2jurZ01q3fSaZFPV8RmbpFaRYuF1G+W1GkSW
 gUsPJRZGdERKCPpQxRvq9jRSp4zAw9xd/0HGKDE+iRBBtnM1Qu2dWdze49YS+zOQKoJw
 di7hVqYqaLE5G8kSD/895vjfaYjNT7lfavsHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694186477; x=1694791277;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WsH+Igm5GsD8yL8QSOj2E5JqNfyyJbnJuT7jZZ15EuU=;
 b=UaLX2kzFhslnmVy8feCGKd4f0NYYsWbyDmH+FSKat70Qabz02zcQQvb5dVBeXwRagW
 dgA4LbxlMqLozRGnsz+sJlMGht6zQKCk5xjelAlY9C0kahV6/ZEo1DcrgxjBOon0PU8y
 4t3PbbQCLEv97q6UzncPAlwrQxUKNclnCsWh/E0QGBlIwGdCya8qp3+V9zaMYIuvQLuL
 18o65RJyIg2LuW7uyLmZ4n6OCZXHaP8+yixjCo/ACHh8nWLSJGKpVyeTexm+vGWgvv1l
 l+9+eR4DWVmAKMeipUXsBB1E6BxQUhPjuvZcE/UroWwJpmKFsZ5sFm7kOzE00Vl4erXx
 u3Dg==
X-Gm-Message-State: AOJu0YyCJGqBudWdLaqXNqtxkv1NhPrj1P+71PlAjduygDyVPN2TzGbp
 TCILnEpeE00bJcv4FdxHnnPjsA==
X-Google-Smtp-Source: AGHT+IGpQHiKd0InvnH5E8ZgQ+qheyJUwNeNxa3kW+2eGqFUBAU83FbLm0vOryNH8gUG//kRt2UcVg==
X-Received: by 2002:a0d:c2c3:0:b0:59b:eba:f94b with SMTP id
 e186-20020a0dc2c3000000b0059b0ebaf94bmr2665150ywd.40.1694186477425; 
 Fri, 08 Sep 2023 08:21:17 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-031e-83f0-a4af-2e7d.res6.spectrum.com.
 [2603:6081:7b00:6400:31e:83f0:a4af:2e7d])
 by smtp.gmail.com with ESMTPSA id
 b65-20020a0df244000000b005869fd2b5bcsm471786ywf.127.2023.09.08.08.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 08:21:16 -0700 (PDT)
Date: Fri, 8 Sep 2023 11:21:15 -0400
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v4 09/22] Move fdt_simplefb to boot/
Message-ID: <20230908152115.GI305624@bill-the-cat>
References: <20230907155933.48511-1-sjg@chromium.org>
 <20230907155933.48511-10-sjg@chromium.org>
 <CALeDE9PS3J-wGzMNbAJuHtqUkVCnraCAAdJXoEnX_eyoFq2xLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9E87AhWdn8+yfoWN"
Content-Disposition: inline
In-Reply-To: <CALeDE9PS3J-wGzMNbAJuHtqUkVCnraCAAdJXoEnX_eyoFq2xLw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--9E87AhWdn8+yfoWN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2023 at 10:36:20AM +0100, Peter Robinson wrote:
> On Thu, Sep 7, 2023 at 5:02=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > This relates to booting, so move it there. Create a new Kconfig menu for
> > things related to devicetree fixup.
>=20
> Is simplefb booting or video?

It modifying the device tree to populate (path in the kernel):
Documentation/devicetree/bindings/display/simple-framebuffer.yaml
based on the first video device U-Boot has.

--=20
Tom

--9E87AhWdn8+yfoWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT7O+gACgkQFHw5/5Y0
tyz7jgwAnQ7t607yXPUCUiNJU0eCFPcXCV5ZS2ppQs/D9zKiGjTXoUvqSVG3iaQJ
noz/AAd7jNgR1cwD3F4lqd9kF6XNXQVYTEPUlWEmiICj/+IZAPQv21SutCVeSgCN
jQN5MCRPkx0P+zvApchXeLVbaY/htroTZdrJJYNAqs1xBgxHNCbfY8n3PCeGIn2v
L8Y5tHOEdXOHorMhKNVIFtURcc5OakitPTVOL5SMnn0Zb5uW7Jcw6bzOrGJbO5/+
K2e4a4XR0bMfKFZy4bye6iusu8bxPaWJ//cB6ze5KwxaJwUSlOgt3DSHULAY9J6X
7l8O03M6/6Pb5+iyUd62LKiKyuYb1EmiNmHXSiT5vzqSFCfdGu6+3CQLZDJoH3IW
LY30FcpUtgL+KvlR5IppMsLo8JQU7yYvgpnEOCIrOPRexXaWLfgTzp10bKGuKtfT
LuF+vsyKpHyg9uFJYQsvUccBWGSh8VLEMNLOnpZXld4isewtwVjr/foUKsYPdBLq
KUxe1nnC
=LQVo
-----END PGP SIGNATURE-----

--9E87AhWdn8+yfoWN--
