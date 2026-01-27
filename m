Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCAFD2595A
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 07:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B2B283F9D;
	Tue, 27 Jan 2026 08:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wl1aw2vB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2A4D83FB5; Tue, 27 Jan 2026 08:59:13 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 494CF83F53
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 08:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-79430ef54c3so49604307b3.2
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 23:59:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769500749; cv=none;
 d=google.com; s=arc-20240605;
 b=F5gY5oaGZHoG1Z+07ian14PQH/FIXF6vO6M9o9DgfCzrnb5exppb+58JYkMVq/Y5+t
 Hev5Zu1smhsDz/Qia78rIJlEilqJjVQIMmzuPq+uFCWK7KmKeAHcKOu1APvEjEIUug1v
 UkgrlBi4jvmmpZONhdnonwtRxv2AaNy0L+cgZVRg4e9kXeiztRJSCdLtXHNoMChrj+w9
 cq4+De6VtHxP/0I/y15YxMxUHSgFEGR4xRVa+as9uvQDRKXEWe0jsaI/5dn+WBCVU2yt
 P8B3vAKJkAhEDG4jOSJ58ucs3hinkLKb9F+dSzGb8VMNSsirGDgjmhMWBiSn75nobNJ4
 koUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WzPR9Ga8k2Al6bQ9FwoIZfYtPkiIzWUiqdF1BLZq/E8=;
 fh=omMQb5rW44y7vyeSKMXjAMl+ucsSYPjf1R95uleYbSo=;
 b=RuuqXYCMlFYbmriHe8Hv/MHfKSnWxzo3Og4jjC7pqWl/G/xNe36spWB05lcTFnoOmD
 VGfOzIdg7fORcbzp2AV+1wZnyZiEdKE0kwnKWEHM9pVB+GaYRQsKoiojgizKyYrwlO0S
 wLkJ6FBvbHTv/8Q/7ulUiBJFzB8NcnxQI8VClmkwUYJVn+aNuN13UMjzKBx/knoCzvNz
 eMunwLX+hzqd2m80VQ/r9hCLfKNpD/h/uPnyiN/RzP5iaxuZbNu/BcdWIa8eTeQe4Wg6
 wKxZHetXqgW/9oW0Om7Wt3RQeRVrrq7WX86YyfiLbmDF7HOr0uz6XCU0B0BE9BgZAyUt
 /sBw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769500749; x=1770105549; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WzPR9Ga8k2Al6bQ9FwoIZfYtPkiIzWUiqdF1BLZq/E8=;
 b=Wl1aw2vBBwKOfr3SI4FhhNPRhC9iTJ1ZMu5X8sbahMTeqEtEDjprBLN0pmcjbG6QHL
 qp0iUXu7gbvEFuA9m1ENdcB+JWH92+mEtfmHMBDJB/jgpPmP9T4SbmQC+Hq41i3zz3hV
 xGwVkYMqpJ8uFjKl1mq7eZdOCJxNMaPmU6MqnTCqcc8GFQauXunPN2yIPyvUFq6MAd/j
 nqOG6sqb3IsE743dS6XCGP46lgOd0e4ZiDPoiD15+AfycgABxJfuOpl+Rtn7kTR7GMA7
 cbUX25gblRu2jWpzm09cwTY+4i2CeLou5doGSezZSh7BnPeZObFwtbOO7v6JLzTSz5Uv
 h7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769500749; x=1770105549;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WzPR9Ga8k2Al6bQ9FwoIZfYtPkiIzWUiqdF1BLZq/E8=;
 b=Y60n+jmWqal9shUWwcznxSEQgbZZ1BdsxOHXp4BblJFTyXP0uU/M2cZgWZT4PVwztx
 1mnkLWkidOx1y7k8jy+s99p5alub3ewCbsiv5DajpQhRTQrzvf+ZkK4bH9B5g3gTR1gb
 Hpx67wp/SBn4YNSG2n7afJObiDrnvAWKex/Qb03htcc7NEcA9vWzCmHuxqtUiRkgP51f
 gclFSZiX2au23UrJSfXnPDq2DJr0qpguaff2/Az3it+bit5Judv8D98N16auiPJKqPme
 N/kbfSslQt/afGoKgHUV03ESiZccEnyHbre2rPffuivuv/zNpJQhGDkg3fvLBu8REctb
 sVaw==
X-Gm-Message-State: AOJu0YyOToETTPIxJuHdx94Z25qs7aNTzx85ZfNQN/az/XsEP0BPX33I
 eYr+bqWrrL4jvyGKat66Kv7njs3rZKZVQHaHPRP9UOaKA6J0nL/Pjzvhk2xKMXahZnceQSYJQQP
 OjB/AoqFgnR+o+6Gzd1k3q27cEtHmyvDX/2rSMFbp2w==
X-Gm-Gg: AZuq6aLQGpAlzkVfdIUwW0cS2Xu36EdyWWFC6vPJBuRkJD9mG1q83IR9FcXM0Xq9vbi
 RodrxDWaz6822jzPjkr33vk0/rVlMHac1Zt6Vi0I/2kfVdPo1uaMFwAzanpSt2mWKsXAuWkN2ue
 Q80fKQCV/AdTooBAhDEWg1zjdN4pIVBQzKL2LQncehFvjHMHGck0qXgpDHIyCdXUlJdnmLxkSA7
 EKgHewhOOGvqY8IiD/wNxLu2xEX8jNHgy0Nq3b24DYzWoLDwR1KIs/JbFB12QAodlnkDhPNAvKa
 ckMPKXQJ079ZWTG+QDl7bDA/2zCMqkSm0r4olJ01RCU6pJSLcaVUtkiRN0hT6c2XFKU36kJRa48
 3/D85LtP5uSNiXh9KifcZFuA0a0AK8o232LjVbTNpX4+hVk9f44v5vkKgCcNExfKypP09MYcS2F
 2Colp8MsLLcRIKBhbz4OwDKl6p3iBfYC9mcBU586p4kNG/qiXG3UwvdmH90KzBIvE43CzgOkwc0
 N884BXzCJ3hZlZ60p3e9vv03qBhIlGrLRdRhDXQZfARVHrJFxZ4axILzHl9G9j7nw+q4gD8U1do
 JYD25G+0i4CYPfNyvTDZxULj+0r9ejr7
X-Received: by 2002:a05:690c:368f:b0:794:3cb7:80fe with SMTP id
 00721157ae682-7947ab298bdmr5117147b3.20.1769500749045; Mon, 26 Jan 2026
 23:59:09 -0800 (PST)
MIME-Version: 1.0
References: <20260123105814.1083834-1-vincent.stehle@arm.com>
In-Reply-To: <20260123105814.1083834-1-vincent.stehle@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 27 Jan 2026 09:58:33 +0200
X-Gm-Features: AZwV_QiNlLbCPe9dEBM34hlsVKiNLaUjvzpjbPxL9ASubPxQ515d32TwrNtI1mA
Message-ID: <CAC_iWj+QPW+7-aJ7XMmzxoHwJ47kM51sZfWjp4T2cT+v7L0wDw@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: fix use after free in efi_exit() with tcg2
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <masahisa.kojima@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Vincent,

On Fri, 23 Jan 2026 at 14:58, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> =
wrote:
>
> The efi_exit() function frees the loaded image memory by calling
> efi_delete_image(). However, when CONFIG_EFI_TCG2_PROTOCOL is enabled, th=
e
> image_obj->image_type structure member is accessed after the memory has
> been freed.
>
> Fix this by keeping a copy of image_type, as is already done for exit_jmp=
.
>
> Fixes: 8fc4e0b4273a ("efi_loader: add boot variable measurement")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>
> Hi,
>
> This can be verified with sandbox_defconfig + CONFIG_VALGRIND=3Dy and the
> following command:
>
>   valgrind --suppressions=3Dscripts/u-boot.supp \
>     ./u-boot -T -c "setenv efi_selftest start image return; \
>                     bootefi selftest"
>
> Best regards,
> Vincent.
>
>  lib/efi_loader/efi_boottime.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.=
c
> index ddc935d2240..0b3f2fd276c 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -3453,6 +3453,7 @@ static efi_status_t EFIAPI efi_exit(efi_handle_t im=
age_handle,
>         struct efi_loaded_image_obj *image_obj =3D
>                 (struct efi_loaded_image_obj *)image_handle;
>         jmp_buf *exit_jmp;
> +       u16 image_type;
>
>         EFI_ENTRY("%p, %ld, %zu, %p", image_handle, exit_status,
>                   exit_data_size, exit_data);
> @@ -3496,13 +3497,14 @@ static efi_status_t EFIAPI efi_exit(efi_handle_t =
image_handle,
>         }
>         /* efi_delete_image() frees image_obj. Copy before the call. */
>         exit_jmp =3D image_obj->exit_jmp;
> +       image_type =3D image_obj->image_type;
>         *image_obj->exit_status =3D exit_status;
> -       if (image_obj->image_type =3D=3D IMAGE_SUBSYSTEM_EFI_APPLICATION =
||
> +       if (image_type =3D=3D IMAGE_SUBSYSTEM_EFI_APPLICATION ||
>             exit_status !=3D EFI_SUCCESS)
>                 efi_delete_image(image_obj, loaded_image_protocol);
>
>         if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
> -               if (image_obj->image_type =3D=3D IMAGE_SUBSYSTEM_EFI_APPL=
ICATION) {
> +               if (image_type =3D=3D IMAGE_SUBSYSTEM_EFI_APPLICATION) {

This looks ok, but I don't remember the TCG spec on top of my head.
Can't we just move the measurement before deleting the handle?

Thanks
/Ilias
>                         ret =3D efi_tcg2_measure_efi_app_exit();
>                         if (ret !=3D EFI_SUCCESS)
>                                 log_debug("tcg2 measurement fails (0x%lx)=
\n",
> --
> 2.51.0
>
