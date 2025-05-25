Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7401C54ED0
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 18:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 018DA82B37;
	Sun, 25 May 2025 20:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C2Tn2hBk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1075482B48; Sun, 25 May 2025 20:09:25 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26FCD82B34
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 20:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6020ff8d35dso3025806a12.0
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 11:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748196562; x=1748801362; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nko9d41RDMdmfLp4oI0rTfy4X3Wg1G6kf+EwWjdMbcA=;
 b=C2Tn2hBkSR60PdB3SV0LdQ1RsmBb7lRw5stBHowg3TK32OGadh3hZ0+JtlVs2f1vyh
 BLahFEd5Aca+Txmfm5zA2/1edRNAUHFU3CdPr9Ilez8fQmZtIbC9FlKzN0affmudQuG4
 nK5R69kQDH7a11oNd1ND7PIYM7aymjaTdFVhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748196562; x=1748801362;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nko9d41RDMdmfLp4oI0rTfy4X3Wg1G6kf+EwWjdMbcA=;
 b=UMIKhXAyr5RbIhRBtaMNsLqOFSkVk5GkjWphDeFW6hevyT4saDwZeGzZPPSod6VgIC
 VY6LaDMtvffgxDdPfbsLXW1WRCBNUYkWfxEQXAbbgTT9mSBucOydAJSYdWPuQU09ykAU
 XQFBdgT12g6WXFjK+yvCU5oDc1Bfgz4r7tBedfO7YqRoz5UuakaEWmWQwAkVgFRZqjc2
 FrSmRTSMogYd/pmkdg6XDjd2ieJfTjQmo4KaHiGjNmEpDqZ1tY/NDRJMq0heoL7Awz5d
 usfx2ffJSDRbQsLZJxIwiTzk015MRDjYw4ergmkBjNPS491rJLN5u5Ndh6B54RnH+QKr
 oRzA==
X-Gm-Message-State: AOJu0YwLVK9CS4a850Qkau8JLY7/KiKU2v4LGK+cOkLn+ExZWFmhhkqM
 yKdD8INYjZbgrslhl3atAds3idB2DfPWOLEM7GoS1ZJLaPCaSaQ28YG8z90A4983vblIYa+8iSh
 SByi+oqjpesR24wuEbngN6WHmOQoZ4H8fG97asHch
X-Gm-Gg: ASbGncuacL67vJBCdmHWp5U9/Qh3wyLynd2b6TH9lSBuQwDL+ThATuT/LTX143qJ8/C
 m3mSZ2KHb4z933MqTa7h8JLbUhYF+iKk4GOv0uHdQibxqx06Rd8Nl8xljpUDshchuRaN8BNKqeB
 BfDnh20uYm4QnSto41j4ywj/mZOi9tT8M=
X-Google-Smtp-Source: AGHT+IH2EcWe92bAkwT4Y4koylf6S8s/gjnPUFEBx2aLw6b8Clq8Seebs6HRkDAwfAN18T2VMpX20PmbVtVOsA1GKQY=
X-Received: by 2002:a05:6402:13cc:b0:603:51cd:f1cf with SMTP id
 4fb4d7f45d1cf-60351cdf8d5mr4125425a12.7.1748196562619; Sun, 25 May 2025
 11:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAC_iWjJirOoP49HAzMSmnK0B5fZji9+-GAg7Vku3DWOZ6DQOhw@mail.gmail.com>
In-Reply-To: <CAC_iWjJirOoP49HAzMSmnK0B5fZji9+-GAg7Vku3DWOZ6DQOhw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 25 May 2025 19:09:11 +0100
X-Gm-Features: AX0GCFuscXa5i2AsDpdOZMnoeksZ2B8bCSbruYbbDDyXch_eKRO3NPNqJ-kscF8
Message-ID: <CAFLszTgC4Z2EUNgy8Ya6joUk3HV6+d2qoiqEq6taf9Wvuhdy2Q@mail.gmail.com>
Subject: Re: QEMU & KVM broken for arm64
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andre Przywara <andre.przywara@arm.com>, 
 Mark Kettenis <kettenis@openbsd.org>
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

HI Ilias,

On Wed, 21 May 2025 at 10:08, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi all,
>
> Starting from commit 53d5a221632e  ("emulation: Use bloblist to hold
> tables") I can't boot U-Boot with QEMU (version 8.2.2) & KVM anymore.
> The command line to reproduce it is:
> qemu-system-aarch64 -smp 2 -nographic -cpu host -m 4096 -accel kvm
> -bios u-boot.bin -machine virt,secure=off
>
> commit 24768a23a9b3 ("emulation: fdt: Relax condition for
> OF_HAS_PRIOR_STAGE") boots fine.
>
> Simon do you have an arm64 host to reproduce this?

Yes I can use the runner to try it out.

Regards,
Simon
