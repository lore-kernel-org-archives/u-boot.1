Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4AFC282EC
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 12:52:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27F8280F9C;
	Thu, 13 Mar 2025 13:52:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a7490atC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABEB280540; Thu, 13 Mar 2025 13:52:01 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0EA48175D
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 13:51:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac2a81e41e3so205154266b.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 05:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741870319; x=1742475119; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bBGHq8JrlXYtnhE8dGob71vr+92RrI9PRS0Bc8RlNEc=;
 b=a7490atClWZPqK2SqpptLuQUmtqrc8+D9BHsGRTeMyUHypHNmRK4tOQF8oTrnWM9h7
 XJm9MkjzWJcqIiwMeETTJoKo7tporAR8/tHAE0IOlek911Se4KV31byjDThM7wAMHRtu
 S+1EQ5a+qlCpX+qCQ6L9VTDO0EKc66+zkWAIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741870319; x=1742475119;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bBGHq8JrlXYtnhE8dGob71vr+92RrI9PRS0Bc8RlNEc=;
 b=tVsM0l/3jOpZ2+Wd7LJ3rA02PR+4DB94hEJwBBqebPak618awliTF/lessaJGpdVKc
 4zGzbyKyGxsxaGm9VS7jb3johlVhcRetfeH4h+HKt+CREZuop5HhmbzbVfvJm4oo5/wf
 OH+Po8bAKgWr2eccuDhgPeiwJ6iC3TOYlHXuydCOM6iONSsHAIhjkI3tpwGIXaCMPGTA
 iDx82y6GUx9+iCZPACxLYMsE04qyRqULkjqf7uaxhG/YDMN+TlDx2RnaeF/DyrojhvaH
 Xvh9U5iYQkJOi/scEAau0fBZrmI1HMtc19A0isAOlCEU/JBJ9ubwFs228Mqd1yJCBHbe
 LwQQ==
X-Gm-Message-State: AOJu0YyjJB9aZr0Pkux4Pku0lDNNEEN1/jcQ7ShCLR7+Z0G24QgwJgsI
 JnIjvdrI2IjkJM99a9cIMCsPI8uxDsJUH2Ul9hPgtuhc2zFf2/sZY19fqm+EBzt+dw7R3ZfQSiS
 GBnD2YsY/C8QmyonXqAL3au8EK+/zhStQ4HjgpNn9EedRw+Q=
X-Gm-Gg: ASbGncuO/Dd6eRSqJdQRoAV5Ol/bdzILbXhE/oFCJ7rkXOD+xnsgHhupOGtLzvum6gW
 ylksINVahitdzI5W1dgEJ9b+k/JZCorHz+kO9Zdovy/oFBaz0GIzUYTNg+6yVHyrm8f/+62LYwk
 rRCC2O3Sgtd+mDiKHhCyoMpMuoGL/R
X-Google-Smtp-Source: AGHT+IHt0PM6BQgfNDgMC0EuuRqHJfIZg3Ee4vZT1/7fumYdYD7HqwEOkaDYyEVVrCGiA+ifOjU30NEQMmkdP4Y/p34=
X-Received: by 2002:a17:907:a1a0:b0:ac3:f95:dbd4 with SMTP id
 a640c23a62f3a-ac30f95dfb2mr221682666b.42.1741870318878; Thu, 13 Mar 2025
 05:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250312090130.2951848-1-naresh.solanki@9elements.com>
In-Reply-To: <20250312090130.2951848-1-naresh.solanki@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Mar 2025 12:51:43 +0000
X-Gm-Features: AQ5f1Jpwq9RmlbH9lSlbA4ctl4vyhG6Dri-mCOit_2KEHhwTBzQixjZewSFsXIE
Message-ID: <CAFLszTgQmnhUsaFmPYsrZKP5KickAbyoSb7Vj8DvuiZY427rJw@mail.gmail.com>
Subject: Re: [PATCH] x86: spl: Add support for NVMe boot device
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
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

On Wed, 12 Mar 2025 at 09:01, Naresh Solanki
<naresh.solanki@9elements.com> wrote:
>
> This change adds `BOOT_DEVICE_NVME` to the `enum` list in
> `arch/x86/include/asm/spl.h`,
> enabling NVMe as a recognized boot device for SPL (Secondary Program
> Loader).
>
> Tested x86 hardware with Coreboot + uboot payload.

I believe the correct names are:

coreboot
U-Boot

> Verified successful boot to NVMe drive.
>
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
>
>  arch/x86/include/asm/spl.h | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
