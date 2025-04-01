Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D461C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 11:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E03838209F;
	Tue,  1 Apr 2025 13:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SLfDp0hL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D26F6820B0; Tue,  1 Apr 2025 13:33:06 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 880B581FC8
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 13:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e5dc299deb4so5497289276.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 04:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743507183; x=1744111983; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n0HmsmC7151URc69E06XWmc9zAszCWba8xOiA3UCnYo=;
 b=SLfDp0hLY8e6fzTom4PT6Vj/Mnsn409fmGaNt9kjQTu9SWsJrCTcZxdt0hab2zenT+
 8XYgzNS/cf74awOi7sVqrXjAkNdCG+RKProF+/AcgX6KJgBPN7xWmqkooAYE4s5Ul5hV
 Fkzm/rvRMqN4jBlj+JDLyS7usxI7+Fs3UPiOuU9Ra8Mf5haCkqlRT1EHwUqYdSy9larE
 d8/y8YddXGX3tngi/v2Jjmu4EaKDIW6ZsjfHcNf5dHahI/MSoUBwbq2GcsTnQgAuYvQu
 ilen6FV5H5KGPUoaZIr5jydwR4sqiIlmYxC1yStZXxoqCFVgQspXs8505Y2WYxu/55ev
 03ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743507183; x=1744111983;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n0HmsmC7151URc69E06XWmc9zAszCWba8xOiA3UCnYo=;
 b=wBnPQ9J+oWMa5CuYjYK03dGbVUBWsMJp0WQLTa08P+qCTV7PFThj2Y3wkI2nJ7g0Hf
 vF/7SMibLx1CRb798mNtrO/39xI2PMcej/fE7e67Aip4jNW26Yc2vGzxqXpoRhlSdMq+
 ljxCFqZwuR0ul80T4PJ0QCTvuMZJkTJQNqegigafNnTcWN6mlkSFHFeS+PqfPH76Lse8
 keHNmuFWupx0T4s3G3GWBjPIyjk8QUPL538mEUj6NU4Kc0iNe8TeGxEFX+QddfKLsLE9
 0/xjQ3/xKUKncegQC3HSHrHVA/+G5rNu/T8VBFGhnxHYi/YaDFEj21GwqTskSJmlvbl/
 DB4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSl0hAPIEKeGxTHx0tVu+T1cHRxBMG9CINDWL4jp1Ne3wz5z7xl800RlapGp6XFFpbl9Brcnk=@lists.denx.de
X-Gm-Message-State: AOJu0YyTCQE+W17PMcVtzRigIb6zDgrs+7SGvkus5AMVE6bDDZrVQ+Q5
 ZaRj5u6gYtAYQSVbolb2RUkBMBAQlAzr6TN9lVh2lcXbRJS0ma3d4HWP0i/6toDfAygIsBYKyJS
 34YOi7E6yNTYqsB+WzgbTfmAVWnxnl82X5drWqQ==
X-Gm-Gg: ASbGncs2pQgjhiLL158M7Cp2aoxPl0Xk4d2rTlpNWMgQzV8lJHoeHaktiir3jggsj3u
 BTMI2L+MKdANpddPDv5ItJQIj/j0hFz/hfsGOxwf2QJb/VsUoKve2lRZMZDrQGjPFx6SV5tYCXw
 2mSH4xw0dmyB/zB4PPLZr17D43
X-Google-Smtp-Source: AGHT+IHWGhs7tBLbTcmFxFDLK88ym8cbK+gaESJBviRzFBdXMaQfMxVjvR5TRGPQMQO9C2n1SZsLxTDbuWV2jdUdMpU=
X-Received: by 2002:a05:6902:1690:b0:e5d:cdc6:7acf with SMTP id
 3f1490d57ef6-e6b83a845eamr15449005276.31.1743507183356; Tue, 01 Apr 2025
 04:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250326054653.273906-1-quic_varada@quicinc.com>
 <CAC_iWj+MPcOcuhM1vcHyXYUF7O7U_y8+KKMZJszTK2aqfgfHZg@mail.gmail.com>
 <Z+TsLpAGAIezgPZS@hu-varada-blr.qualcomm.com>
 <CAC_iWjKyyOHCU2xv-x9BW9w7GtY8ohupxNKTTJC0V91dfPwy8Q@mail.gmail.com>
 <Z+uL1TQlh+ayjF+G@hu-varada-blr.qualcomm.com>
 <CAC_iWjK=-qVD2=SM=fT7JujRPZi5HWht6rjbU_174UUyWYezqQ@mail.gmail.com>
 <Z+uyXhPxpm49c4kT@hu-varada-blr.qualcomm.com>
In-Reply-To: <Z+uyXhPxpm49c4kT@hu-varada-blr.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 1 Apr 2025 14:32:27 +0300
X-Gm-Features: AQ5f1Jqzi0Qmtz76EhSTRZj-pM3G3FideUuGpQ6KEps3mtSFqw8K_B-IVwT43d8
Message-ID: <CAC_iWjKLzYnxZxGH7rdWKQEhFVTFZ1o1=2nf6QjAVgL77TRUtA@mail.gmail.com>
Subject: Re: [PATCH v1] efi_loader: Handle GD_FLG_SKIP_RELOC
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: trini@konsulko.com, sjg@chromium.org, EABachinin@salutedevices.com, 
 jerome.forissier@linaro.org, rasmus.villemoes@prevas.dk, ansuelsmth@gmail.com, 
 sughosh.ganu@linaro.org, michal.simek@amd.com, u-boot@lists.denx.de
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

Thanks,

That works fine.

Heinrich feel free to queue this up

Cheers
/Ilias

On Tue, 1 Apr 2025 at 12:31, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> On Tue, Apr 01, 2025 at 10:02:05AM +0300, Ilias Apalodimas wrote:
> > On Tue, 1 Apr 2025 at 09:46, Varadarajan Narayanan
> > <quic_varada@quicinc.com> wrote:
> > >
> > > On Thu, Mar 27, 2025 at 11:22:58PM +0200, Ilias Apalodimas wrote:
> > > > On Thu, 27 Mar 2025 at 08:12, Varadarajan Narayanan
> > > > <quic_varada@quicinc.com> wrote:
> > > > >
> > > > > On Wed, Mar 26, 2025 at 09:28:04AM +0200, Ilias Apalodimas wrote:
> > > > > > Hi Varadarajan
> > > > > >
> > > > > > On Wed, 26 Mar 2025 at 07:47, Varadarajan Narayanan
> > > > > > <quic_varada@quicinc.com> wrote:
> > > > > > >
> > > > > > > If the EFI runtime services pointers are relocated even though
> > > > > > > relocation is skipped, it corrupts some other data resulting in some
> > > > > > > unexpected behaviour.
> > > > > > >
> > > > > > > In this specific case, it overwrote some page table entries resulting in
> > > > > > > the device memory address range's mappings getting removed. Eventually,
> > > > > > > after the completion of efi_runtime_relocate(), when a driver tries to
> > > > > > > access its device's registers it crashes since the mappings are absent.
> > > > > >
> > > > > > How were those page table entries added?
> > > > >
> > > > > initr_caches ->
> > > > >         enable_caches ->
> > > > >                 setup_pgtables (arch/arm/mach-snapdragon/board.c)
> > > > >
> > > > > > The runtime service relocation might have overwritten those now, but
> > > > > > since they are not in protected memory this can happen arbitrarily.
> > > > >
> > > > > To avoid relocating U-Boot, I had OR'ed GD_FLG_SKIP_RELOC to gd->flags
> > > > > in init_sequence_f -> mach_cpu_init(). Hope that is the right place and
> > > > > way to do it.
> > > >
> > > > I'll have a look at the relocation stuff, but off the top of my head,
> > > > I don't remember.
> > > >
> > > > >
> > > > > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > > > > ---
> > > > > > >  common/board_r.c | 3 ++-
> > > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/common/board_r.c b/common/board_r.c
> > > > > > > index 179259b00de..1dd3b96c2de 100644
> > > > > > > --- a/common/board_r.c
> > > > > > > +++ b/common/board_r.c
> > > > > > > @@ -169,7 +169,8 @@ static int initr_reloc_global_data(void)
> > > > > > >          */
> > > > > > >         efi_save_gd();
> > > > > > >
> > > > > > > -       efi_runtime_relocate(gd->relocaddr, NULL);
> > > > > > > +       if (!(gd->flags & GD_FLG_SKIP_RELOC))
> > > > > > > +               efi_runtime_relocate(gd->relocaddr, NULL);
> > > > > >
> > > > > > Have you tested booting with EFI with this change?
> > > > >
> > > > > Yes, tested this with both GD_FLG_SKIP_RELOC set and not set.
> > > > >
> > > > > Used the command 'bootefi bootmgr' and Linux is able to boot.
> > > >
> > > > Have you tried to call any runtime services -- e.g efival -l will dump
> > > > all the EFI variables
> > >
> > > Sorry for the delay. The test setup was busy. My U-boot doesn't seem to
> > > have this command. Not sure if I'm missing some config.
> > >
> > >         => efival -l
> > >         Unknown command 'efival' - try 'help'
> > >
> > > However, 'efidebug boot dump' works. Does that suffice?
> >
> > This runs at boottime. We want to test the variables at runtime so you
> > have to boot linux.
> > One of efibootmgr or efivar -l is enough
>
> Please see below for 'efivar -l' output
>
>         sh-5.2# dmesg | grep EFI
>         [    0.000000] efi: EFI v2.11 by Das U-Boot
>         [    0.001636] Remapping and enabling EFI services.
>
>         sh-5.2# uname -a
>         Linux qcs9100-ride-sx 6.6.65-qli-1.3-ver.1.1-dirty #1 SMP PREEMPT Wed Dec 11 15:13:43 UTC 2024 aarch64 GNU/Linux
>
>         sh-5.2# efivar -l
>         4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-StubFeatures
>         4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-StubInfo
>         4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-LoaderTimeExecUSec
>         4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-LoaderEntrySelected
>         4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-LoaderEntries
>         4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-LoaderDevicePartUUID
>         4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-LoaderImageIdentifier
>         4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-LoaderFeatures
>         4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-LoaderFirmwareType
>         4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-LoaderFirmwareInfo
>         4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-LoaderInfo
>         4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-LoaderTimeInitUSec
>         605dab50-e046-4300-abb6-3dd810dd8b23-ShimRetainProtocol
>         8be4df61-93ca-11d2-aa0d-00e098032b8c-BootCurrent
>         8be4df61-93ca-11d2-aa0d-00e098032b8c-OsIndicationsSupported
>         8be4df61-93ca-11d2-aa0d-00e098032b8c-PlatformLang
>         8be4df61-93ca-11d2-aa0d-00e098032b8c-PlatformLangCodes
>         8be4df61-93ca-11d2-aa0d-00e098032b8c-BootOrder
>         8be4df61-93ca-11d2-aa0d-00e098032b8c-Boot0007
>         8be4df61-93ca-11d2-aa0d-00e098032b8c-Boot0006
>         8be4df61-93ca-11d2-aa0d-00e098032b8c-Boot0005
>         8be4df61-93ca-11d2-aa0d-00e098032b8c-Boot0004
>         8be4df61-93ca-11d2-aa0d-00e098032b8c-Boot0003
>         8be4df61-93ca-11d2-aa0d-00e098032b8c-Boot0002
>         8be4df61-93ca-11d2-aa0d-00e098032b8c-Boot0001
>         8be4df61-93ca-11d2-aa0d-00e098032b8c-Boot0000
>         8be4df61-93ca-11d2-aa0d-00e098032b8c-VendorKeys
>         8be4df61-93ca-11d2-aa0d-00e098032b8c-DeployedMode
>         8be4df61-93ca-11d2-aa0d-00e098032b8c-AuditMode
>         8be4df61-93ca-11d2-aa0d-00e098032b8c-SetupMode
>         8be4df61-93ca-11d2-aa0d-00e098032b8c-SecureBoot
>
> Thanks
> Varada
>
> [ . . . ]
