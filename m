Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6411DCCA470
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 06:12:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7895183946;
	Thu,  9 Oct 2025 08:12:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SqPWbXHt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8568683948; Thu,  9 Oct 2025 08:12:46 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDEDC8393C
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 08:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-421851bcb25so260904f8f.2
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 23:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759990363; x=1760595163; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8fVoD5vpldm+hsggDzHrIJjMcE91uyP+iuE8Acz9e/k=;
 b=SqPWbXHtJuwe0qwAFI15ivQVEH6dpiEs5tDDsneeevL6lJPLEUW+xueqhUtVUPvNuh
 AGRbBEpboGnfbvgHcosY4AtMxBt9d35/xMeL1HnRYEG5ip4hFa1eiotccxCNAKInqXtk
 DdTAJUX9/gGD6ykXyINEk3Pq2Fz8Ql9MuUlBJfOqhvJekKBgyl7ZK+MSkPTigQupD+gh
 jzAXQb3zi8z1zQSwebgN4ca/wZYv2/nNWexz14bDJuuQLpCorDqalJxXPJkfIlStPPUo
 F/ju3icenQjdVIla192QRHqixg7pw4AhbqJclVB4HHFWEZVSlexRAyW9d3xg8MX51u80
 Zibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759990363; x=1760595163;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8fVoD5vpldm+hsggDzHrIJjMcE91uyP+iuE8Acz9e/k=;
 b=Yb6YCKa/Jn6ebafDKJ+wRz4hwot6Kgh4QQN1hsPrKq8BE4dncMEuxYhiQ6Aw/jvfRL
 tB03dZRLbkzeuBDXeBVXiuz37FVZPt9YlnJLF9NDswt7/6P8EQ7jVbCz/ED8issRNGeW
 6gLUEx519QZremuepufBPCP82YdMtgYgVC6GCZNCGoYcCyLsxZy0XyZk9WX8y1XKawOc
 6sc7RJ3qlgaoIOOnqjL4k+GFpO3lWhT/2+ZgqQjCYOfrYrH870QXQv/+p0c1i1mP2MzP
 U314T//UEANKLjly3jtls0Pe3xJyP83WlWLte/SIsZCNQtKxBDSQW90HkGGWG4wQT+bG
 BVoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxb9pAk+hmH5qXVS+LnGb1UamO/svc/egHX5Cjj+iOCc5DKFZ530hTvF3ECiSAGNx/jzXg06w=@lists.denx.de
X-Gm-Message-State: AOJu0YwQpMnp8dMC3t8TwBhmsboAmyLa0vCEUuinUSELJUQO7nC5qwfY
 ml5zHemEWNqZkdnoMVMDn/8vSfHKbKDnIT5oZUCFsu6VfJGMtc2NtNMqaBPgGkQAm7H+w2lBjuG
 j9oxK
X-Gm-Gg: ASbGnctuUk6HjRFSg5HCnIihyj4yDC20nhaJqzO1kTqD/qqjaTP5i32y6HakwNYVNkc
 ZzSZ59ZNJl2g/SWYbH54jIKOLhN0vlNVw3u+RrrdjR17J5STIyZZugnZUBgkS0crdIDgNYh0Gaf
 NymfCcusqenzUBENw6U79Eg+Aa2krTSNXGCK+nNvNbFBioMgtGqTqyK87j0mx//xCbcl+2goN8E
 hOdJmHnqtKRb9mWUZOXfWusPMGryz5VMAO28nMXqgxXTN4mWlD2px3vHfDU3C/Q+gHzBl2JY+NC
 yy27b9uzSNkKILqi2nPTIXOKxRd3bUGlvPk5tTZsToM7txw1eCofcO7/C7lr3U/jsCqw4wCglvv
 BaKduN4NSPyPUoUr6ugRVQS9bAQ4AJ0Et+JWvIpxYJLdbckD4Zk+guHokS3HhFj/m3Rks
X-Google-Smtp-Source: AGHT+IFaDC1SxcpxjnDLriRTh/2GUY5Xa9EXyuVPJq/FdS/nfsBPzZmABUS/76r9E52zounFZBOh/g==
X-Received: by 2002:a5d:584b:0:b0:3e7:610b:85f6 with SMTP id
 ffacd0b85a97d-4266e8d8908mr4592306f8f.39.1759990363213; 
 Wed, 08 Oct 2025 23:12:43 -0700 (PDT)
Received: from localhost ([95.164.180.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9890sm33285228f8f.32.2025.10.08.23.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 23:12:42 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Oct 2025 09:12:41 +0300
Message-Id: <DDDKIIEGKFEW.13JEXMATMUFW@linaro.org>
Subject: Re: [PATCH] tpm: Make U_BOOT_DRIVER entries unique
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Tom Rini" <trini@konsulko.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.20.1
References: <20250925205623.3562621-1-trini@konsulko.com>
In-Reply-To: <20250925205623.3562621-1-trini@konsulko.com>
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

Hi Tom,

On Thu Sep 25, 2025 at 11:56 PM EEST, Tom Rini wrote:
> All instances of the U_BOOT_DRIVER must use a unique name or they will
> lead to link time failures due to name space conflicts when both are
> present. In this case the driver was reusing the tpm_tis_i2c name.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  drivers/tpm/tpm_tis_infineon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tpm/tpm_tis_infineon.c b/drivers/tpm/tpm_tis_infineo=
n.c
> index 30f23f8610a3..c1e7b98295c5 100644
> --- a/drivers/tpm/tpm_tis_infineon.c
> +++ b/drivers/tpm/tpm_tis_infineon.c
> @@ -626,7 +626,7 @@ static const struct udevice_id tpm_tis_i2c_ids[] =3D =
{
>  	{ }
>  };
> =20
> -U_BOOT_DRIVER(tpm_tis_i2c) =3D {
> +U_BOOT_DRIVER(tpm_tis_infineon) =3D {
>  	.name   =3D "tpm_tis_infineon",
>  	.id     =3D UCLASS_TPM,
>  	.of_match =3D tpm_tis_i2c_ids,

I somehow missed this=20
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

