Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620F4D3B7CA
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 09:43:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A52E389189;
	Tue, 26 Nov 2024 10:43:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xmPVLzOC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0AD4885F5; Tue, 26 Nov 2024 10:43:17 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 864558967E
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 10:43:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-382325b0508so3586366f8f.3
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 01:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732614195; x=1733218995; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=F6E6eXKMgQ5NOgoU0nBoYBT6jEc3FUoeGiLK3Moyu9g=;
 b=xmPVLzOC179st6e0xaW5IcvbSEk8p4Mq1it/MipH6ZoPixHpRSWAeKZlrbcsrHdUD0
 qA7ETVCYZaOVdrBtvCvD8Aey69NT8yCiacK0VU79urcSnLdVm4bmOnELfu/ChpTNpTsU
 QYuZOrlbqjW14Jw+e+ytoELNUkXXmaPTZkxRL8jpV2Ga2TOza6PZmeIAFuRDed3XxkZe
 B/liIaeSvT0KteXkgVqiN5PYHR9y8w8ZnVnETlyqOdh7o4cL1hHoHo0O9R6alu5dfL4I
 b1OxS/6yAzHk1GR71GwHPUiDlf85PVZgYa4cL3xwyzNE9oXWwVkhxdTeuP93N0KgOuQq
 3REA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732614195; x=1733218995;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=F6E6eXKMgQ5NOgoU0nBoYBT6jEc3FUoeGiLK3Moyu9g=;
 b=YdeKDVkxDmMjPDLTLfad990fzQSUN6vLTReazELto+L1nogdsNALQiB/Y9nQNap/aQ
 F7VTT32DoyT3RyY30L0vSiOzMLd0Rc8kJkE1YQyF5tAT6bI1P8dyo0/18IHuPPwuUHIU
 bGSwwYXudpQsM7pXKfA/XEU4fp55wcOXZc9k70xSDZca6jMBWj9+TNHa6Dz+J49YlmWw
 +dGiGaFjRT82uwhTFq6svSsnnuaVO/C9CRNU+4X5nMah0mnvh7jKfMxvOO6lLpkQq3/x
 lm0X76OPn/NdugTQyThvKv/3AQYZBKXuZXKQcwjpFVRAYpWnbYfiw+xMkJBJyrB1hURZ
 CTZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTuHtphQzTjcXkmcROz+wFMZenJuyBRRifCzASVo4fv5BtXpWvusny5+L0UzSByBLlJIL2d0s=@lists.denx.de
X-Gm-Message-State: AOJu0YymEgU4dHol31bP66Ilh8xgS9iuZDyh2Vy83l/hr4oiaZh+PXpd
 QebU1QKE639AxBKGC6nlbXj1XmbLwwGwUhWkYzvDhKUvPbEMwdtKvT08zpZpzrw=
X-Gm-Gg: ASbGnctRQluRAQnoODYU5bWF0a+nGATD/2iyx4btJRDWWRMkNEsEBXClHb+nBHhTssl
 J/eMbkjKyysHl2EnEJT3nD9eFPnY/0SaYWJbRM3tXhTMEsYqioa13kX1mEQ9SnCsqsPbx39Lu5Z
 9tUlF0yT+Amim7+zzHudUEZC5OM/0JzgTm7gaY4n+r4S2h5NiUZZBEP3OdTAkTUIO1mmzsOcPn8
 fdiV41wgSRUPP2nvBHGnoN7jAlL777VRDOnjBRlCYhk8AyHBFkAjIlFrkyFzwT7WJMoRdhI81eU
 9Tzwk4Pw3KEjneLByEYRwz/lx6A=
X-Google-Smtp-Source: AGHT+IHIcr06Af5LzVvB5+BA5NdQ79bZrMPK8o/f5rhPAJ3HHQJHA/0QCjj3rgc2kdDQDjJuK7r0VA==
X-Received: by 2002:a05:6000:1846:b0:382:2976:c27c with SMTP id
 ffacd0b85a97d-38260b874d1mr12204360f8f.30.1732614195027; 
 Tue, 26 Nov 2024 01:43:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:3ee2:3d5f:efe7:5e46?
 ([2a01:e0a:982:cbb0:3ee2:3d5f:efe7:5e46])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc3289sm12739267f8f.64.2024.11.26.01.43.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 01:43:14 -0800 (PST)
Message-ID: <71ac662a-1131-41ea-ab82-9c423996b89d@linaro.org>
Date: Tue, 26 Nov 2024 10:43:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/6] ufs: core: initial cleanup and defines sync with
 Linux v6.12
To: Love Kumar <love.kumar@amd.com>, Bhupesh Sharma
 <bhupesh.linux@gmail.com>, Neha Malcom Francis <n-francis@ti.com>,
 Tom Rini <trini@konsulko.com>
Cc: michal.simek@amd.com, marek.vasut+renesas@mailbox.org,
 bmeng.cn@gmail.com, venkatesh.abbarapu@amd.com, u-boot@lists.denx.de
References: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
 <4838b206-6701-4d03-b291-95bdd691e378@amd.com>
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
In-Reply-To: <4838b206-6701-4d03-b291-95bdd691e378@amd.com>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 26/11/2024 07:43, Love Kumar wrote:
> Hi,
> 
> On 20/11/24 2:52 pm, Neil Armstrong wrote:
>> This serie fixes the build and checkpatch warnings, and
>> does a split of the ufs.h into a separate ufshci.h which
>> helps syndhronizing the defines from Linux v6.12.
>>
>> No functional changes intended, tests on hardware
>> are welcome.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> Neil Armstrong (6):
>>        ufs: core: include missing include/ufs.h
>>        ufs: core: mark unexported functions as static
>>        ufs: core: cosmetic fixups
>>        ufs: core: move ufshci defines in a separate header
>>        ufs: core: sync unipro.h with Linux v6.12
>>        ufs: core: sync ufshci.h with Linux v6.12
>>
>>   drivers/ufs/ufs.c    |  43 +++--
>>   drivers/ufs/ufs.h    | 335 +-----------------------------------
>>   drivers/ufs/ufshci.h | 469 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/ufs/unipro.h | 128 ++++++++------
>>   4 files changed, 571 insertions(+), 404 deletions(-)
>> ---
>> base-commit: dc1859f8d2ac3faaa5e2e1d465ec4bd8980520a5
>> change-id: 20241120-topic-ufs-cleanup-23671e3fc9e9
>>
>> Best regards,
> Verified these changes on AMD platform (amd_versal2_virt_defconfig) and didn't observe any issue with this series.
> 
> Tested-by: Love Kumar <love.kumar@amd.com>

Thanks for testing!

Neil

> 
> Regards,
> Love Kumar

