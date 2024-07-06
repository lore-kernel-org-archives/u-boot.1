Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAD3C38150
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 20:48:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F0AA88373;
	Sat,  6 Jul 2024 22:48:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bAyEVdzi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CF6788403; Sat,  6 Jul 2024 22:48:51 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73DB5881AD
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 22:48:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52e9901f858so298377e87.1
 for <u-boot@lists.denx.de>; Sat, 06 Jul 2024 13:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720298929; x=1720903729; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UDHc+jvVYC0pQCHJ6+3CXG5ZouMeyMn/cMt6doLaY54=;
 b=bAyEVdzi/lCCczLPewBsz4PGmYLNlMf6giKqoIOFu5/ynKAlgnGgwML7hQO3yIBl5l
 eqGmtoY/Nt4+d/HHJdnzzrc/f9HXopRU8zdnwNbxm+XIuupvspTkdKNJnJN0liUjvL/0
 HlXOWG+ouT2D3hHP9j1ljPntxq6gjik0O4zx7oJWUOpkezf3DRy96SIkyU8v9ea/fhcf
 du+C8wY6nCUlU+aV9Is1H6Z2uJRddzINZ/2hCzmZyVXn1zB5geIUS1wn0exz3SygbgR2
 gusEEt9ppPNE6TlW7VEH18JDw85UOlvYJR/10v5VDsYpbkRnA/gjvRrJaMGQWsl5J6qt
 Tdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720298929; x=1720903729;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UDHc+jvVYC0pQCHJ6+3CXG5ZouMeyMn/cMt6doLaY54=;
 b=b3n4u5rOh2AMjRvUYiCsu4552HD/llsXooOluhnRgX1jeN+GxW03gHngGmEJ+wwBfP
 Sdmm9VaUKEiSm+L+FUqdUSZ/48jrIsWc5KQsf009TnXYl3avipIb5iC/fqR7NYi5jvvf
 76ZVu/djtJDOtiFiXuFwtCht+BIFJAjlkz2NSTs4qoloPXTgFSGAsJkV3DokWxoy2s2m
 LcN4XfdsdINFWO5SpwGVuvdcGNzxtsKT7gIJD1Kz1cDOU/KY2ImqquJjfY0KCn8vbSuy
 4Bpl+Hgx880ZVRIgb/3tR3fIdkHO0cZBJMqOwoZ2RACXBfpz0JRpJrXQLDDnp+Tm7BNe
 NECQ==
X-Gm-Message-State: AOJu0YwBlqNszokkAnKEJOEZo6QlLA8cLndrtRjbvwFn9jBGQ3DLynyt
 aN1sWDYk7fsKiUIwzqRIX6Unt4D/rJa2NI1LcUug0w2xrAHhPr6v5gliDAQR46pLzURUb+GFqbt
 Bk1QMHgWW0hjBFhWQlY6dOdPuhYhlkQ==
X-Google-Smtp-Source: AGHT+IGLGIXVvAPUykMDK0rRaal2KvCgJFvgDawDiFJ+4/sLbTI3hFBCbNBBEyzz1vWiIpmyYG/OaTuTFZzsATcMXr8=
X-Received: by 2002:ac2:5051:0:b0:52c:dd58:1a97 with SMTP id
 2adb3069b0e04-52ea0762b99mr5566294e87.5.1720298928475; Sat, 06 Jul 2024
 13:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240625082638.8867-1-marex@denx.de>
In-Reply-To: <20240625082638.8867-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 6 Jul 2024 17:48:36 -0300
Message-ID: <CAOMZO5DY0ohwDJiDxput6wwvVc7DSmuJrxngcJXFD7jnhrRoBw@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: imx: verdin-imx8mm: Set CAN oscillator frequency
 based on model
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, Stefano Babic <sbabic@denx.de>
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

On Tue, Jun 25, 2024 at 5:26=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> The older i.MX8M Mini Verdin SoMs may came with 20 MHz SPI CAN controller
> oscillator, the newer SoMs always use 40 MHz oscillator. Handle both by
> overriding the oscillator frequency just before booting the kernel.
>
> These are the known variants with 20 MHz oscillator:
> - 0055, V1.1A, V1.1B, V1.1C and V1.1D, use a 20MHz oscillator
> - 0059, V1.1A and V1.1B, use a 20MHz oscillator
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.
