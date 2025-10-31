Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935F0CCF9F0
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 01:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22B9A838BB;
	Fri, 31 Oct 2025 02:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HMGoPVd/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 910A4838C7; Fri, 31 Oct 2025 02:51:25 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A286F8331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 02:51:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-37a17d470dfso11726281fa.3
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 18:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761875483; x=1762480283; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vujd3zBzFTAPhu/BGFA8Dgmyk1Rw+fhfDu0QchMxihM=;
 b=HMGoPVd/5MCfY64K+JKJR3+cLOi/5D7pAmzZChAbwuP80xjuNz0gJ5tyVXx4zoTRk2
 cEkPUVwsWYk1pvEw9v3SrCXsm8knnXrTr/GfK7lhb01W+bkIgz6BK0+qyrsTTMBJOdCg
 D6zOXG3loXE8j81xttcis+JdK4e+tP7NVZ0pDBiO+iYjMacxTXRWdILRh4Wc8BF38cAt
 iZp6qWEChjukWlrT60BIBk4DxWbRavFRl7qrpBtcGEgssD7spUgWjGXrbkMJ3/FjbixH
 JmNSaskqSmy8WLgkMxij2iprtB15y0LoFlfg4sts7hHAlPqRVjrsRTKqrRu5+3wZ8cQf
 cD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761875483; x=1762480283;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vujd3zBzFTAPhu/BGFA8Dgmyk1Rw+fhfDu0QchMxihM=;
 b=tla0t49T1arhuPJeRb/KM8ZQve5SJGwT+BY+hU4H3tPYzcwU6TwTXh3F5rs9HhRW86
 Z2B6e8GWCgbNqcrDLxMgmtmrL4PL8ZgrHZgXXqatkpouxc2F3y1u/MjV+S6oreKWZFIy
 /DlMuFLpQT+oHB46krIcGPXx9AwodK2c+1p45QmMR2iQCPmkvjREAdsxC+iKxQaBQ6Y5
 bVIyEEYf1uQ6VOosa4qcxyfv8tUa4feJnG26PXfKnd43xZG8jxrT9DnhweqgrcXAaahs
 5Wm2FrtpwSwM0w/NJVzwSWCTo8iV95o6ChcKAwH5zdQ813jO8Tjj3M98zvAo0FWLGaVB
 /MHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzMWR3xLSdAm70oN1LsdJPOk9pnpjLxpBa5hBqxP80xXaqb3tCRCCKqOs+mjtAuQeQdxIYr7o=@lists.denx.de
X-Gm-Message-State: AOJu0YztFS88bMjdmlr7VScseVbEAf0p/SEAZ4Se+zww6rUgZLQt8YQ+
 6+A9dm3CBxcJPT6aNfZZVq/cysiIo7YVQxzpDP/66ADJYTd1oylT02VgEZe4IdZ7Y1cKpXcL4WW
 44KaqjsTClLe4598oPLNWRC+6/cqBzrg=
X-Gm-Gg: ASbGnctfsQWpdSA88L+nCvXRk6GRF+bN7XeEuchuZ7zNo+sBEcIEQW5zw2ybYRbciP5
 Pn0+VQbxWLtYljvjGfu2uK7NVRH2JR8sGQylgssVnq0qkA3ixO/QWjfCRyJBe2+KovWix7ExzvT
 H6sk7TIWQs7i9jpCfOtSRp61IL32moyFJnSpIge/QRtetw0GXkAW4xij8VEvDlYeSgK9Lgh+xwX
 DQlC+eNEsS7oWJ8psK3PGFXFZK3M/V9Ld7EUhrd21feWnlgQWChhhf9yMzaCAp0tyYlS85CnQ==
X-Google-Smtp-Source: AGHT+IHq/wzB3LgMh/+zICEuXd9yiF1No4lGgPPf1oM4fLCfTpW979rtt+nKCXooxxegkkFmJzJAJ+CkmOowdSD5BCs=
X-Received: by 2002:a05:651c:2228:b0:36d:e147:3f34 with SMTP id
 38308e7fff4ca-37a18d879eamr6760571fa.2.1761875482753; Thu, 30 Oct 2025
 18:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20251013105507.35881-1-francesco@dolcini.it>
In-Reply-To: <20251013105507.35881-1-francesco@dolcini.it>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 30 Oct 2025 22:51:10 -0300
X-Gm-Features: AWmQ_bnNl4f2KkQpTxdYARcsqUj72DaIM1y9jAeRWtrLN6cDzUviDZLZfpwPIQM
Message-ID: <CAOMZO5BDwXe-N4XY+dJ91Z7QbFyOCcHLUGxrf5ZgPptJ0R3bcQ@mail.gmail.com>
Subject: Re: [PATCH v1] board: toradex: fix aquila imx95 0098 pid4
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Oct 13, 2025 at 7:55=E2=80=AFAM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> The memory size of the 0098 SKU is 8 GB instead of 16 GB.
> Fix PID4 0098 Aquila iMX95 definition.
>
> Fixes: 4c9340716522 ("toradex: tdx-cfg-block: add new pid4 support")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Applied, thanks.
