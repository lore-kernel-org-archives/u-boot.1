Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE8ACD6E6B
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:50:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD0D384948;
	Thu,  4 Jun 2026 14:50:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IwBWOdzH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B955784956; Thu,  4 Jun 2026 14:50:52 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A81608490B
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 14:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490ac357c55so8296865e9.1
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 05:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780577450; x=1781182250; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=KBV/+D7PhPKJGWf6BBUnmxJdbow6AQFU+MopEw/25U0=;
 b=IwBWOdzHw5WqsthPQS0fvzifANepD3smy/wUZ7/Meko5+wCPwuFqqa/KJyIiwELja9
 9fLkPLuu9ZyQG3TLCFOFFe2A4NUm704BMJr9dv1hKT8nLD45c5tyPPERBmTnp4fhlOno
 jD5wjqolS5Lh03geQgjjPA86a/zk3wgF1LSLXJ9WnoHqZIyeEhdHHViJh4o5XB/3ihX9
 ME/LiZZJIdIkxuM4FSmOOhrcbYT7yamKKXE4nRQ7MmbsQgmR7KgAsPf8Bgjf3aXAiIbw
 /s8H8OJXM2ooxgh/Fv9eGgRgvLTaZ3ipOJWJN0ZIURC3UhRPs8wiX1G0HAoq2jcZuSBh
 VKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780577450; x=1781182250;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KBV/+D7PhPKJGWf6BBUnmxJdbow6AQFU+MopEw/25U0=;
 b=HWlP6aGYltpZ3VAzxnU6IvK8KfsPF7UcpTIN9sbfecr6tYYlBd5mR4s3o5bJdU3zp2
 0TVtLeW1bpaOKFXc5rcdQuFq0h8UKBaYQOfUTjQF6sPTfz4T7cRqToyOyrwjC6awJ1A5
 5nWj0x+rMk8hAUW9sDBn1C6HlrlkG0qMHXlcjhz0VyPPuk5ESj6JZACGIjsa8W6SpOBT
 Y+5NeF0GkclPDqKON5HcchV49HVgQXboNd1/iZzjRPd0m04phYSfyFcbXvhiqwRxGQHW
 XfiS4uIL7qMGA2eyRRonqC/Vw4idGvTPC82yC05aFt48yUjLjQ6eN1dKTUr+dJA/ZeMN
 Jr3A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9lYZPoIy0lWMJTLl8cRTe9+iMkLsrMKogRJ+HNL8qCRoJg7n5BZgDNNwpyfSTKoPFan7XDg0o=@lists.denx.de
X-Gm-Message-State: AOJu0YyIekFRPDNXKUj8qwqda3GlXPAM+ePIrN4vq4r6mvr33WmDHezN
 RgFcD2CYn9r47Yg4SKXbspITE66We64cQhi++lEfMGYKiml0gaXKZpk2FZrf+7oLHYM=
X-Gm-Gg: Acq92OFC1Ce/wEhHCG3cVlT74tqJuQPSzXU1LQKZOMNyiJOn0oM6I43p+YQihKWPZhb
 nWnTZt8JlMD5ubjmf5v5U+6905tnEUinNEBlUyIk6niGwWXxjmMYZ174QI+i2ErP7o2kvpizrII
 u16HeA5jC57t7mdxVEPGgNzIIg+Y58TEX09I1uLh+JXxT73y0zjLfCWoJlfoA57FpBckkaBpoVw
 VOwzDdj0Tz83hXMscIZq3zjDWXuhMYDkkadbSe7pUwDtfB94I9rVInf//HC4aFmZjaGCfQvKJT/
 Fr4A8xGNBBc9nl3nk+9ysOxUVG5NjloRjVZGCLWO0WJczSPgttBmTEX4/yx/SiEMGkSQ9whW/ZC
 Ec+ow9a2gduCunnN/9swujHhw+A+yeiue+zcWZNg1RzXn1wBJT8EfCGmAxXEj40xEDujjrpuFGy
 UxKIKElzmnrpkdIQ48okYPWfDmwrvA+oolJvHbzaygjY8RTXrCH2JGn3G+VcMRss6MzHPk2m9lo
 AcMr/kDftCRBM0=
X-Received: by 2002:a05:600c:5288:b0:490:b0f1:c27e with SMTP id
 5b1f17b1804b1-490b5ee1c64mr131210835e9.24.1780577449909; 
 Thu, 04 Jun 2026 05:50:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:dbd:100f:afd5:9221?
 ([2a01:e0a:106d:1080:dbd:100f:afd5:9221])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3918d7sm62639705e9.2.2026.06.04.05.50.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 05:50:49 -0700 (PDT)
Message-ID: <20c91f1d-97d1-4217-b67a-a5e239221cec@linaro.org>
Date: Thu, 4 Jun 2026 14:50:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH PATCHSET 6/6] ufs: doc/usage/cmd/ufs.rst
To: raz.benyehuda@mobileye.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Yao Zi <me@ziyao.cc>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Michal Simek <michal.simek@amd.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Jared McArthur <j-mcarthur@ti.com>, Shawn Lin <shawn.lin@rock-chips.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Alexey Charkov <alchark@gmail.com>
References: <20260604-ufs_tool-v1-0-741ed00232c0@mobileye.com>
 <20260604-ufs_tool-v1-6-741ed00232c0@mobileye.com>
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
In-Reply-To: <20260604-ufs_tool-v1-6-741ed00232c0@mobileye.com>
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

On 6/4/26 13:25, Raz Ben Yehuda via B4 Relay wrote:
> From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> 
> Documention of the ufs tool.

Change the subject to something like "ufs: document the ufs command"

> 
> Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> ---
>   doc/usage/cmd/ufs.rst | 217 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 217 insertions(+)
> 
> diff --git a/doc/usage/cmd/ufs.rst b/doc/usage/cmd/ufs.rst
> new file mode 100644
> index 00000000000..a6faf4b1347
> --- /dev/null
> +++ b/doc/usage/cmd/ufs.rst
> @@ -0,0 +1,217 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +ufs Tool
> +========
> +
> +The ``ufs`` tool provides utilities for querying, displaying, and modifying
> +UFS device configuration and descriptor information.

Please document the other UFS subcommands aswell.

Thanks,
Neil

> +
> +Features
> +--------
> +
> +* Query and display Device, Geometry, Unit, Configuration, and Power
> +  Descriptors.
> +* Display LUN configuration and calculated capacities.
> +* Modify LUN, Configuration, and Device Descriptor fields.
> +* Configure WriteBooster-related parameters.
> +* Query common UFS runtime flags.
> +* Commit configuration changes or clear all LUN configurations.
> +* Decode and format descriptor contents for easier debugging.
> +* Provision UFS devices using exported Configuration Descriptors.
> +
> +The UFS tool header definitions are based on the JEDEC JESD220E
> +*Universal Flash Storage (UFS) Version 3.1* specification.
> +
> +Usage
> +-----
> +
> +Query descriptors::
> +
> +    ufs query [lun] [idn]
> +
> +Descriptor IDs
> +~~~~~~~~~~~~~~
> +
> +::
> +
> +    0x00  Device Descriptor
> +    0x01  Configuration Descriptor
> +    0x02  Unit Descriptor
> +    0x07  Geometry Descriptor
> +    0x08  Power Descriptor
> +
> +Configure a Logical Unit (LUN)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +    ufs set_lun <lun> <parameter> <value>
> +
> +Supported parameters::
> +
> +    lu_enable
> +    boot_lun_id
> +    lu_write_protect
> +    memory_type
> +    data_reliability
> +    num_allocunits
> +    logical_block_size
> +    provisioning_type
> +    context_capabilities
> +    lu_num_write_booster_buffer_allocunits
> +
> +Modify Device Descriptor fields
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +    ufs set_dev_desc <parameter> <value>
> +
> +Supported parameters::
> +
> +    descriptor_idn
> +    device
> +    device_class
> +    device_sub_class
> +    number_lu
> +    boot_enable
> +    descr_access_en
> +    init_power_mode
> +    high_priority_lun
> +    secure_removal_type
> +    initactive_icc_level
> +    queue_depth
> +    write_booster_buffer_preserve_user_space_en
> +    write_booster_buffer_type
> +    spec_version
> +    manufacturer_id
> +    periodic_rtc_update
> +    device_version
> +    psa_max_data_size
> +    extended_ufs_features_support
> +    num_shared_write_booster_buffer_allocunits
> +
> +Modify Configuration Descriptor fields
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +    ufs set_cfg_desc <parameter> <value>
> +
> +Supported parameters::
> +
> +    length
> +    descriptor_idn
> +    conf_desc_continue
> +    boot_enable
> +    descr_access_en
> +    initpower_mode
> +    high_priority_lun
> +    secure_removal_type
> +    init_active_icc_level
> +    periodic_rtc_update
> +    reserved_HPB
> +    rpmb_region_enable
> +    rpmb_region1_size
> +    rpmb_region2_size
> +    rpmb_region3_size
> +    write_booster_buffer_preserve_user_space_en
> +    write_booster_buffer_type
> +    num_shared_write_booster_buffer_allocunits
> +
> +Query UFS flags
> +~~~~~~~~~~~~~~~
> +
> +::
> +
> +    ufs getflag <flag_name>
> +
> +Supported flags::
> +
> +    deviceinit
> +    permanent_wpe
> +    pwr_on_wpe
> +    bkops_en
> +    life_span_mode
> +    purge_enable
> +    fphy_resource_removal
> +    busy_rtc
> +    permanently_disable_fw_update
> +    write_booster_en
> +    wb_buf_flush_en
> +    wb_buf_flush_h8
> +
> +Examples
> +--------
> +
> +Create LUN 4::
> +
> +    ufs query 1 1
> +    ufs set_lun 4 num_allocunits <size_in_alloc_units>
> +    ufs commit
> +    scsi scan
> +
> +Update WriteBooster configuration::
> +
> +    ufs query 1 1
> +    ufs set_cfg_desc num_shared_write_booster_buffer_allocunits 100000
> +    ufs set_cfg_desc write_booster_buffer_type 1
> +    ufs commit
> +
> +Clear all LUN configurations::
> +
> +    ufs clearall
> +
> +This command clears all configured LUNs and commits the change.
> +
> +Provisioning
> +------------
> +
> +To simplify UFS provisioning, the tool displays the memory address and
> +size of the Configuration Descriptor (IDN 0x01). This allows the
> +descriptor to be exported from one system and imported on another.
> +
> +Provisioning workflow
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +Source system
> +^^^^^^^^^^^^^
> +
> +1. Display the Configuration Descriptor::
> +
> +       ufs query 1 1
> +
> +   The output includes the Configuration Descriptor address and size.
> +
> +2. Save the Configuration Descriptor to a file::
> +
> +       tftpput <cfg_desc_addr> <size> <filename>
> +
> +   Example::
> +
> +       tftpput 0x8ffffc610 0xe6 luns.bin
> +
> +   This exports the current UFS configuration, including LUN settings.
> +
> +Target system
> +^^^^^^^^^^^^^
> +
> +1. Display the current Configuration Descriptor::
> +
> +       ufs query 1 1
> +
> +2. Load the configuration file into the Configuration Descriptor buffer
> +   using XMODEM or TFTP::
> +
> +       loadx 0x8ffffce00
> +
> +   or::
> +
> +       tftpget 0x8ffffce00 luns.bin
> +
> +3. Commit the configuration to the UFS device::
> +
> +       ufs commit
> +
> +   The imported Configuration Descriptor is written to the device and
> +   becomes active after the commit operation completes.
> 

