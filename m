Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3299CF8853
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 17:16:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5298988C98;
	Fri,  4 Oct 2024 19:16:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aQaZJ1GJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F4B588C4C; Fri,  4 Oct 2024 19:16:03 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2542088DA9
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 19:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7a99e4417c3so189030785a.1
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 10:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728062160; x=1728666960; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YiTfmZrQUsWvazd9DlbJrHKbTHCjOkPZJ3SgCyk53ZA=;
 b=aQaZJ1GJ4II606Fetq0cL0Fibzi6W5x84DLlzfbaZSfFqWI/XqU2Y9E1zoxze+ZtpJ
 +jUBmBGWC4thOlhuL3A8MdTdGE0r5gttXHmzGyI6XEPrBOQJ8V/4RkNhfEKFHAsqMvLj
 5pnO1pLZjrvHDwNY6VRFseKC6D+GhnfyYflAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728062160; x=1728666960;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YiTfmZrQUsWvazd9DlbJrHKbTHCjOkPZJ3SgCyk53ZA=;
 b=NQIbdI+HTgAgmDJoV+rmTp2QLwFuM3L4tQJbphzsuQHcuti0orThZs8P9od6UPxkSD
 24clklsYkimFpcWaXSZ3ZUHySqrB8SmzHmpiSL8AykUB7/SQBdIfAGfDMF9kJJYfubJq
 e6t2FDXv3g0jAqSArjvj8ueA4VLyrMYDlyEdkWXdg+F7wP/tIn0THUfiHKE12887V3sA
 Vq6xjJEgGkORntQRptMtK7LcJd7d7HXC45zU0GoWdPLbBsQTw6cQ4Gi0AFE2ibzePe4b
 4p7vxhBKSyG3jk2xOFGt+NVxHCOwfStzpnridxEOK5jRHxe+wzZUs7GfFwBzQwzG7SEq
 oP2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwrIAB6uY5wxUqof0zMHxBhrMhaNd4an8hK9yCSzGZXpoEY/v7VV09ERCc0tPd9xQlJqBqfSs=@lists.denx.de
X-Gm-Message-State: AOJu0YyGN1D7mI5F2ou3sLqcKTvjqg0r/8qBqyzilYHAHiwW25iwFwYq
 Ll2fo19qujwAMpf4qboeWgdW7yKLA5/gpvyJQMj05v5bHjEv2hiVwLWqGfNQ5SM=
X-Google-Smtp-Source: AGHT+IE+dmmHNu+YoIneF7gqEk5UiOPn3qs2Q8k4ugPzWxj6z2kNgWjeZL0/8pyDbq7k8668FMOZtw==
X-Received: by 2002:a05:620a:29d2:b0:7a9:bf31:dbc7 with SMTP id
 af79cd13be357-7ae6f493a39mr530095285a.53.1728062159964; 
 Fri, 04 Oct 2024 10:15:59 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae7561642esm3087185a.12.2024.10.04.10.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 10:15:59 -0700 (PDT)
Date: Fri, 4 Oct 2024 11:15:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PULL] Please pull qcom/qcom-next
Message-ID: <20241004171556.GE4737@bill-the-cat>
References: <20241004142228.271558-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BrUYkNZABjXbWAI9"
Content-Disposition: inline
In-Reply-To: <20241004142228.271558-1-caleb.connolly@linaro.org>
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


--BrUYkNZABjXbWAI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2024 at 04:22:19PM +0200, Caleb Connolly wrote:

> Various improvements and fixes for Qualcomm
>=20
> * Initial UFS PHY driver
> * Support for SM8150 (clock and pinctrl)
> * Allow writing configuration to PMIC GPIOs again
> * Support for configuring "special" pins (e.g. UFS reset or sdhc pins)
> * Support for "clk dump" command to decode various clocks.
>=20
> CI: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipeline=
s/22527

Applied to u-boot/next, thanks!

--=20
Tom

--BrUYkNZABjXbWAI9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcAIswACgkQFHw5/5Y0
tywFTgv+LBV5jFiOgTI+kQRF8zzE6MBaqBTc6CkV3r8lX8OoPNJNugKvgyIQJvyG
HfOYf5vIWkpa3f94D7L2bzDCsrxx2jrbFiO+OQd7/JpsastJFZD4Ydf/Zv80M3xg
NWETiKVHDzcm7PRIgsm2opAyshUdjtqx+6cXUyyEVBwIgIX5U7Os7SV/zMOqla0v
4cmKlMo7zRB/OVyGUiWS86lg1jV+fWjYi+CqcxJHNHT+7d02EHrXJNhsZtiIoIV0
w7YwvEX8jZ8oi9QbKkaC+sNTKG0NAQ3QuByuZOH416z11O8uPdgr2fXzKAn6kCu3
AZ+vecV22x69B6U/nv2BFpL63mW8PHUgfe8cH0dE/6E0Qaktz7NL4jETYYhPaS83
jFhFqiJmOxiM+xGbL3ofFaAHZOy/iQhLJg44VH6nXCLXbuW9oZhpxJe6THlrbvkS
zaTRkn6bFfIn6sLOdz3iJV6apxF1U0nRJK7ONimAd1CnU8ySwfXknxwBO31Bm9Nl
aKauG3FA
=hICt
-----END PGP SIGNATURE-----

--BrUYkNZABjXbWAI9--
