Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8F1CCF9EA
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 12:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A00480422;
	Mon, 27 Oct 2025 13:51:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fuV3jGW8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0250A82A9E; Mon, 27 Oct 2025 13:51:41 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2F4D80107
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 13:51:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-427015003eeso4157115f8f.0
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 05:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761569498; x=1762174298; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=c6mMYkgW9dG/bnvSd/mM36BSthz9BC2zB2kCwY58xXY=;
 b=fuV3jGW87vWLfdGFnyidU+hA+zI4eXnm5sK1acNugZzJwXeirJBMieMdKirZY3PxMK
 +DVHafZQ2gLBztdWgk5UPLIzFXYwwcx+8iyYhk4VrUXU7LZYAr4rhU35+OZnZ8HMuFWi
 /79IPEjXGtYxUeBxCK+entdpiwqMOcFpz3OywMAT8e6MOr/5cDFUtQbe1qwL2nC7WPGJ
 44NMBd+IezDCXsAJ54hLdfJm3f60Z2MjXR0wLtmbF4k5gMmfsLJhSpdx2SoVi868stto
 VLywYzRQq2wUrVFBV6dg7sc0XnTzeymks/myF5eHKvY6mnyve53AQeld4nQNpt0h5xfT
 oUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761569498; x=1762174298;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=c6mMYkgW9dG/bnvSd/mM36BSthz9BC2zB2kCwY58xXY=;
 b=e3SPUIcp3HzbA2FmXs+nb49ySBqv6jwfAlPT/3RHHmNKn76naP7gIMp09B0gSSkV9n
 Ngmqfpt7htifiEzBpQ6Kq1C7jcxzH2bhk04EIcFbWJJFV/Y7hay8ru+QaQp8B0JoYDf5
 iKihOdN6EeTzc4TD0CHPxe4X4crVhKh69wDMJCGx8OQT4KODs+3ZImKGdhgfjHbCq2Sk
 ECR9o/Rc/XaC3lSlUfgt1v2KLBUHAbl4g7Tsx2TuSDM0x+qcQFHqhrl+0NZz619EazF+
 ARqZzctZcXhO1mVcu1iCwt9/5f3BmYJHPdOkAcighq3S2VOC6uk0cjgboccBPRfGCNGv
 T6Jw==
X-Gm-Message-State: AOJu0YyC/RlOy2od1JOEJODExSs3L+73Ec1i/8dxf1/TiE0+Ea1QMnw5
 YN0+MRqiD1oubkzQPLgWQsvIawA0HNbHYonBqM1+kFURI7h+mVq/fgT7HhI9mraLveBxe7AWG9d
 wwdZR
X-Gm-Gg: ASbGncuzy6/ecmb247xtQ8dg6OHcCdSXfteKLGhiq/WAAzk628ywQuV0mHKtJc8MUsp
 GRAA0NtJiUs47H90tdAF6WKnbVpBiZTiKY9cXjNcFiHNuWDDqsA0C+DnqivEWJCpqdiD2YJMNWE
 oSE4SdeQg9EoFx5qL09N7T2A0Q62e5luXl6k91KqmnO/tykh7MCCPsT1+AVbLWdvZe84mlHh5Q6
 0Tf5yIZpYASNMxt9eKJj1mqgiqq+/zXjRbMj2uCUHixMPiCtmS3vbF54qbEQqH/CTGBnNPgeXNb
 cT97C+aoziHBsPZt5480arUz6eROUN+1Qj5nGdLDHCDpPk4Wz16EHvCoUcXUJ/dGqMLmqpo3GLD
 07EkMT/rUANC9c1KfHBXgAtDzxVdSl6bkqxl9H5hHQPRqFkcUgElN068s22RZOP07yCsYXGV/lx
 G8Kg0fMm50J0DabRaD3MkHr9yDRNaWGEDW0N+6jxoD/JFjIuA6cZBTMeBaJgDK
X-Google-Smtp-Source: AGHT+IHKZ570/kJgkEfsJOYd3JWRfzsKNrej+hUZR5GOkGmwfdEY3W8CNdk24AUydUjgi/P3U7CRyg==
X-Received: by 2002:a05:6000:25ee:b0:427:62d:132c with SMTP id
 ffacd0b85a97d-427062d135emr21928999f8f.21.1761569497861; 
 Mon, 27 Oct 2025 05:51:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:9a4:ec5a:4022:b507?
 ([2a01:e0a:cad:2140:9a4:ec5a:4022:b507])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952db9c6sm14400743f8f.36.2025.10.27.05.51.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 05:51:37 -0700 (PDT)
Message-ID: <ef48b1b9-9aca-41cb-bd8f-1e972fe60561@linaro.org>
Date: Mon, 27 Oct 2025 13:51:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 0/7] Implement the Generic System Interconnect
 Subsystem for U-Boot
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Bhupesh Sharma
 <bhupesh.linux@gmail.com>, Neha Malcom Francis <n-francis@ti.com>,
 Mario Six <mario.six@gdsys.cc>
Cc: u-boot-qcom@groups.io
References: <20251010-topic-interconnect-next-v3-0-b384713283a8@linaro.org>
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
In-Reply-To: <20251010-topic-interconnect-next-v3-0-b384713283a8@linaro.org>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On 10/10/25 16:35, Neil Armstrong wrote:
> Let's introduce the Generic System Interconnect subsystem based on
> the counterpart Linux framework which is used to vote for bandwidth
> across multiple SoC busses.
> 
> Documentation for the Linux Generic System Interconnect Subsystem can
> be found at [1].
> 
> Each bus endpoints are materialised as "nodes" which are linked together,
> and the DT will specify a pair of nodes to enable and set a bandwidth
> on the route between those endpoints.
> 
> The hardware resources that provide those nodes and provides the way
> to vote for the bandwidth are called "providers".
> 
> The Interconnect uclass code is heavily based on the Linux one, with
> some small differences:
> - nodes are allocated as udevices instead of Linux idr_alloc()
> - tag management is minimal, only normal xlate is supported
> - getting nodes states at probe is not implemented
> - providers are probed on demand while the nodes links are traversed
> - nodes are populated on bind
> - id management is simplified, static IDs and dynamics IDs can be used
> - identical consume API as Linux, only implementation differs
> 
> DM Testsuite is provided, testing all the API and nodes lifetime.

Is there any comments on this patchset ? or at least the DM emums and
the general code organization ?

Thanks,
Neil

> 
> A first implementation for Qualcomm SoCs using the RPMh subsystem
> is added, bandwidth vote is required to have full bandwidth for
> storage devices and enabling some subsystem like Display to access
> the DDR memory.
> 
> [1] https://docs.kernel.org/driver-api/interconnect.html
> 
> Qcom implementation depends on:
> - https://lore.kernel.org/all/20250711143851.1490617-2-aswin.murugan@oss.qualcomm.com/
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v3:
> - Add doc page, hevily based on the linux one
> - Documented all the structs and functions
> - Removed id field from icc_node, now using the device driver_data
> - icc_node id is not an ulong, can accept a pointer for dynamic id
> - Removed all functions call with icc_provider, now using the struct device only
> - Removed the icc_node provider entry, now only using dev->parent
> - Removed the interconnect pre_remove and pre_unbind, they are not needed
> - Removed more unused struct entries
> - Fixed the icc_path alloc, added the called dev to print errors with dev_err()
> - Removed IDs in sandbox interconnect, uses the "dynamic id" using the node pointers as ID
> - Now of_icc_get/_index will return NULL is prop is missing, like for Linux
> - Cleaned all the debug() calls, added new ones to track the bw agregations
> - Renamed node_find() to icc_node_find() to avoid name collision
> - Moved icc_node busy check to icc_node_busy()
> - Now icc_node_create passes the ID via driver_data
> - Added more bw test after put() calls, moved enable() after disable()
> - Used "Generic System Interconnect Subsystem" when possible
> - Dropped the icc_node init_avg/init_peak which is a Linux thing for sync_state
> - Dropped icc_node_add
> - Link to v2: https://lore.kernel.org/r/20251008-topic-interconnect-next-v2-0-c46e94dd328e@linaro.org
> 
> Changes in v2:
> - Simplified nodes linking, looking for nodes at traversal instead of complexe debice reparent
> - Populates nodes at bind time, only probinf nodes and providers when a path if found
> - With proper refcounting the node lifetime is safe
> - DM test is added, testing with a small graph that calculations are good
> - Fixed plenty of typo and errors, and dropped useless code
> - Dropped RFC since DM test is available, and code works as expected
> - Link to v1: https://lore.kernel.org/r/20251003-topic-interconnect-next-v1-0-955eef068b6e@linaro.org
> 
> ---
> Neil Armstrong (7):
>        Introduce the Generic System Interconnect Subsystem
>        interconnect: add DM test suite
>        MAINTAINERS: add myself as Maintainer of the Generic System Interconnect Subsystem
>        interconnect: add support for the Qualcomm RPMh helpers
>        interconnect: add support for the SM8650 SoC
>        ufs: qcom: vote for interconnect bandwidth on probe
>        qcom_defconfig: enable interconnect for SM8650
> 
>   MAINTAINERS                                      |   11 +
>   arch/sandbox/dts/test.dts                        |   36 +
>   arch/sandbox/include/asm/interconnect.h          |   19 +
>   configs/qcom_defconfig                           |    3 +
>   configs/sandbox64_defconfig                      |    2 +
>   configs/sandbox_defconfig                        |    2 +
>   doc/api/index.rst                                |    1 +
>   doc/api/interconnect.rst                         |  117 ++
>   drivers/Kconfig                                  |    2 +
>   drivers/Makefile                                 |    1 +
>   drivers/interconnect/Kconfig                     |   22 +
>   drivers/interconnect/Makefile                    |    8 +
>   drivers/interconnect/interconnect-uclass.c       |  543 +++++++
>   drivers/interconnect/qcom/Kconfig                |   12 +
>   drivers/interconnect/qcom/Makefile               |    7 +
>   drivers/interconnect/qcom/bcm-voter.c            |  340 +++++
>   drivers/interconnect/qcom/bcm-voter.h            |   19 +
>   drivers/interconnect/qcom/icc-rpmh.c             |  215 +++
>   drivers/interconnect/qcom/icc-rpmh.h             |  129 ++
>   drivers/interconnect/qcom/sm8650.c               | 1664 ++++++++++++++++++++++
>   drivers/interconnect/qcom/sm8650.h               |  144 ++
>   drivers/interconnect/sandbox-interconnect-test.c |   89 ++
>   drivers/interconnect/sandbox-interconnect.c      |  293 ++++
>   drivers/ufs/ufs-qcom.c                           |   13 +
>   include/dm/uclass-id.h                           |    2 +
>   include/interconnect-uclass.h                    |  136 ++
>   include/interconnect.h                           |  155 ++
>   test/dm/Makefile                                 |    1 +
>   test/dm/interconnect.c                           |  195 +++
>   29 files changed, 4181 insertions(+)
> ---
> base-commit: b8cea886d50e6c09985256e546904d640f600e4d
> change-id: 20251003-topic-interconnect-next-4ed75aecc01c
> 
> Best regards,

