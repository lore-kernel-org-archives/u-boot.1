Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2446BCE8D53
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 07:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 574BF890E6;
	Thu, 19 Sep 2024 09:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RWHxhQFG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55A1B890E6; Thu, 19 Sep 2024 09:06:23 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36487890C9
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 09:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7cf5e179b68so461689a12.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 00:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726729580; x=1727334380; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XCaSMsGRNqyiLsC4U3NfkKRFRxGfD4jrMg/H/9Va77E=;
 b=RWHxhQFGaHBmJ6GpfwjqpARoMWi4sy3QsXYkQddBmaTu1txZKYToIFcya3VCCi3XD0
 oUnQLKl0a5edKPhDF0WbwbxILkUTj8vMRHGA09p9Sb6HQmvvSIjoFeqByLxLwQqNggv6
 QgjFlnVjtV4I5v4XzfqqvNsX/4fqV073/HSMlmKS1k3G0jR6q9LGi31uPvtZC243m4Ve
 dJfjqQ41kYPhasvQjbn4dFQVAIS8Ig8Q8grVqFwoVwSlv/lvEc2GZd8BZn7iGRNIHZhP
 6254hNYB09fMNNMzqjzOnmgGk9xk3UIUpzB7Km0JYyHOaIH0lp6LPGGSFDsK/73r3yUv
 8nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726729580; x=1727334380;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XCaSMsGRNqyiLsC4U3NfkKRFRxGfD4jrMg/H/9Va77E=;
 b=Futa3MoKnXdDz1djXtiXHAJcOBqQfQW37Ruin88Y6EB6oZnr2AX2uPjXf5dvrAW1uf
 z8s3G3eveIq+QXPMNQGKvapkktRlTMZAiUewzzk9666yvtt6uW5stCv2EeLx010yJDoG
 WV6QFgpm4YC/Q5dVNrLVQD0+HDh7c78V9BkVssZMRu+DQWEeK0h03JF6fip+8irRvANF
 Tp4DzlVeX2HpQAYdFu7GstavMQjZ8ZOyFcj2DAC+mPLBrBxeDIJPeRiNkApTsUrwmqlx
 9I3jNDMjWZEDJCDZ/bPRodYvRkNg93+kTI6UXUIIDsvGM3gmqHTEsLsxtTCZrzg0Th7z
 Z0+g==
X-Gm-Message-State: AOJu0YzKmnehNEDbSu5YqXrBZzXg/2JKoZIvuwjqaKz8z3q6gWt5su6W
 SPIlOvVGF0mE1LQyf+PtojtWZ9gvd1f/AEFHriAosnyM3lNZx3PwLaWN27oQu78SAjvHkrXfQIy
 e4JaiOQApalBAK7hMZ8Lk+gV5X+oVoHikV845vkbOxF5SCa3uFBQ=
X-Google-Smtp-Source: AGHT+IGsH11xMIxwzTHa0zKIYyk/JdDHuuHkLm1n5R+N7NQr5NbqYCMp89S7iWHaTGCQO4/XlZhJqgm73WYxaT7wx04=
X-Received: by 2002:a05:6a21:3401:b0:1cf:49a6:992a with SMTP id
 adf61e73a8af0-1d2fcad220amr3553755637.21.1726729579709; Thu, 19 Sep 2024
 00:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240918214342.20197-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240918214342.20197-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 19 Sep 2024 10:05:43 +0300
Message-ID: <CAC_iWj+ZHkx+DhwddoUOC+-VyqmYpcSs-j6vRuJfBb5k7iVL_Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] cmd/efidebug: fix some function descriptions
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Thu, 19 Sept 2024 at 00:43, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The function name must match the name used in the description.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/efidebug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index 1a191eb9994..e040fe75fa1 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -665,7 +665,7 @@ enum efi_lo_dp_part {
>  };
>
>  /**
> - * create_lo_dp() - create a special device path for our Boot### option
> + * create_lo_dp_part() - create a special device path for our Boot### option
>   *
>   * @dev:       device
>   * @part:      disk partition
> @@ -1127,7 +1127,7 @@ static void show_efi_boot_opt(u16 *varname16)
>  }
>
>  /**
> - * show_efi_boot_dump() - dump all UEFI load options
> + * do_efi_boot_dump() - dump all UEFI load options
>   *
>   * @cmdtp:     Command table
>   * @flag:      Command flag
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
