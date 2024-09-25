Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC53C369D3
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 11:42:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 543D288B63;
	Wed, 25 Sep 2024 13:42:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ExryEwhl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F381D88AC2; Wed, 25 Sep 2024 13:42:38 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE3F588BBF
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 13:42:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2f75aaaade6so70766411fa.1
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 04:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727264547; x=1727869347; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=14tMK7J/5OJ5dq0DEQ/xNdRTktR3HwTC6N3t5zefw5w=;
 b=ExryEwhlofqCNIbqRrTSz9zz1d65P3Jzu+r3vzFIYy7ryV73qSGnkY55ZQa+A7Avyq
 PeJT9EtVe0cdxZP1tog/SafizPUgTdd1DiWu212wuL9h9wWfsKWNvueAZ1CQoIlaPw6+
 //NInNANScyU+mysSe8g2QTiHSvF26KAsbUAonjFGO/inmjGwSidvLDUiX5DOdbrUKnF
 XFVm8DO9H8Em+3ch2sTtPpbsqMGzQCtiX8q9QLNHWVEUCBSM0hoLXK+bLekicitvQySw
 cphsD/wE0RFQp+UaCbp/7lPmp7GbEbAb6E9zjAp39D5hS38MIpCGwyfCrok//LRMa9Hg
 YPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727264547; x=1727869347;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=14tMK7J/5OJ5dq0DEQ/xNdRTktR3HwTC6N3t5zefw5w=;
 b=D7E40xA9bO9/mH5kDtueT22wtIA6HA3w7KM4hWtExj4PiXtbAC6znJv15PZKupbFQQ
 ubrQksP4B6T2vWb1nfEqlza6Eq2AEPouLN2jRnPg0UWjld663XCZ+i/SFZMwNa1Vjjzx
 qtIPWu6WKXWkhpxpSTMYkC+GAWmcWjyvbBpKQcgL5U2ykMP7Z3cwSLug+KkBvxk91NfW
 BKT6NHz+atk2Wj9zlGELPn44jakfwnvpY0f2FlZWQyoVtfi9FLFBDHDPBFeiPY4tuUbx
 IgwDSzHLG5HEbxKXUascwV4gZitZfds8teEKqlGndN7Zar6Xxf+UcGYViX0y0SsCyfZa
 EK1g==
X-Gm-Message-State: AOJu0YxP/6mhUWvuFxMQFhtcm0pWCAs1oBSKSP56N1lOk492pMPnuwhY
 8j3SeDJCxQDgOZSbx3YlfmUzkfijsShbhqmONLruuyfyXmkKBItJM2yYLcqRzrxf/oCTxUj529Q
 I1nom1I/CmtmA/xrgLc3LvmtngiM=
X-Google-Smtp-Source: AGHT+IFnnEAQusYLsKNuvyyAU0SUrAjAKrHNx4qIqqPlr5aK8geInZUTy2d/SPhMxDX/SjdDGGGy3YQiQHku6fwasWE=
X-Received: by 2002:a2e:a987:0:b0:2f3:b078:84bc with SMTP id
 38308e7fff4ca-2f915fc17d4mr18050211fa.4.1727264546782; Wed, 25 Sep 2024
 04:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240924130218.308845-1-marex@denx.de>
In-Reply-To: <20240924130218.308845-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 25 Sep 2024 08:42:14 -0300
Message-ID: <CAOMZO5CBgbU4ft4v85yJ7E3G5MHvJ=Xi4Gg9gTqPMzYmjPCVCg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8m: Always name the generated fitImage
 u-boot.itb
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Peng Fan <peng.fan@nxp.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefano Babic <sbabic@denx.de>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
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

On Tue, Sep 24, 2024 at 10:02=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> Maintain backward compatibility with pre-binman u-boot file naming,
> the U-Boot fitImage used to be named u-boot.itb before, restore the
> file name after binman conversion.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied to u-boot-imx/next, thanks.
