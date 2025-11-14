Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26151CE7B03
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 12:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 783AB83966;
	Fri, 14 Nov 2025 13:31:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ePfkCYsU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69D1E840AE; Fri, 14 Nov 2025 13:31:55 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4808B83946
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 13:31:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6406f3dcc66so3343518a12.3
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 04:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763123513; x=1763728313; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PECpaWMUHil4It5iEz2J6hu68jWm8k4PvTMepVAHeMY=;
 b=ePfkCYsUm45SzDSstPUG3B6jUyjgJl86apkh9QHnGnqIHRY8wr2gnwi4pfpVkAGbjK
 FbVOq8l+Wxovqx0cjVeElzrMWa0IjFMxfjELBZkuAdGYpC2iBchSSckwJfcRxfox59s6
 My8xvYOp0rNAXCaxhCii5HcLW9cLrRfPzmLks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763123513; x=1763728313;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PECpaWMUHil4It5iEz2J6hu68jWm8k4PvTMepVAHeMY=;
 b=R9Vk+dND+770qfi4ozVJQ82RklVHgFRQQF+ISM2TQOwaxVucPjjQURbonf5jy2QYaw
 zR1Mt0IKje/HcdwjFkgfUGDHiDKqIKJW9tRSWIHaFcmqMqIm+iibizUutSRAEPC4/4Ra
 V6Cc0Sh1MaxppCyeQspDMMkYrPLMPslQcD/ZJ+wWj3dQEds6B6t8+mLFzeG3nwaZ4mHj
 JP8yfducWgEI5XCSji9jm208LvX8/X94af4PVRZJR8lqKK1lN8btoksgV+EoWoE2ZgaM
 +vfQcR9PI87StN2jMsF4r/n0U+NsNiKnIWPo50obbbj1ijbn72rURMG0ZrFBqPVGpYR/
 BKFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3NpUwlkR1WnHyA5G80QBhgNw+xJLt7f40Pst5J0XoB8G1MMQcNehTeX1+5QRXiSB9uxFoX0Q=@lists.denx.de
X-Gm-Message-State: AOJu0YxKPNLOSmXkU/uAPMsUceFtGkxEL7hvPNDKKDoTsnFEQzMcEvpj
 Til3HFIOULkYNRpiFRecHkKEEgzdGoBth/hMeBvKEdIfYutbeit3yV7HNOhuWE1ziPsjE8nl9Md
 m+5QauxB9W9x30XprnodZEdl8StZ/wkmowLXut9GE
X-Gm-Gg: ASbGncu5USxn/aGBxMFcK4m7CqOhrEkqqBts+LhQPkIIyYj6KLccaJKgs+Af0iS/lDS
 xR/0salg2tlVHAATT22f1wIPG8sXF0a1usFGX45FQ1Wa+zUgs0V5nLognB/DdYfayhHeU3ybT3S
 0jf+1vCpyrK9B9xWUHf84V8f/S18RZEhqz0nIOfo4Fe4VOs9VvA8gkPDWmmdp+8p7wTuK0bUkgA
 a6ZW/vOPBj6D9YBlIPgPyqpwpm0+V/L0A3M3R4RGLRW8MTdwCQUo6JE/9eGFEqAulap/gkHqcON
 hutA
X-Google-Smtp-Source: AGHT+IHd3Of/mED4FDDXzmYVyKfxRcMUflcLAnPba/430EVHh1cp9j/du4y+wBm1+XkwQ4MxNco25kjE4bO2i17R1EY=
X-Received: by 2002:a17:906:6a0d:b0:b4a:d0cf:873f with SMTP id
 a640c23a62f3a-b736787e0a0mr276155066b.2.1763123512609; Fri, 14 Nov 2025
 04:31:52 -0800 (PST)
MIME-Version: 1.0
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-7-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251109101010.306268-7-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Nov 2025 05:31:40 -0700
X-Gm-Features: AWmQ_bm1jpv490GlFVh1TgispcGLTd2HROeN5yMLbRjmESVJyBQ4CvGQwH8SWDA
Message-ID: <CAFLszTiHVqgn5eox3p7CWt0=XjAcYMBjR7F03UqweRftZg5fDg@mail.gmail.com>
Subject: Re: [PATCH 6/9] test: cmd/fdt: do not use fixed buffer addresses
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
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

Hi Heinrich,

On Sun, 9 Nov 2025 at 03:10, Heinrich Schuchardt
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

This is adding memory allocations to a test for hex dumping.

It would be better and simpler to use a fixed address and make this a
sandbox-only test. I struggle to see the value of running these sorts
of tests under QEMU?

Regards,
Simon
