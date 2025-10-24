Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748C3CCD1A5
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 10:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6652835B3;
	Fri, 24 Oct 2025 12:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kD2yvlGO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1406835FE; Fri, 24 Oct 2025 12:51:42 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 433D98334F
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 12:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-783fa3aa582so23086467b3.3
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 03:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761303099; x=1761907899; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lKEzp4rs4XVwAhlIVo7f1RNunEb3mozDCpvqmzede4I=;
 b=kD2yvlGOh/dAV84nEIvbWefJpRWCzKVbFKNua5yYv0Qrh0JFc7Xxu7Y04M5NURADuj
 zMUu6eAHttSqPvsZ9eetKsPbRT7DOjK+mV1AQXTbKUPXnDHgSm6tSTCyiHjpZGW5hzzY
 tW5Hvz6YTLKt+GYYjkXrGtGmHp10l71ZKgn6a+v8ut2q3kvUwxzuPzXZq1lTFDtSfMkO
 3wZb6vJqo3GzlCVXabMX/tlXSeG0i82MLCASmMr1caWoovjDcJ6md+mzyyFjr61BfpTj
 9rXjLHte5bs7h/1Jv4MPsnbU0DVjL8/EFrXRNogS7uS6lb8hTQ0zh+1Rv/Ssr4+fUyaD
 jKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761303099; x=1761907899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lKEzp4rs4XVwAhlIVo7f1RNunEb3mozDCpvqmzede4I=;
 b=Af7or3nCMtud8vFg4riymnJExypx5sW3QYUtPqga8Yj/gtYgjm7W94lS0FRwAVYQ26
 VzNiqHiul6AOpU5Hyhe5BD61or+xDMXnH4jx5k34O0md1EECaSBvkrRpSKb9qhQLFRvc
 +LhyHXhxUOpURtTtCRF6CePLVHJv50FvnQZnvx+1Hw7AywixTOtDdd7QhKMKzyInSOJA
 RrP/F2jIgXwYgzWhpujgLy4v9gFsEOA6pfsBhH7jpEvyLPHlRvDJ3ukQvTMmL5i6JhqM
 aekCACDl8w/Tmax2pPdesKMjYaE1kOHXIJ72EP3Ix9YpfP9EEXZyMTLDrV8/HNLDFBI4
 qPbw==
X-Gm-Message-State: AOJu0Ywi2srqqPxLQEEkjFTGTQM8QQMFHO+JVuHhMGsVLOowqCMdnVfs
 XyPD5O2hH42Ah6lVw2/Uz0vHXTlAcDTv+YvXiS04xJxktIh791zjuYvNMkh9MiCuZnomNzrhh+k
 zG9zIlcm6aEAaSlfq9ZmKoHILoEnCJZeiU57BmIRoqQ==
X-Gm-Gg: ASbGncuVOWq21cHvwoRMnp/dHWbjPCb16GcJszz1uiFLzrXgtHKaRDj74mGb/nhf7EA
 ofG2kPiooJAaXev26TJF76Gbo+6JMYsg/0XXQPfjfnjaT27z1IjP3v+TyM0f2zS44wwo2Y0vnvs
 JCLRYKyCh79EiTl5WfbkAgm9CwalPEeMYsnhmL1QmIEIzUE2nD727BPB1gkBYwSmBj6rDsN57Zc
 RZ5Ko8Kesnq7pBwN1whsjtnNp83Fi1lyz+ub7Gn3OKN3a+pHgz96non2ct/7jVv2Wgke1FKrwWg
 PUx7FdG1AVMgZotxjozthn2x5rpKxamrlu4FUaMm7/6CTTs79CQ=
X-Google-Smtp-Source: AGHT+IEh89f8cHBcGOVZ9myIExyE+5Ix8yf6rorWBKlfA15CPH3MBWwqyAuN5ra31ED2vd3na/He4nq/n6L/nkjgLUU=
X-Received: by 2002:a05:690c:6ac8:b0:785:e65c:be1d with SMTP id
 00721157ae682-785e65cbe42mr4914107b3.26.1761303098811; Fri, 24 Oct 2025
 03:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20251023-eficonfig-ux-improvements-v1-0-f5fc93b126ed@linaro.org>
 <20251023-eficonfig-ux-improvements-v1-2-f5fc93b126ed@linaro.org>
In-Reply-To: <20251023-eficonfig-ux-improvements-v1-2-f5fc93b126ed@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 24 Oct 2025 13:51:01 +0300
X-Gm-Features: AS18NWB9gh01nZ6GDkTlRkMyTbi0H7iVOJxjbK_vvqeS1C3_6Rjp_5Q-wjzjeEQ
Message-ID: <CAC_iWjJFaBkZrs99YOVFaiS0-eT4YD432c0cdJkzjvM+9CpR4g@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi_loader: efi_console: jump to prev/next word with
 ctrl+arrow
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
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

Hi Casey,


On Thu, 23 Oct 2025 at 17:26, Casey Connolly <casey.connolly@linaro.org> wrote:
>
> Extend the previous improvements to efi_console_get_u16_string() by also
> implementing support for jumping to the previous/next word by holding
> ctrl when pressing left/right arrow.
>
> This unfortunately can't be handled with only the basic text input
> protocol, so for now hackily look at the internal state of the efi
> console to read the modifier keys.

Do you mind if we only pull the editing improvements. The command line
isnt going to be huge so keeping the implementation a bit cleaner and
only support left/right shouldn't be much of a burden

Cheers
/Ilias
>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  lib/efi_loader/efi_console.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
> index 7bfd18233feb..87de38a26569 100644
> --- a/lib/efi_loader/efi_console.c
> +++ b/lib/efi_loader/efi_console.c
> @@ -1387,8 +1387,9 @@ efi_status_t efi_console_get_u16_string(struct efi_simple_text_input_protocol *c
>         efi_uintn_t len;
>         efi_uintn_t cursor;
>         efi_uintn_t i;
>         struct efi_input_key key;
> +       struct efi_key_state key_state;
>
>         printf(ANSI_CURSOR_POSITION
>                ANSI_CLEAR_LINE_TO_END
>                ANSI_CURSOR_SHOW, row, col);
> @@ -1401,10 +1402,18 @@ efi_status_t efi_console_get_u16_string(struct efi_simple_text_input_protocol *c
>                 printf(ANSI_CURSOR_POSITION "%ls"
>                        ANSI_CLEAR_LINE_TO_END ANSI_CURSOR_POSITION,
>                        row, col, buf, row, col + (int)cursor);
>                 do {
> +                       /*
> +                        * FIXME: we would ideally just use the proper extension protocol but we
> +                        * can't easily get a handle to it... Since this is only called
> +                        * internally we can be cheeky and access the internal state.
> +                        */
>                         ret = EFI_CALL(cin->read_key_stroke(cin, &key));
> -                       mdelay(10);
> +                       if (ret == EFI_SUCCESS)
> +                               key_state = next_key.key_state;
> +                       else
> +                               mdelay(10);
>                 } while (ret == EFI_NOT_READY);
>
>                 if (key.unicode_char == u'\b') {
>                         if (cursor > 0) {
> @@ -1429,11 +1438,17 @@ efi_status_t efi_console_get_u16_string(struct efi_simple_text_input_protocol *c
>                 } else if (key.unicode_char == 0x3 || key.scan_code == 23) {
>                         return EFI_ABORTED;
>                 } else if (key.scan_code == 3) { /* Right arrow */
>                         cursor += (cursor < len) ? 1 : 0;
> +                       while (key_state.key_shift_state & EFI_LEFT_CONTROL_PRESSED &&
> +                              cursor < len && buf[cursor] != u' ' && buf[cursor] != u'.')
> +                               cursor++;
>                         continue;
>                 } else if (key.scan_code == 4) { /* Left arrow */
>                         cursor -= (cursor > 0) ? 1 : 0;
> +                       while (key_state.key_shift_state & EFI_LEFT_CONTROL_PRESSED &&
> +                              cursor > 0 && buf[cursor - 1] != u' ' && buf[cursor - 1] != u'.')
> +                               cursor--;
>                         continue;
>                 } else if (key.scan_code == 6) { /* End */
>                         cursor = len;
>                         continue;
>
> --
> 2.51.0
>
