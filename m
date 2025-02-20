Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A91AC021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 20:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7923780EC0;
	Thu, 20 Feb 2025 21:46:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XsTf9o+r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 175A380F56; Thu, 20 Feb 2025 21:46:11 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95917806FE
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 21:46:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso14315025e9.1
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 12:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740084368; x=1740689168; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+V7UDwvwWdMdJrUNdAy8rDS5aBpBIQGgMEOZvF2QfjM=;
 b=XsTf9o+rwa5OBEG2aXDxEvDE0vNHKZewsCsT5dau+Nj9H67EN+NFyn3mnHTLeMd+No
 h5rpudIc3CWGxpGTkj6BYQKYTnauO6fp/4zlLbb7v4cWeVsJTC/HJ/ECRkMkvKEXCxaI
 aOXiYmoe/2RwihCOgObgyCQIOVZW2Zlq/SyQykxWo8Ln2Kki0h0kA22zBFiia26lh0yp
 0Mx6ZX1X+RRQYQJGoZh6cza8gcBKv643I3FuGIj1Df0zWN8W1JOktKtIBs7x7NqXQH3C
 R2ctheD0H70KGxTi80eNHHgmfrw4vm6zYNxbKyMS2Qx2leH3zFzpt5C1RwK7gawgnypr
 4Keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740084368; x=1740689168;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+V7UDwvwWdMdJrUNdAy8rDS5aBpBIQGgMEOZvF2QfjM=;
 b=vNqMAgz2GAAwR3UOpPV7wzlVdVR19+s6kJUDaYm/pw484Ppnro/wSURsyYUlneWi+i
 n9t//5l/IDT87EcjxFCmXRPWNKZEag70ofYCm4dL9dJBwF1z023ZaeeypjLUHfQaJ/iT
 Wm/rNscMD5nO8m3XCb6n/Bn/JA+fw7W8OJJ0ohEl84tLdvPR6b6fi+pPzpp9/DZc794C
 EOcqAzV3YiYynfXs4lA2t/DXBy4Irjl/H+dPrd25gZsh0HMZRV0Iw6L/RzsBw47k8rq/
 0fGdpL8fSDtqqtgp6x1CT51tIEriymWqq2xjvZzFRhBgGQqh7MjXJqI36ZWBOU42RBrn
 i9Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvWP+mv6LCYFw/6Nmp7wX7esdIQQpyR6pDPTD/7UVf0rYyfZz4F1yVlz754UI1PYHA1emRSek=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/KZ6sk5DJc8GZTAm9OHoJdjPvI1cZJ974rc9TU0aNTXgDvzRC
 vCvyUNxg0jruqZfx3auhSUG7cT3GuMvOEGAB7dt31fw9c1UZ9nNQ/nMF81OL9WM=
X-Gm-Gg: ASbGncvvqUZirDZjXEIZKQZ7Yn5liOUxdafJpaNk2+aL5fb65CxVJXdC/Sh+jimgjWp
 9O78pY1VjQoleNhocsA8a1FaKIFe8XGPVygTSEFpa5m9+lGgldJP1nQjmQLFtECLrCQnQAFVRrz
 PfxwqKLKd1/5PMQ/tgTqcQOn+xLk1eRHoIgmH9tjY/aTiSCSwVUVmTZigz66DV45W4i/+N/AKCC
 dHtIi99UqQ1Zcf+L5AOqBP83evAwoAHlRRpP+i8ng3UvB0KY2NrYMpGwQMZ5GgpwQ4gCyi7uF5F
 Bz80WLUTVa3iNFTZPX8G6IRJIU3X8ErCVVqZiMcm7lM4vdP4R5G1qo2VgxFuUqP4lb7ipw==
X-Google-Smtp-Source: AGHT+IGk/G20lV9uQTlTVxpnb2IyP3S1LCzkyFN91bQCQeQ9GPC+NJ7+vxR1Ex6tG4RuJw8ffbhd2A==
X-Received: by 2002:a05:600c:474a:b0:439:9106:c09 with SMTP id
 5b1f17b1804b1-439ae21e03emr6192215e9.26.1740084367901; 
 Thu, 20 Feb 2025 12:46:07 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:56e8:1b9f:967:210a?
 ([2a0a:ef40:1d11:ab01:56e8:1b9f:967:210a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43986320899sm121805375e9.38.2025.02.20.12.46.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 12:46:06 -0800 (PST)
Message-ID: <3d7c57e2-215e-4c45-8226-eaf7705fcb98@linaro.org>
Date: Thu, 20 Feb 2025 20:46:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] doc: board/qualcomm: document RDP building/flashing
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, lukma@denx.de,
 seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 robert.marko@sartura.hr, luka.perkov@sartura.hr, Volodymyr_Babchuk@epam.com,
 sjg@chromium.org, lehmanju@devpi.de, pbrobinson@gmail.com,
 marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250220073937.133687-1-quic_varada@quicinc.com>
 <20250220073937.133687-2-quic_varada@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250220073937.133687-2-quic_varada@quicinc.com>
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



On 2/20/25 07:39, Varadarajan Narayanan wrote:
> Introducing basic support for Qualcomm IPQxxx based RDPs.
> Document the build and flashing steps.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>   doc/board/qualcomm/rdp.rst | 55 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
>   create mode 100644 doc/board/qualcomm/rdp.rst
> 
> diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
> new file mode 100644
> index 0000000000..fd14f1d982
> --- /dev/null
> +++ b/doc/board/qualcomm/rdp.rst
> @@ -0,0 +1,55 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. sectionauthor:: Varadarajan Narayanan <quic_varada@quicinc.com>
> +
> +Qualcomm Reference Design Platform (RDP)
> +========================================
> +
> +Qualcomm RDPs are development boards based on the Qualcomm IPQ series of
> +SoCs. These SoCs are used as the application processors in WiFi router
> +platforms. RDPs come in multiple variants with differences in storage
> +medium (NOR, NAND, MMC), no. of USB and PCIe ports, n/w ports etc.
> +
> +.. _Qualcomm's product page: https://www.qualcomm.com/products/internet-of-things/networking/wi-fi-networks/networking-pro-series/qualcomm-networking-pro-820-platform
> +
> +Installation
> +------------
> +First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``IPQ9574``::
> +
> +  $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> +  $ make qcom_ipq9574_mmc_defconfig
> +  $ make -j8
> +
> +This will build ``u-boot.elf`` in the configured output directory.
> +
> +Although the RDPs do not have secure boot set up by default, the firmware still
> +expects firmware ELF images to be "signed". The signature does not provide any
> +security in this case, but it provides the firmware with some required metadata.
> +
> +To "sign" ``u-boot.elf`` you can use e.g. `qtestsign`_::
> +
> +  $ qtestsign -v6 aboot -o u-boot.mbn u-boot.elf
> +
> +Then install the resulting ``u-boot.mbn`` to the ``0:APPSBL`` partition
> +on your device with::
> +
> +  IPQ9574# tftpboot path/to/u-boot.mbn
> +  IPQ9574# mmc part (note down the start & end block no.s of '0:APPSBL' partition)
> +  IPQ9574# mmc erase <start blk no> <count>
> +  IPQ9574# mmc write $fileaddr <blk no> <count>document

Thanks, this is really nice to have documented!
> +
> +U-Boot should be running after a reboot (``reset``).
> +
> +.. WARNING
> +	Boards with newer software versions would automatically go the emergency
> +	download (EDL) mode if U-Boot is not functioning as expected. If its a
> +	runtime failure at Uboot, the system will get reset (due to watchdog)
> +	and XBL will try to boot from next bank and if Bank B also doesn't have
> +	a functional image and is not booting fine, then the system will enter
> +	EDL.  A tool like bkerler's `edl`_ can be used for flashing with the
> +	firehose loader binary appropriate for the board.
> +
> +	Note that the support added is very basic. Restoring the original U-Boot
> +	on boards with older version of the software requires a debugger.
> +
> +.. _qtestsign: https://github.com/msm8916-mainline/qtestsign
> +.. _edl: https://github.com/bkerler/edl

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

-- 
Caleb (they/them)

