Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCDFC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02CD2884CE;
	Tue, 28 May 2024 16:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gf+IV5LD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67521884CE; Tue, 28 May 2024 16:53:57 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF266883B6
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:53:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 4B812CE1192
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 14:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7756EC3277B
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 14:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716908031;
 bh=9tGw+z1Zt5Dci5FRSALUEpOqfWgv86nBetO910mLjvU=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
 b=gf+IV5LD7jTB5tubulPlcwPKubADIuDPDTpWOTfSXJ8x5c8Xgpix+coMXOOXqQeoV
 SKQY5jkQPbrxEyuviJodsu4BCl1Dg4/Crw3htlEJy86ULMdyvWzyTx3R40F308dGti
 0W7QXEB69RSGev9gkeMBWUGDHQk2qcXbMFbuSfVs+X9rHFGMNO0VdTwLGApCqwYBsY
 Ta5lndnWRYJos28faUxwmW/TuLEXuB9fjaLq9aDpB9NUX5vXRZM4fcd3JyutLI7ws5
 fU9beNEtIs85eqTxkfCswEEF0I4NZgPdpQFcZMJYCct7BwyiRaW0zvjayBv3v6bQW9
 cvS+ST/s896cA==
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-2e95afec7e6so35516361fa.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:53:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCW8HVE5w8KdD6I0MxyLOR550wTfhlX9yAwlvcqUrP7ytb7cEtSeP4LTkxa1mtn+6A0ThtEtAF/iCD/P/9mM1kxayir64g==
X-Gm-Message-State: AOJu0YwnoHIPg8+7G+eR/C0B8irbemyZ+NJtZCM7talgHIrHrHE/FU6K
 xQTgvQQrS50BADf/tZgg3WXswInzgPkPnkE0UhP4E7Pa5BTLp+Sis0bX/gnF80nYcpvpQ0BbgmF
 Tr2dGqyCcfFmwZ83U8P8ezSHEUv4=
X-Google-Smtp-Source: AGHT+IEnx7oAnjMfteweZNgs7bWo602GXd4T0sMM9osN0evP8EiXUCzQXspQkkA1F44fHz0B0TS72cLfqYWCsUEJwGM=
X-Received: by 2002:a2e:a23c:0:b0:2e2:6f90:8b84 with SMTP id
 38308e7fff4ca-2e951bfba2amr50998461fa.17.1716908029869; Tue, 28 May 2024
 07:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240509231316.11391-1-andre.przywara@arm.com>
In-Reply-To: <20240509231316.11391-1-andre.przywara@arm.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 28 May 2024 22:53:37 +0800
X-Gmail-Original-Message-ID: <CAGb2v67sxBao35Y1GrPB=Nbny1UrpDKk9ZEa5pXWnQVJ3L3gpg@mail.gmail.com>
Message-ID: <CAGb2v67sxBao35Y1GrPB=Nbny1UrpDKk9ZEa5pXWnQVJ3L3gpg@mail.gmail.com>
Subject: Re: [PATCH] sunxi: spl: h616: fix booting from high MMC offset
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de, 
 linux-sunxi@lists.linux.dev, Chris Morgan <macromorgan@hotmail.com>, 
 Ryan Walklin <ryan@testtoast.com>
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
Reply-To: wens@kernel.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Fri, May 10, 2024 at 7:13=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> The BootROM in the Allwinner H616 tries to load the initial boot code
> from sector 16 (8KB) of an SD card or eMMC device, but also looks at
> sector 512 (256KB). This helps with GPT formatted cards.
> A "high" boot offset is also used on previous SoCs, but it's sector 256
> (128KB) there instead.
>
> Extend the existing offset calculation code to consider the different
> sector offset when running on an H616 SoC. This allows to load U-Boot
> on any H616 device when the SPL is not located at 8KB.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Make sense.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
