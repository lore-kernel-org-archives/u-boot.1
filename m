Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE1DC4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 13:46:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AFAC88F75;
	Thu, 25 Apr 2024 15:46:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UDu0j2sg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0BDD88FAC; Thu, 25 Apr 2024 15:46:41 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ACA788F72
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 15:46:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a56d7d457a1so122498366b.1
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 06:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714052798; x=1714657598; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C/A6qNgSji5q+GEjg+T43A+VL/sYq0yyp+rgFeCOs/U=;
 b=UDu0j2sgEz8gFLLR5+uQZdCKJMw/3isxnSXwjVuaF/9syYrHKE54v08e24TPJGBv85
 C1e4a9swYhP9GaC0d6OzPdj7xGRXCjeYa8NhNil6Vhv6K9bPwt2lYqxvhtmyTAVxtTB/
 fAE35KMkdHf8gf7LIS6JcI/LMmpROtFAlzFnly3BErDKM7fNubfL0V1bzQFMS3VGX3az
 Ma0SeIekakvWuipd8/ZRd5zzyJ1RGMEyQAOtU/UWTDoXL5p4tbXqzFIkPAPTy62kigbx
 NBXNAdFZ/tUNw7ax4CrspZAeuOS3sEK0oxdT9BYRHNWwPkloiwpOqzn2oiiwZHQPlpS7
 Dw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714052798; x=1714657598;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C/A6qNgSji5q+GEjg+T43A+VL/sYq0yyp+rgFeCOs/U=;
 b=bHGK6ALUgaQ+Vdt5bE+YEMBZGctdhMqUdNqlbwGQ6i/6kL2lB6QhmWpSUayIBOORgc
 MxFEfgfQceLVBiZoJJl13WmIGr8EtViLSaGhMJdE7OFMAOl+k0RwnXjWlj2fqxGAXjLU
 MRMOHjeZd/TfI4kepP4JeknkwEjs+354cbcRfDAbTyhs+ddFeyV36Zpq06DM+M6AehNh
 JFLZh1SnSQ8taRr0/hNIzyp0rllzltZxwm6ve+1y+H5v+tua83CzDxms4tAU8gx9zTvP
 coN4xJBXXL0sVM6FZYnPvkPcAj6tUd/ZoeitHVQ6mwHgy8wdgc2cYfeZUVAmtGrP9/bu
 r+6g==
X-Gm-Message-State: AOJu0YykVZO1lNn6pTwSAwa0Pkgz1KYBqRJl4/We0SH2sBHucEfEJ7HK
 Q28mPfu55AUCLUyy6XQMNmCHBRhPbPOKtcWTSE63oHKb2GAnifuNIhCaG2ST7BhCOZ/qUZGeuEN
 Wk77ehTygzbSTparIpC+hsP+dn02od01FKyLdbQ==
X-Google-Smtp-Source: AGHT+IGoBIOPxqQNaYw9JZ5pv/xRTKOTzX7tVE7XugEbiZA7yrWh1n5uSfgRmKbuZt3SRInRm8GFczh00W7vaVrq0dk=
X-Received: by 2002:a17:906:f2d9:b0:a54:4f06:4d00 with SMTP id
 gz25-20020a170906f2d900b00a544f064d00mr3728097ejb.65.1714052797864; Thu, 25
 Apr 2024 06:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAC_iWjJNHa4gMF897MqYZNdbgjFG8K4kwGsTXWuy72WkYLizrw@mail.gmail.com>
 <CAD2FfiGuFaC=r+TGfq9auzWJbyzVNbug8zR9RzSwM2+Uk52d+Q@mail.gmail.com>
In-Reply-To: <CAD2FfiGuFaC=r+TGfq9auzWJbyzVNbug8zR9RzSwM2+Uk52d+Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 25 Apr 2024 16:46:01 +0300
Message-ID: <CAC_iWj+BonsVbA5Bw3Kck2k4b8SXru0U_Y2kAmx5=_t6SozotA@mail.gmail.com>
Subject: Re: Capsule GUIDs and LVFS
To: Richard Hughes <hughsient@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Jonas Karlman <jonas@kwiboo.se>, FUKAUMI Naoki <naoki@radxa.com>,
 chris.obbard@collabora.com, 
 Paul Liu <paul.liu@linaro.org>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Michael Walle <michael@walle.cc>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, 
 Michal Simek <michal.simek@amd.com>
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

Hi Richard,

On Thu, 25 Apr 2024 at 15:28, Richard Hughes <hughsient@gmail.com> wrote:
>
> Hi all!
>
> > Any ODM/OEM creating a board
> > based on the original device must use his own
> > GUIID to avoid confusion. If not we would end up with different
> > devices reusing the same GUIDs and upgrading their firmware with a
> > different one.
>
> Yes and no. Of course it's never okay for vendor A to use the same
> GUID as vendor B -- but if vendor A has two models of hardware (for
> instance model C and model D) they can have the same capsule GUID if
> the update can use a DMI match on the product SMBIOS key to identify
> the system.

In theory, yes but we don't have any of these check in u-boot and I'd
rather avoid them and do it properly

> Of course, it's much better if they have different GUIDs
> in the ESRT to completely avoid the chance of the wrong firmware being
> flashed on the wrong device.

Exactly.

>
> > Richard, the following GUIDs should at least issue a warning in LVFS
> > since they only work for QEMU & Sandbox internally.
> > Sandbox SANDBOX_UBOOT_IMAGE_GUID 09d7cf52-0720-4710-91d1-08469b7fe9c8
> > Sandbox SANDBOX_UBOOT_ENV_IMAGE 5a7021f5-fef2-48b4-aaba-832e777418c0
> > Sandbox SANDBOX_FIT_IMAGE_GUID 3673b45d-6a7c-46f3-9e60-adabb03f7937
> > QEMU QEMU_ARM_UBOOT_IMAGE_GUID f885b085-99f8-45af-847d-d514107a4a2c
> > QEMU QEMU_ARM64_UBOOT_IMAGE 058b7d83-50d5-4c47-a195-60d86ad341c4
>
> Are these GUIDs that should be "never allow a firmware to be moved to
> the stable remote if it uses this GUID" or more "a firmware also needs
> a DMI restriction before being allowed near stable"? I'd err on the
> former for these.

TBH those are GUIDs that are used by virtual devices. It wouldn't hurt
if someone reused those GUIDs but we can display a warning about it?

>
> > I've cc'ed all the people I could find in board specific MAINTAINER files.
> > Can you respond to Richard with the proper company name & board name
> > so we can bind the following GUIDs to a vendor properly?
> > Richard any guidance on how this should be done properly is
> > appreciated, since I am not too aware of LVFS internals.
>
> The LVFS doesn't need "pre-registration" of GUIDs so to speak; we have
> have two deny lists of GUIDs -- one for "this is never valid" and one
> for the "this needs a DMI match"

Ok thanks for the info. Is there also a check of "I have duplicate
GUIDs that aren't in the DMI list'?

>
> > STMicroelectronics STM32MP_FIP_IMAGE_GUID 19d5df83-11b0-457b-be2c-7559c13142a5
> > This seems to use the same GUID for multiple device variants. This
> > needs to be fixed
>
> Is the DMI data different? e.g. you can see the Windows CHIDs (we use
> the same DMI restriction scheme as Window 10) using
> ComputerHardwareIds.exe or on Linux using `sudo fwupdtool hwids`

I hope ST answers that, they are cc'ed

>
> I've created a spreadsheet of what we do now, please feel free to add
> GUIDs (anybody!) to the correct column:
> https://docs.google.com/spreadsheets/d/1uPQmUrGA1KKsDPzGeg4xb2XOQEfsjDBBP9SQjqh31Wc/edit?usp=sharing

Thanks!
/Ilias
>
> Thanks,
>
> Richard.
