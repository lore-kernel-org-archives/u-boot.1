Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F3DE77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:27:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03FD880107;
	Thu,  9 Jan 2025 16:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eCz20NFo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0BA7801F5; Thu,  9 Jan 2025 16:27:17 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 396DC8005B
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:27:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b6f1b54dc3so146548185a.1
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736436434; x=1737041234; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xj7FiFJyRzit50vTb2Z+LKegf6l4fEQA+gY0kkQDsH4=;
 b=eCz20NFo+aXpq4JveH+vjVI0s4k0pRFBSQcmiFDYvl0szwuBbTQ+Qb+MG1H+R01PQk
 d0L3e5lC3Rm35WQPbPFn1CGpE36CnEBKclodMQ0lO/56mHlRa4ulwP2+2CECyxmaIGNM
 cgujw5zzPwQdv/soin3zW2ByX/JnF0zTMfcPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736436434; x=1737041234;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xj7FiFJyRzit50vTb2Z+LKegf6l4fEQA+gY0kkQDsH4=;
 b=Lg0dM2TniuoV3Sdn3l4io4djAiwF3P1ix8i3aeVIyVWiAYgbpPrl1jT9ihgnWY+wMt
 2bQc0ZuQcLCDhB4fU8DMt0SfqJo0zwekGT2icfl4C6nWCpih/OahYDTYJqzlVG63xUpe
 RIOmAMWoarWrKLKboLkRmtHY4FycGzOqMC5Yy52nPv+lOEIA6bLgEy0LJs4smAXf82UY
 GXNvTUXYdtJR6YugUYg8A//4v9nC4eZvMEqVOYavEcZxmLV1SfzbSeLdlgQrhpRg5lnn
 iquFDw2LJOO9av5IJt8GZMP7knCr6w+tKUxhtur6FdC4t0fdPl2J4nzNNuhDDJUzcp7S
 HvNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBtWcc7vxil9+3WAtTXSvYa7lHXppuwIdSwK8zBEW3BGtVkJhHZ7wKFy8K1zpZGWZQu1n3hKI=@lists.denx.de
X-Gm-Message-State: AOJu0YwqjvVr/2uEltVF2/oh3nMNfgtJm/h1x0cYrLM5guThUaTcD+nX
 U5u4WxUkC7RYoAvWEqI8YeIQQKBKycQsh40WnDqH+57J1haaYLK6/VQT/6YTV6s=
X-Gm-Gg: ASbGnct8DNXjjC0B9nzyPia/0z1M2GcZ9WsIlUKzj13Pkyf8JoHmAGEyFvwtv1L7774
 ninA3Z/bJf1FAGDitJchDQIo1lBvhqnrhSk46U/uXA1OxkDE2a9A/QBGn/OTMVDAWqqbyjz6GXC
 cTr5BS0qv5w+/BFW8HKVdj4dhGlSU6oLWk2rXVRFs+sK6VrtSLQz14C7AgFG7Nxb3kUoJzuSUPV
 EyWHcUD2H/QedPMRNKRH02ez+EBn59K/uekIv92oyQkBsxt+s5o1gc=
X-Google-Smtp-Source: AGHT+IFy1qtgzU7QqB0/4JB1od4Eryum9PwJJj9sjtm8B0J3tsIV6egqUnPQlfnD3PF+VMCjX3QofA==
X-Received: by 2002:a05:620a:25cf:b0:7b6:e931:4608 with SMTP id
 af79cd13be357-7bcd9729aa8mr1059051685a.6.1736436432523; 
 Thu, 09 Jan 2025 07:27:12 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce3516068sm76055985a.100.2025.01.09.07.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 07:27:11 -0800 (PST)
Date: Thu, 9 Jan 2025 09:27:07 -0600
From: Tom Rini <trini@konsulko.com>
To: "Vankar, Chintan" <c-vankar@ti.com>
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Nishanth Menon <nm@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Hari Nagalla <hnagalla@ti.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Simon Glass <sjg@chromium.org>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Aniket Limaye <a-limaye@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, srk@ti.com,
 s-vadapalli@ti.com, danishanwar@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 01/13] net: tftp: Increase TFTP pkt string length to
 include null character
Message-ID: <20250109152707.GX3476@bill-the-cat>
References: <20250107093840.2211381-1-c-vankar@ti.com>
 <20250107093840.2211381-2-c-vankar@ti.com>
 <20250107142258.GH3476@bill-the-cat>
 <91021f80-2d2e-47f9-bdad-a652ebea7986@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QEo7zCFkzou3e5/r"
Content-Disposition: inline
In-Reply-To: <91021f80-2d2e-47f9-bdad-a652ebea7986@ti.com>
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


--QEo7zCFkzou3e5/r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2025 at 12:41:56PM +0530, Vankar, Chintan wrote:
>=20
>=20
> On 1/7/2025 7:52 PM, Tom Rini wrote:
> > On Tue, Jan 07, 2025 at 03:08:28PM +0530, Chintan Vankar wrote:
> >=20
> > > 'sprintf()' function defined in 'tiny-printf.c' is returning length o=
f the
> > > string excluding null character. Fix this by increasing TFTP pkt leng=
th by
> > > 1 to avoid TFTP error of request being not-null terminated while
> > > requesting length of packet.
> > >=20
> > > Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> >=20
> > Erm, if tiny-printf's sprintf doesn't work like lib/vsprintf.c's sprintf
> > in this regard, we should be fixing tiny-printf.
> >=20
>=20
> Hello Tom, I have observed that 'sprintf()' defined in lib/vsprintf.c
> at here:
> https://github.com/torvalds/linux/blob/master/lib/vsprintf.c#L3035
> also behaves the same way, that returns length of the string excluding
> null character.

Then please rework the commit message, thanks.

--=20
Tom

--QEo7zCFkzou3e5/r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd/6ssACgkQFHw5/5Y0
tyyqFgv/YulV+zxMigpIH5r/eK+/rl8xXnPw65241qdSASM/lNhgdileWkf13MXK
5vWxvWFAwEVsWNcknGbR1gEhSpYEDkLYnK4lMt7QH/O+CSymz1D/wMD9AtDHApS4
+mwCt1T90saKIAec1DlSi6RSsGv/zuTaUjZLPgu8q0o4n8OA/4W5ocLT2jMIdtvx
yo8zkXhunNQBQ3IvceuiluOIaMPR3FU/yHvTbRNoa2M7fR4cgUHvasiC4WRNfgoE
q+C3gXNaRjaMEGRYRlM63bnYdqfWSDFqm/3GshBzmXVbhiy48tqISoResuqImJMO
8Q2aqaC8sIcdNRiTRnp+1ErCdotDo2INj8OYb7TLZQphDNb3TDgSSUGfe9VHsgyK
m3cUMpRxjlV18zndt/34idXz5YSaPMtcCW6iYyrki4UGtEq2deoL4TTRIPk0stoA
CaX6qIPnlrh/kF/HqxfEflID4Mw0gUd6fZdPyuYgvO/wDFJmamSlYnDiGTH/R831
EGRaS/r4
=P8vE
-----END PGP SIGNATURE-----

--QEo7zCFkzou3e5/r--
