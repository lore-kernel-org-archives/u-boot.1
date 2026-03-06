Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DA0FCB611
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 15:12:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93C1583F93;
	Fri,  6 Mar 2026 16:12:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EBX4EEST";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 575C283F98; Fri,  6 Mar 2026 16:12:35 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B508839A8
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 16:12:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d598f60eeaso7010653a34.2
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 07:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772809952; x=1773414752; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Er7qul1pSi0zvQz4wu5I7+nPk/TcURsjn6zjq8P4ipI=;
 b=EBX4EESTHfsK5zlCS0+wbsczFsmH/l4LkiT3vf2AmpYLn2f+a1a5RrxIwMRdnvb19v
 OZ0E7PW6O147OqTnXXYuPEaliZCpKxVF37abd8e8EsRihBwaBBkMfv9TNfmjRmlx4oIg
 wnBrU6Rt0nLOT7imNooUhkGLL2h3rA7JVbBYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809952; x=1773414752;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Er7qul1pSi0zvQz4wu5I7+nPk/TcURsjn6zjq8P4ipI=;
 b=hp6OQKS2oE/QImRNvtEFupBPQRkEXli+em2GPHCzP0PdtZTtFcjP0yoF/vk3qhhVNL
 jv7vLRCdIWtPJzsyk2vMNfOQNBEr8Pzt7NyOmceMNVz2pDtGVL80wmUEYW5EbZNxYpiJ
 X+CznNpIp1F0AjgS8OwTMy2WRCeuJW/YvsU03QazfGh+1/2leoP4dMznSo4qzv9c2Hqt
 uNZ+sl9+W8V2IsS4SoSBQxo5Cjk4UhvxWi3pN9KHnY596i2OMhizV4mmaSw61jogbdDQ
 ySXaYPqVzXDcKLTCax/J9AbduYCn5wAEK0BZU+yP65m+wRE0NjfQAzwDryq3QHBB/gKs
 3J6g==
X-Gm-Message-State: AOJu0YwUBsvzN/zC7MI2iZ0Qci0hGpX0OBRSvB+y7S1jpVHyEYgwi5RQ
 gjU5+1eVPMvBs0eQyLoFk0AhHUqGP62nW3iXJz3scfodXnE+18L7vE5D/XiUnzQLptw=
X-Gm-Gg: ATEYQzycaLMcSXJR60e0R4ML0DF9U5HLDGa2eI48inE+Pw5Gb/A4vomLXOT7eKOa+an
 /QJzGFXWpeAGis87v+oH9AOxBUsdJAs+WyVZR19aYzYxr0+qUvfFGAlKwPYIpBnwLBf0ZTsu99k
 VcOyuWsSqVtO47m5ARhpeHa+CnXC0sKGrFmBb80uGgKmmHdMzcjNVnJTXiRPutow9rI5tiGz1VL
 t+cwvWHGnvHVccp8u6UJutVV+pLSZx5xi1QCe4UhBLo33i/AhwjcPdsZY37cMBz4KOvmMMimKjt
 P4eHo1tHL1VQ8iOgBlHldedFcMaDmSwa1CY34igLRTY0X37voon8nLNkhLxKQx/8n75d3MzmRgG
 wN/us9KT0Po++7x6zu3wxxJzxbG4VEani5tMfh2lJHpSQsQocMtk6JCTAmVTQIsbewWXv5piQme
 e7w69JrSC0yTOYYfydFu672ITpUsoO0xT7UZ2BbdRHdtQ3pxWwLUdIfinVANIY8SlRh5kGSxSeg
 1269ANmzGjP8g/lFi6XGdp/cmB1H+FqTxhAO/geL43YpJDLYx0=
X-Received: by 2002:a05:6830:3902:b0:7c7:62d0:b462 with SMTP id
 46e09a7af769-7d726e73ccamr1731250a34.6.1772809952036; 
 Fri, 06 Mar 2026 07:12:32 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728d12337sm1008592a34.14.2026.03.06.07.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:12:31 -0800 (PST)
Date: Fri, 6 Mar 2026 09:12:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Aristo Chen <jj251510319013@gmail.com>, Benjamin ROBIN <dev@benjarobin.fr>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo <ycliang@andestech.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>
Subject: Re: [PATCH v4 06/17] riscv: Call bootm_final()
Message-ID: <20260306151229.GO1388590@bill-the-cat>
References: <20260306023638.2678886-1-sjg@chromium.org>
 <20260306023638.2678886-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Qh0XDdLqCH75qcqE"
Content-Disposition: inline
In-Reply-To: <20260306023638.2678886-7-sjg@chromium.org>
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


--Qh0XDdLqCH75qcqE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2026 at 07:36:15PM -0700, Simon Glass wrote:

> From: Simon Glass <simon.glass@canonical.com>
>=20
> The RISC-V announce_and_cleanup() duplicates the common pre-boot
> steps. Replace it with a call to bootm_final().
>=20
> Move board_quiesce_devices() into bootm_final() so it is available to
> all architectures. Drop the RISC-V weak definition and header
> declaration since the generic one in bootm.h is used instead.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
>=20

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Qh0XDdLqCH75qcqE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaru3AAKCRAr4qD1Cr/k
CsRVAP4yZxqX2rOjJ0a8rigZqfGrNvl8lsu1Y0Top15YFWlZHQEAiZiI2ixpQ7RV
M/FgbdnXUSQTFz9luBiJQqh64Wir4Qs=
=i8mh
-----END PGP SIGNATURE-----

--Qh0XDdLqCH75qcqE--
