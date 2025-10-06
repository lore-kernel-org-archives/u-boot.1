Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD338CCA470
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 20:38:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FAEC83C6E;
	Mon,  6 Oct 2025 22:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MJIGNNWN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EAC883D3C; Mon,  6 Oct 2025 22:38:31 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2268F83C46
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 22:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-631df7b2dffso12487239a12.1
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 13:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759783108; x=1760387908; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OZQ69eEX4cqTXuN+ztPwzSmArcsyuTnB4QRfcH3CiF8=;
 b=MJIGNNWNJTQo7dUdYInGanceEPg8I9+f1S3gj3hbquyHrRdmgNMIUgQbSB4NrNtwXr
 9JWpgwN9ASIv7t3LJkv2BgafZP7dWerg85L9OXlGrFQbNt9O8G1mfsNSYYj2LsnxKdhj
 zLU+i6HBVwrERDzAEQGbEencwM6EGqQh2sEkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759783108; x=1760387908;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OZQ69eEX4cqTXuN+ztPwzSmArcsyuTnB4QRfcH3CiF8=;
 b=n16A/bhkVwU15uux/wolrI33Naa+R+WsMa26jhR4NTQ81g3eZONvzsSNxPpfH/M4/f
 nzsgDVli8blpJJJxLLeIeVI/zJpP1s7/fJm6skmIhTQrPVE4WiPRhRR2B0RH7DA7wSnZ
 TJJXN6zIN4lNWm0661Y1MJqZMI2JQqS2FYEqOTIglmznW0wCqXG/ZQj+GNuovrxL59rh
 4u8zRI3YJJN0txbbv89vPfGjRHHm73CQxbcjfqSgXbqBKW+eO9Mg6owys5jqCOrVzUFE
 Sib2VR6XfIXltyXmwJ0Ccd1NIPbdwKbMQ+jEODQxQLfIzYegcB4Glr/NpTxllpaiGn0e
 gDbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgYgyXHy2Mv/qs/ZexZkGjtBhSYcAmc4ljdVQZmlff1HLcaurIMPCBOIteeuyeS0nU7PrxNds=@lists.denx.de
X-Gm-Message-State: AOJu0YzX2qLhA1+EsYXkUgZzBpA5l7ap55OHu0TcyNLk+cydfWjKWt7v
 au91SaOTCLVGyo5/8uN312zc0wEr8cvXixzTuuoXNWm4bCHA8ao1HSY9MvO8XPqtdaXpueztcT6
 Ovjpa3fPt3BbyXISk3zoMPnaJQVeWXOyGG+5401t2
X-Gm-Gg: ASbGnct/9/n8tXs2FLmIcYNpe9qMQ9xQGM7Wh4+7/Vi4cOLsPzXB25qUwnCJTOgFZYO
 mqzvjBqYrU3yFWc3h3wXAATapKff2rT0cDuG/p3cEbuTlSvEeuE1Cy1AjlnetC3yKowG23T2D5l
 2wSox5lH+3QHNGAOeqbL/Xz8hXqVe7AX8uGuREtznFPVcVYez0XxDUwvPajkl12NjI1cBsfe9MA
 e3AOWt6B0NnSMeqAveFKEn/pfb+JHWt1IXpoWgRwLw=
X-Google-Smtp-Source: AGHT+IGFnnL6n7Lft+KBa2Hgv0RZWM3LcxpoPMETQ9RWH3w7EvLLQVxHgg7wQ0NfD2q0sgN83uw3bsuvaMeLKjOjW2c=
X-Received: by 2002:a05:6402:510e:b0:633:ddd4:4e37 with SMTP id
 4fb4d7f45d1cf-639bb13493fmr999321a12.13.1759783108530; Mon, 06 Oct 2025
 13:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20251006133903.58357-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251006133903.58357-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Oct 2025 14:38:15 -0600
X-Gm-Features: AS18NWDMACLXHJRHU9rQrBgFeHiiSB5Qzfr_wmj_oCzrJV1-kuN8rpi3WYU5St0
Message-ID: <CAFLszThOssxWF3ScW3MhhfzxY6MuOMuXeFbpN32ee_xDBzYaKw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: correctly check if the HTTP protocol is
 found
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
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

On Mon, 6 Oct 2025 at 07:39, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> In function efi_http_service_binding_destroy_child() phandler is created as
> as a local variable. If efi_search_protocol() fails, phandler will hold a
> random value from the stack. Even it is not zero, we must not use it.
>
> If efi_search_protocol() succeeds, the pointer has already be dereferenced,
> so checking against NULL makes not sense here.
>
> If ChildHandle is not a valid UEFI handle, we must return
> EFI_INVALID_PARAMETER.
>
> Use a single location for EFI_EXIT().
>
> Addresses-Coverity-ID: CID 531974 (Unchecked return value)
> Fixes: 5753dc3f6572 ("efi_loader: Prevent dereference of uninitialised variable")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_http.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
