Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC354CF34CE
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 22:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6002588D92;
	Fri,  4 Oct 2024 00:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RYxf+UZ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1C2088D94; Fri,  4 Oct 2024 00:25:24 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91EDC88D75
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 00:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6cb2e136da3so10569446d6.1
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 15:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727994321; x=1728599121; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sluDc/fjvCctn6AyJ1Xh2ZJ7sp0DKp8JXarJ1U1Qyl0=;
 b=RYxf+UZ8go5bQTjO6qiDAJzIQkDerrfgxoh++XyCVnjM+LcnZvhIKomyZgLFDOG+WK
 7BYY2QEkx8F7d+OQVjCYyT0HVIreGMwjmqLbH1vPbtoy+PfScx0bwaoJwhJNWyEZ7AMt
 VjdhbAanqO5wNzxxFHmzP3Pyl6gHfVtauN9lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727994321; x=1728599121;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sluDc/fjvCctn6AyJ1Xh2ZJ7sp0DKp8JXarJ1U1Qyl0=;
 b=Azkr73907SZwweQrVTSXtptp0ZkYNrqQwSv5NdYZRZQqS3Xbsn8D66BM/ynhLP8ZX8
 Do3/69zRsG6W3XE+z1OX8r/f8pMICQWBXZWEuJASl1QHg6H2/RNOMzCIRad+fR1D3kJj
 qn8sckoZjJA025g1YykvOT2OgIm8si6tXzChsSgJqF9FG+NlL0BPwFdB3qx8JZZt4sLj
 qtxnN3dg0Gvh8nqwuRgDysX1fqRcq71Rb4+/Bp3sh2EqpVhqpAGKj3Y9wrNqyKnNGxXN
 hEeTPWGgBLW7QINrStMqXyIGTzKYWQmvWj5MR2mcI4+KQ1NeT87Q2YphP6UmcJBYSgN+
 CW2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfDmoB+1fnx8yPOVnQq/a35mTgkCVLN/Y/bHePbT4fi29MDogjZYy1f7FlKWOL76hdlpjlvYI=@lists.denx.de
X-Gm-Message-State: AOJu0YyXiv/TUaIEVksJQZ7RlEF4IQzsJHzxl+uoN6D4Nrt3FkDMjBtT
 LrFJtFT671OT7F55cYYmhXC/ouDF6aiUSxOiwr52RulRKE0RpHtm+86bigqLMuo=
X-Google-Smtp-Source: AGHT+IGoZzsyRt4FPRTTkuXgf8E0+vP0ycBTXq0xxi6V5Puz6KOsT0JJW834Az/E1A83mvB8L4iZgQ==
X-Received: by 2002:a05:6214:448c:b0:6c5:acf0:400 with SMTP id
 6a1803df08f44-6cb9a4bd467mr9859076d6.52.1727994321084; 
 Thu, 03 Oct 2024 15:25:21 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb937f8b5csm10020996d6.106.2024.10.03.15.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 15:25:20 -0700 (PDT)
Date: Thu, 3 Oct 2024 16:25:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v6 25/37] board: emulation: Add QEMU sbsa support
Message-ID: <20241003222516.GW4737@bill-the-cat>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
 <20241002094832.24933-26-patrick.rudolph@9elements.com>
 <CAFLszTh-cEBp0-HP5XMONdwSUBepKWNgJSHLJfQ2VYW9FgJq=Q@mail.gmail.com>
 <20241003013516.GR4737@bill-the-cat>
 <CAFLszTgoD6YDpGTJLPxfqXoudR=TDDDAHQMUJzK+mxntpfhk4w@mail.gmail.com>
 <20241003144351.GU4737@bill-the-cat>
 <CAFLszThJ8ZUpq9_VVTxw6YwCmKqx1gghwinPx-=Srqc5k02UCw@mail.gmail.com>
 <20241003191751.GV4737@bill-the-cat>
 <CAFLszTi5nj-tXuO+UGJSPbJxqFtwQXkN8UsjT2hi1LF6zGLFHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="df5vWNSfV0tk6zUD"
Content-Disposition: inline
In-Reply-To: <CAFLszTi5nj-tXuO+UGJSPbJxqFtwQXkN8UsjT2hi1LF6zGLFHg@mail.gmail.com>
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


--df5vWNSfV0tk6zUD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2024 at 02:46:03PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 3 Oct 2024 at 13:17, Tom Rini <trini@konsulko.com> wrote:
[snip]
> > We don't, but this isn't quite a normal board?
>=20
> Don't be surprised if this becomes more common. For better or worse,
> ARM has decided on ACPI for its servers and RISC-V is following. We
> also have the EFI app, which has a devicetree, although of course no
> actual addresses.

True. And U-Boot being able to take and reasonably as far as the OS is
concerned be the UEFI implementation in UEFI+ACPI boot opens us up to
being able to be part of the software stack that's certified for
SystemReady ES and SR. On that real hardware we can certainly expect to
mandate that the previous part of the firmware stack gives us a device
tree. It will be TF-A and so the "pass over a device tree" part
shouldn't be an issue. And since yes, really (and for the future
record), real hardware isn't allowed to fake this out like we're
allowing here, today.

Heck, it's possible that down the line and it's important to a lot more
people, we can get the TF-A build for QEMU SBSA to have an option to
include a device tree for U-Boot, because it's an important part of the
stack for that project to be able to validate too.

> > > Breaking down the SBSA_UART_BASE_ADDR:
> > >
> > > - this is in the uart0 node so obviously relates to the UART
> > > - it is a reg property, so BASE_ADDR is obvious
> > > - SBSA is the board name, which is in the filename, so don't really a=
dd anything
> > >
> > > Normally where the devicetree needs a value defined, we put it in the
> > > dt-bindings directory. But even then, we don't typically put addresses
> > > there. It is just for cases where we need the code and the devicetree
> > > to be in sync about a property value. With addresses, the code reads
> > > them from the devicetree, so doesn't need to have a #define to access
> > > them...in fact that would defeat the purpose.
> > >
> > > If we did this sort of thing with other boards, we would have a heap
> > > of binding files containing addresses that are only used in one place.
> > > I just don't see the point.
> > >
> > > However for SBSA_PCIE_MMIO_BASE_ADDR I see that it is used in the .asl
> > > and the memory map, so it seems fair enough to define that, at least
> > > unless/until we can refer to devicetree addresses in the .asl file.
> > > Even with this one though, I would expect something like:
> > >
> > > ranges =3D <0x02000000>, /bits/ 64 <SBSA_PCIE_MMIO_BASE_ADDR
> > >
> > > SBSA_PCIE_MMIO_BASE_ADDR>;
> > >
> > > But in this case I can see how a macro might be more convenient and
> > > I'm not sure I have a strong opinion here.
> >
> > If you're strongly against using the macros here, OK, fine. But since
> > this tree is only going to be read by humans in U-Boot, and consumed by
> > U-Boot, I think it makes sense to deviate from the norms a little, in
> > favour of human readability.
>=20
> How about only using them when there is code that need the same address?
>=20
> There are two lots of macros so just to check we are talking about the
> same thing:
>=20
> - xxx_BASE_ADDR - IMO they should be open-coded into the devicetree if
> it is the only user
> - MAKE_PROP - IMO we should use /bit/ 64 instead

OK.

> > > > > But I very much doubt upstream would accept it with a macro. Other
> > > > > 64-bit boards seem to use '/bits/ 64'.
> > > >
> > > > What upstream are you referring to here? I'm not sure what other pr=
oject
> > > > will want a device tree for the "no device tree only acpi" virtual
> > > > reference platform.
> > >
> > > It depends if they want to run U-Boot or not. U-Boot always needs a
> > > devicetree, as you know. It cannot use ACPI tables to configure itself
> > > and I would rather it doesn't start.
> > >
> > > I don't actually see any reason why this devicetree could not be
> > > upstreamed, except that QEMU actually creates a Linux devicetree right
> > > now (on the ARM side) and takes no notice of what U-Boot needs... I
> > > don't see any U-Boot patches from the maintainers, for example,
> > > although I may have missed some. It seems very focussed on UEFI. I
> > > would love that to change, as QEMU is widely used in U-Boot on ARM...
> >
> > I feel like we're lost the point here. This platform in question is the
> > "never use device tree, only use ACPI" reference platform.
>=20
> never use device tree for Linux
>=20
> (U-Boot always uses it)

True.

> > This is not
> > the regular "virt" platform, even. U-Boot needs a device tree because
> > internally we use it for configuration. I do not see the QEMU project
> > agreeing to have this platform generate a device tree for us to consume
> > in this case, declaring instead that it's a U-Boot internal need and
> > that no, it's fine if U-Boot can't use it. _We_ want it because it makes
> > testing of the aarch64 + ACPI use case easy because it provides us with
> > the ability to use the reference platform too and make sure that we
> > aren't breaking the OS in unexpected ways.
>=20
> OK, well as you say this is not really the main issue, so that's fine.
> I agree (and was lamenting) that QEMU seems unwilling at present to do
> anything to assist U-Boot.

At least today, I don't think this is even a QEMU issue, honestly. A
point could be made in the future that EDKII will ignore TF-A passing a
device tree, and that also needs to be confirmed / validated because
<physical hardware platform> supports EDKII or U-Boot for ES/SR
certification. That's a much stronger I think position to start from in
asking QEMU to pass along the device tree that it could make.

--=20
Tom

--df5vWNSfV0tk6zUD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb/GcQACgkQFHw5/5Y0
tyzPuQwAoWbHrDurEPE0mLMNDwYLTH06qmKdQOz5/oAbrw5oI+MILNez+9VLLFjw
5VO1uVLAyAQlApjTnM4ljBtPx1bqYQAf4ENHNa9YbaOjML5sZFq/MgTCkAStnAtg
MOdEtrOQ7JxS0bXpkYhDx4USs6YNUzk4zGqAp2uCLve+BUEDOpF6McRBTFncvwKK
FAdJBcIwzYAt5pACaxmr4moCTMZUVs1XYbXWeLm6KaNkwE+w10oAiFkOdDZszzxa
05YOfrV0h5GYNBcgKiKI2fAgi9RwweZYf4xbEkzVlnG3HXw6apDuszFJx2wUcV1d
9r8WDwkrwpK/x11g8B2+wMvhBnFiMUu9tS0UrlQ16PaLT1ss0a6IXrwAD5BGnWXN
ZbKQzufTX9jH9K3o1AqBHycIaLzlwYV/nj/IO3i1A0+3cwhhNeMvXZHgObUwMPSK
6PTSt6FyMk9zevycY4N0mX5zMy6c76EFtPWlSZGFnrybH9I3uH3aeIo77mLMEFvv
K68D4lrS
=mU1/
-----END PGP SIGNATURE-----

--df5vWNSfV0tk6zUD--
