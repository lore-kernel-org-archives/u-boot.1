Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D1BC021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 19:10:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E75FB80F56;
	Tue, 25 Feb 2025 20:10:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pc9v1cAO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 921F280F96; Tue, 25 Feb 2025 20:10:39 +0100 (CET)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C6EB80F56
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 20:10:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-868ec803d83so1761535241.3
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 11:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740510635; x=1741115435; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jB1lGNPRS6K+/SKBHtPiSoGo0YF8l+MQ/ekB7Gc5y7c=;
 b=Pc9v1cAOUPuOi9m6sHLFO7vpc5k20aXHJoBOJmZ/COFHJkY5W3OQnpTk1im5wgHGLe
 XgOBf6BBM6gmdIaewCTknJtUHvx+bmlbnicx4hhYtQSNcVwtLpu2+tPXNcMTq+xCLy9S
 46Gs6biMc8wAR7AHsoxD8tv0S1XuePXkzPIwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740510635; x=1741115435;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jB1lGNPRS6K+/SKBHtPiSoGo0YF8l+MQ/ekB7Gc5y7c=;
 b=twnEjA6a+KPopO1jETqOMYYj09VHuP4fVIreiZhgEv1poQClz+aBC1QD7YT0bYmgvz
 E2F7U5gsY+6uViJ0ybqlU5pBbLAbdTdPqLwMnjPuPTWHz91jhnkXrRCNVHBVBvWMR0sA
 widd5fDcqKk15eSFduXQgjU4+4I55Z4kIWO1IBpp+o5RJlDiFmwZ7n3yl8G4qSAa8cAQ
 Xi6ee0WGYC5+NHpiX1cU+gjo1TG58BnYEOn50oLg6Y8ug6c0T4pwe9e/LDxmWWlDSX1f
 IhNzNRVzLpepwqxavCDmO+xYi2+FZh7/xD7INJlRQgFxBvyv8c12ARIsvgixmvDMTSQi
 V4XQ==
X-Gm-Message-State: AOJu0YyMce4TZwVyd+zK2Z7+n0nFqOr8BCO48zeY9FfNjXFVjirzPZiv
 XmnhlAdSnB5VzSfn3EKJf1rNwyBXrxJZfaOrc8Dxngyp0G27LVCi+V5eMdUGOOCDMFReNgPjtI1
 5
X-Gm-Gg: ASbGncs2TTHD1R0O7waD6VrrTwr39Z/8Ao05SVJmrYis06F0Mf8HJDqqAMb1+CZPthv
 dkGFqdrLMAuCno/JNk8BRHmlLC+5v+dAISIuOfhEkfX5cmmjKNCmLN7tsEPca0CKYbf4XneL/vH
 4jqQBsDxpjxDD1as2mYHLrSpHo2/UTgPm0oGdFlPE/X9aQYNcF8kubBpVllLecpaVDAqoqIaYgW
 bTQLUksyVI6GzOUkTnzZwN48+aq6OyzAHDS6Cu4TfMQzGTj657HwaC9ZPlVU8QW1YX0LIcx+msM
 6RU4BxCLc2rCSLO3NwlLRTjl
X-Google-Smtp-Source: AGHT+IECzFnQ5omgGX8C60vWcs//eizPU483m0V796Nvqnj8Ngs/sFY++2eII2s+vOTAqb3X/fxfJQ==
X-Received: by 2002:a05:6102:508a:b0:4bb:dc3c:1b49 with SMTP id
 ada2fe7eead31-4c01e3030aemr300446137.22.1740510635193; 
 Tue, 25 Feb 2025 11:10:35 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4c00c72fde0sm347552137.26.2025.02.25.11.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 11:10:34 -0800 (PST)
Date: Tue, 25 Feb 2025 13:10:31 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2025.04-rc3 released
Message-ID: <20250225191031.GS1233568@bill-the-cat>
References: <20250225164121.GP1233568@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GNoOTE0QKkKy97DP"
Content-Disposition: inline
In-Reply-To: <20250225164121.GP1233568@bill-the-cat>
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


--GNoOTE0QKkKy97DP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:41:21AM -0600, Tom Rini wrote:

> Hey all,
>=20
> Well, oops. I tagged and pushed things, and wrote this all out
> yesterday. And forgot to hit send. My fault. So it's the day after the
> release, and I tagged it all yesterday but here's the email for
> v2025.04-rc3. The -next branch has been open for two weeks now and I'll
> merge this in there shortly.
>=20
> Continuing on with what I started after the -rc1 release, we had a call
> today and the link was
> https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DN280=
N2tlcXE3aDVtbjlicnNkcm82YnA1bDAgODliZTdiODEzMTM2YmVjMDZhODNkZTRkYTU5NzQ1ZjB=
hYmQxMWMxYjgzNjA2MWFlMDZjMWM3ZGJjZDE4ZGY0MUBn&tmsrc=3D89be7b813136bec06a83d=
e4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.calendar.google.com
> and once again this is the same time as the previous meeting. The
> meeting details itself are:
> https://meet.google.com/btj-wgcg-euw
> February 25th, 2025. 9am (GMT -06:00)
>=20
> To join by phone:
> https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1
And here are the meeting notes.

- I gave an overview of the master and next branches and asked for links
  to regression fixes that I've missed.
- I noted that in my queue are some ARM FFA patches and that I had
  seen something go by today about EBBR and FFA versions and asked
  Heinrich if he had any comments. He said that the patches we have
  today do need to be reviewed, and the EBBR change is to be backwards
  compatible so there's no rush.
- Heinrich asked about the status of U-Boot as an EFI application and
  arm64 support that Simon has been working on and how close it is to
  being merged. Simon was not on the call yet and so I said I don't
  know. I said it was built on top of some parts of Caleb's series that
  wasn't directly related. Caleb explained their series overall and
  reiterated that it's for a different use case, and some work in
  general is still needed. I reiterated I don't know the intention
  because it's against Simon's personal tree.
- This moved on to a general question on how to get the Qualcomm arm64
  laptops working in Linux, and it's something Caleb's group in Linaro
  is working on. They gave an overview of the general situation, of
  which U-Boot is a part of possible solutions.
- Yannic Moog asked about patches he posted for binman and external
  blobs, and is kind of stuck right now and asked how to get more help,
  I said to setup a video with Simon privately.
- Jesse T noted in 2016 someone posted a patch to disable u-boot
  relocation and asked it that would still be objected to. I asked for
  the use case, and she answered it's a 512KiB system. I asked if they
  knew of GD_FLG_SKIP_RELOC and did not. I noted XIP may or may not work
  in full U-Boot as I'm not sure it's tested currently. Heinrich noted
  that for RISC-V and QEMU, using U-Boot as the pflash payload with
  CONFIG_XIP does work and is documented. I suggested this means that
  generally it should work but there might be some ARM-specific issues
  to resolve.
- At this point, Simon Glass had joined the call and Moteen Shah and
  other TI people asked about bootph property propigation and
  https://lore.kernel.org/all/20250212091820.213895-1-m-shah@ti.com/ and
  what to do next. Kernel community advices that the bootph property
  should be in the child only. Simon wanted to clarify that this is
  indeed for prior to full U-Boot and just SPL and why we needed to add
  the properties. Simon got clarification that the devices are only to
  be bound when the property is present. The parents are missing the
  property and only the child has it. Simon suggested calling a
  recursive function to find what needs to be bound. The question is,
  what is more efficient and wall-clock quicker. Simon asked for
  benchmarking of the recursive method rather than the patch linked
  above instead to confirm his suggestion is slower, as he suspects it
  should be faster, not slower. Caleb wanted to clarify that don't we
  already check every node while binding, and so this patch adds work
  and don't we already have some code that could be called already?
  Manorit asked where that logic is, and Simon wasn't sure if we did,
  and repeated his idea that ideally is most efficient. Manorit asked
  about the binman solution Simon had also mentioned, as he's not sure
  how it would work. Simon confirms binman modifies the flat device tree
  where it needs to. Simon will provide some code pointers after the
  call for clarification. TI will try the algorithm approach above first
  and if that doesn't work, binman.
- Anurag asked about if TI should be using env nowhere or having people
  default to using env default -f -a, in response to some feedback I had
  given them previously. I asked if this is a TI specific
  question or just general best practices. I gave my opinion on how
  it should work, but it's up to indiviual board maintainers to pick
  what they think will work best. I will check on the status of:
  https://lore.kernel.org/u-boot/14701984-073f-4976-b0c2-e2c42dadadd8@ti.co=
m/
  after the call.
  - Follow-up: I had set that to superseded by accident and have since
    merged to next.
- Caleb brought up a more generic qustion, how or should we have a more
  generic arm64 u-boot build. This is related to both the the thread at
  [0] and also Stephen Boyd posting support for a Qualcomm platform
  chainloading from coreboot. Caleb notes there's a large number of ways
  today to pass memory information on qcom platforms as well as to just
  boot them. This will be a mess without some careful planning. Perhaps
  we could have some generic way of checking for some of this
  information and using it, to avoid duplication. This could lead to
  being able to have a more generic image itself. Is there interest?
  Feedback? Tom said yes, but need to be careful about single platform
  support still. Heinrich noted it also needs to be a consideration of
  what the end use case is, are we aiming for on HW itself vs provided
  by the distribution. Caleb noted one use case is HW automation and
  testing, for example citron(trini: I'm not sure I caught the name and
  a follow-up link would be appreciated). There, adding a new HW
  platform is very straightforward and automated. Having U-Boot be able
  to fit in there would be very useful. Other than that, some use cases
  Caleb envisions might be new SoC/device bring-up using U-Boot to start
  with as it can be easier than Linux, mostly about simplifying support
  to new platforms. For example, lots of kernel knowledge in the
  Qualcomm and phone-device community (trini: postmarketOS for example I
  believe was mentioned), but less so of U-Boot. And here, the user can
  only chainload U-Boot anyhow due to lockdown. I reiterated my general
  concern about needing 2+ examples before designing something generic,
  and so to sort out handling Qualcomm first. Jesse asked if we would
  have U-Boot have tons of device trees or if it would be passed in via
  ACPI or similar. Caleb says it depends on the part. Some cases we get
  DT passed in, and in maybe we have some platform specific logic. Tom
  reiterated having SPL figure out the DT and pass to generic full
  U-Boot woould be his preferred solution. Caleb pointed towards barebox
  as an example that has this today. Simon asked about Caleb's comment
  about getting the memory map from coreboot, and how that works
  exactly. Caleb wasn't sure off-hand. Ilias noted that linker scripts
  for EFI runtime services / linker scripts need to be cleaned up due to
  some potential issues. After that, a common linker script for all
  boards could be done, and this would be moving in the direction of
  having genric images. In the chat, Simon says: "I'd like to see more
  generic stuff. When Linux is 40MB uncompressed, we can live with
  U-Boot growing if we are getting benefits from it".

[0]: https://lore.kernel.org/u-boot/b5d2bd37-4424-4660-b5c3-d505e5485ced@li=
naro.org/

--=20
Tom

--GNoOTE0QKkKy97DP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme+FaQACgkQFHw5/5Y0
tywz/Av/QvKvOqCr8mxJvFpjy5Z+fKTaFLf4nhb+HcsbLmQSZkrnqtfgttWFOuWq
U8WZ4e61+selapnm9veIOcdRuOtZxT5yLo+/V3o/Oy6Q/YSpjfHWaJiEgjBU8bDX
DTT92Jzno+6bd3Ffn1cXN8KcskJ6hiQGKDu7azSntlvjCKaSlxfszJ5X5mrRRT7j
klhB5x6XhsRE+UnjmtlWIrKzXwbzcbaOoaRWW49NFBwWie6/LFuB6pmpSZ5yDU20
PUyZxz+7+O+nTbUx8MhQNX+naXk3gHPmjPuMDd06tlFpSno1RKEH/EiTbv74M7ay
nIcPUiFGm/QxYRa7P6mIiudZiyR/tnt8sOFGkbkvpAUSMpeUPZHWHQ88FlnBU+ZB
e1uDQu9EaGD0Ei4uiTcraTTHMXzQnlUp2NTpSjT+YX6BkUyGVeku3e2rZvZbgA1p
egDJYHBc6MZCcr8gXaG+Ij9AQu0h4G/x+QarkJ8ZzP5DuByCDlvs++Dw9F9qo8uG
cO5ilX8Q
=TlK0
-----END PGP SIGNATURE-----

--GNoOTE0QKkKy97DP--
