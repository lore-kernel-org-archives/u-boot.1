Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BA4C44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 15:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4182607E6;
	Wed, 22 Jul 2026 15:43:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fXvLGf6epxVt; Wed, 22 Jul 2026 15:43:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0627960602
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784735006;
	bh=iJyNwrE6lbqgurodZfcvAvzBkEYTAtlO4eq29BR2x0g=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=L6fARanuK7bFcVUH+3Clb3ooDtsGCELfmpBYVHHDRIUd8n5Zvxk4vy3Ci2s20+z45
	 StShVCtjZjIwmaNeNIrD54Bj6pSGRZtIuM3eskym4OJeGEVcmaATyXj7uDIEinAKLx
	 PS+j9KUq2vYo9DnEYU3gqy2XFPhjrtqdWXVcl3Q9X8j0veNxk5fU8CV769l0MiENCq
	 JRV9QnLzmTV5d5tJpc3+APsLOfVNN+wHFR1xXPowh+g4QXRHqI2sEDjqbK1dObv0PS
	 E7xXKB1t4svHVq3Km3ASb0TyUxDaftKf14bjTsDX1OZHkTBRmtc7OIuMGdTRO1ojwB
	 E9G2ZT4tKCu0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0627960602;
	Wed, 22 Jul 2026 15:43:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0153842A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:43:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E7B564077F
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:43:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MtUMtYJZ-auO for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 15:43:24 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=neil.armstrong@linaro.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 97EA44078E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 97EA44078E
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 97EA44078E
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:43:23 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BDBA8495B; Wed, 22 Jul 2026 17:43:21 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5521E8493F
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 17:43:19 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so6843652f8f.2
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 08:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784734999; x=1785339799;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iJyNwrE6lbqgurodZfcvAvzBkEYTAtlO4eq29BR2x0g=;
 b=aW1Wc4vfJJJNmJ3X3e7WC4Q33fLbG09aOsMCxq94XZFWviFAafpvoDSB0pq3xusd5Z
 aOfCRvdls94+Ybiw28r8pQHhC0QIykBiAHhsHN+YNxKEHaDX9+zSfSQ1m8JPzuGRCNLA
 QVm8VVbQ7p+FVDTo86H3ac2QQh7AH/FsjXbsEvUom9lT7VkHp9Q9fu5YDcpy/n6xAYj+
 2HgimJE4fH+rt2MYtnBLDQRuo6ETO7nwjHAakhN67Dnvhpvic35tXrvDBQAlc+rT5/AP
 9OvIfwJQNOYNJnq0a7+rc5E5FOnJkjF+yAbZlXOrjQMIk6lVtgNvOxr8mWQwHCqHBk6o
 gnpA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5WkwHanJGJluVG7QDolqV1d3MSZ9UXHU57yYhuqI+HloRBKBKZNuOjDHdwTJSoUGJgs7J6y4=@lists.denx.de
X-Gm-Message-State: AOJu0YzdfjmUpj+vklBxrFqCjwLp++9iQ6wSZlhdINLp+GsKq9vuKXBI
 LL+NEGix+OjsCQQP2wNW1St5TYn/A3yiZSA5A9LIZZEkn058M1KqJ/GYSmLji2I4nwA=
X-Gm-Gg: AR+sD132X9v+rcVV7+OM8HDfzCtbHwx7a/8bAV0n0XryE+1Lv3N6DuhRy2m9xfNNW+G
 7nevi3dMoqKWV4tKn4ur6yDJKcJkl+rmj6d9TiTZfOCxZGlA565jS2nc5BV8L8o6RAwiP2gHjI7
 yN1CTJnzPoV7FTQomu+qSgsrZCdVv4mc78UQwJCfhmUQaIpBsOvBeydyWtsSf+4qu2zgnx3R90m
 siiaYk3QiZRwFFjFEDc9q5MxVcR+ZzOhcP+uMmGqlbI6Na82FtZSeBnCj0dMRiFczOMnb8gJSUa
 zPfOiLW+j/mb1HT2djYeic3r5FqSDvesz1MFrwBLauK8Hkm9TWPBhAsJzS81JsvAn6UgukkN4EA
 IKdpkDE/2IOtL3ZuC4g4+EnzzeCdWkXg9RLFVpvEcOLG3vvSwczB9B8zTAF5LsI3MKN4aqZs1GV
 Moj9GSmIiLctaQt4PPOr9KKVUDpgyWB5NZp8++DztWaFz+VSWa3cvaTdBHSFxWuTlQrOI2
X-Received: by 2002:a05:6000:3113:b0:474:cd60:1160 with SMTP id
 ffacd0b85a97d-47f623283e4mr27801623f8f.46.1784734998185; 
 Wed, 22 Jul 2026 08:43:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:ab55:6d63:2bdd:9491?
 ([2a01:e0a:106d:1080:ab55:6d63:2bdd:9491])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a64dsm7448744f8f.1.2026.07.22.08.43.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 08:43:17 -0700 (PDT)
Message-ID: <6f5137f9-d358-4c51-ac2c-f667cf126d80@linaro.org>
Date: Wed, 22 Jul 2026 17:43:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] optee: implement the RPMB subsystem interface for
 UFS
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: trini@konsulko.com, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 marek.vasut+renesas@mailbox.org, shawn.lin@rock-chips.com,
 igor.belwon@mentallysanemainliners.org, yoshihiro.shimoda.uh@renesas.com,
 alchark@gmail.com, tuyen.dang.xa@renesas.com, padmarao.begari@amd.com,
 macpaul.lin@mediatek.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com,
 hayashi.kunihiko@socionext.com, dlechner@baylibre.com, u-boot@lists.denx.de
References: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
 <20260722060805.1428110-6-jorge.ramirez@oss.qualcomm.com>
 <791913b4-d006-44be-8c94-871617418dbc@linaro.org> <amDP5roFBAAdOcYK@trex>
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
In-Reply-To: <amDP5roFBAAdOcYK@trex>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784734999; x=1785339799; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iJyNwrE6lbqgurodZfcvAvzBkEYTAtlO4eq29BR2x0g=;
 b=rcGJKOqNh3ErjrQV4yY2hAMDCflJLID1sUwDarkRgj0utyDEc0T48N9TjkAeUXdj7A
 JIBdAXuRxYxYlNeprKtAJ+jkYr8I3g2f34OdfJUvsLuS2DQdjLnxvQEOnO4FEBs2nLID
 pCC6fm4/9iGUXkRs2os7qx+8hx2dFhhNF6Ijg0N89+mjy7/JFwkBbekT/kJXgT+PScoc
 9A02OXOPcTq9Lr2IbNLllpIwxzeN2iSrmcMUO6w+czFMWfc8sKvbWvyVWtr6Q1zu1etR
 SUW8h5SywQ8hmO92y7d96mDenh08ZW4hWTWanfv8Vqbx1oouEzu2AMWYe9I+eFJzd2nV
 I0AQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=rcGJKOqN
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=neil.armstrong@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="rcGJKOqN"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Neil Armstrong via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/22/26 16:12, Jorge Ramirez wrote:
> On 22/07/26 10:31:04, neil.armstrong@linaro.org wrote:
>> Hi,
>>
>> On 7/22/26 08:07, Jorge Ramirez-Ortiz wrote:
>>> OP-TEE's legacy RPMB supplicant interface assumes the RPMB device is eMMC
>>> and derives the key from an eMMC-shaped device ID, so it can never
>>> reproduce the key Linux derives for a UFS device; secure storage on
>>> UFS-only platforms instead needs the transport-agnostic RPMB subsystem
>>> interface, through which the normal world describes the real RPMB device
>>> to OP-TEE. Add a UFS backend for it so OP-TEE derives a key matching Linux
>>> and can use RPMB secure storage on UFS, leaving the legacy eMMC path
>>> untouched.
>>>
>>> This subsystem backend currently supports UFS drives only; eMMC still uses
>>> the legacy interface. As the legacy interface is dropped in favour of the
>>> subsystem one, an eMMC backend should be added here so both transports are
>>> served through a single RPMB path.
>>>
>>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
>>> ---
>>>    drivers/tee/optee/Makefile               |   1 +
>>>    drivers/tee/optee/optee_msg_supplicant.h |   8 ++
>>>    drivers/tee/optee/optee_private.h        |  41 ++++++++
>>>    drivers/tee/optee/rpmb.c                 | 124 +++++++++++++++++++++++
>>
>> Why not rpmb_ufs ?
> 
> 
> because in the future (and IMO) rpmb.c should support UFS and EMMC using
> the new probe interface (eventually removing rpmb_legacy).

Let's see in the future, if somehow there's need for a common "new"
and emmc only legacy some rework will be needed anyway. The eMMC RPMB
hasn't been updated for a very long time...

Using the driver model to register an rpmb device attached to an eMMC
or UFS controller would the cleanest way to handle that, but we're not here now.

> 
>>
>> It's fine to have 2 backend implementations, the emmc is implementing the
>> legacy optee API, just add a comment in the eMMC file about that.
>>
>> Neil
>>
>>>    drivers/tee/optee/supplicant.c           |   9 ++
>>>    5 files changed, 183 insertions(+)
>>>    create mode 100644 drivers/tee/optee/rpmb.c
>>>
>>> diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
>>> index 8321cf53a19..7af19834c00 100644
>>> --- a/drivers/tee/optee/Makefile
>>> +++ b/drivers/tee/optee/Makefile
>>> @@ -4,3 +4,4 @@ obj-$(CONFIG_OPTEE) += core.o
>>>    obj-y += supplicant.o
>>>    obj-$(CONFIG_DM_I2C) += i2c.o
>>>    obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb_legacy.o
>>> +obj-$(CONFIG_SUPPORT_UFS_RPMB) += rpmb.o
>>> diff --git a/drivers/tee/optee/optee_msg_supplicant.h b/drivers/tee/optee/optee_msg_supplicant.h
>>> index 963cfd47824..b720d5d7b3f 100644
>>> --- a/drivers/tee/optee/optee_msg_supplicant.h
>>> +++ b/drivers/tee/optee/optee_msg_supplicant.h
>>> @@ -152,6 +152,14 @@
>>>     */
>>>    #define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 21
>>> +#define OPTEE_MSG_RPC_CMD_RPMB_PROBE_RESET	22
>>> +#define OPTEE_MSG_RPC_CMD_RPMB_PROBE_NEXT	23
>>> +#define OPTEE_MSG_RPC_CMD_RPMB_FRAMES		24
>>> +
>>> +#define OPTEE_RPC_SHM_TYPE_APPL		0
>>> +
>>> +#define OPTEE_RPC_RPMB_UFS		1
>>> +
>>>    /*
>>>     * Was OPTEE_MSG_RPC_CMD_SQL_FS, which isn't supported any longer
>>>     */
>>> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
>>> index 1f07a27ee4b..2888257aefe 100644
>>> --- a/drivers/tee/optee/optee_private.h
>>> +++ b/drivers/tee/optee/optee_private.h
>>> @@ -9,6 +9,17 @@
>>>    #include <tee.h>
>>>    #include <log.h>
>>> +#ifdef CONFIG_SUPPORT_UFS_RPMB
>>> +/**
>>> + * struct optee_private - OP-TEE driver private data
>>> + * @rpmb_next_region:	next UFS RPMB region to report on PROBE_NEXT
>>> + * @rpmb_cur_region:	UFS RPMB region selected by the last PROBE_NEXT
>>> + */
>>> +struct optee_private {
>>> +	unsigned int rpmb_next_region;
>>> +	unsigned int rpmb_cur_region;
>>> +};
>>> +#else
>>>    /**
>>>     * struct optee_private - OP-TEE driver private data
>>>     * @rpmb_mmc:		mmc device for the RPMB partition
>>> @@ -22,6 +33,7 @@ struct optee_private {
>>>    	int rpmb_dev_id;
>>>    	int rpmb_original_part;
>>>    };
>>> +#endif
>>>    struct optee_msg_arg;
>>> @@ -60,6 +72,35 @@ static inline void optee_suppl_rpmb_release(struct udevice *dev)
>>>    }
>>>    #endif
>>> +#ifdef CONFIG_SUPPORT_UFS_RPMB
>>> +void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
>>> +				      struct optee_msg_arg *arg);
>>> +
>>> +void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
>>> +				     struct optee_msg_arg *arg);
>>> +
>>> +void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
>>> +				 struct optee_msg_arg *arg);
>>> +#else
>>> +static inline void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
>>> +						    struct optee_msg_arg *arg)
>>> +{
>>> +	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
>>> +}
>>> +
>>> +static inline void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
>>> +						   struct optee_msg_arg *arg)
>>> +{
>>> +	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
>>> +}
>>> +
>>> +static inline void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
>>> +					       struct optee_msg_arg *arg)
>>> +{
>>> +	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
>>> +}
>>> +#endif
>>> +
>>>    #ifdef CONFIG_DM_I2C
>>>    /**
>>>     * optee_suppl_cmd_i2c_transfer() - route I2C requests to an I2C chip
>>> diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
>>> new file mode 100644
>>> index 00000000000..9c3e0f031ad
>>> --- /dev/null
>>> +++ b/drivers/tee/optee/rpmb.c
>>> @@ -0,0 +1,124 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +
>>> +#include <dm.h>
>>> +#include <tee.h>
>>> +#include <ufs.h>
>>> +
>>> +#include "optee_msg.h"
>>> +#include "optee_msg_supplicant.h"
>>> +#include "optee_private.h"
>>> +
>>> +#define UFS_RPMB_CONTROLLER	0
>>
>> Can this be a config option instead which defaults to 0 ?
> 
> um, I dont think so - this assumes there is only one controller. If there
> are more than one, we would need a mechanism to select which one from
> the enumerated values (maybe a DT alias (ie ufs-rpmb ?) I think the binding order
> changes as we enable/disable devices)

It could collide with other SCSI devices like SATA devices over PCIe.

Usually we try not to hardcode the devices ids.

Neil


> 
> 
> 

