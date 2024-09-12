Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63372EE57F6
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 00:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B279388CFC;
	Thu, 12 Sep 2024 02:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eWKfzCOt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0308688D1B; Thu, 12 Sep 2024 02:58:38 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B422D88D28
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 02:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2d8f06c2459so287425a91.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 17:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102713; x=1726707513; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FJ3fVP6Uic6lPVFcKM8nwOgQnoHlTFDIo3L9EHbLgc4=;
 b=eWKfzCOth6uxdWUjrGt+yWFkVSjinNwYywIcGzUtaRPaOWuxf0PC6/VuUboaTnTGd3
 n9MZ29i3IHRDFuD14kv4FmyCE0fRFqOSOuiLpAOkRYnRD7S+aSHsfr1h3QZKVRkDxzRb
 lpcvQAnQ5OjAE0LUd14WvomVGsaYLBGkldqzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102713; x=1726707513;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FJ3fVP6Uic6lPVFcKM8nwOgQnoHlTFDIo3L9EHbLgc4=;
 b=qkDzPxgOxqdyAn0DULkiuaj1hj8TEbFpJNE+zIj8bKlMFJXSzbmUG3yqzOtekOci+j
 pM8EoT4CqD6OB3TjYU3JW65U8j2IzEx6LeTEddkbprDvdzO4LcL33fHhnI2P7E8+Nkfv
 PjcLG32OOEW/trPmSKlzNgVj9fA3kPT/23EtAKcrKyaXcbhzXKhsU9vEhcher2I+PFcW
 y0Ok98Llv3Rt/EImCveYkjG8jhRYGQTgTxkFNgVZiR3OegYGZuBSpbq6GTTYgQb0TRjJ
 vxnKbRKA20ODbF0soy8/xf33tiFbmFjuzaZ/pYeOUdoSW1Nc7yw7m42tYROlGDfSx2tw
 ZyDw==
X-Gm-Message-State: AOJu0Yy4tom8gAQQa4k9zdEbldzs89dYgnPcph3PMNUbeYa07/1fhH3j
 VqUf1HXfKpgS5YIT06RBJx6mMWpWShrnkDaqK3keHovD5N5uQD7ErdceQynQFT44pCIOdrxmeXc
 1d7k3tjA+iEIzw+/xzidFlv+suanQVBwboiQGKnmqUZfQZoc=
X-Google-Smtp-Source: AGHT+IGg6kOLOm9AN2S69cf73K+9C9G0A8Pg+OuS9jFp2cJ8IqVyt9RScWKkqbGHEt2x+/ffEbzH5+3HBKNEpVmG+oA=
X-Received: by 2002:a17:90b:4b45:b0:2d8:ee39:47d with SMTP id
 98e67ed59e1d1-2db9ffa3bc1mr1176796a91.2.1726102713224; Wed, 11 Sep 2024
 17:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-12-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-12-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:58:18 -0600
Message-ID: <CAFLszTjZAyPnm1o=G-7enP48pZ-D6BPb0t=EAK73KsS6jM7juA@mail.gmail.com>
Subject: Re: [PATCH v3 11/30] acpi: acpi_table: Add IORT support
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Patrick,

On Wed, 11 Sept 2024 at 00:25, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> The SoC can implement acpi_fill_iort to update the IORT table.
> Add a helper function to fill out the NAMED_COMPONENT node.
>
> TEST=Run FWTS V24.03.00 on RPi4 and round no problems.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  include/acpi/acpi_table.h | 213 ++++++++++++++++++++++++++++++++++++++
>  lib/acpi/acpi_table.c     | 213 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 426 insertions(+)
>

IMO the 'const' on scalar params just clutters the code, but I suppose it is OK.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
