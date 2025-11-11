Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B9DCCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 08:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C178C83AEC;
	Tue, 11 Nov 2025 09:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rbGqZKQr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAB7E83EC0; Tue, 11 Nov 2025 09:44:19 +0100 (CET)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC92383AB4
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 09:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-640e065991dso2972573d50.3
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 00:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762850655; x=1763455455; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xf1zq4jyHOWbwK01xk+oBgwyMuSyq580Nu2cX28XsRs=;
 b=rbGqZKQr8f01nG0YuFOWW08CnpZkoQ21HyuQfTw7sach8Un7dmCrze9oHzNQISMMqh
 G0IPtx/MD34SksTAnVIHYc916x3taeZ5EtHfn4Rjt7NGRTj0Q5Wa54IpInRWMvIcRy5H
 n0XLjaSYC29FvfdnxC6kQk4HhlF0cfkZr2LOf553yZotpOozrV87LHeFBlbwg5gjgAK2
 VP0IYd6yqlg44wHzq64FURzRdGpzOJanU57LVB/g33JstFPVMvlgCG6kRysVl7M91S3B
 ML20HbezB6otSOeyi1shl0gc5Q/ZKLsp/f2Rr6HOjBZk/6NwWsrdreU1c+7xkz4WJ8x8
 otfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762850655; x=1763455455;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xf1zq4jyHOWbwK01xk+oBgwyMuSyq580Nu2cX28XsRs=;
 b=lnWomSP0/vIvN9Xq3OPHRilJNgtLW88zMKg3h3zmpRBGwI8iOsPVazgvaaYjHglZpF
 SqKFLzfeAhYWK6w21A77ocBxRgkmDuModv2duv9+SxTma2E6gPknPCSI2Hwz/yYKqw7k
 t2Ly+eO8/a8sk9Bs6ZU5I3rOmqXQYUs25DcwojK5exdu42xyAEX3f7ugvpz+WwW3s7qv
 jKUDebdqBit2G/78tXqnkBNcgx8hHioVzT0Akuftf39pEdRky3/AulVqo3LiccSqiF0R
 /gnqDSIGPx37dXUKH9W6BmrQq/wfe4rMrZ/E9hyFu3H6V5qoQKQNpYWZd/DX8tCoV7NU
 Jb/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW716RV/nVOo237HE+g+FalR9GpVZJ+674fiYbebatGxOrJU1EWEsMR6dlqX9hvtcVOC6M+DJg=@lists.denx.de
X-Gm-Message-State: AOJu0Yym/9M0PtqBimXaG8tPU2xnF2C619ODsViknG5vsCAeU/vabq+0
 ch0T1EJlthcgB4Zc2yeVFceNeYY/JMRbGsS/XYQKP4pD76BWmTEP5tbT0W37rprQsWMYd219dSQ
 ISD1qSs9AyS4Aae+qDC1+n+CHYF6b99quygyJcdxqPQ==
X-Gm-Gg: ASbGnctQX5Tcgd3i+gGrqDQjgmmG27kf3wj3CHjgW3GPpyOzfSKx1rdXOnpF5M2qlWG
 t+OO+MAzWvyq+yoxOSa3O/IrujrP5zo9SH0VV6J5VtmQ52F0k0AemCWCA/k+jZHAXCX9/RQnUVy
 mWlOK+YctpwOE7GL0BmCVmdULuRajELrmNsAFyAt5Q6K8IKtFe0mb1ZaO/7tbB5R0F7Yo0ZRE5F
 6o7TTIZIBvnxJZP/ZVDsP1NrPfU9VtkyeAj5fzQuYm/xvSc+5kuqto3PaqgmcETYhW0My/2a2Rh
 KF3yh3kz4vI2ZwI91bVIKzmBqrFAER0x20tZck6dYBqyAjd2BEc=
X-Google-Smtp-Source: AGHT+IHuri/yWdbeUmXYd8oeK1BYoI1lnc8pxq4qC7jIOxOEcdaggeVqkKtzKAerSFYstKotkeCmlKDD+tdUux5b+2E=
X-Received: by 2002:a05:690c:6c86:b0:788:284:39e3 with SMTP id
 00721157ae682-78802843f98mr27126757b3.26.1762850655452; Tue, 11 Nov 2025
 00:44:15 -0800 (PST)
MIME-Version: 1.0
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-7-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251109101010.306268-7-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Nov 2025 10:43:38 +0200
X-Gm-Features: AWmQ_bnrxRka7YB55_M1Hl8MJ0NR6J8Mn6l6RkDO4V7YMECVh2ItvQ3ARBMKFn8
Message-ID: <CAC_iWjKQke5sO+n2rwODWGi0OPi6xAHSNyKBBFyAG-j+zmDR1A@mail.gmail.com>
Subject: Re: [PATCH 6/9] test: cmd/fdt: do not use fixed buffer addresses
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Harrison Mutai <harrison.mutai@arm.com>, Peng Fan <peng.fan@nxp.com>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Rick Chen <rick@andestech.com>, u-boot@lists.denx.de
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

On Sun, 9 Nov 2025 at 12:10, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The location of memory depends on the board. Do not assume memory at fixe=
d
> memory locations. Use memalign() instead to allocate a buffer.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/cmd/fdt.c      |  8 ++++++--
>  test/common/print.c | 37 ++++++++++++++++---------------------
>  2 files changed, 22 insertions(+), 23 deletions(-)
>
> diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
> index b950123b6da..4c3c6308ab4 100644
> --- a/test/cmd/fdt.c
> +++ b/test/cmd/fdt.c
> @@ -265,7 +265,7 @@ FDT_TEST(fdt_test_addr_resize, UTF_CONSOLE);
>  static int fdt_test_move(struct unit_test_state *uts)
>  {
>         char fdt[256];
> -       ulong addr, newaddr =3D 0x10000;
> +       ulong addr, newaddr;
>         const int size =3D sizeof(fdt);
>         uint32_t ts;
>         void *buf;
> @@ -275,8 +275,10 @@ static int fdt_test_move(struct unit_test_state *uts=
)
>         ts =3D fdt_totalsize(fdt);
>
>         /* Moved target DT location */
> -       buf =3D map_sysmem(newaddr, size);
> +       buf =3D memalign(8, size);
> +       ut_assertnonnull(buf);
>         memset(buf, 0, size);
> +       newaddr =3D map_to_sysmem(buf);
>
>         /* Test moving the working FDT to a new location */
>         ut_assertok(run_commandf("fdt move %08lx %08lx %x", addr, newaddr=
, ts));
> @@ -288,6 +290,8 @@ static int fdt_test_move(struct unit_test_state *uts)
>         ut_assert_nextline("Total of %d byte(s) were the same", ts);
>         ut_assert_console_end();
>
> +       free(buf);
> +
>         return 0;
>  }
>  FDT_TEST(fdt_test_move, UTF_CONSOLE);
> diff --git a/test/common/print.c b/test/common/print.c
> index 2ac7eeed2c1..f33476a36b4 100644
> --- a/test/common/print.c
> +++ b/test/common/print.c
> @@ -266,74 +266,70 @@ static int print_do_hex_dump(struct unit_test_state=
 *uts)
>  {
>         u8 *buf;
>         int i;
> +       ulong addr;
>
>         buf =3D calloc(1, BUF_SIZE);
>         ut_assertnonnull(buf);
> +       addr =3D map_to_sysmem(buf);
>         for (i =3D 0; i < 0x11; i++)
>                 buf[i] =3D i * 0x11;
>
>         /* bytes */
>         print_hex_dump_bytes("", DUMP_PREFIX_ADDRESS, buf, 0x12);
>         ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 99 aa bb cc=
 dd ee ff  ..\"3DUfw........",
> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> -                          (uintptr_t)buf);
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
>         ut_assert_nextline("%0*lx: 10 00                                 =
           ..",
>                            IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> -                          (uintptr_t)buf + 0x10UL);
> +                          addr + 0x10UL);
>         ut_assert_console_end();
>
>         /* line length */
>         print_hex_dump("", DUMP_PREFIX_ADDRESS, 8, 1, buf, 0x12, true);
>         ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77  ..\"3DUfw",
> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> -                          (uintptr_t)buf);
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
>         ut_assert_nextline("%0*lx: 88 99 aa bb cc dd ee ff  ........",
>                            IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> -                          (uintptr_t)buf + 0x8UL);
> +                          addr + 0x8UL);
>         ut_assert_nextline("%0*lx: 10 00                    ..",
>                            IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> -                          (uintptr_t)buf + 0x10UL);
> +                          addr + 0x10UL);
>         ut_assert_console_end();
>
>         /* long line */
>         buf[0x41] =3D 0x41;
>         print_hex_dump("", DUMP_PREFIX_ADDRESS, 0x40, 1, buf, 0x42, true)=
;
>         ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 99 aa bb cc=
 dd ee ff 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00  ..\"3DUfw........................................................",
> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> -                          (uintptr_t)buf);
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
>         ut_assert_nextline("%0*lx: 00 41                                 =
                                                                           =
                                                                           =
     .A",
>                            IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> -                          (uintptr_t)buf + 0x40UL);
> +                          addr + 0x40UL);
>         ut_assert_console_end();
>
>         /* 16-bit */
>         print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 2, buf, 0x12, true);
>         ut_assert_nextline("%0*lx: 1100 3322 5544 7766 9988 bbaa ddcc ffe=
e  ..\"3DUfw........",
> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> -                          (uintptr_t)buf);
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
>         ut_assert_nextline("%0*lx: 0010                                  =
   ..",
>                            IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> -                          (uintptr_t)buf + 0x10UL);
> +                          addr + 0x10UL);
>         ut_assert_console_end();
>
>         /* 32-bit */
>         print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 4, buf, 0x14, true);
>         ut_assert_nextline("%0*lx: 33221100 77665544 bbaa9988 ffeeddcc  .=
.\"3DUfw........",
> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> -                          (uintptr_t)buf);
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
>         ut_assert_nextline("%0*lx: 00000010                             .=
...",
>                            IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> -                          (uintptr_t)buf + 0x10UL);
> +                          addr + 0x10UL);
>         ut_assert_console_end();
>
>         /* 64-bit */
>         print_hex_dump("", DUMP_PREFIX_ADDRESS, 16, 8, buf, 0x18, true);
>         ut_assert_nextline("%0*lx: 7766554433221100 ffeeddccbbaa9988  ..\=
"3DUfw........",
> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> -                          (uintptr_t)buf);
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
>         ut_assert_nextline("%0*lx: 0000000000000010                   ...=
.....",
>                            IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> -                          (uintptr_t)buf + 0x10UL);
> +                          addr + 0x10UL);
>         ut_assert_console_end();
>
>         /* ASCII */
> @@ -345,8 +341,7 @@ static int print_do_hex_dump(struct unit_test_state *=
uts)
>         buf[8] =3D 255;
>         print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 1, buf, 10, true);
>         ut_assert_nextline("%0*lx: 00 1f 20 21 7e 7f 80 81 ff 99         =
           .. !~.....",
> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> -                          (uintptr_t)buf);
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
>         ut_assert_console_end();
>         free(buf);
>
> --
> 2.51.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
