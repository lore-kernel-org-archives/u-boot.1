Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CBDCCF9EE
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 20:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23B7A82A9E;
	Wed, 29 Oct 2025 21:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WsiQiGbp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3265835B3; Wed, 29 Oct 2025 21:13:03 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03EE7836F0
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 21:13:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b4539dddd99so68896666b.1
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 13:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1761768780; x=1762373580; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GFQLsYGcAc1V9XpunQHpzYbqxcFp0eCyCdaHaeie2QM=;
 b=WsiQiGbpEolxHUkhroUqNM5PVbsGcGYv9rUhiZXQAsR1lVwrOMFaG+qmnytsRcjvOY
 FNsrDVZWexwHQ2bFG4U8YA1dku+3RSxE6T3KYASN5HMqCSEF76hD8BlcnKDPp/TXONBE
 4hmR/0zRk/1at+KESArtg2AGsI44suUPe+AWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761768780; x=1762373580;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GFQLsYGcAc1V9XpunQHpzYbqxcFp0eCyCdaHaeie2QM=;
 b=fmpBivBh1bMyRTY8Q7hhiVhYOaMmWlHW9niWYw/2wTxyopg/cK7P0srXwRFnwS34QY
 LbCQFH3uNBlV+L9Mhm9XTXpDJ8z5oLWmlB7pkDgwi07BBDQoSlbk+EA1wiOm/UwraBQz
 qxt4BS18scgGhgznMrtji7RC8KtJ6om74utr5lE7avRl/WbD9oCp2Bm4I1XaIwYZhsj1
 EFIsRnXb9QcEK6hIPFBdkAqJfFodgXedukeadW+IjQ4nGaaitV3sUicVh6OVvU1fnUdA
 qH2hL4HyIgHIdAycCtWJ6yq9N0/9yamcmepoO63QDkL1RXOHTAxIEyicseSNBFRaqECE
 0AYQ==
X-Gm-Message-State: AOJu0YwnUoeKmrGAoYa+yoZUoZE7YOn0Ng9LISwERM6Dq05+qeuhx3X4
 V2IQxBIFU2tV4DxnHSMQV2z/Sm1JBLQgUIXEoOat7erCpdlcSPgalnRR1sx0XiKDzv64hdEblBt
 zFYdld6g+HUbG1StB+Xw4QE+VRgR+5A0QiDvg26Ne
X-Gm-Gg: ASbGnctGLsvM00DKp487pUaGZWXzHKy4k495Fa6G/mEy+4IsWiziKd3lFyEYlTqLFGE
 7DYF0GBpGMjQtJrjOjGf+OFDe0OrmvekYW7pV9r/fNP1nbTZ+wk7gH93RrR609UoOD7eDZEyCU+
 0f681XUldXgwkB63Fu4RBFiQJZMC60+Pcv3AuyABn7PF6JEQp7hhCFmE55Uq+KD+TrQi5DmY0nO
 3eI1HCLA7JbaNTUUR8Qn90F+PcSO5Ky/n1gfUcREdHfzfdoOAjcuZv6+t6hvNlwIgHXaw==
X-Google-Smtp-Source: AGHT+IEx1xOsrPVB+wtGZK4IDUADE8BIW5HQrBfqNORpgh75UxVqUA5xmvPZrVHiAEwRVRspEUCgcpET1cPYO/diDRY=
X-Received: by 2002:a17:906:dc91:b0:b40:101d:cbc2 with SMTP id
 a640c23a62f3a-b703d524adamr350632466b.37.1761768780458; Wed, 29 Oct 2025
 13:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20251029-sys-bootm-len-typo-v1-1-5f1858d9e80d@cherry.de>
In-Reply-To: <20251029-sys-bootm-len-typo-v1-1-5f1858d9e80d@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Oct 2025 21:12:48 +0100
X-Gm-Features: AWmQ_bmFUxFCFDgYM9iY3o2HARUV18S9AdprAca4zS80vtketBm_bdNaNc_Sjkw
Message-ID: <CAFLszTi4ZiQpBdOhHwkt7P84PK_9HY=tWj+nBMMsiG_wA8CB7g@mail.gmail.com>
Subject: Re: [PATCH] boot: fix typo in SYS_BOOTM_LEN description
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, Martin Schwan <m.schwan@phytec.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Wed, 29 Oct 2025 at 12:19, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  boot/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/boot/Kconfig b/boot/Kconfig
> index 9adb051400f..762bf4e2dee 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1053,7 +1053,7 @@ if MEASURED_BOOT
>  endif # MEASURED_BOOT
>
>  config SYS_BOOTM_LEN
> -       hex "Maximum size of a decompresed OS image"
> +       hex "Maximum size of a decompressed OS image"
>         depends on CMD_BOOTM || CMD_BOOTI || CMD_BOOTZ || \
>                 LEGACY_IMAGE_FORMAT || SPL_LEGACY_IMAGE_FORMAT
>         default 0x8000000 if PPC || ARM64 || RISCV
>
> ---
> base-commit: 4cad9faf8d2887b8851f0ced5194ffbaa92ca71e
> change-id: 20251029-sys-bootm-len-typo-65afe0aa772c
>
> Best regards,
> --
> Quentin Schulz <quentin.schulz@cherry.de>
>
