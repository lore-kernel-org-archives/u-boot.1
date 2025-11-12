Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA1ACCF9F8
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 12:05:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB9B783C08;
	Wed, 12 Nov 2025 13:05:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M2wDk1rL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C209183C30; Wed, 12 Nov 2025 13:05:44 +0100 (CET)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EAD283BDD
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 13:05:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-640d790d444so668385d50.0
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 04:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762949141; x=1763553941; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lSD0KWrE2BWLCfIQudgY86gExFKEFpAA4PMt6Da3xqg=;
 b=M2wDk1rLxufVu7bV1phrRr0t2IoSDmLFnFWJ7gG1IYkujUK98JX3+l4AxdycBLWxH5
 fAsf9vsDLRMol+OvdZaUIzxlrsUztI6j7gaQGtxEtUJWrHmD4O6cXK0oaBbIin1V3qCH
 uvfzbv4yHAcJJ9RazQSP9df4NqeJnSzENQtBhE/remFrpPAKzfOu8j/vM6nlkWNwRjT6
 J3Jbn/EgofSo3D1pTvZeRFmLlPDGFAAe7nNsi352b493HUq/gVP/fyraX/jAFJ1cUboP
 p0BuCVa+YOKzKwHtjnwto4CKWhhShdE2uLqmUgv5kfh9bdxUyJalZeIcoWyQAqAR2kIO
 8GKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762949141; x=1763553941;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lSD0KWrE2BWLCfIQudgY86gExFKEFpAA4PMt6Da3xqg=;
 b=ryzpfQjozgtiRMo9xy/CGIdZrFLVoyw9g9wF01PbiVZ7qbROBVz70y1WCw0q9t+vtt
 XKdhhtj6dfM7wwC4Di2apbGduEnBoT6/4xqNy9SHY2S5+2dc5TAXZNYSkOoQ883huQRw
 BZo+vkCeGtp5BxuNyYxnBfHcBG8Y59otMTb/6fPv7gic8fDZGjXfTMkJ/oOMjFaGRXDU
 MuKDWt+Tx8GEsA1VxKRhZa/2NvjDNV09bVp/MalpsSM00xVUsi8L6G0WkCDtGV06AwqV
 96oaJFknIHJcLHYPtVh5qQMM/PbR9IP+ws3YmAL/8oG11GIkO7/2XjdZ1NHmHyimleGL
 ZHoQ==
X-Gm-Message-State: AOJu0YzHcCu2B2/Z6qoZH6IcuhYGc5hTRzAeNDK7O1+RJHgiWmQqA+IO
 wbFrgn58ayNcG5xdRZKVzSFo8II2Gzb4AGtRtaOb6fAOtvgVc0SAjY4y9FsXUwKeuPH2UPLjzVo
 ByT0Ok7B3vfQlPIxK9UvvrrHf9yhsiUt3xKG9+I0lwhx8SPxFnTMj95Q=
X-Gm-Gg: ASbGncuLpbzygbFmhMNkJdauaYWOxgwRIA8fKi1MwbubAxPj0uDehKMcWa9o4Mo0fkn
 T03TwsRhBmm14/u0JD6eWqNBze7B+7FOpehX65WZrVDpiIc3df9dK+1d/xPQmEwG788n8mAb3v9
 THgusIm6H8O75LdpWQ05pp5Gqv0+EXgHzc4/TM1FENGuflZemcSc8v/YAy8G7FC/+Jb7UIxoWNN
 yG+UPgleXNyU5Nu7PvX8F2ZokSe2PPA5Vh9ehumyiXpBoFyG7fA7IYFxd/hzW4gseBCS435h7vz
 +KFde1NmZLB0lUbOc7HHJSVUGDjfMifUg+Ta+Aa9
X-Google-Smtp-Source: AGHT+IHbNHlwvOwZeQ+lk2axvFXI3Y8JS2PEJlWzLI7O70No2WWOj5Jw9vRYMDyKe3kx/Z60zQfHboKyFV9lt12VPE8=
X-Received: by 2002:a05:690e:15c7:b0:63f:b3f0:42f9 with SMTP id
 956f58d0204a3-64101b61677mr1790647d50.57.1762949141165; Wed, 12 Nov 2025
 04:05:41 -0800 (PST)
MIME-Version: 1.0
References: <20251106232839.3243622-1-trini@konsulko.com>
In-Reply-To: <20251106232839.3243622-1-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 12 Nov 2025 14:05:04 +0200
X-Gm-Features: AWmQ_bmGed5lJlCHU0wyh3UHkf94xSHDB4_IuX1iWavm4bnunBPULzHTcZQUhmI
Message-ID: <CAC_iWjLherR6eOeFZ6kw1AXgoBPuf8w0HtuS8GkwOL5tHU8nWg@mail.gmail.com>
Subject: Re: [PATCH] efi_selftest: efi_selftest_snp: Fix warning when building
 with clang
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Adriano Cordova <adrianox@gmail.com>
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

On Fri, 7 Nov 2025 at 01:28, Tom Rini <trini@konsulko.com> wrote:
>
> When building with clang, we see a warning:
> lib/efi_selftest/efi_selftest_snp.c:63:18: error: field dhcp_hdr within
> 'struct dhcp' is less aligned than 'struct dhcp_hdr' and is usually due
> to 'struct dhcp' being packed, which can lead to unaligned accesses
> [-Werror,-Wunaligned-access]
> when building lib/efi_selftest/efi_selftest_snp.c. Resolve this error by
> packing struct dhcp_hdr as well, as the only place it is used also is
> packed.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Adriano Cordova <adrianox@gmail.com>
> ---
>  lib/efi_selftest/efi_selftest_snp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_selftest/efi_selftest_snp.c b/lib/efi_selftest/efi_selftest_snp.c
> index b00c76c2f172..290ed3a28f2c 100644
> --- a/lib/efi_selftest/efi_selftest_snp.c
> +++ b/lib/efi_selftest/efi_selftest_snp.c
> @@ -43,7 +43,7 @@ struct dhcp_hdr {
>         u8 chaddr[16];
>         u8 sname[64];
>         u8 file[128];
> -};
> +} __packed;
>
>  /*
>   * Message type option.
> --
> 2.43.0
>
