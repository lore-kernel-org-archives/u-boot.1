Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256C5C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 19:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B54E8700F;
	Sat,  4 Nov 2023 20:43:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NtCiWkQz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37FF686F7C; Sat,  4 Nov 2023 20:43:00 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AF5D87086
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 20:42:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5401bab7525so5368679a12.2
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 12:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699126978; x=1699731778; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DWddhVZFZiBORLm57HoBR8jte9F12rd34ICNsoPDy0k=;
 b=NtCiWkQzo14hLIOHEvPeHu6V7dee9wWuK3eEUDlkRm8lxaCJd49gHbhcTtNmrUdOwQ
 hLy6BQps7HeLloot/7gUiOGl1/G/fjj7ex9th4SFMiSlxGUH+AhGRE2R1RLE1rQqagS8
 L/BOzmeMkuPKqNmgtjmP5wmr9EcbNnpyhCYaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699126978; x=1699731778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DWddhVZFZiBORLm57HoBR8jte9F12rd34ICNsoPDy0k=;
 b=kBDouFWuYIYu8rSa9CnwMoAe/Vs8L/dFO1OFzh9iyr5UWBtPZs6SzTeYOUJcg2u87W
 i2pef8FLNqZ8m8lpglindzYPNiY9dE9YPusDlq5CKDYaC/IPd90X+PeQ3+DPitoe7QWP
 h8Np4WvRviuzq08bzd/xJgZ0aXvLEbprPifYHbfWm4EBKm/rz/MHwQ/ha4wBFZw01wur
 07PS2qQXBSXOugAP80mA3rvl6HxMVFORYz1t48jtW22EXBDQyu65S+zHy5zXrY5NuBB7
 +fJ0hyvC2KeDGEoy/3M+9Cvjm+VZYTBvoGhfi8nVthE1M854Gl24bjuitXej9HSFfzYQ
 caRw==
X-Gm-Message-State: AOJu0YxaXPYQtbDE5llXEESuVNf26TYuQ3R077HaCw7z20Q0vVSivgcU
 VEp3JgIvu9J0qNUO9h8lnZxQ0PE8ckvJKMCK31TjdQ==
X-Google-Smtp-Source: AGHT+IEl1MPGUTBZLxM1rj6K2m862/OJwGCCFWKNWhGL2h8kvOnG5H1s9GBe5fsdZm53yFIGEeis5UaWB1GhOQSJ3ZQ=
X-Received: by 2002:a05:6402:951:b0:53e:8e2e:2b8f with SMTP id
 h17-20020a056402095100b0053e8e2e2b8fmr19815719edz.9.1699126977582; Sat, 04
 Nov 2023 12:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231104065107.23623-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231104065107.23623-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 4 Nov 2023 19:42:41 +0000
Message-ID: <CAPnjgZ36uRkVGKicr_hD-=0HO+i9giQ7vRxo0uKD+BGQnLWdWw@mail.gmail.com>
Subject: Re: [PATCH 1/1] rng: detect RISC-V Zkr RNG device in bind method
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Xiang W <merlew4n6@gmail.com>, Andre Przywara <andre.przywara@arm.com>
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

On Sat, 4 Nov 2023 at 06:51, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The existence of devices should be checked in the bind method and not in
> the probe method. Adjust the RISC-V Zkr RNG driver accordingly.
>
> Use ENOENT (and not ENODEV) to signal that the device is not available.
>
> Fixes: ceec977ba1a9 ("rng: Provide a RNG based on the RISC-V Zkr ISA extension")
> Reported-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/rng/riscv_zkr_rng.c | 34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)

This device should be in the DT, so you have some control over which
RNG is used.

Regards,
Simon
