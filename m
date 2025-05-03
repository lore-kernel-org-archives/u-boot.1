Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494D2C369C2
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 21:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 332FE8283E;
	Sat,  3 May 2025 23:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cDz1Nnh0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF68F82836; Sat,  3 May 2025 23:26:45 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E42F882937
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 23:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5e5bc066283so4704439a12.0
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 14:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746307603; x=1746912403; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u0Fnpi/TAvCA9ET+nqdTXQkYJb0pgeOgrtSSSvbWtV4=;
 b=cDz1Nnh0lf/x5YvweF0Mo0TX2oE3VTxidw67UqkXd06Q2+dCo5DmrR2lGx6bxPs1a/
 XjNeTpDtpiI/D2pDRBtyGruNNVAMuqf8leluAQBkn03uAlFsAf5tT4+/2/1H6n2OTCSo
 PQFiYD2GgkuHVnwpy4BpjF1q5DOH2Gs+j4330=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746307603; x=1746912403;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u0Fnpi/TAvCA9ET+nqdTXQkYJb0pgeOgrtSSSvbWtV4=;
 b=u3ySOryJbfDle2YPni6dPkiaQZDVKJ7dNfRecE1vGQBlr+MzvoS1Ue/nPBUqtfH5nF
 KX31lN+v0YX41vk9UVV6cW0D21HmjBjDjTFotN6dFbBGwhy/Z9cfTz5h1ap5KodvoIu5
 gg8mvs4cdo/aESQWGeRuQMU8uQlIUOC7/RnB7xpaxa420je+h9Ii3AwCeaxesj/NGLNy
 rcmutp9KIgcXHvLJvnBPOMprXAknBoDRPUHdc7TvnEGlShj3S+MFWfRF25OieRXzzOIJ
 Y8XibHogC9hGt+FdgLLo5Nq9hl6LPY2Hr43BlHWQ7c+RO/xpJxz8FMA9VGkpmHI76Xdy
 a/gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNviw1gcTpzj5k5ipqBHSoH5rhlPcofBDo5hK2LivnEV+PnK45TT7zpWaBal0NgaJZBwOl6XA=@lists.denx.de
X-Gm-Message-State: AOJu0YwOB3QkQoefHMF3xzESvFgf4tFB0s0mQrbNVRhcZH9Zk/C3+ZJ2
 t6pzesqmcKW25CEGUnvrSYAC0SrEQAPFiZQcXohUwYkwt0w7k0dZnAnPN9nmLuv8AIf10ypPAFt
 zIBOKjKvysHh57mznspS8fVtH8cmbuxJWZzH+
X-Gm-Gg: ASbGncu2XO1FxSj734PcwTYsXPRVbFSlzmsBcmJiNFeXPiAN21v5zCIN8tY4a/clJzi
 k39/VfI/0EEkh/hn9kEjwew5xndfeQ/bsBR3wTDQElhk30swN4oDMSiAyGKKGlmZSNkjafGbJPk
 KhsxUCckADxtPFJstA6XW5w/7z5CKtswMP5bPePUAdpt/s/Frr9BrII6U=
X-Google-Smtp-Source: AGHT+IGWnphaPN4lXjPsRxt6zBlTYCchcDiJkvnnk90gtsFqGljzqpVDYjKFUB8L7idNZAhCXVRKw5PNUaSvr7TycAo=
X-Received: by 2002:a05:6402:13c9:b0:5f6:23b1:ab43 with SMTP id
 4fb4d7f45d1cf-5fab04bbf9bmr1592091a12.0.1746307603345; Sat, 03 May 2025
 14:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-4-heinrich.schuchardt@canonical.com>
 <CAFLszTjcCXDnjOjpD88tGcvSz1AOAouyHKsynzCC3tngDqzOvQ@mail.gmail.com>
 <27c7a370-ad40-4935-8b2a-f27468a01467@canonical.com>
 <CAFLszTh3db5HwBfD9rg=YGY0n2DKE2vfBL0UG5x1_5DoJcj5WQ@mail.gmail.com>
 <CAM=mAOk8BOz9O517614qOLCin-KjmQHXuwAkSSRUewmLG65Vdw@mail.gmail.com>
In-Reply-To: <CAM=mAOk8BOz9O517614qOLCin-KjmQHXuwAkSSRUewmLG65Vdw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 May 2025 15:26:27 -0600
X-Gm-Features: ATxdqUGczs69l83bNiwi4uHHN21X36v5H4DDp36U44pesu_ckMKURjuHviK6GOo
Message-ID: <CAFLszTiamZFOyWoiSJO4vdEUSucwh3bcVrk2fzX4X9m+e8V86w@mail.gmail.com>
Subject: Re: [RFC 3/8] boot: make BOOTMETH_EFILOADER default=n
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
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

On Sat, 3 May 2025 at 01:16, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
>
>
> Simon Glass <sjg@chromium.org> schrieb am Sa., 3. Mai 2025, 04:10:
>>
>> Hi Heinrich,
>>
>> On Fri, 2 May 2025 at 10:16, Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com> wrote:
>> >
>> > On 5/2/25 16:49, Simon Glass wrote:
>> > > Hi Heinrich,
>> > >
>> > > On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
>> > > <heinrich.schuchardt@canonical.com> wrote:
>> > >>
>> > >> The boot method is deprecated as the EFI boot manager covers this
>> > >> functionality.
>> > >>
>> > >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> > >> ---
>> > >>   boot/Kconfig | 1 -
>> > >>   1 file changed, 1 deletion(-)
>> > >>
>> > >> diff --git a/boot/Kconfig b/boot/Kconfig
>> > >> index 71ddb37f6bb..b973d9eb0a7 100644
>> > >> --- a/boot/Kconfig
>> > >> +++ b/boot/Kconfig
>> > >> @@ -595,7 +595,6 @@ config BOOTMETH_EFILOADER
>> > >>          bool "Bootdev support for EFI boot"
>> > >>          depends on EFI_BINARY_EXEC
>> > >>          imply CMD_TFTPBOOT if CMD_NET
>> > >> -       default y
>> > >>          help
>> > >>            This bootmeth is obsolete. BOOTMETH_EFI_BOOTMGR takes care of
>> > >>            launching EFI\BOOT\BOOT<ARCH>.EFI if not boot option matches.
>> > >> --
>> > >> 2.48.1
>> > >>
>> > >
>> > > As mentioned on the other patch, we need to keep this enabled and it
>> > > isn't obsolete.
>> > >
>> > > Regards,
>> > > Simon
>> >
>> > Please, read the UEFI specification especially chapter 3 "Boot Manager".
>> >
>> > * The functionality is fully covered by the boot manager.
>> > * The current implementation of the method does not comply with the UEFI
>> > specification. Especially if run before the boot manager.
>>
>> We're going to have to go through this together sometime as it seems
>> like chicken & egg to me. We don't want Boot Manager first because it
>> is slow and stuffs up FEL on sunxi etc., we don't want it last because
>> then it has to wait for networking, we don't know whether bootmgr is
>> being used or not, so we just have to put it in the middle, but then
>> we don't know whether it will succeed, at which point we have to go
>> back and try the whole boot again..?
>
>
> Sure there can be a situation where none of the boot methods will succeed. E.g. if there are no boot media. This has been the case before the series and won't be different with the series.
>
> But if we reach the boot manager after trying FEL, extlinux, script and none of these booted retrying these would not make any sense as they would fail again.
>
> The boot manager already comprises booting via EFI/BOOT/BOOT<ARCH>.EFI. And this must not be tried before booting according to BootNext and BootOrder. So we can safely delete that non-compliant bootmeth_efi.

OK let's discuss this and see what we can figure out. Perhaps we could
come up with an env var which controls this, or similar.

Regards,
SImon
