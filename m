Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F92C4167B
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 14:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 683FB86E65;
	Tue, 12 Dec 2023 15:03:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j8vhR4j5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2781386C67; Tue, 12 Dec 2023 15:03:23 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2F7186D9E
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 15:03:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3333fbbeab9so5006658f8f.2
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 06:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702389798; x=1702994598; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=i5XvVGdA0q6db+uTpkKx1sq8IbJLw/bQh8rsthK+eMU=;
 b=j8vhR4j5gS5B1OydXpHs4FY0TR1/gI+SIso9x0BGg3gLYyXD/Q6kiaXZdxvMB+m5O4
 nP8e38YN9IBJ/uF8p0FkvkdmM3Jr06AaywreeHKXi32nx7F7D7+pIRgxdgetWgpgERg4
 I+f5/+ShYJj+CDonR6P3XYr3acj1vA/A96sI7xbZMbGoiFBK4ksuVYGJKzc+YuUCU2Wk
 CkxhBNn8yg2+JaVaMaIo5GvfaATlMwx7tDHDEYonmstkZ27iP/FytjYAOhJJlMz0uFyn
 kKbDlzwczKvlfDJ0vNL39WitTew+OL9l05IP3lw5VR9YuizToRt2EGWoQpJGuNRMIlQ9
 D8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702389798; x=1702994598;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=i5XvVGdA0q6db+uTpkKx1sq8IbJLw/bQh8rsthK+eMU=;
 b=hlKFarqqq2wJiUyDYO8Zaa7Z2mjDgN6I0LpOFknyo0IUiDJV8Yzgouhflwr2H6bWP2
 jX+DGguF0xIm2wmAeYxFo6RrSfAsvF/bvO+Trpzga9npDF0Wf2/DWDu4cdPyhhnXtCD0
 4ilvq7kiHXd6Z1BTaWH3EYXsOV3evZ4tf8V2iM/iR44xxAimswFOIIayEEKWB1zX3fxS
 7mYKO7wQ2iI8wj8h32X9xc9435F1YfD2ZAlDG9OKoFxb0a2L4Cc/06bxY26CUJATM1Vv
 U6+Ox+ZdtA0/wQThCAfhPAwKra67fM6acO1OX2xJEiHxSGBB9ZEoBhoBMFOdRdv667a/
 FcBQ==
X-Gm-Message-State: AOJu0Ywq5LbqDriMVPKKg4LZprEm3nFsEMgCRCwqet3ZTmA0Y7uYu2og
 pbGjcTOJq4OxgcA4SQlCB6uHFg==
X-Google-Smtp-Source: AGHT+IHzUgR6f94Smv0KuL8FdQ43huuJ10eLUCcdRTZMQTNffs24LEPyFVQT1ZndLotECok39JHa9Q==
X-Received: by 2002:a05:600c:4509:b0:40c:2518:687c with SMTP id
 t9-20020a05600c450900b0040c2518687cmr3178063wmo.61.1702389798335; 
 Tue, 12 Dec 2023 06:03:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5894:fa62:26b4:bf82?
 ([2a01:e0a:982:cbb0:5894:fa62:26b4:bf82])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a5d574c000000b003363654301esm193942wrw.98.2023.12.12.06.03.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 06:03:17 -0800 (PST)
Message-ID: <88960dfc-441f-49fb-bd36-ee32e754b003@linaro.org>
Date: Tue, 12 Dec 2023 15:03:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v7 0/8] clk: Switch from soc_clk_dump to clk_ops function
Content-Language: en-US, fr
To: Igor Prusov <ivprusov@sberdevices.ru>, u-boot@lists.denx.de,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Stefan Roese <sr@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com
References: <20231109105516.24892-1-ivprusov@sberdevices.ru>
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
Organization: Linaro Developer Services
In-Reply-To: <20231109105516.24892-1-ivprusov@sberdevices.ru>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Igor, Sean,

On 09/11/2023 11:55, Igor Prusov wrote:
> Currently clock providers may override default implementation of
> soc_clk_dump function to replace clk dump command output. This causes
> confusing behaviour when u-boot is built with one of such drivers
> enabled but still has clocks defined using CCF. For example, enabling
> CMD_CLK and using clk dump on sandbox target will not show CCF clocks
> because k210 driver overrides common soc_clk_dump.

What's the state of this serie ?

Thanks,
Neil

> 
> Changelog:
>   v1 -> v2:
>   - Add missing static to dump functions
> 
>   v2 -> v3:
>   - Make soc_clk_dump in cmd/clk.c static instead of removing __weak
> 
>   v3 -> v4:
>   - Rebase and refactor dump for new Amlogic A1 clock controller driver
> 
>   v4 -> v5:
>   - Add docs for dump() function in clk_ops
>   - Print driver and device names before calling corresponding dump()
> 
>   v5 -> v6:
>   - dump() return type changed to void
>   - meson_clk_dump() and helper functions moved under CONFIG_CMD_CLK to
>     fix unused-function diagnostic
> 
> v6 -> v7:
>   - fix return type of k210_clk_dump()
>   - fix clk_ops dump() docs since it returns void now
> 
> Igor Prusov (8):
>    clk: zynq: Move soc_clk_dump to Zynq clock driver
>    clk: ast2600: Move soc_clk_dump function
>    clk: k210: Move soc_clk_dump function
>    clk: amlogic: Move driver and ops structs
>    clk: Add dump operation to clk_ops
>    cmd: clk: Use dump function from clk_ops
>    clk: treewide: switch to clock dump from clk_ops
>    cmd: clk: Make soc_clk_dump static
> 
>   arch/arm/mach-zynq/clk.c               |  57 --------------
>   arch/mips/mach-pic32/cpu.c             |  23 ------
>   cmd/clk.c                              |  13 +++-
>   drivers/clk/aspeed/clk_ast2600.c       |  83 ++++++++++----------
>   drivers/clk/clk_k210.c                 | 104 ++++++++++++-------------
>   drivers/clk/clk_pic32.c                |  37 +++++++++
>   drivers/clk/clk_versal.c               |   9 ++-
>   drivers/clk/clk_zynq.c                 |  52 +++++++++++++
>   drivers/clk/clk_zynqmp.c               |  22 +++---
>   drivers/clk/imx/clk-imx8.c             |  13 +---
>   drivers/clk/meson/a1.c                 |  58 ++++++--------
>   drivers/clk/mvebu/armada-37xx-periph.c |  20 +++--
>   drivers/clk/stm32/clk-stm32mp1.c       |  31 ++------
>   include/clk-uclass.h                   |  13 ++++
>   include/clk.h                          |   2 -
>   15 files changed, 269 insertions(+), 268 deletions(-)
> 

