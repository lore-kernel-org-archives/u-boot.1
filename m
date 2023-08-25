Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B39EC6787B
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 18:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0D5486B5B;
	Fri, 25 Aug 2023 20:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g7wclGGe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2410C86B3F; Fri, 25 Aug 2023 20:06:28 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C4AC86B2D
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 20:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so4624765a12.1
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 11:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692986785; x=1693591585;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/N4uFH1b1Qy3iulbFwRcgBFfIDFlm2U+TfqgaRW2eoM=;
 b=g7wclGGe6yclqHZjPaeQrANmyW5wyLIL5gPN/6kPYX+2pwOphkOdDldl9d2hrnHe2a
 cGjFFFTmNVKZA9Zv1KrPo5fuOPWAE3/f5HCMObmkSGgVNYYxl0dsc+JUFZTefnLprwTS
 wt8jZCAgd3CmnFQNBZ3KSRhW5IfU167A91RGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692986785; x=1693591585;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/N4uFH1b1Qy3iulbFwRcgBFfIDFlm2U+TfqgaRW2eoM=;
 b=i4J0wpLyYwMS9W752RlIl2cLPThqB6hO01fyqU5vXQIP8CPwkFFtqCEL2c9QFMf8IH
 uyEvzvDPw9Y8yPPTlL8hiA6JQGrpKKeFW3k9UH3Odg0VSLnjFaYGQ8lIbj4pgI0ZXM/q
 NhJlqDL52qT+/5FXqfR7Luanis9gHT8Y+W63yWxizeyf1wzUwbkpnSoNRSlgWDAMzJcy
 07Q0e/shL3rABEtjrapGFGpiBC1Sa/hLCCsiz8jE29EUvBBFFJmRnFjKoUvA9HSCHuE9
 1SVwKIE5N1tfItG7H9Fx1OVdaEGLcvgNAFP9k3yaKpUtejgX6VdT+1towRrHAtrApPCo
 DUIg==
X-Gm-Message-State: AOJu0YzDPUVzAkmZ9OA12EKXkvZNaGu6T1yGcl421etHgZogCGXI+Ui5
 IMZRHEGDohj0aHCp6z6eaGr5bqYSynHXBStjDQvTxw==
X-Google-Smtp-Source: AGHT+IHZ+Py4NH645aJ02V2qg0LuOBbe0gBJ4zD8EOAN3tqZMDx/uGB6UZTPTdSN977wHqXCLNiEkAYGChVrvq3p5Os=
X-Received: by 2002:a05:6402:40c8:b0:529:d147:e9f3 with SMTP id
 z8-20020a05640240c800b00529d147e9f3mr22467282edb.5.1692986785004; Fri, 25 Aug
 2023 11:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230825081940.5866-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230825081940.5866-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 25 Aug 2023 12:06:11 -0600
Message-ID: <CAPnjgZ18OOTQDuTUsr4uOnsOe5uiak15sO4VAwOxx=F9aqcMXg@mail.gmail.com>
Subject: Re: [PATCH v2] test: print: Fix hexdump test on 64bit systems
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

On Fri, 25 Aug 2023 at 02:20, Marek Vasut
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
> V2: Break line before IS_ENABLED
> ---
>  test/print_ut.c | 42 ++++++++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/test/print_ut.c b/test/print_ut.c
> index 47a6ce57840..b26f6281b01 100644
> --- a/test/print_ut.c
> +++ b/test/print_ut.c
> @@ -283,16 +283,21 @@ static int print_do_hex_dump(struct unit_test_state=
 *uts)
>         /* bytes */
>         console_record_reset();
>         print_hex_dump_bytes("", DUMP_PREFIX_ADDRESS, buf, 0x12);
> -       ut_assert_nextline("00000000: 00 11 22 33 44 55 66 77 88 99 aa bb=
 cc dd ee ff  ..\"3DUfw........");
> -       ut_assert_nextline("00000010: 10 00                              =
              ..");
> +       ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 99 aa bb cc=
 dd ee ff  ..\"3DUfw........",
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL)=
;
> +       ut_assert_nextline("%0*lx: 10 00                                 =
           ..",
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL=
);
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
> +       ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77  ..\"3DUfw",
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL)=
;
> +       ut_assert_nextline("%0*lx: 88 99 aa bb cc dd ee ff  ........",
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x8UL)=
;
> +       ut_assert_nextline("%0*lx: 10 00                    ..",
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL=
);
>         ut_assert_console_end();
>         unmap_sysmem(buf);
>
> @@ -300,31 +305,39 @@ static int print_do_hex_dump(struct unit_test_state=
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
 00  ..\"3DUfw........................................................",
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL)=
;
> +       ut_assert_nextline("%0*lx: 00 41                                 =
                                                                           =
                                                                           =
     .A",
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x40UL=
);
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
e  ..\"3DUfw........",
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL)=
;
> +       ut_assert_nextline("%0*lx: 0010                                  =
   ..",
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL=
);
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
.\"3DUfw........",
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL)=
;
> +       ut_assert_nextline("%0*lx: 00000010                             .=
...",
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL=
);
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
"3DUfw........",
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL)=
;
> +       ut_assert_nextline("%0*lx: 0000000000000010                   ...=
.....",
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL=
);
>         ut_assert_console_end();
>         unmap_sysmem(buf);
>
> @@ -337,7 +350,8 @@ static int print_do_hex_dump(struct unit_test_state *=
uts)
>                 buf[4 + i] =3D 126 + i;
>         buf[8] =3D 255;
>         print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 1, buf, 10, true);
> -       ut_assert_nextline("00000000: 00 1f 20 21 7e 7f 80 81 ff 99      =
              .. !~.....");
> +       ut_assert_nextline("%0*lx: 00 1f 20 21 7e 7f 80 81 ff 99         =
           .. !~.....",
> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL)=
;
>         ut_assert_console_end();
>         unmap_sysmem(buf);
>
> --
> 2.40.1
>
