Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D36C54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 10:22:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14C8082FC8;
	Thu, 22 May 2025 12:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="po16r3Dz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A33D83043; Thu, 22 May 2025 12:22:32 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F279282F67
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 12:22:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-441d1ed82dbso79436405e9.0
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 03:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747909349; x=1748514149; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M8dzPlhmnbDJAHGZN2kjfIP8Zg7s5+LAIINw1n5GmLA=;
 b=po16r3DzaF0WuDlJdJSNFFPq8zE53CuUUrJdtZvm+xlnPhkGCzBMFoWUGjhR7vawRT
 tSzKfd6Kjtkhfr0JM1MYc23gStG/J71FBUlq4JI5EjC1ptvMomW3TTKwIPmFJgZj94+5
 yZoYK23+RDX/5I89s7+z0JwlaXQVpaJYXwSpxSuVMHWD5vrgs3TckTbpxkYqpfXm5jZu
 sCHztMCx6AeVdrWbRUoDh3G1+34UnFjONyeDoSYpixiAWxjJm2VS3u8O6YQrZlyhxnFy
 lRvGlLvcXlEL0cvzw1uoLwNAoVat6bk3rrQxnGXdEqPjF2P9okvAIdjyqOx3C4A91fEL
 9HvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747909349; x=1748514149;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M8dzPlhmnbDJAHGZN2kjfIP8Zg7s5+LAIINw1n5GmLA=;
 b=I3WLY9U9SorudJfKWKfM2/Uf5Y2+9Q8/XpwZKQZ63SRdBAAaQwvVGlWUmf57aUdm91
 xJyiysRDT7YrUziCp/2Hy6yCKQWsWkVnggtFNqw/TdfEBAuL43ZnPL8NqHp9bMNLjfT7
 Wv9DLTF/KwqsgZw5JX2J9sn4u6CZdu9zOyf4MzD5fvJK/payMaG4fJw7CpQg8ZOqrWiL
 OFsvxEdcfAcKB27DB/zOpQZGC8Tl3ln+O6AVpAjYlKXLr5Hl/8n9AuUbaLXYSF6WnSzl
 +DEB6YN3gAxzWi6tYm230AZJiFb3Nl9t3aO9jJ2D4AL/oZ/2tHedurT1zioeXw5Bb++y
 3WRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfJxnfaqosn2vuH7q/+2fh+LGBMzDfMBXemMKomxV8me38nW2m2EzvDm7agV6nREAoXXifSCM=@lists.denx.de
X-Gm-Message-State: AOJu0YwoftkO3NAcpuiXsgKfQxwD7Pt4lnRQKToqWo7NHbd9rE+4UEG+
 sHjGRR3ZoxdQj7SxixjSj5DLWeBp3dVxQhi2zYF0X0Jw71cqH9+4t0rE0TgnI0j3raY=
X-Gm-Gg: ASbGnctWPFB5w+Apy2ATFOV+rGbumyyaOmUpLydFWc2C1J54S4yjMkocaeCSedftBc5
 959cj8wX94yt2rRDoKN8N/1mZPxnOozcnrP6TYK+d5VK8KtUqLp6V/ZNMJMd/Vdm0xBCKiBRgM2
 EdlSFmtoN9lEzKuiuBRktWb1l0k0nz/nrAxODwxo4hNgu2ch9khTPyMu1RSlaa3U5T2SUE9eZ/j
 IwpjqGPGn+/AMsrMZe9LKz9SuVYRgoLciU0RtJ6e7tM1uaTRwnMlvsE6qNOXa/Bnig0flw7gQcr
 DdyxqaSWSmNP0MCFBC/KC4nP+UHV1HoYo+8nQdYf8L5kbT+UZsSYm9gViziCwLR/0xfv75DNOku
 GCdgQ
X-Google-Smtp-Source: AGHT+IEC/+E695GqUeMCPAgAjk2KRdkRcr2hUMuVKcf4l5TB/9//vbQmMH3BOy7D5wCwyk1CJXDIlA==
X-Received: by 2002:a05:600c:b94:b0:43c:e7a7:aea0 with SMTP id
 5b1f17b1804b1-442fe694699mr205998505e9.26.1747909349041; 
 Thu, 22 May 2025 03:22:29 -0700 (PDT)
Received: from [192.168.1.47] (i5E863A39.versanet.de. [94.134.58.57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f73d25b8sm103420235e9.17.2025.05.22.03.22.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 03:22:28 -0700 (PDT)
Message-ID: <43bdeede-85ac-4394-80c2-ae246ae6b197@linaro.org>
Date: Thu, 22 May 2025 11:22:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] doc: board: qualcomm: document Dragonwing board
 building/flashing
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 lukma@denx.de, seanga2@gmail.com, ilias.apalodimas@linaro.org,
 me@samcday.com, quic_varada@quicinc.com, sughosh.ganu@linaro.org,
 sjg@chromium.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250521094442.3522036-1-balaji.selvanathan@oss.qualcomm.com>
 <20250521094442.3522036-2-balaji.selvanathan@oss.qualcomm.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250521094442.3522036-2-balaji.selvanathan@oss.qualcomm.com>
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

Hi Balaji,

On 5/21/25 10:44, Balaji Selvanathan wrote:
> Introducing documentation support for Qualcomm Dragonwing series
> boards. Documents the build and flashing steps.

Thanks for adding this!

> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> v3:
> - No changes to this patch in v3
> 
> v2:
> - This file is newly added in v2 based on suggestion from reviewer
> ---
>   doc/board/qualcomm/dragonwing.rst | 41 +++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
>   create mode 100644 doc/board/qualcomm/dragonwing.rst
> 
> diff --git a/doc/board/qualcomm/dragonwing.rst b/doc/board/qualcomm/dragonwing.rst
> new file mode 100644
> index 00000000000..18788cd6167
> --- /dev/null
> +++ b/doc/board/qualcomm/dragonwing.rst
> @@ -0,0 +1,41 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. sectionauthor:: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> +
> +Qualcomm DragonWing
> +========================================
> +
> +Qualcomm DragonWing are industrial-grade boards that provides various series
> +of processors such as IQ6 (QCS615), IQ8 (QCS8300) and IQ9 (QCS9100).
> +These SoCs are used for factory/industry based applications.
> +More information can be found on the `Qualcomm's IQ6 product page`_,
> +`Qualcomm's IQ8 product page`_ and `Qualcomm's IQ9 product page`_.
> +
> +.. _Qualcomm's IQ6 product page: https://docs.qualcomm.com/bundle/publicresource/87-83838-1_REV_A_Qualcomm_IQ6_Series_Product_Brief.pdf
> +.. _Qualcomm's IQ8 product page: https://docs.qualcomm.com/bundle/publicresource/87-83839-1_REV_A_Qualcomm_IQ8_Series_Product_Brief________.pdf
> +.. _Qualcomm's IQ9 product page: https://docs.qualcomm.com/bundle/publicresource/87-83840-1_REV_A_Qualcomm_IQ9_Series_Product_Brief.pdf
> +
> +Installation
> +------------
> +First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``QCS615``, ``QCS8300`` or ``QCS9100``::
> +
> +  $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> +  $ make qcom_qcs8300_defconfig
> +  $ make -j8
> +
> +This will build ``u-boot.elf`` in the configured output directory.
> +
> +The firmware expects firmware ELF images to be "signed". The signature
> +does not provide any security in this case, but it provides the firmware
> +with some required metadata.
> +
> +To "sign" ``u-boot.elf`` you can use e.g. `qtestsign`_::
> +
> +  $ qtestsign -v6 aboot -o u-boot.mbn u-boot.elf
> +
> +Then install the resulting ``u-boot.mbn`` to the ``uefi_a`` partition
> +on your device.

The flashing steps here are a bit vague, with the edl tool it's 
something like

./edl.py --loader /path/to/prog_firehose_ddr.elf w uefi_a 
/path/to/u-boot.mbn

All the pages are a bit sparse in this regard, we should probably add a 
generic "edl flashing" page at some point.

As a final note, is the firehose loader for these boards published 
anywhere? Otherwise there is a major risk of bricking here. Could you 
include a link to them?

Sorry this is a higher standard than the rb3gen2 page, it also needs 
some improvements...

Thanks and kind regards,

> +
> +U-Boot should be running after a reboot (``reset``).
> +
> +.. _qtestsign: https://github.com/msm8916-mainline/qtestsign
> +.. _edl: https://github.com/bkerler/edl
-- 
Casey (she/they)

