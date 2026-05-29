Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43073CD6E45
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 07:19:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F8E2846B4;
	Fri, 29 May 2026 09:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ltc4YbpD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B88C2846B4; Fri, 29 May 2026 09:19:20 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9552883FF5
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 09:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bdb3fd39045so1201820066b.3
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 00:19:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780039158; cv=none;
 d=google.com; s=arc-20240605;
 b=LsvUcdwSm2FdrSsibBUc2C3Sj6HoS/CDomZPnVMkjWGFsqFwTqZOj55P7FNNSZ/asM
 E/pLxjE+3Rg7Fdl95a3m/l6ovS0crpZU/vssU4RCC9qxPGEK2ngqwlBHXlvwKv5OkxBq
 OvykWvVtUfX40YW/k/sxqwSGdyp2fXfhjcpgck8++UZWr/2BvWs9A7s5zhMqYoJgM36b
 nFRzGqyOs2pdLJhVkqmXpUX1H9rmja5cii8QOTSxRCluHmoBp9gKB/jmoHkmfSfpyVew
 ayWQdLYN3nsWi4TnyWa6/hAyxukOgrh1+zxpdHoztm68V6DfZP4saT3rYo6sy0yQ6p4M
 9/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6JKlkgNd8+niuxiQtFl7zwwn5pD+D/CM0gMabRFM0no=;
 fh=zkIH7sm8MHsRpVxSKj0Cr4dlgZKRRuO64+TLJMaJ9Q4=;
 b=kZVlTCn6pRFBur8Hngk7QPdipa2l4n1r1K3xmPJ8cXEuaYEarpgtUzJfiLgcl/vylN
 SZRX3vB/T+MDqAwQOkMMHTQw+3QS0NTr6xLvy2E+75DEn64NzrPVmsSGeKOuAaVg+lSn
 Sj7Gx1nWkq1hH8i2DL4MSu44/b4z5E8k5fVpopu36SQBbrYn5gqSUkvF1DCV4G6v0P0e
 yJt2TJjxh2Vv3s5NMecLPIFrWlIQKn9xxKcXclc3f/wudsRCay1g6+M0lPo8QBvh+pqI
 zet8+GiT+l6ltCY4yY0YZx4zUtJqYsH9MEdwMBhq4alOCn9+UySjqOH3cqqAndPPwDHT
 XFkw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780039158; x=1780643958; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6JKlkgNd8+niuxiQtFl7zwwn5pD+D/CM0gMabRFM0no=;
 b=Ltc4YbpDQ+B+QmIRbSQjFJZheLw5bxk0rdBEb0jM4H/EJko7N+qaKEJadBl68v+hd4
 HE/AJ42ee2aDrUWICfmH5bHXHQWsEOxB0FXPesMYj/HngsfXB6uJ56CUo6ANrvRni8XG
 TXetRWBelVfh0UpgeaZnradJ95p+AY940aBPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780039158; x=1780643958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6JKlkgNd8+niuxiQtFl7zwwn5pD+D/CM0gMabRFM0no=;
 b=gh9NLAfcde4uxfwae16x0H68ZtfGiJmLYuaR9JoYAa4fCcMSivvO+fCnYzqQcZZamI
 If76jbBQd7WSqBCFDsJwMHBRTGm1Z6z8uw1b5mGD3vrupGlP7/mr2FaGZJd3XCxCiFDm
 p6J/VSJNkGHyi8wHtmGsyfUX0eBqieHnt1uZkjeOBXec3YTCoJ0Oy0BSlpxArcejSGWE
 4kqxEU8OCCUv7sGyArryN9J1uysbBTHmmbwDPDwUQE5F+hP+YfezGOrhx05JJZl1Nw1W
 39DhE3ePlDsCzPn/QWHT5+CMSQZB9iu+g5C5hAij0UEqcTdMjEn3x2KhpADa3fqxTWQ5
 qolw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9f4S7iSloxdznO+MXH716sZf+ZZIDV4nCuZgMlrMEE5OEnUEa9sDD4oHGU26or5QKXJMSL/aQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxCdazT4RcA7rSWFQgt8kQW8TdiKBVkcwodo4TszyK2AhglecRU
 GOWiUDu9hdzDYWDUAI1GRk2JtndUPRUy+46Iw1762PBMMbr++sLKD3/pBD4QZ0gkCk/2D3wJ6u6
 psbsfPb8TKJQVo32qWoiMMkyHtLdJm6UkkdM8Unez
X-Gm-Gg: Acq92OEF/VbiQUlbWPVGpPoQw0ULo8Ae9+pyAwEpQxl8WAhGqXojluXHy+uFQqMp14r
 yR/k/MPo2UHyP4/e4zOcHbq38ycizobnVP7xBF/CFNgJoh3JBdEWaHKSRkLsNwrvlVr6NXRqQsr
 +5bpfEGaaZy30P6MkOUiLbE2E6VFymMSNwGBfcq/JrL2ZeXtVvSKBdt5tenjC/ZbV5Wo10GG6Xa
 eIkRJ1rM51zOfr3/FKj9dLr05viWsdKWxhx5boX6fDS9fO7n0Xb2Z61TxKCWnjgHmv9iK1/6tWL
 IXZQGuwtbhrVZ6HO+eg=
X-Received: by 2002:a17:907:763b:b0:bda:3458:48df with SMTP id
 a640c23a62f3a-be9cd94bfabmr50445766b.20.1780039158054; Fri, 29 May 2026
 00:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260528081916.11355-1-philippe.reynes@softathome.com>
 <20260528081916.11355-3-philippe.reynes@softathome.com>
In-Reply-To: <20260528081916.11355-3-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 May 2026 02:19:05 -0500
X-Gm-Features: AVHnY4JgGup6sdZvHDme8sdlx1liIT9Lzkx0OMyL01VEh_K5-9Adp4PhG5uMA50
Message-ID: <CAFLszTirXh89ELGY=D1pzJH+dwg5LqDm8YOMNco2fxx-qzripg@mail.gmail.com>
Subject: Re: [PATCH v7 02/15] mbedtls: enable support of ecc
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

On 2026-05-28T08:19:01, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> mbedtls: enable support of ecc
>
> Enables the support of ecc in mbedtls.
>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> configs/sandbox_defconfig        |  1 +
>  lib/ecdsa/Kconfig                |  1 +
>  lib/mbedtls/Kconfig              | 17 +++++++++++++++++
>  lib/mbedtls/Makefile             | 17 ++++++++++-------
>  lib/mbedtls/mbedtls_def_config.h | 41 ++++++++++++++++++++++++++--------------
>  5 files changed, 56 insertions(+), 21 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

thoughts below

> diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
> @@ -122,7 +144,9 @@
>
>  /* ECDSA */
>  #if CONFIG_IS_ENABLED(ASN1_DECODER)
> +#if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
>  #define MBEDTLS_ECDSA_C
> +#endif // #if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
>  #define MBEDTLS_ECP_C
>  #define MBEDTLS_ECDH_C
>  #endif

Please use /* ... */ rather than // here and on the matching #endif
below, like the rest of this file

> diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
> @@ -62,6 +62,25 @@
>
>  #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
>
> +#if CONFIG_IS_ENABLED(BIGNUM_MBEDTLS)
> +#define MBEDTLS_BIGNUM_C
> +#endif
> +
> +#if CONFIG_IS_ENABLED(ECC_MBEDTLS)
> +#define MBEDTLS_ECP_C

The commit message is very thin for a patch that splits BIGNUM/ECC out
so they can be enabled without TLS, introduces new hidden Kconfig
symbols, moves several object files, and changes lib/ecdsa/Kconfig.
Please expand it to explain the motivation (preparing for ECDSA-verify
via mbedtls) and the structural change.

Regards,
Simon
