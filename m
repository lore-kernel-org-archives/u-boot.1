Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8809FC61CE5
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:43:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E326C82B19;
	Tue,  3 Jun 2025 16:43:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E8Mf+0fU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DBFA82A8B; Tue,  3 Jun 2025 16:43:51 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3900782B27
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 16:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-406e31162c6so1120711b6e.2
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 07:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748961828; x=1749566628; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5s2kq2gWuKEVgowzP7u2Ab/2315vi5Wptli0nVzVUQc=;
 b=E8Mf+0fUH8rO643IVhpS/lPCcPLAgFFmnFbryIJk2tPY8yEwHWNdTIqDaYMP1iMI3G
 Zd+R2y7O1Q48mPxWNtYXXyegN1UXycjlOUX5/qXx6FBDibDhwgLZARD3BkTPNK0RR9ua
 9yTxHwqL8FVKhyVU2ZNj8bhYx+TI1KD+afZIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748961828; x=1749566628;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5s2kq2gWuKEVgowzP7u2Ab/2315vi5Wptli0nVzVUQc=;
 b=nlK7p7IF4I3RvR8GmP9Y3wkrtiGWp7KuKHDDDYdqDjgfTyOUrUtFYKCWn3tHrxIjaY
 rP4saadBWBKVxn1z6RZNJyLMM5JcUwbqO9AaXYFN2LaYy3HAOMann/YSV1Pkcman8Po0
 ZRGsfO30cuCiGj/xL2JA4gKtS2GOlkTN0yE1aMTDmiIUZNAYPojD3mSh4DXYIZiETJ40
 dKdVFjCNBQLX92ezKFTpxrgpbVEc1p1yoFQ9AlqSGmPB8JrBHA8LrlnjKU1Gw5/Gb5T6
 FcAH4y6vZ9u3BS4KbKN/prk990Cf5jZFQ6YmjPtryUAeMcDLWDa5wxL9O9aqCo9zPUtR
 NbPg==
X-Gm-Message-State: AOJu0YxEoUFfDZyb/WDNYsUenLir78e4Xef+53Krc8dGu0fHaTGgmWvt
 kXI9+4mXmhNm2u1eaEzdPyLMockfCVJkPm4Pkd2KcYlnGtTVXhUVYeQNJ/BJW2ZjOzA=
X-Gm-Gg: ASbGncspoIk2L8hyfK38QQCila/for4EBtOBMf0LweIMAvHhnpy3cgDRhhcNgAH87ZZ
 N5Nj0zWyQ5u60PCol3b0UVKn5NXoEONRbt1kFiiRC3QWDs2+T8UcVUBEQzu/FR4sptplaSLLEkD
 Hfm3q3XpyDoP8T9yyYxAa6NdjjFcFFpXsZIBf0mBNxtkBJe7NjbJJlCRZNlJkh2F2wzM0MY01iD
 6SnChS+pogDmSryJqUj1C47wjRGZCXOIBHKFtKECDyIfeTfISxlFlBSsBfish4EwxT4AkkPR69J
 Y5YOBqu+f8M3wdt4iSST9HVEfvNDvjY4p+MOjbGunEyzfNJMv/C3ECg0uVJFUnU9imkw9ojy5+6
 zRzxND5e/gr9N
X-Google-Smtp-Source: AGHT+IH6J768cj6vu0lrRUHGkBkY1eN/NpNV+h5j7fOl3wOUzEMPeoW7jb5XKgduD8CTnTlmLusSOw==
X-Received: by 2002:a05:6808:680a:b0:407:a5b1:c1d4 with SMTP id
 5614622812f47-407a5b1c22amr9102475b6e.28.1748961827902; 
 Tue, 03 Jun 2025 07:43:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60c1eb6e063sm1846421eaf.32.2025.06.03.07.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 07:43:47 -0700 (PDT)
Date: Tue, 3 Jun 2025 08:43:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Stephen Boyd <swboyd@chromium.org>
Cc: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: Re: [PATCH v4 08/28] coreboot: Move coreboot logic out of x86 to a
 generic place
Message-ID: <20250603144344.GF1382132@bill-the-cat>
References: <20250523225845.2311989-1-swboyd@chromium.org>
 <20250523225845.2311989-9-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sXgVknb8IGrlBGyV"
Content-Disposition: inline
In-Reply-To: <20250523225845.2311989-9-swboyd@chromium.org>
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


--sXgVknb8IGrlBGyV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 03:58:23PM -0700, Stephen Boyd wrote:

> Lay the groundwork to run U-Boot as a payload on ARM coreboot based
> devices. Move the coreboot table parsing code out of arch/x86 into
> lib/coreboot. The headers like cb_sysinfo.h and coreboot_tables.h need
> to be globally accessible, so move them into the top level include
> directory. Introduce helper functions like
> board_get_usable_ram_top_from_coreboot(), dram_init_from_coreboot(), and
> dram_init_banksize_from_coreboot() so that boards can still override
> these common functions while also supporting booting as a coreboot
> payload.
>=20
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--sXgVknb8IGrlBGyV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg/ChwACgkQFHw5/5Y0
tyzAMQwAlr+rwCkyhpYccxAuaJp8PejQvMIr4djfjM+lwgocUzFJ/N1sfCOjjLDi
FtQpoqtNhQtoM+K8zvlf3xiKt0KjUuRUFA+jOpsAiPlxSm47ro2yvg56wFdoraG5
9sj63SRSYO4YFPBeS2G85O4efsYLEcC5B7Ixvng6DjScqgE+aymxtmRa2JT/mMd+
m9+tK8voWZFPBICTj8PLhZvTGsKu7pm8eiek32KjjiQWZYB8oTT/enNl9FYJGkxz
2K+lYPdGdkkyQMZ62OnOmZnYqGDnon/zfIHVB09iFgf4C1BfbTz1FdBYcGXDP+5Y
09ka3acUBMMOeRImU1vicyqCRjTtVdfIsjsC5b6ga2pybUUJPxLNpMKkfre5Zbci
dznoVyeZv6CSMudDTZFAMG7x9gymgn1106T/wOZk0+ghNkGL5yDE+M/5Z5ijIT7d
mnyrK0ZSlaMlsd7VBA74e9slHui1fHHpqrZcHfl5SCF6/ki40Gj0I4I+1rMfLz6N
vPIdUKzy
=bck+
-----END PGP SIGNATURE-----

--sXgVknb8IGrlBGyV--
