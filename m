Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F12CD8C92
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 12:22:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFA4D84704;
	Tue,  9 Jun 2026 14:22:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w9nC9HkG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F6EF8484C; Tue,  9 Jun 2026 14:22:13 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1F38846D3
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 14:22:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bec405a6ea5so785852066b.0
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 05:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781007730; x=1781612530; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lilbxl7w+LYWPnSmk/kEeg46V7c98ovLaHJlUoSz02E=;
 b=w9nC9HkGRb5fSokbfUmC/4+SPcI0bhRYnOhMOasj7g4BA6FV5BtGQtPJ7bltc8c4Vf
 RC5QiN9DbR9I7g/27Wxl47gqQ7+FHsmLy/PmsGdaMykf/kzgVnxpEpyLLNQ9+zkM8LV4
 m8l8LVG53bj8hbQSpclnq4R2FVWKxxzIaMU8IBgbBP0qzq57ADqcjSk5nbGKaSB1OE5C
 h5N7qr/H12I/0WUAm6V+e6u39BMaIgF7KUTuxgp/Bx4TYsJqORgTkiHeKa16DCKE0HcF
 J4K6IgUkWk5yT0xJr+8R6AAwqD8DZ9XIKdY+uatzHy5fdgIpjVfnRgNNbqjNITlOPe32
 5S6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781007730; x=1781612530;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lilbxl7w+LYWPnSmk/kEeg46V7c98ovLaHJlUoSz02E=;
 b=mdoxoZUVNS0LJGzYU1U90nvxDXrStQmEsppvCxPESTa56XpwCrWr56K3dhRZ3mIYoI
 vLWL8WVgwUSZjG++OT4YUnDoatKGZlYnQ4oOVx0ioggDz49EmiV1yrhTZrxicKro3Rcn
 geMEjwTPoRkBDuv5+1GrxF3UJ/DfLtPI+fbyLi+TbXQhWQXxOOLlRVTH5Rx1tLmDp9us
 urShni0OYtiZKQsRtuvxCPfQGGxLGjtZYhI8lmRtsrG+Hpjkq3i1Bs6qMSAXCWUNXdOq
 GPZFhrdZer7n2pw65c0PdWtIt2pb1fPM+ZUfwEH/5OA+3GcuPijgAcdq5uo8R8NTPPbZ
 hqng==
X-Forwarded-Encrypted: i=1;
 AFNElJ81v8+aE0TIxVrr3dJuKtmK4yFZwD8EsUJg4hn44i4I2Etnwht08E22HGUVyQGErp81KEcxqEU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2QwDZOHSuVqgxf0f6CtoVUsijR89VltBj8S+u+NJnQSAl+cxC
 hBDUZkk11ZEU1GAbcORkWPArjWqkZwl3cP3sQNF25Z537d9quWvigKXNai3fsJdR9yQ=
X-Gm-Gg: Acq92OGzzoyhR3h+RPBPpm9PCdX+p8DoWZbmje13wrb0EKlaItN+we6GuAGsZ6K6KCA
 92L8QFab+RF9w/rXLGNPOcyjDKDecwVO7Uh4JJ+AIV+KMMF6OONDw3kPQX8aE8g+hDCNuo4EDMA
 hG8vy7kz5gR1wXLyT4otALwE8FiIpczbewNDvAGnV/cOOEyvlEeHqcSlSHbgF/m3P3X0ccyBTGj
 EJ1ga+O2Pnqs4oYip9Oz6Cd7/kHvC7CLlIS6VRfncQ9sWah8///Gw+QarMMa5Tab4ivOMPJRA4n
 gebGaQNhskJqG7l+Jr+N4WJ6QiG9BwpjiKgZARO3LUebA9rUHvvX49ywBUJkdsW4vTpc4MZp0sk
 /WVCE8W31ZuVpvua8dDOjK9e2GNbf0tB5DOhojLxKmVQuTh3NwbI7adO094vEeTXeBVzFY2GXA7
 46Itpo7JHT2butdLZcpuQ5HkvNOldlI7F33evz2qmaXHgnYt40RvlLqWCRKVkB9bLHITFDZWxwD
 A==
X-Received: by 2002:a17:907:1ca9:b0:be9:45e8:1767 with SMTP id
 a640c23a62f3a-bf370c61226mr1105287366b.19.1781007724076; 
 Tue, 09 Jun 2026 05:22:04 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf054dfe3aesm1031218666b.37.2026.06.09.05.22.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 05:22:02 -0700 (PDT)
Message-ID: <237a99e4-49c2-4f5e-9e10-5b3ffbbbc282@linaro.org>
Date: Tue, 9 Jun 2026 14:22:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: talos-evk: Set USB controllers to peripheral
 mode
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>
References: <20260519-talos_fastboot-v1-1-6908b79ffccc@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260519-talos_fastboot-v1-1-6908b79ffccc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Balaji,

Sorry I didn't see this one, seems it wasn't sent to the qcom list.

On 19/05/2026 07:17, Balaji Selvanathan wrote:
> Override USB dr_mode to "peripheral" for both usb_1 and usb_2 nodes
> to enable fastboot and USB download functionality in U-Boot. The
> upstream device tree configures these as "host" mode for Linux
> runtime, but U-Boot requires peripheral mode for flashing operations.

There are cases where Linux might boot using U-Boots DTS, we don't
really have a policy on stuff like this but I'd probably suggest using
OTG here instead (and specifying the default role of host), that will
allow fastboot and once Linux boots it should switch. Obviously you'd
generally load another DTB for the OS but we shouldn't make that
assumption to justify changing stuff like this for U-Boot.

> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  arch/arm/dts/talos-evk-u-boot.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/dts/talos-evk-u-boot.dtsi b/arch/arm/dts/talos-evk-u-boot.dtsi
> new file mode 100644
> index 00000000000..74c3d37e2d9
> --- /dev/null
> +++ b/arch/arm/dts/talos-evk-u-boot.dtsi
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +&usb_1 {
> +	dr_mode = "peripheral";
> +};
> +
> +&usb_2 {
> +	dr_mode = "peripheral";
> +};
> 
> ---
> base-commit: 38dbe637c9dfcadbd1bc201bfbb27f96b2ad525a
> change-id: 20260519-talos_fastboot-d9fe9351692a
> 
> Best regards,

-- 
// Casey (she/her)

