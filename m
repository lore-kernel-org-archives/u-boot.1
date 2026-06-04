Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2101BCD6E6E
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 23:10:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DA8084931;
	Fri,  5 Jun 2026 01:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IpdzimnN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6AD084944; Fri,  5 Jun 2026 01:09:57 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E525848BF
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 01:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7e6db226e1fso907764a34.0
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 16:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780614594; x=1781219394; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IxWutOivOdylvsYXIwoHxMVPsHuV0FOwM/iiKtuMA8Y=;
 b=IpdzimnNh1cOvlLQOdDY7uRS80fZgarI6+nEgKqEVbJTf2248pNqB2aO3Htg6f+2zx
 1dyzXuvlKVLxO40YsZazuV6A7Ypp8buxGDPKfhNxTxfP4EId0ika2ymxbe/QiGNFyhId
 ciW7E1ocabp1deBvVDfaiy7buCNsSSrd4T1cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780614594; x=1781219394;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IxWutOivOdylvsYXIwoHxMVPsHuV0FOwM/iiKtuMA8Y=;
 b=ZjNXetymJutfiiUt/qsq9Shl1dgCdmfC6lwbxqPtuG+axT3UPwM7N7nxNYNnIpNNe+
 KW6EK7UsSGJx0siMzUF+3qvH+4SkKzL69IjbiXrnMhGhU1xviuf2kzjEbUOD7CryEAOl
 8r2mLl4SWeWHbj5qUROeKis8nNPECJZzeZUITYmHcrVCL6v8o0lO7eXS99iegXVS/r+T
 nCNeFxsdPcAimH5lZ/5OxfQrKadAAwS4n5x0b6bKevqcxRSagqZMTfeTCnPlzF+8Oulk
 elY3gHmVh6kUdZnrqMYc006rH7Hj/mEYcS3HqZCysGKWLBrmVBUJARust+KMX8081cU6
 0tBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/JPjgEXzRz5VFVia97Mi711tMT382iqdALmfQPXpJ0LXkxe3xCbVtX/ovpgfKX1LnpO0x0MWg=@lists.denx.de
X-Gm-Message-State: AOJu0YzhZYy97Pef+2q5u3BLBa1DdvR8JGbyzWM+XvHonRF8l7ubcUj+
 SdHBa4KFaCInEzNud0vLXzrm7emXffIrpnMbLdlwO+LN6ljXTyKpJJEvO8XZwfK3AwA=
X-Gm-Gg: Acq92OEkOu0gEeWPvQoVO33p72jofnSb9VVjUA230WiKLVUe4gx9wUbzdBWDc6e0Ej2
 jOb9ilYOBI0w64b9NG7kjAcgcgvwEvofgmpSscfnZxJeJ+6TFfNrfVEhDuzSlh6Ptjehupe8+Eh
 WCJ7dfS48hIhFsPv58EylSGRDNDxLO7OIrjbpQEh2TqpaBTRr0HHYp597rT8WOaRrRMQRXwoOH1
 QomkM7TEfHZW1pPmbDwKumAdoG6nFGDWFW4k9FS39ocNuZsUC6v1FBZzd0bhSqHt7B9YY//rqpR
 Bm8FGz8vkLr6VYozJrvII+no3KPtA4BK5IZIoH+9u6DSqzWKzwzJCDpwZKLAZyDKs5B2OyEKUOZ
 2eAwlMyTc0Qb2IOGHysWXtK9CKbwVZn7D/8LP1G8hmwchEhyeiIvJfb/kF84tuJyfqOp5UXw8g5
 Pwgd4HOvE0gva7CBoFSOLmKn/z2YVfiBEZAHk7w73EzleTVw0D3Jq7JGXs7Exu0O/3KGtQA0g0c
 UEm3V0S9ETyVDJop8po1nf+SDRTYuZk4QVFWl9G35IT3r9CEoLYU37y2/rvCg==
X-Received: by 2002:a05:6830:4990:b0:7e6:ce35:4b11 with SMTP id
 46e09a7af769-7e70ca611d6mr485299a34.20.1780614594199; 
 Thu, 04 Jun 2026 16:09:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e78dd7b9sm4842971a34.15.2026.06.04.16.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 16:09:53 -0700 (PDT)
Date: Thu, 4 Jun 2026 17:09:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v5 1/7] treewide: move bi_dram[] from bd to gd
Message-ID: <20260604230951.GX627328@bill-the-cat>
References: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
 <20260604073719.48723-2-ilias.apalodimas@linaro.org>
 <89b2f624-796b-48b9-92b9-4739cc64a497@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Vto159T+9SYaDYbt"
Content-Disposition: inline
In-Reply-To: <89b2f624-796b-48b9-92b9-4739cc64a497@mailbox.org>
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


--Vto159T+9SYaDYbt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2026 at 12:31:10AM +0200, Marek Vasut wrote:
> On 6/4/26 9:37 AM, Ilias Apalodimas wrote:
> > Currently, the bi_dram[] information is stored in the board info
> > structure (bd). Because bd is only valid after reserve_board(),
> > dram_init_banksize() must be called late in the initialization process.
> > This limitation is problematic, as it forces us to rely on a variety of
> > bespoke functions to determine board RAM, bank memory sizes, and other
> > early setup requirements.
> >=20
> > By moving bi_dram[] into the global data (gd), we can run it earlier.
> > This is particularly convenient since boards define their own
> > dram_init_banksize() routines, which do not always rely on parsing
> > Device Tree (DT) memory nodes.
> >=20
> > Additionally, U-Boot defaults to relocating to the top of the first mem=
ory
> > bank. While boards currently use custom functions to override this
> > behavior, having the DRAM bank information available earlier in gd makes
> > relocating to a different bank trivial and standardizes the process.
> Regarding the BD, this is likely really old, but it seems BD might be pas=
sed
> from U-Boot to Linux somehow ? See [1] and U-Boot
> include/asm-generic/u-boot.h :
>=20
>  8  * NOTE: This header file defines an interface to U-Boot. Including
>  9  * this (unmodified) header file in another file is considered normal
> 10  * use of U-Boot, and does *not* fall under the heading of "derived
> 11  * work".
>=20
> Are we certain we are not breaking ABI here ?
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/arch/powerpc/boot/ppcboot.h

I've added in Christophe as the maintainer of one of the active and in
some ways oldest (since MPC8xx is very old) PowerPC platforms we still
actively support. A tested-by on this series that also includes
verifying Linux still comes up would be much appreciated.

My suspicion is that anything DT-based shouldn't change here, and in
turn if you're doing modern U-Boot you're probably doing
not-extremely-ancient kernel and so DT based booting.

--=20
Tom

--Vto159T+9SYaDYbt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaiIFuwAKCRAr4qD1Cr/k
Cg35AQCIxRrGWoHWN8kPjZuGOr2Y2uI5UAkuTcpSYZbdVFbZzQEAj0DYFa8JZ9p1
I0xloKEIkISpU8wg7ba38vrDLnxNFAc=
=9ILQ
-----END PGP SIGNATURE-----

--Vto159T+9SYaDYbt--
