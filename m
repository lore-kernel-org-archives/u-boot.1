Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5A8C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D79687D80;
	Fri, 19 Jan 2024 17:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G49YeC8I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF80787D71; Fri, 19 Jan 2024 17:09:55 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF83087D6D
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dbed0710c74so884002276.1
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680592; x=1706285392; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5aikJ2P5L8+S/lyXDLfb16o8fPg+5TA/8Q1WZhprKmc=;
 b=G49YeC8IJvrpiJbMPmxgCW+7wl3PUSGPdfKUAdp84SFxxbzJKJAFCIidamzIoRDpIu
 TgdgZyBy1GX3J6JDnqEM65TkqoWTQoRktd3yD1PPIg+Mb8nVGCFHozRyWfaKvERt2jc3
 DZa1VAatUwtZ3CvEgeuPP3lF9fJQyYabRzsn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680592; x=1706285392;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5aikJ2P5L8+S/lyXDLfb16o8fPg+5TA/8Q1WZhprKmc=;
 b=J6rPaMLnoxUAwbmiw7KAMhxkqLBnX1qNfuGMQvXFIz4qN5Dkmae+kzjAU1jQYWxUUp
 Cc2bxl/9zms9k1ov3vuvnyGY7JYmjbibxdCB14kbff4ntOriw5mWlDeDf82bekcL33rd
 xFV2gdjWJ7M7CAL4UPRnB7KfIRpAvsz4ReIHtXBeu48kR3VFDUema2uUnTsDJ79nZwfc
 b315KpB4gLVe8geXt9oO6FeeCIXWLO9PDTrkUW4zjtvvzG5jU6HB8Yz0WVoZIRpIqUeD
 m8kTAJyVLvwEBrS2IyWRWknjnI8Ai3msmc5iT4+zG5a6QYDWsl0elR9B/94uPjBynHQG
 kBlA==
X-Gm-Message-State: AOJu0YyMnKOFRVYq8MjnxqOCz9GtTHxU0XYQ3vFe6ZYJfeCPY84bkdc1
 c8CNZno7Gqcd+dKVLhEeQIkIxuqHWSZcBYJDeDsA+ZSKDLKp77vqVs+r1avLjHI=
X-Google-Smtp-Source: AGHT+IH90BtlwQDRTDyWvc8zAVVzfKFZ1vA2NVfIH88UtWs8WXVN6JfqnW4a5qwOMOmyjOxVm0zIjw==
X-Received: by 2002:a25:26d3:0:b0:dbd:b8bc:3c89 with SMTP id
 m202-20020a2526d3000000b00dbdb8bc3c89mr128822ybm.43.1705680592593; 
 Fri, 19 Jan 2024 08:09:52 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 d1-20020a25eb01000000b00dbf23ca7d82sm6592983ybs.63.2024.01.19.08.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:09:52 -0800 (PST)
Date: Fri, 19 Jan 2024 11:09:50 -0500
From: Tom Rini <trini@konsulko.com>
To: Moritz Fischer <moritzf@google.com>
Cc: sjg@chromium.org, bmeng.cn@gmail.com, xypron.glpk@gmx.de, pro@denx.de,
 marex@denx.de, stcarlso@linux.microsoft.com, u-boot@lists.denx.de
Subject: Re: [PATCH v4] drivers: pci: Fix dm_pci_map_bar() to support 64b BARs
Message-ID: <20240119160950.GG12635@bill-the-cat>
References: <20240110045903.1439339-1-moritzf@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y3H0wljBl3OHukmu"
Content-Disposition: inline
In-Reply-To: <20240110045903.1439339-1-moritzf@google.com>
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


--Y3H0wljBl3OHukmu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 04:59:02AM +0000, Moritz Fischer wrote:

> This enables 64b BARs if CONFIG_SYS_PCI_64BIT is enabled.
>=20
> Reviewed-by: Philip Oberfichtner <pro@denx.de>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Moritz Fischer <moritzf@google.com>

Applied to u-boot/master, thanks!

--=20
Tom

--Y3H0wljBl3OHukmu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqns4ACgkQFHw5/5Y0
tyyn3gv+PlFbL3XV7uP9lXwUwmmlrqiIgItqC5W0Ful27RUb2gKBxk5yRz8BLWGV
BG1EFQpzeHdTO1OXaHy5ectcqU5aBHTUvTLFCaQK5dwLjPFfdfEngcQGX0Zydcvm
b8BXemmQ9FNmorDGHNx65HoEvNIXWWyXC5RkyM8fURC21MwA97Ld7urLzYdL7PGx
fMJ878WKRBuge+oA1PJjrTuf2jE3//c6MEsjzIZFmAhNFBbrXeSfzE93nZxwSCHD
A7B7932uuUgVZqSsl080jHmSSXrylFnhG+p3tqfc3cOO+SBhvFRSPiuyq9mlikCS
SzDc/d6KjLJCPnP326MdfwvHSXd2Bm4uFDs7UUL+g1iKf2eVZkVvyxddrWuPqa9C
J+GCxYlFCRjfNeTQ3hesU5gwddwKY8bY2nA3n+tXBRBsLS0M3pmTVNtd/iwZnEpZ
GzYntaWSpuRLdNzYboaHdCdZ9wpWDCedzDymJ7Grr9p0Yyi2r/grZ9GY4gf20HFM
6RdFJKkG
=EVrk
-----END PGP SIGNATURE-----

--Y3H0wljBl3OHukmu--
