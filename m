Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD7DC4452A
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 13:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13855838D7;
	Mon, 20 Jul 2026 15:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HKKDly/r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6103583E76; Mon, 20 Jul 2026 15:20:07 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EB9780517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 15:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4954a2e73a9so18721455e9.3
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 06:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784553602; x=1785158402; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CkFPp5FpU19LTgH2MSTEMS4eKP+IlL0hKyWdG6v9LKE=;
 b=HKKDly/r23o9gS6ybXAiHrFWz+e3cYuV1/4e4as/xoZdid+2F1I76ZyQF0r4quP9ZJ
 jlkdu655j490wA/2ZjocVEcKgvvAcXtNqB9nvemhiL7kfSZw1OcJ9hWUrxZMH02LPS2U
 x3v0mMuhRlILWNweZSgkRNCuadLu45ngwuaXxqUY3xtgE+/zHVIx8+CI4oH14+PPH7sx
 SiQoRMyaTeH7U5Tjl3qMncyQ9pgrf4Vgl3RN5ZlKPRLDRi4TjVsz4s90ewolP6Yfwom8
 nDWOcDpAkQ8/6D4Uja+TjDuBjlqVY/tutkjv/F98vOFstDTeGklosDRbIx7n8zDZGWBN
 +uCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784553602; x=1785158402;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CkFPp5FpU19LTgH2MSTEMS4eKP+IlL0hKyWdG6v9LKE=;
 b=PgSEci2wkm5W+DMeILqF38RCRXVvWd7DrxokVs6OCNgbB+f59BBT/EKX6tTCQpeCsC
 SfAIp1uYr4ctCR+Gt9f26rnEiKKke3MyByW/yI7IALCvw8316vP2LTe2g3GJUv+FslFz
 uWQB5XHTEYSGSGdZNcJnGU24fy7BS4cdvs61orIJx6ZL9AkP4zVYIOpq4Q3PWNzcSdB/
 j0dRFzYiswMEuyhacYswFkRXJ0nOzQ8dY62932mz45xNPUdj+0zf6bCv1uDKhEm1P9DX
 AqqxoYbuPfrC1590A1jtQQz9w5nf/4k3jy64ZwUS5Wi7ERc11zK12kjSlhv0se4URhKr
 V7MQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpICM2wRhtWRJvbEjU10NMSBRlPKlU3PmG6E554+hwztV8zczCgeRo7x7d041+ga0/7Gqc4Qgg=@lists.denx.de
X-Gm-Message-State: AOJu0YxFDQHuJNYWyYDJxpR/D5onkNpOA0XjQXCCn4Su34FNEmGF/G0+
 m3pM4GWHsQ6ITvg1XUSR6ZUyLIRLzy1fBOgeTYcrkWEA1j9wX56sPddubQd4uUiP93k=
X-Gm-Gg: AfdE7cmJbxG5m0Isri0xPsL0bzpoj2kDmGz6eklRe01fm0gdtV/197g1Y7YlgC9tK7N
 /fZ/WEzRKjcuKBJK3rdRJubckV5pQEv+ZtE9m8qMpc9Q0g4/r8ZJBpEnDbPk26eS6qhZRSrh4XG
 f01ZnT8fQ13ECXXHEVOHb5AC64OvCLmo1jaZYO84nxrCIXkQUL53G3K6ubMuuY6wLlu+h5nzZEi
 KkR3nGpl2GY/2VKPkEHMNZTUdcecqHJ9dDaCcfse5ux8hlZFMwxxnyWJOEe+eT84rc9l5OQh6RL
 oEKfUgaf2ptgRL4ggPEyrK6OoiUwGx1+VsmszurXXmYk+OIcvcdNFvW8mZw0plb95Nh6/wrMpv2
 gauLcaKb0YE6soL9GVQ9AuY/h5lq+OSAauvebpKpoGLmWMDvdeTIGwGj3Zdpv18uCFcLrCGR9d2
 47xd1cS003VTd+10MzTx3DAT9SVD01Z5KAeuOS/Zq8JHg7/gSBlw5m4ukykBY=
X-Received: by 2002:a05:600c:1911:b0:495:4fd4:619b with SMTP id
 5b1f17b1804b1-4954fd46219mr122237835e9.1.1784553602196; 
 Mon, 20 Jul 2026 06:20:02 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1d11:1101:a3b4:4010:a727:b812?
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955dfa81b2sm55357465e9.4.2026.07.20.06.20.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 06:20:01 -0700 (PDT)
Message-ID: <9d437ed3-aacc-4e36-a49f-aa7f2931a468@linaro.org>
Date: Mon, 20 Jul 2026 14:20:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] doc: board: qualcomm: document SM8550/QCS8550
 building/flashing
To: William Bright <william.bright@imd-tec.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260720-sm8550-hdk-v1-0-84f077937303@imd-tec.com>
 <20260720-sm8550-hdk-v1-1-84f077937303@imd-tec.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260720-sm8550-hdk-v1-1-84f077937303@imd-tec.com>
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

Hi William,

On 7/20/26 10:52, William Bright wrote:
> Introducing documentation support for Qualcomm SnapDragon Gen 2 SM8550
> and QualComm Dragonwing Q8 QCS8550. Documents the build and flashing
> steps.

Thanks for sending this series!

Do you think this could just be folded into dragonwing.rst? We're sorely 
missing some nice broader overview of the list of supported 
platforms/boards, but since there's a lot of overlap here I don't think 
we need to duplicate the instructions.

Please also rebase this on qcom-next from 
https://source.denx.de/u-boot/custodians/u-boot-snapdragon and add 
CONFIG_QCOM_GENERATE_MBN=y to the defconfig (instead of 
CONFIG_REMAKE_ELF), that should actually spit out a ready to flash 
u-boot.mbn.

You should also be able to drop patch 2 since the memory map should be 
parsed from SMEM automatically.

Thanks,
Casey

> 
> Signed-off-by: William Bright <william.bright@imd-tec.com>
> ---
>   doc/board/qualcomm/index.rst  |  1 +
>   doc/board/qualcomm/sm8550.rst | 48 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 49 insertions(+)
> 
> diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
> index 3238a68e859..de5b24dd463 100644
> --- a/doc/board/qualcomm/index.rst
> +++ b/doc/board/qualcomm/index.rst
> @@ -14,3 +14,4 @@ Qualcomm
>      iq8
>      phones
>      rdp
> +   sm8550
> diff --git a/doc/board/qualcomm/sm8550.rst b/doc/board/qualcomm/sm8550.rst
> new file mode 100644
> index 00000000000..200420dcaf8
> --- /dev/null
> +++ b/doc/board/qualcomm/sm8550.rst
> @@ -0,0 +1,48 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. sectionauthor:: William Bright <william.bright@imd-tec.com>
> +
> +Qualcomm SM8550
> +===============
> +
> +The SM8550 (Snapdragon 8 Gen 2) is a Qualcomm mobile SoC featuring an octa-core
> +Qualcomm Kryo CPU and a Qualcomm Adreno 740 GPU. The ``QCS8550``, part of the
> +Qualcomm Dragonwing Q8 series, is a child SoC of the SM8550 that drops the
> +RF modem. As the two SoCs are otherwise identical, the same
> +``qcom_sm8550_defconfig`` and flashing process can be used for both SoCs.
> +
> +More information can be found on the `Qualcomm's SM8550 product page`_ and the
> +`Qualcomm's QCS8550 product page`_.
> +
> +.. _Qualcomm's SM8550 product page:
> +   https://www.qualcomm.com/products/mobile/snapdragon/smartphones/snapdragon-8-series-mobile-platforms/snapdragon-8-gen-2-mobile-platform
> +.. _Qualcomm's QCS8550 product page:
> +   https://www.qualcomm.com/internet-of-things/products/q8-series/qcs8550
> +
> +Installation
> +------------
> +First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for
> +``SM8550``::
> +
> +   $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> +   $ make qcom_sm8550_defconfig
> +   $ make -j8
> +
> +This will build the signed ``u-boot.mbn`` in the configured output directory.
> +The firmware expects firmware ELF images to be "signed". The signature does not
> +provide any security in this case, but it provides the firmware with some
> +required metadata.
> +
> +Then flash the resulting ``u-boot.mbn`` to the ``uefi_a`` partition on your
> +device with ``fastboot flash uefi_a u-boot.mbn``.
> +
> +U-Boot should be running after a reboot (``fastboot reboot``).
> +
> +Note that fastboot is not yet supported in U-Boot on the SM8550-HDK, as a
> +result, to flash back the original firmware, or new versions of the U-Boot, EDL
> +mode must be used.
> +
> +A tool like bkerler's `edl`_ can be used for flashing::
> +
> +   $ edl.py --loader /path/to/prog_firehose_ddr.elf w uefi_a u-boot.mbn
> +
> +.. _edl: https://github.com/bkerler/edl
> 

