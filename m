Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC2AC36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 11:27:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E28348070C;
	Wed, 26 Mar 2025 12:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZntbUc/9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EE7E8083E; Wed, 26 Mar 2025 12:27:17 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBD85806FC
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 12:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e4930eca0d4so5281766276.3
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 04:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742988432; x=1743593232; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DX1bDdABqUAyOq53ZG4TVHsdUUSgRUhn5KM7hPwWhb0=;
 b=ZntbUc/9HVRDPlQUbEFOi5O+NfeY/Zbhrq7+hwbU9PoKTGklpyJZ6RIZQB5BBjc7k1
 VT6r7isvOc4PUXKuBD4eMpR1TgHRayUZ+6gnlBp+EzU0v3vcSE7bDcFGSD4kgPlpsNTG
 O+AwhK58KKCQLtLgDPna6f8mDsQYSsg7ZPQItYKssERkgdsmDWo1dQicDCSjtuq0X5Jb
 09T1nn7LHtWzEPYLNQDrX6I1OEMmkapXq83F8PP4NH08fmcynMZDcmxXmV0D8Ya3581w
 npSV6YjOLgceIZg0K6XiI5LVT/WLR+YM7ZHSb35CYc6niXE/NAGzbnInAwQTYcvuLt8q
 lYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742988432; x=1743593232;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DX1bDdABqUAyOq53ZG4TVHsdUUSgRUhn5KM7hPwWhb0=;
 b=V1DscSfxrKpoACEnM+uhJb9QZ/IksRCzhYd9denVNgVD0cTXE8s0YsS7tnDYmRN2n4
 hauj8yw+zKX5sFH5s+1GS2Sbhdme0hbo3iAEIAAAcxpWtF93TxTJNGmFd8g5XUmPpWJ0
 whyyrWapajuuPeD8sv80MPHo6A0aVmIVmq09ehEAaXC9HusNQyutjvhoMomIo1Ba2iwv
 6orjR77UTLWJcwai2h7E/5bAwo8ga7VyOkYDWo7BOGSTrSHnjNrcs2GW1llQJnJO2fw6
 5rYND1GmPaMPa64KWeVcSnzcLqfnav9UOXfOjCn9YSwq2+oC/Bcy9ocrmaRo13w/e3K5
 88/A==
X-Gm-Message-State: AOJu0YzsWFOak4rKnIyR6sV5wzqyW5Jm8R+LAcSDjXzLpYc3IAc9lAM8
 3hETj3i81JNRomv6gvmn73MPIBJDdlbPIJCow12PO+t30igJQ8Blp6D3aXYIFK5hfky5Vli/ZWi
 qjlA76OI2jxIrp0FY5bFdj+KCZlIqve8dUE6ccQ==
X-Gm-Gg: ASbGncuRe1lveseiPZoTCrcMTupOs2XIsIz/bWbWwgbScbusPRbP9DzIoZlPG2MV8J7
 tVGNx3iaqZ+cJ8tkz1RmpVKu4sXlQUdO1cf1t5cO7gkHVXU1+shDmV4UuWYJj2YhwMQXYDhGfIT
 YFzK8dcAMWGaGZ0UmP65G6A+41FaU=
X-Google-Smtp-Source: AGHT+IEAkpk0fOU/MG+It0zjHcqTz9lOoZuiZFM7Gp9sHYx5aEagVhtXjuETKIZBhpE4Oy9yM2EP803PUhwxEbeNa8s=
X-Received: by 2002:a05:6902:2203:b0:e63:eea7:8f95 with SMTP id
 3f1490d57ef6-e66a4fa20e4mr24482621276.38.1742988432423; Wed, 26 Mar 2025
 04:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250317083402.412310-1-sughosh.ganu@linaro.org>
 <20250317083402.412310-3-sughosh.ganu@linaro.org>
 <CAC_iWjJgOwvovyLTtiDu3PqMvCFX4SrOGj6CCE5QQMV-Ypq=Tw@mail.gmail.com>
 <CADg8p96AwQQvR-0C7QfggKtoLGT1Hn4zcAAww-bH-Cc2=HdABA@mail.gmail.com>
In-Reply-To: <CADg8p96AwQQvR-0C7QfggKtoLGT1Hn4zcAAww-bH-Cc2=HdABA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 26 Mar 2025 13:26:36 +0200
X-Gm-Features: AQ5f1JqO3zFfPMBIR1t__MDdgWxNWQlR0cv0fR6EvhFqQCyAjW_KPD8tNxHQJtQ
Message-ID: <CAC_iWjJ=gHYSUqSGP1JmUdV3YuH99PMQ___7NfooHjNGrWW=PA@mail.gmail.com>
Subject: Re: [PATCH v9 2/8] efi_loader: install device-tree on configuration
 table on every invocation
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Antonov <Anton.Antonov@arm.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>
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

[...]

> > >
> > > -               /* Look for device tree that is already installed */
> > > -               if (efi_get_configuration_table(&efi_guid_fdt))
> > > -                       return EFI_SUCCESS;
> >
> > This is the last nit I have an I think these are ready for  -next.
> >
> > Instead of removing the existing table in copy_fdt, can we remove it
> > before calling copy_fdt() in efi_install_fdt()
>
> I had actually thought about this, but did not put it in the
> efi_install_fdt() as we have a case for GENERATE_ACPI_TABLE, where we
> are not actually doing anything with the device-tree. So copy_fdt() is
> the place where we know that we are going to install the DT as
> configuration table, so then remove the existing configuration table.
>

Fair enough, leave it as is. I'll queue the patches shortly

Thanks
/Ilias

> >
> > if (efi_get_configuration_table(&efi_guid_fdt))
> >     efi_install_configuration_table(&efi_guid_fdt, NULL);
> > should be enough and you can also check the return code that way
>
> For the above scenario, we will not be getting any other error than
> EFI_NOT_FOUND no?

The config table is there it will remove successfully no


 If you have a strong opinion on this, I can make the
> change. Please let me know. Thanks.
>
> -sughosh
>
> >
> > Cheers
> > /Ilias
> >
> >
> > >                 /* Check if there is a hardware device tree */
> > >                 fdt_opt = env_get("fdt_addr");
> > >                 /* Use our own device tree as fallback */
> > > --
> > > 2.34.1
> > >
