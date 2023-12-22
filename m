Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E61AC41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 12:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D23AF87858;
	Fri, 22 Dec 2023 13:02:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R5Dna102";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AC888785D; Fri, 22 Dec 2023 13:02:46 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 386CD8783E
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:02:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50e6a806e4aso420110e87.1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 04:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703246563; x=1703851363; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TCFp0sqNzu9Nr24TU0UE1DTqZp6VRcthmHkvzc7IsP4=;
 b=R5Dna102CCSZUGBlA5CXeDyp5e6VyOuT6DzVVfuLmQLpsO+QNvBf5PWnSTqNLdzPh3
 MpyTKI+XFFe/7XnbMla4tKxSZ3AmgLa5w1BcP5VKJSV9RGVL/+NI/BKbDJgaN7GPgSyb
 J/lWHw4xSlSydYU8abo3q7ufcz5Hv9m5UO7oYq79pyznNjkz2JG64K2qssOEPbR0FpDZ
 QxbdDx8fMdudDyvpkwta+2twuHXnBXuM06juK5jYGB73EmEghkBuZC8cz9mw/mX5KpSi
 GkIAVBlPweF4ANA/bjrnWTSZtBOYtWeSpkwfg+uqMi1r9Tqmp34TrcTCWhNy6LDKKQkx
 CjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703246563; x=1703851363;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TCFp0sqNzu9Nr24TU0UE1DTqZp6VRcthmHkvzc7IsP4=;
 b=MutOcZ59XufBfvUOZB3UKd5JTTC9RB5YWoQi2IbkTHc4iTwipC6yhMfOjvDyAMbwis
 GQQ5tKpxMaZ+Bdty81pXYmTvd5gxNclo6bUhpubTtelRXr6yOyqYgcMys9LdAqJd6Vwk
 c3TMgBQ1os9Ofp+OHTznMfzN+QcdxjM/et3ErT1ks3qCtXziUrLpgsIE8pECrYSpBICZ
 v6hTA5y5HBNmpuLLEc0YEhGrhWyGScfAaJ6U093iPZwemcDSTGavvCze5D8Y3Mm4/KWm
 x/o9TDT0J00lpLRFypXqyZCm5VP3tCzh1bYa+i8O1Y92krzyG8f5H6WpGo1pT1VSoU46
 +dag==
X-Gm-Message-State: AOJu0YwxlRV6N4J6UyPB6LZ6o37U+j4XRAzKQKn4ApUblTIpP47DWTjp
 dPGKPPDTCG1oBCsn0UXNR0xXOBwCBBKNHKebgFSgoLHWyt8DNg==
X-Google-Smtp-Source: AGHT+IFLXbzUv2UyPBBqCmglWcdyq9Pb6et7RrDxMiKCOLPKm8burGtrIFoEn9poo0LICK0S4bxh7dYM5vMWrS3xlRE=
X-Received: by 2002:a19:4352:0:b0:50e:4bdf:f943 with SMTP id
 m18-20020a194352000000b0050e4bdff943mr556959lfj.69.1703246563351; Fri, 22 Dec
 2023 04:02:43 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
In-Reply-To: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 Dec 2023 14:02:07 +0200
Message-ID: <CAC_iWjK2Rm_DPhk+1PwFmdARJ_7svNuKd3GTKUwzEm=+iWZS6A@mail.gmail.com>
Subject: Re: Proposal: U-Boot memory management
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi Simon

I'll respond to the rest more thoroughly but I since I caught this early,

[...]

>
> 5. Avoid calling efi_allocate_pages() and efi_allocate_pool() outside
> boot-time services. This solves the problem 6. If memory is needed by
> an app, allocate it with malloc() and see 3. There are only two
> efi_allocate_pages() (smbios and efi_runtime). There are more calls of
> efi_allocate_pool(), but most of these seem easy to fix up. For
> example, efi_init_event_log() allocates a buffer, but this can be
> allocated in normal malloc() space or in a bloblist.

The TCG event log is only valid in the EFI world and is described by
the EFI spec extensions [0]. I prefer it to remain as is

>
> 6. Don't worry too much about whether EFI will be used for booting.
> The cost is likely not that great: use bootstage to measure it as is
> done for driver model. Try to minmise the cost of its tables,
> particularly for execution time, but otherwise just rely on the
> ability to disable EFI_LOADER.
>
> =E2=80=93
>
> Regards,
> Simon

[0] https://trustedcomputinggroup.org/wp-content/uploads/EFI-Protocol-Speci=
fication-rev13-160330final.pdf
Thanks
/Ilias
