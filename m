Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33119D2D8E6
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 10:22:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9416083F53;
	Tue, 27 Jan 2026 11:22:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lLYL+OMo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED01B83F9D; Tue, 27 Jan 2026 11:22:54 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A02AE83F50
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 11:22:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4805ef35864so17398255e9.0
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 02:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769509371; x=1770114171; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=rdCtmpPX7/OdeR3hu/m/0MxtWrU1rpBJ0xvuDf5/9TE=;
 b=lLYL+OMoZsePP9kx0BImc9lRe9bPF90NOQlqYg8syxtiM0dEzGz87ZaRSLug5ze4DB
 3Fp56zW3R8mL6HU/FQNsSmnGgzgUpgjKfEQMpp+rR01PR1kNzz0kw00Q6jK1jzWHN3m8
 3Tm/bgvWxb/nKiXmtExJoZvz+bu9nZ0HfkprMYY6oez+XRuqcWAfRlfO+WMEIpcIydS0
 drc81YH39Qab+B84nliD7zVXv3NN1FrkBZ94QDrnGEv+u/Ak195dYB02ip7gXnfqg47v
 WiyhLbhpvC2VrS6DTMW5uJZ/PLTpBXX7Th0MC4N/N0Xv+kqebNbH0LsHAqPNtXDu4SLM
 noRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769509371; x=1770114171;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rdCtmpPX7/OdeR3hu/m/0MxtWrU1rpBJ0xvuDf5/9TE=;
 b=DNu+RroYNWwD01ksQErNvje3Z5g7KOAWxRi793a/SRkX7y4ag+kMLcaBt+1iWVYvWp
 RkD4+nAn+E1+jiTI7QKXpDOUYBKT3YxZxC2zWaUuZuHdVYXV5v04ds+W/yOGi+VXeqjc
 IUmIUfEXij+dQnuifl59UdE9R8SrPAuEm/lZnbVjijDvjD55L23IWwDf0ArxwdmChisU
 gvTlcZa2k1GfiKyZP+kl26qSntqLK903rzzfh69fFl4XQsdPswr+jwDJ9DljSto5Xetc
 bdvBH/6JG6/Ev7J5ES/12KgguHV3KJVZNhXAmNPIOYi/NvR9EQob1s0LZX6/FS0Sc9E+
 VSyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6c5asVW7JjVzFC8L9yFek0wgAGEjBI+Wgnd73EIpDmjjJuQTU0cSxy5Ax75or/JVvu8WKo9Y=@lists.denx.de
X-Gm-Message-State: AOJu0YwmHAZJZIUabx+ELEHguhmwI/4683mP3u50NPALD2bgZKfPCKqd
 RviMmHzx9qH3tP2m/koVoTnpQYQtQoqXFAiZcPrZeQyUY+v+ovkIpaFZVTzARqhw4oI=
X-Gm-Gg: AZuq6aLewxjEz9FiEljldsxqCfMJOjySfOu6LE2J9RtcEnpmqABDg4G4SH9/pNd0hlm
 o2FAnwzW+4R6a4yxsmZu9+NsvKO4jQw/1ryAsRdjg1vBbz9a2sMQmcVC9F+JdFOCMoRP2nBcl/W
 UKMLkEk+MHCMR3ZtzHopbqexrDQ7NpAmxwtrq3I9wwLKQOlK930AvcB+cel3E8XE/X7x7SRz36m
 40wDSehC9lLndQk7ANKPjOnuVVzzHlqb4kLPHUNdYbAVGgYMby6XYcA/8Jvk84e5lPXzgnmTJEq
 EhAN+vfUhHnvZVbhP7SDkjE8sn82MSNvLwEwM3KSXRVk5adeKyx4CLZhdeFyLLVQtA3SW1WOdnC
 qjsAxeOiWGlxNyi0DO/OuubcX5zYNBXDEiCvf0SPNCCTXEkng85YGpwd1LIXMLAVoZshk+AxcT+
 nEWumU4IIQkeFummywbjkjKOH0s73Nx/nmm66JZj7Vxxgur8UUigNazs0J6k0dB/I=
X-Received: by 2002:a05:600c:4f0c:b0:477:9cdb:e337 with SMTP id
 5b1f17b1804b1-48069bfaa18mr19185205e9.7.1769509370836; 
 Tue, 27 Jan 2026 02:22:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:53a6:bd3c:8e65:509d?
 ([2a01:e0a:3d9:2080:53a6:bd3c:8e65:509d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066bf7c58sm53125885e9.8.2026.01.27.02.22.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jan 2026 02:22:50 -0800 (PST)
Message-ID: <956d86e5-6bef-47b3-a436-9acd03b38aec@linaro.org>
Date: Tue, 27 Jan 2026 11:22:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 5/5] scsi: ufs: renesas: Add reusable functions
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
References: <20260103002254.183357-1-marek.vasut+renesas@mailbox.org>
 <20260103002254.183357-5-marek.vasut+renesas@mailbox.org>
 <a99b6773-5bd4-4030-9308-59db9d4d0fbc@linaro.org>
 <e3100b4b-98e6-4a08-aa26-df9dcceac235@mailbox.org>
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
In-Reply-To: <e3100b4b-98e6-4a08-aa26-df9dcceac235@mailbox.org>
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

On 1/26/26 19:13, Marek Vasut wrote:
> On 1/5/26 4:20 PM, Neil Armstrong wrote:
> 
> Hello Neil,
> 
>>> @@ -244,9 +275,7 @@ static void ufs_renesas_pre_init(struct ufs_hba *hba)
>>>       ufs_renesas_indirect_poll(hba, 7, 0x41, 0, BIT(7));
>>>       /* end of phy setup */
>>> -    ufs_renesas_write(hba, 0xf0, 0);
>>> -    ufs_renesas_write(hba, 0xd0, 0x00000d00);
>>> -    ufs_renesas_write(hba, 0xd4, timer_val);
>>> +    ufs_renesas_init_enable_timer(hba, timer_val);
>>>   }
>>>   static int ufs_renesas_hce_enable_notify(struct ufs_hba *hba,
>>
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Do you plan to pick this series, or shall I take it via sh tree ?

Yes please

Neil

> 
> Thank you !

