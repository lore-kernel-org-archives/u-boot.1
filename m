Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F9CC021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 19:34:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D19D2807C4;
	Fri, 21 Feb 2025 20:34:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i5Hiplpd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0910780EC0; Fri, 21 Feb 2025 20:34:34 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 969DB806FE
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 20:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e4419a47887so2053819276.0
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 11:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740166470; x=1740771270; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dkesruoR+sNn2ei1myESQeAJd2f/LR8166fkMngllQw=;
 b=i5HiplpdmgvUxIidk1JQh68BjhfuCejzYzuyCjkbMVX2IzbM8/WGrVPH/yw/4xuqa5
 ko4efYpL/Lcbjn8HR5aC6gwYiCNBO8yIac3mZFl7RRaersZEKBwBv665jQdyY/CU0ITq
 ASe6ww9yZuAv4EFzDMaxOOmj1JwSpa4bI+434yT4g+YFrGFZqa6ckOavttEiJhmG4TrY
 n0WJ/mmGXNR5cZK2ddmKTaxcrwriW63pu1SZjiANoOX3LPa/y0mw/L12DEcrZyJWnvN/
 iY+WBo6syJjd0ZgmTMySzEV/HDTs0ZdiffSRQPHDijedXO3kVKaBEEGcsP99ZOGrdILX
 GHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740166470; x=1740771270;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dkesruoR+sNn2ei1myESQeAJd2f/LR8166fkMngllQw=;
 b=AntYqRqyjYahJY0BD+vjTFf+rz0vMTl9yskzr6quWQq/kpWqDS764UPn9wGHN8qx4c
 c6zKccG0arnKBXD9i0OydTqW1s8Bb14XBnlJi8vUHPa+GqTuu3ZTCjyWC0xHc3CE/PKd
 E4GOoEMudlLyMyT7Xi6cTDvHS4svvq7vaVnWnuplrPPuyBNCrS5aZqwgZglStVTSwSF0
 zcoK0Oy5tUSMFSloFhjX2XSo4o6hfZRK7ufSaDmoeP7/7fXiIcGJW8zGGIsKFw83raKh
 g7ix81gUe+5z/zBJAhot88muQ49Als/xefXrq6Po+Gx709QcXJmnTxUkvVHc1GSRKytT
 kyhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUda6D/FK1LPoNGguI88L/tLnmUYrZ0m4PeraNm3jTxQP23Qw8ZC/ryw16qZsOvc7VRipYFVc=@lists.denx.de
X-Gm-Message-State: AOJu0YxoRUs2vWqoAu6P4pWfMS0r1Ak/zaxjs9zDNuHANUJzbRkegabX
 KbOLMhiBbbzpxcWYCqsHWs+Kl+mvHFAdSImfT618Sr97arPvmWCyfoKiJxdQCGc+KrtXQ2x7nbi
 yRZnw8xFRnBibP09j3UEF2LKSVrcEQVrxttwwg3y+UewdEEYJ
X-Gm-Gg: ASbGnctMegjMVpzqgjTGDBElpNYZy9lbispwlOQmVWn/cSgK8r/bRlrxMk9+OlNRsSH
 rWtB4YVmY5Tkb+ILosW23gq/UKnyNSlVqulJHqcGOzs+HsxzvaFS083+CAL70pPusw/3oWFlhkz
 rpzwJmagAA
X-Google-Smtp-Source: AGHT+IH6cIcUbum7EhO32cBDdhQPZaIePLHN27PjL5zmPF292solBA/oF3P3karD2Hj4D4Y6slNiJmtkDxH6lJ0QX+A=
X-Received: by 2002:a05:6902:2586:b0:e5b:1453:d2e4 with SMTP id
 3f1490d57ef6-e5e245e714fmr3882698276.11.1740166470428; Fri, 21 Feb 2025
 11:34:30 -0800 (PST)
MIME-Version: 1.0
References: <20250203105912.196654-1-sughosh.ganu@linaro.org>
 <20250203105912.196654-6-sughosh.ganu@linaro.org>
 <CAC_iWj+a-hcvS=u_Gtk39UyjSPuMgWoao982TzN+wb5uKnS=hg@mail.gmail.com>
 <62C0A2AF-2936-46DA-9307-7AAA90512B4C@gmx.de>
In-Reply-To: <62C0A2AF-2936-46DA-9307-7AAA90512B4C@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 21 Feb 2025 21:33:54 +0200
X-Gm-Features: AWEUYZnlRiT6okK4E5kPH602cWu1zFUy6mS5mttFGZmBFEzNvkRWkjyEu6QNwHM
Message-ID: <CAC_iWjJ40WF98vj88aEKrqXY1ZVR70SK4Gn4gEN33s+RMq8TnQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] blkmap: add pmem nodes for blkmap memory mapped
 slices
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng@tinylab.org>
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

On Fri, 21 Feb 2025 at 21:22, Heinrich Schuchardt <xypron.glpk@gmx.de> wrot=
e:
>
> Am 21. Februar 2025 19:55:03 MEZ schrieb Ilias Apalodimas <ilias.apalodim=
as@linaro.org>:
> >Hi Sughosh
> >
> >This generally looks ok, but I don't love the idea of unconditionally
> >preserving all slices regardless of their usage.
> >Basically, if a user doesn't unmap that slice it will end in kernel
> >memory. My fear is that someone will forget device sensitive data in a
> >blkmap....
>
> I don't that you can easily determine which blkmap and which blkmap slice=
 was created why.
>
> But can we realisticly assume that a device that U-Boot reads from is sec=
ure against reading at kernel runtime. I don't believe so as U-Boot runs at=
 the same exception level as the kernel. U-Boot and the kernel do not empty=
 RAM. You always have to assume that whatever is in U-Boot memory is dicove=
rable at kernel runtime.
>
> If you load sensitive data, you must overwrite it before booting.

Fair enough. I am not against this patch, I am just to figure out if
we can restrict what we preserve a bit more

Thanks
/Ilias
>
> Best regards
>
> Heinrich
>
>
>
> >
> >On Mon, 3 Feb 2025 at 12:59, Sughosh Ganu <sughosh.ganu@linaro.org> wrot=
e:
> >>
> >> The EFI HTTP boot puts the ISO installer image at some location in
> >> memory which needs to be added to the devicetree as persistent
> >> memory (pmem) node. The OS installer then gets information about the
> >> presence of this ISO image through the pmem node and proceeds with the
> >> installation.
> >>
> >> In U-Boot, this ISO image gets mounted as a blkmap device, with a
> >> memory mapped slice. Add a helper function which iterates through all
> >> such memory mapped blkmap slices, and calls the FDT fixup function to
> >> add the pmem node. Invoke this helper function as part of the DT fixup
> >> which happens before booting the OS.
> >>
> >> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> >> ---
> >> Changes since V3:
> >> * Move the definition of the helper function to the efi_helper.c
> >> * Remove the region of the blkmap mem map device from the EFI memory
> >>   map along with adding the pmem node
> >>
> >
> >[...]
> >
> >> @@ -680,3 +683,52 @@ out:
> >>
> >>         return ret;
> >>  }
> >> +
> >> +static int add_blkmap_pmem_nodes(void *fdt, struct blkmap *bm)
> >> +{
> >> +       int ret;
> >> +       u32 size;
> >> +       ulong addr;
> >> +       efi_status_t status;
> >> +       struct blkmap_mem *bmm;
> >> +       struct blkmap_slice *bms;
> >> +       struct blk_desc *bd =3D dev_get_uclass_plat(bm->blk);
> >> +
> >> +       list_for_each_entry(bms, &bm->slices, node) {
> >> +               if (bms->type !=3D BLKMAP_SLICE_MEM)
> >> +                       continue;
> >
> >Can we convert the 'type' to 'preserve' and teach
> >blkmap_create_ramdisk() to pass that flag?
> >This way we can unconditionally pass it from EFI HTTP installers, and
> >let the command line users decide if they want to preserve it.
> >
> >
> >> +
> >> +               bmm =3D container_of(bms, struct blkmap_mem, slice);
> >> +
> >> +               addr =3D (ulong)(uintptr_t)bmm->addr;
> >> +               size =3D (u32)bms->blkcnt << bd->log2blksz;
> >> +
> >> +               ret =3D fdt_fixup_pmem_region(fdt, addr, size);
> >> +               if (ret)
> >> +                       return ret;
> >> +
> >> +               status =3D efi_remove_memory_map(addr, size,
> >> +                                              EFI_CONVENTIONAL_MEMORY=
);
> >> +               if (status !=3D EFI_SUCCESS)
> >> +                       return -1;
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >
> >
> >Thanks
> >/Ilias
>
