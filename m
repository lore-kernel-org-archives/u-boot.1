Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F8CC0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 14:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E3BF826C2;
	Fri, 31 Jan 2025 15:13:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=inf.elte.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D64E182166; Fri, 31 Jan 2025 12:15:23 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD90882161
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 12:15:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=inf.elte.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primalgamer@gmail.com
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-43618283dedso18758155e9.3
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 03:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738322121; x=1738926921;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7Wao06F0SlgQ1yEP+aepIsdq9dpr42+K3X7fC14ALWI=;
 b=SYR5JEGHc49SJbH4FHnGJ9ojiy7+vPcWCoRnlBefyyzkZp2tNmIGMh6/lj1JLHu+E5
 0QirB5jKnI3W+Z932eSVeOoP1ffoMxnXSDIMVqJIoXHtfn0dtrjIXBoKSdsRlwFBuSyC
 1p8yG2oqk2arI3ygPWgwHiXyBAFj/oXwE1qPYG1Tfq1KQnwMBs9djewTHn13k0qfcd7R
 GdRPhqTPS/C06nwGAuYDjkEH94usd79Nm7g9FrSfjvNYv/G3SxCbHpbW1j446nGuFyu2
 La22QpavCEtGSbgaf8EJSnST1D50GmjGcqbi1+14iJDC0ellXn7DdNtexNXRs+vm4knr
 Vmlg==
X-Gm-Message-State: AOJu0YwI0BhYmGJV6l1fu/q+5Um5l42GYOcb4+NsCGm26YbBLx1hEruq
 8xldnOIG24JLZSFxfSyJ49eYUqF4IvyIeTKAY+IZhQTOYfDvhgn2eggifN/j
X-Gm-Gg: ASbGncty+DUZfDymt3+V2wLXXUOVW401d4XSUzOq1OQxy+89+9BwqCLwyJ4uYLA1Mix
 hoZc6AmhHOEIQLvBzx3LqwDOKBsZpuQaGcmFZ7+mAOURgFo4PeHbTj/AsuqgZrZM/LeQ8k2D9fL
 uWkSB1J5S6DxAgnBONCcHSrWtxkxntNUi7/r6pQjj/pxZLFcteM++eWMg53IIBj/RD1e1rZcNck
 oYc0b8S9vO+BIXi1ch8JHqA0kf7RgL97+Li+CenLRcOqaQ1tOUMvrRj7JGBAzUv/Rymub/9leQW
 QEsbZyhDm1ku2KHanTA4/MdHpDBKyvh+C/s=
X-Google-Smtp-Source: AGHT+IHAsFmYk/sBSUw3Cf1PKCFyveeTVi4BmdJ6vrtBNpjgyMQeVZ8cuyyEoia0acdCr7PGKqSXIQ==
X-Received: by 2002:a7b:cbce:0:b0:438:e232:4686 with SMTP id
 5b1f17b1804b1-438e2324732mr58219915e9.8.1738322120606; 
 Fri, 31 Jan 2025 03:15:20 -0800 (PST)
Received: from [127.0.0.1] (login04.caesar.elte.hu. [157.181.151.133])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc8a59dsm89243965e9.40.2025.01.31.03.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 03:15:19 -0800 (PST)
Message-ID: <e5da652b9fbdce0e4a7071a05c8c2159a728743d.camel@inf.elte.hu>
Subject: Re: u-boot in restricted environment: networking over serial
From: Ferenc Fejes <fejes@inf.elte.hu>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Date: Fri, 31 Jan 2025 12:15:19 +0100
In-Reply-To: <20250130170406.GF1233568@bill-the-cat>
References: <4fcb9244e87d5bb4a53075775247cecde2f9e3fa.camel@inf.elte.hu>
 <20250130170406.GF1233568@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.55.1-1+b1 
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 31 Jan 2025 15:13:17 +0100
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

On Thu, 2025-01-30 at 11:04 -0600, Tom Rini wrote:
> On Thu, Jan 30, 2025 at 02:55:53PM +0100, Ferenc Fejes wrote:
>=20
> > Hi,
> >=20
> > Is it possible to use the serial port for u-boot networking? For exampl=
e,
> > given
> > a restricted environment where the FIT image is available with ethernet
> > firmware
> > and drivers, so it is not possible to boot it with DHCP boot since ther=
e is
> > no
> > networking. Or simply the ethernet NIC has no u-boot driver at all. For=
 such
> > cases, I assume ymodem is recommended to download and boot the FIT imag=
e.
> >=20
> > However, experimenting with different images and debugging, it would be=
 more
> > convenient if serial could be used as both data and console channel. Is=
 this
> > possible?
> >=20
> > A simple example:
> > 1. ppp on the host machine, with IP forward, NAT, etc.
> > 2. u-boot establish a ppp connection over serial to the host
> > 3. u-boot starts a netconsole session to the host
> > 4. user can use netconsole and wget to download images
> >=20
> > I was thinking of PPP, but that's probably not supported by u-boot. Any=
thing
> > similar with RNDIS and USB CDC ACM?
> >=20
> > Thanks in advance for any hint!
>=20
> Typically we use x/y/zmodem for sending data over the serial port in
> U-Boot as no, we do not have networking support via serial port. Thanks.

I see, thank you for the clarification.

