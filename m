Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36495EE57F6
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:05:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AD8C88E83;
	Thu, 12 Sep 2024 03:02:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UjqcSM9j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C77C88E7D; Thu, 12 Sep 2024 03:02:18 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4319D88E86
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-718e11e4186so336805b3a.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102934; x=1726707734; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=djYLsEzjIOIjKkcu1FxvTF2ryQ4KVzB7kMzZfgv3Ekw=;
 b=UjqcSM9jRsKGYR9vwzD9wMIN3ya0/o1V29VGnBgpAGvEn2rqBVRaaN75EzZ12TI/6S
 wY1ipIker51tOzOPfLlYd+ATcgSUyve2c2O9lLixRHoo7NT7nvs+7BMim18w2KZdHj48
 CKeXX24K2nrEhmxBfHQkwvoo7i7EOL6U4G2xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102934; x=1726707734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=djYLsEzjIOIjKkcu1FxvTF2ryQ4KVzB7kMzZfgv3Ekw=;
 b=mOPmI3piQVII6nrvbnWAYGXyinoXXS46+WKaPgoWYRDhOduaHZCUIi6vqD7ZxlokkB
 +0EJbegII0rYdmykIdvpSzULBJVqALgx8FPE64/cJU2mHFD5Mh7cmZIX3J59212CwrlA
 RUtLQ8ZKf4mCWHnAPI1dFbSqCGJg0zV+6NnLCcn+xfcd4d2nVl4eO12nN0CsmFlplTom
 yQHUFS3mMfmYJWiUWJxbvEK75EvEmBbj0L+3m4WDSkJdWx5crYxMAXiiIN6E6YQJAboG
 Mhncx6q/0tRbLesszZT4dtQcmuq0IKHB0I56Kl/ZeJmG4kjyYDns+HZoLuyfDApSVHeX
 c6DQ==
X-Gm-Message-State: AOJu0Yw5p8ieJJn15DALIPCWmUSDXrFBrX9MHybcf36qn4+JSsfnrutv
 wEsCiLQswZBgnV6hfFeP/bzZPpdYmf6QdvgtlwW0Va9WsiHI26GKS0e3ymmBlqdh3My4bxG2ohN
 0tOh9huN/YJAZCqgIW3KO8mk7el6TX3l/U1OU
X-Google-Smtp-Source: AGHT+IHKkoPiqAZFiZFkrePVaNpNYhJU1D/r4WxGgR0MlRXa/+llCgo67tEBNRapD4MSulqp/uc2ZZKFOBqou3xWxj8=
X-Received: by 2002:a05:6a00:1a8b:b0:718:d942:3475 with SMTP id
 d2e1a72fcca58-7192607f8aemr1922016b3a.7.1726102934327; Wed, 11 Sep 2024
 18:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-31-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-31-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 19:01:59 -0600
Message-ID: <CAFLszTjPvK+2RMDro59DcyzZ-EzAK1vbQo3S_rUD8PHPD5wy5w@mail.gmail.com>
Subject: Re: [PATCH v3 30/30] configs: Add RPI4 ACPI defconfig
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
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

On Wed, 11 Sept 2024 at 00:26, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Allows to build the RPi4 with ACPI enabled.
>
> TEST: - Boots on qemu-system-aarch64 -machine raspi4b
>       - Boots on real hardware with arm_64bit=1 in config.txt
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> ---
>  configs/rpi_4_acpi_defconfig | 72 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 configs/rpi_4_acpi_defconfig

Reviewed-by: Simon Glass <sjg@chromium.org>
