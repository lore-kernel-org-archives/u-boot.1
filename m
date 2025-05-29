Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6C1C5AD49
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 19:03:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABB3F82F8E;
	Thu, 29 May 2025 21:03:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Dy59puVO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 732DD83010; Thu, 29 May 2025 21:03:07 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B098A82B20
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 21:03:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-450cfb790f7so8004465e9.0
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 12:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748545384; x=1749150184; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T6wqx3ETv0jYNMa3aAVDSm+9y/c3+qZaOctBMUNTXzI=;
 b=Dy59puVOilYC36Ys2qtzQI/Ff8kXSpGpIkKbtl0c5cVEoWUmlXWex0YomKYdRv6e8a
 Kj2Q5t1tWqQ2OglfVdx1ibMGoypmAq9NJk48p/SEozla3Thh2SrGbBIEOy/U3QmewCFU
 8mkOorrZ0YlmsKb6TripKpEPY8UUXwdV9J56iXEskCLOhLJZz1Vl4ONQ4PnN2wfGh2Ao
 TGWdVUT6Nyr2BeYuihh8go38G43dqDX3SjIQHyEL1GVOfwAViRs/yQt2LEvCudvewnnI
 +rqGCa8cOH53ZBhH3EawmNnk7rDp1BNmL1KjD1ut2ASTvOkavA+WjW1MhZEsz4jrx68Y
 qHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748545384; x=1749150184;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T6wqx3ETv0jYNMa3aAVDSm+9y/c3+qZaOctBMUNTXzI=;
 b=LmB3NNqryeQSOPw5rbspBO9rMlExgSQUFlpliQOxK93ElJ6j+C33zqegBJdvsxiB6e
 ajmaJM5pGxISOQxnkx7aea6qB6c9ocqXJx4NNi9JbUgQBLGYQnaj282eket/83JV6Gd2
 U/2P0StC6hg3Ziw1/Skdnw1uZASk1SA9D4FUOChNhpgHt31/1c+TZjJ3U+BHY8gOlXat
 A6WZkJqA92KgCXJXy+/PKZaEGHFU8EZ0XTw/vw1N7G3AQoAgSnykSkq45sf89ffZUf6U
 hURA4aaWzy5KLIoFrMwalM2gzwk54148/FSdPdHp6PEriFvRonFiKVuBawmswwtMP552
 fJAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8HkNl6URWeD99TF7t3ns98d1GcB9whM2IFEajJ3oMBZ0dpYBPmFEH57LqOCnBwjWbRga2itc=@lists.denx.de
X-Gm-Message-State: AOJu0YxlOBZVYt3KSmYBgPu9uhU7wqmbTLFGXumjs20fNIan9ste+26G
 2WZJYotX4scY6+Olm+G17FZt9wqP4d2bN0uXG2HIKQNXuJqIZD84VlBVDNwUF/wQAYE=
X-Gm-Gg: ASbGncs7RUPue2WWB7rf++BcfCfH4sfx86tDksL2kxozt95bYwhvwXNbKvG1aEIRfs/
 1vEVTeQna3OpZeqKouvj32BQxJsP/xk7TSGXn7SHtiBj35zgzI2xhoh2qNwn6x9zgG2tNZwWfYR
 AMseLUOpNL1U+T9JH0LMm2K8diYJCTCgYBZVers7EsO2JKPR6ea/s9D2A8F+b0yU065eQI+Z75m
 jGRrzWqENxHClSWyba12RT4fnK4kmDT5OUjytV4wzihn1oR7+nX+Jd+1eTySHxEJQJVw+pQNBP6
 9qcB29r2mIBr5G4tF1bIznwA6zoZVKvMVyvkG514Hwco75Kg5AA22pCl+friQfY3wq24AbyqjfF
 X9wm7ADR+2rPfsRX3Xm6rTIWgCA==
X-Google-Smtp-Source: AGHT+IFdofzvvCw13g/HYag5n3vdD2PpIaFYZ8D11vSOL384it+KhxZ9m3rPXDFZz7Yucig5MtGEPw==
X-Received: by 2002:a05:6000:144f:b0:3a3:65b5:51d7 with SMTP id
 ffacd0b85a97d-3a4f7a72d8bmr334929f8f.26.1748545383946; 
 Thu, 29 May 2025 12:03:03 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:9bc3:77c2:6c71:775c?
 ([2a01:170:117e:fc:9bc3:77c2:6c71:775c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00a02cdsm2811810f8f.94.2025.05.29.12.03.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 12:03:02 -0700 (PDT)
Message-ID: <95052b49-dfdd-4a27-9c63-1f086d3bf23e@linaro.org>
Date: Thu, 29 May 2025 21:02:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] doc: board/qualcomm: document iq9 building and
 flashing
To: u-boot-qcom@groups.io, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 trini@konsulko.com, joe.hershberger@ni.com, quic_varada@quicinc.com,
 avromanov@salutedevices.com, michael@amarulasolutions.com, sjg@chromium.org,
 hs@denx.de, michal.simek@amd.com, marek.vasut+renesas@mailbox.org,
 venkatesh.abbarapu@amd.com, ansuelsmth@gmail.com,
 cniedermaier@dh-electronics.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
References: <20250513091710.3719292-1-quic_varada@quicinc.com>
 <20250513091710.3719292-5-quic_varada@quicinc.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250513091710.3719292-5-quic_varada@quicinc.com>
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



On 5/20/25 16:32, Varadarajan Narayanan via groups.io wrote:
> The steps are similar to other boards. Minor difference in
> the way environment variables are stored.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

This is superseded by 
https://lore.kernel.org/u-boot/20250521094442.3522036-2-balaji.selvanathan@oss.qualcomm.com 
I guess.

The rest of this series is fine by me though.> ---
>   doc/board/qualcomm/iq9.rst | 62 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 62 insertions(+)
>   create mode 100644 doc/board/qualcomm/iq9.rst
> 
> diff --git a/doc/board/qualcomm/iq9.rst b/doc/board/qualcomm/iq9.rst
> new file mode 100644
> index 00000000000..bc89f286add
> --- /dev/null
> +++ b/doc/board/qualcomm/iq9.rst
> @@ -0,0 +1,62 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. sectionauthor:: Caleb Connolly <quic_varada@quicinc.com>
> +
> +Qualcomm Dragonwing IQ9 Series
> +==============================
> +
> +The Dragonwing IQ9 Series delivers unmatched on-device AI performance for the
> +most demanding industrial applications, as well as available built-in safety
> +features and design flexibility for high-compute, powerefficient performance
> +capable of handling heavy workloads in extreme environments. More information
> +can be found on `Qualcomm's product page`_.
> +
> +U-Boot can be used as a replacement for Qualcomm's original EDK2 bootloader by
> +flashing it directly to the uefi_a (or _b) partition.
> +
> +.. _Qualcomm's product page: https://docs.qualcomm.com/bundle/publicresource/87-83840-1_REV_A_Qualcomm_IQ9_Series_Product_Brief.pdf
> +
> +Installation
> +------------
> +First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``qcm6490``::
> +
> +  $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> +  $ make qcs9100_defconfig
> +  $ make -j8
> +
> +This will build ``u-boot.elf`` in the configured output directory.
> +
> +Although the RB3 Gen 2 does not have secure boot set up by default,
> +the firmware still expects firmware ELF images to be "signed". The signature
> +does not provide any security in this case, but it provides the firmware with
> +some required metadata.
> +
> +To "sign" ``u-boot.elf`` you can use e.g. `qtestsign`_::
> +
> +  $ qtestsign -v6 aboot -o u-boot.mbn u-boot.elf
> +
> +Then install the resulting ``u-boot.mbn`` to the ``uefi_a`` partition
> +on your device with ``fastboot flash uefi_a u-boot.mbn``.
> +
> +U-Boot should be running after a reboot (``fastboot reboot``).
> +
> +Note that fastboot is not yet supported in U-Boot on this board, as a result,
> +to flash back the original firmware, or new versoins of the U-Boot, EDL mode
> +must be used. This can be accessed by pressing the EDL mode button as described
> +in the Qualcomm Linux documentation. A tool like bkerler's `edl`_ can be used
> +for flashing with the firehose loader binary appropriate for the board.
> +
> +Environment Variables
> +---------------------
> +* The environment can be stored and retrieved directly from UFS partitions.
> +
> +* Environment variable partition details
> +
> +	UUID: 71cb9cd0-acf1-b6cb-ad91-be9572fe11a9
> +
> +* Relevant config options
> +
> +	CONFIG_ENV_IS_IN_SCSI
> +	CONFIG_SCSI_ENV_PART_UUID
> +
> +.. _qtestsign: https://github.com/msm8916-mainline/qtestsign
> +.. _edl: https://github.com/bkerler/edl

-- 
Casey (she/they)

