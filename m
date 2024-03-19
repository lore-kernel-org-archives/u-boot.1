Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711B3C54E58
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 00:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AC9D8803A;
	Tue, 19 Mar 2024 01:15:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B9paHJrH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B91028718A; Tue, 19 Mar 2024 01:15:09 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 445FC88010
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 01:15:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e6ca65edc9so1641933b3a.0
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 17:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710807306; x=1711412106; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aEglWZczOxAVk65M74blTG/LkHusdIwQaecWgFVBEb8=;
 b=B9paHJrHY/CxpjIdPUAy642CitTrsZ+uxWWBKeh5qjkcXCstQJ0ewWdOsexis8RJhL
 /t/uFmQLxn9Bb8MXpAbneLC8BayJ2vgNKxoQdHahgb4orfkkCx6NiTEHrw+re2t/12EG
 xSCJsw4Q3oTEtJQm5fjH/RkoG61UAJhKMsT0RMDvZt2bonVPSQ+u433A8s7J/TOEYD4D
 LhJYzUGNJs+08Qaerj9ojyaHWD+48I4GH1k2qqGSnimLIOg6gF/lWI/flP2oRyHzxRkr
 JspeIje8ezAEtusf4A+pWDVIjucg8Up4/caWmV7eJ9o6vCZSdNF+fW64m6IXZ8Y0Ma1M
 UlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710807306; x=1711412106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aEglWZczOxAVk65M74blTG/LkHusdIwQaecWgFVBEb8=;
 b=Td7AInHra4AM5d8jVj6euT5YhPkYHDrcpu2Qk0e1JQrrHUKgUi3lHiIJkkZDxh3rCJ
 ZPUHm5s7sIXlfF50cHDyl25gJoB8u3ghPvUQaCuCwMwYfQww8QS5od+I3jq9eZgYwpcq
 ivoDBRm4n+sl4+ESEBsN/cAoYCDA6Mz5hJQkS6u3VQuFd+dgkBDgvhHkrOe6QBkrCvkg
 n9YJe5rlF3RyvNIZSQ+vcHzcPwTxENxsn2hrKircLenYNOnQnNGN/50EDZIs6pzzRN3s
 vGmCzq4iz2R0zDGHB9Av05pBPoXKPTYNrIkCy3g8KlLEyHvfUmEi+w69gO3+qpSYE4Jk
 g2pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqLKKkfVgi//PyGPjwxIP9KkSM2Vd7P/B28PBSWqkK2PXWS0qRgin7mC0ioH9HBhTjW5CWP8jQo8SxSD7J3SnewDn3yw==
X-Gm-Message-State: AOJu0Ywl6AE02PSrEW052/SrufUi+iDURdsZzYGhCIKRmlSy8RnFtitz
 voRLtej70CIYENqFFY8h61u9vVp5AV4zhMvkhhRLrJBjE8WQz11JeyqLe81w9w/G9hT25WGP5fd
 F9MmMpwtLgS1TJHMBdOXGAZjW1io=
X-Google-Smtp-Source: AGHT+IF8bWRr/86RIQLaG6LSmRnGQwcX1Wgg1oit22wV4h6qDRhVnhiOBJL6fopWmclEH80QSjxLmlDMtAhc7JgsqtE=
X-Received: by 2002:a05:6a21:78a7:b0:1a1:4de6:dd5c with SMTP id
 bf39-20020a056a2178a700b001a14de6dd5cmr973469pzc.2.1710807305754; Mon, 18 Mar
 2024 17:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240308201316.1721909-1-festevam@gmail.com>
In-Reply-To: <20240308201316.1721909-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 18 Mar 2024 21:14:53 -0300
Message-ID: <CAOMZO5Aa_EaTtL9r7k0P7CaJQ0fixGLJSR3WvxHAD2=5RJdncQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: clk-imx8qxp: Add LPUART IPG entries
To: seanga2@gmail.com, trini@konsulko.com
Cc: peng.fan@nxp.com, ye.li@nxp.com, u-boot@lists.denx.de, 
 marcel.ziswiler@toradex.com, francesco.dolcini@toradex.com, 
 hiago.franco@toradex.com, joao.goncalves@toradex.com
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

Hi Tom and Sean,

On Fri, Mar 8, 2024 at 5:13=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> Since commit cc7df0b9e8bc ("serial: lpuart: Enable IPG clock")
> the colibri-imx8qxp board no longer boots.
>
> The reason is that the imx8qxp clock driver does not handle the
> LPUART IPG clocks inside get_rate(), set_rate() and enable() functions.
>
> Fix the boot regression by adding the LPUART IPG entries.
>
> Fixes: cc7df0b9e8bc ("serial: lpuart: Enable IPG clock")
> Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Please consider applying this series to 2024.04.

It fixes a boot regression on imx8qxp and imx8qm.

Thanks!
