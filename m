Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B917C83F29
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 07:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF57E80770;
	Thu, 31 Aug 2023 09:54:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e+N8c2/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 503858652C; Thu, 31 Aug 2023 09:54:16 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48B2280374
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fe4cdb72b9so5421125e9.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 00:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693468453; x=1694073253; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=J9o4jIzgTDzCS8keb/VJxcr5uR2GxGl78aPztqyoXlc=;
 b=e+N8c2/8lJwlMfv4bGxKVZzFBQx5Jn3JDuz5UHBXR3qlPyR03QEAJj2ybJPTioVNns
 AO/M8KhvGGWfVEKZV0YEgfH18m7JJHSylWUvxD2fvlglTNDNgkh5cs6IQ03uZwvbJRMR
 jWq76/W/tRivnHpx/dwJy4AH/r9VRTJGf4NEofAXdDxbT7fVbVEwZsGSIhBdws/e8RSv
 ydT1HiEZ8dNFWIYrCWV7hblT2dA+iO0x/NXa2ixB2qvU/rwy6pn2dLca0s67e2py/Dyn
 nmrlMAG/Ypr7WOFeOn54ELOi0hsMezF7uX4L8CTNbSHRFtpPeVRcuotr5za29tJSe7QV
 WHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693468453; x=1694073253;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=J9o4jIzgTDzCS8keb/VJxcr5uR2GxGl78aPztqyoXlc=;
 b=fWP7zBemAwRAK4yaC0JwnblZQEB7ltP+I+xM3BuGqwrIf0S4G6rw3ZgHRiwPLqfM5w
 SXj60yh+e1pqXGlbldg+rRKEf1ENETtemkLjfZhag5PO/F596VSY9LEPyXvvTZbkCdQf
 zO9dvSHlHS9xYIYuXE654kRWZB4wmY0nPyfc0M6frOMAJvS4+UduZuU6epGXh/BbNUex
 X5Kdt3kFPt6doO8GfaXOffZhhZZ2r0y1RAOnKZQqVB6/Br449oEOUmRwIt8dda0DYjId
 J4T3ujwwVoUXHWiAbF14TN4TqcJ91JwoATeecpmzjJ4VLzf8hTHClPWQLHC0s6jbXORY
 7h2w==
X-Gm-Message-State: AOJu0YwNOyxv+I4yXGeBy6NIUrP24Xs4ofQJcVC8OcrT+58x8urQ3wLb
 PjPZD5Gyw1bRd/dYZYAdCgSvHQ==
X-Google-Smtp-Source: AGHT+IHWsrPm2UBXsGxKKIMiYf/l9u4U35sZyeGuJmoQGcwdG464dSpZW2Dd/j4SS5peAPhlRcchyQ==
X-Received: by 2002:a05:6000:45:b0:318:fa5:d84e with SMTP id
 k5-20020a056000004500b003180fa5d84emr3060959wrx.70.1693468452627; 
 Thu, 31 Aug 2023 00:54:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a33e:476b:58d7:9689?
 ([2a01:e0a:982:cbb0:a33e:476b:58d7:9689])
 by smtp.gmail.com with ESMTPSA id
 y15-20020adff6cf000000b0031934b035d2sm1299935wrp.52.2023.08.31.00.54.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 00:54:11 -0700 (PDT)
Message-ID: <d94b0cae-99cc-4f8b-9d0d-52a5858f6e33@linaro.org>
Date: Thu, 31 Aug 2023 09:54:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/1] meson: Demonstration of using binman to produce
 the image
To: Simon Glass <sjg@chromium.org>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>
Cc: christianshewitt@gmail.com, mark.kettenis@xs4all.nl,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 linux-amlogic@lists.infradead.org, alpernebiyasak@gmail.com,
 da@lessconfused.com
References: <CV61D7ULLVZ0.3OCFZ743L1KSE@flaptop>
 <CAPnjgZ2iff6F3CFjnjEMUVoX3bO=kv3za4Q45YOcVeZqc96=rw@mail.gmail.com>
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
Organization: Linaro Developer Services
In-Reply-To: <CAPnjgZ2iff6F3CFjnjEMUVoX3bO=kv3za4Q45YOcVeZqc96=rw@mail.gmail.com>
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

On 31/08/2023 05:37, Simon Glass wrote:
> Hi Ferass,
> 
> On Wed, 30 Aug 2023 at 11:53, Ferass El Hafidi
> <vitali64pmemail@protonmail.com> wrote:
>>
>> Hi Simon,
>>
>>> So I wonder how best to move this forward so that we can build things
>>> using binman and everything works?
>>
>> It's still not ready yet, but I'm working on porting U-Boot SPL to some
>> Amlogic SoCs [1]. I'm currently working on Amlogic S905 boards, but
>> eventually I'll work on Amlogic S905X devices too. And speaking of
>> signing, Jonas Karlman wrote amlimage, and integrated it into mkimage,
>> and I applied his patch to my tree. There's a few things to be aware of
>> about Amlogic signing and binaries in general, however.
>>
>> amlimage was intended for use with U-Boot SPL, which obviously has
>> no support for Amlogic's FIP format and as such amlimage will only do as
>> little as possible to get the bootROM to load U-Boot SPL. Most of the
>> packaging format is handled by BL2. The fact that the signing process is
>> completly different across SoC generations makes it difficult to
>> implement them all into one single tool (and by which I mean all of it,
>> not just signing BL2 for the bootROM to run it, that's mostly the same
>> across SoCs). amlimage has been confirmed to work on GXBB (ODROID-C2 and
>> the KII Pro set-top box), GXL (librecomputer lepotato), and SM1 (ODROID-C4).
>>
>> My U-Boot SPL port is still rather incomplete. As of today, it still
>> can't boot anything from any storage device. The goal eventually is to
>> be able to load upstream TF-A BL31 and U-Boot+linux.
>>
>> While Amlogic distributes proprietary BL31 binaries upstream Trusted
>> Firmware-A has a port for some Amlogic SoCs [2], but as far as I know
>> SM1 (which is the SoC generation your ODROID-C4 is using) is still
>> unsupported. GXBB, GXL, AXG, and G12A are all supported however, but the
>> overall port still lacks some features the proprietary implementation
>> has.
>>
>> As for the SCP firmware (aka. BL30) I'm not aware of any
>> reverse-engineering efforts for that.
>>
> 
> Thanks for your efforts on this. I look forward to seeing where it ends up.
> 
>> Honestly, in my opinion, including proprietary and poorly-written
>> Amlogic utilities lacking a proper license, into U-Boot looks like a bad idea.
> 
> With Binman, we don't really include them in U-Boot; we allow them to
> be fetched easily so that a complete build can be produced.
> 
> I don't like it either, but for users it is better than doing the
> build manually.

I'll rather spend time and effort to have a fully-upstream TF-A boot chain
for Amlogic SoC (when possible) that maintaining support for bulky closed-source
x86-64 binary only tools. The tools aren't even officially distributed.

Neil

> 
>>
>> [1]: https://git.vitali64.duckdns.org/misc/u-boot-kii-pro.git/log/?h=wip/spl
>> [2]: https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/plat/amlogic
>>
>> Cheers.
>>
> 
> Regards,
> Simon

