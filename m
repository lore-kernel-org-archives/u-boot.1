Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE34CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 03:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9D0F86F44;
	Wed, 18 Oct 2023 05:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BuafAPVG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D063586F46; Wed, 18 Oct 2023 05:31:49 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0490586F44
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9c603e2354fso291037166b.1
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 20:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697599907; x=1698204707; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TOqat2Of3ESGEKBOrdPthgRdP73wDqsyJL30GS9Pe5A=;
 b=BuafAPVGjHn/FqyeALBeuf8SDIfm9oba4CVPOnmC/ZG7HL2t/apGYAoOBza0x4awaX
 wBlO7YWBiNcrhsm6f4RLmVYpqj7LHlDFH+6m4IBrM2b4abwc2Xrh5A16jrKqSLiI9wMp
 Can81NcWT+bDk9f2tCgVNH3HizlIaNx9DBH60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697599907; x=1698204707;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TOqat2Of3ESGEKBOrdPthgRdP73wDqsyJL30GS9Pe5A=;
 b=cRd09jc/cq280aiSLgFFXm+fRBUgpqU6iOhfBBDzMqa8Sm+Qlpb8EUgI4X56zLMBa9
 MZXCLzTShQ9CJ91mtG9NsnMuxQshRnFNQ2RTyr4CP/tL28nniyBaFxW4F/XoptGfqRmR
 9ChaVl17ib3/64jNCAF7zRlmJRIYbjwWvy4h5s3Ziq7rNTrYdR7+/0xGED12w78O+ANk
 08EckkU9RpcXSDQ8SrTSe8sWZpEsZC72U+dc74AomWZFbrqN3rW79PV8r0LQTt++z4jK
 zr1igUMatFtjlpSUAAn6ARYST+oCPIZjhMTt34lm+HJeGQwMDKptzuE8S+ABmWmqO/4L
 QT0w==
X-Gm-Message-State: AOJu0Yxu+Pj7N/H4JjQrpW6gjSBdMwwVUFzHl2ZNF81dZxxGkLQEQq8l
 fionomVoyJmhWc6Sm2XvWEZpO4p46yie+qg0LVmbDE91H5toACsFQcc=
X-Google-Smtp-Source: AGHT+IHp+ZbJHPWJJLZudJOe/DHye6hCiJyyrQlZ+9sT++hiHo+fNlNhjY0njzj83X6GkxY7MJuU6Lh5mQ3A2xCePTQ=
X-Received: by 2002:a17:907:7eaa:b0:9c3:ba22:4d65 with SMTP id
 qb42-20020a1709077eaa00b009c3ba224d65mr3650917ejc.4.1697599907534; Tue, 17
 Oct 2023 20:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-23-sjg@chromium.org>
 <20231017140925.GB3119521@bill-the-cat>
In-Reply-To: <20231017140925.GB3119521@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Oct 2023 21:31:34 -0600
Message-ID: <CAPnjgZ3QDBJSmdOc=DMOUur0NgbytfWC6SQMNLs9_zX4WCFDqA@mail.gmail.com>
Subject: Re: [PATCH v3 22/32] efi: Update EFI_LOADER to depend on DM_ETH
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 17 Oct 2023 at 08:09, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 16, 2023 at 04:28:13PM -0600, Simon Glass wrote:
>
> > Since efi_device_path.c calls eth_get_dev() and assumes that Ethernet is
> > available, add it as an explicit dependency.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v2)
> >
> > Changes in v2:
> > - Add new patch to update EFI_LOADER to depend on DM_ETH
> >
> >  lib/efi_loader/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index 13cad6342c36..fca4b3eef270 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -11,6 +11,7 @@ config EFI_LOADER
> >       # We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
> >       depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
> >       depends on BLK
> > +     depends on DM_ETH
> >       depends on !EFI_APP
> >       default y if !ARM || SYS_CPU = armv7 || SYS_CPU = armv8
> >       select CHARSET
>
> Does this work for you Heinrich, or do you want to clarify the
> dependencies (and re-organize the code as needed) around networking?

It would be great to tidy up networking in lots of ways...perhaps we
should add ~CMDLINE support to the list of post-lwip tasks if it lands

Regards,
Simon
