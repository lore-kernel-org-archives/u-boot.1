Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF28CD3430
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:24:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E825984693;
	Mon,  4 May 2026 15:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ICqV76kp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3E13846A3; Mon,  4 May 2026 15:24:47 +0200 (CEST)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AB9884374
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-60fce51aa55so1501880137.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 06:24:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777901084; cv=none;
 d=google.com; s=arc-20240605;
 b=VuFZQ1l71j8vXNeHNfrOGvchBfPGfCUUKXcR20PSn1/HeB2HRUqh4l9GDw4zTYSKXV
 ZI9isUrz+aqkhNuIEQUJ5netLGPsUiHqBzMYwnQFvfgqGmU0yuJa2CvKCze/sfeDkbu/
 mgLaUpiF0On+ZW42Cgdq51aMxLxhKA6DFJUyqBOAGnfQyY0T2yeeEt5K8tFqtm9BcR4y
 SlgCu7w/lDn6P+c9IUG6ErIL92SENoskDAxK9OTKVNj9RqZYPMkbADSXlecR6FT+qGWj
 R6NF+vc1TAeuS8raW3wKbDj+nDGujPhsC84+Xsuy2/8+yJFI3RzwAo9xzbQdPPTox/h2
 ieAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=puqPxSbKplQPZVsj4i6brMI1bKXgzgTxawMQIP0+adU=;
 fh=PGOLd+qEpcD6x9mGtgU6Iib0OY1GoEwS3sDTWb0pfio=;
 b=giP6SbdKkonJYFIxjHqqoOHy30efaDxeNpv8wIoQNe9GPuxyzYZGCdmFdGyc1dsK6A
 4UfTy7Afw2RjUl8mdu+fm5gsZ7X8MpXLSwgYIAn6+4cpixJXilFXuq3h5vBbVGOUAKXp
 9y/WHZd6aHcBFbGE5x9fiymi86opdCk26njwOW7yax+QlEmommMPDDHcIJb/A1iV/hgK
 d2QZ9BVJ4ZjYlf2xpkcczJpDJn3sIAWvBkBxDF+VOedqAetYPE8AJ/pLgWPjLnINF0mR
 EFrMy0PW1pBK5SAQx2KsxMmity2AUOJvhFV2M0Y7C9ysmMJhMNYp4KZK6rZIZY21n10n
 +Iyg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777901084; x=1778505884; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=puqPxSbKplQPZVsj4i6brMI1bKXgzgTxawMQIP0+adU=;
 b=ICqV76kptf+WZhV1HKtqyBSDxVA1t7D6KPCUztv2bE2Rv7dO6zxe+Jdo0ZCDhaESAq
 9hZC+r3CGp76lTCl78WUV79wuA07UVyCJ0Z42V/ikCFwBUEo5lyV6UDOvT1tYN8Qusqs
 DS6mV1IQ+mCaPIYzIBl+PsVN2w/IsOLSOFVFXDlKU/+xjvGvNWhRqC6eq9V57ZnCvB/i
 qIBtjRQrk+2BxDG0HQRmzZ5ZuBMW7jV4d8S81YK7z+eOecz5jA2xJo6s4jkh0SeVNim6
 TpFwNo0kRYSVvMUpi/R7h6z3/qf6IuwrqWZEGdXoA+RXkONwjb2van7lNPuh8D/PZZZJ
 whKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777901084; x=1778505884;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=puqPxSbKplQPZVsj4i6brMI1bKXgzgTxawMQIP0+adU=;
 b=d0Gs+bq937wd36aQ3lqf0Agzk03vAxbkAeoOHmSGZKbkyjPxx8zkcd288ratm03nyk
 9+7M6MIeIpYSFoUZuJIrGf2gMhFREibSGtBV/DI+A+9VLHNXIp9tCRKBz8oSI3ZTrCc6
 9eK+KrvNubRZL0MZj03CMhi77ZtOt5Gw5WYsxTLyiWSCPiYn8YHumjDVmwRb4KvHEMgL
 /Ub4KXUt0WjKIcb1ealYM/lXqgPRu4oZhYnzVgyjZfL6bU6DcY1YvqnBCBHL1nVy6t+o
 pYjgOZLMheTScvBh5+K0ww6Qy9zWs7NadGfuhdT92eXVooL4ZGL9zSbR4AuCa0RoX6H7
 N+ug==
X-Gm-Message-State: AOJu0YyVVssRl+Spsh+aHqtnzYhPHYab0y2sTpd8d8ei+0v9Nx+EcLRP
 tot2aQNQYbHeVt8itd2DO+dXaKa8ShfmVTr5v5uUj+n5FNCz99OKHvRZgUWseCRQm639CV2L5Bs
 boZoJAd5B+nrhc8FW5cHFjPBEFpgS/6Q=
X-Gm-Gg: AeBDietUWUW/CahbB4dfHAutSYfThBuN6n515r8IUlEkCU6Rs6l1mf6x0Xyny/yaS1h
 lzeYvxZsM2heWMukYkWv1SDxTg210zVAW9y0wr25Q8n8u/nQtU81n+AksO7BBykyJw+1E0nDQuq
 iJItymdE+dOYVtJHRJsr10egT6SgVxbK4ydS6WH+ygk367ibdPWAjDg+aspbpb2SI6SgtUS7Y98
 Kztpug3jTRgeTSm6fuuOGFxxfnZjQQE26hHewIkNJGbzoPJLaFHz2Do3lU8yVAjM1EhKFbT5+x1
 MXqC4mymBWUeXrADKt4=
X-Received: by 2002:a05:6102:2926:b0:60a:9cac:d286 with SMTP id
 ada2fe7eead31-62d85485941mr3648328137.12.1777901084393; Mon, 04 May 2026
 06:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <3eeec4427b9ce9bb4abac4e27414ea1cb687e45b.1777443726.git.michal.simek@amd.com>
In-Reply-To: <3eeec4427b9ce9bb4abac4e27414ea1cb687e45b.1777443726.git.michal.simek@amd.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 4 May 2026 09:24:33 -0400
X-Gm-Features: AVHnY4KumLxFTmn6n7OLfiYXWtC34OEc45cq_okzO7Uc_Yw4vgzH_Dp3RQYPgSk
Message-ID: <CAMDkj5wHrE3jK7keuzTxA1ED9frCTeXQ6Ro0X1sntRfRd7pNCA@mail.gmail.com>
Subject: Re: [PATCH] fdt: check fdt_pack() return value in
 fdtdec_apply_bloblist_dtos()
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Pranav Sanwal <pranav.sanwal@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
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

Hi Michal,

On Wed, Apr 29, 2026 at 2:22=E2=80=AFAM Michal Simek <michal.simek@amd.com>=
 wrote:
>
> The fdt_pack() function can return an error code, but its return value
> was not being checked. Add proper error handling to propagate any
> failure.
>
> Also fix typo in comment: "Shink" -> "Shrink".
>
> Addresses-Coverity-ID: CID 645839: Error handling issues (CHECKED_RETURN)
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  lib/fdtdec.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index c6e13b6abefd..2d66860f6ed0 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1781,8 +1781,11 @@ static int fdtdec_apply_bloblist_dtos(void)
>         if (ret)
>                 return ret;
>
> -       /* Shink the blob to the actual FDT size */
> -       fdt_pack(live_fdt);
> +       /* Shrink the blob to the actual FDT size */
> +       ret =3D fdt_pack(live_fdt);
> +       if (ret)
> +               return ret;
> +
>         return bloblist_resize(BLOBLISTT_CONTROL_FDT, fdt_totalsize(live_=
fdt));
>  }
>
> --
> 2.43.0
>
> base-commit: cffa552d648f84769f4d5d540f419173f10cb86e
> branch: debian-sent3

Thanks for the fix.
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Raymond
