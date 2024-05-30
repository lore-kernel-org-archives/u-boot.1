Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5850CC25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 14:42:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94C5D88708;
	Thu, 30 May 2024 16:42:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r1s3iQGs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 247CB8870D; Thu, 30 May 2024 16:42:46 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A34588706
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 16:42:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f62fae8c1aso463775ad.3
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 07:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717080162; x=1717684962; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qDtSB0o2UNv+hp+dh19Ww8DmJSRgJkI1r1J83tyGqeo=;
 b=r1s3iQGsRQM5+NYefDr9eEvCiZP2pvHECLcYEcXrqZHMNWP3o7+KeP0S/3Rf91v8BB
 YrFBjrR0KwerQSmbuPFUIUlHcdl6WfBHS3SOJOvfzx7mbth9hkX8Rb35ndYdgrPYX3u9
 LS5eYcgvOJrvVMXzOm9Gcj9UQ4EFKtXpo91XsdTmmDg4nWqKrVgHFwjTC1kQvDVAwWDY
 4AW4ZnHTeRXteZ/EYWn9BLks5ft3HAcbmTduSHQPuS3ooQLrVie/+sz61QGI1WCpS9X+
 BQRkcHoT0HIMCZA7vBp4KsakP+7lekTJOcTpoyBtz1qS2qtcPHqsb+GMe0BmLFcDdK3b
 o9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717080162; x=1717684962;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qDtSB0o2UNv+hp+dh19Ww8DmJSRgJkI1r1J83tyGqeo=;
 b=nPuiBIa6fUH5TFDUQvK44cInsQrysJJj8fQIcwISV4YjrPPc/eI0v+F3d1JKUg2cB/
 XQfXEZI28bg5hlxodHqSFEPMR36uBWsmqjPmZubyJfVpPAZZfqoKr+50AKFxDyPONNZR
 ZkKiWZLYI27Wjas4dEMNUPr+w/R3uE3HE66JEUF9T8AwOi0FmYQEKD/ahO63NuPDlAiI
 //WIFZQek+FDKM3nmK6cca7j/yDp4fvwDGtXeT/gmVl7t3UEH2GqZBDfNhbkF0nanS6l
 1ac4b1X9w/g8WteJYvgNjMqDfl+YYdzC14hkODeDyhasxgZn5DtnhUYOEsKRhjBw596j
 JxUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF7ZoNP+q77W/e7Q9ovf82fi7+f/xNzqyF0AaJczPCbk1oRGpkDQGkInlxu7bIr6yn/TJEdr6ke3wTui/OlVevJTy6RA==
X-Gm-Message-State: AOJu0YzVX23xrLAKlhPKd5FHdphwxBFLX/Xl/M9OIjB/hZgKUoscUqtF
 lxpmoLCl3MWbJ00JPHHeDkSpRGUdyIXWG5E0IS09yTXTKe8eVRFAMEjvKYMWECdJmgI4dlWzKF5
 3aT+aLkUawMYNw2fjbXceh+yyLLoq/NKvDRy6jQ==
X-Google-Smtp-Source: AGHT+IFrDlGS0lrUs2bnazBRVhiHTe1VKto6VB302uW2JjHg6BU1aCP2dAA5zTvXGgxqfBBASFucIfcBXx7JTYIfGtQ=
X-Received: by 2002:a17:902:e549:b0:1f4:5fe5:74c9 with SMTP id
 d9443c01a7336-1f61a4e4e8emr31262335ad.69.1717080162046; Thu, 30 May 2024
 07:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
 <20240529-b4-dynamic-uuid-v2-3-c26f31057bbe@linaro.org>
In-Reply-To: <20240529-b4-dynamic-uuid-v2-3-c26f31057bbe@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 30 May 2024 17:42:05 +0300
Message-ID: <CAC_iWjLTm0wzet_NPSzA3QFR+0tE+EAxyq7F=hbdNnSdVOPQ4w@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] doc: uefi: document dynamic UUID generation
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
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

On Wed, 29 May 2024 at 17:49, Caleb Connolly <caleb.connolly@linaro.org>
wrote:

> Document how platforms can generate GUIDs at runtime rather than
> maintaining a list of UUIDs per-board.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  doc/develop/uefi/uefi.rst | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index 0389b269c01b..0b60702c052a 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -448,8 +448,39 @@ the location of the firmware updates is not a very
> secure
>  practice. Getting this information from the firmware itself is more
>  secure, assuming the firmware has been verified by a previous stage
>  boot loader.
>
> +The image_type_id contains a GUID value which is specific to the image
> +and board being updated, that is to say it should uniquely identify the
> +board model (and revision if relevant) and image pair. Traditionally,
> +these GUIDs are generated manually and hardcoded on a per-board basis,
> +however this scheme makes it difficult to scale up to support many
> +boards.
> +
> +To address this, v5 GUIDs can be used to generate board-specific GUIDs
> +at runtime, based on a set of persistent identifiable information:
> +
> +.. code-block:: c
> +
> +       /**
> +       * efi_capsule_update_info_gen_ids - generate GUIDs for the images
> +       *
> +       * Generate the image_type_id for each image in the
> update_info.images array
> +       * using the model and compatible strings from the device tree and
> a salt
> +       * UUID defined at build time.
> +       *
> +       * Returns:              status code
> +       */
> +       static efi_status_t efi_capsule_update_info_gen_ids(void);
> +
> +These strings are combined with the fw_image name to generate GUIDs for
> +each image. Support for dynamic UUIDs can be enabled by turning on
> +CONFIG_EFI_CAPSULE_DYNAMIC_UUIDS, generating a new namespace UUID and
> +setting CONFIG_EFI_CAPSULE_NAMESPACE_UUID to it.
> +
> +The genguid tool can be used to determine the GUIDs for a particular board
> +and image. It can be found in the tools directory.
> +
>  The firmware images structure defines the GUID values, image index
>  values and the name of the images that are to be updated through
>  the capsule update feature. These values are to be defined as part of
>  an array. These GUID values would be used by the Firmware Management
>
> --
> 2.45.0
>
>
 Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
