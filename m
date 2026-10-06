Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D935CA5FF0
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 13:28:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C34C180D5E;
	Tue,  6 Oct 2026 13:28:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MTnifZnEG4sh; Tue,  6 Oct 2026 13:28:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0D72D80D6F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791293316;
	b=SHZg8T79dokT2La1HYV7z34YKVZtXmTQ+yYYkWnqjJ+boHkIg5Zkyf9rLx7DDDsYFTtp
	 j0we8AZ6hpw0rRq1u6OfThsePteHFfJ5CLmLnty6DB4n80x0HvNDzz7vu4Sudsplo6uhW
	 VZyBXkPKG+Lb9Es77mcVu95MiwJdTLzt4QlcNVhr3Gqb7MX/C0y+Z5yTa3i8YKrQc6k9S
	 EsBdBitD80qY5m1J0yrPeAmcm5u8PLPoi/H1A5gzNUlEzVRlPVPv9xqZxn9ZS0T8ZifIz
	 TANRqkQK2XJ3L+2xws3gDXh/O9iHCBEQqOfJIidjiWbne751Sor0qckPs+aYZysO7TA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791293316;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:References:From:Content-Language:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=BiFGqJJvDvu0pZsiHsmZKvA0wsGpIF3ZSMIUy5It0K8=;
	b=GinxwBaUllvyg217Eljmb923yzYfzpGpgExyZmA6niHGFKy/oPWiCxZunAAaThk/JYrR
	 spFr2oAvijHH72H6kf+wXK2xfAqZ/m7xPNXDmrQii8Wab1hKFonhVz4f4dQp4gVuC5vPb
	 2ZyUGf0WJN8gPbOHRJoye8h+0TO8oscaL9fcHnfOL9hP/20qlZgcP6hyBmVJFW4OGGX6y
	 Y6+m1NosZeW+zZ1jZrcWmYaCV5ABfUyPdPSSu+Jx8XGkxA/EJH8cBCuwbyojaBDwSkrNp
	 YgNDLPiGpjRhaOJTO1urnBNLSjZgJLFNN6ghiIkWOfgk3RXzbh53bGBeloDMEwaBmZA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791293316;
	bh=BiFGqJJvDvu0pZsiHsmZKvA0wsGpIF3ZSMIUy5It0K8=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=C3QM5xwgdaxkkr1vsZGJrqU8lyqy7iF9NKJkE9EYiBqDPApITGM6hvbbRV3Ye6xrj
	 w9HsqsxSZoHt/SNcyzCN9jK/EZT5jj5Uu7rcW8jXTqSbSH+y0aMWsz1rDIUT34T8IA
	 Bv82ditY/y1O7c1Tb99coBTsXWjR6L7rUGGnx28HmwFFNdFNEMUxHXfGHUSCe+tP65
	 q2Dk9y+AwVftwUHY4nyxUN8sjbVpOT2RcmVf1cZA5fbVrfLpoZAKBy2IskQEilQxEv
	 Toh/ytDERAQS53CtDEzEXXfFTdQVtCCN+mQASKp0k6x1JDT6svgAHzYMqF9v+LsOgc
	 cQRndYHuzZAvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D72D80D6F;
	Tue,  6 Oct 2026 13:28:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 63D1422B
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 13:22:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5556B40249
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 13:22:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aYlYKFOC_V3F for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 13:22:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0C7E640076
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::634"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791292976;
 b=oDK+tqu9tmQGfuCngJE4QGnH4OF1p3LNub0qTXnJVrqRAfpP51xdXmm1ge3teMCHyBmb
 S6ZHuP4QwdgoD1Oe7rCE6TKmmomJav9G4r69tIyRMlj5F2cc2aGq8asYDZBT4/92E8jEg
 FsGwT0Ga0AuFmiEfCEe9lCzRAZUQexk07pAMu5Acaiq+xZw19r9N8q/+F94Dx6KieMxNS
 xARvyMIJe4iZL9L6NJhkIZUMR/lPyKrzGfhHqS6nG+AStVjjqMpj3yBu+Br++dRmtjOlp
 k91LV8prOgE8oQdrBZHVJne5JKBxMIYQP/AfrO2bsoGz5qTyg+wLMZoVBgyoLV5YG4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791292976;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Reply-To:Subject:To:References:From:
 Content-Language:Autocrypt:Organization:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=BiFGqJJvDvu0pZsiHsmZKvA0wsGpIF3ZSMIUy5It0K8=;
 b=CwWfQzhnl5UEXOR6kD3Ncs3uzyUNrqxqZMqRuBMYCShmQc41oW4WJS3ha7/H6b8VirIt
 G5AG4h4NWlTj0+d3uY+0kvND4XDl7nrfuJFRmcbIb1w8H5iDF9+QJ4g+K3ndBkJ8ei+Oo
 YL/kukgVW95PvuJbczwJnt2uMPAeJPZqCEcepb0XyIJTdooVQlw3uQim3HuMw+EsiCTyB
 s8tgpb8CLWBWGPznpHLxzVQQZG7jhfzjOJri/Ht6UTTLW8+BEschLtG+s7YOJbhI6Weli
 npWymoJ65+ydaOCDWQV8Dvvo5n/RjyfcvML7tqj1bq2/egPEhK7WbTpruoBFVLzohvA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=lZTQUY4w; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::634"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=lZTQUY4w
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0C7E640076
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 13:22:54 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c2e5e801487so84448966b.3
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 06:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791292972; x=1791897772;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:from:references:to:subject:reply-to
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BiFGqJJvDvu0pZsiHsmZKvA0wsGpIF3ZSMIUy5It0K8=;
 b=lZTQUY4wtQJq0Xx2TcjsNRHLVXxoTs25664ThUe7rlbKOE12KZ4e7HtrYbp0oB7JNi
 vo1mm+Y4X7zqW6Vns9fU7jpSFwJXucqIfCN54OWWl+PIduzqjaCm8yPjGIne/OlId8bC
 AaIuEdC4F8I/V5FxoGzyhyaiUSvvSj3iyNsv6a61vw0rQWuNmAsvGjVxDfJRNHYc2SUX
 wSUT8WW7BtGqmDcDXg6cf3AUbI6x/lyx7IjWFXFFUttRtJ2abvjmet7q+sFzYrzmFRSZ
 9kIlXMNVpffO3DXLhL/O0MsaDuWvNxSM/ImMWkLFwjfdkDy2J9mnmpb/9yGSz762+cie
 GzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791292972; x=1791897772;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:from:references:to:subject:reply-to
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BiFGqJJvDvu0pZsiHsmZKvA0wsGpIF3ZSMIUy5It0K8=;
 b=SVrUh6Lsqi1l+k4wJPWFUMo36CjrGOmhQQ+pFedduL6dubSlboMFvu9xDb4NlnMBfw
 NAJ5MZwL52sLrM8YHX9++6DgIA756Iy6cfRKsLsJqA4v3qly32RSIqNT7mMwviHvf9e3
 42jv/bL7XaphvmN8+dm01DjLLjxpFHXhNdb4Dfu/GSymRYcyjZ6X1IWzN3F3+DMxADMA
 k0ed15dWZFbBHS5Aha/mTswc6ZHFDINOXCymGioRO3NgnA1G5+M7KnFRGFknOBd/M9fI
 p1uoCKxmbVZzc9MY7tbXvRjDkPe+d5BQ7om6xQbEwYBYxcb/AvKpoB4tUOUvsh8Of763
 iyqQ==
X-Gm-Message-State: AFq9FYI3+UCGt3gsjXzpVVGtM/z7GHxk/SlMC1N6g7TMXBApr81Q3L4y
 iqMR0CPJwgt5+IPL4UdrItFJOaUDrd/tyVxvYsa6btJrWo0aNO2lNDRgxAi/ZeEb1aFJOBgdsaJ
 kxhLSblHHUw==
X-Gm-Gg: AYBFou0bVKYElH4j2uPYTPkLBc3wHnJga1GvgEidtDvLzN+ehr1eJQEvN28qMNltYJn
 2wwxfO3BbFlYBoPnTw0wp6FD+gIcU79nBAiRIBGoPDXeIZrpswWI087OQEgrAlYZS9segi2S+8J
 b2mVhf8WnVf/YpDR4Pa9S8SahoVGUh/mdsUPHSSdJ/JM8I0KHoaXzM7xzoLKN2HwgXAk9XkVZFZ
 PwLnWNaPayPkNQbEtOAga53pWveiAxlcJ9BFaa2B47l5MgdynTK9Ztwsyr0xda3dD/a9sdBnSYg
 MjgIMlUTNCVQeBtpWUlhlzH3AaG9yiyT7VXQyjznDdkIo2fRqcYEGSHlBWwK531yIb/0isrZso5
 8yZBJRB+RMGnMgoR92fTI3rgwUdlXGDA39bz+yXIN+WGMIW73xCrhFb0hmbW+v8G51H+slPiR6N
 LvUtWiavOh3kHvDt/qDXjn3OA2LxXmFXbFgLWlZqpiYnz0SaYje1vr0aiV+tAEpyx+qzJFl1qoX
 e+1e+cLUyTiHLdKA6d9AztNpHNtUWk=
X-Received: by 2002:a17:906:c105:b0:c2d:bf61:24d1 with SMTP id
 a640c23a62f3a-c3169cea2demr172451466b.1.1791292972414; 
 Tue, 06 Oct 2026 06:22:52 -0700 (PDT)
Received: from [192.168.151.96] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31562d7983sm206772966b.30.2026.10.06.06.22.51
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 06:22:51 -0700 (PDT)
Message-ID: <3ae0a18e-0fa5-477d-bf5e-89072b9634ba@linaro.org>
Date: Tue, 6 Oct 2026 15:22:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: stop generic OHCI and EHCI at OS handoff
To: u-boot@lists.u-boot-project.org
References: <179128521948.5.12131679420803093421.uboot-usb@gmail.com>
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
In-Reply-To: <179128521948.5.12131679420803093421.uboot-usb@gmail.com>
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

On 10/6/26 13:13, khaliforce wrote:
> The generic OHCI and EHCI drivers provide remove callbacks, but do
> not set DM_FLAG_OS_PREPARE. Consequently, their controllers can
> remain active when U-Boot hands control to the operating system.
> 
> An active controller may continue DMA after the operating system
> starts reusing memory previously occupied by U-Boot. In particular,
> OHCI may continue accessing its HCCA.
> 
> Set DM_FLAG_OS_PREPARE on both drivers so that their existing remove
> callbacks stop the controllers during OS preparation.

So while they actually have the same behavior, the DM_FLAG_ACTIVE_DMA
is exactly what you want.

Neil

> 
> Signed-off-by: khaliforce <kforce@gmail.com>
> ---
> Tested on a MangoPi MQ Pro with U-Boot v2026.10 and Linux 6.1:
> 
> - Started USB and accessed a 64 GB FAT32 USB storage device.
> - Read 4096 bytes in U-Boot and verified that their CRC32 matched
>    the same data read under Linux.
> - Booted Linux without manually running "usb stop".
> - Confirmed USB storage access and Wi-Fi/SSH after the handoff.
> - Observed no panic or Bad page errors in the kernel log.
> 
> The hardware test used the downstream D1/MangoPi port.
> 
> The standalone patch also builds on current upstream main for
> RISC-V64, ARM64 and ARM32. Checkpatch reports no errors or warnings.
> 
>   drivers/usb/host/ehci-generic.c | 2 +-
>   drivers/usb/host/ohci-generic.c | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-generic.c b/drivers/usb/host/ehci-generic.c
> index 1ae3619ce25..8075fb069f1 100644
> --- a/drivers/usb/host/ehci-generic.c
> +++ b/drivers/usb/host/ehci-generic.c
> @@ -167,5 +167,5 @@ U_BOOT_DRIVER(ehci_generic) = {
>   	.remove = ehci_usb_remove,
>   	.ops	= &ehci_usb_ops,
>   	.priv_auto	= sizeof(struct generic_ehci),
> -	.flags	= DM_FLAG_ALLOC_PRIV_DMA,
> +	.flags	= DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_OS_PREPARE,
>   };
> diff --git a/drivers/usb/host/ohci-generic.c b/drivers/usb/host/ohci-generic.c
> index cc44226f5e0..6cc26e2d3c0 100644
> --- a/drivers/usb/host/ohci-generic.c
> +++ b/drivers/usb/host/ohci-generic.c
> @@ -110,5 +110,6 @@ U_BOOT_DRIVER(ohci_generic) = {
>   	.remove = ohci_usb_remove,
>   	.ops	= &ohci_usb_ops,
>   	.priv_auto	= sizeof(struct generic_ohci),
> -	.flags	= DM_FLAG_ALLOC_PRIV_DMA,
> +	/* Stop HCCA DMA before Linux reuses the controller memory. */
> +	.flags	= DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_OS_PREPARE,
>   };

