Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093A4CA0EFC
	for <u-boot@archiver.kernel.org>; Sun, 24 Aug 2025 13:34:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D80B82FC7;
	Sun, 24 Aug 2025 15:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XNHmfayb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C76483071; Sun, 24 Aug 2025 15:34:23 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3341F83020
 for <u-boot@lists.denx.de>; Sun, 24 Aug 2025 15:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-61c51f57224so614212a12.2
 for <u-boot@lists.denx.de>; Sun, 24 Aug 2025 06:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756042461; x=1756647261; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ny5npgVRt+tr58NgGLBX2EmLPuQ+xco3xdIxbuv4nfs=;
 b=XNHmfaybKXHFOaabNg6VbUNJ5Ra2Bj2pKWYG+Q2C8WFTu08dbDoEus0vbnwrIkjv3x
 F4ejE76VjyKWdo3VaavE99ua5mnnE2Hx6hL3PaaKmL6zpicb5Kv+VcnROu5TeylOkaOn
 2YCSP7iLeHZn+9ffM79h5ypQNwEvysD3jZtICooPmtE22GOiqUsL/9cg1fsMLKFAekGn
 D9eVtHk1CVSKLzX9QMMTpR/Slpb38ibMepE4s9y9VUIJluUlW+bLx7JNjGU9IImneQHH
 D2o7Ez72Zp4Qva6/cM73Neo8uGFaTg7YDszSQ4IWuoMgvahx55fi5BYAWss+TNNb89B3
 oMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756042461; x=1756647261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ny5npgVRt+tr58NgGLBX2EmLPuQ+xco3xdIxbuv4nfs=;
 b=vInNCnyQ5zZToRMkajFz8OCXnNny4F6E4N5dhfO+VIbLAkE6av9pd3rRDGqkp1Q/8u
 lbEMuqXEhS5D9nZZx7QEpHVUsaAcK6r9twUp4+DIgbGoN/aH9pWFxSVDxvBnW3LYj+TA
 2okFbmim3ab82Wkvv5PNVKzCnDFeT9c6t8Z032vSEDBCr9pqp0RaKNROixXUOlK55smI
 kDCBTfhxX8tmcLuUL6npgvzC/cP+zFuaz+sA1U8dolQHoxIMBTvyyiy2krTJd+GjP1sX
 +N6OXPH+gmgccuQLQIuA7/cI0Y4VOVQwc/XIIbOonYRADjwWEkLN1kWOKoS8221TxifD
 47EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhnTc2WeR8CUUdGInXiF7O2SJ5XKxvQ8gvIVyjwirfFNzrmWTz7EmTLDUPf9sMYxFQOALJxMI=@lists.denx.de
X-Gm-Message-State: AOJu0Yxo1YvKp64Y4JFplag4bHjm5rZ6mLwKTUquItEpKvtc0BwWHUWt
 qPk4bppypaO36SKYCkZvdPqVq6DrGk6WvfHC6abgRxz9hdnZ5FjYa5pSu29LAk+Zy7EHNT5jWKE
 xhBn29uvg59Y222k8sZBd0+7x08K6Bdw=
X-Gm-Gg: ASbGncsPpAQuuHhq8qZEnOpIppokcBO30pzCexV/ye4HMH9i8WaIEVzRaKQlIsMTzUZ
 0LhsfndOPPA0Cn/gAy7hycitFKxMLsZ6JWpgcJ6AQjHULJJ9IBzRtH487cvvKlnIVxWlp6u0UIY
 JKfb7XQSoenEribErA33iX2BMh2zPYPKkOsMziZjseNTwHSWRdbsL0B3dL034e4DTIiIIppckni
 r58yw==
X-Google-Smtp-Source: AGHT+IH9/ar7iaKNULx+6Vhyof6SMaJq60GXZo6qKqtEe8VpjZpd4yAvGC1t4ZPwdE1yY/jTKh+U0EYWo9/K1965eeM=
X-Received: by 2002:a05:6402:a0d7:b0:61a:7e43:662b with SMTP id
 4fb4d7f45d1cf-61c1b7095a3mr7828704a12.27.1756042460422; Sun, 24 Aug 2025
 06:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
 <20250822-b4-exynos-power-v1-11-9e2f2f740029@grimler.se>
In-Reply-To: <20250822-b4-exynos-power-v1-11-9e2f2f740029@grimler.se>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 24 Aug 2025 19:04:04 +0530
X-Gm-Features: Ac12FXzKujBKFq2W_tD_MvoKksa1C-7Tjfx4dzDMeSR9PHyXx-FOcdixnOCytmE
Message-ID: <CANAwSgQqV1LZVoWr_Fwbj7+CRO749P5AE+FThrY=5LPjwOanwg@mail.gmail.com>
Subject: Re: [PATCH 11/11] board: samsung: odroid: drop exynos_power_init
To: Henrik Grimler <henrik@grimler.se>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 David Virag <virag.david003@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, u-boot@lists.denx.de
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

Hi Henrik,

On Sat, 23 Aug 2025 at 00:33, Henrik Grimler <henrik@grimler.se> wrote:
>
> exynos_power_init sets up regulators for the emmc and sdcard, but
> these regulators are already marked as always-on and boot-on and hence
> are handled already by the regulator-uclass. Since we currently try to
> set them up twice we get error -114 (EALREADY) from exynos_power_init
> on every boot:
>
>     LDO20@VDDQ_EMMC_1.8V: set 1800000 uV; enabling (ret: -114)
>     LDO22@VDDQ_EMMC_2.8V: set 2800000 uV; enabling (ret: -114)
>     LDO21@TFLASH_2.8V: set 2800000 uV; enabling (ret: -114)
>
> Remove the superfluous exynos_power_init to silence these errors.
>
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---

Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand
