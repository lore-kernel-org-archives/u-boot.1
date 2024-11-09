Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B5AD5E378
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 17:11:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFE93890C1;
	Sat,  9 Nov 2024 18:11:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZQoMoWAY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 590B789137; Sat,  9 Nov 2024 18:11:37 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA52B88C0F
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 18:11:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2fb443746b8so23474971fa.0
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 09:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731172294; x=1731777094; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q6zXSQWTLLKoaXk9fIdcjR1OwE24rEXWJEJH8P/Cc/M=;
 b=ZQoMoWAYTRvMt0AE9pO/v4Jx4dSt9AkECntdGJI3giT79Vef0k+oCsjc6WeF9RWHqX
 qdbuI7LGukgAk2JCjoyQr84LRBqixJdVgwLmQ1QoDZ9whWA0HdJM6oNZ5UKQQNJe+s35
 +0B/aoF6psI842WmCOVLR+HD2NxQCXSGckJBWBT1zWg21a09iGqm1FwY06nCarkxwEL5
 lmmUUz8qVYNiEzJSKuoU5WLIyjYCdozTzHp7AgUGvKlVFniRKy3gYQCt6TJ5HBvbl9Cd
 aTu4jRIRld4gmvYgCqnEV9MIIG8F9aksxBoMj7c8cf82aAIuDIBf/DRmx0N5dQ4Sy/JW
 AdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731172294; x=1731777094;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q6zXSQWTLLKoaXk9fIdcjR1OwE24rEXWJEJH8P/Cc/M=;
 b=VYmcW2EM5SzswW31YE6Z24PezUVoyimsES6ghH+X9jHHMY1TccZ8lsyT+gfX0uKopd
 rCqiRXrqmTpyKfBuGIbWi0c+tx+2tXz7MLdHote1thhIvxoZPpUnEgyjZOmGXOyhIzc7
 tRy/RjiNvLxRroNQWudREi+qY78ANYHw5byeNXSvV9gquKCh7mVuu94y1CcOWHc7d11L
 lX8Q4oE+WDeEG9lbc3ZpLdEeMBE/fQOn/uXFcXNgZHuk97nOLptNUMafCGMhSzQKrLcs
 ny1VA+Nve1ZO9xKemXBHXjrFoECxolEdqlVLlkJIyFevaevwopGG1rsGLJ9IfQQRtGy5
 CKfA==
X-Gm-Message-State: AOJu0YyoqSWqYxD28qPQ6mk8w2uq4vCiqGsdBrx5naZX50XHO/lfyVQJ
 9xTRLqpNg/NKFbxOL5rBQ8HdDv8g5yDPX5RY66UPKzMmu6bm8BzWy+hSbKq9hmvF9igGA6KN1Zj
 DXBxvwZ/4lt5ZApxVHUoToKlRCvY=
X-Google-Smtp-Source: AGHT+IEFpXT+qa7ZQbTQGfym55yrmSAJHw/dTQ8jw0Fl8cdVvSHk7f85WwwcaAKL4etN0JDHe09EdAQvVw2o1ypj+n8=
X-Received: by 2002:a05:651c:158f:b0:2fb:3d86:d932 with SMTP id
 38308e7fff4ca-2ff2021b921mr38073291fa.12.1731172293825; Sat, 09 Nov 2024
 09:11:33 -0800 (PST)
MIME-Version: 1.0
References: <20241105230724.159755-1-marex@denx.de>
In-Reply-To: <20241105230724.159755-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 9 Nov 2024 14:11:22 -0300
Message-ID: <CAOMZO5D958UF9ZF3PY49KXCE=ijAykmxUhkHKJj-212-T0kUeA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx6dl: Add support for i.MX6DL DHCOM SoM
 on PDK2 carrier board
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Shawn Guo <shawnguo@kernel.org>, 
 Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Fabio Estevam <festevam@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
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

On Tue, Nov 5, 2024 at 8:08=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Add support for the DH electronics i.MX6DL DHCOM SoM and a PDK2 evaluatio=
n
> board. The evaluation board features three serial ports, USB OTG, USB hos=
t
> with an USB hub, Fast or Gigabit ethernet, eMMC, uSD, SD, analog audio,
> PCIe and HDMI video output.
>
> All of the aforementioned features except for mSATA are supported, mSATA
> is not available on i.MX6DL and is only available on DHCOM populated with
> i.MX6Q SoC which is already supported upstream.
>
> Backport from linux-next commit
> c3f5d76a6e03 ("ARM: dts: imx6dl: Add support for i.MX6DL DHCOM SoM on PDK=
2 carrier board")
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Reviewed-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>

Applied both, thanks.
