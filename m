Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477B2CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 12:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A80386BA6;
	Tue, 17 Oct 2023 14:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c3//Rqns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A1386B05; Tue, 17 Oct 2023 14:00:24 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3B7886BF2
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 14:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5079f9ec8d9so4247804e87.0
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 05:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697544021; x=1698148821; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=omShJlaERikxCHbMhQbx0vL7spls/aqnlOsjUSeGuME=;
 b=c3//Rqns3u4va2SJWD8/pjX8w9XHKXE2NKYgg/29RM0U5cUzMP8L6DT31H06bm0Gce
 5eWp1Xd/mrFJWCh40Qxy7l2mYbIsWBRwWR5cmdkVn3pQRsaANcUshCu7t115Kv3Wc18h
 OAP2nXf65ZcDpofdXpdkFTlW89/XXf7Q85eYHuGex8dLY6SZxVdK++JGESe0g4up2AfI
 knBAJBPCEW5puxhvKQ8ikdrcgLzndkKjhONM0tOUIJB5FO6osfRVIItaBF3/vvFsng5A
 aegLcHY6+/o6ItpTVFdph6j3BqYp+HzqCLFrJBsgwZockHl1qB+OsYLJnb9WZ3414fYZ
 KYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697544021; x=1698148821;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=omShJlaERikxCHbMhQbx0vL7spls/aqnlOsjUSeGuME=;
 b=jVcll38nOCApmdPbQRvwX78pHHmHzZnF1xuJAQZHaIr+V1Q+WdoewLqEzv3JUokv+2
 PLpoAmZBgV5mDqlUD9vqRSdSo7J6OoD83AIowAXzaHnew3H1Dqe7mdAoPlmjZEJ7dtRH
 gSMw2jklAkOQ/rxntHQu0hMrtsBsMMiUQjbfNQGgmfc4ZNFrf3tcxeqNe/smYoxgnpG5
 y/kN7mdkkkGIKL+jsrLonViieePzJaPXypjh9w2WDXVWmfALi0fPX0wQZR/Vr7USg4vA
 t7ZN61COpUqDx8Ve2LPq1VTjAULsFVCK22pNPDgG5fd1JvxWFeQ7aOlNPS9EVsuWY31b
 bO7Q==
X-Gm-Message-State: AOJu0YwKW6GMSbv9v8WgTH50xoyT3bnHEdKZofMylPU8CGk24DtlGXct
 OuGb3TQxu1G8ejpKlnGzAM5Y9BWD6RWbpn7qG/nzUQYaNl5n8FqN7nSuMQ==
X-Google-Smtp-Source: AGHT+IHpBhvQdb9gVSjd5CSF6XdeIwMy7aplRiscDQbXtDrODg1Dpf9d30/TNzqeLkuc3hi5h/+KUrC75rEpA1rTIqg=
X-Received: by 2002:a05:6512:1106:b0:502:e0dd:628b with SMTP id
 l6-20020a056512110600b00502e0dd628bmr736606lfg.32.1697544020714; Tue, 17 Oct
 2023 05:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231017085507.12094-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjLgt0USVOQxp6WE_1edxMYMdGzfhvEFM67e91m-_iYn-A@mail.gmail.com>
 <cf0e5002-223e-4777-ab6f-654747c516b1@canonical.com>
 <CAC_iWjJ41LUzR-1GV4MCvgBADqB9Ba-hHT+7M2BEsQC_uz3-Lg@mail.gmail.com>
 <794f1510-72bb-4463-b1f1-18c9e06d2d94@canonical.com>
In-Reply-To: <794f1510-72bb-4463-b1f1-18c9e06d2d94@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Oct 2023 14:59:44 +0300
Message-ID: <CAC_iWjLgCvk-FRBgLNtPUgGX3KRjcBGFS8YEX0aor6bArRhzJQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: expose the device-tree file name
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

Hi Heinrich,

On Tue, 17 Oct 2023 at 13:12, Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

> On 17.10.23 11:49, Ilias Apalodimas wrote:
> >
> >
> > On Tue, 17 Oct 2023 at 12:23, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com
> > <mailto:heinrich.schuchardt@canonical.com>> wrote:
> >
> >     On 17.10.23 11:14, Ilias Apalodimas wrote:
> >      > Hi Heinrich,
> >      >
> >      > On Tue, 17 Oct 2023 at 11:55, Heinrich Schuchardt
> >      > <heinrich.schuchardt@canonical.com
> >     <mailto:heinrich.schuchardt@canonical.com>
> >      > <mailto:heinrich.schuchardt@canonical.com
> >     <mailto:heinrich.schuchardt@canonical.com>>> wrote:
> >      >
> >      >     Forward and backward compatibility of Linux kernel
> >     device-trees is
> >      >     sometimes missing. One solution approach is to load a kernel
> >     specific
> >      >     device-tree. This can either be done via a U-Boot scripts
> >     (like the one
> >      >     generated by Debian package flash-kernel or by a boot loader
> >     like GRUB.
> >      >     The boot loader approach currently requires to know the
> >     device-tree name
> >      >     before first boot which makes it unusable for generic images.
> >      >
> >      >     Expose the device-tree file name as EFI variable FdtFile.
> >      >     This will allow bootloaders to load a kernel specific
> >     device-tree.
> >      >
> >      >     Signed-off-by: Heinrich Schuchardt
> >      >     <heinrich.schuchardt@canonical.com
> >     <mailto:heinrich.schuchardt@canonical.com>
> >      >     <mailto:heinrich.schuchardt@canonical.com
> >     <mailto:heinrich.schuchardt@canonical.com>>>
> >      >     ---
> >      >       lib/efi_loader/efi_setup.c | 26 ++++++++++++++++++++++++++
> >      >       1 file changed, 26 insertions(+)
> >      >
> >      >     diff --git a/lib/efi_loader/efi_setup.c
> >     b/lib/efi_loader/efi_setup.c
> >      >     index e6de685e87..b24feb94dc 100644
> >      >     --- a/lib/efi_loader/efi_setup.c
> >      >     +++ b/lib/efi_loader/efi_setup.c
> >      >     @@ -26,6 +26,27 @@ void __weak allow_unaligned(void)
> >      >       {
> >      >       }
> >      >
> >      >     +/**
> >      >     + * efi_init_fdtfile() - set EFI variable FdtFile
> >      >     + *
> >      >     + * Return:     status code
> >      >     + */
> >      >     +static efi_status_t efi_init_fdtfile(void)
> >      >     +{
> >      >     +       char *val;
> >      >     +
> >      >     +       val = env_get("fdtfile");
> >      >     +       if (!val)
> >      >     +               return EFI_SUCCESS;
> >      >     +
> >      >     +       return efi_set_variable_int(u"FdtFile",
> >      >     +                                   &efi_u_boot_guid,
> >      >     +
> >       EFI_VARIABLE_BOOTSERVICE_ACCESS |
> >      >     +
>  EFI_VARIABLE_RUNTIME_ACCESS |
> >      >
> >      >
> >      > Why is runtime access needed?  Wouldn't the choice be done before
> >      > ExitBootServices?
> >
> >
> >     Having runtime access will allow to use the content of the variable
> to
> >     write a devicetree command to grub.cfg or to copy the relevant
> >     device-tree to a predefined location.
> >
> >     As GRUB cannot read EFI variables, yet, this would be the easiest
> >     short-term approach.
> >
> > Do you mean to write EFI variables?  If you want GRUB to be able to do
> > that, wouldn't it be better to use a generic GUID instead of the U-Boot
> one?
>
> No, I meant read. It is U-Boot writing the variable.
>
> Concerning the GUID the UEFI 2.10 specification requires a unique
> VendorGuid other than EFI_GLOBAL_VARIABLE.
>
> If we think about adding a recommendation to the EBBR, it might make
> sense to use a GUID other than a U-Boot specific one (at the expense of
> 16 bytes of code).
>
> Best regards
>
> Heinrich
>

Ok, I like the idea of standardizing it, since GRUB needs to pick this up
eventually.
I guess we can use the u-boot GUID until is there, so

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
