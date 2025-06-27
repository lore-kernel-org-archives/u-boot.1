Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF66C77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 12:07:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB5A482E27;
	Fri, 27 Jun 2025 14:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TioCuJtM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7217082E9A; Fri, 27 Jun 2025 14:07:08 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0BC382B6B
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 14:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-60780d74c8cso3262739a12.2
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 05:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751026018; x=1751630818; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/tcMtoN7qEIXjIkGcwS4gCTrcXaEximmtgqvc8wjn1g=;
 b=TioCuJtM5sf5ao2aPeItRFZ0M51SC596RjU123rT0ytM+km0KwF0Y8WwXJdq68ncZi
 Pt0FM/U0zsz6aWU7d4O6JZYC6JZHfnTVW1DuTjPKunPsswBh5BXHd86miVz7TeTqnKyX
 oOIFPZ06y++FRkRkFpLBM7drwZniYaknM+H7N/gmMortWZWAlETZRku0UOqPGyrUBpWb
 OFHZEKwPaz0aYMmqLEfPylUY15Vm3D+aeECmzSfmGAIL2JPNGqTxD/iWDEHQPomlSqLv
 dE6G26FG3QLEJYe6GO10aMeQLN8Z2bNwSXYhlps65N++9bA53Wl9yla27h1gJxZU+xMF
 J+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751026018; x=1751630818;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/tcMtoN7qEIXjIkGcwS4gCTrcXaEximmtgqvc8wjn1g=;
 b=KhvlAHQ9tnby6GkVqTOWNjgvvJsnBHVLuEzykc1wvimNAPdF3CV2I9lyXdZYYBhci6
 2YK7SzfOiqVHZXDUUsm8+FMr1coLxCAT+Lh06cXVrURC18zwO6/d8PvEGC35Ow/RlZKm
 Q1sqLEDzR/40WoQRNAJ6AYsRhEMzxcmB1rCnNVzrDeb3LgK9047o3JhiegZJDbzju7mu
 DlpDUVRPurBgMP7OYD5/RYmf4IR+xs1S8skO6eIgiGn1xa6Je3Fl6XN6iIGWU7zGDaZv
 Bnd8GGH8dTvwMEPBCxNqCUBxj9QYXqDePV+T3XCg3lGpReJV8YOwGrJy+VF9tF0Ybwf3
 /LUw==
X-Gm-Message-State: AOJu0Yyyy9R0UnuP5kVzTLVZ22WzL8e4/o5OzXSEVVEBYqlvuSeLC08B
 CiKF0oH/Xl7FskwsHybcixARiA3SNVlWtw5vr0TJz43ppqYS1dd8doyKfBpWazmnhNsKA7WGJA4
 CnAzXnx+IpBXXC/pK0mF4+fcn1JtQJtk=
X-Gm-Gg: ASbGncth+UsTeytA3OG7EPSSPMz6JYY4fnHnQMoxbCfA/Tlp1JSmIlgl3YqJj9c08zf
 o2Gopl1l/4MLG1xdI9/yxNH/iKgFnAFTRQA5e2/AYGHXVdOmuRQZPIKJp+qOPtK1TsGwre8Kw43
 MjoDsgTr5626ZmEd7/agP0GdiCXNIfZCnQqJcfon9VnZCbC2GD2MaROjJCLNvk9mZ/s/HMWDLbv
 G9T
X-Google-Smtp-Source: AGHT+IGqZU4xS3UJbLItTySq8s4qKFpm9TFPBbGLEXp0JNb5EMqIuwtbr2HMEe5L13bSuOQULa+kvCwHVBzzvai85DA=
X-Received: by 2002:a17:907:7b89:b0:aca:95e7:9977 with SMTP id
 a640c23a62f3a-ae3500b8f3fmr273400366b.28.1751026017840; Fri, 27 Jun 2025
 05:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250627112509.264221-1-sughosh.ganu@linaro.org>
In-Reply-To: <20250627112509.264221-1-sughosh.ganu@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 27 Jun 2025 13:06:46 +0100
X-Gm-Features: Ac12FXzdL68T__RcA-5NyP23uWMYkiOqfVhYetkiA8wL2AOyMgorCSKmYwABcHw
Message-ID: <CALeDE9MixLWWM+YRpERY1NqNpFVW9JyVT=um7_PaLVa7YY7dHg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] eficonfig: add support for URI based boot option
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

Hey Sughosh,

> Add support for adding URI based boot option through the eficonfig
> command. Also add a basic test case for checking validity of the URI's
> being passed to the wget function.

I suspect more an extension to this feature, have we looked at getting
the URI boot options via dhcp?

I'm not sure what options the LWIP dhcp stack support but it would be
a useful automatic deployment option

> Changes since V2:
> * Added comments for eficonfig_create_uri_device_path() - patch 1
> * Added comments for fill_dp_uri() - patch 1
> * Remove some superfluous newlines added - patch 1
>
>
> Sughosh Ganu (2):
>   cmd: eficonfig: add support for URI device path based boot options
>   test: wget: add a test case for validating URI
>
>  cmd/eficonfig.c      | 131 ++++++++++++++++++++++++++++++++++++++++---
>  include/efi_config.h |   4 ++
>  test/cmd/wget.c      |  20 +++++++
>  3 files changed, 147 insertions(+), 8 deletions(-)
>
> --
> 2.34.1
>
>
