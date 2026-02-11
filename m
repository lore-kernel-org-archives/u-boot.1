Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC01DE9E319
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 14:45:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6018E83A47;
	Wed, 11 Feb 2026 15:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L+OC4OyL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C777783A47; Wed, 11 Feb 2026 15:45:11 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97BE183015
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 15:45:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-7946a1f2430so49978527b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 06:45:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770821108; cv=none;
 d=google.com; s=arc-20240605;
 b=QYQWpdQ0iBE8iPosNM9Sf3wkAxSGENy/LOTlsZ7SGIDRMWZLbRiMp5v5mU7aE6JkJ0
 or5+FEUEyjZFN6h9Q9tfmVBwRSIM4rxdeltv4QSGH5tID4vQ0M6YHhzjihcMpmpOZjQ1
 isxZjc4WgBvFTozQQaw/KsOA2N5am75na7+HEkiYJ9cg3jPKzQOTBP7IcMnxOwOou8FM
 D+bshVr0RD/L6giO1Uya7Wulejp5HQ7tZOyH3MUCXPlrVXGed+4DdckoohkQormuJ8HG
 W8rx+BBZSpv8flSrfINORN/6XfXnz1vMpcf1nOIoKwAoqZCQKGGgZESutWWZIiWOYgu8
 pwVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DmfBS1TH6pt8HC9ibtNEcEklgQas5OkTbVTVipCGKyA=;
 fh=Bi45BNOIaTlC2fxBbuvVx15YbEA4BS6w/USvLa70Wic=;
 b=S2bY+e+vwa8jJE6uW9ybg0me1ZYjujqXYQ3fhYVvx1KjM6atoc1WDtHOwr/IPAC9l3
 IF62AIBoNQbZJQ+o8dypny1/+9O2dEDNwozgrKW0Nyk7K6qIeN4qH0+9NDmu1bFT11WJ
 FZ6VOCrn+Kr/71DLAZdpsK85qDee9VGfIxgtafxwYSFRYro4F4iNOo042SzzSXfo/mZg
 U1eR2PdNu+UudgSNSAuKJYiKl/BTDvWQHXgpyB7mqs0168iw3mKAs9HItn1OFaNn6Ny9
 PwnSjojRLequQiEj712WtL5Zrc0r/AjdG/p0SAABfao4TWQWgyuNSM6s6xA7OpS2aXFa
 6weA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770821108; x=1771425908; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DmfBS1TH6pt8HC9ibtNEcEklgQas5OkTbVTVipCGKyA=;
 b=L+OC4OyLBaHau/ATLikS8XQnujY/sNioC9YXV1FJ+cCmOQcSDl/L9hOPCs6LPDOH3F
 mKJEIsjuffHLyxj8cmFXrJO/Rbuyrmn0DqfO+M4gbSdUL2b/B60zjExx8U7nAE0ZjKPN
 0ZVBWrvgIHlvcwWlgRes8/XNCaytSo+0jSIfDHgrgHvDnjgo1g/rLm30whrs1q6x93/J
 Gwy8nZU2WFLNHx+LvmscQqbJksQDDbqbQw0AU6tURH59tDpDV+qPIzyGSqrg76pPA7QS
 fXbKWN77nNqgyXTEphnNsLrTmXkWGdM1WQd8kpYuNJFn/YRiaz0/RYLlY34IFxnXvC4f
 Z+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770821108; x=1771425908;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DmfBS1TH6pt8HC9ibtNEcEklgQas5OkTbVTVipCGKyA=;
 b=Yin2sr/H6g1tTXs0zSFXYtSPAovvnw3tbL4T6DsU2PVZ/bpEgYt07x+uy/8dSlEum4
 BDO1i7iZRW70cVnzS3Jhp+XpFwI7aClDMFkrhHIGXa5mqtHJItzSDnVMevGRD2YmvArV
 ke9ay7JlYl+p6PAsgVmcb1fvkIgsiEpN1+Fno+E0Ii3BJxtv0tfBNuyNp9w2mE5FUIUm
 ahu7GPWqG4V2jhW2SbWN+9Q0qMRVEU4K7uWpxHiR2vgChKT41+/kUYFQF2AnTmpQc3wN
 WgdYCFMSJqkLQUv/LD7Q0duSIcLnA6V9zyCT6ydUJq4bORjgeSzCUkk6QHP1gkaSOX2O
 01yg==
X-Gm-Message-State: AOJu0YyPruhdtWJ2Bxym6XGA/+mlPSI73M+wf5P+HFuNsS7Rrg5ZzCwH
 frKZBFEDs4wveLOKHQ9MbD1KyIYEiYrwIYd0tBP8+R8Hr7su1ddSNADdhSbIIf392To6WwuMmUc
 3JXpxXLg9g+UyXAaiaOlon3ULFWIYDts/a5A1dvomZA==
X-Gm-Gg: AZuq6aLf3FPHvHdg+7+6oV5SsJtqltudgJ4qIMNx1nFczuNNULq0s25q9ycH6BG+SI7
 iaHV9mvq4BdzUVzrXE3AwDoLjFOy/p/kOflur8WrQZTNrb/F6KcNkTekcoJjMRldskHBJwwdTkp
 BviqRliQ1XLd00rCkuMQ298w7yjjU42tOqU+rsp6C79nkdZr4wOzePy672z/sGk6CgfBvL1CYtT
 DzyOJKKUH8KMr/Iqy/OV95Ae0PQKf5QqYYO3QGm7VO8VocbX/AY3JThSoBY8YY8gw40i4TDsQJm
 d3gWianB/CGyLAvA97pg2HBAMrqflD8XzRBhA85PQ+OMM1/nsv2a0k2mrxHjEcRg6FWAfz6Yboo
 qp5r0479jb8lnOfX7loQZo/+j7Kj2xrHJS7OIogkIjZ5OzT/5MwVL1bj+tWUTg8r6QamPXzJLcw
 42xcMbO0S2Tv99vLpfAEwg1S7cna41lvHX32DaPcGc/r8OWX1nmDdimsG6H2ubt/uHpfzCE5cO5
 PkVLdf3DYTKDvmMYVsrcyWq2yz4HDB4+dbf0wr6nq0vEs3xxRWP6Oc64WCLP3r0ORZdP5CkFobd
 eiXpATaeFfdZRrr3Zk19FIo3Oe2CAdlLtTvVcV87ciG+
X-Received: by 2002:a05:690c:f82:b0:794:ff22:4fb1 with SMTP id
 00721157ae682-7966a9628eamr24924497b3.8.1770821108029; Wed, 11 Feb 2026
 06:45:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1770119483.git.michal.simek@amd.com>
 <eb7bfafc0b4a44375833b935bafa4df2550e9c3e.1770119483.git.michal.simek@amd.com>
 <CAC_iWjKtexQULYwA8LUzwB1-06qkAHo1LVgRq4=He5Sse34Rnw@mail.gmail.com>
In-Reply-To: <CAC_iWjKtexQULYwA8LUzwB1-06qkAHo1LVgRq4=He5Sse34Rnw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Feb 2026 16:44:30 +0200
X-Gm-Features: AZwV_QidrTaglmVKp-Px0Bzr6w0mvsvUcM-hP_cmwrgW_-z7tQ4-IecmI4maiSU
Message-ID: <CAC_iWj+-jMQ8MAYL5Q4Rn=5BFL-O4y4V4JVnCCnk6OPuYeEsLQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] efi_vars: Implement SPI Flash store
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, Shantur Rathore <i@shantur.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonathan Humphreys <j-humphreys@ti.com>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

Apologies I just noticed a few things

[...]

> >
> > +config EFI_VARIABLE_SF_STORE
> > +       bool "Store non-volatile UEFI variables in SPI Flash"
> > +       depends on SPI_FLASH
> > +       help
> > +         Select this option if you want non-volatile UEFI variables to be
> > +         stored in SPI Flash.
> > +
> > +         Define CONFIG_EFI_VARIABLE_SF_OFFSET as offset in SPI Flash to use as
> > +         the storage for variables. CONFIG_EFI_VAR_BUF_SIZE defines the space
> > +         needed.
> > +
> > +         Note that SPI Flash devices have a limited number of program/erase
> > +         cycles. Frequent updates to UEFI variables may cause excessive wear
> > +         and can permanently damage the flash device, particularly on SPI NAND
> > +         or low-end SPI NOR parts without wear leveling. This option should be
> > +         used with care on such systems, and is not recommended for platforms
> > +         where UEFI variables are updated frequently.
> > +
> >  config EFI_MM_COMM_TEE
> >         bool "UEFI variables storage service via the trusted world"
> >         depends on OPTEE
> > @@ -152,7 +170,7 @@ endchoice
> >
> >  config EFI_RT_VOLATILE_STORE
> >         bool "Allow variable runtime services in volatile storage (e.g RAM)"
> > -       depends on EFI_VARIABLE_FILE_STORE
> > +       depends on EFI_VARIABLE_FILE_STORE || EFI_VARIABLE_SF_STORE
> >         help
> >           When EFI variables are stored on file we don't allow SetVariableRT,
> >           since the OS doesn't know how to write that file. At the same time
> > @@ -193,6 +211,20 @@ config FFA_SHARED_MM_BUF_ADDR
> >           the MM SP in secure world.
> >           It is assumed that the MM SP knows the address of the shared MM communication buffer.
> >
> > +config EFI_VARIABLE_SF_OFFSET
> > +       hex "EFI variables in SPI flash offset"
> > +       depends on EFI_VARIABLE_SF_STORE
> > +       help
> > +         Offset from the start of the SPI Flash where EFI variables will be stored.
> > +         This should be aligned to the sector size of SPI Flash.
> > +
> > +config EFI_VARIABLE_SF_DEVICE_INDEX
> > +       int "Device Index for target SPI Flash"

Dont we need a depend here as well?

[...]

Thanks
/Ilias
