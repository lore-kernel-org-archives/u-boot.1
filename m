Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612D9C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 10:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2FF082917;
	Wed,  9 Apr 2025 12:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="GcOW3N0C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 090E4835FE; Wed,  9 Apr 2025 12:27:41 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECFFC828F8
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 12:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so45099995e9.1
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 03:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744194458; x=1744799258; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=AdEPNAckHV+/R4fL/z2rI2w0viOdmERl4RSX+96vfAE=;
 b=GcOW3N0CXI20RRcInF/rQI4K/l6Cxkyy5V3dg9zhEFkh/WsBIr6YJs/ICTuuxAh5Qy
 0Iww8FkunTS4agBpMiNINixnLKL3PTkW8tz6n0dift7vCBELwphgD4apesZAM1RNkcoe
 QtnJiARVcz+Inw4xY0zNsRLcAJteAvx23H3b0z9xQja9OkjPMkP3XOXNvC3kTxvWxNmO
 OMpIH+VSzuxxFzD+t6UhlpoForMxrHleX6mCYm0dgCjbG6faTozIs6mBdK5A3jWHyy1b
 wAfD0xKc9qkmS4la8E9Fb4DUPP/egIscMzCMEaJ6R+Tux9bBzATHw7pxYYekBzy4tuNR
 a/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744194458; x=1744799258;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AdEPNAckHV+/R4fL/z2rI2w0viOdmERl4RSX+96vfAE=;
 b=hhfDyqpFeFEgVOLedDD+MkNt5/gDztMrHxSqExt7KVCCCiMob/lST3CeJ18J8DqVDm
 eQJNJ/t/wrhhIwFSABWe/xU4famPywfxh5mBqlWgsT0joh8WKjQybZzUz7a6wXvQ0Jjl
 BKvCRWS6wR9x6BwhNUX4T3s/oSy0dpoEaAaHbW6n/a5Q5SoceIWqK6Fe1D62Tw2M+gZe
 +C4pWNR1kptBob8iYQvob1hjKY5yQhI8MRR/G02tnuY6xRtKKY2i/+PYdUl7bk5FPeFd
 KGVvmIjvhHi5H4+MV8u4jkzLBDe8KUq7q4d9zRL/AvdDGRXl5pq7xX+objp2sa4G3lWt
 c64w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVKiNKfp8WiKGQkVmXAJemiO0CR51arXgnlMv0gQ6XLrS3NbRP/4Dl6jB0U3Jm3YeB22rMnMs=@lists.denx.de
X-Gm-Message-State: AOJu0YyvrSim5u1cLAl1Fxf+LR8ybEPKQB8dgvXoh7Tjtbe6oCXI+I86
 2KcMEWnFs5wKzYn7z5XYLZIrNr208YWEzONfEQwhYohdspPNbiaS5Isdlzetnyc=
X-Gm-Gg: ASbGncuZByCcmfLjAGb9C/TZnzF4oIdbBYGZYcOjxfRaTOTxj7AHAGeAGfrb2TSSlWy
 sQHbZ7k/3IkdIiBXaJuG0FmDHC/d7vjKzxSpORBsD1CUqCZRvbPIFsfAvq5eao+Sb2NidCpZixy
 eeN1FbIBAsGCuiuctIzDFhmpK1ho2yIra9yuIolXsAof3mkIwO/et+OJk5Q2vS15pek8g3kCWDQ
 5jy5O0zia/J8gWdZhF6+xkR2n079IXE65bj36XMQ4LWGqqvu+j/xrwyij96jvfL+NfBLYd8pnNm
 HUgExVxPvr3N3Os1dInK6iMtcSWY2QJE+HfFtQ==
X-Google-Smtp-Source: AGHT+IHdeHKywxtVp4Ypnj0YPdv/MqY4AUXged713VhZlbA+QrBH2eh3ebDEJ2M99xzFbxKHZSR5+A==
X-Received: by 2002:a05:600c:1f89:b0:43b:cc3c:60bc with SMTP id
 5b1f17b1804b1-43f1ecd6b3amr24272525e9.15.1744194458340; 
 Wed, 09 Apr 2025 03:27:38 -0700 (PDT)
Received: from [192.168.2.177] ([81.0.8.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d8938a83esm1207485f8f.47.2025.04.09.03.27.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 03:27:38 -0700 (PDT)
Message-ID: <17c7d897-6275-4f75-91c9-13c40b7ffc1c@suse.com>
Date: Wed, 9 Apr 2025 12:27:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] riscv: dts: jh7110: add DeepComputing FML13V01
 device-tree
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 E Shattow <e@freeshell.de>, Sumit Garg <sumit.garg@kernel.org>,
 H Bell <dmoo_dv@protonmail.com>, Simon Glass <sjg@chromium.org>,
 Andreas Schwab <schwab@suse.de>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@linaro.org>
References: <20250409071836.26629-1-heinrich.schuchardt@canonical.com>
 <20250409071836.26629-3-heinrich.schuchardt@canonical.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20250409071836.26629-3-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 09/04/2025 09:18, Heinrich Schuchardt wrote:
> Add the u-boot device-tree include needed to support the
> DeepComputing Framework motherboard (FML13V01).
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
> v3:
> 	no change
> v2:
> 	no change
> ---
>   arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)
>   create mode 100644 arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
> 
> diff --git a/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi b/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
> new file mode 100644
> index 00000000000..ab882d07f6f
> --- /dev/null
> +++ b/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2024 StarFive Technology Co., Ltd.
> + */
> +
> +#include "jh7110-common-u-boot.dtsi"
> +#include "starfive-visionfive2-binman.dtsi"

