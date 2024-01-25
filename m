Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375C3C47422
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 20:14:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ED6B87527;
	Thu, 25 Jan 2024 21:14:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lhb2tm2l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 949B5876FA; Thu, 25 Jan 2024 21:14:44 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A9F687447
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 21:14:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-55b5a37acb6so1096769a12.0
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 12:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706213681; x=1706818481; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b+IF75aPo+dmG7bqBEQutw2aeLoMt4rZWQZt3z+Spp4=;
 b=Lhb2tm2lNGF7NW/nA/6Azaqs6R9e/9Tp850G4nqOxC2Iz+7uGOecwQ2HGiV9g1GmSm
 ocMy7nt1kyNiDDZjlo3X7U/7+t0vvgdpsAgMqZPuuDE7GeThK/SyHkBF1U/Fk+mPFaJ7
 9WKx4OhYUG561n2zf7viSj1IY0o+PpEBKnOrUsDKDw8pcWU4mDHliWfFDpo0ygRzTIM2
 koxgU9wYCYbT83DfnIsoOEQQ3sgVAWMmvLGSkon/Pn5jSQIHuiby6iJvuUfjf2M3f3yp
 mxikvfsViZebRStFg0nVCmPbNkRAl6dZD1balW6wSQhYKwyKDdaGv+uHUlyCNKmKBKgH
 yrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706213681; x=1706818481;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b+IF75aPo+dmG7bqBEQutw2aeLoMt4rZWQZt3z+Spp4=;
 b=p3GVrs5BdLWtSkB+rJ/FPfWmV5ozYZKml2OcAj5wcbEs41Tz6XTxJ/KGNJ2b18bEyx
 8AUGHzR+sWsLyEoGjlcE7BCSc86yAGmH/6MkxOE1/JbNFX5ZHVPUob5zYDYDOR1S0sf1
 0A5O9FDv/Q1x88p7Y7/vccO9BadJYJqwk0E5/JPnb07UPWXshDXD9VSqKtA6UqHu+8KZ
 8iGKKENojISYnvfWQLMxPt1kqytGBpRACjBSlgWzFfrMmDjllbZTX8dnERZ/0hbwV60W
 VaJXpzpNakBEb+YI2Jqk6wvXZEyg7/sfO/QEjc9UqGcBZmUad1BnzVWEDCv3ph7nj3ZP
 Ph4w==
X-Gm-Message-State: AOJu0YzA7MkExgfKoOTvM1AGg/0JHBxpwfLvJK2AOqpo2tFTBBgtPhOh
 H3wzzu9NDqatQ54SxkP5nYAdA0hudkQH5syyNVPVeGKcd2SXXUzi2uXYFya10H1P6mmpgAlI5Yf
 U3VPnz56/sf5/hTVi8kZjR0N23HqMP1NV
X-Google-Smtp-Source: AGHT+IGhnvugJbMm5rvHRnW7tX5sObAnBTrOmYFSGZrUab8ajVqW96kbrhtIvUBvVEEsXcmjAnvXLr2qTsqpYacZv20=
X-Received: by 2002:aa7:9f51:0:b0:6dd:86b1:7d93 with SMTP id
 h17-20020aa79f51000000b006dd86b17d93mr555081pfr.0.1706213680740; Thu, 25 Jan
 2024 12:14:40 -0800 (PST)
MIME-Version: 1.0
References: <20240122200930.673447-1-jpaulo.silvagoncalves@gmail.com>
 <20240125110214.GA12545@francesco-nb>
In-Reply-To: <20240125110214.GA12545@francesco-nb>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 25 Jan 2024 17:14:29 -0300
Message-ID: <CAOMZO5BgSdBb66RyEK9mbfKO5s6Sn7ZwG-=73AB14XguWt1Qyg@mail.gmail.com>
Subject: Re: [PATCH] toradex: tdx-cfg-block: Add new apalis and colibri pid
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, u-boot@lists.denx.de
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

On Thu, Jan 25, 2024 at 8:02=E2=80=AFAM Francesco Dolcini <francesco@dolcin=
i.it> wrote:

> there is some trailing space here at the end of the line.
>
> Fabio, can you fix this up before applying?

Sure, but next time just run checkpatch :-)
