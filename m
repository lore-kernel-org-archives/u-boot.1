Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB6DC0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 20:24:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 218F48679B;
	Tue, 15 Aug 2023 22:24:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IP+L8P4/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B68B867E2; Tue, 15 Aug 2023 22:24:00 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42DFD8671F
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 22:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-589f2fb1a88so27340367b3.2
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 13:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692131036; x=1692735836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ACmrL9hViqP08JxIqOr4DsCM9U6EE3FTpnZk9fOj16M=;
 b=IP+L8P4/RjEzAqh62smeyulsOORkZg/GYznmIYSrZ6z34XOkeR+S6WwlB8S5WcYfat
 zzgwP9RXqIPkNNJSLx7aG5srMHypCCW/CdgFWmSLHKqmQfygk/KHn0GiBfcP3R7ex79l
 Vnx4GU40gyVLZya4Jc0fHat+j+aRyG+wXIom8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692131036; x=1692735836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ACmrL9hViqP08JxIqOr4DsCM9U6EE3FTpnZk9fOj16M=;
 b=Pzj68SShd1G8AFohUMvp08R4YR63HbBPqAVR8kNJfiArPxyPslrwChOOW/MK2derkn
 OnHdC11lqRqg9XUJqj665h+tpJU0HQl9hIEYsYWD45AJmxIgSxZTwUKM45BmmsMwtOvD
 1afePuZpzVeKaNxUMs+D2zhSB00k/d4Wi/yu/iIDfMkzsxQxg9YXtaLbWH5ucfGkJnhW
 48V6UaOkfTij5Tq8vc9/f6jqUviB8MqX4qCeHQdlB75Sb8G+H2ODkDepLmDZqx77/WF9
 uE7ZL5psHEnzAbANkIPE0C0ZP7un6DcSkt/sGfpT3XWL6x8RmlcDMkzXwJnRl6lDuqb8
 1ZBQ==
X-Gm-Message-State: AOJu0Yxp/nDoF+R2LfJ4fG19SwLmZnvj+f7xVrc1vwkJQl9/qrvildb2
 6kl/CF/ZV6ZKTgwTn0yKFw/Gag==
X-Google-Smtp-Source: AGHT+IH1Gt4d+nA1hOola7XDv8x05BAMYygVUf3iQq2stUzukxI/CtGqJ1NdFQ0o8rO5WOJfML+D/A==
X-Received: by 2002:a81:6f0b:0:b0:583:9018:6fbb with SMTP id
 k11-20020a816f0b000000b0058390186fbbmr13920061ywc.37.1692131035955; 
 Tue, 15 Aug 2023 13:23:55 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-14d5-2a24-c47a-465f.res6.spectrum.com.
 [2603:6081:7b00:6400:14d5:2a24:c47a:465f])
 by smtp.gmail.com with ESMTPSA id
 o69-20020a0dcc48000000b00586a74620f9sm3614280ywd.41.2023.08.15.13.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 13:23:54 -0700 (PDT)
Date: Tue, 15 Aug 2023 16:23:52 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Simon Glass <sjg@chromium.org>,
 Sean Anderson <sean.anderson@seco.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] spl: don't assume NVMe partition 1 exists
Message-ID: <20230815202352.GB3630934@bill-the-cat>
References: <20230815160736.39330-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BQrIVNiOZTsNdnhv"
Content-Disposition: inline
In-Reply-To: <20230815160736.39330-1-heinrich.schuchardt@canonical.com>
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


--BQrIVNiOZTsNdnhv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 06:07:36PM +0200, Heinrich Schuchardt wrote:

> There is no requirement that a partition 1 exists in a partition table.
> We should not try to retrieve information about it.
>=20
> We should not even try reading with partition number
> CONFIG_SYS_NVME_BOOT_PARTITION here as this is done in the fs_set_blk_dev=
()
> call anyway.
>=20
> Fixes: 8ce6a2e17577 ("spl: blk: Support loading images from fs")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--BQrIVNiOZTsNdnhv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTb3tIACgkQFHw5/5Y0
tyw3dgv+MPyD6JcyRipzVnKj8e3pnboAJFFbZR/1ylkedw2lhjWm+6mnQXjMOq/l
m7Ms9poLi8ghXOidfQKMlVrjcW+3ohEbQg11BzzPcj9cIVS/SmgpgSnZQQwDlz56
+UunrPVHl1dLPLMsPdVQsWVooBXBtHmDJ1nMFYcTtrhjKc2u/BLYgUliqdKZpsgE
Ni5zZHwEMaB/0oQ1brBGgWTARiemgjvEIG5v4qia5DbWHB5PIKYiGy2ZIWHhzTAt
PQRDrPqMsLG+F1ZbfOa59jyFWnk3z//M9Krl07XIqztYx+mo+k+JPSNzMs1VbqV5
O2W/F0Z8sWiKDLTsdmqFVwdukKW24Wtuh/JAEtz25Q2SRid2dGPOCBFVLfF5FBMS
biVAPTF/U4EM0xaD2MLNhwB2snB5OeqyBxImAA00kiOdkSStxnzpFM0qsCRY2KlM
BVie5caxGzXzmNpz6eXOxdSEuvaDZ6XldgEMnhk7otHTjLlwV/BCMCbjuwGo0jR/
PA+ZZI9C
=7FKH
-----END PGP SIGNATURE-----

--BQrIVNiOZTsNdnhv--
