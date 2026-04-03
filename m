Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4E8E8536A
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 13:21:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF77983DC9;
	Fri,  3 Apr 2026 15:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OZRiOSdH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18C838407E; Fri,  3 Apr 2026 15:21:34 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA6B583642
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 15:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b980785a0bfso238900266b.3
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 06:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775222491; cv=none;
 d=google.com; s=arc-20240605;
 b=OW0CoK2Y16ZwpeVeRkdpr3tF01iqfYFZt3bhbx9PT/GxbtbLfoNphMZanD5sXYXoom
 yYVHxroUOeivX9fbWlgd0meoL+05tdV6h01g1baOg6MtKHbseAnptz+J92CyAjlAO/1p
 Y8t6TVq6WMWe7TE1gM6cuUuHAjEkB/OR/J7owiSTkruGPVi0XqO0eHqXFELC4OL8i6zn
 tp8nWv45ZMQFzLwjQEpCwIVURmZaW38HsF9Qe0z4EJzlK/o3xcXu4K2gFklHHgo3bBdm
 a/ylDW9lM0GufQJNTPaATGrJpCRzCyHqKFt1FwXdkZwZoJ9CHSxw/iUUpxzqxMAdja46
 mmQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eWBIbtU+ViD5dwNrZAetFbwwYusA5fBDMX8u787DLA8=;
 fh=5aZ/Uc5Ywtkf/zmUnQVnxrdfy0B6r4qSK4qv4k7beVk=;
 b=N4fKgj9CF2arMOwTKKwjrCcFrC/5iuYZwQJLnnBIdJjS+fFK4PyDBbdRmRkZHXItjM
 sTe6Qbdby+/U7a06VIyw/+94Ggl8pmyarVs+g9Om0i4dCl49b5vMqJNDkVL2qi/KWYNm
 ANfOvKwL8gVpk4lZ9BXX9KNMiTS39rnIkgopUXnXbjeN5/SXM8oUw6pqDUPqN6H5oEV0
 nc0MIxoRInsM3rPBTSLYr1U7fmbAFq1mUfFIn1GIx0EG9a2wbn9JSyxVgbddDVDT3k4a
 pfxofUwcDCu4532czu6gu6tpniy+eJhXo8/WJBKnmf9P2XK3vQWJeX7aVsBKPLNUYidR
 1Upg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775222491; x=1775827291; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eWBIbtU+ViD5dwNrZAetFbwwYusA5fBDMX8u787DLA8=;
 b=OZRiOSdHDTgvEJIhH+MJab74KKegAnh0lIeYH2L3YCP7xvOWiDFZHtgUMukN6AnO/l
 ZkZY1WpUABPItTc35HnfWGxNXOmeCYhHi4R96X3ao8e05oVl2uZu80XG5SNZoUEM/33B
 2Gl1wx3n+5SzHkEBr4MjLkT99aVEHi6IDuaiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775222491; x=1775827291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eWBIbtU+ViD5dwNrZAetFbwwYusA5fBDMX8u787DLA8=;
 b=mrsgcFkRvMAIwmWBP7N9RecvCieNhXyuxwEfR2OyG0B6QLsR24w1OF0obf9toGDNOy
 F0goMOa9eGEdwmJDPWj3HFJsJODamKF0Zn0/yvSd4qlTY2pRxg7KtLpJeP5NHOrzUdXk
 tY3/buZVEJQ9H6Far3vmqkvTpp/LRggfspNbcngwgYd9UF7aIjV/G8D32Q1TPvlmQ2Rn
 NNAqvshQCql/LJwiAVdYwTHRwDvJD63Wk0aT9euz+YrthJB9rFQe9bU5reax1mkat4OL
 moncotHLhcjdHrB6h90oKx8kilF6idAInjq3LXQdBwA7KtIUmIqP4DuvByuFBlELgtz+
 2HGw==
X-Gm-Message-State: AOJu0Yz/jKRcxhnaeIb0PcGeNtV+z7kLFKTeWKWlIYP4jnbJHAYAHV9S
 2A7pm//GGvxO7vOsyHkCC2Xvx8HqHaM0+9RNCRAczgMhlehITv6s56/ze3UVy5BpBBeUiZG16aT
 pRWj/7Vp1n76I3vfmnBEXlR0y3Cey6K1T1P6VMiir
X-Gm-Gg: AeBDiesKxJzHyzh4mtPqBtu1E3X1Sb3w2r4ZmPh1oec1wze7/Lh2iTLUrCQ6T2s/6DF
 R2cPFxUWHRPoZhOpIWl14hZZ+54C6HG1dEioHY97sCYLFM985uiW4NDx37twYQm96ElTSEc61FU
 F3VDOwk204sm6QdAUZCgeiOhr8ivlgKQMxjaka4TWf3QPe6WdpWhXxRueOq9fUPVYoR0WRg+gY/
 X6r/DDB+RIY+ca2gPVFcQgJ1j6XOogWNhKFic5WiM9ubME5+hZf5E/4UO20oYiMymZu6LehWZUW
 tPxMWg==
X-Received: by 2002:a17:907:d06:b0:b97:98b3:67ce with SMTP id
 a640c23a62f3a-b9c677fc14bmr143566766b.32.1775222491135; Fri, 03 Apr 2026
 06:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260331032525.62304-1-S4210155@student.rmit.edu.au>
In-Reply-To: <20260331032525.62304-1-S4210155@student.rmit.edu.au>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 3 Apr 2026 07:21:19 -0600
X-Gm-Features: AQROBzBC9DwqKpu69p5Z63efmtfNYztyxQSA6dprzoXiWiFsgklvIR305wiHcJs
Message-ID: <CAFLszTgMH2hH--g3fe9mmpWuyBo9oQ3f6aQTOsRvnLFx37mhdg@mail.gmail.com>
Subject: Re: [PATCH v2] common: cli_hush: fix console_buffer overflow on boot
 retry
To: ngotra27101996@gmail.com
Cc: u-boot@lists.denx.de, Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On 2026-03-31T03:25:11, Ngo Luong Thanh Tra <ngotra27101996@gmail.com> wrote:
> common: cli_hush: fix console_buffer overflow on boot retry
>
> Add const_strcpy() macro to <linux/build_bug.h> that enforces at
> compile time that the destination is a char array (not a pointer),
> the source is a string literal, and the source fits in the
> destination including the NUL terminator. It uses __builtin_strcpy()
> so the compiler can optimize the copy.
>
> Fix the console_buffer extern declaration in <console.h> to include
> the array size so that sizeof(console_buffer) is valid at call sites.
>
> Replace the unbounded strcpy() in cli_hush.c with const_strcpy() to
> catch at compile time any configuration where CONFIG_SYS_CBSIZE is
> smaller than the boot retry command string.
>
> Fixes: 657e19f8f2dd ("cli_hush: support running bootcmd on boot retry")
> Signed-off-by: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>
> To: u-boot@lists.denx.de
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

> diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
> @@ -76,4 +76,27 @@
> +#define const_strcpy(d, s) ({                                                \
> +     BUILD_BUG_ON(__builtin_types_compatible_p(typeof(d), char *));  \

The macro checks that d is not char * but not const char * so if
someone passes a const char array, the first BUILD_BUG_ON passes
(since const char[] becomes const char *, not char *), but
__builtin_strcpy() would still fail because it cannot write to const
memory. The error message would be less clear though.

How about a check for const char * as well:

    BUILD_BUG_ON(__builtin_types_compatible_p(typeof(d), char *));
    BUILD_BUG_ON(__builtin_types_compatible_p(typeof(d), const char *));

Regards,
Simon
