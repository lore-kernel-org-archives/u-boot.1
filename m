Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53F7CF319E
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 19:16:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3E2588D27;
	Wed,  2 Oct 2024 21:16:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G3keoQk0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41CD388DBE; Wed,  2 Oct 2024 21:16:46 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21F1888D14
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 21:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-710f0415ac8so79951a34.1
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 12:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727896603; x=1728501403; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NKpi3giNrzn6dC0DhqpsT1D14VRa6aJRkGhO5aIitsw=;
 b=G3keoQk0XvtWq2EknbhVMxtJ26OCGjRo75VeNDJ214zRHjF1BYy18hFB65qF3XhqZJ
 kr4TuIjRYahJ0Em+4GOJj+Z9rXcsGbd5xee8/PmLCUU7xiOzPFVnho4NgGzYbzlfPo0C
 fcku1CbVmytkD8tRcLEACCGLw44qyGnTZyGnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727896603; x=1728501403;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKpi3giNrzn6dC0DhqpsT1D14VRa6aJRkGhO5aIitsw=;
 b=V134Rkoc8bLsGhLUe6KIoFyd3I399EqV9i00FVZtsuVpmasUXhNJ+40hkHc29oKOpf
 tO7J03EueV+0/UnKlj392Q/EjVm0iNd7lb8RnAmaojhSX3xXXetKJuXaVfpeI2ZYYQHw
 S1h546BoltM/0Ys53CbZf771g2PeUo5tCviSQaqLoNz6/5e/V6Gts4UZbdw5ZChOJCaH
 bguQjGvHXKMRy+/0DTlEdVKF/Q6ORj4iscGic7Rbu0RieEiaSq0kVovgM2XxGxbVLw74
 Y0f6IUahe1f7OTQkhF71duYTe1iqSJwxokfj//RYXW1KETCSJ+JTJyv3XwSefdRHwfQp
 9hUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV387u7+cpvmJKTwQB0lme9oxn+SWRydY/NoTXCxx/PMTNV8TJL0G7cU8BCShdw4k7CRBmVpSk=@lists.denx.de
X-Gm-Message-State: AOJu0YwG3V5dR07AgytJPt19KP3TZLAcyZI+elWjlREFXl/otTzhdu/z
 v/iS3+i9Kc+Z6ZjSyvTSDhq3ejttjJfnbyO9qhNy/Op+smVq+yPI7xZsu9QxIhg=
X-Google-Smtp-Source: AGHT+IF7MVE6Jyv2qSmwXw4wG3GBl8YXy8jmxQxeq4pKNfnp0sXuZjLyBun6qOPuZ3xFaQmqj2osCQ==
X-Received: by 2002:a05:6358:60c3:b0:1bc:468f:c74a with SMTP id
 e5c5f4694b2df-1c0ceed45b4mr216894755d.27.1727896602718; 
 Wed, 02 Oct 2024 12:16:42 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae377bcd31sm649037985a.26.2024.10.02.12.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 12:16:41 -0700 (PDT)
Date: Wed, 2 Oct 2024 13:16:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Martyn Welch <martyn.welch@collabora.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/4] boot: pxe_utils: Add fallback support
Message-ID: <20241002191638.GQ4737@bill-the-cat>
References: <20241002132633.246942-1-martyn.welch@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1dhnzmrMCXYsiKXV"
Content-Disposition: inline
In-Reply-To: <20241002132633.246942-1-martyn.welch@collabora.com>
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


--1dhnzmrMCXYsiKXV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2024 at 02:26:30PM +0100, Martyn Welch wrote:
> When configured correctly, we can detect when boot fails after the boot
> process has been handed over to the kernel through the use of U-Boot's
> bootcount support. In some instances, such as when we are performing
> atomic updates via a system such as OSTree, it is desirable to provide a
> fallback option so that we can return to a previous (hopefully working)
> state.
>=20
> Add a "fallback" option to the supported extlinux configuration options
> that points to a label like "default" so that we can utilise this in
> later commits.
>=20
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>

Is "fallback" part of the nominal extlinux specification?

--=20
Tom

--1dhnzmrMCXYsiKXV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb9nBMACgkQFHw5/5Y0
tyxqlQv+IO+MSMVqn2B+9v5qLZhT+WEpjQ6vzSzPmDBsApiUvCYhRO2aNZ//aP4v
nx6ePvMHT3OtbBODUxk1scaM7oWC1ZsDzQPALV/Bvlxtv/YWg4F4ZNS6RTSQRvB+
/UEjQ8DdrD8H/k0S3re7Y0ziLEer0ygdjwAkJcgIO4exogfLsucKBC+Xq0NJ7IfY
ekBnXVpYC3rPYu+WxmbIm5NJrA9AZw1x4SKChu46P0yNx7nBOs1SysaZyPZry4u9
6JgSULYgdK8+lM2bFpcsBYZKWM7RI2yUxjUpoRh13JlNx+o7Jv621eZ4rMCsFi78
OG1kkyEt0O1j88UAQ+CaDhGHW9yvXi4ulYS7KeabpO6iQB5EFjOilgoteFFjJIZD
4ik37vy88e2RNx9D0+1XK1E19hl5PmgX1+LzKBSjeZq2S8FhcTZPL1XOEgtHUIcv
LMkkR4EUZh3Ekc1e0163lUDN4/Km17tGFwvtF6KrHlpe8e46vW02hR7BXij53ZOU
7K6TDDqu
=1vOo
-----END PGP SIGNATURE-----

--1dhnzmrMCXYsiKXV--
