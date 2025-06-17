Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A22C71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 08:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C905982B20;
	Tue, 17 Jun 2025 10:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GG+KnDRq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E47A82C4C; Tue, 17 Jun 2025 10:26:24 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD60281E18
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 10:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so45209225e9.2
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 01:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750148780; x=1750753580; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=lbrY4mIs112t0tDW9N00nEHoPaQi5tn9jAF0qzwJdkI=;
 b=GG+KnDRq7PngDFoNyndw6nn0Wtmt+0dzMNnu/fkJBBKOctaZdM478qZvIfJ+LbzgQ7
 tlT1RLKa55pOGV1LMIjdQEzhUpgNQRlMV+OYIMr3h4j+EBMzRo8Ao5qVIdSs8nipDzNq
 ZO3fjqjoPrUjFdLiYRZb6VedV4059r5xfiZlqqKRrDY12BXIIHDNZFwajHQ/lAZcAnhX
 mFJO7dHMvBMT10h8Z9st2TK4r2di/cv1oVhS2Ea5JxNExx8nzro6aWJRt+B2fL60DFAw
 1mCBeT1Avg25kluCcMiPLrDOjpHBN/zBnNHw1J2iQyrBtxBM6BlJ+ei8r5ljV127cJT0
 gM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750148780; x=1750753580;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lbrY4mIs112t0tDW9N00nEHoPaQi5tn9jAF0qzwJdkI=;
 b=XoZeGuCfTf3KWNdrhwXs+qTHz8D6OXTQ5cdIPqp4YKssgHdvGuqgFNsDXhrF7KWroX
 2s9zMiPUCjZyGprvE2PWeyYcDqAwXW2KG4UMvVwrf1E2owvfcsK51oyan4+EdGorxHEB
 ORpDQWhOYpVcuRYA133zH7a2ZEic351hFoJ8fqE6QabcwUW0ToW9Sy5AChlNAK5OTAJ4
 milOAionYr5c3RwL4KsaY9pS181XOZAz2ppQ9oJP9VcxU05bWVcaLwBmJE5a4WyyJTQA
 9W3t8WOsIL4/KmlxEcrXtkECS0c9qg2vRBLWVwavxXJH5I5FjB2v8KVk2PucMdhiifCz
 NMNg==
X-Gm-Message-State: AOJu0YyCq2883a870fFhBhmdztzN3KiO5x5LpvExro8a20lZTUEYR4l6
 4LNcVUR9b/MaDuVZMxOv2DS3HTWlU/HCQoOucS9+zYiNrRRk1QdmECz42JyD8QtthF8=
X-Gm-Gg: ASbGncuUciLKgERw7cHHhgGnZQ/lkA0il9hCbRxPa4zjP1JvKiwW/9tERIifUYjAk7Y
 /p0K0wY0v9h5wUSwKQOVCtBaMI9an7rImt8yQ9sTXJaAPfd0xfcaIFMioC9MdLS+ap0QhKgB+Ob
 JjnhP/ckEaiYY5GwXxzHGaKwFebYrGmRpdaIQLciEFqPdNLWz+qFtfzy49LOX4oH5RKPb6nu7Qp
 RD+XEhWfluAPua/IP6hXkb7LqXvHy/O4aFS1J4RuCBXEbewvi2dRDNkbcPaNF70gMoxSOa5yg5z
 1nvhVJ97F83RETNwKb+ObX8kl8lH1ELZkEx+Wl++cKsUrWvDwQ0Aia13o7roJ2GJjlO4KcifLgT
 U/6CFOBRoj4h4AmjyxwenatH3N6Ynx8cSfTd0JJs=
X-Google-Smtp-Source: AGHT+IGL9x/9dEWLpZUioufCYkFQ/F1OqbU/6TEG9vXMWsGH8ULhp4QmZKgZIqU76XVnK/tuOvYTOw==
X-Received: by 2002:a05:600c:b95:b0:450:d012:df85 with SMTP id
 5b1f17b1804b1-4534b4d8ad2mr61493585e9.18.1750148780039; 
 Tue, 17 Jun 2025 01:26:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3819:3250:4f73:db31?
 ([2a01:e0a:3d9:2080:3819:3250:4f73:db31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e172b03sm167292895e9.36.2025.06.17.01.26.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 01:26:19 -0700 (PDT)
Message-ID: <6da50198-445e-4e50-b2ec-97a385c5b2eb@linaro.org>
Date: Tue, 17 Jun 2025 10:26:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 0/8] Qualcomm: teach the build system to emit signed
 ELF images
To: Casey Connolly <casey.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
References: <20250613-b4-qcom-tooling-improvements-v4-0-7ea1c68779fa@linaro.org>
 <aa490fb0-e485-4227-8750-70c66c308bd5@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <aa490fb0-e485-4227-8750-70c66c308bd5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 16/06/2025 18:13, Casey Connolly wrote:
> Hi Tom,
> 
> So I've been testing this a bit harder (really should have noticed this sooner) and it turns out using binman makes things a whole lot more complicated...
> 
> Specifically, the new trogdor chromebook board doesn't need binman, the U-Boot ELF is used directly since they have their own bootloader beforehand.
> 
> But since CONFIG_BINMAN can't be enabled in a defconfig and only selected by some other Kconfig there isn't really a nice way to handle this. The trogdor board doesn't add any Kconfigs of it's own and doing something like
> 
> depends on BINMAN if !CONFIG_SYS_COREBOOT
> 
> would be a huge hack...

Can't you change to depends on BINMAN if CONFIG_BINMAN_DTB ?

> 
> This wouldn't be an issue in and of itself, but binman makes the build fail since of course the DT doesn't have a binman node and the trogdor defconfig doesn't define CONFIG_BINMAN_DTB (and shouldn't have to...).
> 
> Possibly the easiest solution would be to allow defconfigs to set CONFIG_BINMAN, or add some additional kconfig we can use to pull it in (CONFIG_QCOM_BUILD_MBN ?), maybe the latter is the most comprehensible solution.
> 
> I think I'll go with that unless anyone can chime in with some other suggestions.
> 
> Kind regards,
> 
> On 6/13/25 19:23, Casey Connolly wrote:
>> With several new Qualcomm platforms appearing on the mailing list, all
>> of which build U-Boot as an ELF, sign it, and then flash it to some
>> partition on the board, we're getting a lot of defconfigs which just
>> contain a debug UART and a TEXT_BASE address. This leads to needless
>> rebuilds in CI of effectively the same image, and needless duplication
>> of build instructions.
>>
>> To address this, let's introduce a new tool "mkmbn.py", this is based
>> on the existing qtestsign[1] tool but is (currently) hardcoded to
>> only handle the Dragonwing and IPQ boards which use MBN header v6.
>> Additionally, the tool contains a lookup table that maps from a boards
>> DT compatible property to the load address it needs. Since it's highly
>> unusual for different boards using the same SoC to have different load
>> addresses, generic platform matching is also done (e.g. "qcom,qcm6490").
>>
>> With this tool in place, we teach binman to use it and introduce
>> a qcom-binman.dts file to describe the image. The tool will emit a
>> u-boot.mbn file for supported platforms, for unsupported platforms the
>> u-boot MBN etype in binman will print a notice explaining that no mbn
>> file is built and to look at tools/qcom/mkmbn/mkmbn.py
>>
>> Finally, the defconfigs are cleaned up by moving the debug UART
>> definitions to config fragments (since it doesn't make sense to have
>> them enabled by default anyway) and remove CONFIG_REMAKE_ELF. Notably,
>> the qcs9100_defconfig is removed entirely since the same binary can
>> be created with just make arguments. This platform entirely lacked
>> documentation to begin with, which should be addressed by future
>> patches.
>>
>> The Qualcomm documentation is also cleaned up, a new "signing" page
>> is added to briefly cover the what and why of MBN signing, and board
>> specific pages are updated to explain the new build process.
>>
>> These patches have been tested on the RB3 Gen 2, but additional
>> testing for other platforms would be super useful.
>>
>> [1]: https://github.com/msm8916-mainline/qtestsign
>>
>> To: Tom Rini <trini@konsulko.com>
>> To: Neil Armstrong <neil.armstrong@linaro.org>
>> To: Sumit Garg <sumit.garg@kernel.org>
>> Cc: u-boot@lists.denx.de
>> Cc: u-boot-qcom@groups.io
>> Cc: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> ---
>> Changes in v4:
>> - Rework how qtestsign code is imported to make it easier to sync with upstream in the future.
>> - Actually raise an exception when mkmbn fails in an unexpected way.
>> - Link to v3: https://lore.kernel.org/r/20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org
>>
>> Changes in v3:
>> - Fixup Makefiles and add missing qcom-binman.dts
>> - Adjust wording to reflect changes to build process
>> - Link to v2: https://lore.kernel.org/r/20250602-b4-qcom-tooling-improvements-v2-0-c7d19c0d4a8b@linaro.org
>>
>> Changes in v2:
>> - Reworked to use binman with a plugin to build the u-boot.mbn file
>> - Added some fixes for binman to work with OF_UPSTREAM and with tools
>>    in the srctree toolpath rather than objtree for out of tree builds.
>> - Link to v1: https://lore.kernel.org/r/20250522-b4-qcom-tooling-improvements-v1-0-8141b8955cfb@linaro.org
>>
>> ---
>> Casey Connolly (8):
>>        binman: add $(srctree)/tools to toolpath
>>        binman: support building binman dtb when OF_UPSTREAM is enabled
>>        tools: qcom: introduce mkmbn library
>>        tools: qcom: add mkmbn.py
>>        binman: add support for building Qualcomm signed MBN ELF images
>>        configs: qualcomm: use fragments for debug UART
>>        qualcomm: use mkmbn via binman and stop creating ELF files
>>        doc: board/qualcomm: update docs for new u-boot.mbn target
>>
>>   Makefile                            |   5 +
>>   arch/arm/Kconfig                    |   1 +
>>   arch/arm/dts/qcom-binman.dts        |  16 ++
>>   board/qualcomm/debug-qcm6490.config |   5 +
>>   board/qualcomm/debug-qcs9100.config |   5 +
>>   configs/qcm6490_defconfig           |  10 --
>>   configs/qcom_defconfig              |   2 +
>>   configs/qcom_ipq9574_mmc_defconfig  |   1 -
>>   configs/qcs9100_defconfig           |  10 --
>>   doc/board/qualcomm/index.rst        |   1 +
>>   doc/board/qualcomm/rb3gen2.rst      |  27 ++--
>>   doc/board/qualcomm/rdp.rst          |   5 +-
>>   doc/board/qualcomm/signing.rst      |  29 ++++
>>   dts/Makefile                        |  19 ++-
>>   tools/binman/btool/mkmbn.py         |  29 ++++
>>   tools/binman/etype/u_boot_mbn.py    |  53 +++++++
>>   tools/mkmbn                         |   1 +
>>   tools/qcom/mkmbn/cert.py            | 127 ++++++++++++++++
>>   tools/qcom/mkmbn/elf.py             | 238 ++++++++++++++++++++++++++++++
>>   tools/qcom/mkmbn/hashseg.py         | 281 ++++++++++++++++++++++++++++++++++++
>>   tools/qcom/mkmbn/mkmbn.py           | 154 ++++++++++++++++++++
>>   21 files changed, 981 insertions(+), 38 deletions(-)
>> ---
>> base-commit: 783f365c9dbb5c9e9341753fbad6a44dcdc7a069
>> change-id: 20250522-b4-qcom-tooling-improvements-ab40585b11a1
>>
>> Casey Connolly <casey.connolly@linaro.org>
>>
> 

