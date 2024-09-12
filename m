Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FDDEE57F6
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 00:59:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EDC188D4F;
	Thu, 12 Sep 2024 02:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CqVJE8mg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7594D88A43; Thu, 12 Sep 2024 02:58:55 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53D3F88D43
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 02:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-718e9c8bd83so1101643b3a.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 17:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102732; x=1726707532; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M23a0dldQJWOtmyHpiWoP0hTZ14AQCcL+uuaOjjmpCE=;
 b=CqVJE8mg3i58MNgqFdmCkfpTmw27PvqbinllMEF1IvMaKuXI1PgYMJAZ4Fgo943QOJ
 qptxdiKJfr8XOg7jyz4S6dBdXPXCtVJd6KysXjunmqZrMNW9TrlxUMPlGxqe5i+rrvDa
 qeRos2wRt5YscTIhsNPw5zxMtldapqXzn5xCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102732; x=1726707532;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M23a0dldQJWOtmyHpiWoP0hTZ14AQCcL+uuaOjjmpCE=;
 b=qzQAghVgfggExi/iHISTofomPH49Ut9iNfEE/MOYRIRdDmCm55dUz3aZxSzBBqwtVM
 yNgeneTiNxkYQAxmI7VZOgiP/4fHNcbTOBfQFh6kCI8uQMQ3Lh7TrY8yHnyZ9dUIbveW
 cQhwLNBdBIiUgi1G/AsvMKfpC2Ark92Z7xjPuclioW/XH9rNDd3Dsd2tt8iaGJQ/2HTf
 0WCSEnJOpOEpVIDpPCP/BJMHkEbXJYw8Ken+cTOuoYw5HnKFj35wktpRvYzm5siydXEe
 kBEWmFefgf4ghkjGNyInr9BxggIb2DJJ1gf/snbAEd6hQmydgkuuZcXdTe3Zp4n/VoTI
 pU8w==
X-Gm-Message-State: AOJu0YxXRnlnQV+qSL95oWtE+Ioz9VlJw6KmuE8Tky/KGVDgHfjc/TMZ
 FD8J/vLbIFgKybvjTJJZQHsJQRpmZqvpa7Ya9AUM0lcE//Ko8uOdN1mxFohVtsLxZ+OAcu04c8P
 QIXBOnTGFKv7GSmHMHt6IGDTJLxhqnDEmWyy4
X-Google-Smtp-Source: AGHT+IFfRUN98v+9JoEDtICu/TVaENpfhs7hIIvIp0jyuvL8DZVQsnLkYufb7wsi9N6jvN4JyNT3m4osCYincLb2Rfs=
X-Received: by 2002:a05:6a00:b011:b0:717:83bc:6df3 with SMTP id
 d2e1a72fcca58-71907f55c44mr11580731b3a.11.1726102731848; Wed, 11 Sep 2024
 17:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-13-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-13-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:58:19 -0600
Message-ID: <CAFLszTh0Y8-1-TYO+fYOgZh85C6Y1w+Jxu=K78MtSMSJFiQaow@mail.gmail.com>
Subject: Re: [PATCH v3 12/30] acpi: Move function prototype
To: Patrick Rudolph <patrick.rudolph@9elements.com>
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

On Wed, 11 Sept 2024 at 00:25, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Allow other architectures to use acpi_create_mcfg_mmconfig as well
> by moving the function prototype to common code.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  arch/x86/include/asm/acpi_table.h |  2 --
>  include/acpi/acpi_table.h         | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
