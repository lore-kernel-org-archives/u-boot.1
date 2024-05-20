Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDB4C04FFE
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 10:00:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 867D4886AE;
	Mon, 20 May 2024 11:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="psFQWj93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EBAB886A7; Mon, 20 May 2024 11:59:44 +0200 (CEST)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A226886AE
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 11:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-47f03844ea3so412348137.0
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 02:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716199181; x=1716803981; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1ytUNpLRQwO1DH/fMub3VJr4hkKsy0etWVjGBPVACdc=;
 b=psFQWj93TpfqFDQjEojm4QZkRsxaOFBNKYXQWEqy6hSOzPuc46tMc4Ompr8WIGs6q/
 B1Yi6WX9Vw6L5XMJq/kY+mvShgRWmxc/JTBfwGEMSosagMN5IFy+l24/RpPC1CrrzxSr
 B/2E615GR7pSNBqO5Oc2AHXhDvNC6GZ5rJQjRFyzo2NDH6QnWOKyxDyWRZltWuxVs5M5
 zQCDAvBxacdPCaIiLOp+HtyPzb0YIkCnudwQJ7EpaWj9wt+fYawXWJUMWPkFC8ERdkz+
 5m4LE2SlsCzcgmLhf1Xc4Ep/ounpKi8uKfME3PTU6Gs7PhHQaoaq9FkKWuxAO6jPE/NT
 2Lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716199181; x=1716803981;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1ytUNpLRQwO1DH/fMub3VJr4hkKsy0etWVjGBPVACdc=;
 b=czcdf9kQj6JxO9QkrY4CONB61AEklOQPa4fOBL28kKNYNqyzFTGadDpLQ7tk4FpRJ4
 2tWjEi9zBAVskSu8BQCTnATjk1EnO/vRy4Xa+T9rEDu29DuqbJjJRJtNmJ7epaYsvoat
 Xh25gX6muxg2tsnT44DD12iz47fWHDTat7NWo5CROSFH/X/26PsXu2Bm4kxK36l4T9XR
 8A9c+QDlYbOEvB4r4XqgcSxR56gv91D9cvBHx4KJNeg80tPJT5KnUCCvEMGWNZ/PdAfi
 adwrUe+GOgMLt6CC2UK8Qam3ZW/b5UK2RUzZMltEKwG1tCrw24Mg+EbWyAcLiQWC7Tul
 pWfQ==
X-Gm-Message-State: AOJu0Yxye+vltcKNUIvFeAijAsr419/Cs3ZxbU9aEYEW1UYW5txH4E6B
 U1VfQ3mh35VgRbKTQ/lK1PdOm5GZW2B/KJm2QJob3sTGpWIJCUN8aVdoxyFp2Cs2uzVFt1IJyr4
 WeyDaMMmFE/po3Sf8LowmbGb8TwWN/QsBrdCL2U57adZvPj8vv5A=
X-Google-Smtp-Source: AGHT+IHY7yyD/das1bUbiWEKqK8pQh0oDtFHRJuPV6jnILrNIYEhdrB/+CbI5QKY65pC1bMRHUwpvqjk3qvq6Dj7tHQ=
X-Received: by 2002:a05:6102:370a:b0:486:6998:d773 with SMTP id
 ada2fe7eead31-4866998d8f2mr10222664137.9.1716199180503; Mon, 20 May 2024
 02:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
 <20240519-qemu-xtensa-v1-8-8fff0cb11c19@flygoat.com>
In-Reply-To: <20240519-qemu-xtensa-v1-8-8fff0cb11c19@flygoat.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 20 May 2024 15:29:29 +0530
Message-ID: <CAFA6WYOcypO9YHdJU0gcOWZgcEXNG3Yd=4vCPVnRQ8BE4tO=yw@mail.gmail.com>
Subject: Re: [PATCH 08/10] dts/upsteam: Add Makefile for xtensa
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>
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

On Mon, 20 May 2024 at 02:24, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> It is required to get it xtensa OF_UPSTREAM work.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  dts/upstream/src/xtensa/Makefile | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/dts/upstream/src/xtensa/Makefile b/dts/upstream/src/xtensa/Makefile
> new file mode 100644
> index 000000000000..2a81acb32bc3
> --- /dev/null
> +++ b/dts/upstream/src/xtensa/Makefile
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +include $(srctree)/scripts/Makefile.dts
> +
> +targets += $(dtb-y)
> +
> +# Add any required device tree compiler flags here
> +DTC_FLAGS += -a 0x8
> +
> +PHONY += dtbs
> +dtbs: $(addprefix $(obj)/, $(dtb-y))
> +       @:
> +
> +clean-files := *.dtb *.dtbo */*.dtb */*.dtbo
>
> --
> 2.43.0
>
