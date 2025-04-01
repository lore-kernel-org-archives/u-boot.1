Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752C5C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 14:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC9EB80FDA;
	Tue,  1 Apr 2025 16:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eHisXZen";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C976281703; Tue,  1 Apr 2025 16:37:44 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3158D801BE
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 16:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so2922160f8f.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 07:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743518261; x=1744123061; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=H97U8UY4VFtbbMgXsOpOjrPHAdXiiCjGzqOyrGA6/xA=;
 b=eHisXZeneqFiQ/MqSUCLUiWEoS0PhZ0f1tt8SLXoac5j+453sl4U560YfWn658LxSl
 Fzqv0Ndpfx8a9coPfdkvR8cee1agT/mrvcBiWNj/MGK3/JBlAr9DNNF56mfOFVqLhM0n
 PbZIoEBZZhcWgwC9fIZRk9IJyyv2aAXNeLyiCuHbZHd+Lf7UPLdayDKGfJJPc8mmnQSn
 nKcoM7zy42rnDvItN1b46VHjRlHCwV0W8qQ+hzG/KRF2kxcmwdWPFjT9tHb0YYF33HS4
 TcQo1yZ83Ov3w76Mys58OR6afr/bWnMHGAoYYylrHcF99wiLmbpKMBsISv7aRQM6jV2x
 ymUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743518261; x=1744123061;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=H97U8UY4VFtbbMgXsOpOjrPHAdXiiCjGzqOyrGA6/xA=;
 b=JAF6MVTuC/ZeUnHjMRG47gPUW3yFzyu/1H5PKFj4vjMI9e+vTjdSKhlgU4V7PZYBiz
 pt7xuNOlYCjxfXiCy7WfbYPWAGnek0/rZOlWgs1c8+eMZuDlPr2QI/7dVOmxRb/UDdVF
 i9jkqAoovlnY7E8EAfzvt3XYILmQT6MNpjAUOA7GZjyKrW66Pcx3dvLkcj2rq7Nq0n+h
 A8YX21WlbEhqLpePSTdB+jTZ92FrOsn70Qpc8isc49KCKoS/k3THwZFZdj7baN2Zl7IE
 b2rzgEwj7VHN9vnzoY1sUAOvwrEmu1dlwKWwceQydCv7j8Wm3AWUSG8GGiYemYf7ARSG
 Rtkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI2OoHbTTWleOGeHsa8y1Y/LL/HmYlicpNoVXaUYKm9xzNs37/uO9X/LXv9JaGzfUoGnw4BtM=@lists.denx.de
X-Gm-Message-State: AOJu0YwAW3nMCcs+AHyPqDIeLFxK8SnmWoA5Uh8J9gplxwU/GfxqZGtg
 MGzrsUY0Cl4u1yRayxgV0u3iWVmxoUMibNZ3Axx3HYmJraNl9xuqGj8S3KWo5cg=
X-Gm-Gg: ASbGncvfVaLanJ0SWvveWUDK3+gkjo/Q0wLxYehFygtEF/hj8V4Yg6cBa6G+7LRuKZc
 6+MVywdA8R47Q3HE+MWRVlwsilgCEAy3B88X6sw0qtKNi6W7q9UT6nwKxO3Wvf4UITZwXxpzLId
 DlpXjAGhLJEylx2JbNCSzYRxtcjnYLmq7WBYZ+GWnDpvbKOs/Coa5rKdGo9FRW5igcqjEkVfQtV
 S+OqKH5IGF1ta1XTi73E6fv+9sRHMAVs1aV6KxiTT5rJNPqYdr/aQc54xdhC9AkERuv7qPGtz8d
 yRKVrc7i+w/tG7Vf4OoEMji2lAtfqE1WY/eifemOavUoLxam8v13e4E5Lj7pUGnE0nrGViHXhMy
 TtU+b06GWwru409aYYyEnIg==
X-Google-Smtp-Source: AGHT+IFUgomJ8iGKd/whgfCnYpYTy//YPwPqpOpAOY+Th8jMbRyrYSk916OY1F+5xRD3cGqwWD+vaw==
X-Received: by 2002:a05:6000:4287:b0:39c:1a86:e473 with SMTP id
 ffacd0b85a97d-39c1a86e5d3mr6869405f8f.56.1743518261586; 
 Tue, 01 Apr 2025 07:37:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9eae:2c33:be54:89e4?
 ([2a01:e0a:3d9:2080:9eae:2c33:be54:89e4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66ab6dsm13986100f8f.48.2025.04.01.07.37.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 07:37:41 -0700 (PDT)
Message-ID: <7a5ac5c2-5bb7-45d2-838b-63fa07766c4f@linaro.org>
Date: Tue, 1 Apr 2025 16:37:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 0/3] Enable env in UFS
To: Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: caleb.connolly@linaro.org, sumit.garg@kernel.org, joe.hershberger@ni.com, 
 michal.simek@amd.com, marek.vasut+renesas@mailbox.org,
 cniedermaier@dh-electronics.com, xypron.glpk@gmx.de, sjg@chromium.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250401080015.1470999-1-quic_varada@quicinc.com>
 <20250401141022.GD5495@bill-the-cat>
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
In-Reply-To: <20250401141022.GD5495@bill-the-cat>
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

On 01/04/2025 16:10, Tom Rini wrote:
> On Tue, Apr 01, 2025 at 01:30:12PM +0530, Varadarajan Narayanan wrote:
> 
>> The qcs9100 based Ride platforms have UFS as their primary storage.
>> Hence add support to U-Boot env framework to be able to save and
>> retrieve the environment from UFS. The environment will be
>> saved/retrieved from the partition specified in the config option
>> CONFIG_SYS_UFS_ENV_PART.
>>
>> Also add an API to convert partition name string to block device
>> descriptor for UFS. This API will be used to get the block device
>> descriptor for the partition specified in CONFIG_SYS_UFS_ENV_PART.
> 
> In general, I'm glad to see this, thanks! In specifics, Marek is trying
> to bring more consistency to some of the env symbol names and so I know
> CONFIG_SYS_UFS_ENV_PART is patterned on CONFIG_SYS_MMC_ENV_PART but lets
> use CONFIG_ENV_UFS_PART instead which I think follows where Marek is
> going.
> 
> Also, this seems to be a generic ENV_IS_IN_SCSI implementation and it's
> just that UFS is accessed via "SCSI"? Perhaps we should name things a
> bit more generically, and it should already support various AHCI SATA
> devices out of the box?

I agree we should use scsi to access ufs, we do not need a specific
ufs backend anywhere.

Neil

> 
> However all of that said, do we want to be encouraging environment to be
> stored directly in blocks like this rather than a filesystem on UFS?
> 

