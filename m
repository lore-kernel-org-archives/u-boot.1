Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0105FCA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 09:16:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A136040CAC;
	Fri,  2 Oct 2026 09:16:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CwGprK5I2q79; Fri,  2 Oct 2026 09:16:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C8E8240C00
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790932572;
	b=DXAHQAf7gdF4NkG+XnhyNKWNRRxYkcImq746wuRmDf75PEChZAiWIKH8FhXls1PTXEOt
	 /gAr9CD5trdkRFMWgnLunxceQtQ+/QY/Dl2uBRsJcYKVE0tw7V0/DWfUGQhdteVpk+gOi
	 WgLQIR3unPbY4gv9UfFTvjZ+ToF2ALH+0uwe0QzBebDb3xxRhA/Zev1Gq7bzdLo9R/yvF
	 SBZmt46Vt7T/Hp/VofnDmLU4Ko7aX5P8OOXKrefpFuraVLRnDHQ8h/UmS5bjrqNWj10nL
	 IRn6zAV0rFU+yjnDtNm1ylvHQiEWUwIk+xlMITMYCtjxrUvcp5lJayoQmar7lShcOhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790932572;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=nMbtp6pVACoSY0yGRqtBtU/kUmZEoR1xGJjtCttuC7I=;
	b=JX9Hvs6nCDIC72sa7g246P9HURFYsd4IdDeiusX8atYG9ukoGZbGuLKQJ9KGk4VGw7hv
	 6fmt8gne1yzZ7PG4DWvxKUGd9w1wVF9XiK6o3MROaFDsl9LtgrIcISwhnT4sSxn12uob5
	 EGUCj8TNSvHcfdZUh+ONm3CSgsv4h5WE4bcRIEDZwuLkWrg/l2zIM2PjnJlp/Iy5s7r07
	 DNasIWU6XHLhKeLs8QIiIoQW8rAd/eCs6FdOJpOSqnw35iSftnUNIcCly1A/CNqZ0p1Mf
	 1hsMeG6RTBju2olCnCNFeYg25Wdu+hY72AwEkKW2iqjzUU3H+PNJGj/hsF5HymJexKQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wTxZ2Eb+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790932571;
	bh=nMbtp6pVACoSY0yGRqtBtU/kUmZEoR1xGJjtCttuC7I=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=SdOWlvdr0TSp5c0KCvpVmEU8wMW0pm05jFmI//q8EjT2MZo2ZHPyniqEoqTVgL5kw
	 Oy4qp/rTOXX5ukebHnWBx793VuBTd3T1XO62VZ5r99VnEtJDSlraQyl7cokgf3bOOC
	 /OLn6x03+b9TxxPjWy0k2H5dK9Lft5yntOZMKvDoTzhRTqjZBN5uEyo0yzdjlMFZ0b
	 WEyeZ/y3HZTvinPhhlpZo7JsWAzyTt5OfHEEy4pPdSZWv6B7B4EbfX4TTz4gpD9yia
	 XReOz+BN5WrYqc8S7jgLNcEYv+V0gP7wx/6qa009zVgcVN9zlUuqiXVmnZDKuEKpUW
	 kEaNJxPCOuo2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8E8240C00;
	Fri,  2 Oct 2026 09:16:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2DDCF4C2
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 09:16:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1F78340C00
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 09:16:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2l2n19I49yEp for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 09:16:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CCE0040BF0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790932570;
 b=VF9ogIrICWH47knLW0XtPYKUOpvUoiVbjqrzloA1+FPW2wmlqBK5JK7LHsM4EsXAM9s7
 pNxBXaBG24oYXc5UETmyebzQXMEMOFPFmdmlSU8Y5MjxMoXu5QmUauZO8r7ZrgKYvdoNL
 ZfUIbzMEpv9RFTTXvL8S0VZDlwE/YqvlUyPgHgr3G3Vui6Y2BzWrpqoaR0Wd636cADWne
 hIqz4KvXtKU9hWgD+v2MMUrS+LY47KLA6iiQb52P2SJ3wLYno6XysGhjfrgLLUjFLBVen
 MlazM3tEyWbUjDko453sjr9C3HuyE1BQuuBaTesnEZuW84emaiRKT+OvtQu81yCiDkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790932570;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=nMbtp6pVACoSY0yGRqtBtU/kUmZEoR1xGJjtCttuC7I=;
 b=VlQ572l0Zvr0jFw47KZCGaBLez7ZgViS7H/ysjN4HHAfuNc1FZX/8I1neKmvDepbsfM0
 sAvglGckCiYRd6DP5M4SI5gnoPvfxc75r8Lj/k38C4mtUfq40KMpR9k25pVwXkTYgOH9H
 fC8df7EVrqeROoXcruIjHouOkvJ2me5a9IfuSBnQrzIRme9C8DbOXAjYe1NK61jcCtwDa
 bI+2zyecHFBNEvrlmraeyWN0BYb8YPntTlqRDRku4VvJIK6pWjVSmJfSN3NRPYzctW1k7
 GzdpKKOTMJ7ogruJXmWfUROczhROWq+zGpvVVWxdsQe/AFCFS/A5FU0BuEOFpqHhqSw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=wTxZ2Eb+; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=wTxZ2Eb+
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CCE0040BF0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 09:16:08 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ff9642c57so17288645e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 02:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790932566; x=1791537366;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nMbtp6pVACoSY0yGRqtBtU/kUmZEoR1xGJjtCttuC7I=;
 b=wTxZ2Eb+lvd3R4aStFEU2tZiFjaKHyXgg0PgMEjT+fEdJyz85bPA7Y1IlLV5RF2goQ
 /1XSoVcnI37blnT1f/fvi0Cjjr5ynKp4mHd/ANMnnPt5ds66gKeVfbvUxbEGdR3zqRtu
 hvYKUiw2S08Lm9HXPfEvk6grGPAhqDJ1ae8/zY+tFFzhfZUsCQDnOlVfNM4t6Zap4AQg
 /XPkdLU58seFAI7FIpk8TxVIMBvTyxUK8agzPwLW1cj2d8Jbcmk9uaDR1SKidldVGlWO
 wy4xvXkhTiPciK+DfRkpe6gMsKEBS1uTV73iwzVGVFoVskikLgy+8yY7buFggR2wWJXG
 Gr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790932566; x=1791537366;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nMbtp6pVACoSY0yGRqtBtU/kUmZEoR1xGJjtCttuC7I=;
 b=Zo3Pdyj+lUvSEPtXrDchfIiUhUCjSfqp6jGEG4nocVyBfqKpyJ1cYzk2jrk5HHkSPZ
 vSZdvBmRh00TYUyn8tZ9vSMVT8V3Opohtf/dy+9RHPRrL1xecHmR6A/wp813J+7ZhGdv
 qJvFt6/Gtz6IIwOhBwdsvvEz+i8mT7E1iXTg3lzgGGeEhhUFFDKJPT/zvc5ZIokOH8Jh
 UVcyDOXrbAl0MmMPF13biav89mA7fP7DQkJgkegWPsWq8u+EPaAPWO4QjzzeHbUFZBSl
 PDZkElLZBV18iECU3MSf1bxug/2wsgbketfOhJqQCkmPoQ2XKMYFqEvG+k7Q3QIoLeNg
 049w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJDtQ83JxszJlvZDz9wrP+LB+FvgSNfDXNvgOt/4en6ktqDapMLXkNLEnkM5M6LH/D7viCK2Y=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m02sDP8WCvm6SgaMClDTnpr2CGkNovcKOpZ0yLdYm5ONNN5HnC
 iauwChx13OnE0bSJQPtxvdGxUyhvyr0W5wr0fK45rN3d8OVSkFyXqZPDddINd/rCRJo=
X-Gm-Gg: AYBFou2ziRGqatuUlbM9hqjn8RPev4RfEdlA98bke3yBDknJV/dDEFrexQL2HZo4PFv
 j0z5cf29cV+QOAGNr/EZcP5N878NzHkvWFYcaKtsCkr31xUpSgJ1SQIykOlYBj3A7yjKb2kn2ex
 T9iPXkQMt7BkLliX79n0CkmQrrCW75UceWLLK0gJP3tvp19cMzwFq/+6fWf6WPyHh8fqKS8Vyjn
 btjr2NhrSdmF0MjUYWsep0tK47+ttr64OESojR+kOk/72ln/BJoGLwKtszDmgrLKiUllorh9TON
 e/qDWH/VC7P+0EsP4t4jZ9mhyOwtOPbzDgHJEYBDab23aaulFEum0jcVyQMvOGRN99IBzcca6Mx
 LV5zGLdmYpTpVe9Y1oJZW80pjBZHfxvjA5AD5uodJGNDW2fhgswyPkVmnd5aiWMU9MP3GrXCSyd
 vx0j8vERnzINek+4HuDI5hsQs673gbpQ12u3SYclY1QRdccuOM9sB96AD0wYuatR5EtoKqHSqq4
 ZRqxl6OREEWyzE2+PCEhRM0MzaYBV9mfuUe3hvkKRN257V0Gbo=
X-Received: by 2002:a05:600c:6090:b0:4a1:6282:1cf3 with SMTP id
 5b1f17b1804b1-4a162821d88mr11207925e9.9.1790932566028; 
 Fri, 02 Oct 2026 02:16:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:2f62:6d3:721b:8c9e?
 ([2a01:e0a:106d:1080:2f62:6d3:721b:8c9e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03fef174bsm35171605e9.2.2026.10.02.02.16.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 02:16:05 -0700 (PDT)
Message-ID: <ae9e1c32-e8aa-4304-85b7-8de17c775aec@linaro.org>
Date: Fri, 2 Oct 2026 11:16:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/9] ufs: bound request size, enforce timeout and latch
 failures
To: Qing Li <lqing2013@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
References: <cover.1790887323.git.lqing2013@gmail.com>
 <ec3f2172a8d12e33155d2da9efd48880f34ab3fe.1790887323.git.lqing2013@gmail.com>
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
In-Reply-To: <ec3f2172a8d12e33155d2da9efd48880f34ab3fe.1790887323.git.lqing2013@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi.

On 10/1/26 22:44, Qing Li wrote:
> A single large request (up to 32 MiB, 128 PRDT entries) can stall on
> some controllers, and a stuck request hung U-Boot forever because the
> UTP completion timeout was only checked once the link had left
> SLOWAUTO mode.
> 
> - reduce the maximum request size to 4 MiB (16 PRDT entries)
> - always enforce the UTP completion timeout
> - latch io_failed after a timeout or controller error so further
>    requests fail immediately instead of reusing broken descriptors

Could you split this change into multiple commits so it's easier
which changes are for with fix ?

Thanks,
Neil

> 
> Signed-off-by: Qing Li <lqing2013@gmail.com>
> ---
>   drivers/ufs/ufs-uclass.c | 30 ++++++++++++++++++++----------
>   drivers/ufs/ufs.h        |  2 ++
>   2 files changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> index 6ef01f8e4aa..7a8d3e9de53 100644
> --- a/drivers/ufs/ufs-uclass.c
> +++ b/drivers/ufs/ufs-uclass.c
> @@ -60,7 +60,7 @@
>   #define MAX_PRDT_ENTRY	262144
>   
>   /* maximum bytes per request */
> -#define UFS_MAX_BYTES	(128 * 256 * 1024)
> +#define UFS_MAX_BYTES	(4 * 1024 * 1024)
>   
>   static inline bool ufshcd_is_hba_active(struct ufs_hba *hba);
>   static inline void ufshcd_hba_stop(struct ufs_hba *hba);
> @@ -915,6 +915,9 @@ static int ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
>   	u32 intr_status;
>   	u32 enabled_intr_status;
>   
> +	if (hba->io_failed)
> +		return -EIO;
> +
>   	ufshcd_writel(hba, 1 << task_tag, REG_UTP_TRANSFER_REQ_DOOR_BELL);
>   
>   	/* Make sure doorbell reg is updated before reading interrupt status */
> @@ -926,16 +929,15 @@ static int ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
>   		enabled_intr_status = intr_status & hba->intr_mask;
>   		ufshcd_writel(hba, intr_status, REG_INTERRUPT_STATUS);
>   
> -		if (hba->max_pwr_info.info.pwr_rx != SLOWAUTO_MODE &&
> -		    hba->max_pwr_info.info.pwr_tx != SLOWAUTO_MODE) {
> -			if (get_timer(start) > QUERY_REQ_TIMEOUT) {
> -				dev_err(hba->dev,
> -					"Timedout waiting for UTP response\n");
> -				return -ETIMEDOUT;
> -			}
> +		if (get_timer(start) > QUERY_REQ_TIMEOUT) {
> +			hba->io_failed = true;
> +			dev_err(hba->dev,
> +				"Timedout waiting for UTP response\n");
> +			return -ETIMEDOUT;
>   		}
>   
>   		if (enabled_intr_status & UFSHCD_ERROR_MASK) {
> +			hba->io_failed = true;
>   			dev_err(hba->dev, "Error in status:%08x\n",
>   				enabled_intr_status);
>   
> @@ -1030,6 +1032,9 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba, enum dev_cmd_type cmd_type,
>   	int err;
>   	int resp;
>   
> +	if (hba->io_failed)
> +		return -EIO;
> +
>   	err = ufshcd_comp_devman_upiu(hba, cmd_type);
>   	if (err)
>   		return err;
> @@ -1661,16 +1666,21 @@ static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
>   {
>   	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
>   	u32 upiu_flags;
> -	int ocs, result = 0;
> +	int err, ocs, result = 0;
>   	u8 scsi_status;
>   
> +	if (hba->io_failed)
> +		return -EIO;
> +
>   	ufshcd_prepare_req_desc_hdr(hba, &upiu_flags, pccb->dma_dir);
>   	ufshcd_prepare_utp_scsi_cmd_upiu(hba, pccb, upiu_flags);
>   	prepare_prdt_table(hba, pccb);
>   
>   	ufshcd_cache_flush(pccb->pdata, pccb->datalen);
>   
> -	ufshcd_send_command(hba, TASK_TAG);
> +	err = ufshcd_send_command(hba, TASK_TAG);
> +	if (err)
> +		return err;
>   
>   	ufshcd_cache_invalidate(pccb->pdata, pccb->datalen);
>   
> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> index 0f6c93fbce7..c35f395ea7a 100644
> --- a/drivers/ufs/ufs.h
> +++ b/drivers/ufs/ufs.h
> @@ -719,6 +719,8 @@ struct ufs_hba {
>   	struct ufs_pwr_mode_info max_pwr_info;
>   
>   	struct ufs_dev_cmd dev_cmd;
> +	/* Do not reuse UTP descriptors after a request failed to quiesce. */
> +	bool io_failed;
>   };
>   
>   static inline int ufshcd_ops_init(struct ufs_hba *hba)

