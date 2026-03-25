Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FF5FEA80E
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 07:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4126F8352B;
	Wed, 25 Mar 2026 08:00:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KoD5YS/z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 101B4838BB; Wed, 25 Mar 2026 08:00:30 +0100 (CET)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04BD581E18
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 08:00:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64ca6595c8aso3953484d50.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 00:00:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774422026; cv=none;
 d=google.com; s=arc-20240605;
 b=eINzy9Z6CwKqHziJDI0puhTxS+ClFdfs+9YYp9Dw4xNrAzQjL5Wj9ThaXzZgS1cU2+
 nEBU3VbufaL4phtmDVq+RfCKGa5R2SGFbNL29YHdjyFDGM6V9RJRRopAxQcaPayCiD4i
 0cBnxCPNXc6zQjI1vtAgHDqvb7T2AjRRjrY+blOLg62jPWphntHdZaIPf8jQuPVFVQcl
 g4o2CvyRwZnn+eHhG98c87heagic2MN7dFXNovkmMRfL313etEvu3jdrOd/mvlUIUgr8
 9fyr81sWE+zjhsiq1hZowrqd4pcIxoge/eMXCH8kLEEECYYiygaUFTrGkt9a+xZlbwD0
 EaKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZSmPq3xm5T06Ep2sLwb7OcygoBrfMNyGqlf+PQyU4ug=;
 fh=RmTn4s4sqLcX8iJ4MxtUSIkPs4H9uRcitXg8KKSp8LE=;
 b=lBtT3M6lLQ/f5F7msByBNV7cmVOrp6kNIyMvgLzARr1L2Gon2Rd0fv2vu/EfTs3qw1
 bJ5rn8788X8NhwvwyZO/bSd+dldKagIlDz4hjtnkNz8rHIt8dJKpyoSZpq+bfT7cQWBx
 8bT1oWxi3BJuRRyRtBWf7ETUG5GdyE/ol+AxNqD1sTjLdpnBuAD7z4uI/L0+jrvvDCuV
 Fov6JFh3zV/C4eeN9EBO080EVutO7oNypxGWbz2sBgHB8KjFLYgfb17gCTYErXxE3Fky
 BUsqGAAGeSx+3lGHqIrhY737om3uifllrA4cmppJZpyv+LH0jFEUBZJ3oSdWicGBeccQ
 +YvQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774422026; x=1775026826; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZSmPq3xm5T06Ep2sLwb7OcygoBrfMNyGqlf+PQyU4ug=;
 b=KoD5YS/z4cxCzMLKowoM0jlsy3c67/klwfQDLaIXhrQ7cdo7uhRv8wj4EKQSh/+gxk
 +ME0/9yQZLxqKcEPZB02DkwikhEY7/G35K0rmegzMn649Zkf+P4RBOZu/yQkcPaP8Cot
 mxQ9HSuF6SwCF+hBgfNiJIT+x4RnVdO9uQZ9d5kI5JAJ2xpXONPzb3MA0OvUNkMUlwC6
 r3zWGLrE7IfURFnHm5GIixLadZ1k0tPD1+5Xu3ieKEKRA6h8k6KxSMp4YFKNTP+thOjY
 +JPycCj8pCUuQMjmSmJiww8g+Jj+4HysIl7Mvf826Wi9hix153NT/67w8MRehvk13Eac
 jXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774422026; x=1775026826;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZSmPq3xm5T06Ep2sLwb7OcygoBrfMNyGqlf+PQyU4ug=;
 b=GBtwn4C4av4B85c08pVyw7tw8p2HzA5Xn758jycqFHnG65Z6XffTFveEuOK4W1RkdB
 tN6HAwzhMmKBOQXXLEDjcVh9PoQDf8q7UmjxLsM34OnjvrVLkSqVlNeFhJJY8mxKF4yw
 CuLQGZBwRaopKbNLC6T4SoHgNMXhTW0OlPToRr58MzBYxQtONqdCZIyFvIpuY/uCuwcW
 vEWRRtbFblIMA3YyQmqsLnVQwUfbZ0vJliEyvLs0rFZh0uUDtLI1IkmkCMxU/iuhfmyW
 hnLyUnGk42XjuhrDm9Jikk4vSmEBTDOHA4FziJNeAuEmto6/6cfACkz4KPBuCHZSDJur
 fdcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFPb8u/Fw4D+84Z8rC7iFVb7J8cYO0D8ZiQ2UDu5g7Tm8kOs2FwjD8APZfZp/gsvPAM4SDtyk=@lists.denx.de
X-Gm-Message-State: AOJu0YxhRAVglNnCK1s7vTMv3FsKyKndH1I8rWz/AwvgkTHFhhUtDAlV
 eRG2OPZW9694wkTZGELyf4EjsW09T36gWdTXt5xLD00UTBYFf8MKMNgFBkFzv7uWLeM1toProiO
 eVS1Wbq797lwUxWgQLefEXyQUGnqH+w5z3nleSj5akg==
X-Gm-Gg: ATEYQzwFELJAl4TE8VEIJrTAXBnEtx8SV9+HIcfk5nCJrWz5YrIMkFxCSSwgomkjQME
 2i7tC/6Rw8hOGngA2HvGWc0xkMiOclJoQVupfDqfUtxovqfIqTE8lw9chHkKqlkvNQPiJo7Hyqj
 eAbpIJtYkmfeOdiSrnTbzOVkE8G5wvtZrf4nypS05sLGMA99c28Pi+STl4uyL3HDvSFGx+xqdHt
 ggsaTUkC13Yp7mi+RESlKw7CmYUfdFCwkWZXgBDkGw0ggLBhFpvjfzE7d16Q7NAIhNwGJhoxJQf
 DZz0hqV4rCOaRthAQwSQ25FiLY5QgNIBpHhoGtUmnnyCn2uahi4jGbRK/qkLqV0lVF9j+HZHUjm
 UFVW+X1sduILNtJWSDkWfODjDgd3+WMNIYBBgNRLlcP36IpZeagld93EKeTyxz0bYMimo8zfEiv
 CYRDmAhFn3ZyAvlO4Yf8yQxlkhLJ6MI3IdujbRgu2aJ/nA1ddeW6mgAvvBmEGndfzm5qXR7W5Io
 2wP669SI9Xa7Yg4rOW6yQeAUVMs3urEEXc6zSJ8rC/oaa3W1wZziz3+wh5NVsveMDfhodK4uWIY
 LQkwSFApj2L3G4x/Fvhn7pQs8yckjB3cQp2Yx47iZJ9T
X-Received: by 2002:a53:8241:0:b0:64c:aace:60c2 with SMTP id
 956f58d0204a3-64ee612f9dfmr1725991d50.38.1774422025287; Wed, 25 Mar 2026
 00:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260324175913.92858-1-aswinm@qti.qualcomm.com>
 <20260324175913.92858-3-aswinm@qti.qualcomm.com>
In-Reply-To: <20260324175913.92858-3-aswinm@qti.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 25 Mar 2026 08:59:49 +0200
X-Gm-Features: AaiRm53WAs6_kkFuqJyX7Cdx29IBI9Xp4S-vYQPEau-xsqygB1kfdiLaXRS-5hQ
Message-ID: <CAC_iWj+XvV+LE43CbvvjwgF3iyGAVgfW6dm_FRC2Ombs80g-4A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] qcom_defconfig: Disable EFI_HAVE_RUNTIME_RESET in
 qcom_defconfig
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, trini@konsulko.com, xypron.glpk@gmx.de, 
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com, sjg@chromium.org, 
 mkorpershoek@kernel.org, jan.kiszka@siemens.com, paul.liu@linaro.org, 
 j-humphreys@ti.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
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

On Tue, 24 Mar 2026 at 19:59, Aswin Murugan
<aswin.murugan@oss.qualcomm.com> wrote:
>
> From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>
> Qualcomm platforms rely on the kernel to manage specialized reboot modes
> such as EDL, bootloader entry, and other vendor-specific reset flows.
> Allowing U-Boot to override these via EFI runtime reset services leads to
> incorrect behavior when the kernel issues advanced reboot requests.
>
> Now that EFI_HAVE_RUNTIME_RESET is exposed as a user-configurable Kconfig
> option, disable it for qcom_defconfig so that the kernel retains full
> control over reboot handling on Qualcomm SoCs.
>
> This ensures that EFI runtime reboot callbacks are not registered on
> these platforms, preventing conflicts with kernel-managed PSCI reset
> paths.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


> ---
>  configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 314fc0c4903..8042855bae1 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -6,6 +6,7 @@ CONFIG_ARCH_SNAPDRAGON=y
>  CONFIG_NR_DRAM_BANKS=24
>  CONFIG_DEFAULT_DEVICE_TREE="qcom/sdm845-db845c"
>  CONFIG_SYS_LOAD_ADDR=0xA0000000
> +# CONFIG_EFI_HAVE_RUNTIME_RESET is not set
>  CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
>  CONFIG_EFI_CAPSULE_ON_DISK=y
>  CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> --
> 2.34.1
>
