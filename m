Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA4AC25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 15:05:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6AE6885EB;
	Thu, 23 May 2024 17:05:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FZ/fqDCw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69120885C5; Thu, 23 May 2024 17:05:56 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50E1D87E9B
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 17:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-43f984101e4so11664931cf.0
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 08:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716476753; x=1717081553; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+kxAzw8mzV2C4Z39YEYhm7WTZ+a1F0Nt4jxdpepqQs4=;
 b=FZ/fqDCwxFTcVIsxqo9U5lP9T9dHq6A3O1dd/qJRBfrzH3YtvoMRkYdsCwop1PTSp8
 aUpkQfH8hiNq0ASgyNTvJlw6959+j5bzi4syGmQVEygHR0Q7+zDyz/7WPD0vMFqkzYbn
 9j+jPCAKB6RHpZg5MyYsogRILYQeGIS/uphAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476753; x=1717081553;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kxAzw8mzV2C4Z39YEYhm7WTZ+a1F0Nt4jxdpepqQs4=;
 b=PaGRDggA0M9vzk4Iwefum6Z+EujG0MjfRwSqLXvQfENFEKs6WlfGXqwtbg1hRM521N
 8ZlOgMOqGzy2Sxr2PgkiICGt8SFeuG0+VP4x+ZJ3g3W2CILi4mySTfFFq1kSWbtq8bXP
 0CVZOGYzOAFKDEZ0ot5G4Ohz3BApG583URU9+BB8UfkBCsMarwJknh2PDiZk9+E/2Caw
 txohylKX9hhoAumpTGUukiCueh7ILt1lVGv6eIrbdPscsJpar3OYijC9VMxVuL8f9Y25
 NpCJJZE2r4CLGBtB2IWVPsodm2FjwQKXrRQHl7eMAC4Ib4KwBq+qCERhwvvEOS62r+IC
 KErQ==
X-Gm-Message-State: AOJu0Yzv30efEk2a61RPgUQOLrzRIK6UK8HgAAnau7koTGR+RatISc+h
 C7ozlZ7Zrl96TCH+4mB7Q3SYwBXAWfflGj+DcIefrr4XlYGPVN/+5n9Oxr1LAEk=
X-Google-Smtp-Source: AGHT+IH7FqWNvLFkW5nt5rzjOvIP7EXSh1vi8/3/VXXvCaknzilTIzru4BeOY8Hy1966Kc1VK916lQ==
X-Received: by 2002:ac8:5912:0:b0:43a:bd92:6ad4 with SMTP id
 d75a77b69052e-43f9e151ee0mr48825221cf.46.1716476752977; 
 Thu, 23 May 2024 08:05:52 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43f97b8d3ccsm31252861cf.43.2024.05.23.08.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:05:52 -0700 (PDT)
Date: Thu, 23 May 2024 09:05:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: Re: [PATCH 11/15] cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y
Message-ID: <20240523150549.GP2568172@bill-the-cat>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
 <c5bfc875954340d5dffb57c6bce0b4a9a99f6051.1716393035.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wZV39XCB8/YDpT/C"
Content-Disposition: inline
In-Reply-To: <c5bfc875954340d5dffb57c6bce0b4a9a99f6051.1716393035.git.jerome.forissier@linaro.org>
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


--wZV39XCB8/YDpT/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 06:00:11PM +0200, Jerome Forissier wrote:

> Support "bdinfo -e" when lwIP is selected.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--wZV39XCB8/YDpT/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZPW00ACgkQFHw5/5Y0
tyzGCgv+JvLs6btQ9adryJK6CfXZ7k+GHuP1DG5P6U4x4e/w5GlLSjlmm98Fy59H
u/w2sFVhvvw5Oigw/GzuYvxA921hj+oi2TnaEUWLMEZsdY2arAqgT4GpOB7krUfZ
W0LqPDzFq6tl8m4w+ovLbpowIClRghF7GuSFgSpYlkNYxEkLeNke5JnOTPj9Wc2s
c6U7POSh3jykJTmtmOhyDye4qr71uYYugHvcV4vyktAd9bnd52eVgiWVIwXXiP/d
ItH2i9elqw63HD3Hw8BY7UcWeTUbVkYUJrpXpIavjcfhENOtqNtok5CaMktA1RcS
TA49LLSFqJg3c9y7FrfPSUSPwjsiQHpacAzVbrSrSNaBImKXL7YhtQiU2++gQNho
m9mhjp+Nya3vCLfB+izVX+3rrts02nDOKaji+XaMIBbs7S3cCzphLbquRTJRAFDG
pf93TrB/w1srBIJAlL1enyaQUiTEG1tOPl5vPie/dQxNko3eqYjtrWjNcY09v8j+
aUgrsu0R
=0aJ1
-----END PGP SIGNATURE-----

--wZV39XCB8/YDpT/C--
