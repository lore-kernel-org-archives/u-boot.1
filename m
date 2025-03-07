Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BCAC19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 15:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F0D281298;
	Fri,  7 Mar 2025 16:58:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KxD1UbL4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F36581420; Fri,  7 Mar 2025 16:58:17 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB3ED8122F
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 16:58:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6febf391132so10593917b3.1
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 07:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741363092; x=1741967892; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1zEAtTKZhjjUO9M/Oa98brOsuOFulVqW+O8YlZfKfLs=;
 b=KxD1UbL4mxgar/GZS7pzmndmZg9A3Cp3ZYMoetIG+PkbW3SFbBiOno+dhW0kc4G75T
 hWJ6E87txzOW+9RBLULhyKESSfhTRIt57zI4xNSpsUpH6gina7jcLqKu1vKmfmZc/g5R
 1Qto0vimNT8QXStWOEts5QIq7sttgksk8UZJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741363092; x=1741967892;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1zEAtTKZhjjUO9M/Oa98brOsuOFulVqW+O8YlZfKfLs=;
 b=CLJNQrfYAjZDm2h8Sp7mLWDT7MWeE1i5epqp9dAPB9ZLZeWsbWFhxhtDgvHXogfcRG
 MzGQiMhmusJVfgaAIdQuzJUqSVLqlQZOF3V3uvBcnEmUeNTSaPQ3ROIFz5geFLffZGmj
 eIY5PXQ9bhH0N3p7sElBSSxCtYNYyWrvyYrC9AqCIcKSnQUhX4ZHqJZcoCsulL0bc2WS
 MavCUeiq902CEVx2tfHucshiY1bbJ1Z9VMH2x2e/3zxHrvfP6EKkJY/tbmIUmAn+LrDE
 Pst5UfkmphFgeE3RBGN+NWvZIhybKLwPtoAjY1cPmImXwN2KDkFZou6YlMIMOeQ3PWRt
 uIfg==
X-Gm-Message-State: AOJu0YyBokUpX2zht+EeOBcM6VOWqhkipkdS+I8wtz4ZxUo8wNJPGj0T
 SeVE+CCaAL5LYr3xlM4eeWbyyyN5b2JrPS5YCdLZ+9gfbsTAxQLa9ycqBwz+DmA=
X-Gm-Gg: ASbGnctu+pqT1tD+XSru9GncMz6J8pOnvZpRjDFQlX1wrKpBi7mmYlNpO4fME7TLGCQ
 zf1VWRq/vvrV3df6rLr/iJKRwoOmGuVkRThArYiJgRWdVE9TchPNOCqnt9FxJuDxaMr5VSMPtKS
 sVWwVmarhkJu+FZTg9oH9y393zWtHeAmC+Xa3BKC4loGk4P0msAD6Qs//MqCyJMTeqSVyCmVo8K
 LtfH0hSQ6fRobMAovuhMvLbGMfyBTkO7AldBWUxyJXHQo/uv0yJidg1lvfHLglDsa4sKILKX6oM
 6d2b8ZMbhaoo5iRsTpp5+HV2yGeS2YGHmtg2BSn5d5NNCg==
X-Google-Smtp-Source: AGHT+IGSGcplfJfr7XDXe55UVuHwV+BF1XbquXaszg76YEsv5fdXG1HHO3ah2wQsyR5HcgWQnQj7Ig==
X-Received: by 2002:a05:690c:6209:b0:6f9:7b99:8a29 with SMTP id
 00721157ae682-6febf38dc37mr55831277b3.34.1741363092643; 
 Fri, 07 Mar 2025 07:58:12 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6feb2c304c4sm7750547b3.80.2025.03.07.07.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:58:12 -0800 (PST)
Date: Fri, 7 Mar 2025 09:58:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com
Subject: Re: [PATCH 09/10] config: add falcon boot config fragment for am62x
Message-ID: <20250307155809.GR2640854@bill-the-cat>
References: <20250307075541.2571104-1-anshuld@ti.com>
 <20250307075541.2571104-10-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fJyVUiNn3r99feCu"
Content-Disposition: inline
In-Reply-To: <20250307075541.2571104-10-anshuld@ti.com>
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


--fJyVUiNn3r99feCu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2025 at 01:25:37PM +0530, Anshul Dalal wrote:
> This fragment enables falcon boot for the am62x, 62a and 62p.
>=20
> To have enough stack and heap space for loading kernel image as FIT, the
> memory map was modified as shown below, the PRELOADED_BL33_BASE in ATF
> has to also be updated to 0x80200000 since the kernel requires to be
> loaded at 2MiB aligned address.
>=20
> Memory Map (changed addresses marked with *):
>=20
> 0x80000000 +-------------------------------+ Start of DDR
>   512KiB   |   ATF reserved memory space   | CONFIG_K3_ATF_LOAD_ADDR
> 0x80080000 +-------------------------------+
>   1.5MiB   |            Unused             |
> 0x80200000 +-------------------------------+ PRELOADED_BL33_BASE* in ATF
>            |                               | CONFIG_SYS_LOAD_ADDR* (load
>    30MiB   |   Kernel + initramfs Image    | address for kernel)
>            |                               |
> 0x82000000 +-------------------------------+ K3_HW_CONFIG_BASE in ATF
>            |                               | CONFIG_SPL_PAYLOAD_ARGS_ADDR*
>     1MiB   |          Kernel DTB           |
>            |                               |
> 0x82100000 +-------------------------------+ CONFIG_SPL_LOAD_FIT_ADDRESS*
>            |                               |
>    55MiB   |Initial Download Region for FIT|
>            |                               |
> 0x85800000 +-------------------------------+
>            |                               |
>            |  R5 U-Boot SPL Stack + Heap   |
>    56MiB   |       (size defined by        |
>            | SPL_STACK_R_MALLOC_SIMPLE_LEN)|
>            |                               |
> 0x89000000 +-------------------------------+ CONFIG_SPL_STACK_R_ADDR*
>   344MiB   |       Device Manager (DM)     |
> 0x9e800000 +-------------------------------+ BL32_BASE in ATF
>    24MiB   |             OPTEE             |
> 0xa0000000 +-------------------------------+ End of DDR (512MiB)

This information is good and belongs in a relevant rst file, not just
commit message.

--=20
Tom

--fJyVUiNn3r99feCu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfLF5EACgkQFHw5/5Y0
tyx/fgv8CFowEV3I4AD1Ix8XRnqBjtlQoOu7C73Vdh+xEyOA5tNyONViNfzz9oJ5
MqDTHA+BSNT+eGfAL88ms9eaTkv+HUcaGAHZrcrTPQz4OeV55kKTOxR8G66csDhX
xcs5T7ScwwRWCkSGnlxiOg5y33IIl3rhSUu1DvV9eHWBiXllwRQR4MK/S22QNu8M
3caUA2D9XgqKcR3eC0KLmIpTxFvT0FEXmZpdCXe0uoty5CKrqRBL9XVKM73ZLyr6
VepnJIpZLztx3435ZsK1+d6YjYSd2BfLYloZ03Ysv84XfMWAPecY6r4K1ktb2jRj
4F7dvb1SfwiuUMm14N3Q8WGBZE/ND2RBSG1uHsaNbnHjDc8tvpfLCKWNwR+yB8Dw
auJ7wJiLxb661vKIZSxO101EAOkTxygQWZLHPFWUFsEGomRYrl4nFVlw8ui5GyQk
gnivimZ7adD+2IA8n8jFzV6tcCHLDbrO+sBQmYOes2PC/LF47KtsE1nf5T/JdaSs
qBzBorXR
=QuGJ
-----END PGP SIGNATURE-----

--fJyVUiNn3r99feCu--
