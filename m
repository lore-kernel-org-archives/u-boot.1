Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114CBC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 21:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16B3082EAA;
	Mon,  7 Apr 2025 23:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NowA8iH4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA67282F08; Mon,  7 Apr 2025 23:58:46 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1C8982EA3
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 23:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-72c14235af3so3026897a34.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 14:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744063123; x=1744667923; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x12JBpcB8pFPeMXfvGobXyGMIrmutm2OboQglUyg5UM=;
 b=NowA8iH4VUx+Ri4b5JDLphP43NEaKe5hsli9rxH2m/4COb+J357MTYAR4/RwdSFw9p
 Vt/EPLgK0X/AOlDOtlB3VEYWfwxIiSJq4s5ELPqGI9wE/v24OdDBKSwWRY0BvEXHSZuG
 hVp1SUk0M0loqeDVSlWamL6IRSc+f3XHpFuUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744063123; x=1744667923;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x12JBpcB8pFPeMXfvGobXyGMIrmutm2OboQglUyg5UM=;
 b=dV2BweLW1FkoYeyJ0YWEzVQ/jJoKDitTtQWWBLqxuoAu1Rvcmc5iFEYOJLANMVe48P
 yUQd90L78XXb/nLSuQDlTbxRh2oY85nX/o7ttAnh4gP93/+X941WBzkK8ysxeRC9wI/j
 LXeZmQd4Q3e3WhyNlPENI0xBwJH7Ivc2q6uUliW3AkG8aUN84+6Kdl7HUUTH1G1RJ6vS
 RP2h6w27mlgwhs47RSAYAMZmv324DAYryqNImyH2kcyU2vGwtKYHbUuSh0AqucIOdl6m
 1GnLeZyC0HNzxJ9azTNJFUxg2AC5tF+ZcSubIHeaIuoWjWWZTayNEgqc6oLVUHmB8WrV
 XOaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6LfKEVp0SNTsbh69MWhWbNB9u5Poc+4DdE8ODMOhB7PpZCjbJlldy7HjiPcWuCN3JBoJjBUg=@lists.denx.de
X-Gm-Message-State: AOJu0YzvMO+qN/L0mY7hhYNhVrtKMwL3KzPwEETQKEEk2XqWtFCSAVow
 RXS2DVAMWcxWDVtFAbZaSQXacJPayp8Wh+hehWjf6ooxXmSCUazHiJRsCruz0uw=
X-Gm-Gg: ASbGnctIWwbz99S5wx4T3Oo0H+lCy1mmYbnbVuihMCPvEkGO1OioDt4MGOxYYa11elf
 qleN6UdKewnmw5Fam9bg6M0AIAEgQMAPAObR/tYNhPUi4s/SqE7BSwJ9xvK/2FewbRqE05k8LWC
 qqWlw7h/Dthzj0QZQMA5mmFQ98zOUg2gHTILuHnq6lfbASP1P7rKeqSb5N3gjF/yNVtjrQxD33x
 /rZonwaXbpKHdIyJHMsp+RL8rwoDpZ/wuaKKznomfm0v6q3JhQCh9FV79cytJixvVGnjEzUflNd
 SzkRiqcSv+QqS6QbHPq2YokIG8ufZiYP1tDMJnDXWRzXP5Qp0BiwrfdK4HasRVjrGuFCPXJtJPW
 qUkjqdA==
X-Google-Smtp-Source: AGHT+IH1qZgVahG8/OATKphkZQoqj+agOFWZYFNZIzIFuJmSVfBlbkjMyldVs/JfUpueIXWoqNM9nw==
X-Received: by 2002:a05:6830:698a:b0:72b:888b:27e4 with SMTP id
 46e09a7af769-72e367da5camr9802087a34.12.1744063123376; 
 Mon, 07 Apr 2025 14:58:43 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e65178b5fsm122715a34.28.2025.04.07.14.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 14:58:42 -0700 (PDT)
Date: Mon, 7 Apr 2025 15:58:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] acpi: select CONFIG_BLOBLIST
Message-ID: <20250407215840.GQ5495@bill-the-cat>
References: <20250407064424.71541-1-heinrich.schuchardt@canonical.com>
 <20250407064424.71541-2-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hwAcL3ZZDIOB/lH5"
Content-Disposition: inline
In-Reply-To: <20250407064424.71541-2-heinrich.schuchardt@canonical.com>
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


--hwAcL3ZZDIOB/lH5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2025 at 08:44:23AM +0200, Heinrich Schuchardt wrote:

> Since commit 53d5a221632e ("emulation: Use bloblist to hold tables")
> `make qemu-riscv64_smode_defconfig acpi.config && make` fails with
>=20
>     qfw_acpi.c:146:(.text.evt_write_acpi_tables+0xc):
>     undefined reference to `bloblist_add'
>=20
> Build with bloblist support.
>=20
> Fixes: 53d5a221632e ("emulation: Use bloblist to hold tables")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--hwAcL3ZZDIOB/lH5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf0SpAACgkQFHw5/5Y0
tyzavgwAtfbhdnnu2NeS27lC7sjDW6nUbTYrK2W45r+y4PBc0wf6H/EZI2TXTdWy
PAjFclQCzGUYAo+b+ZacXB6JBC+W0E6yqAO2ObPITjZMDcyI8+3gD2v0mQTsjUY3
AZcN9QDGu4mUSh5ZZcAut4AVgrWRklz2/V6zXPvFsGhcbgySnSGhSn+nk+6t+OBc
qySztc5bA7OOLG4A9/3QjGEBOEDhN2s7LT2mqw/HcQHEOYIWlh4FQDZvx/Tr7RIo
37mTfY7rP6TQKHczyQNSxvqvTGDFzx8xmDUyqI4eYV6mt08Umz5Crw508EynASHO
LKZhKD7Qyk84sQOCV9peItaxGY3wWdB3Cr+Iarkfc84VdbrKf7UeiVW2Y8jeiyaQ
EsHtxaf/q26UHGg5HDjsK8/PmaPKssukflTw8zkElzYG6cLY8QjkmikxWb9d5Ce5
kDz9kGSk+nBaGM1R5tSAWgkPF8mTbyy9fs15di0An4GscQVLZfUj3FjY8+GG0SFV
JpjBrQHG
=BX+r
-----END PGP SIGNATURE-----

--hwAcL3ZZDIOB/lH5--
