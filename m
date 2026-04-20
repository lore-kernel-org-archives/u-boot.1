Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99C7F99C86
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 06:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01E2B840D8;
	Mon, 20 Apr 2026 08:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A8aM3jgn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46200840D8; Mon, 20 Apr 2026 08:01:33 +0200 (CEST)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9372183B99
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 08:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-651c5d525f6so2312702d50.3
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 23:01:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776664888; cv=none;
 d=google.com; s=arc-20240605;
 b=NNjL7d69mve/YVAPs5THI2E4dBIb0v5U237f6pMsc8g77XlEacYZlxgDDolcWSs1AK
 dk11LidVke9xNduKpgc0xOcMj2tUtlt+LapJUdy7C40tmUgYKOaCiD8iBluddfW9gckq
 PRsMC3c1e1JRrp44tssFQLQcA8QMy5jT94htfyCoiqrnebNl19X56i79XzjUH4BT+DAM
 VsRqsQuOl9YGhUGEwWuheOWka+UXDsGL9vkSc4GEWAIdq3BqmhrtEpHhPjEYhc+ELcLT
 EM6pnu8WkbPHYjPSsdoCWtWTLnkISdjP59259umTGrnjxOhR9k7kvPyid2hFvSxUmsPS
 3w1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Yjh3k4kz0vZB6GdZdE+MEdiW7SveUF/86EhuCLTqmzg=;
 fh=Jr2IUJfenNIzBR7WHABSUI04S/zkmmz2UU6+UrwUYUk=;
 b=gJ8bMrXAZX8ASoPsCRioQVvBmQcQGmrKWo594NSPxbMgBa9EfpuuvjpVOGpUNt6+Th
 Nrm0/eFuVAEwukq8wrg/Lff8K6zRRvY0pLTLwbGzHE2M/zUZZ/wEUIOq4q0fxv064/oh
 95fjxZJ5sqr32xt85rplxdf46NcKKs6FV+Pc9Ku1EuPdPZkyb4jtmmMczniklHRKwNFw
 b3phY0UYKQuxFFF6WmLvHQ0ujTbzUi4BwspMcUo7CXkUTBV1YmJkFsaJOwn++7+Ef9x0
 7lqsMVrHTmiDUIhs6l3B1a+WPhzRCmOrsYYZobj7scYnd3NLU7OUAmVMxzCa2+yo8ma5
 sw2g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776664888; x=1777269688; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yjh3k4kz0vZB6GdZdE+MEdiW7SveUF/86EhuCLTqmzg=;
 b=A8aM3jgnwT2tYvifgoNOAaJdyOJc3Sglv21o3E72Czjz6IlhZJsAcGTwYPZkOV1mRC
 Lp9OGOpTUT3SMaEDAIcPZLsjBf/KOPiLRtmOObGS6a4kJ9Ku8J9t1Zmobo3tntobTpSN
 SJ77HwXvVBK0DU/vff2SPySjP4SWt607HljTo1UYyTga4TKFv3qmHarsRW9lSZW1rbmP
 BRzmGoH2bOdwhLSWzJzxHSQ7VzyoSYpCCHb9HcTCmBTt7oqWfAOvMq43yqualPgs+MaA
 YRyRkYKCfmU04Phw/xIF6nUluh2zgH8v4jUCLbNwxgLO5IAuGKmwAbbSw9FDmpB5lDl/
 XRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776664888; x=1777269688;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yjh3k4kz0vZB6GdZdE+MEdiW7SveUF/86EhuCLTqmzg=;
 b=Pu8MDAk2hsHtKU2CFae4+D7EdZ2s9dNlmhKIG3QkiqAIeepoz0usw4LrT5pKjE26Ef
 jp68sJ80flOVwYybKQGB5hqzoB172Si2o1eaaQAs2Iwc+gt4SJLunCJQCY/iGHgmWSaB
 MSHgKJO3CBnPSeqkRV224ZVobE0vOj7UqliEyriuva5ii4MtjnwFkHrrW6lk4xZX6SE3
 IBw/RjxgsxfhsS0cdAizrkk1K/O+BmfJ+hfoszu9EQ3b5exwRq/6qzDMnuDUwfLgL9yz
 em19b620fJy0Y3HUaPQs89hqJ0u7c8dROmgByLQMp4FyKgAcY0ZPSzyT5VD24bcEGKne
 oAFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+tiKNXKBM9roq63WmNtYHUrLd0k/S7bNYQzzDFC+vmCd+fSJelqPO9503vd+XMTsY/C7Eokug=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1UYYtDbxdBI0EN4aZlzSUkcwDAyvapR102YSMoDagJe1SabEo
 6RVIvNjMyl7uRQ5X5UI53jcAgWRpRdWurhXpOxstMQe29I8aAhMi5eiQKZ9DANCrgxBa+V6rfzM
 LFjXwZnsnBVaR0VtHn+I922TF89PGDQkQcW6rd+nDlA==
X-Gm-Gg: AeBDiett9f70NKi1cg624SQTQ2lCVQEXef1Q3x3N/k/IQuX27H38gcVw1PEcmgksUXs
 lX62lFOxyOnQfvRKFObjQ2INg2AKix/gEjGS/HWxnV3r8ib1iQDz/M9zCzOFp6eEESSbzJlO3ot
 3S1sSxiQmFPR1YHgud1ngmqSKl/V6lqvkc4tS7snMeYkgsIpOthrXawtfK/Xvwp3i1mT1/FvWm6
 r8x7wdI4rllyqRFKHTR0lmOQHTDWPjUGlGc1gZyDZgJeut2jp4NSmM1hWI6s4N7PWV4bg3xQqyP
 paJ9C2zq7J9eTR+cgSq8GfPmeahrJMG16SrQyUagJxbIBmpOrbgm5eY81fvndvH4yoH6MkgEKL+
 hgRGiXqiglf0xVAf2fgkXRFmTNX4Jx0SVMh+SucBZD40zMQCuP51hdJOr6I1Ws0AJ4zxEH+76zi
 Fy17iU6gq1T0KoSge6z6pVP9og/qeQ+I/whzOUaQ/lZ1Sux3ExM+p3IHMNU3R9/sf84lQqmhVTn
 It7jpvJbvw5FqtlphVwhcB0OEADAgEfyCyq2v4xv6DiGNwDyXeIwATsHA4CpuHtr7sbNBahcP+Z
 HsT+2zmCqD89Gk3QQDYWxW6CJ0f0AfQd1F6lXrxRWSeGSTm/R3VaF/VCaBJtC0b5KA==
X-Received: by 2002:a05:690e:130d:b0:64a:d6fe:5e18 with SMTP id
 956f58d0204a3-65314f8fa23mr10811023d50.64.1776664888315; Sun, 19 Apr 2026
 23:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260418175814.5731-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260418175814.5731-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 20 Apr 2026 09:00:51 +0300
X-Gm-Features: AQROBzB_hPJYJ86t-CFlOxYod6Z01WXltHIX9wySqVzzkSEEiifnpXlEt5H6yZE
Message-ID: <CAC_iWjLu-a8CGn1R=6oEXOMrZZ+VSU2zThZOSvf6Of_MbPSh_A@mail.gmail.com>
Subject: Re: [PATCH 0/2] efi_loader: centralize messaging for efi_init_obj_list
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <kettenis@openbsd.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Peng Fan <peng.fan@nxp.com>, Christian Marangi <ansuelsmth@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Adriano Cordova <adrianox@gmail.com>, Javier Tia <floss@jetm.me>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Ying-Chun Liu <paul.liu@linaro.org>, u-boot@lists.denx.de
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

On Sat, 18 Apr 2026 at 20:58, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> If efi_init_obj_list() fails we cannot use the UEFI sub-system.
>
> * Instead of having messages for this everywhere write an error message
>   in efi_init_obj_list().
> * Always use (ret =! EFI_SUCCESS) when checking the return value of
>   efi_init_obj_list().
> * Remove the return code from the error message as it does not help
>   users to understand which initialization went wrong.
>
> In do_bootefi() move the check to the start of the function.

For the series

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> Heinrich Schuchardt (2):
>   cmd/bootefi: move efi_init_obj_list() to the start of do_bootefi
>   efi_loader: centralize messaging for efi_init_obj_list
>
>  boot/bootmeth_efi_mgr.c      |  4 ++--
>  cmd/bootefi.c                | 13 +++++--------
>  cmd/bootmenu.c               |  6 +-----
>  cmd/eficonfig.c              |  6 +-----
>  cmd/efidebug.c               |  5 +----
>  cmd/nvedit_efi.c             | 10 ++--------
>  lib/efi_loader/efi_bootbin.c |  5 +----
>  lib/efi_loader/efi_bootmgr.c |  5 +----
>  lib/efi_loader/efi_setup.c   |  2 ++
>  9 files changed, 16 insertions(+), 40 deletions(-)
>
> --
> 2.53.0
>
