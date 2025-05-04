Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A07C369C2
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 02:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C6DA82836;
	Sun,  4 May 2025 04:31:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZDFyOfUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1BE482836; Sun,  4 May 2025 04:31:56 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF5638210D
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 04:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-54acc0cd458so3802752e87.0
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 19:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746325914; x=1746930714; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U8AByFjpQ50U1StUAYfiRHCIx/AtaxUn8ZFpssRMDBc=;
 b=ZDFyOfUZC6M9kufOXqxS8LC2XpCJxK6ft+x9jRgbuHLUDg+GOvplxOwHkhmNiPn1qy
 sDhNvhlQ8Kb31XrxwLKk1u6KTj0sQn+udnA63khWPgYlV1r8zPm+3MvPzZfRakHaviTo
 mPRB84adtZAP2TdLkWf7RMMmSYga8JAb4QnGjoPU69lIsOD882G9BITM99rIBZhY9Fjn
 nmXyMg0UC9jjfR2DtV/Nk4MT6yHrkvzLGcp3brZhBn8uMKs4cJzLQqw3EWjZ4biJofLq
 /ExKpOv8m4u6qlkg040BEgkgw5V7BPYoIVLUiW5x97BQPsREJXHDG7fVoS5j1YPkNjN6
 3eZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746325914; x=1746930714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U8AByFjpQ50U1StUAYfiRHCIx/AtaxUn8ZFpssRMDBc=;
 b=DE56qbBBQ6dBhLC5eGm6AhD8rn2w/4GKg9yLVsgIFAK0RlCr0jE4qwHe8DBFwBCPq0
 W+bzDpXk+USJw5I/MNvRNeUnqYC1xuIpnPDtAIgTg1brb0CwgI9KgzrNIgxTKgbOrveB
 u1/4OhLE0/TcNebMWYRNYw+AwMoRse9OV0atGaZgSQhimzarpJcBPsO+gE4S5sGD+ncT
 Va72Kvi+6bGfUDNf6Ysi2V3tqIr02l+SqTFJjwhL8SKE+Kuina3SLqXjQg0ClGg2HI2j
 vl69iAm0wEs1Uvm+0KJrgvmbM1b46x+wi3NG9VMaD3uhhwaJ+Ezj/2StR4ibE85qNgok
 l3nQ==
X-Gm-Message-State: AOJu0Yw/ktALAkvDkxwf2CFcmwhBWDqgSieZuBcPUfoNeNOHBEtwjF8L
 onh+XNs6jpWD+HB8HnbeaC/GP/E36bMKuZBL1tnx66PpyvJD0jKEHhaq9+T5D7s+paATq5A/IWq
 4YIOmBkgMNoSSX5LP4IetzTaegDY=
X-Gm-Gg: ASbGncuQg2ADtgTiUZBjF+0Z6s6Pr3aTpNf1rOn3fB472++KiZNk0zVYqJa144Jr8st
 0fWdXEOo7X1d+GpSXCKYiVFhoxPCiMuFhMXJMWuwIVcbOwgJ4xEwPJzKrY4BpX4CD760/thZ4jB
 oYkHKJo0lsdluCoHkWl0ESy7Lu9DTX1ZG+kIj11qBumQu/JjiQmLj7
X-Google-Smtp-Source: AGHT+IGx0gvTLEu6pyG+yOD8GCUUmkUr40PJpfQY0YjLUg7vway/J5e9W5YqRPWxasCFpfh03M5OamN+mUTlzVwMzJs=
X-Received: by 2002:a19:6b0d:0:b0:54e:86f3:5e5d with SMTP id
 2adb3069b0e04-54eb2427df7mr633078e87.7.1746325913990; Sat, 03 May 2025
 19:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250502105859.978427-1-aford173@gmail.com>
In-Reply-To: <20250502105859.978427-1-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 3 May 2025 23:31:42 -0300
X-Gm-Features: ATxdqUF2B2v8iWQr50CtUX8P5g2SYLjdhRRTvygCm_tT2SYM_VnFfJqOCWrv5B0
Message-ID: <CAOMZO5DTagYE3aE6vnXgXqtp731ZV3gnk6MpryCKFFooqLkn8g@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: imx: imx8mm-beacon: Enable BOOTAUX
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Fri, May 2, 2025 at 7:59=E2=80=AFAM Adam Ford <aford173@gmail.com> wrote=
:
>
> In order to run binaries targeting the Cortex-M4,
> BOOTAUX is required.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied all, thanks.
