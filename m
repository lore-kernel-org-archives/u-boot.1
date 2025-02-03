Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0489AC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 13:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D609806DC;
	Mon,  3 Feb 2025 14:10:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=inf.elte.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B17480087; Mon,  3 Feb 2025 13:31:48 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 349A58004F
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 13:31:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=inf.elte.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primalgamer@gmail.com
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-385dece873cso1981220f8f.0
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 04:31:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738585904; x=1739190704;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U1SxHNfK7J6z68rmR2xPxRpiGIbiRW4Vf5crjxdiLDg=;
 b=uupsy/uhn/f3M+suDgmNNVxx4cZTkP30fpAcW5j9g+vnr5RZrP71XMBDcHVM86T1Gh
 8OOiiZxxI+yKT93xJTOWwIqYdIBfYjGksaaFVLbsQWDBhcm/JbWqOnnMwxIPcFxNiFY1
 G6KPdgIrohHwLJ06xLvY1D8DeDXwRhAdoJKP7dvPZpouJVxq5jooJ8klSdqTvayQ6Yzg
 rLf5ERmKqo+KsSl9ENPAdqxJXX5JZqtDaF6KsRQ+ORY1/m4kGsFO3+s7mFkc+lmVOqJn
 zvb0g/rijr0HvSPhqd5Df1+aSupbUHeUTLtdJBhyEyXovC3ngvxIejuhgnE+S9g8KTax
 qMRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5CxjGEJMDtfzDFrDYE86SLCDdSogHBIqLvYvhlhBf8fs2zfff/2iLLVkUcwcE5xfsRyX3Igg=@lists.denx.de
X-Gm-Message-State: AOJu0YzapSc1bk83t+j77QpupaHoLRJQKsLu9QVntwrtPTpf5hzodx1t
 9ZfnrEm68FNF8lcRYKcTRRS6S2L6wXWacnUqT1ulFKEYTtjTVqhVRdjvPycx
X-Gm-Gg: ASbGncuySDFeMDFGKE3MDgefB2gGo8GhULt5k0cJK31s1ruD6kUz6kLi9zGc4J7iwe9
 JRaGniPAR78LSKUE1ia/bLLA7wqUSZT3yf+NeDzyWF4LYO0bwTPCueKONDlrYiG49geaJ53DUXG
 Pa3mEMuwSwD3KfReeskECsvQ1JRzjqeetumEcGGkW5OJxqEdDXN5ZD9uZDAbylP5r2gxxnw22zC
 6P5Z654bVDRxt6prV5v1j6x0vrUMx5toZVgwMmGLzyamcXfquYxELrDPty4//4XCXduZuG5QItT
 ovd1+wQoEpzKrbzzAPMZNv5n3Z99RwVKJf4=
X-Google-Smtp-Source: AGHT+IG7GjAh0qo9JI+9vLMfS6WOHQZtnVUxmJGfVjIqbNl2aWCcZZxhwNG6NPCXOp1uH3RZ88QwPw==
X-Received: by 2002:a05:6000:1a88:b0:38b:f3f4:57af with SMTP id
 ffacd0b85a97d-38c5208e9cbmr20409412f8f.35.1738585903643; 
 Mon, 03 Feb 2025 04:31:43 -0800 (PST)
Received: from [127.0.0.1] (login04.caesar.elte.hu. [157.181.151.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1cfa3dsm12840479f8f.93.2025.02.03.04.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 04:31:42 -0800 (PST)
Message-ID: <4ff910a006c5bb7c9fe1b460d426b4cf86059c28.camel@inf.elte.hu>
Subject: Re: u-boot in restricted environment: networking over serial
From: Ferenc Fejes <fejes@inf.elte.hu>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>, u-boot@lists.denx.de
Date: Mon, 03 Feb 2025 13:31:42 +0100
In-Reply-To: <9f8dcabf-339c-4051-82bc-178e0047f886@pengutronix.de>
References: <4fcb9244e87d5bb4a53075775247cecde2f9e3fa.camel@inf.elte.hu>
 <9f8dcabf-339c-4051-82bc-178e0047f886@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.55.1-1+b1 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 03 Feb 2025 14:10:19 +0100
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

Hi Ahmad,

On Mon, 2025-02-03 at 13:08 +0100, Ahmad Fatoum wrote:
> Hi,
>=20
> On 30.01.25 14:55, Ferenc Fejes wrote:
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
> If you are willing to implement it, there's RFC 916 (RATP), which
> addresses the use case of establishing a reliable communication link over
> serial. We use it in barebox to mount remote file systems via serial.

Thank you for the pointer, good to know barebox have such a feature! I assu=
me
the license permit what you suggest here, right?

>=20
> If you were to implement the same support in U-Boot, you could reuse
> the host-side bits without change (and take inspiration from the barebox
> implementation of the target-side bits).
>=20
> https://github.com/barebox/barebox/blob/master/fs/ratpfs.c
> https://www.barebox.org/doc/latest/user/remote-control.html

I'll look into this. This looks like an interesting challenge or even bette=
r,
add SoC bits to barebox (probably that is more work).

BTW I have a MT7986 based router and I wanted to install Debian on it. In t=
he
process I encountered even though the ETH PHY supported by upstream, and li=
nux-
firmware have the required bits as well, none of them included in the insta=
ller.
So I facing the same issue on Linux side as well :-) On FOSDEM '25 I notice=
d
usb9pfs contribution from you, I really like that idea as well!

>=20
> Hope this helps.
>=20
> Cheers,
> Ahmad
>=20
>=20

Best,
Ferenc
