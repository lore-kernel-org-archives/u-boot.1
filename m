Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF460C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 20:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FA8C833B3;
	Fri, 23 May 2025 22:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HtlaFeke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2F00833F9; Fri, 23 May 2025 22:20:52 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C04718334D
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-601aa0cb92eso369688a12.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 13:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748031650; x=1748636450; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cDWYhlJuojACkvqpYcfdbHiBCypDoE7XwWxAQdwgB+k=;
 b=HtlaFekeG6PnxQVsSVUUVwkRIE00LGfuzeCeJR2hGE88H3MHLpCWMzB21TyGz7rvQS
 FP1FhMZMezHqivL8XIJa5kBWI4Wn2hOsnUWxd2mp2Dt/fxVA6rfPEyXEWJp0huQSMwpr
 qp5rzaoQ2FMpqL0Tg06IlroGuaI/ykCbdtWYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748031650; x=1748636450;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cDWYhlJuojACkvqpYcfdbHiBCypDoE7XwWxAQdwgB+k=;
 b=ABtiNUawZXJ9O4KcHfVLD0XC2X5Wzk3XyjMz71/sWICQHOiiHHnhWilLcIgSzmy7rI
 Zy2TlkhmCknGfUKRwGyrpPhEeGVi4Wz0V7YNZVnW8lJcEM+CpUx9uE/SgQxEjBAFc0AQ
 5DnO4DajYoJ70qKMs21Dhg2mLt2P3zzN7MxKelaJQKmBdDNkJtuqh8cszaGkTKDNmNqD
 FAqG9nh+wHSeYh4xN57dAF7C9dRicA20lFvn77xQlKg1iT9eUE9gVYNmRMW5ITQ4b8kg
 zGS7ybLUm752EyUAkMmRizHRh6B7NqEVCvCTNxJejpr1gS4spqKSK9G6Q9PYiwOtRGrP
 Cpow==
X-Gm-Message-State: AOJu0YxrDregzGgLbeQh1MAppH7JvhOkTbP1RvyACe+0qZVSgFtJIHp+
 upGxhgQ7uUijt9g+xUlFdIqfOq6OVcycvr6dN3VuYAMv40FkkK70fekBiHnibuzH4cCKeNk98Wn
 V8iTTCBKYyEi6C8C21/L8SxvmoXlYoEEJibTmNhZw
X-Gm-Gg: ASbGncs46VQvDpISTz+CjundVx8sNSWzggvRaUfNB9QzjRSwetua3gjGyGql1lCKoQ0
 CRnvgjk9X2Mj36u3tleLh8V5RBWLZ+YuapjJmRCGEuHJSktsRdkouzu3jieZ6oGozFLI5vZdOc1
 mLpoyqpUFmSoKjlEikE9ceCsGFPzsJeCQ=
X-Google-Smtp-Source: AGHT+IEuYb/uVhe/iaNvrcy8e+nWJ/s3hDX97ogJh196G7fB3v2ZHFErIxujekFlIkt8h7m6hXW/4D87ybg7Qroh6I0=
X-Received: by 2002:a17:907:6d0c:b0:ad2:40ee:5e29 with SMTP id
 a640c23a62f3a-ad85b130236mr44911266b.10.1748031650179; Fri, 23 May 2025
 13:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241220003447.2913443-1-sjg@chromium.org>
 <20241220003447.2913443-6-sjg@chromium.org>
 <CALeDE9PnQSp3knoo5Hc4_2UUWhF0sJ=bHeL2zi2K5TReQqXLPA@mail.gmail.com>
In-Reply-To: <CALeDE9PnQSp3knoo5Hc4_2UUWhF0sJ=bHeL2zi2K5TReQqXLPA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 May 2025 21:20:34 +0100
X-Gm-Features: AX0GCFuWskGgdYx0BKOG25Hq_QaVJUgpyptNz6r70rp-zUSZX_VHOQUYZYTfa1s
Message-ID: <CAFLszTg5PkkaShBJPsPb3KttS7ktosFn6vDVSNfpUmbA7fC+aw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] rpi: Use the U-Boot control FDT for fdt_addr
To: Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@wwwdotorg.org>, 
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, 
 Francois Berder <fberder@outlook.fr>, "Ivan T. Ivanov" <iivanov@suse.de>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
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

Hi Peter,

On Mon, 21 Apr 2025 at 11:34, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hi Simon,
>
> With the other changes in the rpi pull this no longer applies.
>
> On Fri, 20 Dec 2024 at 00:35, Simon Glass <sjg@chromium.org> wrote:
> >
> > The fdt_addr variable is used in extlinux as a fallback devicetree if
> > none is provided by the boot command. Otherwise the only use in U-Boot
> > seems to me efi_install_fdt() when the internal FDT is required.
> >
> > The existing mechanism uses the devicetree provided to U-Boot, but in
> > its original, unrelocated position. In my testing on an rpi_4, this ends
> > up at 2b35ef00 which is not a convenient place in memory, if the ramdisk
> > is large.
> >
> > U-Boot already deals with this sort of problem by relocating the FDT
> > to a safe address.
>
> I'm not sure the context of the two paragraphs, they seem to conflict
> with each other.
>
> > So use the control-FDT address instead.
>
> The RPi is interest as we have different DTs, the one the firmware
> provides, which is useful as it deals with things like overlays, the
> U-Boot one we've typically not used or one loaded from disk which is
> generally the upstream Linux kernel one, how does this change address
> that? I have concerns this will change the logic overall. Does it?
>
> > Remove the existing comment, which is confusing, since the FDT is not
> > actually passed unmodified to the kernel: U-Boot adds various things
> > using its FDT-fixup mechanism.
> >
> > Note that board_get_usable_ram_top() reduces the RAM top for boards with
> > less RAM. This behaviour is left unchanged as there is no other
> > mechanism for U-Boot to handle this.
>
> Could you answer my query above and rebase?

Yes, I've made a note to do this and should get to it in early Sept.

Regards,
Simon
