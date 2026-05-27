Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CB2CD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 04:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 460A6846AA;
	Wed, 27 May 2026 06:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l1AXIqdP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23A42846C0; Wed, 27 May 2026 06:47:06 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02AF8841D7
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 06:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-67c1e0229acso18530329a12.1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 21:46:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779857218; cv=none;
 d=google.com; s=arc-20240605;
 b=L5WjmPcJ7MTVYfJU5OLJ8iCkcHwkWvBPH/+aIwXYHUStorvOvnpmPcOqm7ZP/1RHdh
 sJI+wgLFlZ/yPnlBh1xLAokXtHQ8+YrY7l9Bt/zjs/nUAFYhzD0ly5PgfbQ4zDcNu8Lu
 c51QYlmxyofIvCSfltTLLAQC3iYRxslxTT/DJPQWCMVLHHYGNulRCMMAjyoXH/wX9iIN
 YgOJyjnQI5ENCJqu5Tdv8nuOZlHiOifwDJ9Az5t3/7ElFCIcVkqdEC0CtYLM+NgbPOZ6
 JC4MPltBJvxjw9lxPqD9giblR1wyY32OGhIQvr2bjYitMNjVeCacGtfF4nO5iMRZjyp0
 mDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EsvgxGFkJ6OImmM8vIhkanAx8yf2rqw9Tb9dFGWCCi8=;
 fh=hv+M4LQsJ0nwm2OiG7HVcWuIRFfSJKk38BkJQGrVkdY=;
 b=XsNsscxvfzxxNXEHQgEeioa4wsHju+hc4TMaPK1t/HvwvyG6Ph7erUu5/UyX2uZYGS
 CCOkzXAgl5hV0G+Youo8f2P9wQuWxby+7NEZJSEg6UgQ4aLw8rBLLXcmiAeaOiFQGi/8
 jKZp8iFgIl2xuoLmY3wlIGZGD6DDWTwCrvUEcub4B4VXDXPvuVQ4Du7AJwaqcs2QtW+N
 aApgamgthykb5UEbWsiOYmGEBcVyFuXPmxx9wL5orseA0F7sxmsW53wTffJ9Qj5wqdBA
 ExlDJ+hzpnamdwVxxEXqbavngIfzgKrYHMG+Z6A9NbHMEzUfVL92CoBP47NffnXK8BOQ
 fp1Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779857218; x=1780462018; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EsvgxGFkJ6OImmM8vIhkanAx8yf2rqw9Tb9dFGWCCi8=;
 b=l1AXIqdP4+/zlsNlGNNS2GoMdWC9fsen2SYcZv0YH7AS1iwxdYxS5xwTyfhbHYm8kD
 PE0ObxstzgA9Awspq6d/FHK387VyhJkM2nm1N+wIw7BfOurWIU/nXJ4Cwt3SHTNcCTQ5
 e78qE9W68FG9jjzSzuVJ0Q5We1ktqnmWOz03U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779857218; x=1780462018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EsvgxGFkJ6OImmM8vIhkanAx8yf2rqw9Tb9dFGWCCi8=;
 b=L1YsthNZoaz9lswMctgByD3nuj/qyM0ys4kZk3tveHFUrBBjxjfct0xU0+6H4vjHjh
 DeT9S3XT6gXb9ZF41CKjJwvBu9/sKHLnybcJbSLPZ6VsE+h9nt8WWqjyoJsWt/rlGb+F
 PiJDPK51xjcerFgywm9rHYJMb2HOnNJ5TEwHpVl0a7I6PD9tb8ov7Nktq5v8cURM4YpO
 TFzv+tf0Jmm6yQn/phVF0Z/4oR7x/Y112ztkAbIKqv9pUYHMDgU8OXly+jFY9wGrrTCs
 YW+dEsBcjv/j/5W4SMA5EXNe0v/J4X4eK86nzB4aPCukBVIJZxNMFUwfqgoPEiWhIMyf
 akbw==
X-Gm-Message-State: AOJu0YwHunij5MQtsQKEn61ivtSGbJN3emJ3lWHuCvyoP5uUGFF5YO/Y
 XVdNuQqBlAV6ceWub2w8n2bhIe9uEjDNLhWtgsNni6IHK3/4tWbtSsDDUu1tfbOr5kkRTZulJA7
 j04S8q1vdfHJvH+e1MKfTDueS+qU3BBhu7a06Nr6P
X-Gm-Gg: Acq92OHdoQFxgnTeChCaVZh6wXSh6Lik/rBnonPgBcdkWCkM1QJkeusWu91Rhvnar2o
 O8SzU0WccsZ89u5tmqnLE+CcvVQ/Frt9JYLhFXh+zgGlcFAPoMwPtBzZ/S8bau+HEeeA6RmSplY
 BF3EsFRS0tlbnnfXUckYo4B+ydWOswqBuUkzad+EfAeHc2ajiQ29AKrQfGthRa/yCBztlf6rv+z
 rdkfGaxPzFdZFPgD1BQ27gDJic3uPS0FaGsmTifiKUU2Lu5Btbh9Nc1O5vn0vd0d10QpBSzSE9M
 co4/Hg==
X-Received: by 2002:a17:907:68a3:b0:bcb:8984:15ec with SMTP id
 a640c23a62f3a-bdd2a409683mr929998666b.29.1779857218430; Tue, 26 May 2026
 21:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260522183228.GZ1858239@bill-the-cat>
 <20260526104744.33248-1-anton@binarly.io>
In-Reply-To: <20260526104744.33248-1-anton@binarly.io>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 23:46:45 -0500
X-Gm-Features: AVHnY4IVszG1h8Z14kU2HOAiqQc5R78adWvRbxlVmj6GeqguCjf_-yyhTN5cZ1w
Message-ID: <CAFLszTj1rx67qY7AHB70w2+zUSGFYFgAocTbVtibt6rZp7pjRQ@mail.gmail.com>
Subject: Re: [PATCH v2] fdt: Check return value of fdt_get_name() calls
To: Anton Ivanov <anton@binarly.io>
Cc: u-boot@lists.denx.de, trini@konsulko.com, vr@binarly.io
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

Hi Anton,

On Tue, 26 May 2026 at 14:41, Anton Ivanov <anton@binarly.io> wrote:
>
> From: Binarly Vulnerability Research <vr@binarly.io>

Is this a person? If so, can you use his/her name? As it stands it
seems like an orgnisation rather than a person.

>
> fdt_get_name() can return NULL and set len to a negative error code.
> fdt_find_regions() does not check for this, leading to a potential NULL
> pointer dereference and a buffer out-of-bounds write. fdt_next_region(),
> fdt_check_full(), and display_fdt_by_regions() also lack validation.
>
> Add NULL checks and propagate the error code from fdt_get_name()
> to the caller.
>
> Signed-off-by: Binarly Vulnerability Research <vr@binarly.io>
> ---
> Changes in v2:
> - Rewrite commit message to be concise per maintainer feedback
> - Don't mask fdt_get_name() returned error
>
>  boot/fdt_region.c           | 5 +++++
>  scripts/dtc/libfdt/fdt_ro.c | 3 +++
>  tools/fdtgrep.c             | 3 +++
>  3 files changed, 11 insertions(+)
>

Regards,
Simon
