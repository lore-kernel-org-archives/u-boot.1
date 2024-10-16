Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB92D2A53E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 18:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CCE688D8D;
	Wed, 16 Oct 2024 20:49:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aABSznaV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A4E688DE5; Wed, 16 Oct 2024 20:49:45 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DD0D88CAE
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 20:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2fb3c3d5513so1887021fa.1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 11:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729104582; x=1729709382; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e0i9xMJTiwIw+pAwXfj6fzwEbOcmWBFS8u/rASVFpD0=;
 b=aABSznaVjYE2czHjj4XJVlsiQiOu8dLpNwl6OXbmT06lno5s23XjLn2cM7/FsxaUCN
 5jxaVy/gca5uGnZwu83lYNtUJHxhtsO0PcTUSl1OGY5Y4S8CJYOEkOFRui7hZgonV6/E
 ufgtv95SSzApRarzHnDPRy96OzKwZyRxPEneGljZy9UvwtIvHGEeXdbkGZ8eFyOl1kRn
 Fm2Bhz5kOtZitnOGmFA44UkbriOPIurG/JKC3kBuD001pac8P0fFlwq1TTR3ks7eSonc
 DxXnwwp9KreJqMlhweJLNiIzMw7LUvJF+6OjyQWsnd9YJrDSmHRrJldI1jZdC8pLz8Im
 xDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729104582; x=1729709382;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e0i9xMJTiwIw+pAwXfj6fzwEbOcmWBFS8u/rASVFpD0=;
 b=rKii+9d6cKMz9XkU3ecws9Q4zRmcCCSFIO3jdZsp7qEXhKjaspd3WSkqyja9KHS8bu
 Gv25vBSB8v5Z9UcQkgH7pAnFMZH62jI4l9aV0sDKVUqLqHWr3IF4pI8NIU4wu+uAj7i7
 S/qciMYj7L07Y+wpQ3kOBrRLNSOpXivMVUaRY+TSe8Bx26IyfyDOcdaIXn17AXv1eg+G
 j5AEjTPWibaUtca1Yyl5AFgVWaW4/1V9Db4x31hdhwQ5ZuTLbFu1HUo3MtEbDrHTsEGf
 YDFVrg4z4qkzf8UbetmlitfJn5t7PZv6YbteWhoEdhOTNgVePwDsMfNUGuZRae0oSES6
 P+IQ==
X-Gm-Message-State: AOJu0YwXB+yA7r+0Y91AavBuQlB3qv4405RDBOu6G9fahTmOs6Z3N33p
 Rhm3N2KDshl9UCaPY3cA15XYAnVSlA6o2FmyQWxYDZy2X2dzaYU8NE3nW/S93iBmVgMNGzjRVL1
 wIEIjyM2iuhMcZiuiLKyAop22tR8=
X-Google-Smtp-Source: AGHT+IFzUD/lAmKQx69pu/L+1REY9dxFEcH6L0H2TUpUlMFTgyVp5z36vTID2ziKoiR3FUsUfgTNnEt4H+aEEXOhInQ=
X-Received: by 2002:a2e:809:0:b0:2f8:c0bd:d65f with SMTP id
 38308e7fff4ca-2fb32740b7fmr70381951fa.20.1729104582045; Wed, 16 Oct 2024
 11:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20241015234502.129086-1-marex@denx.de>
In-Reply-To: <20241015234502.129086-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 16 Oct 2024 15:49:30 -0300
Message-ID: <CAOMZO5Bhu5OHYJuTdggeaaR=_-cjWguqN-3oapTLj2OgC9m1Wg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6-dhcom: Remove fdt_high and initrd_high env
 variables
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Andreas Geisreiter <ageisreiter@dh-electronics.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
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

On Tue, Oct 15, 2024 at 8:45=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Remove both "fdt_high" and "initrd_high" environment variables
> in favor of "bootm_size" to safely contain a kernel, device tree
> and initrd for relocation inside of 256 MiB region of DRAM.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
