Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB44CC61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 22:10:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14EB786538;
	Tue, 21 Nov 2023 23:10:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="knQPC3bs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C71887585; Tue, 21 Nov 2023 23:10:56 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C6BA8269F
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 23:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-548d1f8b38bso3584852a12.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700604653; x=1701209453; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UEIubZ2dXB+NAgyIgVQo5uLj/cQFs73nUjfXFbZi63Y=;
 b=knQPC3bst5OQYMxJvjf+z8/0cgCZR2yZs0nytpzNC2A+msw8IgtJI4Kvv9+n29FMbx
 VqyHMWBttA0DtLOuEc2WOlcwGso6rotj5p5TxdE5IlQHmfixxqZSRBTZeLKm9rYicCjY
 VeloNLV3vh1YYCVIgHPIxGRpPSVlotECeF/f8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700604653; x=1701209453;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UEIubZ2dXB+NAgyIgVQo5uLj/cQFs73nUjfXFbZi63Y=;
 b=UsDr3cI0vFgLM1L42Zr3EnX7C3iLVUEsybvHiBZoVGf49a0miPLXUO0OrUgVnkZAVY
 akDuGa3rUEBZ+ogdZXVOMpefewpdRivZFM2+Wj2YX8g9Ffn+tNy3oskSQZ2/PsaqrkzL
 mgiNerPMc1Hgqwi+Q7Th6dA0s5avtfGYHODnULTay97y/L6ouRNpFFrQtw74ACuor5Kb
 zVz8I5TrtZvSEgppPzllEer/bKHn0f1OtxtbWpYKhBDTdvU6PV9rAEiqVBX16rzK2nmy
 Mg/QSwLhfUHeHT6bElnREe3UZQ6PEGJUXl8OtnXMXd1phkjW1WiYrjKVdv7pj3Aq2GE1
 H9Gw==
X-Gm-Message-State: AOJu0YwYSdydyXEwu4UfclJy9DN84NLHv5Xz0FjbPLYnmWfKpKZ8XI6O
 5lZspnxm3UE1UTKeL3D9vtxkNwiAvbPwwiwVKtTrvQ==
X-Google-Smtp-Source: AGHT+IHsYXGyhJi51Cr77wz0Ufb2qASyNr2hwYtQvazDCMGVpUqirv6NXsa1pkYc4V+sZzTTt9Mqr8SMRouqvgTIWBQ=
X-Received: by 2002:a17:906:eb4c:b0:a02:8b23:895d with SMTP id
 mc12-20020a170906eb4c00b00a028b23895dmr175867ejb.35.1700604653320; Tue, 21
 Nov 2023 14:10:53 -0800 (PST)
MIME-Version: 1.0
References: <20231121113557.800353-1-sjg@chromium.org>
 <20231121113557.800353-8-sjg@chromium.org>
 <555a04a5-170e-409e-bae5-b2b0ba03e09e@gmx.de>
In-Reply-To: <555a04a5-170e-409e-bae5-b2b0ba03e09e@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Nov 2023 15:10:42 -0700
Message-ID: <CAPnjgZ0K=fCvqtZLEsCPgh9iOvb44U+e39kNT3B-xQFRX9HZcw@mail.gmail.com>
Subject: Re: [PATCH 7/7] WIP: efi: debugging
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 21 Nov 2023 at 10:20, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/21/23 12:35, Simon Glass wrote:
> > This works when run outside a test:
> >
> > good:
> >
> > /tmp/b/sandbox/u-boot -T
> >      -c "bootfl scan mmc; bootfl sel 1; bootfl list; bootfl b"
> >
> > ** Booting bootflow 'mmc7.bootdev.part_1' with efi
> > desc = 0000000018c86ee0
> > dev=mmc, devnr=7:1, path=efi/boot/bootsbox.efi, buffer=0000000011001000, size=1600
> > - boot device /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/SD(7)/SD(3)/HD(1,MBR,0x2f7d9756,0x800,0x9000)
> > - image /efi\boot\bootsbox.efi
> > No EFI system partition
> > No EFI system partition
> > Failed to persist EFI variables
> > EFI using ACPI tables at 8ef8000
> > WARNING: Can't have ACPI table and device tree - ignoring DT.
> > Loaded from disk
> > Booting /efi\boot\bootsbox.efi
> > EFI: Call: efi_load_image(false, efi_root, file_path, source_buffer, source_size, &handle)
> > info->device_handle = 0000000018f180e0
> > loaded_image info for 0000000018f184e0: 0000000018f18470
> >
> > EFI: 0 returned by efi_load_image(false, efi_root, file_path, source_buffer, source_size, &handle)
> > EFI: Call: efi_start_image(handle, &exit_data_size, &exit_data)
> > Hello, world!
> > Running on UEFI 2.10
> > Have ACPI 2.0 table
> > Have SMBIOS table
> > 18f18470
> > Load options: <none>
> > finding
> > - search 0000000018c931a0 ret=0
> > File path: /efi\boot\bootsbox.efi
> > Vendor: Das U-Boot
> > Boot device: /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/SD(7)/SD(3)/HD(1,MBR,0x2f7d9756,0x800,0x9000)
> > Exiting boot sevices
> > EFI: 5 returned by efi_start_image(handle, &exit_data_size, &exit_data)
> > Boot failed (err=-22)
> >
> > bad:
> >
> > rtv bootflow_efi
> >
> > ** Booting bootflow 'mmc7.bootdev.part_1' with efi
>
> Should we have an ESP on the MMC image to persist UEFI variables?

That would be a good enhancement, but I would like to get the basics
going first.

Regards,
Simon
