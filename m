Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3E9C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 09:14:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C8B4809D4;
	Wed, 23 Apr 2025 11:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gbOYS3Sz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EA8D80FA8; Wed, 23 Apr 2025 11:14:32 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C090F800D7
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 11:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39c1efc457bso3987494f8f.2
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 02:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745399669; x=1746004469; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:cc
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=l/+4vKKuZMyfWtXjT7YL1QAVeQPDsVArICsGBWtFxJ0=;
 b=gbOYS3Sz0H/Y4Um3ikScc8JIxYZTEwHAGPfKpLCCzvRqaNU5HyHBImmKXE6D1W70/O
 XA/Ynd4V+5f2AwheGOigBO8HCuT2q/endhEw085Q3oUTO2CldEMMSSyv1qwFOcV0VPrB
 rl7d/6i+HqxD77ms/IBsDw4ptvajfJL985W40VfPY1fD/omMDJoTuUML0jZr3+wRf//W
 6roxvQCTA3dCRei/2AcNs/o5mpoDjVFIGYkEmlel878T1o4THI0OuzI7PlZHISvO9o/Y
 5B4NdAdJQ6PecW5sqxuZ9au0RmHWhpdeQFMpwssooScQEKDI/M/H4JQ6c9Nj4bbnvIWP
 0aDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745399669; x=1746004469;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:cc
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=l/+4vKKuZMyfWtXjT7YL1QAVeQPDsVArICsGBWtFxJ0=;
 b=U0eKWAPPWLATwmDMzfQu+QG2QV0edqppTiItP+WXcm/ZI4GhLe921glPFYRAW1fH+h
 Kz0rkBlIc1f+e7ywxZmx8CtnlXQTd6RkyIQ/6otUZD5wC0Ujw/jWBuvI1tMnuurNHpBJ
 kSS8lhcqSPXfI6/lfTKWrx1uEIe43ECRYGUWC3RWGYbvBox05ucmDfiq9Yvw0XnSdY1x
 GlI2fyl6c79V9IqDJkSOO1LmO7F0+Qedmt4dINeusc447vA+yoz4/QGPudnHbcGULEv+
 AKag3QUJ9jH4kRy74DQtcqP/8hblsu4Wd2JKRQ9E5nMrVGJkH54Rayml3Tl1xAtYheIW
 YnuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTgKN6CZ1AHTSv0KQLXBEclaKSeQJoFnUfFKVgfdIUYmplBTnEKPrHqKD69M3f3dnY43gh4Zs=@lists.denx.de
X-Gm-Message-State: AOJu0YxV0cNuovg6VcoC264xLJ6r3gt0VRsu7Uhr7DLaKEuKDKHChSRl
 X0DUzz2pl3944zRgFT29rxrFRK67SfXfcruMFC9qhXGmTqN+LAUlqyIrfm6Bjks=
X-Gm-Gg: ASbGncsALEjFx2Z4N5oGmiBPW4EuNAv1dlWqVpmvuviTqacsm+xvn70NPBcIy+fwGjf
 8cVfnekH9sQyZ2vIIsAK0zOj2S9Wi+wod360BMwFHyGot6YyRhGCEO8vKJYDiZXnBCCvuY4jHqw
 UGObVF8HuKTQmKObcEQ5ghAo3DlV59Vwu6SFLHmK+PXheaSZWa+eRwNGygwMYzPRw0dVQKXVvPx
 UoUJ1vO6OMnQDpeDNsiYhnD5oN7mw7aPU0uhGjkfecINGxYmh978EDzHQ9f4kBwUqqM3va/eTyA
 d79Gi1w+D+jLOjhqpwfJVz79HNmlkI5ktWuPwae7fG3PVip0vCoEKSFMzPtCS8uya3puD+obM09
 ccvv0ZSIkdE/Er6KJtQ==
X-Google-Smtp-Source: AGHT+IGm0+ljMc+E/mQzO2T6vO0aDTe1Uj11qmdDLIkwYnnu51lI8TDAEKMid9IrwELkl2S2dvPSpg==
X-Received: by 2002:a5d:648d:0:b0:38d:dd52:1b5d with SMTP id
 ffacd0b85a97d-39efba2e5bfmr14157565f8f.4.1745399669152; 
 Wed, 23 Apr 2025 02:14:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:2835:c2f4:c226:77dd?
 ([2a01:e0a:3d9:2080:2835:c2f4:c226:77dd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa433104sm18121180f8f.29.2025.04.23.02.14.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 02:14:28 -0700 (PDT)
Message-ID: <132c8659-c000-432f-9d2d-7712de50fdf3@linaro.org>
Date: Wed, 23 Apr 2025 11:14:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: Wiznet w5500 support
To: "Verdun, Jean-Marie" <verdun@hpe.com>
References: <DM4PR84MB1976607AFF39ADF74D9AAF7BD6BB2@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
 <3f221717-b5a2-472c-888c-cc8f777cde40@cherry.de>
Content-Language: en-US, fr
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
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
In-Reply-To: <3f221717-b5a2-472c-888c-cc8f777cde40@cherry.de>
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

On 23/04/2025 11:03, Quentin Schulz wrote:
> Hi Jean-Marie,
> 
> On 4/22/25 8:36 PM, Verdun, Jean-Marie wrote:
>> [You don't often get email from verdun@hpe.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Hi,
>>
>> I have written a small patch for the wiznet W5500 adapter. (https://docs.wiznet.io/Product/iEthernet/W5500/overview).
>> I am in some ways ready to push it into u-boot following approval from HPE, but as that will be a first for me, I just wanted to get feedback from you.
>>
>> The wiznet device allows me to add a network adapter to deep embedded devices like PCIe board and boot them by using ethernet through a spi bus or gpios by using the soft-spi drivers through u-boot. Usually, such devices boot locally through a spi-nor or other local storage. I want to promote a PXE like approach as to ease firmware updates, improve security, and boot speed. The wiznet device can load raw images at about 1.5MB/s in memory and the u-boot is in charge at bootstrapping the second stage through the in memory copu.
>>
>> I successfully tested it by using a raspberry pi 4 device through soft spi as we do not have a driver for it inside u-boot. It works at around 360kB/s compared to 400kB/s through the linux kernel.
>>
>> Wiznet device needs in fact 2 drivers, one which behave like “PHY”  and one which is perceived as an ethernet adapter. Both needs to be linked through a phandle as to use the relevant xfer function to push and receive the data.
>>
> 
> An Ethernet MAC you meant I assume.
> 
>> So, my patchset will contain some work for the spi subsystem and some for the net subsystem. Do I need to break them down, or a single patch would be good enough ?
>>
> 
> Separate drivers, separate patches please. It's likely going to go through different maintainer trees. They could be in the same patch series though, to give everybody ample context.
> 
> Having had a quick glance at the diff in your U-boot fork, it's very unclear to me why we need an SPI bus driver (UCLASS_SPI)? The Linux kernel seems to only have the Ethernet driver. Is the w5500 acting as an SPI controller instead of as an SPI device? I find it hard to believe, but maybe :) ?

Yeah looking at the code, the SPI controller driver simply call the buf xfer, so it can be dropped.

> 
> I believe you should only need the Ethernet MAC driver (possibly Ethernet PHY driver as well?) but built on top of an SPI device (and not driver), essentially just calling spi functions taking a udevice as parameter?
> 
> Look at drivers/power/pmic/rk8xx.c for example, it is a PMIC driver for an I2C (or SPI) device. Or for something closer to your device, maybe have a look at the KSZ9477? It seems to require I2C and SPI (but is a DSA switch, so slightly different than yours).
> 
> Additionally, we do not allow modifications of the dts/upstream directory. The patches absolutely need to come from the devicetree-rebasing tree, via the `tools/update-subtree.sh pick <commit>` command, so please upstream the binding to the Linux kernel first.

The w550 bindings are already upstream in Linux and are already in the U-boot tree in `dts/upstream/Bindings/net/wiznet,w5x00.txt` so the driver should conform to this.

If you want yaml bindings, please convert them to yaml and submit them to the Linux mailing-lists and they will be synced in dts/upstream when the next Linux release is done.

Neil

> 
> Looking forward to seeing patches on the mailing list!
> 
> Cheers,
> Quentin

