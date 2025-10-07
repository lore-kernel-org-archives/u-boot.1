Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F26ECCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 06:44:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 812FA8323A;
	Tue,  7 Oct 2025 08:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NeqIniXT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B691183631; Tue,  7 Oct 2025 08:44:15 +0200 (CEST)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3636809A5
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 08:44:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-638d01a8719so6216226d50.2
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 23:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759819451; x=1760424251; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+UNwrqgacbnH3eZMWxNAKMJho3HBcXdDGRsXT39Hxz0=;
 b=NeqIniXTVBsgBpnzRKX8nap1vNh7laOHIOgkW2zQs0niKztyMjJ3KRYis5+EONFjlz
 RMsjNoryXpZFlXEFPjKdcfcs/Xk4Wej8A+BXRQzNQs9Yn+oiqPpHxVGuT8cHhz7CmlTP
 lbo7FFB+yaKDaaX39G//NNhzPVxxY/lk3PFl+qtIZ9Du3vTsm0Vw5egzKTpUJvsudnw1
 dVf6yLZl+VzaQDtLyCvdlcCf4zj1pWYbXdueoYBAkjige8PiOyT+poT3yxEedfZ80Zlw
 CN5DJYeGsQDAWPy0qUbGOAB3u1egSDX3l0k3HqYLquhGOhf0RA3v8m58MfUuaC/H3vP5
 TNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759819451; x=1760424251;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+UNwrqgacbnH3eZMWxNAKMJho3HBcXdDGRsXT39Hxz0=;
 b=GIEDgMiVpwgErBWjhwk96e0JC7zzIM0REYY7HNS2AxRtjRnDxMwB+WivmsJkvcMVF5
 +zX/tp1ZL+2xZP1U+Zgu0/5RpsMsQLqmiy8wCyRjz3vzUiG17NRVxXCRkQj7XF9Ml30/
 1VYkeCgMvY7QUCP215ec3/whLUUtZMNjzyz5Q70+RdUOF7SaZpoWunjZ8Ih88TsPYwp8
 xlCOTnIZmnUk8ukAzoJ4cKewYtfDQdMxhN4DI/5AEFrF4rQj/xcSdb1dAD2MQ283q7Va
 k96/BwDOf4ZLsqQzCnjxPeN3tywJKf5x8HOZ92gLuCgzv0388lkEotd1OvApXUCtC4kj
 pJLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3ny+2oqlp4eANMnRUxQF910Pc6jcTXMY7tZULTd3cCegzbaKLz9mChp3yLJsA5k4TLons140=@lists.denx.de
X-Gm-Message-State: AOJu0YzQBBB+XRMKXRKsVDFUXKWQywWyegVNkkhauAs9PlcGu0rieIws
 yeFtnkFgP8geB/75mjQ0QgEEtAv5MXO8893aTkThhsYblT0rtDrAX1AhFwFE05gX1ND7hn5x3go
 b5fR4GpLmGkMsQgvI5Tk045auD6hSbagYMpaiB6BTCg==
X-Gm-Gg: ASbGnctIV/m0LQ4CehO6nzJdsWhzgnvrHjmB266FZOk7S/GUecj3Xcmvnq0QFqEB9Wh
 UvMSilb566/eUfMb8XBQKrFQ8oPJ6XOmiskFMuI/A+2DhFLFM6AdfRJO3Er1HANVSI/yi0oCJi8
 LUfH4eg4Kks/na3vSnvUxovRrRGsBQuvHzbnQYdWDAB09nngxX9o1xq+/MHgL8vXkmbXbYL9Pt9
 6xVkisunXbycXUjBASV05tJUjllMKCvm5g=
X-Google-Smtp-Source: AGHT+IFjL2mQygubch9k/PEK5tVYsGuKvNUUIp96hvMyuH4gKt/MGbDOy9BmhcCcyNuyYu4y1UP9hZ7gFWZ7cY9gunQ=
X-Received: by 2002:a53:c043:0:20b0:636:1ee5:7745 with SMTP id
 956f58d0204a3-63b99f36944mr16775442d50.0.1759819451226; Mon, 06 Oct 2025
 23:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20251006133903.58357-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251006133903.58357-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 7 Oct 2025 09:43:35 +0300
X-Gm-Features: AS18NWB0YLkA8Xncxy9jNpUnJgdUIhJhq8zpm6QVCh4ebTrohMZls7xN5zf9MaE
Message-ID: <CAC_iWjJJdj=CEN14No6Wq4jZY8QyiNWJyE-ao4YzfTtYDM7ZVQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: correctly check if the HTTP protocol is
 found
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Adriano Cordova <adrianox@gmail.com>,
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

On Mon, 6 Oct 2025 at 16:39, Heinrich Schuchardt
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
>
> diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
> index 9a0f2675132..2a606aa441e 100644
> --- a/lib/efi_loader/efi_http.c
> +++ b/lib/efi_loader/efi_http.c
> @@ -460,14 +460,16 @@ static efi_status_t EFIAPI efi_http_service_binding_destroy_child(
>         if (!child_handle)
>                 return EFI_EXIT(EFI_INVALID_PARAMETER);
>
> -       efi_search_protocol(child_handle, &efi_http_guid, &phandler);
> -
> -       if (!phandler)
> -               return EFI_EXIT(EFI_UNSUPPORTED);
> +       ret = efi_search_protocol(child_handle, &efi_http_guid, &phandler);
> +       if (ret != EFI_SUCCESS) {
> +               if (ret != EFI_INVALID_PARAMETER)
> +                       ret = EFI_UNSUPPORTED;
> +               goto out;
> +       }
>
>         ret = efi_delete_handle(child_handle);
>         if (ret != EFI_SUCCESS)
> -               return EFI_EXIT(ret);
> +               goto out;
>
>         http_instance = phandler->protocol_interface;
>         efi_free_pool(http_instance->http_load_addr);
> @@ -476,8 +478,8 @@ static efi_status_t EFIAPI efi_http_service_binding_destroy_child(
>         free(phandler->protocol_interface);
>
>         num_instances--;
> -
> -       return EFI_EXIT(EFI_SUCCESS);
> +out:
> +       return EFI_EXIT(ret);
>  }
>
>  /**
> --
> 2.51.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
