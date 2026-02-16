Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF05E7BDA1
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 11:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44EF980FA1;
	Mon, 16 Feb 2026 12:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jHRxWWAL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDC5B83AA9; Mon, 16 Feb 2026 12:44:09 +0100 (CET)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04EFF8063E
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 12:44:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64aefa98fe6so2864471d50.1
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 03:44:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771242243; cv=none;
 d=google.com; s=arc-20240605;
 b=jK9PvnMqY9sp+JsrEgNdudeRcQM6jBsrALvbLTfCy04ILjJgvzuqkOI1QuSWEFLtUO
 87L6PmEm0wfzAF7w4WMYLh1YzZWpoNo4VRFjS+fVjCbOaYMeh2v+wdnWe8L9qdPPyvuX
 MkXp8I24eaj/sfbYWBgH/B8tDV70CLaoieHdv3vZod+IJ5lkKy87KckSH8FJCMBXS6kI
 jXlJfYd08O1nespcVdgfX4MyUloacIOiw5BrDBsRN1r9rolSo9+Qisse7wqZLL/sx4Np
 PoSXYMRmorlyMUqxl6tj/0QiSQleM7M8xLVawdoKRT5YMgHne7AkaDbiMK/Ck66QMywu
 QE3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=37jzJqHwMVCizkMhufUH6LF+/gn3LZJX02CKI3CGHkQ=;
 fh=h/NSytHuRsdbAD7hlG0RbzxVojgON1YQeaP9zYX/iYc=;
 b=ls35XMzfO8dT3QuJvbXuW3f4uI9PmbdhQr6w5QvAS8iCKPPXHo7OQS8xTToXZByRYm
 wI4TRmEECStxGe3SHYad3cnhlstejwTTeWvSw2GQMQe+EBoZb48zXDLiZQMAKVAI8QHe
 DxTTTSsMOJV+NG/3MCMIdT6KJ1OEBSLn0GjAGFbR4wxa6wXp+vFoRD8Y+Y8e7hnyVOue
 kGhyDP0srIDT5RE+T7f21sqevQ7NKe4Lv3/lC8N6Zt4UTUlrs0NwhYBG8DLd9sgyKGxT
 IvnsjUXIYMr3l8hayTWgOd4Xihq3XVHedJ2M6A7MXiQpvcswjnFicnNk2Zu6xxQnlh99
 YmLg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771242243; x=1771847043; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=37jzJqHwMVCizkMhufUH6LF+/gn3LZJX02CKI3CGHkQ=;
 b=jHRxWWALWflV0PHDraVFF9HHlXBYw6PSnKWrfqBm38HeoA2Mp8Lu5aKEJosOzfRYN7
 hKyNg4r+S6lBtmvVpsiSvBbrGNiZQqyyHcoIrCDHM1MyKjTFnqIgUOrQgKt1N0anNFpf
 ATBzTE8t/Lx7jlMQ7eFAi2HAVmeiHDjRkvmzH/jV7VgWDadnmWH6JaayJYjQs6+MN8qc
 f1zrk8OVcQO5cXf8yPPj8+TjIuVCxv1TR6HKU13i/1nt0ZXkqocg77XjKlK1ZZwvd1vo
 Wfahcwd1Jhk9ygFULaxemAFMhkqga1fEbUFRyHzqQUroCP+UnQ2xEH4StCgCKCboGbyx
 EEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771242243; x=1771847043;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=37jzJqHwMVCizkMhufUH6LF+/gn3LZJX02CKI3CGHkQ=;
 b=JS+5djf8ZUGVr++BidOsa0rJOS4y/YwXuCPCDisVC81dLKTecXidlUIacynhqLDmiE
 Yp8UjN5L1v3U/8jK/6J3H0PDGK4UiJwy95ayJqkBI1CLGo4xfNgM2jwWVZQWfwIm0siU
 6U4vVWuqcqV7Ftx1YwyVa/Bk1SH7INZBFRRUx5w+JTenZkhphrB3iwHFVc14n6o7/iz9
 VelALYi2gsBAAuFg97kxNC1vixhytWJEyhD5QMg9DbkNdjifVdeiQe5epdYjb+0oHNmz
 3AukF351tkKb7kpkOHKxIun5SYA10EV37zMniLIYS4Adq/JrAav01DbkBQ7UyGaX0nxj
 HVyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAwSyFoudHVXeu5OmPRM56IEr5RfBelPRMHA5k/qPwswYBFC3UEuGb//qgAOZCZ+uZAVLqDP0=@lists.denx.de
X-Gm-Message-State: AOJu0YwprRR1v3kDH6lW0SU82IBAxdCtpxKhp961B4AuJ/UpnbYB6VwC
 TmKJ+2Z4lVtWDJ/4Vcc2OnKUJwjjZUla4TUqR3p5pEQhVS6Sr+eh5He+9CcrgfrL33o7iX/t2eu
 QKfTfJ9FKrTwpcAP2oBLspsjg3vDFe745wd7UI1ruOQ==
X-Gm-Gg: AZuq6aICK6g3iQ6aLEGtDc66gASNOpPSikIurWWC8lF61vELCQ+acbZmGAr0W6LgVKH
 i34TDQtmLD9MX4giqSiX5ztTMVlVBF+Ha3zthYBatVEo1FtepvOyOkeSBp2MJsYqrwgS97WL4UN
 WntAQ5Hcrqp37969g5rOLPlbVdKSACiZAeEbTiU9+WcAcXqu5gcFpM354+Y70vT2rqe7Z3dCy7Q
 xvUJHAz2B9+Wn4IbLBIAk3nN3gZQoxEXE+gdL4PTas9bFX33UpalCE1JYup5kHrumoQnAWAaxyJ
 vczWR4nEldPa54nf42LMLd1d2bELgKClzIiTccvMWp85s6/dupxz04ulK/qLMAszs7DItFnthP2
 Hn0dVIHLpGCr9n27cj/JT3MwIxw6FvCaWKDK68m0zJhmrOBpUxZ3Ji/ITAXTvMVBQeXysWqsNZT
 PorZD5z8pJmAnYlfTCzm8bilf+jWTV06ftj/x715qcd7W0jXL0/rcj1/SKSoVW6jA14MzP854/i
 OUiPrC5Ss5IxkwmaHixStq4aHNZirDfx9isIKY23o7FQ4nMTRsCaIxgQ3H0a/6qF3zrtkCyT3d2
 H4lya04WRaWTBgDSRXzempvyUcpXa5z+5swWIeG1Qugc
X-Received: by 2002:a05:690c:398:b0:794:d388:6145 with SMTP id
 00721157ae682-797a0cab64bmr167618987b3.41.1771242243012; Mon, 16 Feb 2026
 03:44:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1770825377.git.michal.simek@amd.com>
 <35ddf2fe394ee55c66f349dc5cc33fe1dda8f864.1770825377.git.michal.simek@amd.com>
 <1508c7be-0700-43ec-adfa-29ea16081b2f@gmx.de>
 <e5c63fcb-c88b-4550-bf5c-de46a66db0a2@amd.com>
 <E2042B0B-0842-4FC0-B4A8-49D195E5A532@gmx.de>
In-Reply-To: <E2042B0B-0842-4FC0-B4A8-49D195E5A532@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Feb 2026 13:43:27 +0200
X-Gm-Features: AZwV_QgMiMHcuennfnLrOdBmFwyHDsp6qfVQnC2XiEh8hjwqYve9WR9LWMiQCRU
Message-ID: <CAC_iWjJ4+Rx06YBAp_hYkDWXBjkJ_=iE7QzuzuPF-X9W5KyddA@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] efi_vars: Implement SPI Flash store
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Michal Simek <michal.simek@amd.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Shantur Rathore <i@shantur.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, git@amd.com,
 u-boot@lists.denx.de
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

[...]

> >>> +
> >>>   config EFI_MM_COMM_TEE
> >>>       bool "UEFI variables storage service via the trusted world"
> >>>       depends on OPTEE
> >>> @@ -153,7 +171,7 @@ endchoice
> >>>   config EFI_RT_VOLATILE_STORE
> >>>       bool "Allow variable runtime services in volatile storage (e.g RAM)"
> >>> -    depends on EFI_VARIABLE_FILE_STORE
> >>> +    depends on EFI_VARIABLE_FILE_STORE || EFI_VARIABLE_SF_STORE
> >>
> >> Hello Michal,
> >>
> >> If the backend store is SPI flash, we should not publish the variable "RTStorageVolatile" at runtime as currently defined.
> >>
> >> For the background see this commit for the efivar library:
> >>
> >> https://github.com/rhboot/efivar/commit/68daa04654acbe1bbaa17ebfc23c371b39e69c6b
> >>
> >> The first three patches look correct to me and I will add them to a merge request for efi-next.
> >
> >Do I read it that when I don't allow to select EFI_RT_VOLATILE_STORE you will be fine with the patch itself?
>
> This was my only concern.
>
> Maybe setting the file name to /dev/mtd/by-name/<partition name> would work with efivar. But I have not tested it.

I don't think it wiill. That variables describes the filename relative
to the ESP

>
> In U-Boot we could replace EFI_VARIABLE_SF_DEVICE_INDEX, SIZE, and OFFSET by a partition name, too. That way it would be the common device-tree for U-Boot and Linux controlling the placement of the variables store.
>
> >
> >
> >> The usage of efi_var_mem_ins() and efi_var_mem_del() when SetVariable() does not change anything is not flash-friendly. Michal, do you want to have a look at this area?
> >
> >That's known limitation describe in EFI_VARIABLE_SF_STORE Kconfig Note.
>
> This could be a topic for future work.
>
> Best regards

Cheers
/Ilias
>
> Heinrich
>
