Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAB3EE4993
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 17:49:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91200869E9;
	Sun, 20 Aug 2023 19:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MsBxu6I7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFDD386A97; Sun, 20 Aug 2023 19:49:27 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC486869CD
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 19:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4ffae5bdc9aso1689294e87.1
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 10:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692553764; x=1693158564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QOk0sqwnJCCZey/go6gNOWfL7vjM19RJg+NlIj4lV64=;
 b=MsBxu6I7R78ff/SaFePa8mp2bNfwaUGSvvPh+iJwOJ0F/xJ5Zq0+DS0NVakNImpph8
 BHIYJH6ZlBMP3Dlvcbdj2cKxUS8LDyuvSr5viras0mjKm1cn9V3w9UVKBAAM2ZHiMe0/
 IJFZYv/F0xAgEb29Q4uDKIwYL7X7gh8OVrkEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692553764; x=1693158564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QOk0sqwnJCCZey/go6gNOWfL7vjM19RJg+NlIj4lV64=;
 b=dnJ9TOcP+49/CaOJzXAHZ8DXLCmnJ5rKHKA+1qcTPn4LrVuyP2XchD6bkrRlBMyLqc
 VDxqs82aiSAPe9qWpLX8FNnlVEjSrV6iqJ9lqQjeGVJqzYsEEPgzo19Z/i1F0MfqFRXg
 xG/f3XPuQzLt1Gs9+m7650bVv63unFxxDNcGZQhDJ7Sg8otxVYdBNVX9zG680/vi5rAq
 u4TMDLqh1QgImhTMvTxOn1WQuqUqn0arreU2pjnUL/Afw1C3iN4CmK3FcKpkGp41j5q1
 x3Y8mtw/ltdSUWdsNFcxj+P1QXjBXXzf3e7skzzQYmYbpGKzBCb6iSZmtlayh7uWtuuk
 upog==
X-Gm-Message-State: AOJu0YxoDsJq0ND6ZPsOptPrHJcLTRfd8QHi9BOY0LCE/8lhmCH0Rzct
 jXhfGvwSYaWykjceS0tyyY/R3WE1B6BQ3fyNjInf1A==
X-Google-Smtp-Source: AGHT+IFRnpTjQ55ka72AOvTSPXDa+EUNbxzhDDBsh5A4N2z88YQthWy1ieLlHuiOKze0Yi0l4hNZTudJSSzQzY4yFAs=
X-Received: by 2002:a05:6512:3045:b0:4fb:89b3:3374 with SMTP id
 b5-20020a056512304500b004fb89b33374mr3850008lfb.54.1692553763719; Sun, 20 Aug
 2023 10:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230819212309.1094440-1-sjg@chromium.org>
 <20230819212309.1094440-13-sjg@chromium.org>
 <4d09f5d8-bf1f-f9fe-e607-c6cf648789b6@gmx.de>
In-Reply-To: <4d09f5d8-bf1f-f9fe-e607-c6cf648789b6@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 20 Aug 2023 11:49:12 -0600
Message-ID: <CAPnjgZ0ae+Hc6ZfUHkqo08ryO9T5cwpPZNLPCEjqObb6y9bFOA@mail.gmail.com>
Subject: Re: [PATCH v3 12/19] x86: smbios: Add a Kconfig indicating
 SMBIOS-table presence
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Sun, 20 Aug 2023 at 04:00, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 8/19/23 23:22, Simon Glass wrote:
> > When booted from coreboot, U-Boot does not build the SMBIOS tables, but
> > it should still pass them on to the OS. Add a new option which indicates
> > whether SMBIOS tables are present, however they were built.
> >
> > Flip the ordering so that the dependency is listed first, which is less
> > confusing.
> >
> > Adjust GENERATE_SMBIOS_TABLE to depend on this new symbol.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Allow SMBIOS if EFI_LOADER is enabled
> > - Reword the help
> >
> > Changes in v2:
> > - Add new patch
> >
> >   lib/Kconfig | 15 ++++++++++++++-
> >   1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index a9dca5f52b5a..8901b3a87fc2 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -984,8 +984,8 @@ config BLOBLIST_TABLES
> >
> >   config GENERATE_SMBIOS_TABLE
> >       bool "Generate an SMBIOS (System Management BIOS) table"
> > +     depends on SMBIOS
> >       default y
> > -     depends on X86 || EFI_LOADER
> >       help
> >         The System Management BIOS (SMBIOS) specification addresses how
> >         motherboard and system vendors present management information about
> > @@ -1054,6 +1054,19 @@ config SPL_OID_REGISTRY
> >         unambiguous persistent name (https://en.wikipedia.org/wiki/Object_identifier).
> >         Enable fast lookup object identifier registry in the SPL.
> >
> > +config SMBIOS
> > +     bool "SMBIOS support"
> > +     depends on X86 || EFI_LOADER
>
> Is there a calling convention for the legacy entry point of Linux to
> pass SMBIOS tables on arm64 and riscv64?
>
> > +     default y
> > +     help
> > +       Indicates that this platform can support System Management BIOS
> > +       (SMBIOS) tables. These provide various pieces of information about
> > +       the board, such as the manufacturer and the model name.
> > +
> > +       See GENERATE_SMBIOS_TABLE which controls whether U-Boot actually
> > +       creates these tables, rather than them coming from a previous firmware
>
> Thanks for updating the help text.
>
> This implies that CONFIG_SMBIOS must be used to decide if
> efi_smbios_register() is called in efi_init_obj_list(). This change is
> in patch 14/19.

Yes that's right, since we still need to install it if the platform uses SMBIOS.

>
>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Thanks for the review..unfortunately I found that on ARM (and probably
RISC-V) U-Boot does not create this table. On x86 last_state_init()
calls write_tables() to do this.

So I will have to adjust this...

Regards,
Simon
