Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA844CD5BD1
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 09:29:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67A378341A;
	Thu, 28 May 2026 11:29:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nvEzMQdB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC84783FF5; Thu, 28 May 2026 11:29:56 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BE8580398
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 11:29:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45ee5cdbd28so288056f8f.1
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 02:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779960594; x=1780565394; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=BsoS1MB8bbjaY8sUZj56NiHukG3NVG0KPczUc5NlDrw=;
 b=nvEzMQdB/mQCB/ylBW2B9pXwGAyUvEDRKyn2itCQAtLtBGZZq4+O9uAhpWjeYjodvA
 sGzPIG/sPYhf0ckFRA9odQhrAB77pHeu9MdtsvpD+PjmIySFXcv/WqdKqV3/JKzEz3Lg
 0zQDhfcZQiMfKz2REbA9fg7nUWrgb4mrGkCTKUgDBLwroBhMxTHytf66Dgyx6Xbwpcvr
 sd0NtNVekscV6iZ793C84186gp+b4jTIeUFwNWN6OoY4pqCfMgXRIPRgnb6mSBzyp8hu
 Ut4bdhDV6KADYtv9Qdc9TOaBw1kIAEcl+brZReR8ttJMhzzKjq0G5Vrns+P9DdpGyyYk
 YgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779960594; x=1780565394;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BsoS1MB8bbjaY8sUZj56NiHukG3NVG0KPczUc5NlDrw=;
 b=Vh3xbAP4rgFDZK2V1upuGqvhULGsWP3Tj2WymUNARN/uHEEpTY+tWRPTTmLDGHTlX5
 9Q6auQga8zEP3qEwOAsXPG2mPqwv2c9tJwqO5w05Cia4LSOJkN5mERVd+oTloj8StqVm
 sdwMNT8/Hl88UE6hOvdY5qbPt30krfOC1oRgKsb4ztYprjhxtc437CaambkLJ1QCCwWT
 RJvzvgAozxPaqmeCFLzlZQwba0WYlZL2SACXcIGK5ETeYlYgROj7FjK4YhB08z0laQZm
 h9Of+FyYc0Rlt6Ehl9NysVjdnaTALhg5BNBbfDKRJkr9DzqYf9/vgag53X6L9CrcCb/I
 6Ldw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/riL4zai/e8ySP88YaR65TtggKm52xnlgEVEodaGp7cGmHQIF7ZpAI3EvUKVmnrHlJFrDlcL0=@lists.denx.de
X-Gm-Message-State: AOJu0YwAXbRrtyl8J+k9cvvfQXUcWjSwchOkrsqioMVXRZIzj4qhrjgr
 5Eg+gnSZYvjxpWgFCnZTIJX3DKy5rZTC5Ibi9S03Q9swXpD3cDa+0t9ViCB0v9rNmIQ=
X-Gm-Gg: Acq92OHBoyphhC239N+EERspRAwfpT89vXTE5WRJNFWl9jdPhm6/ASfVf5vFMWfb7uw
 YLF40Q2pr2Q9Soy59DJCN0nlW6ASjyS1Cd6gGf4vPjeuBVRgMk29LHtotXZbSXZwf5b+ZI5wE3k
 Vje/TUAVFOs7vsxrFcu5BIlYzCpjr/e8bg21jIP/sppEBbyCQ2swBQ3QonloCUNfiYwS6w6D22C
 mWdnVRDyiCCamBRfXGpt9jqQD2ma1ODyAcZofHKYApj8ujp53vB2BYBmy5zFWbTPMQuTUorRQ7R
 S7NOqwsAvVpQUO/zCUuW8Ixopfne0gZiQ6lOAoVDx00C9WChzhTmV4dg5vfjjVO0yfwJm5YJDQM
 yB5TuIK+gEvgrGlqWodnNPqp5Cmx9EHN9nPiSt6Al96evpmlN90Vna68+IHOmslgyTyMcvvChm/
 524RnD1OVPkKU2z35OAvtkQP6gxJ5cVVV76f8/Yh7HKO4=
X-Received: by 2002:a05:6000:238a:b0:45e:6876:793b with SMTP id
 ffacd0b85a97d-45eebc8d0d4mr1486043f8f.28.1779960593518; 
 Thu, 28 May 2026 02:29:53 -0700 (PDT)
Received: from [172.20.10.2] ([37.167.60.147])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eed49f19bsm431020f8f.14.2026.05.28.02.29.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 02:29:52 -0700 (PDT)
Message-ID: <93b97c39-b3c8-4ec4-83f0-af1ca93fceec@linaro.org>
Date: Thu, 28 May 2026 11:29:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] cmd: nvme: Add flush support
To: dmukhin@ford.com, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com
References: <20260528012056.1744362-1-dmukhin@ford.com>
 <20260528012056.1744362-4-dmukhin@ford.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20260528012056.1744362-4-dmukhin@ford.com>
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

On 5/28/26 03:20, dmukhin@ford.com wrote:
> From: Denis Mukhin <dmukhin@ford.com>
> 
> Introduce `nvme flush` to allow users to commit all dirty data explicitly
> to the current NVMe device.

This adds flush for all blk devices, please rewrite
the commit subject, message and update all blk commands
and not only nvme.

> 
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> ---
>   cmd/blk_common.c | 14 ++++++++++++++
>   cmd/nvme.c       |  1 +
>   2 files changed, 15 insertions(+)
> 
> diff --git a/cmd/blk_common.c b/cmd/blk_common.c
> index 56529702a470..d3b00e10f17c 100644
> --- a/cmd/blk_common.c
> +++ b/cmd/blk_common.c
> @@ -37,6 +37,20 @@ int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
>   				printf("\nno %s partition table available\n",
>   				       if_name);
>   			return CMD_RET_SUCCESS;
> +		} else if (strncmp(argv[1], "flush", 5) == 0) {
> +			struct blk_desc *desc;
> +			int ret;
> +
> +			ret = blk_get_desc(uclass_id, *cur_devnump, &desc);
> +			if (ret)
> +				return CMD_RET_FAILURE;
> +
> +			if (blk_dflush(desc)) {
> +				printf("\nfailed to flush device %s\n", if_name);
> +				return CMD_RET_FAILURE;
> +			}
> +
> +			return CMD_RET_SUCCESS;
>   		}
>   		return CMD_RET_USAGE;
>   	case 3:
> diff --git a/cmd/nvme.c b/cmd/nvme.c
> index f2c9acba5c32..21ac9a6fac7a 100644
> --- a/cmd/nvme.c
> +++ b/cmd/nvme.c
> @@ -46,6 +46,7 @@ U_BOOT_CMD(
>   	"NVM Express sub-system",
>   	"scan - scan NVMe devices\n"
>   	"nvme detail - show details of current NVMe device\n"
> +	"nvme flush - commit all dirty data to the current NVMe device\n"
>   	"nvme info - show all available NVMe devices\n"
>   	"nvme device [dev] - show or set current NVMe device\n"
>   	"nvme part [dev] - print partition table of one or all NVMe devices\n"

