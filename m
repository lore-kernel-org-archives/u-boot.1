Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0523C46CA2
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 843188775F;
	Sat, 16 Dec 2023 19:46:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jgeyk/Di";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 827A287721; Sat, 16 Dec 2023 19:46:02 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A378B87729
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40c580ba223so21620025e9.3
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752360; x=1703357160; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/l9O0x5gEzCM6HSw6ITOt+VPJtb0c97OyJvhAvObtos=;
 b=Jgeyk/Di6RW5aASeQZHgV0YGlFXeg+RwrIZYe6HVwnSehcb4rOcfaIrstRb8wqiySh
 03uPLizgpR/0FT1s/pIGHzphEP8ZVp+41BpA3Q6GDeCSXPS7k6abadyuka7ZJurtyRXs
 yCSv9kG7SPNTa7lC5hMfJJcvGUrysHqRIUCF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752360; x=1703357160;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/l9O0x5gEzCM6HSw6ITOt+VPJtb0c97OyJvhAvObtos=;
 b=V+QNayJ6XwjIROEFIvda/c7+Ws68CRWiACM7a7qluWlM7g7asmQeVuqIaWhGi9Hthf
 VqI808j27QW+hnlOtPokcaFTwHKUqo4u8vdrS+lnGvnnK41Qn6+AceudNWXhQCeqaMPq
 jooT674Gkk06Ld6+vefCWqIuQ+nv5Vn9RMYYWYrHWGT1iBN2jYMdiqM2QclGW6Gtvuv1
 sU+BvKRmZK9jK8bXoZxhUcOXhDtm4/r0ZDkR+L9R1jPKuJF4SFjkRAmUl8UwCnRqg7J+
 mj6+C7/Pm9g32zevcV0A5AQtVsonqxqxjRY4xtJhHIH3OlrcJlXZkkeUZCWnXT+DwU/j
 hzmQ==
X-Gm-Message-State: AOJu0Yz4PJIwczFL6wIRHjNF2E4/9mcqxdxRmRy6Wqx4GXmMw4Ekb9gY
 ZdxjPenzUZz3q7ofsxVambDG8J3Pc9w2kWzWjjeedg==
X-Google-Smtp-Source: AGHT+IH2xvCG/Moz3wUZYBeP+0BLVGXkRN7YqgmRNmjNquzCxe9kShiypHU+Z+qvVYcPzL5AlvvxIOvAlnsE84NC5ac=
X-Received: by 2002:a05:600c:181c:b0:40c:2f84:59b1 with SMTP id
 n28-20020a05600c181c00b0040c2f8459b1mr7355589wmp.151.1702752359871; Sat, 16
 Dec 2023 10:45:59 -0800 (PST)
MIME-Version: 1.0
References: <20231216081200.7677-1-heinrich.schuchardt@canonical.com>
 <20231216081200.7677-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231216081200.7677-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:45:27 -0700
Message-ID: <CAPnjgZ2tJSTO7HC+_zCzxBBxSFAPmg2g+hyacqXoKWM+u1HhEQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] cmd: acpi: fix listing DSDT and FACS
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
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

On Sat, 16 Dec 2023 at 01:12, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> If field X_FIRMWARE_CTRL is filled, field FIRMWARE must be ignored. If
> field X_DSDT is filled, field DSDT must be ignored.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/acpi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
