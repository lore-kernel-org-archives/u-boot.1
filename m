Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED66CD98F2
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 14:19:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30325849E5;
	Tue, 23 Jun 2026 16:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OW34cMOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 610F2849EA; Tue, 23 Jun 2026 16:19:06 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDD5D849CE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 16:19:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-3967738c801so53536591fa.2
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 07:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782224343; x=1782829143; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=1QNFPOt15OI7TybwNlQneidcDYOrAbOUUNpsCvFybos=;
 b=OW34cMODchtgzLmmKHm10VJ4KxrBUrgDYoq4UIHA/u8JF3CSEESnV1kLN1SyJVaP7e
 POU9gNNqg+w53fzbf/h5EYDzPtmXnpuUANE8GGXR72fMtvZSHezqoyEPFCv0Fw/S4Q6z
 4wp3xkdxc5qztoWU9gpXaIQHumDlkpoKSMKRLHNEeVtcc8pkzMcBza44ADoNnDWhOxK8
 eE+6wu8SWu/6oEiSuxhT72nR/Amn/KLuYEJ1zsqFieX/uYqLcTZ4TWq6NAXdlOV5NRkr
 6rGtoRZIBe3JiiqktdjTfLwRRXbwMgLs0mMNXMAR5wHqMWhZd0dQZ8w7k8Je44mBHToV
 QT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782224343; x=1782829143;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1QNFPOt15OI7TybwNlQneidcDYOrAbOUUNpsCvFybos=;
 b=GWGiLk4wpzcLHyU4Mu5IqxUA5EYX8b7QkLx8X0EbslzI/WBd28kVmc9bJo0d1JI6Vb
 aqYkBsH1QOgWErYZmBqGr8nxKcg3G9T5zwWs5tZTHwt6/NQ1bix2ET1YrUH1IlnhU1n5
 uko989pj7IYJj/0D9yYOQ81eTpDt8/V3vs7AwvUo7P3KKcjAFC/WbyO3dccjnSxPMGhL
 TDZZ0jdePPoEy9qWCsPP88zSrensN7+ysbxzjq5D7DrDxEaE0tP0MmNcQsmEs0nmtNuf
 65oSgwqmQ2ipXEb3QMEHQ5wJU5TMV2o7day5tbpSWanZWLTxZDQ6RhTX1vEI6Zg2Dg8p
 jIAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/TX4D4S+hz9Y85/sChWx6DQINYpZsW4MOxvyEr4IN0yOAE0S6qWgI6S+B3LycgFRcwkUAPJYQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwgWorkFNaRWNvz+jR5SGihbrOLwP+V3wCBcuUWcVMO3fIV8pdg
 NStPDufucCZwcYxjQTWn8f6TcItcY0wUaEF6GAgRTpXsD7WKNx9xxFgTbgIZvm3SbIs=
X-Gm-Gg: AfdE7cmcFAb0FuMtfw0NE2s2Tfj1Dw/NVUQ0GBq4tmM6nYrT6GEKsJXZQmcKSuoRrPE
 GvWWSRq/JmDrZQ2kYFz9KC2+0J4mcrev7LTf+mTNmVrTUB8sVSy13Rau316RwpJ95yuV9SqLCjw
 iw/4J5UyY3tYZ4Aw+0NHHtll6E4+CjXmRW56X1kEdvVOefF3uYkI/rlSPpKKiW4g+ixqL4mkItD
 AsTsmLfWiHXbfSjG7cQiqjPNXy7YagxF7SW9tquyqAWJaF39diXFcaUxj/HAr3SuC/mBh7KzZrJ
 lXLSqPE6OzAdSMrfg7NrjtEwROJdupSyLv31dL6QDY68G4jKdGvZ3eNVDkv/55quv6v6hANyuCC
 ta9RU7i85gj1i8JFHtzv+yaw3xlVKXDHPI6laya4/kzWP+PXUN/IMRsHvJBLnk/Ku5U81P8CYx5
 nj7BCeYKUENgxbMG15kEJ4yAwFXbCQFU8VW8BYLhFBBc1Y4U6u9DmdvKATwCHeXUSycrx0HFryZ
 hJOh/w=
X-Received: by 2002:a05:651c:513:b0:396:9b1f:a8b9 with SMTP id
 38308e7fff4ca-3998bc2b690mr53985831fa.6.1782224342566; 
 Tue, 23 Jun 2026 07:19:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1ad1:3e6d:c980:680b?
 ([2a01:e0a:106d:1080:1ad1:3e6d:c980:680b])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999b1b1a7esm27534201fa.40.2026.06.23.07.18.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 07:19:01 -0700 (PDT)
Message-ID: <f0044913-eab2-4493-9dd5-c1ade7973db6@linaro.org>
Date: Tue, 23 Jun 2026 16:18:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC v2 4/4] all: Fix lists.denx.de links to
 lists.u-boot-project.org
To: Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.u-boot-project.org, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tony Dinh <mibodhi@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Javier Tia <floss@jetm.me>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Heiko Schocher
 <hs@nabladev.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Daniel Golle <daniel@makrotopia.org>,
 Simon Gaynor <simon.gaynor@ezurio.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Alice Guo <alice.guo@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, Yao Zi <me@ziyao.cc>
References: <20260623-osuosl-ml-switch-v2-0-28fd46e89e46@linaro.org>
 <20260623-osuosl-ml-switch-v2-4-28fd46e89e46@linaro.org>
 <d40725cf-7f70-4038-8a67-aafe04f90119@cherry.de>
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
In-Reply-To: <d40725cf-7f70-4038-8a67-aafe04f90119@cherry.de>
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

On 6/23/26 16:12, Quentin Schulz wrote:
> Hi Neil,
> 
> On 6/23/26 3:22 PM, Neil Armstrong wrote:
>> The U-Boot Mailing-list is moving to the lists.u-boot-project.org
>> domain, so fix all the links in comments still referencing the
>> list.denx.de domain to the new domain.
>>
>> The URLs were manually updated since the mailman links don't
>> match anymore after the archive import in the new mailman instance.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/powerpc/config.mk           | 2 +-
>>   board/boundary/nitrogen6x/README | 2 +-
>>   lib/efi_selftest/efi_selftest.c  | 2 +-
>>   tools/rkcommon.c                 | 4 ++--
>>   4 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/powerpc/config.mk b/arch/powerpc/config.mk
>> index 6e30df6504e..26fcdc4e884 100644
>> --- a/arch/powerpc/config.mk
>> +++ b/arch/powerpc/config.mk
>> @@ -32,7 +32,7 @@ archprepare: checkgcc4
>>   # GCC 3.x is reported to have problems generating the type of relocation
>>   # that U-Boot wants.
>> -# See http://lists.denx.de/pipermail/u-boot/2012-September/135156.html
>> +# See http://lists.u-boot-project.org/pipermail/u-boot/2012-September/135156.html
> 
> Sorry for the mangled URLs, it's changed company-wide at the server-level so nothing I can do about it. We went from "please don't click on any suspicious link because security" to "click on this very long and incomprehensible link wink wink", I'll never understand.....
> 
> In any case, wrong link. You want: https://lore.kernel.org/u-boot/1348500648.2514.2.camel@petert/ or https://lists.u-boot-project.org/pipermail/u-boot/2012-September/134737.html if you want to stay on our archives.

I think we should move the links of the mailman archive since they can possibly change if we re-import or migrate
to a new mailing list server.

So my best would be to switch to https://patch.msgid.link/ with the message-ids, I'll try to cook that but since
the mailman interface doesn't provide the message-id it takes some time...

Neil

> 
> Cheers,
> Quentin

