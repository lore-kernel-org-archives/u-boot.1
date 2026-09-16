Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C948CC88E5C
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 07:24:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC02580C7E;
	Wed, 16 Sep 2026 07:23:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dON5Q60v73Kw; Wed, 16 Sep 2026 07:23:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 99DF980AAD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789543438;
	b=qjy1c5iepAxoIGELVHjyvG9tRm2vZ1aFxUKbIF426WajhXn6Fknd5uomaH0w2gSU4OEP
	 KTG2y8CybWcxKU5Bw4TJT5NEIR70+ZSXwiZ4VWe+I9sJOuZKhTpGXI5nJLbbs3G9LX85j
	 WOXfUckiYPhuVlHHImo7yppmqcmPJmrso5mm33EVz/JNRO/3gD85mbGCyot03T2y/rO/n
	 5uS0zvl95CMXN50zyPO73ZlI4PjDs6irbcyu1WI0Q/bjqk3jQ67rbgPkEL7nLx+oaKFvS
	 inYY0wJY5WUj/Q6PohrhKELHA4vm3Mjore6qimYg+YPouCh8aQOJK7jYm8Mk1qm/k3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789543438;
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
	bh=1LlfTSe+4WGk5Xa4pmaY5EelasQE2J6w5NiGUHbMkmY=;
	b=MwEE8pmpev4qHX8ELDWnuTdyqpCfbZ1EnhB7pLIMRgxHlEK38VmqVd0uS53pB9GWTI9a
	 s9z0yceStaqQV8eqAXK8ox5sQ+S3lOqKHf+fUi4oiVuaDmLQfSk7OjqW9tkoaUPuETV6i
	 3p96MHqbTIr7b3aAqj9AyEnnRnuaqIm+p0TYhTNE9+Wjba6iX8RtvmGZaaqeMe61SN6Qc
	 /izMNmgyXN39yUe/P5TLHFNvHsU6zYWsMLqsl6awdp1z/F7rIuB52p7yACuLfKDv3htVr
	 cMeO2bs2G+gZeLZE8wbopMWKhO2swyhhfNA/a/WeJN+O/lNwPTaL1lvwODfSfLh1L4g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789543438;
	bh=1LlfTSe+4WGk5Xa4pmaY5EelasQE2J6w5NiGUHbMkmY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=OPai+PAeebJfwBrLZCc+resVASBuy2a2Fdakg4jMYd+AFxRa/eJF9N/gmtGWs2rou
	 XFw5+J0XSkq6GxvvZ8YrcEFjWe9HHEE5OvgA2yNddM4+KRk+cXCtUOdtmeDQDwnxw2
	 nEk0PKSX6fFMHJ0TbSqpZFDX7Y0qA6Pxr9F2wbk8ORVs0jaBTFNZHsBnnbQAMP6ODs
	 lDvibBFAPlXnlODvWNsUexPwGwDm2KtNAYEukbgIGJOYYOUamb2Vvbz3ifHFXSVYfs
	 o/K7N/pb+GgppTcZ07+pMKphZDXzWVytFWn3xGFMlrZY4dL6SScPXTY4fYBiePor67
	 0buAtLkB01XCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99DF980AAD;
	Wed, 16 Sep 2026 07:23:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F8D5259
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 07:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 55449607CF
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 07:23:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nRBLr0g2bwGD for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 07:23:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BC71860738
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789543436;
 b=fB05rdYPdemalRLL0yjqTCJcwZL9eudfVinDId6G75hQxdPmIkCM5/twqr13gG4+3tu6
 1NilYnc58qDZ3EyKQVYvcyw4l1TAq832fZqLHVwT9kJ4nNpOagUrN46yAzMnpKCKfNpJG
 shsdzmLYehyRAu3l+BX0sv0LcH4oKtk5QtTGUS3jTtW7uNrVJOx1rPJR6GnFw/Zrb/sF/
 8G2S0RQ/KfvEz7FrgvDxsYTW3jRevfIA5QZFdb/mATopz4b2/5lKtgzhnkjizMbytHqAC
 LLLJcX+0aOiu6wFOu//38OitvsuYdvi7M+qok7oOCPvLQrnq0or2I8lo5zJI6dKm2hw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789543436;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=1LlfTSe+4WGk5Xa4pmaY5EelasQE2J6w5NiGUHbMkmY=;
 b=AS6XzK/q7hRdSW3MWbQujZ6aiDt5LwKpxxnHp2IA+DYm7xWLO4dKyYXBKvHg0jZW5u9Y
 ElwwDNRuRMLDhzECYQH1EUfI0zi8+bEq11WyckUx0HH7d1+q5gzbwlXhYaAdSmavCyk7T
 fc+3NH5HDZVC/v/dEc+z3UXnUNyZpNksH089YdAlUTSaWyZctiZashPv+3P4u93Qzit8w
 DMaPtvGQToXPktgdLuLDYc1yg3vQcx24IAOYtsr3FmfcPBPtHhsNryHAlZCXvuGX5mgwy
 4SOl0rWlsgHmoipSkafZh4Kpf9Syh14MXZJA3Bh8hylXzPFNmbGD8SIQUw1DgKliDXQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ANlx7UCJ; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ANlx7UCJ
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC71860738
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 07:23:55 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so4404445e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 00:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789543433; x=1790148233;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1LlfTSe+4WGk5Xa4pmaY5EelasQE2J6w5NiGUHbMkmY=;
 b=ANlx7UCJNQciY9wGrx8E2lg0IKkEDs3+Wwu/QbHjO+xM/699rFjyya7JlWIoNw/hfx
 P2Xrs5hSUEgrwk6ZrK1IFAedAze59yJ3N22Qjn/WSM4xF74LwhW2md0iUDC7M0Ld+mqv
 XsbYqnUMiC10ufPIz3cw+PiOPY6/ddVxDmeZcAl/mQ+YxAWViQIbMaEP/n3KxEuf4sC/
 pY0+SvMydJspf+szwxFIkxcwNojaTQ6c0kf47oQEPClt6kj4eJ8v6pIKy6jP5c4woObp
 HmhiXagP6JPnaeN05UFNu7b6hhPQIOFyuL3AkjcSRxb1Teip3S6ulfku2irMjKxRpOot
 oOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789543433; x=1790148233;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1LlfTSe+4WGk5Xa4pmaY5EelasQE2J6w5NiGUHbMkmY=;
 b=eYRhah33coyp+TRBgNEDQnHfqzrVjLTG5G/mcT8+blKFZtSobeD7Y2ekRwnAQVpVe1
 ricALNGjJzlDRxdsgxv4l+YcDEt9jxL0za+sGgLpMY3PNPyE5vzHSdMRx1jRassSPkoA
 bAqJ+CGl3RK6/y6dQbnmxUKQVD2nNUjFONtYUDVCFgmKOOvH2/R0chNXuVGfEAWKntlK
 fQVrTVlJndJqBa50YkXZQkJ7qjBjMnRJzO6GAM7rWzyi+WL7ECaj413uDJjJqK5pD0uW
 6AqOOAGYFc8GZis7P+hdskDm197dDHz/RuhK38GiXH4pKaElCZsIj0gGB12GT4rwRrrk
 wbzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxymsW/45adrO94BdspxBxMWL/3pp5IjJfpL108hs4DrrDwyGBilqCr3BmDSjPUnwnTSQExzWk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ln2ryx2JVGgHVP6emc/kcbF/Zqh9oglT9cwZh8C/3xUZxyiUr7
 3fDTp5/8dD5HNSdKpg54uHjM7YsYsmC5nY4eF/w98cYk98pschc6Ym9fCSY5Tm8scdQ=
X-Gm-Gg: AYBFou03KoH/W0P7/cBWMDyMN7y0VFOorYwCsQNk7XS5yEZDJrI3BuIKRgt1Rn848vd
 me65s+lpFh12eTkSx8qr+ybQ5GbWNjSxKVWkTFOOsvEyboSuYbDJAnX1SVmto4vHYfgKK+5YQ8W
 zITOTSnwGizGGw+0Jry6sTg6E9lD3nOjsR0jo9Ssa9BEpm5GWCabXGo9F2lMHVSG0h3I9hNflWF
 h1V8NO07582KlQBzphi2WrJptH5WI2NuesLr4QMU2YFGxpS+aZVg3cYoXMHom5rEsNXOpNmYxwN
 etmJC1aV0mhzVENGHgsKHq3VekRWyn/MdLtlhrMlpWX5VyA+NViLrdBG3FK9GD+WCBxaSxL5ClF
 IvTwVdLoP8tSAaumwHeqhcvqndZ6yJxudCrBxwEoQ+6nG4E7ijUoDzYfE4WXgzfd1WB1LIN5t03
 fBxZXsM/XfMjQ0Xus9O4hpASLDB4ilSNXHgPbhW6QvRCGdvh24YSNUcNZCbwAd/JDNXgf+kIAFi
 D8wJnL+EGRDX06MnO0xIYK73RtjQ7C66u8pugVgu4aVqPhE91b32g==
X-Received: by 2002:a05:600c:5488:b0:495:4d88:e630 with SMTP id
 5b1f17b1804b1-49eb731f56emr15388765e9.10.1789543432835; 
 Wed, 16 Sep 2026 00:23:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:449b:f2fb:7cc4:bd4e?
 ([2a01:e0a:106d:1080:449b:f2fb:7cc4:bd4e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83b12385sm58567015e9.14.2026.09.16.00.23.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 00:23:52 -0700 (PDT)
Message-ID: <a55454ec-32b2-46bf-9f83-3b34be6aa6dc@linaro.org>
Date: Wed, 16 Sep 2026 09:23:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Change u-boot@lists.denx.de to
 u-boot@lists.u-boot-project.org
To: Mike Looijmans <mike.looijmans@topic.nl>, u-boot@lists.u-boot-project.org
Cc: Daniel Golle <daniel@makrotopia.org>, Heiko Schocher <hs@nabladev.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@riscstar.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.4c5643b3-0c93-4843-8d61-6d64d131693b@emailsignatures365.codetwo.com>
 <20260916050312.7618-1-mike.looijmans@topic.nl>
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
In-Reply-To: <20260916050312.7618-1-mike.looijmans@topic.nl>
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

Hi,

On 9/16/26 07:02, Mike Looijmans wrote:
> The obsolete 'u-boot@lists.denx.de' address occurs in several places. Use
>    sed s/u-boot@lists.denx.de/u-boot@lists.u-boot-project.org/g
> so that patman and similar tools, as well as mortals, send their e-mails
> to the correct mail list address.

already handled and merged with [1], your tree must be outdated.

Note we switched from master to main branch.

Neil

[1] https://lore.kernel.org/all/20260720-osuosl-ml-switch-v4-0-20ec1c334dd2@linaro.org/

> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> 
>   MAINTAINERS                     | 2 +-
>   README                          | 6 +++---
>   doc/develop/security.rst        | 2 +-
>   doc/develop/sending_patches.rst | 6 +++---
>   doc/git-mailrc                  | 2 +-
>   tools/patman/settings.py        | 2 +-
>   tools/u_boot_pylib/gitutil.py   | 2 +-
>   7 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 45e9076de67..89a525631fa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2050,7 +2050,7 @@ F:	test/py/tests/test_xxd/
>   
>   THE REST
>   M:	Tom Rini <trini@konsulko.com>
> -L:	u-boot@lists.denx.de
> +L:	u-boot@lists.u-boot-project.org
>   Q:	http://patchwork.ozlabs.org/project/uboot/list/
>   S:	Maintained
>   T:	git https://source.denx.de/u-boot/u-boot.git
> diff --git a/README b/README
> index 5653f687e82..d77acc48999 100644
> --- a/README
> +++ b/README
> @@ -45,9 +45,9 @@ Where to get help:
>   
>   In case you have questions about, problems with or contributions for
>   U-Boot, you should send a message to the U-Boot mailing list at
> -<u-boot@lists.denx.de>. There is also an archive of previous traffic
> -on the mailing list - please search the archive before asking FAQ's.
> -Please see https://lists.denx.de/pipermail/u-boot and
> +<u-boot@lists.u-boot-project.org>. There is also an archive of previous
> +traffic on the mailing list - please search the archive before asking
> +FAQ's. Please see https://lists.denx.de/pipermail/u-boot and
>   https://marc.info/?l=u-boot
>   
>   Where to get source code:
> diff --git a/doc/develop/security.rst b/doc/develop/security.rst
> index 84b130646f3..ed652ec756e 100644
> --- a/doc/develop/security.rst
> +++ b/doc/develop/security.rst
> @@ -11,7 +11,7 @@ Contact
>   -------
>   
>   The preferred initial point of contact is to send email to
> -`u-boot@lists.denx.de` and use `scripts/get_maintainers.pl` to also include any
> +`u-boot@lists.u-boot-project.org` and use `scripts/get_maintainers.pl` to also include any
>   relevant custodians. In addition, Tom Rini should be contacted at
>   `trini@konsulko.com`.
>   
> diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
> index c3e0ef27824..85b45e8f3a4 100644
> --- a/doc/develop/sending_patches.rst
> +++ b/doc/develop/sending_patches.rst
> @@ -25,7 +25,7 @@ Using b4
>   Use the `b4 <https://b4.docs.kernel.org/en/latest/>`__ tool to prepare and send
>   your patches. b4 has become the preferred tool to sending patches for many Linux
>   kernel contributors, and U-Boot ships with a ready-to-use ``.b4-config`` that
> -targets ``u-boot@lists.denx.de`` and integrates with ``scripts/get_maintainer.pl``
> +targets ``u-boot@lists.u-boot-project.org`` and integrates with ``scripts/get_maintainer.pl``
>   for recipient discovery.
>   
>   Start a topical series with ``b4 prep`` and keep the commits organised with
> @@ -51,7 +51,7 @@ additional runs.
>   
>   When the series is ready, use ``b4 send``. Begin with ``--dry-run`` to review the
>   generated emails and ``--reflect`` to copy yourself for records before
> -dispatching to ``u-boot@lists.denx.de``.
> +dispatching to ``u-boot@lists.u-boot-project.org``.
>   
>   .. code-block:: bash
>   
> @@ -86,7 +86,7 @@ patman now lives outside the U-Boot tree; install it with
>   General Patch Submission Rules
>   ------------------------------
>   
> -* All patches must be sent to the `u-boot@lists.denx.de
> +* All patches must be sent to the `u-boot@lists.u-boot-project.org
>     <https://lists.denx.de/listinfo/u-boot>`_ mailing list.
>   
>   * If your patch affects the code maintained by one of the :ref:`custodians`, CC
> diff --git a/doc/git-mailrc b/doc/git-mailrc
> index 65626d89eac..f0ba30a5c74 100644
> --- a/doc/git-mailrc
> +++ b/doc/git-mailrc
> @@ -5,7 +5,7 @@
>   # Then when sending patches, you can use:
>   #	git send-email --to u-boot --cc i2c ...
>   
> -alias uboot  u-boot@lists.denx.de
> +alias uboot  u-boot@lists.u-boot-project.org
>   alias u-boot uboot
>   
>   # Maintainer aliases.  Use the same alias here as patchwork to keep
> diff --git a/tools/patman/settings.py b/tools/patman/settings.py
> index 17229e0d823..fe65b1d3fb7 100644
> --- a/tools/patman/settings.py
> +++ b/tools/patman/settings.py
> @@ -162,7 +162,7 @@ class _ProjectConfigParser(ConfigParser.ConfigParser):
>   def ReadGitAliases(fname):
>       """Read a git alias file. This is in the form used by git:
>   
> -    alias uboot  u-boot@lists.denx.de
> +    alias uboot  u-boot@lists.u-boot-project.org
>       alias wd     Wolfgang Denk <wd@denx.de>
>   
>       Args:
> diff --git a/tools/u_boot_pylib/gitutil.py b/tools/u_boot_pylib/gitutil.py
> index 34b4dbb4839..59688aa7147 100644
> --- a/tools/u_boot_pylib/gitutil.py
> +++ b/tools/u_boot_pylib/gitutil.py
> @@ -528,7 +528,7 @@ send --cc-cmd cc-fname" cover p1 p2'
>                     "Please add something like this to a commit\n"
>                     "Series-to: Fred Bloggs <f.blogs@napier.co.nz>\n"
>                     "Or do something like this\n"
> -                  "git config sendemail.to u-boot@lists.denx.de")
> +                  "git config sendemail.to u-boot@lists.u-boot-project.org")
>               return None
>       cc = build_email_list(list(set(series.get('cc')) - set(series.get('to'))),
>                             alias, '--cc', warn_on_error)
> ---
> base-commit: ece349ade2973e220f524ce59e59711cc919263f
> branch: maintainers
> 

