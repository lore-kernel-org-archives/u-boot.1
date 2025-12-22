Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C906E67811
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 18:46:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 796F883B99;
	Mon, 22 Dec 2025 19:46:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F2wa3JeU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CDA383D1A; Mon, 22 Dec 2025 19:46:51 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1301E83B95
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 19:46:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c52fa75cd3so4341669a34.3
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 10:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766429208; x=1767034008; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PbmFjhGElqdoWtTrB10W2K9jEjPZonNTNPtcRBvkvzI=;
 b=F2wa3JeUPPyOCI/7BnNgbDQAypjtUgprvX75fGtB17lwQzK0HhsSop3rMftWf+dyjO
 NwqxZ3wn1INGhOjax7w4XtZdvY7vqmGUwYVApJByqaTYDmk62itF8HjNYh1AEQRvpWHZ
 a0XMmcOIS6UCgieVbrDZM50aiqXHYzdzj3sjqdHdz4hWbI51FRYS+BTzdC0dwtx/bJCq
 bExliYSZriJ+lVkfI/nIIvGdETYtfGqm99midfS+EXniWUJSmd1AEdTAxpSsGJnI4692
 Ig3+ZP2aLP53NZOceB0lzoNtRct4ZVK/9TKOTrwr0ShYfB9rO2FxfWg7UhO9taQOSy7I
 A+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766429208; x=1767034008;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PbmFjhGElqdoWtTrB10W2K9jEjPZonNTNPtcRBvkvzI=;
 b=o7EkTj6UGA280+0ZHwH7TLLHhYMPfn8tJydmrZSsHuOxTlzeBRBeT/99rWGnD/C4b7
 qvR9wby49qQsemh/AvMeNrGh65vOjhGzGXC1DM3+H5ozaeLA2iqh4Cls8v1bodtYYCZ5
 0B3fwU+aoKWO3oFa8yyFcxLp+fWByNEMYOlPvpiEQhOqQGa+TRhsE/fCCedDBeY7hkMI
 De33oFVmNgqYOjGw2Gtg3vkEpcKwFWVc6WZb0g1f7hD+Nn1seQjlTcveONdsMmMCSpNd
 EzvZBPZ7b68usDWC8ckubE55/FrEDlA4kVPQbNeT9J7hDSXYQid7eTrj/faHVJ6msGp8
 nr1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6GvUYkllWdJkLC0UYkKv1AYiiVs6fkXtWy9tdIgFYmixUzmrGzwcRI4bx+LfNqlNjcxAaOu0=@lists.denx.de
X-Gm-Message-State: AOJu0YyFOnr0gPmQqTARskVB2Jz4TtfZR1V0u/R5h2/2+ekJbAGmKbRO
 UDgQ1lB8XuNJRJZiXpu8T2ts1bbru6pqBicMrF+mB8/gakM5td3emTE/m5AwCF78pQ2fMwiLeGY
 TAHLK1njxaj0d/sZ43YeEG3Ab5DY4+gI=
X-Gm-Gg: AY/fxX6lNfHPC0Jl3zugTgei8Uo8ubNx8j/Xzp5AzIrcLmAGlXJihaTG1gxoilbCagO
 6Wa63E1mNshUFQF9CwFm4fYCQ5XHF08PwRs3vldk+PvdoJbnJRnhc9ulSwe6FiYSyXjwxwtSJNg
 mLckU6MX9BX9jnruXRFf8RP3O4DEQU7+WRVXXwbNaGPasEGw7eN03GZP5cuisEyw78qjSsedcjp
 6I7Vd92YVYPIFc6rF5DhSlJcP3d/CL1dfuIR53voenLK/tbN7ieNEPIZPTUdH8MoXUcO+4=
X-Google-Smtp-Source: AGHT+IGEwjALntVEghHtgmZCN4vSXejtLqdSABM+X2VFldYypOZeXUYDTmxyR4RvDLhQ9vku5mDtR/ot+ixxfXxWYD4=
X-Received: by 2002:a05:6830:4acc:b0:7c7:6850:81b0 with SMTP id
 46e09a7af769-7cc66a01e13mr6517583a34.21.1766429207716; Mon, 22 Dec 2025
 10:46:47 -0800 (PST)
MIME-Version: 1.0
References: <20251222170521.147815-1-briansune@gmail.com>
 <20251222183151.GC847766@bill-the-cat>
In-Reply-To: <20251222183151.GC847766@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 23 Dec 2025 02:46:35 +0800
X-Gm-Features: AQt7F2qQfg45PLGwWMJGfkBNRiyXHq8r9BJqw71NBbfxb8LlW7cL6OqulsWjWA8
Message-ID: <CAN7C2SAczZL5Q-26PM1RHczH_E7oRUqh0KsRYHiNuOLySZkT6Q@mail.gmail.com>
Subject: Re: [PATCH v1] Replace TARGET namespace and cleanup properly
To: Tom Rini <trini@konsulko.com>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Dec 23, 2025 at 2:31=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Tue, Dec 23, 2025 at 01:05:21AM +0800, Brian Sune wrote:
>
> > TARGET namespace is for machines / boards / what-have-you that
> >  building U-Boot for. Simply replace from TARGET to ARCH
> > make things more clear and proper for GEN5 SoCFPGA
> > where GEN5 is referring to both Cyclone5 and Arria5.
> >
> > Signed-off-by: Brian Sune <briansune@gmail.com>
>
> This might be something to work out with the rest of the Altera people.
> Looking at the start of arch/arm/mach-socfpga/Kconfig, there's a lot of
> examples of things following the anti-pattern of using the TARGET
> namespace for what seem to be architectural symbols. These should be
> converted (and in some cases possibly collapsed) one at a time.

That's why it is out of my power to do this.
But I guess ARCH_ is a good name when referencing rockchip setup.
Too many family that i don't even used before so I am not brave enough to
touch those.

Brian

>
> --
> Tom
