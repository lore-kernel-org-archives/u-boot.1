Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DECC61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:17:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E4786070A;
	Tue, 25 Aug 2026 19:17:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GbfF4yIuK3zK; Tue, 25 Aug 2026 19:17:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787685432;
	bh=e7uv8HM6jZI2SyYgklnONMkfXLhLhsgdDunX7Vgb7JI=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HFaajuHngGtY9TW11vVoMlTrOjH+aEn3Eng1X23QPiBmM6mfCH4jmDsvM650+wV/W
	 zXzaguoM4LAm4vUTPDY8prYAMeVpLoi1Im9WUkxCjQbcSe77Txld0JskpFRRPKWc+F
	 CcwveP8b9YGZu7KoXnTr6qypbz6b2SW02zPK5Z08DjFDoMovFBHACQoDgLiFvb4PGR
	 r5jmioU0jLFZ77dW/KqudEtlaYsVD/c8LIRVchlm/wINbV55kLhV6ZrvyU7114wEy+
	 t73LXdoVe+eSWbRlHPrTicXTVZSOFekMUalXXegtoe+KgwVFDNsbwutjDrlIWkKbPy
	 jD7gUDXv6wr7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 331F9606E1;
	Tue, 25 Aug 2026 19:17:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 66DA3105
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4CCFA4057A
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:17:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8F22EYSNARof for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 19:17:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Pa5gunlK
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A1CC740576
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:17:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A49360053
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68D51F00A3D
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787685428;
 bh=e7uv8HM6jZI2SyYgklnONMkfXLhLhsgdDunX7Vgb7JI=;
 h=References:In-Reply-To:From:Date:Subject:To;
 b=Pa5gunlKuYFDx75gyLYzdu6b6ZoVDjOfTlhrQPb1LTEMsRRdwe03ZwuKEdUNaPrXr
 42Nyb+dR6d4M1Gm6xW8txsXayeepFzgM2X5pGsyJHSyy3b6rvJIIKrJHnTH40s2Gkl
 BHv4u3kSFk9QZeDnW3NTaLFOdRiaWPBA/icGCr5sUXUg3gucgEyXazrfGGHWOgtzcm
 xX86FO1tSnmuUvca5TctkoLLedBvKCTaRSqk6AL5txIQIdl50+JPwL6U3Ku+CBDQ9v
 hZuCfu1Y6ICLUPKCZB8q8iXAn2SpToTsBdgl4XjEap0LrKD17vhxDtnVceEVvwu2Nr
 AVIDlWSXKH/tw==
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-3a1981228f8so957431fa.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:17:08 -0700 (PDT)
X-Gm-Message-State: AFuF++nhMMx+dIYynLK9J6BporIbi9t629xqpVuRzSJhsRCvuOwl+t8U
 AMt1cefZ5+BO85rOKn2Dd0Q/2AGITJDThp8YQWvhs2mXLE7HVXrgeKGNq++Lf35g6jD2dfTWr5+
 Ywm04Mf5qMMDbIkW4TlJlV9hwE4eSC/g=
X-Received: by 2002:ac2:4434:0:b0:5ae:bba5:aee8 with SMTP id
 2adb3069b0e04-5b4a9092f1dmr70780e87.24.1787685427473; Tue, 25 Aug 2026
 12:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
 <20260825-ux500-external-sdcard-v6-5-61446b6c289e@kernel.org>
In-Reply-To: <20260825-ux500-external-sdcard-v6-5-61446b6c289e@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 21:16:54 +0200
X-Gmail-Original-Message-ID: <CAD++jLmh-fYQsAt=7Js+Lz9yKLy1zAE5j8t0JqR6PkfqUeA3Lg@mail.gmail.com>
X-Gm-Features: AcwNN1X1tzHwceZq4K5pTa5KS1YYXn3NNRHuV6Jf-_8eBYSWFyJuPGNysjbQVho
Message-ID: <CAD++jLmh-fYQsAt=7Js+Lz9yKLy1zAE5j8t0JqR6PkfqUeA3Lg@mail.gmail.com>
Subject: Re: [PATCH v6 05/13] mmc: arm_pl180: Set initial supply voltages
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Tue, Aug 25, 2026 at 9:04=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:

> Obtain the optional vmmc and vqmmc regulators and configure them for
> the normal SD voltage range before card initialization.
>
> Request the standard 3.3 V target within the allowed 2.7-3.6 V range.
> The regulator clamp operation lets regulators with discrete selectors
> choose the closest supported voltage. This selects 2.91 V on AB8500 and
> 3.05 V on AB8505.
>
> Ignore the unsupported set-value operation for fixed regulators; their
> voltage is already described by their fixed constraints.
>
> Signed-off-by: Linus Walleij <linusw@kernel.org>

CC the MMC maintainers too. Will fix for next iteration, sorry :(

Yours,
Linus Walleij
