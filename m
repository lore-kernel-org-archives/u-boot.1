Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA48C83F0A
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 19:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAB0783599;
	Wed,  9 Jul 2025 21:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tq9pHwSJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA104835A5; Wed,  9 Jul 2025 21:17:34 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0A2183564
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 21:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-60c4f796446so242624a12.1
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 12:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752088652; x=1752693452; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZB7qb92FqPxvxHz43gQAbcXjsFRjsXWHZBoioNNVKU=;
 b=Tq9pHwSJT3Yrdn4Q6E7+EkuSpOXrtd74huKSL6j8r03RW8+rZcjHYMIcVFH6kBNAHF
 XLEbkUSi4xFX8M57q4HVPuvVxBD5JUx5rzYqYsp1qQXqrPdNmtkX0xKr9yrJQKoDqAoz
 MVIbjwqb5P4zrjUL6eJ9CkFtbLx8qYe17Oe8GdOqFoXigwlbSRRzvOFpfjMIYtDRcsOO
 YJ7ScgMz/kVi0u9cp9Ye+a6g6RrU9vm1CFzMpXhZ1zYHKg6EP6TpGkfO7xTuZgktvrIk
 tGcM1QJfBtuQQNSmHEDXKQ6qJv3N2ctbakc5/qZcGPJPMVskBwUTQwqXahynTDrW/NR8
 iNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752088652; x=1752693452;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HZB7qb92FqPxvxHz43gQAbcXjsFRjsXWHZBoioNNVKU=;
 b=vUhqQSibqfG8VMOkWJ1HCnl8uP8FB8uenGsD8BrGZc0+Dcd1iFzpvv8p5ogucaOfIQ
 tqq/+qVDDsXwSypoJiKj10NDuMrdTheXkPt0G8Zy8nv4fzKjLHFfLRuG1ZTOgYsxW8zW
 z0KsIelo+hwhf81WmxI8taHnTpnTrn/vA33h89VJ0gxzvbZKFIhkzIbzMiu7mOBeElWW
 Qqny+1tnz9UQb1OJyXstXSgQ/oq56+f22SO8QCkDAZO6iBwP/k/oi1D32LkiycV/deSp
 FpyXha4eneYGL9cLuqRrBG4wUHcobGWBkec8I9zQJrTakqZx8t85NC/qgbOWpzl+32gG
 ZQIA==
X-Gm-Message-State: AOJu0Yw6xHOJ9NNF0Ck515OQW9K72Cn7ua4QIrLQqwmX51oE/ZAll5+1
 tYOmxbiDN8iSIkFQZqrSTZdxRwPVKYftjsMrQXz1Z9ywDC+qae53bTpGLYleeeu1V8CfGV8hl4Q
 4L+0RKbfqet3O/dogJw8BR348Ym6Izg==
X-Gm-Gg: ASbGncsb5AYGhp4FanhL9MNilzzfg6ERpOdpwzyT8kQAWhMiSXO+JCi7zEq5442rKGd
 dGmb72BhbZkAQYZLU8W7t4JLT9dS3qKXMsg/zXfH+M2P6KyFqWZmGC5QQIgMmZ5ZEFsh7TZAgiK
 fuuPiAzTzrqfZIncjdqFmRK6ivpVNWIPg9x1+aHkn8QS9Mw9i8OQrbhJAPsxRQ+6MVH1beVR0Kd
 4Y=
X-Google-Smtp-Source: AGHT+IH3vtue75+aEA2hc/F5mO9izYPsUdMyGW7IxX2KcqDFUfI+4z3BdLEyaEZD2WHQZkgRdjNUuaS7bvCZSH3i+yc=
X-Received: by 2002:a05:6402:50cc:b0:607:4c8e:514d with SMTP id
 4fb4d7f45d1cf-611a6599c43mr3332933a12.6.1752088652042; Wed, 09 Jul 2025
 12:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250602194507.15159-1-malysagreg@gmail.com>
 <20250602194507.15159-11-malysagreg@gmail.com>
 <20250605171248.GB1382132@bill-the-cat>
In-Reply-To: <20250605171248.GB1382132@bill-the-cat>
From: Greg Malysa <malysagreg@gmail.com>
Date: Wed, 9 Jul 2025 15:14:12 -0400
X-Gm-Features: Ac12FXz-WjYjPkjsJ8vk7dBduYm4BRho9G5zMkWF1_weiljuxHP45yailBaMkJc
Message-ID: <CABdDSeVrA-XyDhEHC6p_vvaQwM+Dh5xE6Ct=+VXjcd0Tq_8_6w@mail.gmail.com>
Subject: Re: [PATCH 10/10] MAINTAINERS: Update ADI entries for new boards
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, adsp-linux@analog.com, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@kernel.org>, "Molloy, Philip" <Philip.Molloy@analog.com>
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

On Thu, Jun 5, 2025 at 1:12=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jun 02, 2025 at 03:44:48PM -0400, Greg Malysa wrote:
>
> > This adds missing maintainers entries for the ADI SC5xx defconfigs.
> >
> > Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
> > Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
> > Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
> > Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> > Signed-off-by: Greg Malysa <malysagreg@gmail.com>
> > ---
> >
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d62dd35a385..cee5f1a9271 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -631,6 +631,7 @@ F:        arch/arm/dts/sc5*
> >  F:   arch/arm/include/asm/arch-adi/
> >  F:   arch/arm/mach-sc5xx/
> >  F:   board/adi/
> > +F:   configs/sc5*
> >  F:   doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml
> >  F:   doc/device-tree-bindings/clock/adi,sc5xx-clocks.yaml
> >  F:   doc/device-tree-bindings/pinctrl/adi,adsp-pinctrl.yaml
>
> This doesn't also catch the other drivers and so forth added. Perhaps
> the "N: " regex syntax would be helpful here, to make adding all of
> those as well easier? Thanks.

Thanks for the feedback, I'll review the names again before v2 and
look for any missed entries. Our names are a bit inconsistent: some
adi, some adsp, some include sc5xx and some do not. In v2 of this
series we could rename the defconfigs to adhere to a useful, specific
naming convention, and then follow up by renaming drivers across
different subsystems in a separate series so that we can have one N:
line and catch them all. Do you have any tips on tracking down files
that are missed? Using scripts/get_maintainer.pl with a list of what I
think the files are could work but I won't know if I forgot something
that way :-). Is there a particular way to invoke it that checks all
files, perhaps, and reports on files that are missing supporters?

Thanks,
Greg
