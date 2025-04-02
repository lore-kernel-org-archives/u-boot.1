Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E416FC28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 14:27:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DC5581F28;
	Wed,  2 Apr 2025 16:27:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HglVEq44";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8616381F44; Wed,  2 Apr 2025 16:27:10 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77BFD80050
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 16:27:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e46ebe19368so5713571276.0
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 07:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743604025; x=1744208825; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PckDDbIguJZUy3nav+i4FCjq2Yg61xXDd+bxoD4HBXU=;
 b=HglVEq44AmyckZxYh8LXic/pU+aX7HY/ZQclqmar+XYBfIR68DnYguMRF7DSiNrzMG
 6vAgw4GNC0aXVpY1+KlmSKVWE9kh/ucHB/qQarSlw3uPYkUXEJDpn5Wv2PRGrKHwB5Bg
 3eA3a7ryNJtUyZFX6f2W3NY8Xaf0qleFrsL8mKhISrqaTxggq9H7YI4TsVSz5zT1c5tb
 Tdk4bmruyhz6CWk77bkMpAggZpwszVsjxZMCCe1W04JTbPwcwMOFe7FC8S7WSn61PgOy
 OuapqpRUsAraZyauFgmilfxVulo7gu2Z8ScRAz6+9c7cVuOxeSsylPHLpHjutKqT7r4T
 bBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743604025; x=1744208825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PckDDbIguJZUy3nav+i4FCjq2Yg61xXDd+bxoD4HBXU=;
 b=N2NnZgcEQl/OfSp5pJBzeC5W8OdnXIhlpbDgGYts8Eyj+JjH/u2B8bNPACQkOFTMln
 dlNTQtJBuRn7Xmymw694oWtRfiYXbjN7yFU6kHb+PL6s9E1e2UKBdI0ayyRWZC7EbJn4
 EzL6g8gq/PZelG1eL8IDrC9OM+PWaSEAXpJ+qsewNGeFyx47+9FGRZZ/wWMc9T0EpFz4
 1NftHxBiBy9RiDjmRhWjq6E4yv+xuGwdQGZDg+RmuynNrJ9/xpc3Ui8OOuQ0BgVWUqTz
 e96pKvLRf2PjegPhjEHaB5nR6LD+8p4F5TSk5yP8f53FmONXSXEEDGmKIyot38sxXkCt
 BD2Q==
X-Gm-Message-State: AOJu0YwIo14+00rdRAevIU+5YfER9hHBGnfUquQAq2Ejzg06+YZdjE5C
 Uczoz+e2WrVvSKqjSeDOGXF2F2QAg8iSQUQOMIIIIU7KisRlsrNdNU4gZDuih3qSkPHhtQPRjHy
 SoF6MVvmfWzK/Kt6bKXb2RYz/ihkUX02rxgq00A==
X-Gm-Gg: ASbGnctHGbxR7zfxQiv4qaExOsS+XkIFjPub85Fx4ZdU5p9cxr3eW2HXxRv6bysANHX
 PHKNlGmcjjOEAVreIHAv91vJk53OkmBI3pucnEE43Lxr/mcxiNaFWu7lL2HO/taKeWz/nr/qDMw
 K+sHA4/50zy0Vxd3Z1SXONpkUc
X-Google-Smtp-Source: AGHT+IGvKurnW2QwQ7mdYTaa96aTYgTBNrDgDWUuE2RXMb0r7nRVzf07EQapzDHWZ3WnygAwMaiBlA7jeXvPx1sbesk=
X-Received: by 2002:a05:6902:2189:b0:e63:d10e:edc4 with SMTP id
 3f1490d57ef6-e6df449c41cmr4917376276.10.1743604025169; Wed, 02 Apr 2025
 07:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+HfNj+B-LmZx7tVXWPqvK6fZ9V_iHsJ19e9MUFGF=JTVu6Xg@mail.gmail.com>
In-Reply-To: <CAJ+HfNj+B-LmZx7tVXWPqvK6fZ9V_iHsJ19e9MUFGF=JTVu6Xg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 2 Apr 2025 17:26:28 +0300
X-Gm-Features: AQ5f1JqI1AbyTFX4MOzGij3vY6Bq7KtEKlmNMWDo5r6Jrtps2grIJGzrhyk_aBg
Message-ID: <CAC_iWjJyBjGnK6Wv0qXvZ-ujnZ9anc+bw_q-0qCRk-3XAGC4bw@mail.gmail.com>
Subject: Re: RISC-V UEFI/ACPI on QEMU regression?
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hey Bjorn

Long time, hope all is well!

On Wed, 2 Apr 2025 at 16:22, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wrote=
:
>
> Hi,
>
> I think I got a regression from commit 53d5a221632e ("emulation: Use
> bloblist to hold tables"), and v2024.10 for
> qemu-riscv64_smode_defconfig + acpi.config booting Linux with UEFI.
>
> TL;DR: It seems like the RSDP is placed in the wrong EFI memory map
> type (it should be "ACPI Reclaim").
>
> I might also be misunderstanding what config fragments should be
> used -- I'm out in the weeds here! ;-)
>
> When I was using v2024.10, ACPI RSDP was in ACPI Reclaim memory. All
> good, and e.g. a kexec would properly work. However, when using u-boot
> with commit 53d5a221632e ("emulation: Use bloblist to hold tables") I
> get the following when booting, and then kexec:
>
> First kernel:
> [    0.000000] ACPI: Early table checksum verification disabled
>                                                   [    0.000000] ACPI:
> RSDP 0x000000047EED3000 000024 (v02 BOCHS )
> Kexec kernel:
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI:      0x000000047EED3000 000000 (v00
>   00000000      00000000)
> [    0.000000] Oops - load access fault [#1]
>
> RSDP reside in:
> [    0.000000] efi:   0x00047ded1000-0x00047eee3fff [Boot Code   |   |
>  |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
>
> (Boot Code vs ACPI Reclaimed)
>
> Now to get qemu-riscv64_smode_defconfig + acpi.config to build
> post-2024.10, I needed to add the following fragments:
>
>   CONFIG_BLOBLIST=3Dy
>   CONFIG_BLOBLIST_ALLOC=3Dy
>   CONFIG_BLOBLIST_SIZE_RELOC=3D0x20000
>
> which is really just a "make the build not complain", guessing game
> from my side.
>
> My guess would be that it's related to the change in
> evt_write_acpi_tables(), where:
>
> -    ptr =3D memalign(SZ_4K, SZ_64K);
> +    ptr =3D bloblist_add(BLOBLISTT_ACPI_TABLES, SZ_64K, 12);
>
> is done.
>
> Is my config fragment broken, or is this a proper regression?

I think it's a regression and I think what breaks it is commit cfb4aa2a754e=
d1

Can you apply the diff below and see if it fixes it for you?

diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
index 4422b31ac6a7..afa5eee85484 100644
--- a/lib/efi_loader/efi_acpi.c
+++ b/lib/efi_loader/efi_acpi.c
@@ -34,8 +34,8 @@ efi_status_t efi_acpi_register(void)
         * add_u_boot_and_runtime(). At some point that function could crea=
te a
         * more detailed map.
         */
-       if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
-               return EFI_SUCCESS;
+       //if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
+               ////return EFI_SUCCESS;

        /* Mark space used for tables */
        start =3D ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);

Simon, why that PR got sent with no ACKs from any of the EFI maintainers?

Thanks
/Ilias
>
>
> Thanks!
> Bj=C3=B6rn
