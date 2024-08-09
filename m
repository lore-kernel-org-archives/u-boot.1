Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD05C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 05:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABB5788AEE;
	Fri,  9 Aug 2024 07:57:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aA34bKBT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B03F084374; Fri,  9 Aug 2024 07:57:17 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB62888AEE
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 07:57:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4281c164408so12090165e9.1
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 22:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723183035; x=1723787835; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qRKIsfGQqfptr9KoY2smOu+odWJoqUYm8N/m0x5wiPk=;
 b=aA34bKBToW6KMV+y3hqiS0CSBEvKd5BNXedKX31aJ/mfGovqLnBHv4WsuqDrzJzh1k
 /yiHEyFF3PCRuF4y8xHyhVTvUMqL+dnv8z8QbASz6Oo7FACnBeMLhN61eK49ObW6qaj/
 2iWrjxjd7JRqtvd2kEWa9guqkBBW9hEiMuEEvnTQ27B7pgCyEDTN5iOdJSsfA662jr3J
 os4cN0posOySNpMqR0MxplwQgvO/By360LmKC+95C/5czrzQfSfIq3LRrzQfOY0FeduQ
 hWX7oo8frFH67sGD52abrVqwOQ/zA8ZGB9qaI20lQbo8R24B8i8dpk+Nrxdt2pco+AxW
 APnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723183035; x=1723787835;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qRKIsfGQqfptr9KoY2smOu+odWJoqUYm8N/m0x5wiPk=;
 b=M9pK17O/CiVo/gmU2Ii2DYlDj1HQroN8lzjCusskFMnyqKIvDn3yFJ9HyVp/DNVl6C
 anPyWutUFjIiIQHcwNGLo8ZexLq4QITbjdFgxJWM3Nyp0cESGP/1QtlvGlUiBhZleSsE
 v/4Lj4OdirTdfaELBr3fEPQSPtQ+TyP9dceIRJ1EQNKhppLdmNQ8zl9rQ9976/oJKBoK
 ikkYFTRkR9zyvfoO3WnZeIedOLtg3ytUrOYI83a1VEBdLVjxXK1Qd8tL1qx3HiBg6UI1
 xa3tMDNdneeYmiBf6VmvJnf/bTjp1H7j3K875w1Fnhcknjc6kkp/N2fv8XmZ3Y9o/0/B
 iWOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+gyEzHLo4ibwKuphyh8y2WSEFiphPqqcXPfEgqOSfQacn73UCSdyVPJe9jGZ47T4ylLARCmj5iI6MbDYvc01NHwU9zg==
X-Gm-Message-State: AOJu0YzqNOVcdAHQ3THTWzL9yWONVDGHL8kDNaRUQRMw9FXUVY0ZRYOu
 lxnMXpbFNKSXiBmZdvns7a2Ssg7+Ch/tkV3fLmXJPxsxpEq9SuvgIyXaumAOQ9e6WykUySlJLL9
 X8RZq1cOmhsD2F9r7Q+zCmVJbNE0=
X-Google-Smtp-Source: AGHT+IG57ezFQ8qrSlDiWNoYFuXccbuQ2KonbE6NUAqTmEFtK6qELowjAgKn+NYs3kcHXxJPUEIMzUzhOAth+6FsG3g=
X-Received: by 2002:adf:9b89:0:b0:36d:297d:53c1 with SMTP id
 ffacd0b85a97d-36d5e3c2119mr288850f8f.25.1723183034739; Thu, 08 Aug 2024
 22:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240807121024.11318-1-clamor95@gmail.com>
 <20240807121024.11318-2-clamor95@gmail.com>
 <0C2B63EE-A95F-424A-9143-6A0C2164F666@gmx.de>
In-Reply-To: <0C2B63EE-A95F-424A-9143-6A0C2164F666@gmx.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 9 Aug 2024 08:57:03 +0300
Message-ID: <CAPVz0n1CvhkCCNDPSrPvUweBTzTFEUDFHcAP5B7Wno8RefKpPA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] disk: add TegraPT support
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Anand Moon <linux.amoon@gmail.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

=D0=BF=D1=82, 9 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 08:49=
 Heinrich Schuchardt <xypron.glpk@gmx.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
>
>
> Am 7. August 2024 14:10:24 MESZ schrieb Svyatoslav Ryhel <clamor95@gmail.=
com>:
> >TegraPT is compatible with EFI part but it can't pass Protective MBR che=
ck.
> >Skip this check if CONFIG_TEGRA_PARTITION is enabled, storage uclass is =
MMC
> >and devnum is 0. Note, eMMC on supported devices MUST be aliased to mmc0=
.
>
> Why wouldn't you use U-Boot's gpt command to fix the non-conformant parti=
tion table?
>

I would love to, but I am forced to use TegraPT and DON'T modify it.
Tegra114 bootloader is RSA signed and there is no possible way to
replace it with open source one unless vendor allows this. SO I am
stuck with vendor bootloader to chainload from which enforces TegraPT
as well. Modification of existing partition table can irreversibly
brick the device.

Best regards,
Svyatoslav R.

> Best regards
>
> Heinrich
>
> >
> >Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >---
> > disk/Kconfig    |  8 ++++++++
> > disk/part_efi.c | 13 +++++++++++++
> > 2 files changed, 21 insertions(+)
> >
> >diff --git a/disk/Kconfig b/disk/Kconfig
> >index ffa835eb35..75a849ec8c 100644
> >--- a/disk/Kconfig
> >+++ b/disk/Kconfig
> >@@ -49,6 +49,14 @@ config SPL_MAC_PARTITION
> >       default y if MAC_PARTITION
> >       select SPL_PARTITIONS
> >
> >+config TEGRA_PARTITION
> >+      bool "Enable Nvidia Tegra partition table"
> >+      select PARTITIONS
> >+      select EFI_PARTITION
> >+      help
> >+        Say Y here if you would like to use U-Boot on a device with
> >+        Nvidia Tegra partition table.
> >+
> > config DOS_PARTITION
> >       bool "Enable MS Dos partition table"
> >       default y if BOOT_DEFAULTS
> >diff --git a/disk/part_efi.c b/disk/part_efi.c
> >index b1a03bd165..350a8a6dc5 100644
> >--- a/disk/part_efi.c
> >+++ b/disk/part_efi.c
> >@@ -318,6 +318,19 @@ static int part_test_efi(struct blk_desc *desc)
> >       /* Read legacy MBR from block 0 and validate it */
> >       if ((blk_dread(desc, 0, 1, (ulong *)legacymbr) !=3D 1)
> >               || (is_pmbr_valid(legacymbr) !=3D 1)) {
> >+
> >+              /*
> >+               * TegraPT is compatible with EFI part, but it
> >+               * cannot pass the Protective MBR check. Skip it
> >+               * if CONFIG_TEGRA_PARTITION is enabled and the
> >+               * device in question is eMMC.
> >+               */
> >+              if (IS_ENABLED(CONFIG_TEGRA_PARTITION))
> >+                      if (!is_pmbr_valid(legacymbr) &&
> >+                          desc->uclass_id =3D=3D UCLASS_MMC &&
> >+                          !desc->devnum)
> >+                              return 0;
> >+
> >               return -1;
> >       }
> >       return 0;
