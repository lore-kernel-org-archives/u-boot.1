Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F0DCCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 08:49:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CCDF83F56;
	Tue, 11 Nov 2025 09:49:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k7kLcgIz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BB2983936; Tue, 11 Nov 2025 09:49:29 +0100 (CET)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4282983AEC
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 09:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-640f88b8613so453097d50.2
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 00:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762850966; x=1763455766; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/90REf1OOY2n50IgV7XeVJrijfgWYWPrqrA3C1sEbs=;
 b=k7kLcgIzBIhoD7eF/GP/eVgWb+Gj9tk86csnA2OBxqx02Pt6IiEUEb8P2J5J4hL0FX
 IJDn2+TbENgEprDZ/5kRiloJWi5e++p0DWNOaP8ZaPn6ldw+NICqO5WAZ8IF0hPpbq0z
 OOKb1hIuVeLHLCvfMQ5ky7tucPgo70JhytIeR/ujY1REgxKp5vPc1CcFBnhCIg8DL3cy
 969PzYdUlWnJdlg1Ik/tmZSMFA+K/snJDOvkroIlKbIryz+FRi+ioezSHplMI6yqLi3d
 VDmf7a+HhMm+JEpW2tPr31wyaUcbmSlJJdLSYSxG4/Xg9y5e54RKvfFOr+Fv+JLT7hzE
 3rFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762850966; x=1763455766;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N/90REf1OOY2n50IgV7XeVJrijfgWYWPrqrA3C1sEbs=;
 b=dHIDiBsA4/cea1Tc57PMcXCak5pxd6YNg6yYCO9Jh5eMlo2HF19qp8JnIZ+BEo3dOZ
 QbYPIWujVLleC28UB7Gwx4FVWtR8LqH/SvnbXxlFb/77AaZTPrd67HvNjq30lPG/VtPD
 vwmkS1i27pW3mfP+XLWgvvai6i/4JO/6E1Kz8FEDhJF62sZGL1UM2EUhEU0YNSQVX58P
 Ev2YU2XHZJ2wsmZ6BjfeLd8CuCTW+9ESAff9KncgzdcXGucnWx5fR1SUOWBba9hxAGuR
 tQ6ocY7UfR9z3BWXQ332pyLKBD9B6S+ljOHhEkkSye5rjnlCeescJQk53kpCzNA6yFwg
 Zcbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw8mng6z8rHzUT7+tugd6RkyLgnobzDvqPwsm5wS8j3x695r0GVupfPrMx5Z4hZwhZoISnyRs=@lists.denx.de
X-Gm-Message-State: AOJu0YzMg2UXx8qBksjdaaQ1lRmn++04E6PREC2nYf/ByIysOiuaocEX
 mlN7j40lawFneSjBbOV158/rybYqqsBJmv6LBCmaN9q74PFCfaDFtqKutIKFNfX03Y42L3dvJjY
 YRfKeF9RVFOBzd6ATmpScVk7DrcpxwVs1bv3fcBR9j4u+/JN5ssE/bdI=
X-Gm-Gg: ASbGncthMb2qj9iPT8dpHjHeYiMYOHBrnOgxvuxRawPEt4J7jAbCbIDwBTcspVKoQd/
 Kgqh2yMu5o9KPQNcC3qknX92HkKQY/VnWPO9MXhnSsy5Hh+FlyUQX7Dglw9KsqxC3nZGs/kV74F
 R4yxu8TbeWQvvctHKTlfmMBJNs0KI5X9Hgonlndu2VnLHyQkGSDot3y9sAN3yrUzAQD/XDebmPh
 mNInFOie2hLjujTfwxodcemWbBv/hx3ZggNyuMd8/zp+VNEqkUr86YmTC8DRyBTTCXqx3+YvrF9
 T/sDQd2eh//udmhlQTmatfO9h0t0QJ/FPLB8PP3C9TZH1r20MP0=
X-Google-Smtp-Source: AGHT+IGQu1IdIKEtl60okJCjBDAjOhPHij/BSlXAkAWyFufT1MwVHyx4C/CKnMpnscEJtPDnfuL9jUjDaB/uAs1aHc0=
X-Received: by 2002:a05:690e:4254:b0:63f:b1d4:f9f1 with SMTP id
 956f58d0204a3-640d45d39bamr8492539d50.50.1762850966061; Tue, 11 Nov 2025
 00:49:26 -0800 (PST)
MIME-Version: 1.0
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-6-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251109101010.306268-6-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Nov 2025 10:48:49 +0200
X-Gm-Features: AWmQ_bkAuM8nHlAiG6OAEVa3T-r_QEYbXnBKASqTHiaSIaQe8NmXQvVnX2SWi94
Message-ID: <CAC_iWjJMFhmtkMKDuWJNnH-HBBfo6_LWPVNrbJiG_Fj83n0Uag@mail.gmail.com>
Subject: Re: [PATCH 5/9] test: common/print: do not use fixed buffer addresses
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
> memory locations. Use calloc() instead to allocate buffers.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  test/common/print.c | 76 ++++++++++++++++++++++++---------------------
>  1 file changed, 40 insertions(+), 36 deletions(-)
>
> diff --git a/test/common/print.c b/test/common/print.c
> index 76ee851fe6a..2ac7eeed2c1 100644
> --- a/test/common/print.c
> +++ b/test/common/print.c
> @@ -168,12 +168,8 @@ static int print_display_buffer(struct unit_test_sta=
te *uts)
>         u8 *buf;
>         int i;
>
> -       /* This test requires writable memory at zero */
> -       if (IS_ENABLED(CONFIG_X86))
> -               return -EAGAIN;
> -
> -       buf =3D map_sysmem(0, BUF_SIZE);
> -       memset(buf, '\0', BUF_SIZE);
> +       buf =3D calloc(1, BUF_SIZE);
> +       ut_assertnonnull(buf);
>         for (i =3D 0; i < 0x11; i++)
>                 buf[i] =3D i * 0x11;
>
> @@ -232,7 +228,7 @@ static int print_display_buffer(struct unit_test_stat=
e *uts)
>         ut_assert_nextline("00000000: 00 1f 20 21 7e 7f 80 81 ff 99      =
              .. !~.....");
>         ut_assert_console_end();
>
> -       unmap_sysmem(buf);
> +       free(buf);
>
>         return 0;
>  }
> @@ -244,13 +240,14 @@ static int print_hexdump_line(struct unit_test_stat=
e *uts)
>         u8 *buf;
>         int i;
>
> -       buf =3D map_sysmem(0, BUF_SIZE);
> -       memset(buf, '\0', BUF_SIZE);
> +       buf =3D calloc(1, BUF_SIZE);
> +       ut_assertnonnull(buf);
>         for (i =3D 0; i < 0x11; i++)
>                 buf[i] =3D i * 0x11;
>
>         /* Check buffer size calculations */
> -       linebuf =3D map_sysmem(0x400, BUF_SIZE);
> +       linebuf =3D calloc(1, BUF_SIZE);
> +       ut_assertnonnull(buf);
>         memset(linebuf, '\xff', BUF_SIZE);
>         ut_asserteq(-ENOSPC, hexdump_line(0, buf, 1, 0x10, 0, linebuf, 75=
));
>         ut_asserteq(0xff, linebuf[0]);
> @@ -258,7 +255,8 @@ static int print_hexdump_line(struct unit_test_state =
*uts)
>         ut_asserteq('\0', linebuf[75]);
>         ut_asserteq(0xff, linebuf[76]);
>
> -       unmap_sysmem(buf);
> +       free(linebuf);
> +       free(buf);
>
>         return 0;
>  }
> @@ -269,69 +267,74 @@ static int print_do_hex_dump(struct unit_test_state=
 *uts)
>         u8 *buf;
>         int i;
>
> -       /* This test requires writable memory at zero */
> -       if (IS_ENABLED(CONFIG_X86))
> -               return -EAGAIN;
> -
> -       buf =3D map_sysmem(0, BUF_SIZE);
> -       memset(buf, '\0', BUF_SIZE);
> +       buf =3D calloc(1, BUF_SIZE);
> +       ut_assertnonnull(buf);
>         for (i =3D 0; i < 0x11; i++)
>                 buf[i] =3D i * 0x11;
>
>         /* bytes */
>         print_hex_dump_bytes("", DUMP_PREFIX_ADDRESS, buf, 0x12);
>         ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 99 aa bb cc=
 dd ee ff  ..\"3DUfw........",
> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL)=
;
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> +                          (uintptr_t)buf);
>         ut_assert_nextline("%0*lx: 10 00                                 =
           ..",
> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL=
);
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> +                          (uintptr_t)buf + 0x10UL);
>         ut_assert_console_end();
>
>         /* line length */
>         print_hex_dump("", DUMP_PREFIX_ADDRESS, 8, 1, buf, 0x12, true);
>         ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77  ..\"3DUfw",
> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL)=
;
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> +                          (uintptr_t)buf);
>         ut_assert_nextline("%0*lx: 88 99 aa bb cc dd ee ff  ........",
> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x8UL)=
;
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> +                          (uintptr_t)buf + 0x8UL);
>         ut_assert_nextline("%0*lx: 10 00                    ..",
> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL=
);
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> +                          (uintptr_t)buf + 0x10UL);
>         ut_assert_console_end();
> -       unmap_sysmem(buf);
>
>         /* long line */
>         buf[0x41] =3D 0x41;
>         print_hex_dump("", DUMP_PREFIX_ADDRESS, 0x40, 1, buf, 0x42, true)=
;
>         ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 99 aa bb cc=
 dd ee ff 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00  ..\"3DUfw........................................................",
> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL)=
;
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> +                          (uintptr_t)buf);
>         ut_assert_nextline("%0*lx: 00 41                                 =
                                                                           =
                                                                           =
     .A",
> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x40UL=
);
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> +                          (uintptr_t)buf + 0x40UL);
>         ut_assert_console_end();
>
>         /* 16-bit */
>         print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 2, buf, 0x12, true);
>         ut_assert_nextline("%0*lx: 1100 3322 5544 7766 9988 bbaa ddcc ffe=
e  ..\"3DUfw........",
> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL)=
;
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> +                          (uintptr_t)buf);
>         ut_assert_nextline("%0*lx: 0010                                  =
   ..",
> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL=
);
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> +                          (uintptr_t)buf + 0x10UL);
>         ut_assert_console_end();
> -       unmap_sysmem(buf);
>
>         /* 32-bit */
>         print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 4, buf, 0x14, true);
>         ut_assert_nextline("%0*lx: 33221100 77665544 bbaa9988 ffeeddcc  .=
.\"3DUfw........",
> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL)=
;
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> +                          (uintptr_t)buf);
>         ut_assert_nextline("%0*lx: 00000010                             .=
...",
> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL=
);
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> +                          (uintptr_t)buf + 0x10UL);
>         ut_assert_console_end();
> -       unmap_sysmem(buf);
>
>         /* 64-bit */
>         print_hex_dump("", DUMP_PREFIX_ADDRESS, 16, 8, buf, 0x18, true);
>         ut_assert_nextline("%0*lx: 7766554433221100 ffeeddccbbaa9988  ..\=
"3DUfw........",
> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL)=
;
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> +                          (uintptr_t)buf);
>         ut_assert_nextline("%0*lx: 0000000000000010                   ...=
.....",
> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL=
);
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> +                          (uintptr_t)buf + 0x10UL);
>         ut_assert_console_end();
> -       unmap_sysmem(buf);
>
>         /* ASCII */
>         buf[1] =3D 31;
> @@ -342,9 +345,10 @@ static int print_do_hex_dump(struct unit_test_state =
*uts)
>         buf[8] =3D 255;
>         print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 1, buf, 10, true);
>         ut_assert_nextline("%0*lx: 00 1f 20 21 7e 7f 80 81 ff 99         =
           .. !~.....",
> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL)=
;
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> +                          (uintptr_t)buf);
>         ut_assert_console_end();
> -       unmap_sysmem(buf);
> +       free(buf);
>
>         return 0;
>  }
> --
> 2.51.0
>
