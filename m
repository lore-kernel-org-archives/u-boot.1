Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFA0D46BEE
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 18:55:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E357783CAA;
	Wed, 28 Jan 2026 19:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FXHTuBcP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53D9583CB1; Wed, 28 Jan 2026 19:55:38 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63A1B83C6E
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 19:55:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-37fd6e91990so1682911fa.3
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 10:55:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769626536; cv=none;
 d=google.com; s=arc-20240605;
 b=BpWV2SlsxIxgkOyWe6UhI8Fy5FdJEY2s/FqGGh0jkuUsnW/S9FwYQobbRmHSWd/DWp
 958XyOR/QxZDhxt9NAzzB7J8DFocSPaE/zcREedP7b1P4mOgSUKTNc6T82knNSceZOpy
 MXzHYBfBr7HBpYMDTgpUoez1NUm5VO+cVGzfA+57kpfy/0m3B87hPjaETgZhU05ISjBi
 JqxwuNoFXe8Ygmz5fr7Wybt+BZ7x7dp5F9ZghMsiQlvjyUNWU1NWmEgngvw4wlFFm+8o
 mOVUzG14bcXuDJ7H1vZclNu8O+ujpt7cJTft64VszvsCOoi9/IyBdRqUJ6iGM+1puKBy
 5Exw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Wal6u3P7jDqOwJPH1p+bVzfMpSLtDxeNW3TLgrX1tTc=;
 fh=9BPus0yw327gTQle30Kr9dCX5TV3W7iVVJS5r3yt3jY=;
 b=CEB5JwDsv2ng01vjOZEbh3qB7ZSAcQgiTLPSBFJxmgj2J6EfcqykLNHnUfi7iEiaES
 dSeoMuaAaSxl2vgb+qGpPzL9mfoNfPZc5pA2Bipy6S5UkO7fdpBdmzLyND8X2IIMuljH
 V9Me1W1lmOQ6Tt5isIHf/VdUSck8XSn0stcIluxZ/kbYYoji8rWm2fD8Mz16nO5aUZFS
 tsgrx16Cax46+IwMv6msko470WEeTdJeOgyaPrWsNLCFOYG1cpMeWD5P5m5gt5k5YEWK
 9wGuBZraS2Dehc2B8bMdf4BnDxovhM8uHQOd2HgGEv1i4riJqN22o3fzWk1YP+g3yRfD
 AoaA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769626536; x=1770231336; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wal6u3P7jDqOwJPH1p+bVzfMpSLtDxeNW3TLgrX1tTc=;
 b=FXHTuBcPouwbwj6qlLkLIEEwweYrjAfFrL+ZPNGxELznTgsrmM68POSJTmxxYzELwH
 X/TACVwH+ibpwGrlnhZbQJghhgxOQyIjw4v0Uk39v5RmPrk32scxfG5Mun+8Bgqifn7I
 9S/JzVgHbroAHUxwQaTTz6IHV6Sa0sa+jYKstj3XCGw3D/RRTEvArk9xtUnRmoQTAWNP
 K/rJkFtQkOS5WoNNHvOdD/N+cARftpdhPFXS32qR11AJHHJevh5jt+bnsEZu/cAYoDhQ
 fzjUWuzIq1jkfKyO7M8HWcyb/Cj2MECnlkE1H6zHE0Stl0txSp7bx95lUKvfGgsCEA7I
 pQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769626536; x=1770231336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wal6u3P7jDqOwJPH1p+bVzfMpSLtDxeNW3TLgrX1tTc=;
 b=XZ8BTwaPqfQn1PoEc5su+D2tia+NDPm6fTF74YEX1wEGGsear4WVG818LeyF9Ejcx9
 vU2J5YArYZ44xZfPPef9rSDPWuNZaNVpeeevd27OeEy97+/cj7dB1jOkuvQynDXKeZXW
 UwLWs38lOJZSv63+EQyfFknxVgFaRnUXHKANiRXCToe9XpoG61IAWc2631oZIP9vvyd5
 jq9zfQrQnGZLveYQQKurnKOpM3GrxRbfD9gvj3UbMFRGAHXCr5TReuJk8VeaAeO6+eoE
 H6xRGv9mslVm8aNES4A2oTYabMPXTBLXWLx+XThQ/4hXTXe/4R9JuO5RYYChJlIQDOqY
 pjLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1Hzt2UsLe2QsvCkydVeo8Qpvnif7ly7z2Lncvq7rllyf4p0OOaH73H992GACT/qLq1l1hlyM=@lists.denx.de
X-Gm-Message-State: AOJu0YwOzEdWmI8De1V2FZkCqtbpDSVRM7WcY9x52QFKu+eQA9gcHJmc
 kGnD6bLPYBahfX3VVx1fLMowIS6Xw7SYL736y3a6jxGCjHxizSMzlSfHgWSLbfhYjm+JCtzg/Kg
 oWBLI7cYy71sdJwCf0GXcWOQ6Sowdypc=
X-Gm-Gg: AZuq6aIFN2f+AAXiffeKwDhyC3J6UWFlipDCCWZprq50m4EcJX54iXxdlcHH2h4e320
 F8jr2lSs43QyO2ESfFIrIFskSanQ9Ra2KyZ9w1aypQIzDaiAnwzYgv76oQJiBcbMukbEA/ZnqRV
 jhoJiVoO0vaM523s5PSciORS3PfJSHicbke1/NGcLvsQ4ixiGcV3kWQngNrBHV6lz7OQ6OJRDTb
 XzgG6qTO36TBzXu89BifrIQREvZYXsloFERLU26lsUYKPVmCE45WdMT1hEoZmeMybQutcotHDJU
 OBd0nxnc7HOZ3P51Z0Mkw/QNeHg=
X-Received: by 2002:a05:6512:23a4:b0:59d:da10:4234 with SMTP id
 2adb3069b0e04-59e03fe1532mr2662984e87.0.1769626535237; Wed, 28 Jan 2026
 10:55:35 -0800 (PST)
MIME-Version: 1.0
References: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
In-Reply-To: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 28 Jan 2026 15:55:23 -0300
X-Gm-Features: AZwV_QhcOSteXvyuiV9VIanjM4m4QEiu30BnC6mNpH708uvO9HkX89GKwHGRicA
Message-ID: <CAOMZO5APUR+ahmad69iqpWQpD-u-m2MzoWu0g52kykBweKD3kw@mail.gmail.com>
Subject: Re: [PATCH 00/12] imx8m/8ulp/93-frdm: board cleanup
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>
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

Hi Peng,

On Wed, Jan 21, 2026 at 8:51=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

>  board/freescale/imx8mm_evk/imx8mm_evk.c   |  3 ---

Now that master changed from board/freescale/ to boad/nxp, this series
no longer applies.

Please rebase and resend, thanks.
