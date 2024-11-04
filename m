Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C70D132CA
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:55:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D286988D3C;
	Mon,  4 Nov 2024 14:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qgu6rITJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2B8388D14; Mon,  4 Nov 2024 14:55:52 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ECC888936
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6cbf0769512so28219136d6.3
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 05:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730728549; x=1731333349; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1u9DoxHzmVVg12WKzMGAyGr9fUhU5DkRCE/q48Tp158=;
 b=Qgu6rITJlEYhx8YtSirmbcS4qLdb2Xqk/2CqhUVzLYTSL9JardWQWQ5fjpSzJlhP8B
 TdSxJrhGp20hZC/twViV+ehHeg9w+YENnoc49e01zz+y2Yj8Qs5eObYqsBZBnQBu25E8
 I1hP6d3rMqssoJYGYMozOl8vZx7uiSbPs7XYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730728549; x=1731333349;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1u9DoxHzmVVg12WKzMGAyGr9fUhU5DkRCE/q48Tp158=;
 b=nh77NPWn49l6d36PoNvNsu83hIWYuJRchlnzxu+iYmsJwkXzekONtZiWGX+5WTOziQ
 MMDPs3wMhH+JlP/s4kQ4nRyQhZndpByE2qlkTPb+tZyYl5dh2o8D2XeqZVkxAyHuchvT
 bBHmh2nHHe22gNSloD88H1yJd9DRRcVbeGSkMKQYfWDE/cHwHCBHS/jVWdEHGw0nLDV1
 IXr0k0W0YLR3kCX4MjVn19hk7jkZOLbe5OIUcggqTxanCPi0VRA/ijJXiAUBQqrFBsa8
 jZKH4Op+H+YHS+HzUZPn9iyjPIQpllgCx/BEL6PRfU/SBeoLTlvtCCe3ciI5NhHJ6Dmd
 Efhg==
X-Gm-Message-State: AOJu0YyVu8jfCNym0bRlj7UWnz55Fg6L9adQgRqG+C/QF2kCyFjbiyFG
 HEjvMqQ4Olh+QMqhD3bku5jZB5ChrB4wiCv0E14wz4WlDo3gS6k3cPKLGvnoGLg=
X-Google-Smtp-Source: AGHT+IFXcb3yNzwucoLFOuZXGBy4xab9HNODSOY0de6cRxZNecis4e3jBd9tCsaJjn+Rf4/zRXYNNw==
X-Received: by 2002:a05:6214:31a1:b0:6cb:a616:7c7e with SMTP id
 6a1803df08f44-6d351a8e335mr237976686d6.2.1730728549290; 
 Mon, 04 Nov 2024 05:55:49 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d354184748sm48747806d6.131.2024.11.04.05.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 05:55:48 -0800 (PST)
Date: Mon, 4 Nov 2024 07:55:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH 0/9] CI: Set up for an arm64 runner
Message-ID: <20241104135544.GH3600562@bill-the-cat>
References: <20241104133954.840994-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eQieYjkp1XFFEXDs"
Content-Disposition: inline
In-Reply-To: <20241104133954.840994-1-sjg@chromium.org>
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


--eQieYjkp1XFFEXDs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2024 at 06:39:44AM -0700, Simon Glass wrote:

> All gitlab runners are currently amd64 machines. This series attempts to
> create a docker image which can also support arm64 so that sandbox tests
> can be run on it.

Thanks for starting on this.

--=20
Tom

--eQieYjkp1XFFEXDs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmco0lwACgkQFHw5/5Y0
tyw6UQwAlKKJkhFLCt0q6bZvhwXooNkJoCun1EXO5qcjyJ9Jp8GWtKO37gpFoGCH
7OccdQXoIC0KQWxz0IShk4qhl3/SOG1iJmhLYqEns7B13hY6PHgPAIVFP5z0Bj34
sNvYaDLJ2neq+2n584tGcn8LJq6Io+FPiMsmPVSh5Lj+uKHrnvOwvp1mQ2+wgFHl
ZWJFiWMUEQqri3RKCHAdpKC3X6qDMqDlUSXwaWZH4y5r6v06SPgAqUPE8i5Yp11o
fP7kVM6u6H60FQlAYMzuO4Ux+hzptu3zppwM+5DTSD5Ab5VzRXS3jZ/mXh/B80+g
48CImG0iXeH03MjtaRoch4Du8dmKKDYT1dkcGQ5mIAVouaeQm093KaFDwJdFLmHN
SjBtpFO1ZLxm8AELMV9pl1mR434wt3pYFkbj4AZRcZG1rvQzSe6F8iDjbahVednW
SWh7rCjMMXZZu2gG999fH+Dp1NbxYgF+ati/RAib60HbxKO8joWNCawIyw6ijuDf
lCIsA4NZ
=VTNx
-----END PGP SIGNATURE-----

--eQieYjkp1XFFEXDs--
