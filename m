Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F262C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 18:39:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EB598765B;
	Sat,  9 Dec 2023 19:39:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VqATPkj+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49BD087215; Sat,  9 Dec 2023 19:39:29 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C05D8765B
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 19:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-db3fa47c2f7so3418850276.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 10:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702147166; x=1702751966; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7iDiuW7nf5nuWEzBOTU4PLfkUoe/xBXLR/1lEfS+jDA=;
 b=VqATPkj+UyvG/z/RBLgaHXR+Yz6Z7Pgt6NMpSB2and+WMAOvu60EcYK3QFgtEYhfwz
 4PmfbnvRAFgqYD+A5Edd9qB85btPtxvz5xgj1xBCoHCkq2uyZxgslM7PDJ1cr0F5h3L9
 iQzJpMQhwMfxI79I7HFfpiST5tOVrOGqQVCA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702147166; x=1702751966;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7iDiuW7nf5nuWEzBOTU4PLfkUoe/xBXLR/1lEfS+jDA=;
 b=B+Zg0uE0EnpIvOGFF6908pLCn8QyLptrjGsmmDUGptB8JADIIMbaWObjpHVQNhOob4
 ognsJnD31Yjks/RI4bbpqgPDa7loC1otz9XKKAEGif7K9OIhmPpVO12sROy2sgG7DhhG
 vnMxLJZhPw0WAtF6A4PSzt9+CMhNaIppqe0lxF29JiXfsggnHybnbdIN4y7IXiMtculq
 u6aNqkiyhi5dUM17AppJ1sNHonqBEQNgIH6w8iJjO+3uh60dOEG+/TCS4Qh2AJksW/vG
 Mfvt1RtZIikuu7XEhGpPHyL/KI0w4/eAkyNDxzG7Oy6WhYu6aZBVPtxYVLc3jZPyITL3
 Tdhg==
X-Gm-Message-State: AOJu0YwBSI47n64lzGGWFK+cQ9Yz7Kv3YG5OYoZGcSYme6lSP6KKyQsQ
 bD40R8uR5WPeF8NnEWAoHOO9CQ==
X-Google-Smtp-Source: AGHT+IEFZCfihVq//CwNiOUA1XqeH4pfd7u4BODdMlC4y+NDkzggO+o1BEx4W9rY270LsndMROY4hg==
X-Received: by 2002:a25:ae02:0:b0:db5:48f9:2b46 with SMTP id
 a2-20020a25ae02000000b00db548f92b46mr1143740ybj.2.1702147165892; 
 Sat, 09 Dec 2023 10:39:25 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 a28-20020a25ae1c000000b00d8168e226e6sm1435347ybj.47.2023.12.09.10.39.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 10:39:24 -0800 (PST)
Date: Sat, 9 Dec 2023 13:39:22 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH 03/14] bootm: Make OS booting dependent on BOOTM
Message-ID: <20231209183922.GV2513409@bill-the-cat>
References: <20231204003144.899097-1-sjg@chromium.org>
 <20231204003144.899097-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1AiwHQD3uh8rdJ6d"
Content-Disposition: inline
In-Reply-To: <20231204003144.899097-3-sjg@chromium.org>
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


--1AiwHQD3uh8rdJ6d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 03, 2023 at 05:31:27PM -0700, Simon Glass wrote:

> Booting an OS does not require the 'bootm' command, so change the
> condition for these options.
>=20
> Move them into boot/ so they don't depend on CMDLINE
>=20
> Note that CMD_BOOTM_PRE_LOAD has been put directly into the bootm code
> so will need some additional refactoring (and a test!) to allow it to
> change over.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--1AiwHQD3uh8rdJ6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0tFoACgkQFHw5/5Y0
tyxb3gv/fdc7HwsmSpzI1bybGPi88seOanCk+Xoc54nGNRQfrg3oZ2IQbGNlHe0g
RK72lP8OXwP4zKGOeT0neffIjEAIX4ZPg+HcTXeBkVGzJc6ChaNSVjqGDk4yPsIV
Vm3SHlTGN6wCeop/CaFwsQ+rRsNPOYV8HTdjwcumt1RdOBzJjptXP08vwQ9tp3Hb
M7gORv3cNqvJqmcwbQ6Lu1WmAO3uI/ILvkVH9guGfaX/P42m5+TtnwSBX3aUvPNw
pNKFDPmkJ7Q7ODZgrVw2BUm7bmZps/0MsTiLKQTXAgIQhY3BqI32ofVzl/meudED
rXGzI3549SUTHPFoSkj3V8DwxmS9F2LIyf26Yy1sqY6RrG3XImyFmlCY0wgJbCts
pCP+fB/+k4VXrxB/mb/pb1sOjZRE1LuNWCJ7ezqz2mV4BTuN2Xjdf0f9WiX4PGug
C+ooi7jq93gS17zAHWMaCX8oXm1INVnhA0txUqU5+59JEdnScwbg93p8hFB1NPKQ
sUrtcZZY
=IQ+r
-----END PGP SIGNATURE-----

--1AiwHQD3uh8rdJ6d--
