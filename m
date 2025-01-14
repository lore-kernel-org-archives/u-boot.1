Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DEBC02180
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 01:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 973D4806D4;
	Tue, 14 Jan 2025 02:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mDUgz64b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5024280658; Tue, 14 Jan 2025 02:22:34 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DFD08061B
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 02:22:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b6f19a6c04so449177585a.0
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 17:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736817751; x=1737422551; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RAnHY0vGA02Eeb0lLGrZbXLXrMwvMQxUNzUhrA/hFsw=;
 b=mDUgz64bajlV0VGpdBoFFXsE/YkbFi3ljtLDxSdQyhJ/HzXUrNdtxJ6CZjp2jk0brn
 vkfpxJGMNiYZwTmMGg6VcpCSHR0KYEKfHiypZpiy3eOULo7Ct6GNKT0wX/aGZ2ir7s5I
 4KL039UN9HF8zfq7oFaZhpD/WPLWHbo2ClqWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736817751; x=1737422551;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RAnHY0vGA02Eeb0lLGrZbXLXrMwvMQxUNzUhrA/hFsw=;
 b=Ztwf2xzKCQ8I1fT+zTGnv9MXhyFvnfEvisRxLkfSmWHGFUXLeTC30zXppt+Y/TpQD4
 42cfbVi+O9aXQJRvJoOVFiEJHk/rimgcd4Z93EF5J72x4GUoWYWIhAocbdPS2Wg7I9d2
 LTur1LGglYclUY9NzpNi2unOVKPJZUFxqKQMVFwq7CRgomylG6pzzNoFkvJgOg9GubJZ
 MCfGfNmdoC9K8fP3gu3pRvRUbrWt3FnqJ0vGVxzbuek9H4k+/zjoqJfZOGI8dt6eScwP
 x79mUZta7AzSRIt1r1B/O6LjnWV8wkheaUV4JnnZthAow03ZxAQ88an3jHvsrXfqZB05
 QuHQ==
X-Gm-Message-State: AOJu0YxsQYaTrmjhuu/bgrA/qsHt8znM6Qc1hoePViuv5uz9c5m+Z3/4
 kJuag7ApBP5tBKba5VF6xyKr9aORXTLpf/H7HVwMTnX5D2GJZKISvg5RhSRjNsU=
X-Gm-Gg: ASbGncsHpYn5Ds59htYTJV7AxbkurlR8mMlixCN6WOsdzpLjcqWUxp5yOV9p/UUYurF
 pOSCz2670a+f0/j0Fk9IHcvUS/VVUiGZwzqs6b6nvpBsz43IryshXQryvM1eZOOJHEFqKs2y4Px
 jr+n811/kvCf+Bu3QioWC1eC3rRH8WRMpMXJs2UOcpir7ULikyZP9p3oPjQ0Qm9Igp/47hAHAje
 AThGbpyxNcKcyIKduVqKUqg3y9DpTu34NZS2bMdHc8p7UvTDSKqJsGw+Q==
X-Google-Smtp-Source: AGHT+IGRxAtUJtMXZ7H9A0O34fPOkIxpJ6eCGHAJla9yPOodzfKTEYQR4fgPJCzS7xAAas6PKKMK1w==
X-Received: by 2002:a05:620a:2596:b0:7b6:670f:b91a with SMTP id
 af79cd13be357-7bcd97af970mr3452781985a.43.1736817751061; 
 Mon, 13 Jan 2025 17:22:31 -0800 (PST)
Received: from bill-the-cat ([187.144.100.247])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce3503185sm555582385a.95.2025.01.13.17.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 17:22:29 -0800 (PST)
Date: Mon, 13 Jan 2025 19:22:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: [PATCH 01/15] vbe: Split out some VBE code into a common file
Message-ID: <20250114012226.GG3476@bill-the-cat>
References: <20250109123010.4005298-1-sjg@chromium.org>
 <20250109123010.4005298-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qcFEZMu0FszdQFWL"
Content-Disposition: inline
In-Reply-To: <20250109123010.4005298-2-sjg@chromium.org>
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


--qcFEZMu0FszdQFWL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2025 at 05:29:56AM -0700, Simon Glass wrote:

> Loading a FIT is useful for other VBE methods, such as ABrec, so start
> a new common file. Add functions for reading the version and nvdata.
> Also add a function to get the block device.

This is not a good commit message when you're also introducing
functional changes (blk_dread -> blk_read). Further, this functional
change seems to introduce some other code being pulled in very
unexpectedly, and that needs to be explained. For example,
phycore_am62x_r5_usbdfu is another case and that has
CONFIG_BLOCK_CACHE=3Dy but CONFIG_SPL_BLOCK_CACHE=3Dn, and yet the size
growth is in full U-Boot. Just moving code should not result in
unexpected size change.

--=20
Tom

--qcFEZMu0FszdQFWL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeFvFIACgkQFHw5/5Y0
tyxxAAwArU1t1EHeUw083SPskndIjjY6aehe7XsMyiIOZYE3WyfKM+qhAppLwRkd
tDjiCcqm7eahKxKQLm7W/oLUwrOvf/YhgX/5OJOPgBe5sBUTy232oAWPEiOHJvdD
eCmrockv8IYWdwEZdlvXGIwnaAyreF4wQ2i9BQRMK3xTlONElNA4F27iyWr8vJp/
rIMztODoUpoPXX6t542V/OzGwXhTK4ujAIaBy4F2OE4A4yJseioeaeD2nMA620X+
DkodLVkSxtX3oiGT+e61ys3MxcH0AKlshmEbP716iS7i8D52mpuxpfF86gCPWOAO
m8grDpDeAZAif8uTEnYJuQPDo5FW0D/6xmMPFT5vqDuQS1gYEi/hycmsl3wm3CxP
ghkbhI5bcSSuWHnVTCykqQgJa6JrO4N5iXlW9bZabfTzMi4rVe4OM2pWSiEFUac/
aLaZ6cvOWaf5ubvCpOY2b4i+C1xrUZhpQ5BRmhIpHqT3cSif3LROiPDWjH/A8GsN
C1A7xHPr
=GAgZ
-----END PGP SIGNATURE-----

--qcFEZMu0FszdQFWL--
