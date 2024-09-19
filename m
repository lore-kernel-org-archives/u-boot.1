Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958C7CF395C
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 15:20:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FCC789259;
	Thu, 19 Sep 2024 17:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SZ931mlY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB1118925B; Thu, 19 Sep 2024 17:20:11 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E4788924B
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 17:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7191df6b5f5so709454b3a.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 08:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726759208; x=1727364008; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1HiW+vQEhyMppmLKqk9/jf9BK3CfZhq/gUk+zSAuq6A=;
 b=SZ931mlYZAroQ2ZAtcYLWMrsbjJ85RnDHz6/3rKiUVNI1h0cgWFZAXf4EJveZxlG6S
 t20v31D05jZ649AmSt/6Qr5p4gldC6mJDmBhK/S/owSJBCQp3dSqKrHfNcGr3cIN8TlB
 yCgsUdJCaBZBYQDFtV/eF7ehIz8YAf5vXDaFHcuQHj/YKEjMYAbO75ZGYQfg5Mhya/vp
 Q1483bf+cz5LJIqPv9d/KBn55ZnnEWaogUvPttkfVjdkIowZnyhy2qT/m/V94cgWVu7k
 qOaceO+O9RenbC6IgAaJKPqXn1zVwiYUeQAbrqVxuKdGuGqA6zpGq/OFsJjOazUN6loh
 zwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726759208; x=1727364008;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1HiW+vQEhyMppmLKqk9/jf9BK3CfZhq/gUk+zSAuq6A=;
 b=ex3xAY3yvb5L+t2s9NG2LrHC61GYrerqkj2VahqJbVkWldk+qF8CuylGdbCO9ISG2a
 Y2Qmp+HNNEFi1KhUlzJE6ch/SlqEDMItpwJFUbTRHaeTbBhnk+SjcJnjFb5wSo/Mx2Pj
 jYXAe3A7xGvhojP2TkhGaLyaj7bxNxKc1iIYpggbiNnaFaRbrb37UCS2TG5gcg3e+dvb
 MaCJBjDKdWJCIQuYrdJhP8wPWFdaj5OsZJ0sQBJx87QIBt7IOyBB5M0n/54l6xsQRa10
 xiCBZ+i5hIpCSRSIVtqJuqOCLhJEqJf9LwysEK7ta7abUOK4xPoGBP+zIbBkWuxBxI1d
 M+5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVrbqAUhGROxaWwytv2/p9XF/x+uy917+l8RefvJDr4MbKYGA6N0x4Qyjz6N5BSoznU+iUD2g=@lists.denx.de
X-Gm-Message-State: AOJu0Yxw33NNb9OTkqirf9cJNAwO3gFeZ39i0lRJlFxZnckxEyfQdBj9
 d9EGhpGPXVECUKUFT8wzFnSmx5uExbYgHvlcat0dL4COOcFD6hVnX4EBxB7xjUEE/B2wPbWqHeK
 u89D0oV04t88l5Sav7IcDps7Z9fRpC+mZawJI1hoU+D3L714a
X-Google-Smtp-Source: AGHT+IEf8JPBEjb77FWqMLzvJgWtNtmI8ubbNIfKnauHHQi/E3xvTKqzxfXGLGuVAyiUSTO3AcOEQ8mzfRDu5qI84PI=
X-Received: by 2002:a05:6a00:3cc7:b0:717:6883:ad5 with SMTP id
 d2e1a72fcca58-7192608051dmr41577561b3a.11.1726759207970; Thu, 19 Sep 2024
 08:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-15-patrick.rudolph@9elements.com>
 <CAFLszTimAFGocvqbnT=JVsA2bjNa=ZfxP6Sy46a9e6VkhtdojQ@mail.gmail.com>
 <CAC_iWjLASm6U8kC68MJ0uZ14MGFS_SSL3Pcd8hcEH=a=W8gvBQ@mail.gmail.com>
 <CAFLszTgYHO7FgbCgfRwqT_yj4KBm31xKdEUrn0pZkhtLzOh=HQ@mail.gmail.com>
In-Reply-To: <CAFLszTgYHO7FgbCgfRwqT_yj4KBm31xKdEUrn0pZkhtLzOh=HQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 19 Sep 2024 18:19:31 +0300
Message-ID: <CAC_iWjKv+Z4K5xPW6MZhBZ67-rDy9iRVaoqfLKmJRwSG9nKnfA@mail.gmail.com>
Subject: Re: [PATCH v4 14/35] efi_loader: Allocate and write ACPI tables
To: Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi Simon,

On Thu, 19 Sept 2024 at 18:00, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>

[...]

> > > > +
> > > > +               if (!addr)
> > > > +                       return log_msg_ret("mem", -ENOMEM);
> > > > +       } else {
> > > > +               pages = efi_size_in_pages(TABLE_SIZE);
> > > > +
> > > > +               ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> > > > +                                        EFI_ACPI_RECLAIM_MEMORY,
> > > > +                                        pages, &new_acpi_addr);
> > > > +               if (ret != EFI_SUCCESS)
> > > > +                       return log_msg_ret("mem", -ENOMEM);
> > > > +
> > > > +               addr = (void *)(uintptr_t)new_acpi_addr;
> > > > +       }
> > > > +
> > >
> > > The tables should be written regardless of whether EFI_LOADER is enabled.
> >
> > *Why*? How do you expect to hand them over to the OS?
>
> Why - because boards which need ACPI tables to boot should generate
> them;

Noone argued that.

> also this happens when U-Boot starts up, in last_stage_init()
> How - it isn't possible, but eventually I suppose it will be, once we
> have a use case for booting with ACPI but without EFI

Are you aware of such an OS? If not, we can accept the patches when we
have a reason.
I remember patches being hard NAK'ed on using DTs to pass the ACPI
table address in the past.

>
> >
> > >
> > > Can we drop this else clause? We should always use the bloblist.
> >
> > Both Heinrich and I said the exact opposite. Unless there's a
> > perfectly good reason why we should keep them in bloblist memory, I'd
> > like us to do that
>
> The main reason is that we should not be putting things in memory
> between the start of RAM and the bottom of the U-Boot area. That
> region of memory is supposed to be for loading images. Most boards
> hard-code the image-load addresses in environment variables. But even
> if they didn't, we should not be using that memory for U-Boot data.

EFI allows you to request a specific address to use. We can choose one
that fits the requirements

>
> Another reason is that the bloblist is designed for this, for keeping
> tables in a small, contiguous area of memory, so that when passed to
> Linux they are not spread all over the place.

Linux does not and will not read tables from a bloblist though

Thanks
/Ilias



>
> Regards,
> Simon
>
>
> >
> > Thanks
> > /Ilias
> > >
> > > We should use efi_add_memory_map() to add to the memory map.
> > >
> > > > +       table_addr = virt_to_phys(addr);
> > > > +
> > > > +       gd->arch.table_start_high = table_addr;
> > > > +
> > > > +       table_end = write_acpi_tables(table_addr);
> > > > +       if (!table_end) {
> > > > +               log_err("Can't create ACPI configuration table\n");
> > > > +               return -EINTR;
> > > > +       }
> > > > +
> > > > +       log_debug("- wrote 'acpi' to %llx, end %llx\n", table_addr, table_end);
> > > > +       if (table_end - table_addr > TABLE_SIZE) {
> > > > +               log_err("Out of space for configuration tables: need %llx, have %x\n",
> > > > +                       table_end - table_addr, TABLE_SIZE);
> > > > +               return log_msg_ret("acpi", -ENOSPC);
> > > > +       }
> > > > +       gd->arch.table_end_high = table_end;
> > > > +
> > > > +       log_debug("- done writing tables\n");
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, alloc_write_acpi_tables);
> > > > diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_event_dump.py
> > > > index e282c67335..459bfa26bb 100644
> > > > --- a/test/py/tests/test_event_dump.py
> > > > +++ b/test/py/tests/test_event_dump.py
> > > > @@ -18,6 +18,7 @@ def test_event_dump(u_boot_console):
> > > >  --------------------  ------------------------------  ------------------------------
> > > >  EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_request.c:.*
> > > >  EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simple_os.c:.*
> > > > +EVT_LAST_STAGE_INIT   alloc_write_acpi_tables         .*lib/efi_loader/efi_acpi.c:.*
> > > >  EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loader/efi_smbios.c:.*
> > > >  EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/cpu/start.c:.*
> > > >  EVT_TEST              h_adder_simple                  .*test/common/event.c:'''
> > > > --
> > > > 2.46.0
> > > >
> > >
> > > REgards,
> > > Simon
