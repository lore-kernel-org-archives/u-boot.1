Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B27BE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 05:49:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DECF8954C;
	Fri,  6 Dec 2024 06:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q8AbsldA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4105289579; Fri,  6 Dec 2024 06:49:02 +0100 (CET)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0477389540
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 06:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4afa4094708so407217137.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 21:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733464139; x=1734068939; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8wgtpYj+eilLVa6PJvff9JzDdtxa2RSjFt/AZ9XTZQ=;
 b=Q8AbsldArpOGkKjAUZpzG9FdZYDUQehnNtCjF1ZxPApBRZYZZ6SKoT2fltGd4lPK1c
 V222Jld3hz6erw0gRVCQUDU5j+Zik1cL/ou90FrbLUo86bjmQyqoB9LewjF4fxHMLm7p
 nAwgschIY7XZSOsjhnTuTt9Nlz1cryKkBVyf+4SIDY6t+nTXOCVRzFbLorCyJ5WLBj2u
 u6kKVkN5GmjVLyfeGtUcEsf3PRrSn5KAsG5od8DfC1DaC90pCj2WU9kUqqWfIc1R36TM
 d3S+4tExLaDMCEYfda1gxOIdH4a5w4hvJxRQs2AiTAC2Q26tmRXb7iJ2vJdl3noI+hr2
 JJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733464139; x=1734068939;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l8wgtpYj+eilLVa6PJvff9JzDdtxa2RSjFt/AZ9XTZQ=;
 b=KfA33rCOc3jVqRvetX9h2P60Ok8nK0vn6yaxQX2MueRZcMVEMrxIUe/DxifpXOGR7B
 SaQ1lo0b94bpqr2xsnhjxmISj6UJYvDIiLumQHwy0Ku3aZPFucFsMK5o35G2PngxEF6V
 8ImUwI2taCdytLEMv1aOlUa9FhmBmliAIG5ILzDGKQKovrkWcXTXSMDfVujhkt3mM3Iw
 GUC1puj/ITZnTT3Qdpqw4dzHByfaQuqLxHKmXQHcSorXpR96iJyUehiV697ZFSPYCMVt
 TRBoerwgPeOuHbKpx2mZMh84p9d+Mw55vXo5Rd/1sYZEZZ1hi6g4fpV0JuMCF+hlqzuZ
 FEUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl0M9dk3YpKs5Pg13syi7tKj2lbqB+nfJjuZkLrhLwfRKISIT5rsub0AJhRwUo8kBFy7wc5Lg=@lists.denx.de
X-Gm-Message-State: AOJu0YwCg9dZg5xHhm7EBN9ZfekIzwBOOzr8jw68u7bZs1g+9jQI5nZX
 bX2vEhWV/VlCR6OHN/VuQodnx+PFLi3CkYOtBhLzX/vEJ1hOnL2+lO9T2KsinOkrwGnarjUjTwD
 nc6X2BanKKfBYYfWusGdUV1x4R++swKN2mR1I6g==
X-Gm-Gg: ASbGnctXSTzmSEMr7cbtnoBeJG7immsuyM42DFh7R3N0cXqyRJNVALhdSmRlj2N/PcA
 vxFP+dNbYdZBfeuKtZS+6AOmFPIAez2x1
X-Google-Smtp-Source: AGHT+IGmFXTaiYfeKCAFLZEAxN6wIzkJpyEcFNyO2jbtJos9KYjb3BHcKkxt+NoaJ/hgJe2O+4F5SU7Uxkz/f4FVZ7Y=
X-Received: by 2002:a05:6102:6c8:b0:4af:aa56:8065 with SMTP id
 ada2fe7eead31-4afca7372bbmr2597783137.0.1733464138793; Thu, 05 Dec 2024
 21:48:58 -0800 (PST)
MIME-Version: 1.0
References: <20241205-upstream-dts-v1-1-5a6bf6ccdfc4@posteo.net>
In-Reply-To: <20241205-upstream-dts-v1-1-5a6bf6ccdfc4@posteo.net>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 6 Dec 2024 11:18:47 +0530
Message-ID: <CAFA6WYPQg6Z7vZZf17sS-C99oDs8dsBjuCbENv0pGTdrW3b_Ew@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Support using upstream devicetrees
To: j.ne@posteo.net
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Thu, 5 Dec 2024 at 22:52, J. Neusch=C3=A4fer via B4 Relay
<devnull+j.ne.posteo.net@kernel.org> wrote:
>
> From: "J. Neusch=C3=A4fer" <j.ne@posteo.net>
>
> For new PowerPC developments, it will be useful to borrow devicetrees
> from Linux. This patch makes it possible.
>
> Signed-off-by: J. Neusch=C3=A4fer <j.ne@posteo.net>
> ---
> This may seem hypothetical, but I'm working on a new U-Boot port for a
> PowerPC board.
> ---
>  dts/upstream/src/powerpc/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/dts/upstream/src/powerpc/Makefile b/dts/upstream/src/powerpc=
/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..721ec5cb229e2a8ae57e90c94=
07f86054fcb7ad9
> --- /dev/null
> +++ b/dts/upstream/src/powerpc/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +include $(srctree)/scripts/Makefile.dts
> +
> +# Add any required device tree compiler flags here
> +DTC_FLAGS +=3D
>
> ---
> base-commit: 98dd010b311e68b8398428cadf56a6381f7de202
> change-id: 20241129-upstream-dts-9a1eb4524b53
>
> Best regards,
> --
> J. Neusch=C3=A4fer <j.ne@posteo.net>
>
>
