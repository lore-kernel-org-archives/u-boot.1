Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D984FF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 18:17:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11FB4846A2;
	Tue, 28 Apr 2026 20:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zt+Wq5tN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F92A846A7; Tue, 28 Apr 2026 20:17:08 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76A3284694
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:17:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b9c9d03524cso1647068166b.3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:17:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777400225; cv=none;
 d=google.com; s=arc-20240605;
 b=WHDCHL+yYv07ozvKxZW53Ri9cCcIsq8J2mXeXJc6Mi5fDA2tulxnSiGL+Skqbbiyuj
 pOnn/7ebA/P+Uus6qdFE0yV+bpifVcdb+GE1bQXWTnCK0tPS8/ITRkBil/4AxCvjn95h
 oOUVX2ecbomI2ZGVTXOtN5HbiMJPHIoxXVOyM6RAp7h/TBDk7yQ2siL6DIGzPFtPnja8
 LkktU/b1mrmOF8QU+wmitpMUXjvpY5vjsMaPluFx6a+eaUbcJh/iV0JKpcClESXmyx7v
 mRfSzpY4UfFBf+ellCYDDl/TUziPv5i/DWrRU5SKgJC0gcXiHj9BvEjFMfqgRSb0qn4r
 /8kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=P14U5QWczpgd4zONML+T7qPFKynKru5xT25jkcT3A4M=;
 fh=ULnHtFmZm1BmZyjllnexwjsT9NrAdOjxwed+DzCYTx0=;
 b=jWqwbzhnfC0TxV9ZAeS+QA95YbK7/ET4lL9nIDyHRfEuSRYSUnqnUcSZMq2j6heoDQ
 frjhvPkqIhYvXvESt6UGQf1bxF9yig7D5RtgAO0+0ojfSsDqxgwYnUWiemyfiWnVyBj4
 60UUGvi4CH/v9aZGgTL0ex5XJ4vV2yC0XGQDowVeYwLz4VPwkSiZNGDv4kVZxWyPZpS3
 cCMq3D+V+49+iYDovTsQpPW5iEPjFwIKzNWm1tyV8ca5fZnLd6j0GPv+UguZBE5h6xoT
 q8voGNI4RHi/G9CXEm3E0guqfG1mu6wC+t4kmag/C37cgVbOJbS6vRAphilum7QkPMTr
 vMLQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777400225; x=1778005025; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P14U5QWczpgd4zONML+T7qPFKynKru5xT25jkcT3A4M=;
 b=Zt+Wq5tNbqyvF9Lzacuc5lKdANWdlPYpMMabuLtBWQXqj3FEEhin4dkcojxWgsbxsW
 9f8lsLC8wJa5CiBFAU9aITzvZiw104eJsLawIR+x8jjPZBTkfkgTfwXIzHfze11WTuXG
 rtZFo1CL489BdsZFiK6Qyg4RF6L+t4lJ0/mhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777400225; x=1778005025;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P14U5QWczpgd4zONML+T7qPFKynKru5xT25jkcT3A4M=;
 b=dLGiNWeQl8q689/WfBDD04Hhc6eaf894C/ofxxxYPPk5QTeMxYXndKZZ/4wPMWeVFO
 olssDNaKFFTNTgf7rG8ZlUzC+wXaXiU8DjWDbP5pFbtGsoL7EoX9ae9SyqathbDRA1fX
 luORw0KjIx6t948e0XDyioUsIMorMo72q93HzzPBi9QXNszNegVOzyzqc0Njur/bjnwQ
 N655SyYAjhgI0GnpKtzb7F5PrXHC2SW7gT1d3kfbpjr7UfykaNfSSX4GcdiGB9RzDKl8
 Bmx6Ml687JGqIqX1cjYSmSy5e8Zfh/U9z6RkBTnKUbBzuelKY9E0YDrkR2u49qsn3RAc
 cZ8A==
X-Gm-Message-State: AOJu0YxD5+hVFuIyuPkA5CdfHaf6HLgf5jD0H5OQ3g0kt5MHowz55yfK
 TooAkKkk8pUnIc1a8O6svlFONmL4kA3Jab/vqJZweBDxAnn04I6CvSnU3PRwfRX0bQTOKrgKzDH
 Qx3qz/gJxob4Tdr6d289ATjsOkXMRemBKl3Y4E4a+NwIARFEWBbI=
X-Gm-Gg: AeBDietvKGxnpspOpOjBNQGyCGC3/ZwMkm8r+ASP7fvBnV8E02YhoCVmGxKQtYOdl8v
 1WTQGK+yJp6d54Tr2CjRAdF0wm8jDjKatBcZJCoGUMAFqvyts7y/piLpzddevP1Uvd6+/eGuCit
 vYbx+oXRUUmZNcwAFZrs30L16Sq6Qr623i0F9lqPQyuDHHjx51OOrH/vEPk3q53a+qjoKeCwq6B
 BCvdpq1EqHzAnCmDb912cixzPgUHsuC+cHiL+sixERMLGnqRfIyGEf+Min2UKRZDhhUOuQyOUNO
 cgdUa0U7na330h9uj4fzA2kss5k=
X-Received: by 2002:a17:906:6a06:b0:b96:f863:deba with SMTP id
 a640c23a62f3a-bb93e54f244mr30282066b.32.1777400224744; Tue, 28 Apr 2026
 11:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
In-Reply-To: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 12:16:49 -0600
X-Gm-Features: AVHnY4KPsDYcdJBZSzB3aQrslWr2nRmeGeofIyDPo2-ATY8HBLvT5koLskE_ts0
Message-ID: <CAFLszTiY1HHER7fbGz+0BwDBGcfG7Kkp29641rvWOv7DyD_scg@mail.gmail.com>
Subject: Re: [00/12] arm64: FF-A runtime transport for EFI variables
To: harsimransingh.tungal@arm.com
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

Hi Harsimran,

On 2026-04-24T17:31:50, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:

> efi_loader: align FF-A cache maintenance with runtime path

Patch 12 changes the boot-time path to match the runtime path, but
sits at the end of the series. Between patch 3 (which introduces the
runtime cache pattern) and patch 12 the two paths are deliberately
inconsistent. I'd prefer this alignment before patch 3, so patch 3
simply adopts the established pattern. It would also make the
rationale in patch 12's commit message read more naturally. What do
you think?

Regards,
Simon
