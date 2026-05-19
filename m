Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CD5CD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 15:48:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D4E284879;
	Tue, 19 May 2026 17:48:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bstWmxvh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 165DF8489F; Tue, 19 May 2026 17:48:01 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0328084870
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 17:47:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45e8a834cc2so749147f8f.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 08:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779205676; x=1779810476; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=aAaJ9hDD2D19n2kWDaC0CtGsIHjrEEFtwlcHp7njzu4=;
 b=bstWmxvhCGI0iZUlOaQxYOCBwSwMSxMItsqtuyylO4YTeFS3i6PG/en3TypMwOrwZz
 v78G7tOeJeboczNsexUfY0s0IO0BIAMUNckY6YhYChIYOjToTzUWx/1WgNCRjJtUGElj
 ii7TjhSLQR8JQ1cWZS6JYvIJe+mxPEZ30eJBPyjLpPEQhypitU862xYk238D/Wmv1DtJ
 RUMn6xifBOW3WSaO25k6G8OhLBOis3zFpIDVr+pWxqDle2SMCPGnu5l3ZzJYeYSOCsMs
 +XwcfXABCoDmcgjlozuW6v6QucRdE88W2dXlDBCZEbho8A6LHQMYbl73qD827FQVoh53
 FNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779205676; x=1779810476;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aAaJ9hDD2D19n2kWDaC0CtGsIHjrEEFtwlcHp7njzu4=;
 b=JblU05B6h2wBJi4ZQqqh+CtoBHimBTyQeOGH3sY/Yr64kyfo16wb+9WvZJDHOUJdxY
 fh2aX36dsqpaNGlrTXT7knTe3s0T/KXfdWkXwHVooGVuy8mEGj6hF5aSB5YYwcroAlhC
 YxDcSagsSDxoFf0U4txK6z/hkRSIi7Me+FbJshplTirm8qux+tDkXf+W5FZ09aDAsC0m
 QnjthE0dYobLIY8AsdyOpJRSY1KCrIKHcRvgpnkokobF2kS00SvCn9s3DgTKRwILY865
 6HRxgJ8seOts5UMZ+z8XkrkeW3HJho1y4RFQXZ5NZwJ+8G1b+YLD1nXb0zzvl9SYUc9s
 xORw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8v6EXTCNW3nubKe9J6Wj1Jd0ToBGi7duOarJSaKRBiPYfBX5Rv7vWzdZW4i2q4LnBqGqsThSs=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8rjGIBGq0gVNK08SwaneITyMajFPuRrQeW65NSm+QnW6j3Tij
 yFvFHkOr8vigq5/hZsXKjAskH2eTRQNIOwyYVTNLbza6JRiU96U5cVT5JYHw2b37i7MKuCLfKMf
 xBtQW
X-Gm-Gg: Acq92OFFrTw1af7sFczp2solhoB2O/AAFdMIKDGpdW4qUWyaSyVQQrWbcDsiQboZ5Rm
 7WmcxpzZuqZXXE2FbMm8prlIQAFB0zEDdX4nrdsICJNX/ExG5/tOCoVh4pjVDiS3X0jdoXY9anr
 zAXpR+jYaoJMGJXiDQMIjN0EMWY2kaQqzUejxfkvKel9Ki0vU/LS9rtt3bJBfSlh/7wfr4DTslT
 CcTiODsXc1wzJvgY3wxuj2knR9W9UW1EIXRWbVWcq21tLXG7H3ZdYbsGPczGhA3Him/NIir9iMG
 qERpL6EV7HlAV65ZMUZx3sIF3r2wG7ydLwg4Xmi2m528h0JZ2Om3OfUrC4RvRFckYVr1OP28QsX
 Vbrx5O+/0F5P7hBUQyl1/TWvm9fGR7sSuKuK+9tc/kCqnyEF8X+WJJ9QLNWvp6OWxKkGfw8q7K6
 BtmwV+TFck3HrCJBgQcIYruuKHb7t9WNR9Vb9SSuPO8amGA4SWBAQk+Ibiorg0MZpaVuBhidGB/
 du+5+M=
X-Received: by 2002:a05:6000:290d:b0:456:d5bf:e24d with SMTP id
 ffacd0b85a97d-45e5c35e415mr33347357f8f.2.1779205676360; 
 Tue, 19 May 2026 08:47:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:45b7:1191:7413:7781?
 ([2a01:e0a:106d:1080:45b7:1191:7413:7781])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe0fecsm42939084f8f.26.2026.05.19.08.47.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 08:47:56 -0700 (PDT)
Message-ID: <a97ae4de-3159-4678-ab25-e5ce9ff1e12d@linaro.org>
Date: Tue, 19 May 2026 17:47:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: UFS boot and UFS tool
To: Raz <raziebe@gmail.com>, u-boot@lists.denx.de
References: <CAPB=Z-rjEF5fCXcYWfeskz3W3u16FoW4VN48O-OZTz+fp81Q3A@mail.gmail.com>
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
In-Reply-To: <CAPB=Z-rjEF5fCXcYWfeskz3W3u16FoW4VN48O-OZTz+fp81Q3A@mail.gmail.com>
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

Hi,

On 5/19/26 13:53, Raz wrote:
> Hey,
> 
> I have added a ufs_tool driver to my U-Boot repository. It extends the
> ufs command to provide access to IDNs and flags. Mainly, it allows
> creating and listing LUNs.

This is something very welcome!

> 
> In addition, I am currently adding UFS functionality to the environment.

Which kind of functionalities ?

> 
> 1. Are there any other engineers working on it ?

AFAIK no, you're free to send,

> 2. What is the procedure of posting a code ? Pull requests or emails ?

It's mainly aligned on the Linux practices, you can find the U-Boot particularities in
https://docs.u-boot.org/en/latest/develop/sending_patches.html#sending-updated-patch-versions

If you're unsure about the features implementation, please tag the patches as RFC.

Thanks,
Neil
