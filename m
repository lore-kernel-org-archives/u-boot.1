Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D51C47DA9
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 12:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F53C87C9B;
	Mon, 29 Jan 2024 13:03:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TI+mZ/kF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E00387C37; Mon, 29 Jan 2024 13:03:29 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFEEE87CFE
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 13:03:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5ff7ec8772dso27422307b3.0
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 04:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1706529805; x=1707134605;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iq2VF/LGK6hCW0sppxbtdQihaOFDWR/IAllkZGtvFWM=;
 b=TI+mZ/kFbGAoJpANXP7IDcL6BFAa6ofVOZyDg/gKJcTfj1p5W91+i1UanhjWbA1mdh
 oRJnuuBMdHso54oG7GJ1yd+ZFe7pZj/hEjNdADuMiWNiu/cOqQwCjAt8dBl1BsauvOiK
 tpxRT8lrquh1WqAXMV/DZ7F0lJvxrdVc11O9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706529805; x=1707134605;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iq2VF/LGK6hCW0sppxbtdQihaOFDWR/IAllkZGtvFWM=;
 b=ijA9uD4L2u7QmmlWk8vFYr1pq/lNUA1CNeiwjEjyHBTwGJDgLevdDLmi6CB2+cwn3j
 ULSqlg8PAYlwbT0B91TudoB4uWZzT/s/VcWBXM57ttiPCF2JcXtMMUeZXoQEnhVhcMN2
 XOdF2KZaD6GLettTaGBCFUIt1SSGzCl7N4T+d7hi/FdBNjdtkQXBLAFEJiYbwk3WgJiw
 CqxCnSiFONgD5aEHCEC4g8aV/Rxw6Rr4rHB9NYt7QUAjo+5EPQwo2UHPvANAuHDNvPEa
 CVNqItZ23nXo3uio4hAWPGkhQfYvd9AFd7j6P9BEU49Hnc5cWVVkNa1IX0dmA+VXhWvs
 zwVQ==
X-Gm-Message-State: AOJu0YxhpKzoGjzuy3CvkZJVPOlLFlpwtw/S6v3OgIDWG9I5ezQq4MkA
 rWIAchaPQbFyzvfZs+rEWMv39PWiVa6xy4gJXD1Lnz1oxTss4IhfQjBwS5G/n7FhffwOP6ZlalU
 9kTJn4leBj/8pcm21uZgESdk80m1AYWv/wpJroQ==
X-Google-Smtp-Source: AGHT+IHt4RSkR5p0IBABniSPGL/fLkLG67LIr2Y8qx84zJk654ajftg6fMUEUbBaWLi9CTJHBtxj+rRcZovm0gUuLqA=
X-Received: by 2002:a5b:406:0:b0:dc2:5140:8b4e with SMTP id
 m6-20020a5b0406000000b00dc251408b4emr2529912ybp.91.1706529805604; Mon, 29 Jan
 2024 04:03:25 -0800 (PST)
MIME-Version: 1.0
References: <20240128063746.1552081-1-tejas.arvind.bhumkar@amd.com>
In-Reply-To: <20240128063746.1552081-1-tejas.arvind.bhumkar@amd.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 29 Jan 2024 17:33:14 +0530
Message-ID: <CAMty3ZA0V6zgaa28Lje_O_TyEYT+ttMcOTZS8oiZbMmb0s+f2w@mail.gmail.com>
Subject: Re: [PATCH v2] spi: cadence_qspi: Address the comparison failure for
 0-8 bytes of data
To: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Cc: u-boot@lists.denx.de, n-francis@ti.com, d-gole@ti.com, 
 michal.simek@amd.com, venkatesh.abbarapu@amd.com, git@xilinx.com
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

On Sun, Jan 28, 2024 at 12:08=E2=80=AFPM Tejas Bhumkar
<tejas.arvind.bhumkar@amd.com> wrote:
>
> The current implementation encounters issues when testing data ranging
> from 0 to 8 bytes. This was confirmed through testing with both ISSI
> (IS25WX256) and Micron (MT35XU02G) Flash exclusively in SDR mode.
>
> Upon investigation, it was observed that utilizing the
> "SPI_NOR_OCTAL_READ" flag and attempting to read less than 8 bytes in
> STIG mode results in a read failure, leading to a compare test failure.
>
> To resolve this issue, the CMD_4BYTE_FAST_READ opcode is now utilized
> instead of CMD_4BYTE_OCTAL_READ, specifically in SDR mode.
>
> This is based on patch series:
> https://lore.kernel.org/all/cover.1701853668.git.tejas.arvind.bhumkar@amd=
.com/
>
> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> ---

Applied to u-boot-spi/master
