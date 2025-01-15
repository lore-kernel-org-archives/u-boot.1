Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAD5E77188
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 01:17:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDDE6806D4;
	Wed, 15 Jan 2025 02:17:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B1oDk8Jj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7566E806D6; Wed, 15 Jan 2025 02:17:01 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FFD58069A
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:16:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aaf60d85238so1113005266b.0
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736903819; x=1737508619; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ujgHm1YsdANoFgpVALFDJK36hxUrWI4NXVrtPHGwi7E=;
 b=B1oDk8JjyzoTrT9sXSsv7YTlVDT38hfWw30o/Sd2fYvh8zH3i0JE0nApVuGLGUe9Z3
 MyJoyS5r9y99zJl6ZkVjFUvOaoQDKaJRhhOIRTzu26fTSobwWEfD/tl4XFRivsMsVJm/
 /FMVltyPtXhgnXLx4poFxUt4g7a6Uz+x2KGp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736903819; x=1737508619;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ujgHm1YsdANoFgpVALFDJK36hxUrWI4NXVrtPHGwi7E=;
 b=Dw9xzrgV9eMnFRhzCLC0F7ApBXCGLqs+B7eSzuWsx42iW7/0ECvkd1dxJA9qtTMfQB
 6mjNNABeYrG1Rnrcx95g8Yq/467ibNk3QGXzmf1rFUvhAnxUgljbpf9OQoerKJDXBUiP
 2XUoV9nHKldGKak0nzXM5QPFZXQT1QPYd/64bx0KbtoGJ7Wr361yHpcGko0XdiUAeb9D
 05x2oQ7GSAg+ku+OEtJLHdeSg+ij8DIjqhj9k/wcqTT+c70U6XbezpvZkJVfhJZ2n+ow
 pxAeZzmQi2QkmIS6eQKll16p33e0HK+ZwKvfjIMQNGjCLLbyNMhLx+m2pvzaUbJ+1l7m
 9RSQ==
X-Gm-Message-State: AOJu0Yxc4V8P75pgqbUN+loIxxh+WQ6oV5mjnKuuYFQV7U8uYY1+fdGP
 /5tVrjpTnLT2FsUIQa1/dN7dLI2SHwrJ4n+3hAdOaDkFA+s6mj7yR33zPMgMF9W0epSLxIfv+lA
 q6bKYviwwUa3Zo0QURoMXkXnxDr2rdbfEAxJGhGhtiZrDDoQ=
X-Gm-Gg: ASbGncvsGq39m0K1apWckpVvasBhS056sCB1EnJVEGVxqjZ0+Ny1dEIKzdlL7rqMw/G
 S8YlW5j9Jq1FxNQ7zoQfAciBOnD9iixkD/tYhoqU=
X-Google-Smtp-Source: AGHT+IFetuYRisYdx4CVa47f8ac4MKWQdlExqB4B5Oqp6YuH8TwnNe4afmQd60cPvmFPAkKRQRedFMl7eKuTrpr876Q=
X-Received: by 2002:a17:906:6a0e:b0:aae:e784:55c5 with SMTP id
 a640c23a62f3a-ab2ab7101eemr1920135766b.33.1736903818968; Tue, 14 Jan 2025
 17:16:58 -0800 (PST)
MIME-Version: 1.0
References: <20241220040120.3245610-1-sjg@chromium.org>
 <20241220040120.3245610-4-sjg@chromium.org>
 <a1572755-9853-4941-ac0f-3a30bce768a3@cherry.de>
In-Reply-To: <a1572755-9853-4941-ac0f-3a30bce768a3@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Jan 2025 18:16:45 -0700
X-Gm-Features: AbW1kvZT8rhWVU9QreCyysGZQEE0VdOYtU7RjWOuwFLTN-rD1yNe67mnNlo356I
Message-ID: <CAFLszTi0CToKb8zLC1tRXW0XabQTAEQeT3PUZbR9YRybr9R9DA@mail.gmail.com>
Subject: Re: [PATCH 3/5] pxe_utils: Allow the FDT to be missing
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
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

Hi Quentin,

On Tue, 14 Jan 2025 at 08:13, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 12/20/24 5:01 AM, Simon Glass wrote:
> > The devicetree file may not be provided, so avoid a failure in that
> > case.
> >
>
> Can you provide a bit more information on when/why this shouldn't be a
> failure? I assume likely x86? or Aarch64 with ACPI instead of OF?

Yes, either of those, but also, even on platforms which use a
devicetree, some don't have it in the extlinux file. For example rpi
passes it through to U-Boot from its own closed-source firmware.

Somewhat related: my opinion with extlinux (and EFI for that matter)
is that we should be using FIT.

Regards,
Simon
