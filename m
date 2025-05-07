Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE613C3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 15:45:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7251F81F32;
	Wed,  7 May 2025 17:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="JMLB20GG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA8AB81FAB; Wed,  7 May 2025 17:45:04 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89DF18059D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 17:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adriano.cordova@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8022F3F20C
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 15:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746632695;
 bh=denMvzi40uWLn5G5sbzl6A+JXCHDcGgOZx6kkbsa9F8=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=JMLB20GGPElT3cjz86Pwcr6sX5hYToMwXYKO0+EJ7y8aDHDruUNfGLTRhpG7emmrz
 5mwOHaw+7Lho3+10rbdnk9T6LriMQGaIKnwvOXguxx8/eHWlcpa2I2/bpoP/vQ79nv
 tj1ElktnByflA9Qwu5amGJ4NZtYbPYMH9DCgGpDTvumU6ZXr/9f4OkYdXIXc+Ol8pj
 STtg38NTdfdMIGEbs1xuthIyCOANFW443MH5hj71cQgN0JtLR8NiOLtXJBHJ/HZx4w
 5YO7//Qi6m6tqDdmm+3ffq3X97RZ6QFURVf6mzDqeAYLoHbvO9N7NKbH7k5vc1+2We
 Y8otwfQVS5BZw==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a0b6cb5606so11198f8f.0
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 08:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746632694; x=1747237494;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=denMvzi40uWLn5G5sbzl6A+JXCHDcGgOZx6kkbsa9F8=;
 b=rscnBe+ZDcVSGQH1RLdJ4DiOiDiSjhZ+eoaz2ATlqm+6CcGHUNylZhZzL64azYIr8U
 oNyIXh4wyXxrWPYKtF+xlMkmGeR2MRVE0Fi4husjc9AnjzP+uO8jphonPQPCuRtt67rz
 NymHadNbTilOgRgrxD06JiHc4rpsNTAuR18qJwfx8PJZDFzIYXmr4m+xRe/sbrdWC5cK
 LGycEKTkg40b++TD6UG8/8LDW9PoMiBfI6Ixh9ASU4wdsFqgyPDfNgG6khGGjqd90CeY
 IUILrzdNa6CadjvdGv6xCbTPiUpCfHxS0lcDOmAuLkdsGaRwfUUfGmGqUPU6PPq+pzA+
 b7TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQXNiqvIfLoN2pc95pMoUtJ7KATNKR6IbKDSXkEWGOUFjCKgUrJzXiYL5wzjIoKyDpgszfvkQ=@lists.denx.de
X-Gm-Message-State: AOJu0YynegoY5YoPm/rY7OkMj9XvNG+vCCn5/uxuW1eM8U94pg3b6I8l
 wxeG2O3EDkGvPSN5hsGP9unFcPsGavjnIiX3mnNq5U+O+XrPK9K/vVWeJshO7X2t5K7U+PpDxD0
 w3EGEaMudIkbdhB5Wmj+xIO0HcizStVD4VRJSVvVcOGaCw7rkFpMZYEA4hXb7RKEl+H0K7n7uCT
 g/AKDyj0n8nuBQU/ZNTqbxsTOHk9qdN079EWnS2JiiUA==
X-Gm-Gg: ASbGncsIvwHcJrfccnsDN0SGUlgnYYKXCqaHAWhi9K47sF34FQwIfchczkgKcuHRNdN
 4YnD4PCcZZD6aIUyTxt8pai64tMUH15v8uYqM2oc9ITITIIMCj9fHF24IDwnRgL2EkjVa
X-Received: by 2002:a05:6000:1ace:b0:39f:e7b:2c87 with SMTP id
 ffacd0b85a97d-3a0b4a22c7fmr3313140f8f.29.1746632694367; 
 Wed, 07 May 2025 08:44:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzN4WhjGa5OXpXs35kENDOABo+xXs+NvxLk7dqxa3DC3F9s3X6n+eUQCH2VbwgE0FPlhG/uUX5qwDj0QPkIYA=
X-Received: by 2002:a05:6000:1ace:b0:39f:e7b:2c87 with SMTP id
 ffacd0b85a97d-3a0b4a22c7fmr3313127f8f.29.1746632694063; Wed, 07 May 2025
 08:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250507144619.3288456-1-adriano.cordova@canonical.com>
 <20250507144619.3288456-2-adriano.cordova@canonical.com>
 <700D243C-61F5-415C-8506-8DB58F23E04B@gmx.de>
In-Reply-To: <700D243C-61F5-415C-8506-8DB58F23E04B@gmx.de>
From: Adriano Cordova Fedeli <adriano.cordova@canonical.com>
Date: Wed, 7 May 2025 11:45:38 -0400
X-Gm-Features: ATxdqUFBKJ1x3Osaid0K5TofQnb3G3E8ZI6BNvNfSe4eN5Z1UAPQTStPYOKIsbI
Message-ID: <CAFQa3MLiKE6PS07zn=CLqTBJdUwR+QpG6a+aGzAfeg43T3EOZQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi_loader: initrddump: use efi_uintn_t in printx
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, 
 sjg@chromium.org, trini@konsulko.com, o451686892@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Wed, 7 May 2025 at 11:03, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:

> Am 7. Mai 2025 16:46:17 MESZ schrieb Adriano Cordova <adrianox@gmail.com>:
> >Use efi_uintn_t so that it also works in 32-bits.
> >
> >Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> >---
> > lib/efi_loader/initrddump.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/lib/efi_loader/initrddump.c b/lib/efi_loader/initrddump.c
> >index 615119043d1..8d08f7c5cd5 100644
> >--- a/lib/efi_loader/initrddump.c
> >+++ b/lib/efi_loader/initrddump.c
> >@@ -99,7 +99,7 @@ static void error(u16 *string)
> >  * @val:      value to print;
> >  * @prec:     minimum number of digits to print
> >  */
> >-static void printx(u64 val, u32 prec)
> >+static void printx(efi_uintn_t val, u32 prec)
> > {
> >       int i;
> >       u16 c;
> >@@ -342,7 +342,7 @@ static efi_status_t do_load(void)
> >               return EFI_LOAD_ERROR;
> >       }
> >       print(u"crc32: 0x");
> >-      printx(crc32, 8);
> >+      printx((efi_uintn_t)crc32, 8);
>
> Why wouldn't the code work for u64 which is defined as unsigned long long?
> That type must be supported by all EFI architectures.
>
> Best regards
>
> Heinrich
>
> To be honest I do not know, but it does not run. The function printx works
with an u64 argument, but it is currently called with initrd_size,
which is an UINTN as returned by the LF2 protocol, and with crc32, which is
u32. The compiler should do the conversions by itself, but
for some reason if u64 is used the app initirddump.efi does not run on
riscv32: the booting freezes both locally and in the CI and is not
debuggable by printf statements (i.e. no printf in initrddump:efi_main(),
even before the first call to printx, prints).

Best,
Adriano

>
> >       print(u"\r\n");
> >
> >       return EFI_SUCCESS;
>
>
