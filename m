Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0CFC28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 14:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E851081F28;
	Wed,  2 Apr 2025 16:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="VUhieOMD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF65281F44; Wed,  2 Apr 2025 16:04:12 +0200 (CEST)
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FD4680FDA
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 16:04:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1743602649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tfGP2domM8zYyHxFUNMuUzGbwZLMvUpfq5xBKoD0v80=;
 b=VUhieOMDHoimjL1Tms1tanZVzlvUd64ZMkOMxCFAxt27W7EBUTNrurI2fblCkXxh3xapXW
 +bqavcH1JeT/97uQ+8RgjquGmbiw9gAXRU/kBxZIcOEolAhGvbAleBMU2RxuDBRLQhZLjU
 1Slskt8O8ZNQNVlZ80C0VG065EoqIgXcexBsD8kUlbFJhk3HIuiCtlFZN9qoA16rYmP+3s
 UFfRCh9jcnC8/9T9YdtZsImNzGu1qpwWwxVRXe91AP7+RxGH+oFnw7IibP+w3H4fSlFgGK
 y21/XLwahizoAyFyut7KtSO0wJTFgbPDNmpo2A6oUfalh1RdMqtECqZmCu0smw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Apr 2025 14:03:24 +0000
Message-Id: <D8W7JECRPL4G.3HTWL5VYGY6Z4@postmarketos.org>
Subject: Re: [PATCH] configs: meson64: move DFU step at the end to give the
 board a chance to boot something on storage
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
Cc: <u-boot@lists.denx.de>
To: <u-boot-amlogic@groups.io>, <neil.armstrong@linaro.org>, "Tom Rini"
 <trini@konsulko.com>
References: <20250402-u-boot-meson64-move-dfu-end-v1-1-68399499ee29@linaro.org>
In-Reply-To: <20250402-u-boot-meson64-move-dfu-end-v1-1-68399499ee29@linaro.org>
X-Migadu-Flow: FLOW_OUT
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

On Wed Apr 2, 2025 at 2:02 PM UTC, Neil Armstrong via groups.io wrote:
> The DFU was set to run at the beginning, but we may want to
> boot something over USB, MMC or Ethernet even if booted over
> USB, so move the DFU as the final fallback.
>
> This keeps the current Amlogic U-Boot CI working and makes
> the default config more generic.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Acked-by: Ferass El Hafidi <funderscore@postmarketos.org>

Thanks!

> ---
>  include/configs/meson64.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/configs/meson64.h b/include/configs/meson64.h
> index f3275b37a516da6befd41324ddb2a3fe1f36fc83..675df623311f361f3a55971c3=
894ffbe1d07fee6 100644
> --- a/include/configs/meson64.h
> +++ b/include/configs/meson64.h
> @@ -118,13 +118,13 @@
>  #ifndef BOOT_TARGET_DEVICES
>  #define BOOT_TARGET_DEVICES(func) \
>  	func(ROMUSB, romusb, na)  \
> -	func(USB_DFU, usbdfu, na)  \
>  	BOOT_TARGET_MMC(func) \
>  	BOOT_TARGET_DEVICES_USB(func) \
>  	BOOT_TARGET_NVME(func) \
>  	BOOT_TARGET_SCSI(func) \
>  	BOOT_TARGET_PXE(func) \
> -	BOOT_TARGET_DHCP(func)
> +	BOOT_TARGET_DHCP(func) \
> +	func(USB_DFU, usbdfu, na)
>  #endif
> =20
>  #define BOOTM_SIZE		__stringify(0x1700000)
>
> ---
> base-commit: c17f03a7e93dfbbe5d32f5738274187065d9493f
> change-id: 20250402-u-boot-meson64-move-dfu-end-eb9f5fe55608
>
> Best regards,

