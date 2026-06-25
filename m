Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57C8CDE002
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 08:54:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4820484981;
	Thu, 25 Jun 2026 10:54:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jzH2ewhX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C299B84981; Thu, 25 Jun 2026 10:54:44 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA698846F4
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c07ea058c1aso268506866b.2
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 01:54:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782377682; cv=none;
 d=google.com; s=arc-20260327;
 b=h4BXk1n2EpnN9FOaUcPqE0nco5ig6I4nwo5P6gFJxcGloIWOtDTPLZlBpgho+MxmXn
 EAmeMAK2NLR8l3RpVFDecIQitx4Jd/4XEsRSz9p8YrAcR0bol7/2YIoPo/izqjqFx9f0
 PaYJf3vqlGfu1HnXhvFdq5biWDT9YayoXTGaTzS4fWbPnjor7cgUOwBmB9R1c7kpKn5v
 ev4eqqa5QEUtzFxwWnDtXhvls962Hn39ooJw5KYMVK3kj/eqAzcVwt29fxTPHOsjBdRr
 iFHG2I584iIuve+iSz3L1Qag+T+HJtvWq6WA/wMtx/3iEJcuz0qNZvi/96c/QL1jjU7T
 v67g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=axBPk/B+mAPGU2nvAotvK7xiPqGWfuHhFpmblLbxoos=;
 fh=N329o0+WNi3gsUp1Dez6W/3snJ5w8E/W+IhF1lZLJVs=;
 b=WM86Ng4Mv3ZHfelDoYx1mhmcm9iKSS10sVSU4FXQ3fT7zQAq3AFNfHYkQTKOzWO5Uc
 jhG9TUdB2zbWic+hrbhJ6lR/6GZNCwIitJT2jJgjw6uVTEE3oUBsZmYFjm6VQHJ1t8EV
 YJ4Mc302LR/tydqnVZU42kZ4AJdXZGrrVdliHi6+70SEiVVoWj6yQ0376mU4txreeHk5
 gtbBUJE70vDisWEKkLdMEYKIEFEiWUBlRso6LZIL0L//+rML6f6vmNkkxK66jEWOYCUi
 Hf5Frsd1rUbOLBx0WOeno4Jao+pP6itA4OVeDIVdPHxJ6TgsJY17Li/X3M/kXJiMODG/
 FYGw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782377682; x=1782982482; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=axBPk/B+mAPGU2nvAotvK7xiPqGWfuHhFpmblLbxoos=;
 b=jzH2ewhX+iXmFYBsj9RKr+RtKCyWTlM/Ip1EGDtFcznT3yqdBMqfoisrsaPykC4QJH
 ohogzEo95yMbTOaRT86igv0UfWo+UAmfpaYDgb5v4H9sJja4WHRYkjhAI0EBIcA10oDU
 kwAVUt7FdE9XwqZuqxnSF+wuwNOe5mOF0EXa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782377682; x=1782982482;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axBPk/B+mAPGU2nvAotvK7xiPqGWfuHhFpmblLbxoos=;
 b=afbGWjnJStrHfoYSkQ+TSnf4eDU5n9gesD9IMe0hEiYDumPjPZYcfXvD8TT2TnCrBH
 6fNbbVlFIElFXPjV0qbkrSFSg1XzEJkuxfQvJSln1B6PvKal6HIunzmJ2QR5HDktFccA
 Gzat8bz8ZSvs86l9rxCvI81g1AqoaZzzeeL9RbF72+yV4bnxA+bbPmhPygU4yIRLIfaO
 naDSX1HNyAuBQxsp7DW6ZixhjDkyQG5U3iu1U4c/IVu8QaIQCbUnZq3Nb3NryoT0mXjx
 AFBJXYespbYkDjpwj5kPa5Eu17vrUOliVoURHOD9Fw0t9c/IyMQpFfijdeb3kSZXDz6h
 ghPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMsjDdUXGiP6bLOIjL9b1r7X4hEqLyeXjNIKMNxbYz0AMo5QnSu4MryVkXUibbsOQ1tpj6xN0=@lists.denx.de
X-Gm-Message-State: AOJu0YxFr2eaoSR886AWINCMzvE9THVSH6EROcWHvfukZdL5gRM8BE7Q
 t50M+0JB/snW4gzzLiKUmfUNoIPjHYqscwljRalLbaXUdXINI30b82P3t23PvoU0MpFh6XQ2ZR2
 Q9ZnvoteWBbv7eWzfkI/IAA+7021dCWCdLTTw+tw/
X-Gm-Gg: AfdE7clQ10mu7ZrF2VGwLaDyMZH7oKC7LEXD/ZVh1W7CoMuDQqPPrlRnjEgoj0zWCqy
 ZFJ3CZGbU9JvuZw6LteZg4KPMIkq7X/IlXHAMrGJXfoSnnfGbd7Ow1LMQuTIxz4cp+oCL31BiKO
 ofiksSJ/z/jH4FWBeRBT3kdWIvkS92FK48jYJAVa4saicy+wVeQ5/lkWlWL9Z05E2WAIcxf47Bc
 k/Cj9n/sfYexwC9DrihaapNzov16b6EP1XdnJiOedupgE2asayjl9W+wyI0jiq9aXb+LXCiXg==
X-Received: by 2002:a17:906:6206:b0:c12:db:3062 with SMTP id
 a640c23a62f3a-c1205f15deamr87897766b.35.1782377682060; Thu, 25 Jun 2026
 01:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
 <20260621081915.19154-7-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260621081915.19154-7-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 09:54:03 +0100
X-Gm-Features: AVVi8CcZ37SWqVYFAOBdJEKeECPJy7-XAfXWDCvPknJvCyR6azfp_RmOxrfHFig
Message-ID: <CAFLszTjyf2u2oNMGVdpQv1pEo5Y0APOkwkgBiV0_RiZfS+9q0g@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] efi_loader: move console-input helpers to
 efi_app_common
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
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

Hi Heinrich,

On 2026-06-21T08:19:04, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> efi_loader: move console-input helpers to efi_app_common
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
> [...]
>
> lib/efi_loader/dbginfodump.c    |  61 ----------------------
>  lib/efi_loader/dtbdump.c        | 109 ----------------------------------------
>  lib/efi_loader/efi_app_common.c |  88 ++++++++++++++++++++++++++++++++
>  lib/efi_loader/efi_app_common.h |  29 +++++++++++
>  lib/efi_loader/initrddump.c     | 109 ----------------------------------------
>  lib/efi_loader/smbiosdump.c     | 108 +--------------------------------------
>  6 files changed, 119 insertions(+), 385 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

thoughts below

> diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
> @@ -277,7 +217,6 @@ efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
>       handle = image_handle;
>       systable = systab;
>       cout = systable->con_out;
> -     cin = systable->con_in;
>       bs = systable->boottime;

The commit message says efi_drain_input() is added to dbginfodump and
smbiosdump command loops, but only smbiosdump's command_loop() gets it
- dbginfodump's efi_main() loop does not. On top of that, the old
dbginfodump efi_input() opened with cin->reset(cin, true); the new
common efi_input() does not drain at entry, so this patch silently
removes drain-on-input from dbginfodump. Please add efi_drain_input()
to dbginfodump's command loop too, or update the commit message.

> diff --git a/lib/efi_loader/efi_app_common.c b/lib/efi_loader/efi_app_common.c
> @@ -104,3 +106,89 @@ bool starts_with(u16 *string, u16 *keyword)
> +efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size)
> +{
> +     struct efi_input_key key = { 0 };
> +     efi_uintn_t index;
> +     efi_uintn_t pos = 0;
> +     u16 outbuf[2] = u" ";
> +     efi_status_t ret;
> +
> +     *buffer = 0;

efi_input_yn() drains at entry but efi_input() does not - easy to trip
over later. Either drain inside efi_input() too (matching the old
dbginfodump/smbiosdump versions), or document in the header that
callers must drain themselves. What do you think?

Regards,
Simon
