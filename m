Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1FAC3ABBC
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 18:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29F3482161;
	Mon,  5 May 2025 20:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QzcsstAT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 173B682163; Mon,  5 May 2025 20:23:54 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02FC28215B
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 20:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5499c5d9691so5643570e87.2
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 11:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746469431; x=1747074231; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5jMfhK5C30vWySAsYeZjG/13dGTP9GAxBz6zBP+6j20=;
 b=QzcsstATTDvkAtpjLg2elVmWGgsC5spHp/kbLFSkpIum/S7/kWznQHnLthehWjdl/V
 6ybXWsBBH68baLGL793MkSJk1Ta6crMM0MjF5s1BH8r6KuP13Od4BbriZl0ZTbJtY0qz
 oxxrLrwdEUZRgSTQXupizTuDs/5M9bFvGWXt2gSzpKJwAgk2avzflupHfN+ZyY6In8+L
 Vp3i3M9hc9JkiM1eKx0as8ZmazHP0dx8LhuBW5SeEAO8Mnj4BIiSBT8ngLiqDh26IzCF
 uRtXJT8nVblL5+kE5MdtBRIbcEkGJXsZ3KQ/VSYCX1rg3vjNeL/RB5xI6BBbO/OmR1L3
 IRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746469431; x=1747074231;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5jMfhK5C30vWySAsYeZjG/13dGTP9GAxBz6zBP+6j20=;
 b=TrhDSxV4WKEfwdhYH2KnZbAvS0FAFlOfX88Og2WhDuuxsn19kkNdc6CI2ykiamJ3hG
 iQiZYnn1KOUjJgjlk2/G8Ff9Jn37Ww8a/pKgLJpwI7UiILAVlP7EocbT/WhuXYKVMA+Q
 tqGDhlzbVAh8H116dX5XNrauNRP+iLJe+usb81O4r11Po2X8cX0ckUCGfjBZOU48Y2Oe
 rq6CKCgpBL7q4JbdbUiqWvcxeN1XvXXgoGnLy+STw1CMRBCjDrVgZlLPFO86P3zfjs0G
 o+w4r5vKSQKnqFODMCzaygFy8eKsPE52PGaEHN6Q+x2qSNhOb3k4qy7oOvgV3Vntee1+
 IGrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9+4bzH1WP3NUcWk1bCZm8tJtXj3MCerUmnt2xuYZq5k1LX/489sCw9GgjIp4yK2JWGgDgSeE=@lists.denx.de
X-Gm-Message-State: AOJu0YzW2q5J6PyMmDr7XqqY0PVpyDA1nWqW/5uMdaBKZAEPL5VpAlT+
 M1+hr6rj1fuS0YBStd/nzsbLnMMl9Nzbhp4geJ5DqNfTw8j7L1Cp5MKG6e2HUbCobzJ4cDMCVKT
 zo0gTBl6YcENwWKuSjSiq6mzcOgw=
X-Gm-Gg: ASbGnctrz3wEiSjgEK5uDcKC9e6WtO8hZsvuo1CNwj1XcjTyFY3BjwZlK+DYQea2jV8
 1/U1j9CVfgOklmN+wx/PyhykgQh4WY+W4SohQHwJWuz30vtCN1KVdXw21O2hI6Fuh1MtQLCE/RD
 q00GLHdEUUSarl9vTBZNsWiAyGqogdu2uCtxcT4xNbAhGVmqXZ+TynTg==
X-Google-Smtp-Source: AGHT+IEXzOvSOeFjXj7UTP5lqK7Grk1o291z/+g8VJw6f5T1M88x2XiJP3ZRww96611QTpPzyxlrCY8QnEOEg5/FyN8=
X-Received: by 2002:a05:6512:e9b:b0:54a:cc73:1460 with SMTP id
 2adb3069b0e04-54f9efb7114mr2235041e87.1.1746469430869; Mon, 05 May 2025
 11:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250418210430.27458-1-dullfire@yahoo.com>
 <20250418210430.27458-3-dullfire@yahoo.com>
 <CAOMZO5Bfq23ocQXd5pvsHzD+dnRexW=PFunf27dwtmz2o_ov-w@mail.gmail.com>
 <865d511a-c571-4f12-8f5b-a3182f2b67d1@yahoo.com>
In-Reply-To: <865d511a-c571-4f12-8f5b-a3182f2b67d1@yahoo.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 5 May 2025 15:23:39 -0300
X-Gm-Features: ATxdqUHtmqLcy9xaLp_70Tqx2TGb2Tjq1bqL-BqYX0C4HDc6zxt8AzSE_TqZpLQ
Message-ID: <CAOMZO5Cg9W7kfUPUbRhMX1TSfwd6G9KSQBYXyqdkAgp1aR2--A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] spi: fspi: Add imxrt1170 device data
To: Dullfire <dullfire@yahoo.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 William Zhang <william.zhang@broadcom.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Haibo Chen <haibo.chen@nxp.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
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

Hi Jonathan,

On Mon, May 5, 2025 at 6:57=E2=80=AFAM Dullfire <dullfire@yahoo.com> wrote:

> Sure.
> Should the dt-bindings include update be part of the driver changes, or t=
he devicetree commit?

It should be part of the devicetree patch.
