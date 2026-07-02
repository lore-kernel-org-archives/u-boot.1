Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E14C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 08:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46C6B84832;
	Thu,  2 Jul 2026 10:29:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mDazQGtb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D277B84B8D; Thu,  2 Jul 2026 10:29:38 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEDC2846A4
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-697e96dd8d2so540199a12.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 01:29:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782980976; cv=none;
 d=google.com; s=arc-20260327;
 b=TIIBm6bYgdNn3ry/O1o5zS+C52z16m+L3hJfH1XKLUtnf0w+POhSMZuMNhR+flhs03
 mlPBmaTWv0/s8NmcF4OWPdf3eztxhFKRpHT03v9wGytCEcSokSMGFSeJNQOjwOCE7KbN
 CJSi44QrRnu0nAX4/yRhiwwjHf4kjnK2qhCjGYHTRlekks8EWNDlI3Q2IztqZHPXtrgo
 I27bQzrMd0B9dKFVx4IveOc61K8UwYVKs4sb4EeqFFZLczkyiKD8azy5Wt/gWVvvL/2g
 dBJHrbhpp4jb+ZESSoXigw4el3STQtM3sB4oFB4P5eHcM0i1or1Eubi54GCgSR1I4aD7
 eniQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/wH0PtWLgDN63mx0Z89GDhpx1wX8m2XZkjDG1EI5lWs=;
 fh=bw+B8yMH0j5/Xib141B9M28QPxTPqJCdmhUtRtZTZTo=;
 b=ckNIlYuQhXL7to/X4DHlyEtmRPHbs/W3DIsMJHELGuUlOzznbYkwEppiDVOEZXbOTn
 XEOoKbYvNKl/Hnu6GXXTVyPAbBnYIw8Ko65D6oVdx5ysu01nEUyO7dIpuILsIX7PnVtf
 /9bU0mUxk5DXr+w4lYG00aCYgKQA45+xKuOHXTN0QuY7lDfrRu0JyM7T6npv2eVw8Yx5
 hBrk8mgdGTp2V2Wy6WTaVtlIfmcdW9BSHl3JKonKiX1xDHrbS7lxkWQaV72VVX+weRs9
 wYoH/yc+gPhNfXeNhVcY5oDrn9TGcZ8yVtJ5uCiSrWK0pK3A6GsJgjIEQ8E8mlZZuCl8
 2QRg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782980976; x=1783585776; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/wH0PtWLgDN63mx0Z89GDhpx1wX8m2XZkjDG1EI5lWs=;
 b=mDazQGtbzS9Sbketz+z4XOqFYkqvN8r43dbXOMsSDQtePzrCyPmohY716LxI7Qlh7v
 gU4l14+XH7TZN4AqsgEPBKvvVSrMkHLQ7GkF2FJiW1z4InttCiF7mIoJZwAu1SqMQX6O
 iJryyovk+wWCvH0aPw6zqQAT4VtigI7Ku7TBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782980976; x=1783585776;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/wH0PtWLgDN63mx0Z89GDhpx1wX8m2XZkjDG1EI5lWs=;
 b=mXNCg7SnGzDqQ+mczR4WYZUJK6s41KqhPsFlaaxeBdwRmg2qFkcNTVAXrGVgfbo3JF
 fZUjvK4MfLCsVbeCK8+XUQtkMIm2hvgUyPNQ2sSwPqWKoA37hrBuA/O4Ja2EgizsqgpL
 NaQ/Rh5Dr7Me3TL0zLZxJW0U8yXXiJi64DxeI8/5HP3C/dpC8yBexVYNKRRp1MS5xqzN
 p9KPoJoAR/nKvLc0G8y4ihlVVb2H5YA5NZ4UQ2XgnNp4AMVj0MLj6pnIZOr276SGef8Y
 gpKKqNJtKKdtUJ2lKPXR8Va48RqcDkj/HMvh6A/jqQldeqt2cuJVlxzoYgvCHhYDvhfm
 3anA==
X-Forwarded-Encrypted: i=1;
 AHgh+Royvet0YYpEktVje/PRc/CA3vvRq4aycd2OOOfIjB67f+IIhKFPBQVd9zzOGltfAalyA1PBFBM=@lists.denx.de
X-Gm-Message-State: AOJu0Yy40cr/8B3PklGGqrjBfQqboSY0DGQNBzieca2L7N3GsVUoHz5W
 VLflwNKW7cBW0G41a1xUDzQNralgDGg4VxH5zHgEC/lbZieiyt+3124WTg226qUWyiBBoV2Wumf
 XOcSN3DHcXvUQL0VGCrAQozLya+3tqUDF0BpP63Bv
X-Gm-Gg: AfdE7ckwHlSCcHMHaaCSuybdp6gHrsNAV4pWu/hFfcV8t7FuzBNriZj7tkrHQIxPReO
 dlhbVzqPwhRjUw2Vi484EEeT0Gh9QeJOGEeAJR6tXIYS56LsHtmGCEPOANyxOnw7FOxCDrginMX
 nM97wNB5c6T9ripxr5vEqXUa1GQ4ydmsak8OjuzSWELviS3/Plsr0KFnSqgVcC/AjLTucPfsdDe
 1HeGFk7om9s/Zb7Ns03bwh4jFFf1j7Hb+osX5ZjEYzU6mFwI65U7J9EsGDuhFOAc8XrT3sKh8KY
 WA4z1IVa
X-Received: by 2002:a17:907:c30e:b0:c12:3bce:c3c4 with SMTP id
 a640c23a62f3a-c12903b38e5mr453002466b.3.1782980976292; Thu, 02 Jul 2026
 01:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
 <20260628082810.175862-2-heinrich.schuchardt@canonical.com>
 <CAFLszTg0C6cQDVWYbSPRJxjCwFhH3oa4yCPb8tJa4h7Akd=aXA@mail.gmail.com>
 <837c7f40-fa2e-4fd5-a889-4c07b6b779d7@canonical.com>
In-Reply-To: <837c7f40-fa2e-4fd5-a889-4c07b6b779d7@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 09:29:22 +0100
X-Gm-Features: AVVi8Cch7IvV8KPJNp6VE5jvT89tp3YRIRWVFJgp3rSQajIuipFRUfOTRxP8oPo
Message-ID: <CAFLszTgK6RTUqpjoFNT9jVVCR-YHLwF+4QmuRS4vJ74mGBwSjA@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] efi_loader: use pointers in efi_acpi_register()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 u-boot@lists.denx.de
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

Hi Heinrich,

On Wed, 1 Jul 2026 at 14:29, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 7/1/26 13:59, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On 2026-06-28T08:27:58, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >> efi_loader: use pointers in efi_acpi_register()
> >>
> >> Both efi_add_memory_map() and efi_install_configuration_table() expect
> >> pointers and not virtual sandbox addresses.
> >>
> >> We need to convert the virtual sandbox addresses in efi_acpi_register() to
> >> pointers in memory before using them.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>
> >> lib/efi_loader/efi_acpi.c | 35 +++++++++++++++++++++--------------
> >>   1 file changed, 21 insertions(+), 14 deletions(-)
> >
> > I think you missed a few things from the v2 review.
> >
> > Regards,
> > Simon
>
> Which ones?

The EFI_PAGE_MASK -> EFI_PAGE_SIZE change should really have a mention
in the commit message, if it isn't its own patch.

The main one was my comment about the confusing pointer code - see my
suggestion for how to avoid casts, etc.

Regards,
Simon
