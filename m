Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2E5C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 13:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B403A80540;
	Thu, 20 Mar 2025 14:53:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sRifLugP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B44A80540; Thu, 20 Mar 2025 14:53:12 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB8D28001F
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 14:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22423adf751so14264145ad.2
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 06:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742478788; x=1743083588; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vgCKf+LgxKcYF2pYG5pS2JbIyiBg5toqFXTAjR1sKNw=;
 b=sRifLugP5jydC/EMVga1vIQSG4Cpelbtfxhlpplo/5Yq5X5FO3aXcVUTYQedrX0ftW
 QV5LD/6+RBy2SdqPnkNZOnpQ4ub5Z/UWxe8FJOF89nYM0tA6RP45YZrfdmxxhV1gdYnK
 BwyEHzf7kJiuziqzsBaUOXaMXSTVknY0McE8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742478788; x=1743083588;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vgCKf+LgxKcYF2pYG5pS2JbIyiBg5toqFXTAjR1sKNw=;
 b=oGvJ4J0i9de3adiLyet2KjtGjpgu3QbjxkGkaW5famuc0XZkTDQFZx9e88biwwWGSR
 jQRtrvItnwXKN8XAO5PuXhv4u+Adsr5j5gX7hOpHibkeSSezgdfXfpgVst8sWLdoPpVV
 Vzefwwy8IFlEpAknT17npnwGKN9JV496bxEhJCeTfcqnjhTOIn6o9663DI1mIgFYOTz0
 0eaTpHPv35M2dzdI8MvcUDrkyqHAfEOw2pJJAskqlcB98NB8OsPuqq9INEvcsVNxdtxJ
 aW7mbBzh1Ar8hbfuCV7n8vGyn9PJViorX+FDW4xJJDK7gSKK/9YW/df1GoflGvE0mQ5S
 i6QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJDD+wlqMHAPFBfOQQSMEJo5B/VXOnXdt8RgGipWDxQWT369gdAFOLjE+xH8iqGlGq7kvLBAI=@lists.denx.de
X-Gm-Message-State: AOJu0YxHytFOQ+VyhIHaeQ7j0JW7CN1wpGr/wTs27m0770sfvm1ZjToz
 tPQoYAsPjd5xej93J/CQaLX5jXma8St9fL4JlPxYS3ft6czTUA/dXyzIZ2o/cY8=
X-Gm-Gg: ASbGnctuK91+QJsZmMxG4HQQMkixCFItamzp81aGStGOKJog35a/5gNlHnRxIAtwPr0
 rB4TO7DVfub0fsT3h2USrOw43E1Y3ybGecklSI+1ny/mcbaUPhGGuToQBDxh6DUiL1SqEyIfyf5
 qINSsyFlaXVzQrFuXkwhBnZoFjPYojpFXcrgMzyN9MgNQTd4zMs4B/pYnU4zyIpAx+YxcBK3ByV
 YRfnxXb34jgfRbTbui3oVe/zar3VZbkNE2QlqaNnxTyi71nxebwbqKwDlNkwM0PpJXYtyCivwxH
 a+4iJCpg2z3quNjTdpUW+lN2E9DFZDjNc1KwabQe7D68Aw==
X-Google-Smtp-Source: AGHT+IHRf//0n0Z6BgxJzAPe+2w/pI0rrHp/2VZAlFTaLTJrb1ms0xheYDr99ahF0wr1e8xUmjI0KA==
X-Received: by 2002:a05:6a21:68f:b0:1f3:48d5:7303 with SMTP id
 adf61e73a8af0-1fbece41f10mr13227618637.31.1742478787962; 
 Thu, 20 Mar 2025 06:53:07 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167da28sm13796867b3a.89.2025.03.20.06.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 06:53:07 -0700 (PDT)
Date: Thu, 20 Mar 2025 07:53:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de, Benedikt Spranger <b.spranger@linutronix.de>,
 Simon Glass <sjg@chromium.org>, John Ogness <john.ogness@linutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] tiny-printf: Add support for upper case hex values
Message-ID: <20250320135304.GN2640854@bill-the-cat>
References: <20250320102346.13564-1-cniedermaier@dh-electronics.com>
 <a6ab86ac-4404-4081-8529-b8d11b37b5d2@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kB7GCYLTibO7m86O"
Content-Disposition: inline
In-Reply-To: <a6ab86ac-4404-4081-8529-b8d11b37b5d2@denx.de>
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


--kB7GCYLTibO7m86O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 12:49:17PM +0100, Marek Vasut wrote:
> On 3/20/25 11:23 AM, Christoph Niedermaier wrote:
> > If tiny printf is used with 0x%08X (upper case X) the output is
> > always 0x00000000. It could be confusing if upper case instead
> > of lower case is used intentionally or accidentally because the
> > actual value is not output. To avoid this confusion, tiny printf
> > is extended to support also the formatting with %X.
> >=20
> > Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> TINY_PRINTF is meant to be tiny, i.e. not consume a lot of space, at the
> expense of functionality. This is meant to be used in size constrained
> environments, like the SPL. If you need full vsprintf() formatting suppor=
t,
> disable TINY_PRINTF in your config and use the regular vsprintf()
> implementation.

Right. I could accept a patch to tiny-printf that treats %X like %x (so
that the value shown is correct) as that would be a minimal size change.

--=20
Tom

--kB7GCYLTibO7m86O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfcHbwACgkQFHw5/5Y0
tyzAFgv9GoATdZndPev1HGUehsx6sIoxlhbcWRFuSFvu7u1DTLvcFJwY0hPtDvqP
UVVSCiHpJXCXFcwsXYLguQNRVn2MdgtblFaCvcGIqdmQy0alfg76Hv4RbicUNMMc
u6mQQ6BLXmMNo/FJfNU4v3xj4hxXWZt7+Xe4U0r8Z8L9RfOJb1OW3dAKIic0cnl9
lkKKJDPQFuWNpMp/lRHHE+KW05Z4VRTLtrUcMiuBHiQPHWygPUPW0yUC9clIN2Kg
WRIiYx+6L2z2T9HH8XjBrapPDyxA5sL5fk3XSQO3+q6AxOltQXyMlp3hnTYsgOs0
bkITLw7GDJaKw3T9TXjxST9GTdZvaUDjOsaiGnqaySYfP5pkMJsREr9c9AufzGtU
X8jik1Nrv/FOhYb9U+9JcoeZ2jpPzbgwWekSHth4ulGLWrMbx7KQ0pksfaddvOLr
5Vl1xna5qEIRMI2mxR56VklZSdzfBnAn3wnWrbjDRSdpSWbLRsnQGKAUBMcJAw7Y
Mj3urYLx
=h8lX
-----END PGP SIGNATURE-----

--kB7GCYLTibO7m86O--
