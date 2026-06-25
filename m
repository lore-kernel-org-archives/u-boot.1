Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6223CDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 10:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 681BA847C8;
	Thu, 25 Jun 2026 12:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E57/45W0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FAD984949; Thu, 25 Jun 2026 12:55:55 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21D968460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 12:55:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c074142cf6dso188835166b.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 03:55:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782384952; cv=none;
 d=google.com; s=arc-20260327;
 b=iC9o6JDYx5p6iRD4b5wI4Y9J+hfJ7rBVpbh3Hd7FkdZbZE/n2OFGVf2M2Fg+pJRq1F
 cMMMGZCBxA+SxJEWLltaoBfhV2RPt7q3qUcslPlHNPi6a+p2V3BWq7GwTHIN+vUxaVis
 ZFWLPvk97qeTB6wwEzoz6vCVRRaGqSGfLHL1zjwxmMCs5SeT9VZpqNudSYr42SaRdH+v
 K7CdstRDaUQh+kevGoQplnDQJ8oE4G9YTwmVVDwK0D3iCHN6D2540EL+hbA5e9fpJ5Vt
 UDUOerGw++zDAK/J2nAPtYA65+kYdH+z+o9ZpXMcdSXUJH/nbkd2b5HIvoFpVxOiLyG3
 vAEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SeH0F4pzLJUJVkQI3qRH+/zIoPriUdn1X6O93Az9odc=;
 fh=Z4yLj43ahI6uuOf9+07zKoAcIItxgPMz2kioJsUl9c8=;
 b=TR1MKfNDeyv9SVSPy9t2dOgbBFTU4WuH3uNz9rSY0zPifn0B2dgZup7uQKPKSOsJiB
 I1tIokuyH9cHMFtDqq71dDMe/iAdMPRq/uzF0mWB5Rh4WQmPfJHmkH5ez2hrJ4hRI8ed
 ZRhE7XzaCI8TFC5M5Z00sRFVubk/EqmDGgFFTxZvUtpDEBraERDX6lDcFmPTaHnTPoze
 b8qZd9SVRQJCkJuhXGdhwQcQboecS6BHwLafucdIjFeqd4pbew54shN7UKzY51sQCN79
 MG6MU0t7/A7KKUv8Ts8zoCoan+KTwjEMUDMkjaRLcMm2v710kvxh9b+eA/9hkqi4jers
 uR3g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782384952; x=1782989752; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SeH0F4pzLJUJVkQI3qRH+/zIoPriUdn1X6O93Az9odc=;
 b=E57/45W0vR6xclDvNddTh3VcpFMp5IU6ayHiuWw2dxHWnnalM3foboDvM36cFAw7fI
 +JCSjIK/Mz2nNyqbpvETx59+GPUVf5BTcwYclxP5gQV1TGQY3WXTA9w9OPUhdZAVXFgg
 cQnIaUiok9055iqrPLUEw2qogLq9sqe+g0hxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782384952; x=1782989752;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SeH0F4pzLJUJVkQI3qRH+/zIoPriUdn1X6O93Az9odc=;
 b=kld43hqnU4gzah2eJld8RY8U4Fj/tFFDwcRF7+ySbmjQSatR2P8LPl5fT9R60+Z1Kk
 3amdTJ7wwjYtD9PMEa1E83evNo3ryUysi5ixc8jvaz+Te7LaKKlUY04XiWibBwLJU3EV
 S6H+sT4mpXuRqpZlV9R2iCqbxVO171wM6NrOjsGp+QwCnKLxKz8XpjYVx/0Aypbg8CXn
 hsV4z5sIm7fze6blX1DKrjlEp0eCD9T3CdTkYjGiqz8GysRVtmlxMgNVy26v/8hlpIXd
 AQxIK1vvtIWisJPEpRtcdCt+w+ndRgcELFh9pb0cra36x4erHDf5gTbrvQ91cE5Cs9ki
 R0MQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtEzo6KJjEk7ZslwLV6eVoLTsyalib5dCzL0khMiw18U68agARcv0B0OUookDhw2/kfwOma/Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwPx1ZpdW6TVX0BQuD1FX+GfPHtlxSa8WweMNYIFT1YAc0BkLMD
 t/TcCilzkZOfJCiWgGU4S1Il/fzpbF9px+3E6fkUXBfXTiFALXZmyttz38GDdDiUowsJYXXucjm
 vRe/QrUdKJmfp7zrCpBlpa5Z7KqXTevdO+rKsLZIa
X-Gm-Gg: AfdE7ckYb533yrNKIXqSQX3PQuCPQVJLWBF6OlnDobehifrNt2z31333P7OGo6hFMPJ
 LhF9a4PN7/9mGVR12guLGKSOg9Jb5hGvMLzoxXYwf8/wkFQKeSJ/21ahA6XL5wktd9taejqApqN
 r/rFGVVq7qgexu8D9BUlKThRvWzf/3jBcwRAjzLvxFDLqQTOT/lP05RyGkS+j0wrd3l2WvwDtFp
 6j6L85MJnXDqF0nJmYwk+tH8nnBFswOIrj1oVrBW2PX+oUo5Dt9jUEm8eyqjzPNxaqgLjheBw==
X-Received: by 2002:a17:907:c01c:b0:c11:fe5c:28a6 with SMTP id
 a640c23a62f3a-c11fe5c2b4cmr195857966b.5.1782384952528; Thu, 25 Jun 2026
 03:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 11:55:40 +0100
X-Gm-Features: AVVi8Cd_a7zTzlPoJMsqf4wsepXvRj_FxPJdNAJrdgfxiiJLd6I7LyRCZbpSR2I
Message-ID: <CAFLszTifgugTbuWsU9t+NCPaeAJxDeKaP-aTk7_qvCOvO8vWoQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] efi_loader: fix ACPI table installation
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

Hi Heinrich,

On Sun, 21 Jun 2026 at 09:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On the sandbox efi_acpi_register() used sandbox virtual addressed instead
> of pointers required by the invoked API function. This lead to EFI
> applications crashing when trying to access the tables.

This series helps a lot with test coverage - the acpidump app is a
really good idea IMO.

BTW instead of 'used' can you please use present tense in your patches
('uses')...i.e. the current code is the status quo and your patch is
proposing to change it.

> The next for five patches factor out common code of the EFI apps

Typo: 'The next five patches'.

> The tenth patch corrects the checksum in the RSDP table.

Please mention in the cover that this was uncovered by the new
acpidump app (assuming that is how you found it), so the reader
understands why a qfw fix is bundled into an efi_loader refactor. A
line on how you verified the fix would help too.

Just to recap for the record although you already know this info...

In sandbox we used the term 'address' to mean a U-Boot address, which
must be mapped to get a 'pointer', which is something which can be
accessed. Especially in the EFI sense I find 'sandbox virtual address'
(note typo) to be confusing. It is a pointer into its emulated RAM. So
I would prefer to talk about 'address' as the address (ulong in
U-Boot) and 'pointer' (or sandbox pointer) as a pointer into the
emulated RAM. In almost all cases (and to avoid confusion) we should
use a ulong for the address and a pointer variable (e.g. struct xxx *)
for the pointer.

In most cases it is convenient to store and pass around addresses.
ACPI is an exception here, since if we put an address in the table and
then jump to an app* it will see the address and treat it as a
pointer. As I understand it, this is what this series fixes. It is
also why nomap_sysmem() and nomap_to_sysmem() exist.

* The interesting thing about the app is that it is built under the
sandbox architecture but (rightly, I think) without the sandbox
mapping.

Regards,
Simon
