Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177821125851
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 16:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 881EB83FA4;
	Wed, 11 Mar 2026 17:25:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L2zmGh8O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5300E8407E; Wed, 11 Mar 2026 17:25:22 +0100 (CET)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF1238352B
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 17:25:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64c9f7576d4so54314d50.0
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 09:25:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773246319; cv=none;
 d=google.com; s=arc-20240605;
 b=K5jiMgWhZN6jO8eFUdv9L0yGYfABs/ijICsUqL/QJylzsYNgmAhHtoQugWIb2myRTW
 7265DL84WaW7KlsIzUJpc3aF7MTcqROOjVw411th4Xj+LalNRrQQ2cH10yrhdMV67Bcj
 ark/V4NXDHlnCloIyH4q45UiRgtxpPK2hpVY5b6b/dtVk9Mm59ycURFk3Zl+9PneAyt5
 0dBZqXyUFkFRCTQRhxpJe2zh5BM0F24abdMeIp+0r/hyfH0m55guTHCaCqRrW7jMW1xB
 TYEex8gUomNl7hbP8sespj7hvKogc7mp3I1m3GZdfQujymYj7m/MOGRdzIi+uUGW68hu
 Aw3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zuqZM8jkZJgQGU66j1DLdjVPeSFJ+GMcUyvuWi8esFY=;
 fh=qVPXZENsT8HTjc1yhpZmugGERdHloY1MZQ2O3ZL3iu8=;
 b=MV3oKxvhJK7DTCEH7D5wp1Fo+kwJQnzc3patUFsYx3++0IsISqAj96JmuV9f4GO/Yz
 g7aQX13pcpGn+5GloiQy53py/1yVb8n4ENsw3ucdkjf1SWClKj/IGvBAhe4kbGTE0HSr
 NHFAX+qcwZyp2xHbmcGpY2CXI3zfjmsd/bFzBUJj6LfX7yh8f7S6IB/f6wlQMQOL+GAT
 XrHhq9RDQTrEQ5/MtBaR2tOeKAKaDYr70hCZoTpiQRjOaNqKgH9BLpuxAfoJTUHP77Dd
 WXMDnrGTWXUDFMw2ukY6P+p+fGivkYVXaFODZ3znkHRy4hh3ooXNZjw2womgMnQKbtNT
 7SNw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773246319; x=1773851119; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zuqZM8jkZJgQGU66j1DLdjVPeSFJ+GMcUyvuWi8esFY=;
 b=L2zmGh8ObzocBS2Bc4IWLlZRk+31mC6cm/Auhg0BUoOBIHmi35kIfM+gNv+v9SSTIJ
 lek3h843CQwSSRq4dwHVyAUaSasjLiWkt6uN96IykzWbKJ8B0aN9Akq5fK3IPvzhrUdG
 8Mpzi6mRtFchP8E7944NECrwOnjsFRueLgH1qVO72npwGzyFVozgEYStmfof5CKGutBG
 7DdAVR5n1oT8+stgARZAGaZYoXdYkPNb5I6K5kscYNGPzaWpdoIGXA7zGPpHxgLQonZO
 dbCWYkufb9lHtqc56EaF+GMIj3q7lDNrFEN59qO5GxC7KZayba0VLMwoCd49blm1F5lB
 nt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773246319; x=1773851119;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zuqZM8jkZJgQGU66j1DLdjVPeSFJ+GMcUyvuWi8esFY=;
 b=BMLQR9GnDdPa46KZMqAru5KB2xcvDjZK1Eyte1JBLEDL5T8Hu5eRt1IIQyR4tvSmmR
 /wT+TIoU8t49DJb4IPi7G/qLDtdI7Z2/bEhKR/VjIiNlT2yrLym523Xuq3P/VbBEfUBt
 jB2mbLZyqL3WRrVQ78gic+qib0WPeV/FYgu4cE7FB1+BxysYzHWwU7mh8Y6IvsGUqcSu
 uIIrGXOZlAl/yRWUVRsFQixnS6hgCLSv+Eipw5sOkKP9tCmInPeZ4HNeojcDxxLIdYDz
 siWRO0fDopFOM+nw7tvC8pGgIXGWYcQ4jX0IxHxwsIbcXawQ+E3lEJX9H0HPVzJsngcG
 jOFA==
X-Gm-Message-State: AOJu0YwUA71AiRZkCvT3hjZn3QFID2FvZPiEhoiNzuOy/LJYE7ALvn4o
 BuOdvkuyo+CbLSbN3jA9Ke+pJoYIcNfwMGiDm+ocTZaKYTfg1m18ZC438gYqIEdUQWPFwn+tiHN
 9c4KmnnoF+8hM/BNrj2leo4vBFUlOt33WL6F/qLq4HQ==
X-Gm-Gg: ATEYQzz3xB18MaQeTu1j/a4zHyJoAkFG7X+ivGcE5xfgKatL+lg53NHxfvaABj/C3/p
 tsSu0HcaooU/GYVxNbKK1dqIbfUzT3JeCDzeVclPfc3FEXJ15NlfaObPqZXNa/Ifpfg/TWLUBol
 HQJR/yrNiNY9mRe19YnpZkkIHeeAfJjZ11m6NQoeLHz67JQHYH6zoKQp1RYI/hd/ez1HVuF9gvu
 /lrtgxEcilu3aehFYCUts8kdxEI6+aeM+Eyje+1GZ2P9UENoGiJLMYpMXvQO3IHQRrBwLFCgcUj
 c0a4udZdw/ITP2B77eelH4DDQmOFQN09W9AeZ3X8C2m3zsqFtaPuKU0MfVH3GK4kY7wIFYbH6J4
 CZ8beoG1s/HnNuhgzLBVbbAp+2kt7TC4Ka1w1aUADyQBEVsbsA1slaVJL60oRtLIObyxpDCRqgQ
 5wIzIHF1HMPz4zV8qg6+ns+43LG4lYoqxScdI8SrQ4dgFcagmVy4XS61OOF6R5dbX+0PBoLQZpi
 JgTMg7SJgQkwNyuPXdJTIr+ZUB3ZQKNjoD4FgJo7LR5H1t77Aoz0jH2ytlWQi/M8zkh5jiU3H8S
 mOuFA2ZXhIZ3YyAkUBKGxZjZBbcO39rBkBmMKO0kb0b91WqfiPkr
X-Received: by 2002:a05:690e:1409:b0:64a:e799:1d92 with SMTP id
 956f58d0204a3-64d657ea500mr2564798d50.61.1773246318531; Wed, 11 Mar 2026
 09:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260305161349.2317130-1-vincent.stehle@arm.com>
 <20260309163638.2340548-2-vincent.stehle@arm.com>
In-Reply-To: <20260309163638.2340548-2-vincent.stehle@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Mar 2026 18:24:42 +0200
X-Gm-Features: AaiRm53RXRKjbVATetSCgTQdmqSROEtobBRKCdQn1v6i5z4hG0F1Biq7bNvft3s
Message-ID: <CAC_iWjL8na_JuE5p87mMh45EpKGPNznZU0JA-X3qzJLjj10n1g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] efi_loader: export efi_ecpt_guid
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
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

On Mon, 9 Mar 2026 at 18:36, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> w=
rote:
>
> Export the ECPT GUID, to prepare accessing it from more than one location=
.
>
> The C file containing the GUID is compiled only when CONFIG_EFI_ECPT is
> set; gate the export accordingly.
>
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> (No change in v2; re-sending in the series for consistency only.)
>
>  include/efi_loader.h             | 4 ++++
>  lib/efi_loader/efi_conformance.c | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 3e70ac07055..0ebc80e0af0 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -387,6 +387,10 @@ extern const efi_guid_t efi_guid_capsule_report;
>  extern const efi_guid_t efi_guid_firmware_management_protocol;
>  /* GUID for the ESRT */
>  extern const efi_guid_t efi_esrt_guid;
> +/* GUID for the ECPT */
> +#if CONFIG_IS_ENABLED(EFI_ECPT)
> +extern const efi_guid_t efi_ecpt_guid;
> +#endif
>  /* GUID of the SMBIOS table */
>  extern const efi_guid_t smbios_guid;
>  extern const efi_guid_t smbios3_guid;
> diff --git a/lib/efi_loader/efi_conformance.c b/lib/efi_loader/efi_confor=
mance.c
> index 2d31800ccb8..470141af483 100644
> --- a/lib/efi_loader/efi_conformance.c
> +++ b/lib/efi_loader/efi_conformance.c
> @@ -12,7 +12,7 @@
>  #include <efi_api.h>
>  #include <malloc.h>
>
> -static const efi_guid_t efi_ecpt_guid =3D EFI_CONFORMANCE_PROFILES_TABLE=
_GUID;
> +const efi_guid_t efi_ecpt_guid =3D EFI_CONFORMANCE_PROFILES_TABLE_GUID;
>
>  /**
>   * efi_ecpt_register() - Install the ECPT system table.
> --
> 2.53.0
>
