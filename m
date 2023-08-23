Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A976C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 00:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49C4D8651E;
	Thu, 24 Aug 2023 01:59:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HE9U+/+F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F54F864F9; Thu, 24 Aug 2023 01:59:28 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3C5D86517
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d77a4e30e97so1740469276.2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692835156; x=1693439956;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R+3neFz7IPFEqFhHx3atpWX8QL0jtKGAl3WxKthDr8s=;
 b=HE9U+/+F07gDrQ68TDArfj5Wh/SEVJDKbXYufvGHCktKyi62U2MQS17Xb3S0nTq5nl
 OmaEmN4lZwW0Q9WiG2Ci65CffB4lIB6UUMhtXiCZ/s1ar/ZleDQtx07R/iai9UZwgHwZ
 Je9KiYp3HR88UWenz9EqpirWG9SWdscYx7TF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692835156; x=1693439956;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R+3neFz7IPFEqFhHx3atpWX8QL0jtKGAl3WxKthDr8s=;
 b=T7qlT8LV6wxvWguIauW6Q/e9dP3Yv4iKne06CSFyjp6rX2U7RjQyvuHBkri9zCZfvl
 KixL1vXB+HMBM5fb2e4QqvzjyM2+iObaB/t5Vj5EpVZTiCZNhgf9OCn35/b2QH+iTpjy
 Da52SPPO5E600byplMkieuQ2qoVE70C5nUURzQSr/SKg69OM/Jc6mC2AOpiOanKV8fjC
 Pc3K9FxYpwQQjfcNuRopZTRp/8zLBK2W5aUGLVR754JvKQUHNWz1HF05w2EqEA8Y5q8V
 uwpWKCTZosnlXxwp5OuR2lZVQHDbyxijdMBiVeq1sYpvPDgkJMsBM72JRI06Pj3TtKaj
 YRpA==
X-Gm-Message-State: AOJu0YzOyLM3bhnUf46mNJQA2SXyFphJnr8wootBe20aB4+vhs/8Ua0s
 UfLxgtPAUnqTJYMXhEuRIW1+GujakBOWDR1kkIUuL6p88PTQ6EkNBNM=
X-Google-Smtp-Source: AGHT+IEQAMIR/eqWKCX6iyUVnJQR7ZqlGlsQlIw/RtEKvPti/ns77kSieqOomF3RORS2Jcru0IE80Hkq4UGLNWbnncQ=
X-Received: by 2002:a25:81cb:0:b0:d63:44e:cbcc with SMTP id
 n11-20020a2581cb000000b00d63044ecbccmr14428951ybm.22.1692835156438; Wed, 23
 Aug 2023 16:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230823193815.64213-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230823193815.64213-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 23 Aug 2023 17:57:54 -0600
Message-ID: <CAPnjgZ3GqMnwTsw-8g5s00RohV_0MEqjY6Rd-i84ce5WG9Mx4w@mail.gmail.com>
Subject: Re: [PATCH] test: print: Fix hexdump test on 64bit systems
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Mario Six <mario.six@gdsys.cc>
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

Hi Marek,

On Wed, 23 Aug 2023 at 13:38, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Use the following regex to make this test compatible with
> both 32bit and 64bit systems. The trick is to use %0*lx
> format string for the address prefix in the test.
>
> "
> s@\(ut_assert_nextline("\)0\+\([^:]\+\)\(:.*"\)\();\)@\1%0*lx\3, IS_ENABL=
ED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x\2UL\4
> "
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  test/print_ut.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/test/print_ut.c b/test/print_ut.c
> index 47a6ce57840..0a994a05cf6 100644
> --- a/test/print_ut.c
> +++ b/test/print_ut.c
> @@ -283,16 +283,16 @@ static int print_do_hex_dump(struct unit_test_state=
 *uts)
>         /* bytes */
>         console_record_reset();
>         print_hex_dump_bytes("", DUMP_PREFIX_ADDRESS, buf, 0x12);
> -       ut_assert_nextline("00000000: 00 11 22 33 44 55 66 77 88 99 aa bb=
 cc dd ee ff  ..\"3DUfw........");
> -       ut_assert_nextline("00000010: 10 00                              =
              ..");
> +       ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 99 aa bb cc=
 dd ee ff  ..\"3DUfw........", IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0U=
L);

Can you put the arg on the next line and perhaps put it at the top of
the file as a #define ?

> +       ut_assert_nextline("%0*lx: 10 00                                 =
           ..", IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL);
>         ut_assert_console_end();
>
>         /* line length */
>         console_record_reset();
>         print_hex_dump("", DUMP_PREFIX_ADDRESS, 8, 1, buf, 0x12, true);
> -       ut_assert_nextline("00000000: 00 11 22 33 44 55 66 77  ..\"3DUfw"=
);
> -       ut_assert_nextline("00000008: 88 99 aa bb cc dd ee ff  ........")=
;
> -       ut_assert_nextline("00000010: 10 00                    ..");
> +       ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77  ..\"3DUfw", I=
S_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
> +       ut_assert_nextline("%0*lx: 88 99 aa bb cc dd ee ff  ........", IS=
_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x8UL);
> +       ut_assert_nextline("%0*lx: 10 00                    ..", IS_ENABL=
ED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL);
>         ut_assert_console_end();
>         unmap_sysmem(buf);
>
> @@ -300,31 +300,31 @@ static int print_do_hex_dump(struct unit_test_state=
 *uts)
>         console_record_reset();
>         buf[0x41] =3D 0x41;
>         print_hex_dump("", DUMP_PREFIX_ADDRESS, 0x40, 1, buf, 0x42, true)=
;
> -       ut_assert_nextline("00000000: 00 11 22 33 44 55 66 77 88 99 aa bb=
 cc dd ee ff 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00  ..\"3DUfw........................................................")=
;
> -       ut_assert_nextline("00000040: 00 41                              =
                                                                           =
                                                                           =
        .A");
> +       ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 99 aa bb cc=
 dd ee ff 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00  ..\"3DUfw........................................................", IS=
_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
> +       ut_assert_nextline("%0*lx: 00 41                                 =
                                                                           =
                                                                           =
     .A", IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x40UL);
>         ut_assert_console_end();
>
>         /* 16-bit */
>         console_record_reset();
>         print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 2, buf, 0x12, true);
> -       ut_assert_nextline("00000000: 1100 3322 5544 7766 9988 bbaa ddcc =
ffee  ..\"3DUfw........");
> -       ut_assert_nextline("00000010: 0010                               =
      ..");
> +       ut_assert_nextline("%0*lx: 1100 3322 5544 7766 9988 bbaa ddcc ffe=
e  ..\"3DUfw........", IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
> +       ut_assert_nextline("%0*lx: 0010                                  =
   ..", IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL);
>         ut_assert_console_end();
>         unmap_sysmem(buf);
>
>         /* 32-bit */
>         console_record_reset();
>         print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 4, buf, 0x14, true);
> -       ut_assert_nextline("00000000: 33221100 77665544 bbaa9988 ffeeddcc=
  ..\"3DUfw........");
> -       ut_assert_nextline("00000010: 00000010                           =
  ....");
> +       ut_assert_nextline("%0*lx: 33221100 77665544 bbaa9988 ffeeddcc  .=
.\"3DUfw........", IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
> +       ut_assert_nextline("%0*lx: 00000010                             .=
...", IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL);
>         ut_assert_console_end();
>         unmap_sysmem(buf);
>
>         /* 64-bit */
>         console_record_reset();
>         print_hex_dump("", DUMP_PREFIX_ADDRESS, 16, 8, buf, 0x18, true);
> -       ut_assert_nextline("00000000: 7766554433221100 ffeeddccbbaa9988  =
..\"3DUfw........");
> -       ut_assert_nextline("00000010: 0000000000000010                   =
........");
> +       ut_assert_nextline("%0*lx: 7766554433221100 ffeeddccbbaa9988  ..\=
"3DUfw........", IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
> +       ut_assert_nextline("%0*lx: 0000000000000010                   ...=
.....", IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL);
>         ut_assert_console_end();
>         unmap_sysmem(buf);
>
> @@ -337,7 +337,7 @@ static int print_do_hex_dump(struct unit_test_state *=
uts)
>                 buf[4 + i] =3D 126 + i;
>         buf[8] =3D 255;
>         print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 1, buf, 10, true);
> -       ut_assert_nextline("00000000: 00 1f 20 21 7e 7f 80 81 ff 99      =
              .. !~.....");
> +       ut_assert_nextline("%0*lx: 00 1f 20 21 7e 7f 80 81 ff 99         =
           .. !~.....", IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
>         ut_assert_console_end();
>         unmap_sysmem(buf);
>
> --
> 2.40.1
>

Regards,
Simon
