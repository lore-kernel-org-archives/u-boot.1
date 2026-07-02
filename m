Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B454FC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 07:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30D9084C85;
	Thu,  2 Jul 2026 09:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gx/cr/zh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 529A284CA4; Thu,  2 Jul 2026 09:44:14 +0200 (CEST)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9314C849FB
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 09:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-664d78637f8so2048646d50.3
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 00:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782978250; cv=none;
 d=google.com; s=arc-20260327;
 b=OXmIwuG6RjMdC4oG99njupV006UkGW7tcGOVnZ0YtYLKt67SdSaEJqf67h4kFqN0u6
 h7GhU8hZB8eh6dKtwsrTmt60+AJtaFb2QY7PPi/PtIrBhnejgZAIehmNKxfN4IuQHPU8
 Jgfn8B6MCEZHHknDpulFmZaMUAiSeMSHqb5gayq7VaYasZomm4wtx7fdwX0yAkiIg3U+
 xs5SkBMprwhfefKGp6yeo//TP0HxJs6o6WkNl/veY/xAyOk+mbXItNHhPPsRJ9hvH718
 LAeo5u+qOVNhKIN2TVATvS9m1Uk0RJPj/qJiZm9s9fCeKceioUbFPmhXTA8vLLk44KLf
 c2QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Q5DCRZrF2Pz0cFzKwCFjGiRsP6CvC4heKPnihiP+XIo=;
 fh=j1bZrBR5QLqIR0LOXMFIh5EDSPj1fVHWJGzki1fNPc0=;
 b=KKg7bvvtIwEeVUArWKAerQPrw/pBcKhynPpAtOdmjgVqRXxWnFsh5lsjOodorDnbnr
 ZE2W972JnAtakby0VW1J0MgXsVM1hvbcoxdQwmB+UNoOpU7rfFKcHy9TF16BMDw3V99T
 dfa1H1QNtBSFwLRRihVZ3yfV1C9k6BytAwX1de5yjz0V4Ze+TjIccd+WjW7ml71jix99
 ZsxnfueOAeWvWdTEjdeRAZT5vicoJ3aYfiqTo354udT7ys/iuVco4pnZrtMIuEhjHPRQ
 0X2a/K7L6Y53Sc8pPcJjymVneBaZgISLBeCr99cPfIK8u0ue46gO4gQyxC8KvyTMHCMn
 QbDA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782978250; x=1783583050; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q5DCRZrF2Pz0cFzKwCFjGiRsP6CvC4heKPnihiP+XIo=;
 b=gx/cr/zhvtq9xMwhZ2x859jSgC38nZwxKKuOSfx0+3H3TsqbpTtHy4lrGe6/IFAhTp
 cOQfEuqZsQTMy6DCI2lgNBia+jq0a/ri1vBNSpJKSi+ahAtTsQm7iMt6lAmBq6bAbwXd
 YOpMlJhs6ah0F9PUSiWcfY7KBj64JhtvzeIeH9tDZRDrALv9v5tcrfA2n82OI0Fx9Vdh
 DatYoZbCDAL4+QaUbnhaIKtETjsJZDwoXIsF7lxnBckoTesdceRMvSJj/PMmbBk2bCOD
 B3Hs7Px45nmkZ9xVGAZOHenXNrzu0Y32aFY2Zs+hHJ2EVBqcXnYmE6SU28CD1NNPa1PZ
 4JTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782978250; x=1783583050;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q5DCRZrF2Pz0cFzKwCFjGiRsP6CvC4heKPnihiP+XIo=;
 b=qQQVL19PiH6UXoDOIZ5P7MLZrdwzbRf2U4mGE5C7G09tTtBxqC0ivy5ArqbjVLRV/f
 n0pO4tiOyQwavLQH+pYpDWeF7FNdkz0IeBsQjdDmS24nivygD+8J08Zrq9RQDLaxf6Xe
 q8k3q9hFGwxkkyKiIqlLwR4WZRqB8nJZke6DMp7xthGRIRUGY0BWkdMknjUKthafCN7h
 qI3OzDdBXDvc+pOASlxsUmUK21u5BuCKl4h+516ihEbVpWOGsaJhfhc5L0mkh1UhvKI6
 EcS9uMacTBJ8ZDqp1xAD9l/Qs9mhqDXZSN7j3pbOm2BsEvAMfOeKs/7az6L7WmVslAt7
 wBQw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoVhVDHXGRm2W2Y9vWW3uT5owtGxJHFcv2H2ruY1vyDNzELnxTbvmXRNGpLVVRr2Cn43T/buPk=@lists.denx.de
X-Gm-Message-State: AOJu0YzVyYnRNrxwTdSDMsSN/3rI3oF4vOaIF/eUyVwVoTAcFYmDr0y4
 XPxY9Jqh13Pm74VbO5UY5DTvE/swoJcpwazPHypgjO60qn+rnzBlMCT3Wn3Is+Zzkkn5YCAZXT4
 EzQOvNxni6IZMCc01HDUQjqUxuG8EM+dzsxth9cwkNg==
X-Gm-Gg: AfdE7ckZnVU5bDyeHtuywcwRoo+oJtxorJN3/gWnWCN8f608BcIhurqNw8SVw2UY4Ag
 mICwZcGqp2PfsaEQgxdRvfKRApMgLne47sWuLMQcZDGLqZM3vORdDCAiaIzXEfN0ju2ZHSN6S1s
 DeMW40z1nqCSHJ1ZQVx7RpOoMmGNJJPWuU23b1LEqnHWlNzS9uSrHSvY98INqQPlnyeog3V+V/p
 8k55TOLJvcI6W12//Qzn+6yCb01OrrSgcSdr0Mu86bhpJB3mU8jJfuEIKctNkZXTsP39GGVEG7v
 WT5aSu35GH57Ihkq8X0WHU9LHg5r/uzTocg+8UD2evVHqh8BtzSNEz7ypN3sOfCjyzoc/oJ4l6Z
 M/Y4C+MjK2yJnQFQtmuN6Qzrr02DfuK9cCJY1WqXghoNvF+FhcxParbAReARsP2e9izao23Uu70
 HgbsmLKB/wtL8NZs2tNiF+9fJ8KMth//ssR6ADupY/e4Gp4U2nuv2qH43ygloHOU4RGxH7vgQ1r
 59sBuyZraRAPUGmqLz/QRo5LbVuiMGjWDGbaBBxBYzBazCJbcG/LG1wLBCZLUMtMdep/q9HKYzF
 RhMASdPln+rsn+DeNo4IE0ixhJ/s29O2Do1vG8u30kcfYBnvG96YRzYHyUdIKRROLIE2EVM=
X-Received: by 2002:a53:b648:0:b0:664:f3f9:c41d with SMTP id
 956f58d0204a3-66521d62cbamr3766574d50.65.1782978249989; Thu, 02 Jul 2026
 00:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
 <20260628082810.175862-7-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260628082810.175862-7-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 2 Jul 2026 10:43:33 +0300
X-Gm-Features: AVVi8CfgVvZkhI3uyrwD1EpfGVRnGuhVPngZnCXR5jGkmXH3WscsvJ99xmNY4Ak
Message-ID: <CAC_iWjKZ6MYMvOZZ560odevd3_L99jhiXHe1Chh+uX8rSPOZwQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] efi_loader: move console-input helpers to
 efi_app_common
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

On Sun, 28 Jun 2026 at 11:28, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Move the shared console-input helpers to efi_app_common:
>
> * efi_drain_input() - drain the console input queue
> * efi_input_yn()    - read a y/n/ESC key from the user
> * efi_input()       - read a UTF-16 string from the console
>
> The common efi_input_yn() calls efi_drain_input() once at entry,
> replacing the open-coded cin->reset() calls that each application
> previously duplicated.
>
> dbginfodump and smbiosdump had no efi_drain_input() call in their
> command loops; add the call so the console queue is drained before
> each prompt, fixing a latent input-echo artefact.
>
> The common state is extended with a cin pointer (initialized by
> efi_app_init from sys_table->con_in) so the helpers can access the
> console-input protocol without additional parameters.
>
> Remove the now-duplicate static definitions from dtbdump, initrddump,
> smbiosdump and dbginfodump.
>
> smbiosdump: fix kernel-doc tag for command_loop() from "command_loop -"
> to "command_loop() -" to follow the kernel-doc convention.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
> v3:
>         actually add drain_input() to dbginfodump
> v2:
>         new patch
> ---
>  lib/efi_loader/dbginfodump.c    |  62 +-----------------
>  lib/efi_loader/dtbdump.c        | 109 --------------------------------
>  lib/efi_loader/efi_app_common.c |  88 ++++++++++++++++++++++++++
>  lib/efi_loader/efi_app_common.h |  29 +++++++++
>  lib/efi_loader/initrddump.c     | 109 --------------------------------
>  lib/efi_loader/smbiosdump.c     | 108 +------------------------------
>  6 files changed, 120 insertions(+), 385 deletions(-)
>
> diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
> index 2dcff2a11fe..b39d47ff9bb 100644
> --- a/lib/efi_loader/dbginfodump.c
> +++ b/lib/efi_loader/dbginfodump.c
> @@ -14,7 +14,6 @@
>  #define BUFFER_SIZE 64
>
>  static struct efi_simple_text_output_protocol *cout;
> -static struct efi_simple_text_input_protocol *cin;
>  static efi_handle_t handle;
>  static struct efi_system_table *systable;
>  static struct efi_boot_services *bs;
> @@ -83,65 +82,6 @@ static void printp(void *p)
>         print(str);
>  }
>
> -/**
> - * efi_input() - read string from console
> - *
> - * @buffer:            input buffer
> - * @buffer_size:       buffer size
> - * Return:             status code
> - */
> -static efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size)
> -{
> -       struct efi_input_key key = {0};
> -       efi_uintn_t index;
> -       efi_uintn_t pos = 0;
> -       u16 outbuf[2] = u" ";
> -       efi_status_t ret;
> -
> -       /* Drain the console input */
> -       ret = cin->reset(cin, true);
> -       *buffer = 0;
> -       for (;;) {
> -               ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
> -               if (ret != EFI_SUCCESS)
> -                       continue;
> -               ret = cin->read_key_stroke(cin, &key);
> -               if (ret != EFI_SUCCESS)
> -                       continue;
> -               switch (key.scan_code) {
> -               case 0x17: /* Escape */
> -                       print(u"\r\nAborted\r\n");
> -                       return EFI_ABORTED;
> -               default:
> -                       break;
> -               }
> -               switch (key.unicode_char) {
> -               case 0x08: /* Backspace */
> -                       if (pos) {
> -                               buffer[pos--] = 0;
> -                               print(u"\b \b");
> -                       }
> -                       break;
> -               case 0x0a: /* Linefeed */
> -               case 0x0d: /* Carriage return */
> -                       print(u"\r\n");
> -                       return EFI_SUCCESS;
> -               default:
> -                       break;
> -               }
> -               /* Ignore surrogate codes */
> -               if (key.unicode_char >= 0xD800 && key.unicode_char <= 0xDBFF)
> -                       continue;
> -               if (key.unicode_char >= 0x20 &&
> -                   pos < buffer_size - 1) {
> -                       *outbuf = key.unicode_char;
> -                       buffer[pos++] = key.unicode_char;
> -                       buffer[pos] = 0;
> -                       print(outbuf);
> -               }
> -       }
> -}
> -
>  /**
>   * skip_whitespace() - skip over leading whitespace
>   *
> @@ -277,7 +217,6 @@ efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
>         handle = image_handle;
>         systable = systab;
>         cout = systable->con_out;
> -       cin = systable->con_in;
>         bs = systable->boottime;
>
>         cout->set_attribute(cout, EFI_LIGHTBLUE | EFI_BACKGROUND_BLACK);
> @@ -298,6 +237,7 @@ efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
>                 u16 *pos;
>                 efi_uintn_t ret;
>
> +               efi_drain_input();
>                 print(u"=> ");
>                 ret = efi_input(command, sizeof(command));
>                 if (ret == EFI_ABORTED)
> diff --git a/lib/efi_loader/dtbdump.c b/lib/efi_loader/dtbdump.c
> index 1468955eb8c..716daf4a90f 100644
> --- a/lib/efi_loader/dtbdump.c
> +++ b/lib/efi_loader/dtbdump.c
> @@ -16,7 +16,6 @@
>
>  #define efi_size_in_pages(size) ((size + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT)
>
> -static struct efi_simple_text_input_protocol *cin;
>  static struct efi_boot_services *bs;
>  static const efi_guid_t fdt_guid = EFI_FDT_GUID;
>  static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
> @@ -50,113 +49,6 @@ static void print_char(unsigned char c)
>         print(out);
>  }
>
> -/**
> - * efi_drain_input() - drain console input
> - */
> -static void efi_drain_input(void)
> -{
> -       cin->reset(cin, true);
> -}
> -
> -/**
> - * efi_input_yn() - get answer to yes/no question
> - *
> - * Return:
> - * y or Y
> - *     EFI_SUCCESS
> - * n or N
> - *     EFI_ACCESS_DENIED
> - * ESC
> - *     EFI_ABORTED
> - */
> -static efi_status_t efi_input_yn(void)
> -{
> -       struct efi_input_key key = {0};
> -       efi_uintn_t index;
> -       efi_status_t ret;
> -
> -       for (;;) {
> -               ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
> -               if (ret != EFI_SUCCESS)
> -                       continue;
> -               ret = cin->read_key_stroke(cin, &key);
> -               if (ret != EFI_SUCCESS)
> -                       continue;
> -               switch (key.scan_code) {
> -               case 0x17: /* Escape */
> -                       return EFI_ABORTED;
> -               default:
> -                       break;
> -               }
> -               /* Convert to lower case */
> -               switch (key.unicode_char | 0x20) {
> -               case 'y':
> -                       return EFI_SUCCESS;
> -               case 'n':
> -                       return EFI_ACCESS_DENIED;
> -               default:
> -                       break;
> -               }
> -       }
> -}
> -
> -/**
> - * efi_input() - read string from console
> - *
> - * @buffer:            input buffer
> - * @buffer_size:       buffer size
> - * Return:             status code
> - */
> -static efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size)
> -{
> -       struct efi_input_key key = {0};
> -       efi_uintn_t index;
> -       efi_uintn_t pos = 0;
> -       u16 outbuf[2] = u" ";
> -       efi_status_t ret;
> -
> -       *buffer = 0;
> -       for (;;) {
> -               ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
> -               if (ret != EFI_SUCCESS)
> -                       continue;
> -               ret = cin->read_key_stroke(cin, &key);
> -               if (ret != EFI_SUCCESS)
> -                       continue;
> -               switch (key.scan_code) {
> -               case 0x17: /* Escape */
> -                       print(u"\r\nAborted\r\n");
> -                       return EFI_ABORTED;
> -               default:
> -                       break;
> -               }
> -               switch (key.unicode_char) {
> -               case 0x08: /* Backspace */
> -                       if (pos) {
> -                               buffer[pos--] = 0;
> -                               print(u"\b \b");
> -                       }
> -                       break;
> -               case 0x0a: /* Linefeed */
> -               case 0x0d: /* Carriage return */
> -                       print(u"\r\n");
> -                       return EFI_SUCCESS;
> -               default:
> -                       break;
> -               }
> -               /* Ignore surrogate codes */
> -               if (key.unicode_char >= 0xD800 && key.unicode_char <= 0xDBFF)
> -                       continue;
> -               if (key.unicode_char >= 0x20 &&
> -                   pos < buffer_size - 1) {
> -                       *outbuf = key.unicode_char;
> -                       buffer[pos++] = key.unicode_char;
> -                       buffer[pos] = 0;
> -                       print(outbuf);
> -               }
> -       }
> -}
> -
>  /*
>   * Convert FDT value to host endianness.
>   *
> @@ -702,7 +594,6 @@ efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
>
>         handle = image_handle;
>         systable = systab;
> -       cin = systable->con_in;
>         bs = systable->boottime;
>
>         color(EFI_LIGHTBLUE);
> diff --git a/lib/efi_loader/efi_app_common.c b/lib/efi_loader/efi_app_common.c
> index e9e9334acc7..406cd236f6f 100644
> --- a/lib/efi_loader/efi_app_common.c
> +++ b/lib/efi_loader/efi_app_common.c
> @@ -9,6 +9,7 @@
>  #include "efi_app_common.h"
>
>  static efi_handle_t app_handle;
> +static struct efi_simple_text_input_protocol *cin;
>  static struct efi_simple_text_output_protocol *cout;
>  struct efi_boot_services *bs;
>  static bool nocolor;
> @@ -40,6 +41,7 @@ void efi_app_init(struct efi_system_table *sys_table, efi_handle_t image_handle)
>
>         app_handle = image_handle;
>         systable = sys_table;
> +       cin = sys_table->con_in;
>         cout = sys_table->con_out;
>         bs = sys_table->boottime;
>
> @@ -104,3 +106,89 @@ bool starts_with(u16 *string, u16 *keyword)
>         }
>         return true;
>  }
> +
> +void efi_drain_input(void)
> +{
> +       cin->reset(cin, true);
> +}
> +
> +efi_status_t efi_input_yn(void)
> +{
> +       struct efi_input_key key = { 0 };
> +       efi_uintn_t index;
> +       efi_status_t ret;
> +
> +       efi_drain_input();
> +       for (;;) {
> +               ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
> +               if (ret != EFI_SUCCESS)
> +                       continue;
> +               ret = cin->read_key_stroke(cin, &key);
> +               if (ret != EFI_SUCCESS)
> +                       continue;
> +               switch (key.scan_code) {
> +               case 0x17: /* Escape */
> +                       return EFI_ABORTED;
> +               default:
> +                       break;
> +               }
> +               /* Convert to lower case */
> +               switch (key.unicode_char | 0x20) {
> +               case 'y':
> +                       return EFI_SUCCESS;
> +               case 'n':
> +                       return EFI_ACCESS_DENIED;
> +               default:
> +                       break;
> +               }
> +       }
> +}
> +
> +efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size)
> +{
> +       struct efi_input_key key = { 0 };
> +       efi_uintn_t index;
> +       efi_uintn_t pos = 0;
> +       u16 outbuf[2] = u" ";
> +       efi_status_t ret;
> +
> +       *buffer = 0;
> +       for (;;) {
> +               ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
> +               if (ret != EFI_SUCCESS)
> +                       continue;
> +               ret = cin->read_key_stroke(cin, &key);
> +               if (ret != EFI_SUCCESS)
> +                       continue;
> +               switch (key.scan_code) {
> +               case 0x17: /* Escape */
> +                       print(u"\r\nAborted\r\n");
> +                       return EFI_ABORTED;
> +               default:
> +                       break;
> +               }
> +               switch (key.unicode_char) {
> +               case 0x08: /* Backspace */
> +                       if (pos) {
> +                               buffer[pos--] = 0;
> +                               print(u"\b \b");
> +                       }
> +                       break;
> +               case 0x0a: /* Linefeed */
> +               case 0x0d: /* Carriage return */
> +                       print(u"\r\n");
> +                       return EFI_SUCCESS;
> +               default:
> +                       break;
> +               }
> +               /* Ignore surrogate codes */
> +               if (key.unicode_char >= 0xD800 && key.unicode_char <= 0xDBFF)
> +                       continue;
> +               if (key.unicode_char >= 0x20 && pos < buffer_size - 1) {
> +                       *outbuf = key.unicode_char;
> +                       buffer[pos++] = key.unicode_char;
> +                       buffer[pos] = 0;
> +                       print(outbuf);
> +               }
> +       }
> +}
> diff --git a/lib/efi_loader/efi_app_common.h b/lib/efi_loader/efi_app_common.h
> index 45c17a8ed99..4498607ef07 100644
> --- a/lib/efi_loader/efi_app_common.h
> +++ b/lib/efi_loader/efi_app_common.h
> @@ -64,4 +64,33 @@ void error(u16 *string);
>   */
>  bool starts_with(u16 *string, u16 *keyword);
>
> +/**
> + * efi_drain_input() - drain console input
> + */
> +void efi_drain_input(void);
> +
> +/**
> + * efi_input_yn() - get answer to yes/no question
> + *
> + * Drains the console input before reading.
> + *
> + * Return:
> + * y or Y
> + *     EFI_SUCCESS
> + * n or N
> + *     EFI_ACCESS_DENIED
> + * ESC
> + *     EFI_ABORTED
> + */
> +efi_status_t efi_input_yn(void);
> +
> +/**
> + * efi_input() - read string from console
> + *
> + * @buffer:             input buffer
> + * @buffer_size:        buffer size
> + * Return:              status code
> + */
> +efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size);
> +
>  #endif /* _EFI_APP_COMMON_H */
> diff --git a/lib/efi_loader/initrddump.c b/lib/efi_loader/initrddump.c
> index 60f8a020e8c..52562be048d 100644
> --- a/lib/efi_loader/initrddump.c
> +++ b/lib/efi_loader/initrddump.c
> @@ -19,7 +19,6 @@
>
>  static struct efi_system_table *systable;
>  static struct efi_boot_services *bs;
> -static struct efi_simple_text_input_protocol *cin;
>  static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
>  static const efi_guid_t guid_simple_file_system_protocol =
>                                         EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
> @@ -46,113 +45,6 @@ static const struct efi_lo_dp_prefix initrd_dp = {
>         }
>  };
>
> -/**
> - * efi_drain_input() - drain console input
> - */
> -static void efi_drain_input(void)
> -{
> -       cin->reset(cin, true);
> -}
> -
> -/**
> - * efi_input_yn() - get answer to yes/no question
> - *
> - * Return:
> - * y or Y
> - *     EFI_SUCCESS
> - * n or N
> - *     EFI_ACCESS_DENIED
> - * ESC
> - *     EFI_ABORTED
> - */
> -static efi_status_t efi_input_yn(void)
> -{
> -       struct efi_input_key key = {0};
> -       efi_uintn_t index;
> -       efi_status_t ret;
> -
> -       for (;;) {
> -               ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
> -               if (ret != EFI_SUCCESS)
> -                       continue;
> -               ret = cin->read_key_stroke(cin, &key);
> -               if (ret != EFI_SUCCESS)
> -                       continue;
> -               switch (key.scan_code) {
> -               case 0x17: /* Escape */
> -                       return EFI_ABORTED;
> -               default:
> -                       break;
> -               }
> -               /* Convert to lower case */
> -               switch (key.unicode_char | 0x20) {
> -               case 'y':
> -                       return EFI_SUCCESS;
> -               case 'n':
> -                       return EFI_ACCESS_DENIED;
> -               default:
> -                       break;
> -               }
> -       }
> -}
> -
> -/**
> - * efi_input() - read string from console
> - *
> - * @buffer:            input buffer
> - * @buffer_size:       buffer size
> - * Return:             status code
> - */
> -static efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size)
> -{
> -       struct efi_input_key key = {0};
> -       efi_uintn_t index;
> -       efi_uintn_t pos = 0;
> -       u16 outbuf[2] = u" ";
> -       efi_status_t ret;
> -
> -       *buffer = 0;
> -       for (;;) {
> -               ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
> -               if (ret != EFI_SUCCESS)
> -                       continue;
> -               ret = cin->read_key_stroke(cin, &key);
> -               if (ret != EFI_SUCCESS)
> -                       continue;
> -               switch (key.scan_code) {
> -               case 0x17: /* Escape */
> -                       print(u"\r\nAborted\r\n");
> -                       return EFI_ABORTED;
> -               default:
> -                       break;
> -               }
> -               switch (key.unicode_char) {
> -               case 0x08: /* Backspace */
> -                       if (pos) {
> -                               buffer[pos--] = 0;
> -                               print(u"\b \b");
> -                       }
> -                       break;
> -               case 0x0a: /* Linefeed */
> -               case 0x0d: /* Carriage return */
> -                       print(u"\r\n");
> -                       return EFI_SUCCESS;
> -               default:
> -                       break;
> -               }
> -               /* Ignore surrogate codes */
> -               if (key.unicode_char >= 0xD800 && key.unicode_char <= 0xDBFF)
> -                       continue;
> -               if (key.unicode_char >= 0x20 &&
> -                   pos < buffer_size - 1) {
> -                       *outbuf = key.unicode_char;
> -                       buffer[pos++] = key.unicode_char;
> -                       buffer[pos] = 0;
> -                       print(outbuf);
> -               }
> -       }
> -}
> -
>  /**
>   * skip_whitespace() - skip over leading whitespace
>   *
> @@ -356,7 +248,6 @@ efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
>
>         handle = image_handle;
>         systable = systab;
> -       cin = systable->con_in;
>         bs = systable->boottime;
>
>         color(EFI_WHITE);
> diff --git a/lib/efi_loader/smbiosdump.c b/lib/efi_loader/smbiosdump.c
> index e19214d798f..100e03294e5 100644
> --- a/lib/efi_loader/smbiosdump.c
> +++ b/lib/efi_loader/smbiosdump.c
> @@ -15,7 +15,6 @@
>
>  #define BUFFER_SIZE 64
>
> -static struct efi_simple_text_input_protocol *cin;
>  static struct efi_boot_services *bs;
>  static efi_handle_t handle;
>  static struct efi_system_table *systable;
> @@ -26,109 +25,6 @@ static const efi_guid_t guid_simple_file_system_protocol =
>                                         EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
>  static const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
>
> -/**
> - * efi_input_yn() - get answer to yes/no question
> - *
> - * Return:
> - * y or Y
> - *     EFI_SUCCESS
> - * n or N
> - *     EFI_ACCESS_DENIED
> - * ESC
> - *     EFI_ABORTED
> - */
> -static efi_status_t efi_input_yn(void)
> -{
> -       struct efi_input_key key = {0};
> -       efi_uintn_t index;
> -       efi_status_t ret;
> -
> -       /* Drain the console input */
> -       ret = cin->reset(cin, true);
> -       for (;;) {
> -               ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
> -               if (ret != EFI_SUCCESS)
> -                       continue;
> -               ret = cin->read_key_stroke(cin, &key);
> -               if (ret != EFI_SUCCESS)
> -                       continue;
> -               switch (key.scan_code) {
> -               case 0x17: /* Escape */
> -                       return EFI_ABORTED;
> -               default:
> -                       break;
> -               }
> -               /* Convert to lower case */
> -               switch (key.unicode_char | 0x20) {
> -               case 'y':
> -                       return EFI_SUCCESS;
> -               case 'n':
> -                       return EFI_ACCESS_DENIED;
> -               default:
> -                       break;
> -               }
> -       }
> -}
> -
> -/**
> - * efi_input() - read string from console
> - *
> - * @buffer:            input buffer
> - * @buffer_size:       buffer size
> - * Return:             status code
> - */
> -static efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size)
> -{
> -       struct efi_input_key key = {0};
> -       efi_uintn_t index;
> -       efi_uintn_t pos = 0;
> -       u16 outbuf[2] = u" ";
> -       efi_status_t ret;
> -
> -       /* Drain the console input */
> -       ret = cin->reset(cin, true);
> -       *buffer = 0;
> -       for (;;) {
> -               ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
> -               if (ret != EFI_SUCCESS)
> -                       continue;
> -               ret = cin->read_key_stroke(cin, &key);
> -               if (ret != EFI_SUCCESS)
> -                       continue;
> -               switch (key.scan_code) {
> -               case 0x17: /* Escape */
> -                       print(u"\r\nAborted\r\n");
> -                       return EFI_ABORTED;
> -               default:
> -                       break;
> -               }
> -               switch (key.unicode_char) {
> -               case 0x08: /* Backspace */
> -                       if (pos) {
> -                               buffer[pos--] = 0;
> -                               print(u"\b \b");
> -                       }
> -                       break;
> -               case 0x0a: /* Linefeed */
> -               case 0x0d: /* Carriage return */
> -                       print(u"\r\n");
> -                       return EFI_SUCCESS;
> -               default:
> -                       break;
> -               }
> -               /* Ignore surrogate codes */
> -               if (key.unicode_char >= 0xD800 && key.unicode_char <= 0xDBFF)
> -                       continue;
> -               if (key.unicode_char >= 0x20 &&
> -                   pos < buffer_size - 1) {
> -                       *outbuf = key.unicode_char;
> -                       buffer[pos++] = key.unicode_char;
> -                       buffer[pos] = 0;
> -                       print(outbuf);
> -               }
> -       }
> -}
> -
>  /**
>   * skip_whitespace() - skip over leading whitespace
>   *
> @@ -467,7 +363,7 @@ static efi_status_t do_save(u16 *filename)
>  }
>
>  /**
> - * command_loop - process user commands
> + * command_loop() - process user commands
>   */
>  static void command_loop(void)
>  {
> @@ -476,6 +372,7 @@ static void command_loop(void)
>                 u16 *pos;
>                 efi_uintn_t ret;
>
> +               efi_drain_input();
>                 print(u"=> ");
>                 ret = efi_input(command, sizeof(command));
>                 if (ret == EFI_ABORTED)
> @@ -509,7 +406,6 @@ efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
>
>         handle = image_handle;
>         systable = systab;
> -       cin = systable->con_in;
>         bs = systable->boottime;
>
>         color(EFI_WHITE);
> --
> 2.53.0
>
