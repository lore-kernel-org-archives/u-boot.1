Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD9CC54E76
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 00:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7F46804CE;
	Fri, 17 Nov 2023 01:48:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U/49wVR7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E6D980090; Fri, 17 Nov 2023 01:48:11 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20907874C3
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 01:48:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53db360294fso2165521a12.3
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 16:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700182085; x=1700786885; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CvvIyuIYx4fDDVgMJzVFXOV4czax8kjYt1/7IGd4Cg4=;
 b=U/49wVR7Jo7ktCMEbaKRWN4LYktNBma4RpD6Jy6CMiRKU70sIq0DWpQXMVEvY7kUL7
 O9qybBKW9+c6CG7xbXG5F3iaIPOutP/xG3OD3acOsVZrZzu97QvbwCeqX7PV2Yu44EcH
 kINDehf2YlLUvj8lqzroT8AZXov2RmvTkaer1wt3G7gvnA3a4e5zfnQvPXdwuQAw3Em/
 i+Ev9vCrrf2bYqUcVYTJICwfmhWX86vDVAQqmiVQrAzMSQuxJEFDcCP6DmpxcPbxLCbI
 Y2k5CY7s1odgxu8yVAxI26kJCCrQWX+1jkxcV25jKR7f3Mh45x3kQKpnA3wxPsbORPRx
 T4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700182085; x=1700786885;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CvvIyuIYx4fDDVgMJzVFXOV4czax8kjYt1/7IGd4Cg4=;
 b=ffkGdKClNKRG6aOVQQFpk58EGizN/qloUkPd0N7KfiCJA2tsEwDGzEU0yb8vePwxqJ
 tFBdu1Kuf7MAqos+7yoUrQYgkz4Nhr2Z2M3lM9wwJWQjLn1OJJ7uv7AtcjFM9QR7f5ks
 EtJYooen7VWGBTcZY7Vfer5/LTO4HVyzzABX5q+P800jWowgsE27nnR3lSNM/12zk92P
 dvab289zflkdrPOAH4AYcXQnmudTqclVfM5poE1IK9XTsmrqZZreBlOU8kWcmhm16WyK
 VBSrL9rBNzNCoIeJZThAdeAtcJIrwojUeL20F6YgWOjTnQAY3aSWiypscz4lu07dTiRX
 89yg==
X-Gm-Message-State: AOJu0YzYPjMTsEEMvu0FfbAv/oBYtlKAZol4r5ewY1CYkHUOElX8uGXA
 54RinRJeikWqMV+po8eI8aGANMkAbZXB7pq1iA54nAwEz/uhrKv2hqc=
X-Google-Smtp-Source: AGHT+IGiaNdbS0Y6BHOYx22/tevfgUwdkHbOyz0MooYVfWyqwhEM1z+mJbsVI+Ysqk1pK6PXfMu55REfaxvN/bI/RjI=
X-Received: by 2002:a05:6402:2752:b0:540:164c:2be1 with SMTP id
 z18-20020a056402275200b00540164c2be1mr17649878edd.0.1700182085672; Thu, 16
 Nov 2023 16:48:05 -0800 (PST)
MIME-Version: 1.0
References: <20231116230806.20506-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231116230806.20506-1-heinrich.schuchardt@canonical.com>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Fri, 17 Nov 2023 09:47:54 +0900
Message-ID: <CADQ0-X8f1zYce7vULLUcHMamHrF03vHGu075A6zssqZgf=F0YQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] cmd: eficonfig: create shortened boot options
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Fri, 17 Nov 2023 at 08:08, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The boot options created by eficonfig should use shortened device-paths to
> avoid problems if drives are enumerated in a different sequence.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/eficonfig.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Masahisa Kojima <masahisa.kojima@linaro.org>

Thanks,
Masahisa Kojima

>
> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> index e6e8a0a488..3d95092109 100644
> --- a/cmd/eficonfig.c
> +++ b/cmd/eficonfig.c
> @@ -528,6 +528,7 @@ struct efi_device_path *eficonfig_create_device_path(struct efi_device_path *dp_
>         p += fp_size;
>         *((struct efi_device_path *)p) = END;
>
> +       dp_volume = efi_dp_shorten(dp_volume);
>         dp = efi_dp_append(dp_volume, (struct efi_device_path *)buf);
>         free(buf);
>
> --
> 2.40.1
>
