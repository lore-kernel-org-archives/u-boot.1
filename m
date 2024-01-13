Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A782AC4707B
	for <u-boot@archiver.kernel.org>; Sat, 13 Jan 2024 15:27:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83C5D87927;
	Sat, 13 Jan 2024 16:27:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UuU6PxvS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B5D287930; Sat, 13 Jan 2024 16:27:39 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 066EC878EE
 for <u-boot@lists.denx.de>; Sat, 13 Jan 2024 16:27:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dbed729a4f2so6473736276.2
 for <u-boot@lists.denx.de>; Sat, 13 Jan 2024 07:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705159656; x=1705764456; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=h2sRU6O0uo9ZwKf0/wwtxQRccwvlhrwtLh9QgxIDats=;
 b=UuU6PxvSdp1970I8WBNJsfrgKQMmysCknRCSycAWkAe8OMgXj9iejSNwd60GjebJKs
 nCl4DWafggYR7SkHXMnNvVO4FBK79WgPzPgkuYDZwbyFnNso3AKhYURHV5dh3oOsM4yW
 HWB4QpzZunoeEgF8kw0tOeCxoZSseyoymKDaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705159656; x=1705764456;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h2sRU6O0uo9ZwKf0/wwtxQRccwvlhrwtLh9QgxIDats=;
 b=bYYJ6wLphOz1W/xj1SV+qN3CGwRFpXI1eUl3kIPNC3UdrwxONofF+lscWO+zdmYztm
 UgjIetA8tZHur7ULesqSoi0exzAXL3NTNdaXB/uQGMkoY+vV2Qx2gQJW55r3sVM0VT6K
 6TxjefRdfUBXKva3fbizV2h6p5jK1C9QFoK0wRIYD+in/77YOTpd5VvFn2JRymesaLGV
 1DF1ecNCFTgbb5MLGk19uN4jM9UixKi1E0+TkazT531HN5Dqce3XrSdoUO8lvPYSogNo
 rjCapF+FxYDHjEj7BhPla/oYKBwa2kcnTWNBGeP+l9erFondrkSkdg9z9wITHB3YGMha
 f7kA==
X-Gm-Message-State: AOJu0YwkOEs8m/cc4fQTcaiInWO7U9EVc+8ZjBsqXCEaH4nPuNc7xFWN
 6ECqzhYlWjmKrbbskvCgdugn7gdLBJtKQg==
X-Google-Smtp-Source: AGHT+IH2iu8EErTHzYYCCfUkc0RADweI1XWwaBnJBBEgiqwNsidG10YOHDECaN+TIt1ZxXTyr59m3w==
X-Received: by 2002:a05:6902:250d:b0:dbc:d8c8:f43d with SMTP id
 dt13-20020a056902250d00b00dbcd8c8f43dmr1908585ybb.71.1705159655668; 
 Sat, 13 Jan 2024 07:27:35 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 qd11-20020ad4480b000000b0067f99a564bfsm1877442qvb.91.2024.01.13.07.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jan 2024 07:27:34 -0800 (PST)
Date: Sat, 13 Jan 2024 10:27:32 -0500
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v5 8/8] fdt: get FDT from bloblist
Message-ID: <20240113152732.GH1610741@bill-the-cat>
References: <20240112213337.185460-1-raymond.mao@linaro.org>
 <20240112213337.185460-9-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WZA5JHbwDLxLjiuy"
Content-Disposition: inline
In-Reply-To: <20240112213337.185460-9-raymond.mao@linaro.org>
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


--WZA5JHbwDLxLjiuy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 01:33:34PM -0800, Raymond Mao wrote:

> Get device tree from a bloblist if it exists.
> If not, fallback to traditional way.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Refactor of board_fdt_blob_setup().
> Changes in v4
> - Move the logics from board custom function to fdt library.
> Changes in V5
> - Rebase the changes on top of master.
>=20
>  lib/fdtdec.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Why was this just not dropped after:
commit 70fe23859437ffe4efe0793423937d8b78ebf9d6
Author: Simon Glass <sjg@chromium.org>
Date:   Wed Jan 3 18:49:19 2024 -0700

    fdt: Allow the devicetree to come from a bloblist
   =20
    Standard passage provides for a bloblist to be passed from one firmware
    phase to the next. That can be used to pass the devicetree along as wel=
l.
    Add an option to support this.
   =20
    Tests for this will be added as part of the Universal Payload work.
   =20
    Signed-off-by: Simon Glass <sjg@chromium.org>
    Reviewed-by: Tom Rini <trini@konsulko.com>
    Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

The commit message is wrong, as it looks like it tweaks how
CONFIG_OF_BOARD works to be differently wrong than today (which is in
turn a different thread and we can just not change it more right now,
and not have another thread about it).

--=20
Tom

--WZA5JHbwDLxLjiuy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWiq90ACgkQFHw5/5Y0
tywFIAv+Pbf+yCI0PXz1M+Xz06eaTJdsw/rWL+0WcwuiyvnXC6wRfhpEllDYRkc7
4hcUrIH5Stix7IHBLzgXv7+beXnfNOAGqKTCNJT2lmSSNkAf4T9P2yAdEoIlo177
mS9+bDEtsMNhcXdToHzC0CynDYXkJlUXTk4IGktcO89sRZXj2MLbsSolskniEzyi
FtEBAgP55E6UyTj9ngM/biSVpWmYfuxYRCQsT9Wae4Sziyad8yrgrRHgCqcPbyeu
5zC6DYSDaVY5/vbSeZyEA/Tmij+aXskQ/K2763dMbTtVZuqIqfPybnvA31bcOEKj
iCvubup2Qc8r4ZzFY23VUmBB4Qk22WAZMxD6AUq3hoyHl/5XwcwKnSdboyFUH0pV
/+wTaaS8smbQ9zUFbZFL03w6FOmmVcMbhQGMKMq5gfXCn2sN/4SAGY4qAVUOrOTr
pYdZUGkon3They66DMf8jtfgs0JrGYUYinRpxwR32FjCP5JwCVNXSL7q8zuzHILK
1lsdH0DU
=AlGV
-----END PGP SIGNATURE-----

--WZA5JHbwDLxLjiuy--
