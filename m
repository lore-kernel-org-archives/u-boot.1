Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E196E77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 19:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC5D58056E;
	Sat,  4 Jan 2025 20:35:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R9WuJ6fH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 758A68056E; Sat,  4 Jan 2025 20:35:14 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B15C8043F
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 20:35:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aaef00ab172so1376955866b.3
 for <u-boot@lists.denx.de>; Sat, 04 Jan 2025 11:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736019312; x=1736624112; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JRLephFVnR9YV5wYrXmMvG0KFQghBiZpR0ZEINN2U3s=;
 b=R9WuJ6fHod65QSvVHsYxl2I5PaCAsHB828GGMAlaQbbnqCbVIsN3Ftp9ORFSbApbvd
 uDEIMp7ZuY8YY92RBhbeW/vgTT1V9ovfImn/SxlA7D3pP0uSGTehnzdvDmVNAcHvwEmD
 tarBlqx1vFygxL9dRIhFJ6kKooE9Ix43xzpIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736019312; x=1736624112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JRLephFVnR9YV5wYrXmMvG0KFQghBiZpR0ZEINN2U3s=;
 b=E8H+S4kMOXxycVui0sNkUBM5WPtr2QS/YzU+J1qZ69nc7Z2PbEYCbYkBBIC/PO5eMw
 pOR23NVxnpFZBHEPwURUwOQGqNegGVVD4WqjXb6x6jJ5gojp/wtsZJ6QF/UVfi5wTY2j
 RYtyQxasPE/FYjVs4LfiRq4Tn8nW/XCi7mAJxmU3r3GAxytlwvq0ZcaM1SyAvkUFvXno
 mC3S//vEidoFGL+zV38Z/ycbKBZf/sccBSHN0eAC9xXCPAu8Yso+OzdirpDS+3M/pAXO
 NJ1I2OMbM742ocq0mfZrpxQD6iMSCsj+kiQaiTCyd6bmtS2AkWlnUj2XKCsw/4kn5m5r
 P/oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSaQvIKDiYU9L4IjU0w5wbdrYk69yifDHiaiP8KWVv62q8QhiUv6N+TXu9QT0iBwSi+A3AAAI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4ycUKA7AKnlkQx5Av+7QlkHlE5rYbRV/2Nwmy9nGmRohc0DRN
 6HXZLvvMAzsxJvCCTaYSPTBjFZI4jSVLZ3ALHx5o+w8Rbe9Fk4pH/vkxqvPXevDIiITJvQqi6SN
 vIvaW5/2SkM0FI9ALan4ewSdRuyhsr4/AQHDue7WJ0rLnAhc=
X-Gm-Gg: ASbGncvujj3IQipz/E/cKa0D0xHRdLNmXDXiQrojC6dhuGhwDzoeKx+wkOufACwoT98
 CdwDYKV67EnD2rw9x5k65alWyRkUN9hS4zwbxnEVB
X-Google-Smtp-Source: AGHT+IHdkC/pkSWzU3+14r/kUZSDPaj6Ol06YibP9NszbSOqYUs+MR4tfojqtTEzhmj0thrc8k/lSUeeI9zcysReXFo=
X-Received: by 2002:a05:6402:2790:b0:5d0:e73c:b7f0 with SMTP id
 4fb4d7f45d1cf-5d81de1c241mr132943000a12.28.1736019311830; Sat, 04 Jan 2025
 11:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20241229144607.1051889-1-pbrobinson@gmail.com>
In-Reply-To: <20241229144607.1051889-1-pbrobinson@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 5 Jan 2025 08:35:04 +1300
Message-ID: <CAFLszTiFbULEJSKvFZ8Vdjsj3QSv-Q-TPA3SRnTxtZz+y1y_=Q@mail.gmail.com>
Subject: Re: [PATCH] rpi: Add identifiers for the new RPi 5 series
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Matthias Brugger <mbrugger@suse.com>, u-boot@lists.denx.de
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

Hi Peter,

On Mon, 30 Dec 2024 at 03:46, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> The Raspberry Pi foundation have released the Raspberry
> Pi 500, CM5 an CM5 lite devices so add the assoicated
> revision identifers so we can detect them.
>
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  board/raspberrypi/rpi/rpi.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>

Would it be possible to get the information below from the devicetree
on the FAT partition? This is passed to U-Boot at runtime.

Since we already have the DT internally, do we need fdtfile? There are
mechanisms for using U-Boot's devicetree when booting.

> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index 18be244aa79..1e43c631898 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -193,6 +193,21 @@ static const struct rpi_model rpi_models_new_scheme[] = {
>                 DTB_DIR "bcm2712-rpi-5-b.dtb",
>                 true,
>         },
> +       [0x18] = {
> +               "Compute Module 5",
> +               DTB_DIR "bcm2712-rpi-cm5-cm5io.dtb",
> +               true,
> +       },
> +       [0x19] = {
> +               "500",
> +               DTB_DIR "bcm2712-rpi-500.dtb",
> +               true,
> +       },
> +       [0x1A] = {
> +               "Compute Module 5 Lite",
> +               DTB_DIR "bcm2712-rpi-cm5l-cm5io.dtb",
> +               true,
> +       },
>  };
>
>  static const struct rpi_model rpi_models_old_scheme[] = {
> --
> 2.47.1
>

Regards,
Simon
