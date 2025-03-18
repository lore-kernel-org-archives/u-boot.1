Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272AFC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 08:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAEB88193A;
	Tue, 18 Mar 2025 09:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YyfXaeYv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB7FF81877; Tue, 18 Mar 2025 09:32:50 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDC9280107
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 09:32:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ac2bdea5a38so884626766b.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 01:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742286768; x=1742891568; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SfQ+C/Lrf6hQt8fKqMTT0yce2T7vkyTMhe5OOr5L1nA=;
 b=YyfXaeYvM2gCyxe/lBZ45W1kr0vrbz2eclK4iEHbyT+RKRqdBK9WarZzp0n9HTCp3d
 WJL9PDtbSyUHbsbfajogPeL4GTnYaiwRrJnPH5b/yUZsdKU9TBOnKrWQYIxXYp0E8gZb
 0DTyFXGP3z6awltXAp2jMbQNXkljKuGAdogH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742286768; x=1742891568;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SfQ+C/Lrf6hQt8fKqMTT0yce2T7vkyTMhe5OOr5L1nA=;
 b=tO8Vrtvf3AJ9w6GyeQPXiGZyVaWhnGxwr+l+iJXagL0hxK3vHyHwUli5nrZrUQ8CFN
 RUnisTCgpKhaw+tYDl1Acb43uH3XosBcZFXdGi1fzOVGbhEfbl/w18+Y9k0QBI1AXhGH
 CrmCMaRZP7C85Qxk7BK+ZvsYgWbJBXAZUF+PXm5ktFDbOSfc9KyCzrxOR0twPANy6v5m
 TneIPjt7gQwFl8ZSJgQUggVeUOW8Xtj/tRIQVw8PoRtSevwmYW/slbDGRkRELsys7Mg0
 /qPFw2xE+aXvzKGU3wgHhHAAplhyFiGq16XaZpZMdVyttk9RYV6yF6bourYoaFD9NqJu
 7d0w==
X-Gm-Message-State: AOJu0YxO7MJ9swsfN5SUJIJLofSb/dsr71+Iy4CIxPlDhReTrJT8Cs30
 xKa0QEtJKqD3k13m8fwC/G6f6q8Qdo+NHrCbUYIM5+2XLTFqaeIFyyk9z/5a1gVhrRO/pvRXCXT
 lv3DTJ4i9N7ZDwZUsSULYK4bsbCLoJ9nsBjvG
X-Gm-Gg: ASbGncungqO9Tuyiizr1sQAAdQkIdC0dEz8j3ETI13WIJtdDq0rCX9GXw4cLLwBk1ZG
 G5a1NuJCA1ERdBZImDni2IaG6yvKE+2OrmlesmSD4ajSiUVlmybG5356K/yeB6Hc5nINxI/R7kz
 vmJkX2KW7/C3KSjxir/whtXvMybWaVJgcJQlnkIg==
X-Google-Smtp-Source: AGHT+IHEa5SBGz8KeewoRZULy0KheY8hNOMbWw7iOsJccgDhaCY3isJTUR2TlOfleXUnNFoEDDUmDXgPoOuwX0WHRYs=
X-Received: by 2002:a17:907:d2dc:b0:ac3:9587:f2a1 with SMTP id
 a640c23a62f3a-ac39587f83bmr209283766b.20.1742286768116; Tue, 18 Mar 2025
 01:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-8-sjg@chromium.org>
 <20250317143158.GP2640854@bill-the-cat>
In-Reply-To: <20250317143158.GP2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 18 Mar 2025 08:32:34 +0000
X-Gm-Features: AQ5f1JrCLB1hi7LPW-hjjdBQ9-I7b7Pan-NA77yY-pACNG2Gu5X_e3JkpXh7iWk
Message-ID: <CAFLszTheHiu3rG+Qtk23ctddUF1_Am=6qGSkSA-+Lp9ndGR2jQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/46] x86: Drop mpspec from the SPL build
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Angelo Dureghello <angelo@kernel-space.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Tom,

On Mon, 17 Mar 2025 at 15:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Mar 15, 2025 at 02:25:27PM +0000, Simon Glass wrote:
>
> > This is not needed in SPL, so drop it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  arch/x86/lib/Makefile | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
> > index 43e6a1de77d..a908356e8a6 100644
> > --- a/arch/x86/lib/Makefile
> > +++ b/arch/x86/lib/Makefile
> > @@ -26,7 +26,9 @@ obj-y       += e820.o
> >  obj-y        += init_helpers.o
> >  obj-y        += interrupts.o
> >  obj-y        += lpc-uclass.o
> > +ifndef CONFIG_XPL_BUILD
> >  obj-y        += mpspec.o
> > +endif
> >  obj-$(CONFIG_$(PHASE_)ACPIGEN) += acpi_nhlt.o
> >  obj-y        += northbridge-uclass.o
> >  obj-$(CONFIG_I8259_PIC) += i8259.o
>
> What's going on? This should be discarded if unused in SPL
> automatically.

Yes and I'm actually not sure about this. It probably relates to the
trouble I had getting BIOS ROMs going in SPL, but since I gave up on
that, this patch doesn't seem to be needed.

Regards,
Simon
