Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E04EC61D94
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 13:46:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EEED875E1;
	Tue, 21 Nov 2023 14:46:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h2xK4xto";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C029F87582; Tue, 21 Nov 2023 14:46:33 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 863AF875EC
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32dc9ff4a8fso3529251f8f.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 05:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700574391; x=1701179191; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=upVedUrQMYJyG4z3BtAvES1f7mfAQOC3h8zjZCXrtO0=;
 b=h2xK4xtoRk9WRUfn9KxqUcJdd2ObcR8+F1DzVYN80bTMWPrXkVFQ39YOCfNK2t7Ter
 k/lubklWm/wY23WCA6rIzark6TZQt3Xex6aYGUeZs3JrFHD/fjMwBx0C/G2wykpc1PIM
 GwX0PDgkVYbRCuKeRjr7BO61bHVX1C/sKUYDWucUN0ZxfywwtCd/eadGPUiuTtYPKg0X
 nLvrqMz7sf97jdiK8GKCnPSutA0AuiV+UtA69FAV6fYRF6kVLRFduQG4An2Au8/gB+cF
 j6C8g1In128Oxch/YzAoeNBEanWbx7ArGJTOt/reW3RynqAIbLspaE1fxO6iFTbCq2Ug
 U3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700574391; x=1701179191;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=upVedUrQMYJyG4z3BtAvES1f7mfAQOC3h8zjZCXrtO0=;
 b=lHC3ZB9abEP3nJe8hZQjP+zjdpCLYecIPBsb575oe+ofiXEAMkriWsrctufy2EHaV+
 egPxAyBv2bezlUvGcy1FDQxZgzNPcXer/KkZ8z690vEYz990njW1j1NZjc6VVYEduhbY
 nb1F+XZqNWVu6jhFVqxulZ4PWQA2iVrtFnbC8rLJCuqVRSNq1dLAEyXAOJVS2DKtKhuJ
 sTzuk8j0A4uPJa0vUknrK9mrweT01MGAENJvVzDEfXxW4hllQuXsnhSoDk0+R6Mg4ml4
 11LZaT8tctRRIOoriIZhU945ZuwRGkh/ZMv2HwJg8TlWAeqFt8uuUJ0TQdvyFykzsdhx
 ziFw==
X-Gm-Message-State: AOJu0YzODNLxRbOf6bsqVOTVuthXzL2374as0cRtWryMAK2jXHwThovR
 BUFDxbcned2bEHff/boANHv/NA==
X-Google-Smtp-Source: AGHT+IFy36lvwG7wcjthOzwoHxwkOLdmzFrwLyiECQt2KurhqusikLZkbGwfZ9KN8a807iTEUFJl4w==
X-Received: by 2002:a5d:5849:0:b0:332:cb12:16ce with SMTP id
 i9-20020a5d5849000000b00332cb1216cemr3021208wrf.65.1700574390923; 
 Tue, 21 Nov 2023 05:46:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:2a39:bc19:20b6:16a?
 ([2a01:e0a:982:cbb0:2a39:bc19:20b6:16a])
 by smtp.gmail.com with ESMTPSA id
 l15-20020a5d6d8f000000b00332cb23ccbdsm4605102wrs.81.2023.11.21.05.46.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 05:46:30 -0800 (PST)
Message-ID: <d59de63c-4d4c-4141-9b4f-9a279da596d4@linaro.org>
Date: Tue, 21 Nov 2023 14:46:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] libretech-cc: Populate SMBIOS information
Content-Language: en-US, fr
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
References: <20231120201609.619598-1-trini@konsulko.com>
 <a653e096-cf28-4573-856f-d52dae233b46@linaro.org>
 <20231121131551.GP2513409@bill-the-cat>
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
In-Reply-To: <20231121131551.GP2513409@bill-the-cat>
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

On 21/11/2023 14:15, Tom Rini wrote:
> On Tue, Nov 21, 2023 at 10:18:04AM +0100, Neil Armstrong wrote:
>> Hi Tom,
>>
>> On 20/11/2023 21:16, Tom Rini wrote:
>>> Enable CONFIG_SYSINFO_SMBIOS and populate the nodes so that Linux can
>>> eventually display this information
>>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> Posting this as this was the easiest platform for me to test some SMBIOS
>>> related patches on and I needed to populate the nodes so I could check
>>> things in dmidecode once Linux was up.
>>
>> Sorry to be late a the party, but can't this be dynamically found from DT's compatible & model ?
>> Since I'll probably need to add this to all boards, it seems like a duplicate of what's already in the DT.
> 
> Part of the "fun" as to why we have the binding here is that while we
> could use the top-level model property, there's not a corresponding one
> for manufacturer. I'm fine ignoring the patch I posted here and having a
> longer discussion about populating SMBIOS more usefully, globally, as I
> think has been suggested a time or two.
> 

I'm ok landing it with the same data as from the vendor.
but couldn't we use the first top-level compatible as default smbios data ?

compatible = "vendor1,board-name", "vendor1,soc-name";

and translate to:


smbios {
	system {
		manufacturer = "vendor1";
		product = "board-name";
	};

	baseboard {
		manufacturer = "vendor1";
		product = "board-name";
	};

	chassis {
		manufacturer = "vendor1";
		product = "board-name";
	};
};

since the vendor name should be already documented in the linux
bindings, same for the board name.
And we would be free to add some custom data in the DT if needed.

Anyway, not sure it's the right place to discuss about that !

Neil
