Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93647C2FC29
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 13:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3F5686B6F;
	Thu, 17 Aug 2023 15:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dd7GfXIx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2AA286B65; Thu, 17 Aug 2023 15:42:02 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3711A86B5F
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 15:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-52713d2c606so943606a12.2
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 06:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692279720; x=1692884520;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HQWk9+Os5crdHBVd9Bd7xi+Rt03wsEe+2bRwhV5Xn3o=;
 b=Dd7GfXIxhFFyzhciSEbthXe4ZNI+e65Bk5HJ7YuobqJN5DqzB/95WK7MwvDL7L1T24
 EyHDqZL3zG/YvaOHrAudndj7616MB2+CF8p8HdrV6VYyiIkb/ymSWd3ZxId/Vxzv2rhA
 MdhoLWHzIwjlMPhswiJe4dbcdvKa4eMs58U7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692279720; x=1692884520;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HQWk9+Os5crdHBVd9Bd7xi+Rt03wsEe+2bRwhV5Xn3o=;
 b=NdG3DbMbQKyy0pMHn4dL9gapj3zY9Z0GM/Sq6HaocV8GdNJLyEx/6cPCTgWaJ7RVNg
 mv7+FT+FKtgTTZgYqJbwGwPQyftjojoIfNJUJaWm7rWE7CR84SMClQ3WhYnJq8aT5o29
 i9FwFoMLK0QMVpztsvL+SMU6Zvf1wW9fQYnZQi9qeEAh3756UjLKVllRvFm/fCzBDnAr
 zyoyEFjelddhvLCxitLcFqxHCHDRxO38kgTg/GN7s5hZfT48QDNninewmzkwnwdVl5a7
 17Pu+0I6W4X0KgsdvXXu9WB0e9w6LlaL0CmjVPNBHdmrA0/d/c7NU3c9BTYF6QxD80PM
 Gapg==
X-Gm-Message-State: AOJu0YyLr2DWd4C2CrpPLkXMJ3TB9psVJxGdAZ4o1spr6I9BSykvqtoO
 LZJgznCMrfKdeED0xhcYVDDJwo9fktB7duWjKenXIzdI2iLwrkPrmQc=
X-Google-Smtp-Source: AGHT+IGAdWfqSqp2qXEgWNqPXWE0D36zqch6IB4dsD6uWmMYh2zhjtiB7XQ1z6WyL4o7PK1nYCDS7RWMxO28tfovOi8=
X-Received: by 2002:aa7:c38d:0:b0:523:bfec:4913 with SMTP id
 k13-20020aa7c38d000000b00523bfec4913mr4329490edq.0.1692279719592; Thu, 17 Aug
 2023 06:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230812002823.82576-1-seanedmond@linux.microsoft.com>
In-Reply-To: <20230812002823.82576-1-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Aug 2023 07:41:39 -0600
Message-ID: <CAPnjgZ1V8prO_iJaf-O+bKrQET=ki-m5cV72faPz5w=pfA7HXQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add anti-rollback validation feature
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, stcarlso@linux.microsoft.com, 
 ilias.apalodimas@linaro.org, abdellatif.elkhlifi@arm.com
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

Hi Sean,

On Fri, 11 Aug 2023 at 18:28, <seanedmond@linux.microsoft.com> wrote:
>
> From: Sean Edmond <seanedmond@microsoft.com>
>
> Adds Add anti-rollback version protection. Images with an anti-rollback counter
> value "arbvn" declared in the FDT will be compared against the current device
> anti-rollback counter value, and older images will not pass signature
> validation. If the image is newer, the device anti-rollback counter value will
> be updated.
>
> The "arbvn" value is stored/retrieved using the newly added security driver.
> A "TPM backed" and "sandbox backed" security driver have been provided as examples.
>
> Adds new configs:
> - CONFIG_DM_SECURITY : enable security device support
> - CONFIG_SECURITY_SANDBOX : enables "sandbox_security" driver
> - CONFIG_SECURITY_TPM : Enables "tpm_security" driver
> - CONFIG_ARBP : enable enforcement of OS anti-rollback counter during image loading
> - CONFIG_FIT_ARBVP_GRACE : adds a one unit grace period to OS anti-rollback protection
>
> Sean Edmond (1):
>   dm: test: Add a test for security driver
>
> Stephen Carlson (4):
>   drivers: security: Add security devices to driver model
>   drivers: security: Add TPM2 implementation of security devices
>   common: Add OS anti-rollback validation using security devices
>   common: Add OS anti-rollback grace period
>
>  MAINTAINERS                         |   9 ++
>  arch/sandbox/dts/test.dts           |   8 ++
>  boot/Kconfig                        |  19 +++
>  boot/image-fit-sig.c                |  94 +++++++++++++++
>  boot/image-fit.c                    |  23 ++++
>  configs/sandbox_defconfig           |   3 +
>  drivers/Kconfig                     |   2 +
>  drivers/Makefile                    |   1 +
>  drivers/security/Kconfig            |  25 ++++
>  drivers/security/Makefile           |   7 ++
>  drivers/security/sandbox_security.c |  65 +++++++++++
>  drivers/security/security-tpm.c     | 173 ++++++++++++++++++++++++++++
>  drivers/security/security-uclass.c  |  30 +++++
>  include/dm-security.h               |  44 +++++++
>  include/dm/uclass-id.h              |   1 +
>  include/image.h                     |   4 +
>  include/tpm-v2.h                    |   1 +
>  test/dm/Makefile                    |   1 +
>  test/dm/security.c                  |  78 +++++++++++++
>  19 files changed, 588 insertions(+)
>  create mode 100644 drivers/security/Kconfig
>  create mode 100644 drivers/security/Makefile
>  create mode 100644 drivers/security/sandbox_security.c
>  create mode 100644 drivers/security/security-tpm.c
>  create mode 100644 drivers/security/security-uclass.c
>  create mode 100644 include/dm-security.h
>  create mode 100644 test/dm/security.c

Can you please add something to doc/ about this?

Regards,
Simon
