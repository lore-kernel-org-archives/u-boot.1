Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0184AC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:24:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2AA687707;
	Sat,  2 Dec 2023 19:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BKtQh8Nc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91D1487675; Sat,  2 Dec 2023 19:24:07 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F33F87642
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:24:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-db35caa1749so1515460276.2
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541444; x=1702146244; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=83/HTVRuzB8m6tPX/aDLpTQN3lS5XQOj7cFd4/79C/8=;
 b=BKtQh8Nc7Om1xKL5vcRXZqpiPdffuzjez1kGRkRBxUuhxgswrNiXaeWnj6roCQlDoc
 y2aeOZiLesODU5iagUiPRJEhAry+5ZzH8P3y76lSy9RzzxwDXgNIhscILuYTVdRWCJXD
 Uq8FQhkCZG5RaW2sUZEuTgy/4WMgBUBwDIzV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541444; x=1702146244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=83/HTVRuzB8m6tPX/aDLpTQN3lS5XQOj7cFd4/79C/8=;
 b=BPUDTmkIQoR0SEaDkSDxCylaqoHb97nLwLnLpaQ26afgw5L/4vpGI8PbuMAd4sQjN/
 u+OsCE4JxdMKrV+WZrIV8l8QAJOqqz5+nzhJP1hpka88xcUojV2dKLXg4NavKhAFaC+s
 KK60QPUBHzdsW8MreiBPE0qB+yrntSMUKM0f4Wxu3bCeqoNNqIRlAagdAZ4dnk+nT+Bv
 UwfqzX0qOgQSVOQYZniPLIvEHE/o++PwGykQIltn+ALuM71gCKuj0u7Y2Wn5UpL0T/74
 QdRUkGrOOzopLFGimC3z9p/XO5BKq3Zwk+Ee2STtDpwpkubGQyF4NvkmJ8QiWx+AoXkD
 qWig==
X-Gm-Message-State: AOJu0Yxg6qlkdzjq/I9VhffejR8WlDdC759lLUNJK8LS4JpRO3Hpjwmb
 7hoNCJpgSPOvIm3C/qSkmgRYtmwmDAcqTKHy8Xn6kg==
X-Google-Smtp-Source: AGHT+IHPpUUzHIfS/tkEMovfXFjaAVk1F+nVzK7wCO1QUAYDS7DmKqLxNljQQq7lU3GqOmipJl7t21qDsAL++Uf4630=
X-Received: by 2002:a25:c053:0:b0:db5:4a19:c32d with SMTP id
 c80-20020a25c053000000b00db54a19c32dmr825902ybf.18.1701541443968; Sat, 02 Dec
 2023 10:24:03 -0800 (PST)
MIME-Version: 1.0
References: <20231122131154.2444690-1-trini@konsulko.com>
 <20231122131154.2444690-5-trini@konsulko.com>
In-Reply-To: <20231122131154.2444690-5-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:23:12 -0700
Message-ID: <CAPnjgZ0KxgFmAtOAYFS-jkdkmmyL=agCfqhJyge4xK+Aq+TwKA@mail.gmail.com>
Subject: Re: [PATCH 05/11] global: Rework architecture global_data.h to
 include <linux/types.h>
To: Tom Rini <trini@konsulko.com>
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

On Wed, 22 Nov 2023 at 06:12, Tom Rini <trini@konsulko.com> wrote:
>
> In most cases, the architecture global data currently makes use of
> assorted linux types, but does not include <linux/types.h> to provide
> them. Add <linux/types.h> instead of relying on indirect inclusion.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  arch/mips/include/asm/global_data.h    | 2 +-
>  arch/nios2/include/asm/global_data.h   | 2 ++
>  arch/powerpc/include/asm/global_data.h | 3 +--
>  arch/riscv/include/asm/global_data.h   | 1 +
>  arch/x86/include/asm/global_data.h     | 1 +
>  5 files changed, 6 insertions(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
