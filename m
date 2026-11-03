Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C39606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ME3d/CRC;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=TYTAeihw
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D56DA606C2;
	Tue,  3 Nov 2026 14:54:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kQa-xrY-CQ-b; Tue,  3 Nov 2026 14:54:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1C945606F3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793717679;
	b=R7wbrRzWVVuYloNRhkJZwpijrDsVMf6cEDABoaFUYps4L8XEoC/D4LqDvpurAs0Lk0Ay
	 ckIYVyXCpQCx8+hnH4rFBKXl/90WUN1Xzjs4NDPmRW8hjf2+jORO5laK7cGDocUborraG
	 WNzlhTogANU8CiwAfmEmBeKLj8aQk1rr9NBiwSRgsBBDwAQLrtb1/PvdSc1/MEV7SnYed
	 albc5bNqLTJvIqE0AujmnT4kCpNyyLUo6zdQdW2DXU37JfRSPeUG5zY9Tz8RhQMh4OGv4
	 HPkW6qlCB1w3DuPDy09ZKOrTFmiWvM+1rw69z/IXKAuWINj3m8ShJUvnKfDoQNySZZg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793717679;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YgnH2IVNAJREnnHYjXMIUSiaVHeH0x+d5//h6QdptiU=;
	b=DRXSd0HmWelK8Zm6l7CY92y5hd0nVOvhrV2e68gt6F7Z04kNkhLfkfnLjDKIhIddPyCo
	 e0vrtlJtGE8A9Olv1nKdP++1RxyMWXTiKZsHv8k3+ncLA3lehZ/kAFk+qG9UtUdNbrKRr
	 Z07FUXVcJ4kFJBwwg7IPNCoEgL0+37rYBLt20wTMpI5cCzSb7ckALMeUN8S8S6BEsImq0
	 ih3HKa4RCqgssDrkInVyjnrd5tJqrItbST9/k97hf1OpmL0+Bgt4cXfN8sEnc56y+63gb
	 kOEVKwHBxJFL9rTk0/iiGCu1mzJ3hfO4ClS3WlSX5OD7TfwrZgaKWH4zdA/UQ2J4B/Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793717679;
	bh=YgnH2IVNAJREnnHYjXMIUSiaVHeH0x+d5//h6QdptiU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ME3d/CRCUPz6bqGi64dRGoB5ar8i9jvcaxI7glMp8DPRsHER/YzgGwGm3awM8Z4HV
	 7M8z/bVme5z51BxGBm/ouxzRx27tFnW7o9dtw/8cCubQdwDpsS5bMAKnXTNJU7PeoB
	 zA+5PGy4jSSX65hjv5o7XSEs5Q/LbszlT9IfmK2FnmIN7pjCDFtULI2vfYNzKiFxTz
	 gyJ7I3xTo9n2b7AOauqtW25E4s+68SMKPwA8Fs7crxW8CLCoQ46GhrjJcb8rwxaxD2
	 39zD2Zx2O1wDCEjaPNbOdIMODyu52OS9G09BPNN2tv34w5hGtmh4lUBMHFBPHUy/Fm
	 L5uMQmlGZR0uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C945606F3;
	Tue,  3 Nov 2026 14:54:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BAD5235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:54:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6125B80AC4
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:54:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KgYomKmRbRMl for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 14:54:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F097E80A58
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793717677;
 b=SuFL6HnsW7ASgPc7xSWcHX/l3lRB0qHqoBt4UKrdUIo1cqUar4t8wU04P2olppDGFW6N
 6tokBRcOcjT5Fw4iGCcWWGAkXZ0WuRq+VJ6RnREYVE3kkrkQcpdSAgNGoxdxkTTrvrOio
 Ti2tUa4fDB8dsvoyrzMP2wS0LCeeeI6e8XJyOtLsfcOSEkFWFbwyfTNQhXrIMKx/ugsz1
 BMS9G2t2ZnpvOqQiE3cEpwGAlh/3ccbY+Jv42LE4W9Ziqv3+YlK4niktzm48jpPicUE+8
 nJLnfm84zo/b12mvs85cov6PVGfjy+zA5PfKdvoO+XfvvOZpftuNo9wbWgu7wIL8r4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793717677;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=YgnH2IVNAJREnnHYjXMIUSiaVHeH0x+d5//h6QdptiU=;
 b=Jb6y9ZcCrRVRp6Ie1yfKc7hC6wp1TsxkgKFTz79vC9RGJWZmDQvUi3iLnVPZQzOoL7Cu
 H++Y8jG6bBaVTSx04lbJxAVCUnPduKlp/ydxUT+rhw843YHmQOlj812XTbk7NZBvkK7Am
 k+/4A/xbYUiYdxXgf3aXmkcL/IxTv76tsbOr/Tskz/rhBFWrZaNlf/weYbz8M7q4dRAJB
 c7sKoMgcK5bZT9z1QgWYYTie00rkDfnp0L/YOtd+q1kEOPI9WcSt66J0PJhykKDlO2LOg
 GMwEKxFQlO4swIuHFtBDGZZp6eS1DTfuwP8TDKkguJ4h9j8Lx63XOjjTYDTg84UOH3w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=TYTAeihw; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=TYTAeihw
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F097E80A58
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:54:36 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6b2237b596cso3582218a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 06:54:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793717674; cv=none;
 d=google.com; s=arc-20260327;
 b=XWIlrr0reP0klw1h5Hte6bzMowB+aJYEDs/7d4QlpC8qAvRg6mPiKjdFrb06ozx4Ra
 /dkg5qtnUCWykkJIcVRK3ZRFX7DT7aYk4YgNSRG+jcuenyp9oeYsG0D817hRo5mKIHMa
 ocdRpJ/JrRmdC6Nrckgd8lJOwImkY42LnImafwS1wYBM2C4X9T0GaXKJR57fnK35d0Tl
 g+ROb9wwkqFHSrdWSK/y1bypApaV6fbBAj2sXwdYBnnkjx41nnFo/Ornc0NVHaXJQ53F
 GGxLxTKg2vZpgU4eriJ7xFfswc8L2l1HNA51Fs25a8wJbSNxTDtGzJ55f8kc7dryOc8D
 zJqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=YgnH2IVNAJREnnHYjXMIUSiaVHeH0x+d5//h6QdptiU=;
 fh=TGQ6P1wgSTDO4lf2kAye1RABSawBFYMuHO4f5FkKn18=;
 b=UpdhY5j87Uuw4yJNKPo1CC6FFfq7mJyD5dvBW75nuiq8Axqsu2qGPAUUpNaF5RZ7tZ
 On2domHBvjLHpA7qL16YWIX3BJHw5tCoHgOKwISGrVwyzUlNXjMOrSEQcDMpVWdN2csx
 l8+9AlBSfJF7Ro3IbZZkj9wfwHUOr2E8bQ6Qsb5NwKHVlaWepHlafqQtOxAAFw7y65aP
 HT0LBspaRfxNEExJNnivlf7FV0etkU9SZHC3S+6Qv+48okTjp5tPl19V9VL94SMH1re5
 w4FvHVcDdBUwI0H4vd/Y+dUrxPAe1QKNqBaA5m+bPV0C8nj+nCnUxc1RXpPFsdKm/fR3
 Qm5Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793717674; x=1794322474;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YgnH2IVNAJREnnHYjXMIUSiaVHeH0x+d5//h6QdptiU=;
 b=TYTAeihwQ0/cmtZjV6uoWHoZgIcr//1gtO+I9lb5qH/CKRgxF1lITx0T4vtq+iUFIB
 pDfzLfixpckl1XWWJoFebHN6rCL+5ZPh6vNHe+LYqfmObzj4PP7BcMYO+L0mhjZP/GFp
 orUBc6WsJlJN0oFrZTSegJ61QUZ5+Ah/BX/Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793717674; x=1794322474;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YgnH2IVNAJREnnHYjXMIUSiaVHeH0x+d5//h6QdptiU=;
 b=1ZvOfL/9mLWvPuL46fBGP/9a7T71QeT3faFJlrTh5N57YNYzFYFKnuz7sX3i9/esqf
 dU0BN5TwocZmsI2KoLLZtuKVkqBTdi8FpUZC5WGTgUcTJrvexfPcNhUSCbrSXACYwCv2
 egFKAX5awwJDlnRawtWUbQgw2etxLT+M6E+a+rJDkwu0UfhwfJk5TLVDSrUUUzm3bO/3
 yofAUSaqO3nXU9CJW3uebF2ASGWJUtj9CurpJvxMkVC3NHTa+zpNZrN8w3Hirq4OmynE
 C6yMq4yLQggAPaGRVYIMJjUjqSWYvmzpDRelxwJpwE2Np0mMCXOFS6ethiW0Bq+qBVtY
 WF0g==
X-Gm-Message-State: APuU4Z9XX+/CyHCl/cDAwFkSKdG/vEuf0IGf0geAkkZXda/UrvbUDwc2
 hgAiOqyLPh736BUou+7kOOfM2yCMckk162cP8+RoCDVMm2vOWKcYzUgy2v79hOA+qbllEWsxctY
 kkorHg/mMSFbJCS0r4jy4389XnJy4RlUZNM4vjB0R
X-Gm-Gg: AYBFou0Z4QDakJUGaJhaRAZxxSNbUkRrmIYLUaRhw0xq3+rciMQdBMmsEIHtBvftwUr
 1DUGIDysAyozhT6UddTtvEZSug0Q6yhx+qj5eTTav/uh2Xq5xyPvPl9ckw64bTPuynX8Ku81I4X
 kNpfnuOVoubcKi6uMh49gYRhiH2QLaXpJJ1p86i53aAlaV+m/ESfuEdPhS3KQOCZzokJgLz8Dt5
 n5RqoTzsyAcA7BXTh5k9/KowlYx99AOVyMMybp5BgeqZ0008xpz9Pyes5tZ1+g1cYF2oBlDDCrX
 k3oWwCuNUDtUu3C40tEOnyp2wd5oYMBRAHkaQiZMNBBA75pwpCOGNp08Q4pzjr/qO/Y1B6epGQv
 CljnI0qmZgjbHHTji0TqZdsh/4oXyPbV/o5JTjkU/jKy99hs3jeglY8I+XgdC36XzD73Ny7Y=
X-Received: by 2002:aa7:c14b:0:b0:6ac:8dce:5a8a with SMTP id
 4fb4d7f45d1cf-6b4d428edaemr7120880a12.9.1793717674545; Tue, 03 Nov 2026
 06:54:34 -0800 (PST)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 14:54:33 +0000
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 06:41:14 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261021-milkv-duo-spl-v1-1-ee7618860237@baylibre.com>
References: <20261021-milkv-duo-spl-v1-0-ee7618860237@baylibre.com>
 <20261021-milkv-duo-spl-v1-1-ee7618860237@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Nov 2026 14:54:33 +0000
X-Gm-Features: AclHuK_A97-SECR-Bt3ojPGSa9U1meJCU-7UoBCHvyAZlbdXc9HDm4RQvh0qPZk
Message-ID: <CAFLszTjyv712mvZQaCX=Cm7nM+b+t7jBAeNo4O-KRAbx5JfAkw@mail.gmail.com>
Subject: Re: [PATCH 1/8] binman: add Sophgo CV18xx FIP entry type
To: hfranco@baylibre.com
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Marek Vasut <marex@nabladev.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Kongyang Liu <seashell11234455@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Bin Liu <b-liu@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andrei Lalaev <andrey.lalaev@gmail.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Udit Kumar <u-kumar1@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-21T12:54:16+11:00, Hiago De Franco <hfranco@baylibre.com> wrote:
> binman: add Sophgo CV18xx FIP entry type
>
> Add a binman entry type that builds the FIP image loaded by the
> BootROM of the Sophgo CV180x/CV181x SoCs named fip.bin.
>
> The image reuses the layout produced by the vendor fiptool: a 4KiB
> param1 header with size and CRC-16/XMODEM checksums, followed by a
> 32-byte BL2 header (first instruction jumps over it). Unlike the
> vendor tool, only the entry's subnodes (typically u-boot-spl) are
> packed as BL2, since the BootROM does not use the BLCP, param2,
> monitor or second stage loader it also supports.
>
> Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
>
>  tools/binman/etype/sophgo_cv18xx_fip.py            | 89 ++++++++++++++++++++++
>  tools/binman/ftest.py                              | 54 +++++++++++++
>  tools/binman/test/vendor/sophgo_cv18xx_fip.dts     | 18 +++++
>  .../test/vendor/sophgo_cv18xx_fip_bad_offset.dts   | 16 ++++
>  .../test/vendor/sophgo_cv18xx_fip_collection.dts   | 19 +++++
>  5 files changed, 196 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
