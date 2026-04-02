Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AFCD3941D
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 13:37:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FBC783CF5;
	Thu,  2 Apr 2026 15:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jq5JDNK4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4227A83CF5; Thu,  2 Apr 2026 15:37:20 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8DAD83D8A
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 15:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-66db0cf6a4aso1659991a12.0
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 06:37:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775137037; cv=none;
 d=google.com; s=arc-20240605;
 b=POU1Opoj2J32T2ahtGXXWUXNU73ENQdyCHNZMyHsUj18qBntEHNdAU761LgY8H2NDw
 XNbpWDFDpyjLy9YlmsYFPy0KJ4GgKZbQrJgOYxMDWzBpBqm6KrBNJk7qZOSWniKbqrOd
 z4IYfVOyMS41vEh+g5PBQKgdr+o7tt9tjS+MqTThoWmgNoto+bdENr7P9iEbgH7b46gq
 keJVMVk/R3r+FuFezOigs1OFi4XJvQQC7N5a2Qyyk6HtR6XeQYmTaWXegioMBBwdicfg
 /UyyPfHoeo6hD6aLqp9v7vBj78WYUdpYUTiKsjTozZUpi4m6PCJtgCurGcC5k//cnuUD
 CYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xI1fZAkzio8+9qhlYZg7/ZVqfGxrvoz51aHmgn9MDBU=;
 fh=uL7WA/lGUEU/6lJ5D7URC9/nS99y0sAOV1btFG7a9iQ=;
 b=h/Yfs6jkQ0ODoGBRh4C+wZ04w+NmQbMsNVEvCdKiqP/Dykhxm3XDj0xeShEe9jR+Xv
 xsz74gzcLM13ESQhQMfcuQ4w2MV0/7d/Epq+L1OnNY+4MBfstkythe/ga70h5FIs8aS0
 69YrlHuVywLgXRVIBAENPllZO+GncEJ3A2rNqnH2BXxLTtz4kZmb+HRo4ZBOMsZRfIx6
 29rGdtnuywKgsw8CUUwXwP//NGli8KOvnhrOEtVV6ELk8N/kN+oRiSGMIKnRFkFKXyDW
 nRI/iiHQt9YalyEqhIW1JHA1YJDk0YThevkSfJq8lwwVkabJQSbkbzzOlGKs6vWvUa6s
 yvMA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775137037; x=1775741837; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xI1fZAkzio8+9qhlYZg7/ZVqfGxrvoz51aHmgn9MDBU=;
 b=Jq5JDNK4Yv1aA4jo9iKt23hP7iF81sy0i9A2ZfmYAZOcqaJ4BC7jdQaHbVCj7k4NFT
 puPBj6mm+Vcb1HzN/0NGHR2WxdF5e5TFiMmbFnR1MAIo2Z6EzF56VfTDhlAig18dFm4U
 JbHu0RESBupKgfFaIpTuzWFg5mI44xHf/yxC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775137037; x=1775741837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xI1fZAkzio8+9qhlYZg7/ZVqfGxrvoz51aHmgn9MDBU=;
 b=RXuqk+upIVkNIccZZLs4h9+/tMkotFsx3cA5dD/Ru2LZHCgpk+2SeofZiWFhg4he3/
 d5vaDeQzbjYE/ztFUvpAQqkELXghbYtHMOzzcd6E0s066pLAc45r6H1sfAOKJFPRN9QJ
 S6RWyg8CRYEa/fb8QYpa+17jF5NivXAGizQAW86j5egXsg0/NHAxNLamaJrE+5EVBOy4
 oh70ekbuUOPRD8vj97+ZnYhtsWDaEVvAuhZMr/FyX7UClBaUgAeVS9xPqw8sio1b4DDL
 WidDn/R0hqTPn4WDOaES6rSFR+xvbeuxODRKti6KRuKFYRmYYgixs4y1LhBhtmckWBJU
 nsIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVikUQ8fs/EUGOzbgePItF38GPJOS6L01Vsv4RP1xy6IkBR8aznViMo4w+R4VEoCB94o0Jtkdc=@lists.denx.de
X-Gm-Message-State: AOJu0YzgTEM3W58qnmVkXhJSLXyX0y8e++RhigdA3KrDmi/mXs4G/vP2
 iAtChizUPRfLtBS9A93aBa/7eEw8Ryht9Jn4xx+IsLAtwo2Fk55IX9nK8t3JreVJVuh3kHf9ZF5
 tZ5hbYv/+/24yMbwRYS0Y/+7xQ0O1PmIHql7UlY+n
X-Gm-Gg: ATEYQzxZIhxwgMoaFk3CEIrAhiBL7vPUptApWwqqgY7FwqcHXAQzVaLuHABfpVzJ5BM
 WSKTM6GH5YtFpy5YdHUK+m4r+07srQFqiPaBaSjoTAQjBGpj5YfyhG/ZCT/po1jokydjKx2TPPu
 sU06IPfWuXdsk7oHmBFuPesA2RMw75nkT4nHQ8IQz6Wdc7WJ6rhLq4mKVs7Td5lYPqLfFgZXc3O
 Z/Akll3zii6+kaXz6x/yJJH18EnGtusTb/5QM5G6qWYnr2l6HV4o/g899LXAXwZKZqG30BSuyaR
 Rq7lNw==
X-Received: by 2002:a17:907:d204:b0:b9b:e687:7ca7 with SMTP id
 a640c23a62f3a-b9c13cc743amr523884866b.50.1775137037053; Thu, 02 Apr 2026
 06:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
 <20260331100047.34618-2-philippe.reynes@softathome.com>
In-Reply-To: <20260331100047.34618-2-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Apr 2026 07:37:04 -0600
X-Gm-Features: AQROBzB6kEadQMuQvUnHsptcBeSpvWc1fhAgqbLwpR7CHauhZ43eY7Kj8IKDgxc
Message-ID: <CAFLszTgb5aJx9nTqWmdok=NOMmFpoz3OmEaaHn88WRA6tdbD3g@mail.gmail.com>
Subject: Re: [v3,01/15] mbedtls: enable support of ecc
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
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

Hi Philippe,

On 2026-03-31T10:00:34, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
> @@ -89,6 +89,24 @@
> +#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP192R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP224R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP256R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP384R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP521R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP192K1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP224K1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
> +#define MBEDTLS_ECP_DP_BP256R1_ENABLED
> +#define MBEDTLS_ECP_DP_BP384R1_ENABLED
> +#define MBEDTLS_ECP_DP_BP512R1_ENABLED

MBEDTLS_ECP_DP_SECP256K1_ENABLED is defined twice in this block -
please remove the duplicate.

> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> @@ -164,6 +164,7 @@ CONFIG_VIRTIO_MMIO=y
> +CONFIG_ECDSA=y

The commit message says "Enables the support of ecc in mbedtls" but
this is doing more than that - it also adds CONFIG_ECDSA to several
defconfigs which is a functional change. Please can you explain in the
commit message why these boards need ECDSA enabled? Probably should be
a separate commit, too.

Regards,
Simon
