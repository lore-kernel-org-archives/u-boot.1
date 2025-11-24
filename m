Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1609CFA466
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 09:54:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3075083D3C;
	Mon, 24 Nov 2025 10:54:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="reblDM9Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C195B83D3D; Mon, 24 Nov 2025 10:54:47 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A763283BEF
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 10:54:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-787c9f90eccso41234547b3.3
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 01:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763978084; x=1764582884; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3Rhn0t+kvN5xY2OMzyc73+aTmT4Q5NpX6oc5Ms4oKVg=;
 b=reblDM9ZsP8NgDw9ZtHA9tG/GnhPescc1mNs28ENcwwmBdUMDOKbxCY9p3pPItqTXq
 SfgWENtMwtU5XjdbMKX5Wa5uSV/54bFdB9ZgvbtMogH/hoGE55fw3J6MMQMOPmEyI3cs
 nNarxkKv6kQ1p1wSD3RXkeyYxkJ6KaiAl9p5pnTh5S0WcO0t+LQrBcVac/NKuIlaRBsQ
 xd1ugAr1X4Y8hupdRbPH5FjPXGQQlBASPNE+YA2/ahaYZU4rO8MV0fvgRt9P0ZGzGrdJ
 K/XQXum73TWU8LCofUSuO0QDKrvt+Nv+qPmEFJyfBsIwVuhDntbLjcfkwy5Rux1SZrdI
 5bmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763978084; x=1764582884;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Rhn0t+kvN5xY2OMzyc73+aTmT4Q5NpX6oc5Ms4oKVg=;
 b=Adm/Cmd6E0YJ2fHSpHm519y7Oe9uihiDOEk+D/JQF71IJH8zkUzCuHQpSRxoNPsqZH
 73bn8O7ZpVCFkMf2IUxqEX1XJz8507sOOgtKdwB/KwL0m4IYk76H8sGVraDUkSbBhPzC
 3V9qeFtjFtXyhKv4xJk4FBFgo5fpjzx1Cz1Wz3xW+YQRj9+FoN4xHAkPGf2sxTXx8Rs7
 stxUURnRnkTDgUXn2zGN3vDOuluT5sDddCWHcDoMEBhWSy12QkN5Z75g4ZsDI6JiBkK5
 X+K0GjkpXoiX9sRjDOpUvhz0IpnHqPsMfhs+V5Nuzq1wgvnhYjAeSTX9UBBOUddLPddB
 3Kpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVJT+H0F39eQOmVivyPNzfTxUsqQUdKmQsfXlTLWm2+NMwpoU7U0Ga8Q/ptpIbal/j7fJNv5o=@lists.denx.de
X-Gm-Message-State: AOJu0YwVgEBUfj4KkXY3ko1WI3XiS8Wv7mFtvdiO/0K1uhNzyLCDIhRW
 t8IMEqUmjwby896NY7XHkeMS6yqCa1sFH61CO8K9gWSN2cYnVvnVUxJbPCUBKf1i2EYCZNRIS38
 WkVhnXhaGAICbjGyyQNGq6xqHPWgNvoBzESN7AgdnToIEnh/d65T+MuKusg==
X-Gm-Gg: ASbGncv9eqvuSBD8VMuFm9wG6o/sWJi8jDR0YkuEgI/AyEnWIVODlLm7cgcKK8uyWqR
 Umk0+ZgnDkc2/JvatEXkA5ElT4P21UI5G349joi/zZXm5R5ipujSJ0hwYMKadVO6P+Sec0nK35A
 leuuUEZxsUiCHUuHymOwteAaERnAT730pxB0FxQ3kC94ApsBNK6n543FJdzjVSMIWEoVY74JAFa
 gxCsH1G70Y4mn4WeEzuppdr8rOoc6ODmyRfpz0Xrqm7t2nNPo5ZYaiPPSa3t3gyZqhMdTdhIvUv
 p8FT6/gA+VTLiebiNeeePtqD26Fwnva9wR90fPHa/FL/78d8sEi3mpvxWYig3A==
X-Google-Smtp-Source: AGHT+IH5N4GdxfFtVaGfVlMawpBPjRSn9SBLzv/eb9tRRI9YUGOfHGAj5CZYRQnYTG2dEgX9bvSwrkpQgRHi9Q15Fis=
X-Received: by 2002:a05:690e:1488:b0:63f:c019:23ee with SMTP id
 956f58d0204a3-64302a2d549mr7273186d50.21.1763978084516; Mon, 24 Nov 2025
 01:54:44 -0800 (PST)
MIME-Version: 1.0
References: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
 <20251123225711.227016-9-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251123225711.227016-9-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 24 Nov 2025 11:54:08 +0200
X-Gm-Features: AWmQ_bmQTN_po2OE7Cc-AEMHjpXPWD4Av639onjjWxasjJ-t-oRvFTKX_BHeTak
Message-ID: <CAC_iWjJ4j8MHpwt84sM9MJbV5iewTz8kvLg3NvjC3UwqiqEDvg@mail.gmail.com>
Subject: Re: [PATCH 08/19] test: do not assume memory size 256 MiB in
 cmd_test_meminfo
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Paul Burton <paulburton@kernel.org>, Alexander Graf <agraf@csgraf.de>,
 Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heiko Schocher <hs@nabladev.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Richard Weinberger <richard@nod.at>, Guillaume La Roque <glaroque@baylibre.com>,
 u-boot@lists.denx.de
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

On Mon, 24 Nov 2025 at 00:58, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> 256 GiB is the default memory size of the sandbox. But in our CI other
> boards like qemu-x86_64_defconfig run with a different memory size.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  test/cmd/meminfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/test/cmd/meminfo.c b/test/cmd/meminfo.c
> index 53b41e3b49e..40c3520496e 100644
> --- a/test/cmd/meminfo.c
> +++ b/test/cmd/meminfo.c
> @@ -14,7 +14,7 @@
>  static int cmd_test_meminfo(struct unit_test_state *uts)
>  {
>         ut_assertok(run_command("meminfo", 0));
> -       ut_assert_nextline("DRAM:  256 MiB");
> +       ut_assert_nextlinen("DRAM:  ");
>         ut_assert_nextline_empty();
>
>         ut_assert_nextline("Region           Base     Size      End      Gap");
> --
> 2.51.0
>
