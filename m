Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D326C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 07:05:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE841878A5;
	Mon, 23 Oct 2023 09:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="jNlMhIQg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DBF9878A5; Mon, 23 Oct 2023 09:05:06 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9726787880
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:05:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53df747cfe5so4484921a12.2
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 00:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698044702; x=1698649502; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fyquVEXZelcq9oq3+AJ8o3ehBhKROAryjl6CjXnIoxY=;
 b=jNlMhIQgI98HtpCunaRtH8RDqF0YTeeBN9HZ4SXofrC6jqmPjTHaEWqcxNj+BfouMK
 hFkPNIkUjpYgxDN0R4eU2dx1Um8NRHVk9S2u8H8AReSJNxSQQZhmm8XiVs8Z3py5Pd2/
 8lDq1So8GcugdmPpfyUaxM46O2ffxYr8h8BXUmSzbhQ+j1hfFw3mGggPIHZF9XxtZX8L
 oiFA0mAQpSH9/tPvEqT5pfoLdtGg8Wi/+n1zSvr3QLgbuWGUdKzTgZxCbcn9a/tcWCJe
 omPShtA3JV+spCnHvu3ps+UqNetuQKExGVrlCMXMiKtqqtL7Tcih8+HWNNnsHzXbfI+p
 f6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698044702; x=1698649502;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fyquVEXZelcq9oq3+AJ8o3ehBhKROAryjl6CjXnIoxY=;
 b=SOXfnR6wLyg3oTvsPyMHT3UxiKUJWRwGoV79d1wRHqDss93lkCp2xI1rwxbvLSLHwX
 T5wl+XbRXcqYCaKajAin6NBXlsQfajD5xBECpFiViyU5HTVx7UHGWFAc6s1FSqvBCJGV
 CJQyAWmQZg056kwHZLQZSewBp/2ZH3uB/6A5J14WVXH8oQYzODvIL93uohs7lJMp6kD0
 a9jhzOAzrJ5u1SQ/RQOeP83qChBoJln5l7gfbNkxWwCOCWnu71iC8FIF5ANcD8MXKuyw
 dmIl0i+1/ENPjsF9iRfQeCvGR3WuOhVnzpkmRFeyoHIzHkdnAFrZV5TdUFINn5mQDlpP
 MZLw==
X-Gm-Message-State: AOJu0Yx+KIPuFk2+bWAMf6u/XVrH5NczFPfxGiZ2MGQk/JMgCWTTU45E
 WikQXwxpPIcm8Zz+qXq7tU6KC9fybzwWvWrTFlpJlQ==
X-Google-Smtp-Source: AGHT+IFp5E/J3TwIzJDz83G4WrGAqwfNZL1mgMYoYqmaqDPsxTl+llzDj9IhCTjXjc/rwjYgR1BZx1Mkdxy4I1R03IA=
X-Received: by 2002:a17:907:2d27:b0:9bf:d70b:986a with SMTP id
 gs39-20020a1709072d2700b009bfd70b986amr6724233ejc.13.1698044701716; Mon, 23
 Oct 2023 00:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231022062012.97271-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231022062012.97271-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@google.com>
Date: Mon, 23 Oct 2023 00:04:50 -0700
Message-ID: <CAPnjgZ3STrx4HnVptVWCmKuM9jZLWma-KmK4QcoDJ+9XKHeM5A@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: fix efi_dp_from_eth
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Sat, 21 Oct 2023 at 23:20, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> When compiling the sandbox with CONFIG_LTO=n, CONFIG_NET=n an error is
> reported:
>
>     /usr/bin/ld: lib/efi_loader/efi_device_path.o:
>     in function `efi_dp_from_eth':
>     lib/efi_loader/efi_device_path.c:985:(.text+0xcf4):
>     undefined reference to `eth_get_dev'
>
> Add a missing configuration check.
>
> As the function is exported __maybe_unused can be removed.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_device_path.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
