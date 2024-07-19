Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE767C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 15:06:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 133BD88C16;
	Fri, 19 Jul 2024 17:05:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f5tRhpTM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A02C88BF2; Fri, 19 Jul 2024 17:05:31 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E720C88BDC
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 17:05:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6b79fc76d03so10452636d6.1
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 08:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721401528; x=1722006328; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LbX93mNWFlVQfQTnsxH3XOD6CmYwebAhzDuuA1lDRr4=;
 b=f5tRhpTM0mLkxJvc9vmjwL7Yo5AATU06eFddn8ryPvG2mY162xFh+HP0BJoeMo0ybz
 FLe7dRiE4lU9gwjlVc8lyfQh3v+w3fS1vZHwKMwHtdcpvku2/HYwHgEwAbP6lujsJQY6
 EYHu8iORcSaDUm5ArHYIfs2WCUiGwXjF4CRJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721401528; x=1722006328;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LbX93mNWFlVQfQTnsxH3XOD6CmYwebAhzDuuA1lDRr4=;
 b=OSsZgOzUxbbRZuGuNNcZoNZRqH4qYyz82DspOlAhQpgcgHhU5PgJ/0HSb26UKIhyTA
 9KpLgclAWhpI30plRA6U/4KTApny0fhrqIsbypeRbD6pWDlVYhPH/xiZK+4LzOMIufHP
 tuY5j1qzdtqywh3CuxKgg17qy39kPuHBXGdtVdFDeqpAmcVe6Td0TmRsGcuAZ/rJs9mx
 vY+8C/zbdi819mAuGLCQMilMAETNaPQYnvEhW9XPFDx7W1aqqFEaYuDfo0z2n8gScNuL
 5ATAEaq/eoTgZ5dyljAkgggcvTExmaDX0LO9T1Phjg9iGZSiYHZmXUkE39an24EdtndM
 Y3jg==
X-Gm-Message-State: AOJu0YwQn6DVg8gLY3ROW5XMcfr/6dUbLgFRHgPJNIoAciqFcks1wwUS
 iA6/cj57oUwyzJG7EPQkKaqxgp6t7+KnDjsGiLDhkXg4j1jePKiV2K7UanNIviJy6GVQqUuYL6K
 fcW24pd3Of98hr4XHsNbLTqu14ISFzarVKL5Z
X-Google-Smtp-Source: AGHT+IFxWfHXuZrO0Zbmp3jjXi0OhA+IQ7l0yjMoQGGpvwWm7cqv0ZYvn4Upm+BHOHojmNI2uVMQ+PANzZm5ruTAgig=
X-Received: by 2002:a05:6214:29ca:b0:6b7:aaf5:7b82 with SMTP id
 6a1803df08f44-6b7aaf57c31mr26949686d6.24.1721401527699; Fri, 19 Jul 2024
 08:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
 <20240717-docker-image-v1-6-7c7fc6251e7a@flygoat.com>
In-Reply-To: <20240717-docker-image-v1-6-7c7fc6251e7a@flygoat.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 19 Jul 2024 16:05:16 +0100
Message-ID: <CAFLszTgiDfk1TDJ1_YLTymcGK_R1+AHRPCbqOkFP-qzmVfMivA@mail.gmail.com>
Subject: Re: [PATCH 06/18] tests/test_event_dump: Relax match rule for output
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Jiaxun,

On Wed, 17 Jul 2024 at 15:29, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> event_dump.py relies on addr2line to obtain source location
> information, however newer addr2line is unable to determine
> line numbers for some functions.

Is this a bug in the tool?

>
> With addr2line from binutils 2.34 we got:
>
> Event type            Id                              Source location
> --------------------  ------------------------------  ------------------------------
> EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           :?
> EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    :?
> EVT_LAST_STAGE_INIT   install_smbios_table            :?
> EVT_MISC_INIT_F       sandbox_early_getopt_check      arch/sandbox/cpu/start.c:61
> EVT_TEST              h_adder_simple                  :?
>
> Which will fail the test.
>
> Relax the source location regex to .*:.*, this is sufficent to
> show that addr2line is being called and returned a possible
> line number.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  test/py/tests/test_event_dump.py | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

>
> diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_event_dump.py
> index e282c67335cd..e87825abcd1a 100644
> --- a/test/py/tests/test_event_dump.py
> +++ b/test/py/tests/test_event_dump.py
> @@ -16,9 +16,9 @@ def test_event_dump(u_boot_console):
>      out = util.run_and_log(cons, ['scripts/event_dump.py', sandbox])
>      expect = '''.*Event type            Id                              Source location
>  --------------------  ------------------------------  ------------------------------
> -EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_request.c:.*
> -EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simple_os.c:.*
> -EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loader/efi_smbios.c:.*
> -EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/cpu/start.c:.*
> -EVT_TEST              h_adder_simple                  .*test/common/event.c:'''
> +EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*:.*
> +EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*:.*
> +EVT_LAST_STAGE_INIT   install_smbios_table            .*:.*
> +EVT_MISC_INIT_F       sandbox_early_getopt_check      .*:.*
> +EVT_TEST              h_adder_simple                  .*:'''
>      assert re.match(expect, out, re.MULTILINE) is not None
>
> --
> 2.45.2
>

Regards,
Simon
