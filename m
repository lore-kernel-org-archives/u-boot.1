Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89F8C44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 18:43:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5319884D1D;
	Wed, 15 Jul 2026 20:43:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jEx9EAeJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEF5184D25; Wed, 15 Jul 2026 20:42:59 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 071BA84D1B
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 20:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c166f1bbeaeso290715466b.0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 11:42:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784140977; cv=none;
 d=google.com; s=arc-20260327;
 b=B7QmWDR6l9EGZSmBcYTQo+IHgTOcLr6curcPJw6F/BlLZBc8hBM7hQYBjkcPwfJkdW
 Mql+Ru/iQldDtLjWjuTj5whxmsMbqBDEkROFfNMqCOw0Vh3NDQ/OgZoEYuVNZTBMXDkS
 k/5fv8H9ZBWoHF9n4XrvwDctmc3dxuaZJKCPz9UrjXEdG9PimY0ypOfrnoZXN0B5Ay54
 zWZU0ej8TXEj+I3XgmImwAQxYLN6SgAyreAksG8TNKbmnrHN0cpEitrpdu+PfRMvcYC6
 9RAoUsEzTogJsDAPOXGE5DltLvzrEsglCy9Ur89nOJahNufkdF9zUpJot0tlamlbObuy
 OHzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9pW2nFudeHTeMaQc1dlE25Dzya+dhn8bqmykkQqPQ0c=;
 fh=2LGbMvXCGKc3ffQbSdLHwaKiLzDbvEUHnpcfS2YzIUg=;
 b=frq8Z1+BWSOgqiNH4OcBxHVmhtgeaRD+jQAv9PMvv96nMJBDDC9W0j6PNz9erLXEYA
 yA0a9NbjSRgPoN1AULEDKsiyIDg1/NkFTWAQ9sqQg3RRD3yUf1DRn3HZ2Y/dfAmj0ByQ
 vEsbUjJfKxDjo8rwpCZmmJHV+TIh0Knb5fo56GQI/1fLRCvnNrGW2TfDGfZVL4q/+otE
 g5kt8iCKJNd7wm0jvramswTVVLhYOiLctQCpWhaPZecHPBb4+cVQNYsV/yR6olf/3fmx
 iw7Od16lqCeg0M1AJPX7mRfA40pweOOszAiTNVucx/E4TNkn+T4LfAsBkJ998nplEny1
 GjNw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784140977; x=1784745777; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9pW2nFudeHTeMaQc1dlE25Dzya+dhn8bqmykkQqPQ0c=;
 b=jEx9EAeJVsZPPi3DvGvB1zwG8TE3HscqGQg+x6DAAW7ei0EGVkg42o8gixBUSfZPIQ
 ADceIJ/rEWHp8+J7/d0qv3GJODzKMB1nUQ9030xHk7dp9NrO8NYPzKTpEvFXJGHG0jpX
 nlpDrn1TUM08yo8c4LPG39bOmXM58RNgp4+qI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784140977; x=1784745777;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9pW2nFudeHTeMaQc1dlE25Dzya+dhn8bqmykkQqPQ0c=;
 b=OmhdYO6UXLlVU8oH7+GX6O4dEcKmVEYC2GcqXtVo0+tPHECEEvSpp2GAjfTeu/Ulq6
 OeIjdIaW2Vez/4GV71IV76q8WT7kApSiKMcdel9m8Rmyi/GH81nGZjz8mIG6Jg6FEJQw
 DrrUYr7FMokNQudUc+5N26GcDOOEgtLOhsLVc5m/wHJpqfUORTXYY7zI2b7FlEGnjblM
 lmgONGgNj+YG+4WNY14IZc4Yq/2da0fQ0X6m579g0QXrO/H9rZShqIdLmssNQt5n+RK2
 fJ+b3vA9dxocie+vR7EFbD3lQnD0fQljdmRrzYZxCvkxOe/2G1LKMwhybzjRKS47WQWX
 CekQ==
X-Gm-Message-State: AOJu0YxT3FMf2pJPZpGDKPKJYDrbihBvMRUn4Wji8GvFdGuaHTj4fjkT
 qJqRqBBw2mZ8/nEKQA/2NM0jZs5osj9iakYSwr78sfZjyefws2M2HXZ/aWx5CFFlkwkIrFYd52L
 Yyh+iRWjKjKaSJ9hR+haAbyQZuM0iFXh3vCyg86tNawzGXQ2LjJLnjg==
X-Gm-Gg: AfdE7cm5tOHOKgcZ/wcH90swhAfKm/7TzwQLhsqjBkobkVFpbwnXWskmBQEse4FsExE
 /tpr6cFv4xAQ2swyjAJQekk2EA9SeOmMJNOFSSna+pRZ6goAdM6p8Ifho8xM37yU83KtxSVqLa0
 PtqPtm8stIRx72IjpGOCg/Mr3+3PQTqybd5X5EuEHPT2APdfVBXeWIR0XcMYJzKy098fm/2bwiK
 zC+VT6NI3eiCoJRti5oEFWe64sQlhR71slowmQL3cYGBB+a23pIJ74VAuXQ0oLMZzMtdEk=
X-Received: by 2002:a17:907:3d50:b0:c16:63c:a749 with SMTP id
 a640c23a62f3a-c16616654acmr564170766b.18.1784140977493; Wed, 15 Jul 2026
 11:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260706215446.4068820-1-visitorckw@gmail.com>
In-Reply-To: <20260706215446.4068820-1-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jul 2026 12:42:37 -0600
X-Gm-Features: AUfX_mzF7ADZct4HIG0svQEmitYMRsX0G-9Uk9Gcy5WdapaKdVZiq6eqMYuGItc
Message-ID: <CAFLszTg9cOebpV9BDecNbU+GYvo-38+ZOyHPUge8PcUX_iu97g@mail.gmail.com>
Subject: Re: [0/4] fs: Add 9P filesystem support over virtio
To: visitorckw@gmail.com
Cc: u-boot@lists.denx.de
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

Hi Kuan-Wei,

On 2026-07-06T21:54:42, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> It allows U-Boot to directly mount host directories in virtualization
> environments via virtio.

Thanks for working on this - a nice feature which has been missing for a while.

My main concern is the overall design. The transport driver registers
a single global client which the filesystem layer picks up, so there
can only ever be one 9P device and the QEMU mount tag is ignored.
Since the transport is already a driver-model device, please can you
attach the client state to the udevice and have the filesystem layer
look up the device, rather than using a global? That would let the
user select a particular device (or mount tag) in the ls and load
commands instead of passing a dash, and would fit better with the rest
of U-Boot.

Related to this, intercepting the 9p interface name in the generic
filesystem code feels like a hack. It would be better to integrate
with the existing device/partition handling, perhaps along the lines
of semihosting.

> The functionality has been verified on qemu arm64 by successfully
> loading a Linux kernel image and an initramfs image via 9P, and booting
> to the Linux shell.

For the tests Tom asked for, one option would be a sandbox transport
driver (see the existing sandbox virtio support) so the protocol and
filesystem code can be exercised in CI without QEMU, plus a pytest for
the QEMU side. A doc/usage page showing the QEMU flags and U-Boot
commands from this cover letter would be a good start for the docs.

Regards,
Simon
