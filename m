Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AC7C531C7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 07:33:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E626F407FB;
	Thu, 23 Jul 2026 07:33:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vSoBYwXYVmiW; Thu, 23 Jul 2026 07:33:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 430DD407E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784792028;
	bh=udvdkbhGuCAaC2HG7xkPhOwn33A6nN/5VfAo4E5avGk=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=lWnG4oCZcZe0TDZ4xpL0VJtvoXcbP8sgA1msI8mUIS+y71/A/ZrSjqPeXgh0aGQPP
	 w0VY6BvumvITbuuBePE97Qrwx+CDCnHmahpf1DFjlVYi/yENnDlCAfewVOnBE1CmfK
	 fk/ETVDiVGJEx0yKtTMR8H45jTXyiWTpluvM6QuMJH5Rcj2+4RKvVfgox6TIdI0Qsr
	 9m+lharh2EJtydVjewEvOo/yGmqH4SRWo7cSo660RtmWwAEMcKJm2b1fX1wR3T4bp3
	 1jBY90JFCaSKOGSSkxUHzP6eG+GsQ3p+CSNCcx+NFUwwYrAq44Lsa8FtfmtP+GuiHu
	 PIUl+ZSj4HDcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 430DD407E9;
	Thu, 23 Jul 2026 07:33:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1690636E
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 07:33:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 082B1400BB
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 07:33:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MhZjeFhyRtzF for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 07:33:46 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 98DB840026
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 98DB840026
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 98DB840026
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 07:33:45 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA9AF8494B; Thu, 23 Jul 2026 09:33:43 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31E7583E76
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 09:33:41 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso269239f8f.3
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 00:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784792020; x=1785396820;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=udvdkbhGuCAaC2HG7xkPhOwn33A6nN/5VfAo4E5avGk=;
 b=bnHf6/USkGqsbnoDDgLD0gh5jucIXBnFEX0PeIszAEvS6gOPEowzdJo9nVuo5EMv6R
 kMLCwToX1B80V0ciOVcm22Le1NT+r8BSmgCmvWHXRcUVsvVbhY0luVwbuVpRM1zZYwv6
 wxSPSIwm1LWuU3nyCsVVnHxN863iGdEeIIvGs6ZwYsM3aFY9kqvfLkSNPYhaDox6cYhT
 CNSiD4rh/6GBOUO1Ra4R3WiIAm6TpmWfbfvqY/pthOzAwZVGFjK0PkxPVdhswGgeCuV9
 uxivIEmqJuCC8SCS3bVlp4m4lEadmdTZLbgvG7xFrOVPrSDSgInaT6LsU9RuOuQB2FZS
 tI0w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqRX8O7Afm2/We0uXvYinEsQLjCDl+pcXjTdvX7l2QDbxD7AmyQ3H0t4LSGssxvKsU+RGeC0zQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyDtZssWCHZ5Rcft/04KZlfaxaTIqGdXuHnitaYXBc8RhfQf+I4
 iXfRbDuVgJ8ufBiZxj8ZbvgeCpV49OrvGvCZerXuMSXRagnyn1PRBR8iX38MYX8QRQ8=
X-Gm-Gg: AR+sD12WPKb1PKLB357Cl8ch3oc28onTmHbnmlsiziBDgHP0VwkEegn5/Kap0BioV7A
 bExSN1EWuRGKT5vdGTG4a/QiAuuEP9WAxMefDgnxFp6MLL0ciY/A4G06SrmRn9ucx3786fQXzex
 Wn0rhJ3sdLkbaucixK+pVQSG8KCL8JIf8mDnX5vCCJl3mliuzmu2ZCNEwhLDiM6wnODkDpOp6RK
 SFMSCCfBuVP11ftn8ixHuGCMQoT/SUqw1CavlrVG7s/+j0ZQhG28GQPpd5ddJnY2z8TVIU8VYSr
 nPvTARDZJ7eiFLl95edVvzrZCZtmi+iDq4bYaOFirdtgIh9TJqpIjxR4dpCQHmsJNA0clcJ507y
 IpGT4OxHh5yB5me9Zx1RiEQfz8JcYXFquuQO9DRNT3dtg2EsRqw0w0elf5q42wVI5c7qGOor2P0
 4eOqBfBVUXNv1nCq43Ru9SyNCBNTQwJF7JE4/ctSD+fLNGeCYbu/UtAhhsyQ==
X-Received: by 2002:a05:6000:4a12:b0:46d:d90b:bbe4 with SMTP id
 ffacd0b85a97d-47f8d76050emr2245801f8f.40.1784792020410; 
 Thu, 23 Jul 2026 00:33:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:ab55:6d63:2bdd:9491?
 ([2a01:e0a:106d:1080:ab55:6d63:2bdd:9491])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c532d4sm12455016f8f.22.2026.07.23.00.33.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 00:33:40 -0700 (PDT)
Message-ID: <4fd9db1d-0194-4f6b-8472-43fffed26371@linaro.org>
Date: Thu, 23 Jul 2026 09:33:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
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
 <6f5137f9-d358-4c51-ac2c-f667cf126d80@linaro.org> <amEIA0pSVEehZJYt@trex>
 <amEPgwafY1zm1LwF@trex>
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
In-Reply-To: <amEPgwafY1zm1LwF@trex>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784792020; x=1785396820; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=udvdkbhGuCAaC2HG7xkPhOwn33A6nN/5VfAo4E5avGk=;
 b=I4HPsq7HNY73q1OQyc8bXX9K6WUVTGLKPximPN9U61CnZ9mZIzJu2H1aGACEl3EAe4
 ToBrCzmxpg2YoWnjpkor5QOOzUOxHF246+XKzjL5s96r7IlAik37XhmVtsUErjzWDb8i
 oHiTB/eEWLaCmewzVAx0Sv2T57fMvCJDJLCtpWIQkv4Iux8zR5kNCAfABZJts4Ie413z
 MrcFh9fBaFNIRBp1uDF4YqMBl9Jkv/DrCQjfby8W4jFXTIu8DDZOg7MnJPF9d4cRzQKQ
 oF8R0RJLbEt9Za9mcZOZGdURNmcbVwAmRI8KC9s91ANaLd91iiGL/haVCtEU71P7UTiG
 qiNA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=I4HPsq7H
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=neil.armstrong@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="I4HPsq7H"; 
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/22/26 20:44, Jorge Ramirez wrote:
> On 22/07/26 20:12:19, Jorge Ramirez wrote:
>> On 22/07/26 17:43:16, Neil Armstrong wrote:
>>> On 7/22/26 16:12, Jorge Ramirez wrote:
>>>> On 22/07/26 10:31:04, neil.armstrong@linaro.org wrote:
>>>>> Hi,
>>>>>
>>>>> On 7/22/26 08:07, Jorge Ramirez-Ortiz wrote:
>>>>>> OP-TEE's legacy RPMB supplicant interface assumes the RPMB device is eMMC
>>>>>> and derives the key from an eMMC-shaped device ID, so it can never
>>>>>> reproduce the key Linux derives for a UFS device; secure storage on
>>>>>> UFS-only platforms instead needs the transport-agnostic RPMB subsystem
>>>>>> interface, through which the normal world describes the real RPMB device
>>>>>> to OP-TEE. Add a UFS backend for it so OP-TEE derives a key matching Linux
>>>>>> and can use RPMB secure storage on UFS, leaving the legacy eMMC path
>>>>>> untouched.
>>>>>>
>>>>>> This subsystem backend currently supports UFS drives only; eMMC still uses
>>>>>> the legacy interface. As the legacy interface is dropped in favour of the
>>>>>> subsystem one, an eMMC backend should be added here so both transports are
>>>>>> served through a single RPMB path.
>>>>>>
>>>>>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
>>>>>> ---
>>>>>>     drivers/tee/optee/Makefile               |   1 +
>>>>>>     drivers/tee/optee/optee_msg_supplicant.h |   8 ++
>>>>>>     drivers/tee/optee/optee_private.h        |  41 ++++++++
>>>>>>     drivers/tee/optee/rpmb.c                 | 124 +++++++++++++++++++++++
>>>>>
>>>>> Why not rpmb_ufs ?
>>>>
>>>>
>>>> because in the future (and IMO) rpmb.c should support UFS and EMMC using
>>>> the new probe interface (eventually removing rpmb_legacy).
>>>
>>> Let's see in the future, if somehow there's need for a common "new"
>>> and emmc only legacy some rework will be needed anyway. The eMMC RPMB
>>> hasn't been updated for a very long time...
>>>
>>> Using the driver model to register an rpmb device attached to an eMMC
>>> or UFS controller would the cleanest way to handle that, but we're not here now.
>>>
>>>>
>>>>>
>>>>> It's fine to have 2 backend implementations, the emmc is implementing the
>>>>> legacy optee API, just add a comment in the eMMC file about that.
>>>>>
>>>>> Neil
>>>>>
>>>>>>     drivers/tee/optee/supplicant.c           |   9 ++
>>>>>>     5 files changed, 183 insertions(+)
>>>>>>     create mode 100644 drivers/tee/optee/rpmb.c
>>>>>>
>>>>>> diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
>>>>>> index 8321cf53a19..7af19834c00 100644
>>>>>> --- a/drivers/tee/optee/Makefile
>>>>>> +++ b/drivers/tee/optee/Makefile
>>>>>> @@ -4,3 +4,4 @@ obj-$(CONFIG_OPTEE) += core.o
>>>>>>     obj-y += supplicant.o
>>>>>>     obj-$(CONFIG_DM_I2C) += i2c.o
>>>>>>     obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb_legacy.o
>>>>>> +obj-$(CONFIG_SUPPORT_UFS_RPMB) += rpmb.o
>>>>>> diff --git a/drivers/tee/optee/optee_msg_supplicant.h b/drivers/tee/optee/optee_msg_supplicant.h
>>>>>> index 963cfd47824..b720d5d7b3f 100644
>>>>>> --- a/drivers/tee/optee/optee_msg_supplicant.h
>>>>>> +++ b/drivers/tee/optee/optee_msg_supplicant.h
>>>>>> @@ -152,6 +152,14 @@
>>>>>>      */
>>>>>>     #define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 21
>>>>>> +#define OPTEE_MSG_RPC_CMD_RPMB_PROBE_RESET	22
>>>>>> +#define OPTEE_MSG_RPC_CMD_RPMB_PROBE_NEXT	23
>>>>>> +#define OPTEE_MSG_RPC_CMD_RPMB_FRAMES		24
>>>>>> +
>>>>>> +#define OPTEE_RPC_SHM_TYPE_APPL		0
>>>>>> +
>>>>>> +#define OPTEE_RPC_RPMB_UFS		1
>>>>>> +
>>>>>>     /*
>>>>>>      * Was OPTEE_MSG_RPC_CMD_SQL_FS, which isn't supported any longer
>>>>>>      */
>>>>>> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
>>>>>> index 1f07a27ee4b..2888257aefe 100644
>>>>>> --- a/drivers/tee/optee/optee_private.h
>>>>>> +++ b/drivers/tee/optee/optee_private.h
>>>>>> @@ -9,6 +9,17 @@
>>>>>>     #include <tee.h>
>>>>>>     #include <log.h>
>>>>>> +#ifdef CONFIG_SUPPORT_UFS_RPMB
>>>>>> +/**
>>>>>> + * struct optee_private - OP-TEE driver private data
>>>>>> + * @rpmb_next_region:	next UFS RPMB region to report on PROBE_NEXT
>>>>>> + * @rpmb_cur_region:	UFS RPMB region selected by the last PROBE_NEXT
>>>>>> + */
>>>>>> +struct optee_private {
>>>>>> +	unsigned int rpmb_next_region;
>>>>>> +	unsigned int rpmb_cur_region;
>>>>>> +};
>>>>>> +#else
>>>>>>     /**
>>>>>>      * struct optee_private - OP-TEE driver private data
>>>>>>      * @rpmb_mmc:		mmc device for the RPMB partition
>>>>>> @@ -22,6 +33,7 @@ struct optee_private {
>>>>>>     	int rpmb_dev_id;
>>>>>>     	int rpmb_original_part;
>>>>>>     };
>>>>>> +#endif
>>>>>>     struct optee_msg_arg;
>>>>>> @@ -60,6 +72,35 @@ static inline void optee_suppl_rpmb_release(struct udevice *dev)
>>>>>>     }
>>>>>>     #endif
>>>>>> +#ifdef CONFIG_SUPPORT_UFS_RPMB
>>>>>> +void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
>>>>>> +				      struct optee_msg_arg *arg);
>>>>>> +
>>>>>> +void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
>>>>>> +				     struct optee_msg_arg *arg);
>>>>>> +
>>>>>> +void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
>>>>>> +				 struct optee_msg_arg *arg);
>>>>>> +#else
>>>>>> +static inline void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
>>>>>> +						    struct optee_msg_arg *arg)
>>>>>> +{
>>>>>> +	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
>>>>>> +}
>>>>>> +
>>>>>> +static inline void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
>>>>>> +						   struct optee_msg_arg *arg)
>>>>>> +{
>>>>>> +	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
>>>>>> +}
>>>>>> +
>>>>>> +static inline void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
>>>>>> +					       struct optee_msg_arg *arg)
>>>>>> +{
>>>>>> +	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
>>>>>> +}
>>>>>> +#endif
>>>>>> +
>>>>>>     #ifdef CONFIG_DM_I2C
>>>>>>     /**
>>>>>>      * optee_suppl_cmd_i2c_transfer() - route I2C requests to an I2C chip
>>>>>> diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
>>>>>> new file mode 100644
>>>>>> index 00000000000..9c3e0f031ad
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/tee/optee/rpmb.c
>>>>>> @@ -0,0 +1,124 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>>>> +
>>>>>> +#include <dm.h>
>>>>>> +#include <tee.h>
>>>>>> +#include <ufs.h>
>>>>>> +
>>>>>> +#include "optee_msg.h"
>>>>>> +#include "optee_msg_supplicant.h"
>>>>>> +#include "optee_private.h"
>>>>>> +
>>>>>> +#define UFS_RPMB_CONTROLLER	0
>>>>>
>>>>> Can this be a config option instead which defaults to 0 ?
>>>>
>>>> um, I dont think so - this assumes there is only one controller. If there
>>>> are more than one, we would need a mechanism to select which one from
>>>> the enumerated values (maybe a DT alias (ie ufs-rpmb ?) I think the binding order
>>>> changes as we enable/disable devices)
>>>
>>> It could collide with other SCSI devices like SATA devices over PCIe.
>>>
>>> Usually we try not to hardcode the devices ids.
>>
>>
>> right...shall I go ahead with a DT alias approach?
> 
> 
> something like this?
> 
> 
>    8 ⋮  8 │ #include "optee_msg_supplicant.h"
>    9 ⋮  9 │ #include "optee_private.h"
>   10 ⋮ 10 │
>   11 ⋮    │-#define UFS_RPMB_CONTROLLER        0
>      ⋮ 11 │+static int optee_rpmb_get_scsi_dev(struct udevice **scsi_devp)
>      ⋮ 12 │+{
>      ⋮ 13 │+        struct udevice *ufs_dev, *scsi_dev;
>      ⋮ 14 │+        ofnode node;
>      ⋮ 15 │+        int ret;
>      ⋮ 16 │+
>      ⋮ 17 │+        node = ofnode_get_aliases_node("ufs-rpmb");
>      ⋮ 18 │+        if (ofnode_valid(node))
>      ⋮ 19 │+                ret = uclass_get_device_by_ofnode(UCLASS_UFS, node, &ufs_dev);
>      ⋮ 20 │+        else
>      ⋮ 21 │+                ret = uclass_get_device(UCLASS_UFS, 0, &ufs_dev);
>      ⋮ 22 │+        if (ret)
>      ⋮ 23 │+                return ret;
>      ⋮ 24 │+
>      ⋮ 25 │+        ret = device_get_child(ufs_dev, 0, &scsi_dev);
>      ⋮ 26 │+        if (ret)
>      ⋮ 27 │+                return ret;
>      ⋮ 28 │+
>      ⋮ 29 │+        *scsi_devp = scsi_dev;
>      ⋮ 30 │+
>      ⋮ 31 │+        return 0;
>      ⋮ 32 │+}
>   12 ⋮ 33 │
>   13 ⋮ 34 │ void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
>   14 ⋮ 35 │                                       struct optee_msg_arg *arg)
> 
> ────────────────────────────────────────────────────────────────┐
> • 76: void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev, │
> ────────────────────────────────────────────────────────────────┘
>   55 ⋮ 76 │                 return;
>   56 ⋮ 77 │         }
>   57 ⋮ 78 │
>   58 ⋮    │-        if (uclass_get_device(UCLASS_SCSI, UFS_RPMB_CONTROLLER, &scsi_dev)) {
>      ⋮ 79 │+        if (optee_rpmb_get_scsi_dev(&scsi_dev)) {
>   59 ⋮ 80 │                 arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
>   60 ⋮ 81 │                 return;
>   61 ⋮ 82 │         }
> 
> ─────────────────────────────────────────────────────────────┐
> • 124: void optee_suppl_cmd_rpmb_frames(struct udevice *dev, │
> ─────────────────────────────────────────────────────────────┘
>   103⋮ 124│                 return;
>   104⋮ 125│         }
>   105⋮ 126│
>   106⋮    │-        if (uclass_get_device(UCLASS_SCSI, UFS_RPMB_CONTROLLER, &scsi_dev)) {
>      ⋮ 127│+        if (optee_rpmb_get_scsi_dev(&scsi_dev)) {
>   107⋮ 128│                 arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
>   108⋮ 129│                 return;
>   109⋮ 130│         }
> 

No I was just thinking as a Kconfig option along CONFIG_SUPPORT_UFS_RPMB but
I just didn't find where you added the CONFIG_SUPPORT_UFS_RPMB option...

Neil
