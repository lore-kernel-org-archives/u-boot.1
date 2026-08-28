Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B9EC61DBD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 09:28:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5836407F5;
	Fri, 28 Aug 2026 09:28:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dP43kjkI3e-m; Fri, 28 Aug 2026 09:28:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787909336;
	bh=rzzcLC3Bx+g7mxkOgY4W0sfFqnMT0XuvCxskcktkRN8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KNvjby98V3PgsMveJ62v9jMQeMQuQzdjPwuUkV7Tgx+ZwkK/hVKeEXPpFScv3E6Ag
	 TUfgavM0WsgPG+V9WGNt+MMs+X2gpj9RNaw5szNHtGpcjSDAQE8x3TYSdK/GILEJxz
	 PbNX7mTM2IkSnc4MZ1ZT0/FPLp9Wc5uu2LsaQriiXJ9jeJzVbDkwNNv5SjpEOBZ1l5
	 ZqdX9qgnpIGmJCM7myrBPPUobqQEdwmYg/zyQEBBeqZSG18Vjfyht2aq7+ArzZ2XcH
	 5zhAghvY/3gaJ4fXXDn+/KzM3CwH5ABxxQmCLX3fEaZg+3nhrfbF4IRm25V7Rs9DKl
	 9+XU35UcLkvHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D15C340692;
	Fri, 28 Aug 2026 09:28:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F1018465
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 09:28:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E275B40692
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 09:28:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZTnM0OzuU8MA for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 09:28:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=kVqDceSR
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D4C6A40649
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 09:28:53 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so457538f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 02:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787909331; x=1788514131;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rzzcLC3Bx+g7mxkOgY4W0sfFqnMT0XuvCxskcktkRN8=;
 b=kVqDceSR4L7XXhwz11Hra9vkaluguxEqHDKNcisOtaRp6G67W85Tpk6OktIJq4x0LD
 yCrVheu/TWgcvtaFLq8lmdzeKu7fdno/YFLZ2YrjfAwZ0gGjzxoh/4l2iR4QG/+oFrdk
 7NATMAA6Ip8py0o9ikEB88x22BTHcKBd5TUHGG06102/IhpypPGuqz/TfevGkhCoREI0
 L0LSdx5bBDKXQ5rt9UaIqaKvEffjFiB9HcgimABKiEyfqV2sxcDsEBd5Pd4rBhSllSla
 ZZzwwy5ylXf+YkMRwgjFLWHPN9j9E5c/KSQib2xMRbo82Vs2FSFYvOxfHVpHWNRP57Bf
 tlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787909331; x=1788514131;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rzzcLC3Bx+g7mxkOgY4W0sfFqnMT0XuvCxskcktkRN8=;
 b=aAPNGMoBKTb7VISfSnz8rsqSw9FNAvmZbtjfzFMtT/fMawrmp+Tbw1u2BSTMk8v6TV
 IbQFgBnnxEad9I1YS1zloGQFuaGpZZAFfP9MbMpGiMoRk7XutSKqQqrM9362bCpnDVIX
 tYR9i6krAQ++4M0c8q23pDDIvwIh4u+Smb8TJJSya1NsoLKrzS/FGz7Z9f5sqeJVNZcX
 BdehmWldg85E8D++K38vN/79isjNScdypv89ZrNda3+Q5c+IF+XgAvNZgBymP2EEvG6N
 fJsgv7VPjPjX8hE460OdQCM41EwNys4qi9WaO+mYjMQu6LKvYhtYYxprX3j0jKs6ZVHe
 Yd9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpEvy8OjzdW/qDg5idT+7L+YA5Xatm5hV4XzzsJlabIbkHhTLV7crCWwYWNlRasW9S6FNWY3F4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lIdKP+lDmY6D0grP4XaOyCAiVByuajBdCmo6mEBuE5GNlc2UBU
 WI5PzqsIv3hXUSI0Wpx2GXj3E+7oVfbL8g5crw/kGVliLpmgq0UfCQ8AGm1Go/7W3ZdzLquhFCu
 kWZL/JF8=
X-Gm-Gg: AR+sD122UgrNrDXbKmyjkhi9O/8vehuKBFiK53D6M+htfTh4mp6SUlnE+NV4OYtlTls
 6Xy76ILNxs76slNUvFlzJ2t8HHPLxeuZjTb4jo9ko0E6wTeDCZFAsmJT0G62nwJ+SWVVUDPRvV5
 RyBh9ZUERY0S1bcfXRYLqig+t4RVkGgXG6SUnimVrHoDyu5q0UVJMLCtUoE8/okuxg0robo7J2a
 5f/JuOyAcRReNDuyDIeq3Ns/8mHDtrayXht7l7Vvu/yFbWD4lO6BEqlL2JFBK/pYRiWkXvAhqu+
 xAvGKyalfVj02MVn6j0DLj5WoS8xq3g/hwJ4xwnj1TFsFqDx1bJR+TyYAQIw9MoWRwZPkkShvH9
 rnBYScXGFGdqnl++Fyvwp+DZ79ELX3b5BnE5gG4KfpyaG5W+n5Ib1AO7KLIPhoTkBxZTVa/8OEf
 RPt7dcNV/meqjAI7uvZvi0K/0xznY7ELKUrjzw+qSKJCJxZ2RkfK5JlLRxM0RHzgFJo66kJuBsb
 EZQ9hs0EO1eJpXrHp+LZcTC+wqyLiTPodJ80syCymHcud85Bo8PsE22AQUUpfQi9PXyPi08vEOP
 cI07ix44f3hxJzQUJTYAw2WDp54BlZtLExlCTtYTOvEO2b0BT1jYWHJeYRrnfxE2u1RUE2XqqiU
 45rk6wZQGGM0TMbqRYN55JIjeWvLmSfxyOn17pKk8sbism+jahqaVadsdw/Lm18RDXVAKIkHhFm
 IHKIXgKOE6IqYhL99aT1+iVleUH9b5Lg6YfE+vWp2dwy/NrFT+6SPY9RUsZniWiKDqgbUtX5yZY
 R8vg7auBjfRMZo5oPrb17u57kNaCsdoDrcDAVPbLojTIIv7pPckJYevU4If/9qceCqw
X-Received: by 2002:a05:6000:4008:b0:482:e2f2:19cb with SMTP id
 ffacd0b85a97d-482f79870f9mr7555872f8f.5.1787909331305; 
 Fri, 28 Aug 2026 02:28:51 -0700 (PDT)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbab3f16sm2749999f8f.1.2026.08.28.02.28.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 02:28:50 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 12:28:49 +0300
Message-Id: <DL0GYMY2PH5B.3TCLPY0T7YFMX@linaro.org>
Cc: "Heinrich Schuchardt" <xypron.glpk@gmx.de>, "Tom Rini"
 <trini@konsulko.com>, "Michal Simek" <michal.simek@amd.com>,
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, "Simon Glass"
 <sjg@chromium.org>, "Mario Six" <mario.six@gdsys.cc>
Subject: Re: [PATCH 1/2] efi_loader: firmware: decouple dfu_alt_num from
 image_index
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Balaji Selvanathan" <balaji.selvanathan@oss.qualcomm.com>,
 <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.17.0
References: <20260813-efi-firmware-dfu-alt-num-v1-0-43f034253b21@oss.qualcomm.com>
 <20260813-efi-firmware-dfu-alt-num-v1-1-43f034253b21@oss.qualcomm.com>
In-Reply-To: <20260813-efi-firmware-dfu-alt-num-v1-1-43f034253b21@oss.qualcomm.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Balaji,


On Thu Aug 13, 2026 at 8:53 AM EEST, Balaji Selvanathan wrote:
> RAW capsule updates assume dfu_alt_num is always image_index - 1, i.e.
> that fw_images[] is a positionally-ordered mirror of the DFU alt
> settings. That holds for every board that builds its fw_images[] table
> by hand, but a platform whose image list is discovered at runtime
> (varying per board, with gaps for missing components) can't guarantee
> image_index and dfu_alt_num stay in lockstep.
>
> Move the (image_index - 1) calculation into a __weak function that
> platforms can override, following the pattern already used for
> efi_firmware_get_image_type_id(). The default keeps the
> existing behaviour, so no other board needs any change.

*efi_firmware_get_image_type_id() was always static, which funtion did you =
mean?
fwu_plat_get_alt_num()?

>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  include/efi_loader.h          | 17 +++++++++++++++++
>  lib/efi_loader/efi_firmware.c | 21 +++++++++++++++++++--
>  2 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 3a4d502631c..6626674f738 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -1187,11 +1187,15 @@ efi_status_t efi_capsule_authenticate(const void =
*capsule,
>   * @fw_name:		Name of the firmware image
>   * @image_index:	Image Index, same as value passed to SetImage FMP
>   *                      function
> + * @dfu_alt_num:	DFU alt setting number for this image. Only consulted
> + *                      by a platform's efi_firmware_get_dfu_alt_num()
> + *                      override
>   */
>  struct efi_fw_image {
>  	efi_guid_t image_type_id;
>  	u16 *fw_name;
>  	u8 image_index;
> +	u8 dfu_alt_num;

Why do we need the extra struct member? The code doesn't update it to store=
 any updates values.
Can't we just use the runtime result every time?

>  };
>
>  /**
> @@ -1240,6 +1244,19 @@ efi_status_t efi_ecpt_register(void);
>  efi_status_t efi_esrt_populate(void);
>  efi_status_t efi_load_capsule_drivers(void);
>
> +/**
> + * efi_firmware_get_dfu_alt_num() - get the DFU alt setting number for a=
n image
> + * @image_index:	image index
> + *
> + * Return the DFU alt setting number to use when writing the image
> + * identified by @image_index. Weak default derives it positionally as
> + * (image_index - 1); a platform whose fw_images[] is not laid out 1:1 w=
ith
> + * DFU alt numbers should override this function.
> + *
> + * Return:		DFU alt setting number
> + */
> +u8 efi_firmware_get_dfu_alt_num(u8 image_index);
> +
>  efi_status_t platform_get_eventlog(struct udevice *dev, u64 *addr, u32 *=
sz);
>
>  efi_status_t efi_locate_handle_buffer_int(enum efi_locate_search_type se=
arch_type,
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.=
c
> index b41969c70fd..c7339412055 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -80,6 +80,22 @@ efi_guid_t *efi_firmware_get_image_type_id(u8 image_in=
dex)
>  	return NULL;
>  }
>
> +/**
> + * efi_firmware_get_dfu_alt_num - get the DFU alt setting number for an =
image
> + * @image_index:	image index
> + *
> + * Return the DFU alt setting number to use when writing the image
> + * identified by @image_index. The generic default derives it positional=
ly
> + * from @image_index; a platform whose fw_images[] is not laid out 1:1 w=
ith
> + * DFU alt numbers should override this function.
> + *
> + * Return:		DFU alt setting number
> + */
> +u8 __weak efi_firmware_get_dfu_alt_num(u8 image_index)
> +{
> +	return image_index - 1;
> +}

This is one of the things you need to support swapping image indexes on the=
 fly, but there's way
more. One of the compromises we had to make to plug in capsuile updates via=
 DFU is that the image
index *must* match the dfu command array member. IOW if you define the arra=
y with this

{guid_a, "u-boot", 1}, {guid_b, "u-boot-env", 2}
the dfu_string *must* list u-boot first and u-boot-env second.

IIRC we already check for a mismatch of GUID/Index in FWU code, but in the =
normal code we only have
a check in the efi_fmp_find(). The way you are switching happens after the =
check so you might end up
updating the partition with the wrond kind of firmware.

[...]

Cheers
/Ilias
