Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26738F3ED40
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 13:34:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68FA08416F;
	Sat, 11 Apr 2026 15:34:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZzhNQwCH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6526D84198; Sat, 11 Apr 2026 15:34:19 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6726E84154
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 15:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-66dd1b5bb6aso4659349a12.2
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 06:34:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775914457; cv=none;
 d=google.com; s=arc-20240605;
 b=ZJhjd73Ap+RYFC8mqfbvWPkLI3LW/nYbpDo/xU+EE8hjTEkOSfwNjVcmADoMVo5oLJ
 2+Y1+SWCgcpeBA+4XMEULcwvuNhTnLOPWgaql4MOxZMcjw9h0o9H41BkA74/men8w4x7
 P7/GUcT6BcpJMHnf3Z/Vs2lLZpxIevflwqTqck3svDis5AQGk1Y4rVzwpsYy7S85fC3n
 TN8z6kd+rejlDTDjT1B1eFLmK1mPS0s3aAPwscjdHzMYZM4vhpdoH3qu5SIvlvuWvKab
 1u1qD5b6etgP1mDOUqrzbW3paAP8IsbGRMVc34Bo0rUNXxEJiDLlMUamqlkkuONi+CAo
 DR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=B6+ZP2l0TTGMyBS1WL0adu00r9KQ5JVnHQk6QfPNQwM=;
 fh=XuW8pdiT74yi3NddyGJqC9l0ddGjvXQIt8YL7LvxIWQ=;
 b=cUBkZ01kDCZS7e+KorEakph3Jyy6IMbm1mnL8YyMNexMPb2UpPR2kEQy0iw4tJrzd9
 anaILd55J9JwhYdWBch8tY60+9GPZXR/dIr/sJOfLrnvFjIq72PGLXUg2NVV+e+PgEtW
 wK94XxTSmff6rPQj+PmIGb5Yqe2pw0Z1USpvhrlqwZEZsfAXWSwXjgNXAw51NljkLvhl
 U+Tn7DdwppKnKJXHWdEuNAjD745U1Qdvi44GqG64FzPbJfE2VhzJgl2nYx9uIfnhwK4y
 ExOgh9ZNKPWgb2aZL3cWJFikd6Ovw41EHgajTbUioPIDj/9KUBuPjmG4FW9W2A6JRL58
 0sSQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775914457; x=1776519257; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B6+ZP2l0TTGMyBS1WL0adu00r9KQ5JVnHQk6QfPNQwM=;
 b=ZzhNQwCHOC2OrCGNm5fSnfxrPGiJkzSv2IzJx8mQ1dQWv7UWfEbi7TszV15aiFHS44
 icD9bZ0euSUAYC+W+hklnAmBmdoyDnMWI+PfIxHJviBPFwGPsWPzWjJ1b9EpoK7zvNR+
 Fos+ufgXJQzPmPpeHqb3Jn6QVtjv/DIDioqYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775914457; x=1776519257;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6+ZP2l0TTGMyBS1WL0adu00r9KQ5JVnHQk6QfPNQwM=;
 b=akRSdRC2FMxSXnSHBkME0SOYTBTD4Dy6JXtmCKxpMZ0FdS+bA5W4s1MSsjIg4ob0rg
 5iJzy8FDLc7qCXdO+eDNZph2SB80qEEc4CeOljc6/hUWDdNEKr8WqDJgHDFH3qbkfZK3
 5/8A5l6HB4vCq4q7sao1xFl5tEf0ko1CtKFvNwudHdJ8jy4c5b62rAdbd/WaUorqL2jv
 SoQpaEHqwNrpCecDq35EN9asxVGgp6c//CmaOjWMUTwlWeMr4RK6xe18C/R83BLlhDTG
 V3hI4J1FcnBSsFvi//MC42/hpJsQI3bAzeMSNoKXBqoxMiLAEvF128RY6jEsL/SVJmdA
 sFsA==
X-Gm-Message-State: AOJu0YwF5x5QJkkvdp9KBZKJdasg0zpzDlAazPWlTqUcX8UsSAXE6Ylk
 s41YokwLm7mhG5pjLxWSUJwCTfpG2KzZzNTOClmUIp6Gr3Pxt39yJ9fUA7a5HXu0QsODycQwjL7
 xW66J4Nq7bD24TqMqUH6s0lSP5b/4oBBCaKFBzRbB
X-Gm-Gg: AeBDievFQq72qhIuh4NguOIpFnKwUcAuaSLQI9+z2lt0V1kIBrKI7fzDDGpbriseJmP
 ZIWoAhYM7XYXFvvZj9Nmr7WTiDr/q3efwvadqrRbSre2nBagyXj2spxwgWnJpfcFpqt9wJrEE0J
 mHsnjKK2lGrNM1Nwks+FZO3JkFRGXcMzA8OljY7g2Bq3qJTO27dGojubENUVkrUOBozorJhyxWW
 UNWeSnzYk84a6k21LAUbrC/ZGNpLlUULh99JiycWHoNuVw4FzNFvEyzHjYCGAjY3QH0GPljA5CM
 t1ebMJEqoWusz4MZ
X-Received: by 2002:a17:907:3991:b0:b97:b3bc:f6ba with SMTP id
 a640c23a62f3a-b9d727d01d5mr411526766b.39.1775914456818; Sat, 11 Apr 2026
 06:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260408-ui-cosmetics-v2-0-721dc6d2116a@postmarketos.org>
 <20260408-ui-cosmetics-v2-1-721dc6d2116a@postmarketos.org>
 <CAFLszTgwK5nUs2QA2Mh_pkTXycAiA0L4ukD8qywubW1AmTetxw@mail.gmail.com>
In-Reply-To: <CAFLszTgwK5nUs2QA2Mh_pkTXycAiA0L4ukD8qywubW1AmTetxw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 07:34:03 -0600
X-Gm-Features: AQROBzCl_En99mAEO-V8zBMI_OLB3h3uHeXr__kMeBzPK3m9o0TTmHGAchOwU8A
Message-ID: <CAFLszTgvueYQUyGCQp3amZN20__LMvz_Eu5S_m=OQf9QDsr+DQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] autoboot: allow custom prompt without requiring
 AUTOBOOT_KEYED
To: funderscore@postmarketos.org
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, 
 David Zang <davidzangcs@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>
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

Hi,

On Sat, 11 Apr 2026 at 07:27, Simon Glass <sjg@chromium.org> wrote:
>
> On 2026-04-08T16:34:55, Ferass El Hafidi <funderscore@postmarketos.org> wrote:
> > autoboot: allow custom prompt without requiring AUTOBOOT_KEYED
> >
> > The autoboot prompt used to only be customizable in Kconfig when
> > AUTOBOOT_KEYED was enabled. For a usecase such as having a nicer
> > autoboot prompt alongside a splash screen, there is no reason for
> > AUTOBOOT_KEYED to be required for this.
> >
> > Remove the dependency to AUTOBOOT_KEYED, and use AUTOBOOT_PROMPT in
> > print_boot_delay() instead of a hardcoded string.
> >
> > Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> >
> > boot/Kconfig      | 30 +++++++++++++++---------------
> >  common/autoboot.c |  2 +-
> >  2 files changed, 16 insertions(+), 16 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Actually doc/README.autoboot documents CONFIG_AUTOBOOT_PROMPT as part
of the CONFIG_AUTOBOOT_KEYED group. Since you are decoupling these,
please can you add a patch to update the documentation? Really it
should move to doc/ though, if you have the energy for that.

Regards,
Simon
