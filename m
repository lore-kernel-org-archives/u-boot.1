Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64DDC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 10:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16A148899B;
	Fri, 14 Jun 2024 12:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uvbkrodr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CF978899F; Fri, 14 Jun 2024 12:47:52 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0825F88962
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 12:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-705b9a89e08so1931220b3a.1
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 03:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718362068; x=1718966868; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3lWviiuEjuNjVtpmXF4vwOefkTPwSs7HIokCy4TsSPk=;
 b=uvbkrodr0K2REczRbFzgztm5Facz4L4AHJkuGmuxCq41KDOCSMuOxvWzbwzAEyTZnv
 1mB5oVW+Qdiw6XIxWVnn6Nky3F9s4qH67SjwfWG9UjPywMbGeTkAOAl5ogy0P3WOMZn6
 QycJ+Bnr5qEPUnCirBywtZ9fAgUkvEg3dSJR1AHraWVagIRbq05fxqAq8aKhdQ57pI6H
 7NTqwVGJMu6BlV90+Xv0Ve2fjLtZUrkXZbBYhkIPdtDfrsZRsQKBC9KhpR95KI+r72Q6
 +uHVCmakw0j1BoBXhbsmOde/cmZCfyctcY9id+jxI6SfcuXs3aNxd04vekcP4zkzZZUB
 VeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718362068; x=1718966868;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3lWviiuEjuNjVtpmXF4vwOefkTPwSs7HIokCy4TsSPk=;
 b=ohJqOTbyQp/KIWY6tle/7KvUBgjFTOatLdwMbHpvoZ/ACY9aQuu9EeevHKg5c3tqEg
 rGGSOMlalPOdMqMsonUW1RVR1CsKb0uA+AA+JICUoPGhEM8DJvNqwVqtIvGgfLzJJjVv
 iaji0W3WJq3b05ujZhIAKrKWdkzlOg/ZXiEeIrodkRIpwlNrzjLMeYHWnQFRdZUNfG/2
 Xw+idnN3Ijl+PsNZ2nDcIkOWnm4lmCL/B7YDh9NQxeTvvlkFTh1Dx4d8oPzHqOteMeAD
 tbir+g1ehD59M3GT6SomzTefsoktj01kMQOpSCFL9IUOXaFl/STfbaq+ZaAHS+zaJL+T
 twNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuGQ2bA1+Zq6oEMveN1naPtvqu3N0Q0Xd5YAw3VrhAJgu6pPgF8jNmOII/SvWZEANAiwc3mXolqcPPA/XIYavxl7pB3Q==
X-Gm-Message-State: AOJu0YwsIuxMln40YLL8fqX7d1bmWweH72iubWQk+TnX0vr0/nHcgEbk
 L1T2BgbqhGvAf2DSjdNXDoGllIBk6ZgxNak7cCyOF3to/aSOtpV+LN0j9kzBGR/s+CxxJ0xa7mk
 8/ToY1KCTjX87JofCmYnDfgWs24Ktm28tgyVe+w==
X-Google-Smtp-Source: AGHT+IH1H6pgUszNsqBXfpRXcgOSsQdK+Kb6u6g4Ueg0II2J7+Ueu+/N2GuhPyH9Fmkwcr8v6wIiy9nY7SkHOxlbuHk=
X-Received: by 2002:a05:6a20:3d81:b0:1b6:db6c:11ea with SMTP id
 adf61e73a8af0-1bae7e895d8mr2980988637.26.1718362068409; Fri, 14 Jun 2024
 03:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240614094031.6013-1-ilias.apalodimas@linaro.org>
 <ab7c6516-8d03-4561-b4e7-f619799416ba@gmx.de>
In-Reply-To: <ab7c6516-8d03-4561-b4e7-f619799416ba@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 14 Jun 2024 13:47:11 +0300
Message-ID: <CAC_iWj+GiFYktbALOd+mZGqPLwe+-+tD_e3MC4E1W=3=mXqz9Q@mail.gmail.com>
Subject: Re: [PATCH] doc: describe UEFI measured boot
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Eddie James <eajames@linux.ibm.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 heinrich.schuchardt@canonical.com
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

[...]

>
> > +
> > +UEFI requirements
> > +~~~~~~~~~~~~~~~~~
> > +* A hardware TPM 2.0 supported by the U-Boot drivers
>
> by an enabled U-Boot driver.
>
> > +* CONFIG_EFI_TCG2_PROTOCOL=3Dy
> > +* CONFIG_EFI_TCG2_PROTOCOL_EVENTLOG_SIZE=3Dy
> > +* optional CONFIG_EFI_TCG2_PROTOCOL_MEASURE_DTB=3Dy will measure the l=
oaded DTB in PCR 0
>
> Why does this setting not default to yes?
>
> Should EFI_TCG2_PROTOCOL_MEASURE_DTB depend on !GENERATE_ACPI_TABLE as
> we won't load the device-tree in this case?
>
> I can't find any reference to device-trees in `TCG PC Client Platform
> Firmware Profile Specification`.

It's not and I've already pointed this out to Arm. We followed what
ACPI does there and used "DTB DATA" instead of "ACPI DATA" as the
event string.

>  Where is PCR 0 for the device-tree specified?

As I said DT is missing from the spec but look below

> I read:
>
> "In general, the platform firmware measures into PCR[1] the
> configuration data that is associated with the code that measured into
> PCR[0]".
>
> This looks like PCR 1 should be the target for the device-tree.

There is a description for ACPI in 3.3.4.1 PCR[0] =E2=80=93 SRTM, POST BIOS=
,
and Embedded Drivers and they explicitly mention ACPI in there.
There's no mention of ACPI in 3.3.4.2 PCR[1] =E2=80=93 Host Platform
Configuration.

However ..... In Figure 6 PCR Mapping of UEFI Components ACPI is shown
in PCR1 .....
I am not sure if we should use PCR0 or 1, if anyone has a strong
opinion we can easily change the measured PCR.

>
> Do we already measure ACPI and SMBIOS tables into PCR1 as required by
> the specification.

We do measure SMBIOS in PCR1. I don't think we do anything for ACPI.

>
> > +
> > +bootm
>
> Measured legacy boot with bootm command
>
> Please, consider in your description that the bootm command may be used
> to load a FIT image with an EFI binary.

I am not entirely sure how this works, someone who has used that needs
to update it. What happens in that case? Does bootm end up calling
bootefi ? That means we are measuring things twice?

>
> > +-----
> >   By default, U-Boot will measure the operating system (linux) image, t=
he
> >   initrd image, and the "bootargs" environment variable. By enabling
> >   CONFIG_MEASURE_DEVICETREE, U-Boot will also measure the devicetree im=
age.
> > @@ -15,8 +35,8 @@ The operating system typically would verify that the =
hashes found in the
> >   TPM PCRs match the contents of the event log. This can further be che=
cked
> >   against the hash results of previous boots.
> >
> > -Requirements
> > -------------
> > +bootm requirements
>
> This is already a sub-section of bootm. No need to repeat it.
>
> > +~~~~~~~~~~~~~~~~~~
> >
> >   * A hardware TPM 2.0 supported by the U-Boot drivers
>
> by an enabled U-Boot driver.
>
> >   * CONFIG_TPM=3Dy
>
> CONFIG_TPM_V2=3Dy is required?
>
> Best regards
>
> Heinrich
>
>

Thanks
/Ilias
>
