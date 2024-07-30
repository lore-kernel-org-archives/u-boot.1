Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC41C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 06:08:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E24D888E5;
	Tue, 30 Jul 2024 08:08:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="f6RCtJP+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FC5F88908; Tue, 30 Jul 2024 08:08:27 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E6C2888CF
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 08:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e05f913e382so2535904276.2
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 23:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1722319703; x=1722924503; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rz7os/Gp9+ytDkaw0syesAy5AWvs3gFjSPH51uvUGT0=;
 b=f6RCtJP+evIa4sVxDXH2u+A7wNgXOE4vkonrV4og9+bXjjHvZpw9v/snqyfJWcraW4
 1RSiYhT7DehsXjntVRdGNHOu2dUujE/btfSqPkJLPotepAE+VKgXFazanuftnviYx60R
 Nk+HBuT9NeKz7y3InBD481vCLy7TcbnxmWjPKHmtIsWYURVkakaCGmdFC3IyRE3+k4JF
 VA9yFFLxk9a0wJQPEIGZHzUqj8O47u0/gE3x/9iRSraT4UllU2S/tIJJ0XsJYO1bUSSi
 e6kaQDxoPXxAw/+CLm4hb9hAILrgHnT69XKcLF1PdTQjS8Qv8aQbdUkkYQ7T4hD+XH/O
 V5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722319703; x=1722924503;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rz7os/Gp9+ytDkaw0syesAy5AWvs3gFjSPH51uvUGT0=;
 b=syDKK9t08XmZNm6pjX+/BItYQkQr65Cb0qF1lsuYBGYh9ncs23pko+CRhFk43Zn7Zd
 rN8E9jsU0FBLutVbmr7yDYY8nCRy9Bp1uJjnDrrjMnLmXxuSHPKl2Pw7YppUcOFJyBEb
 zC5dQMfLpQILfmZ5GmBFD88vDj7D7ctyFd6tI2ap92stak+xizX7ncZkQWKeoFr8AMAq
 WOa6G0b8CWBtFexTHO7Snt6CgrIyvbXM3MkpRy4sujP9/0dQSRjASaI4pgpMhkpE4o0k
 7STx4AG1Xz+nPr9w52m0Db8DrEfJ63d3tC8/3DtdXnccyAZD0IE5E7WY5dH4m6Qnl+be
 rNtQ==
X-Gm-Message-State: AOJu0YwezxkV/Hh2/AvVRaAVEmllTQZt3iumZ62BeiH7D0Ly+f42osOj
 Xm+M01RgEheaClsc57D7oopV4qrYS2/TvXM321MTc0b0Fe6h3J86K2d4mDw1UhT+8FTo1Fp/X8w
 si4T0W27MMr+TsuFqvZIwOEs5+am0w+nQou5deg==
X-Google-Smtp-Source: AGHT+IE0PnHAsWMSXWkCOJLNfbjTgAqD4l/U1sYvNQ608zQk4PhQrwmdAmwLd4vHzyvboFwWwkV0qH5Y1fLJTnQH9Jk=
X-Received: by 2002:a05:6902:1504:b0:e08:6787:54b8 with SMTP id
 3f1490d57ef6-e0b545bfbb0mr9900314276.46.1722319703261; Mon, 29 Jul 2024
 23:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
 <CALeDE9OztBrRDbj8ScFq6e+0XR_Xivxy1NQAOjrsqdqvzRTZTw@mail.gmail.com>
In-Reply-To: <CALeDE9OztBrRDbj8ScFq6e+0XR_Xivxy1NQAOjrsqdqvzRTZTw@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Tue, 30 Jul 2024 08:08:12 +0200
Message-ID: <CALNFmy3pOyH3y48bgOwisOhDXB+p_p8dn2r+ZQLP_srd=JqFRw@mail.gmail.com>
Subject: Re: [PATCH 00/17] Implement ACPI on aarch64
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, mbrugger@suse.com, trini@konsulko.com, 
 sjg@chromium.org, bmeng.cn@gmail.com
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

Hi Peter,

> Rather than just RPi4 support we should add generic qemu support, as
> opposed to emulated RPi4 in qemu support as qemu already supports ACPI
> on aarch64 for generic SystemReady support with pci/network etc that
> way the support is much easier to test in CI.
>
That sounds reasonable. I'll look into that as well.

> Also are the ACPI tables you use here compatible with the tianocore
> raspberry pi 4 support so users don't end up with weird differences
> between firmware?
>
The ACPI code is identical to the tianocore one. However the U-Boot
implementation
is a bare minimum to boot a Linux OS, thus yes there are differences
between those
firmwares. EDK2 has more quirks for various boards and reads in UEFI
variables to
enable/disable certain devices or features.
