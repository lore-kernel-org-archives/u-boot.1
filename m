Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9A1C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 12:41:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD9A8607FC;
	Thu, 10 Sep 2026 12:41:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MVL2ZN-duA54; Thu, 10 Sep 2026 12:41:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3B59E60890
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789044092;
	b=FLCJ1wWkgfdaVWko9T7FKiZDdTgI0p3/AuuTzN/gBdjoiHfVK59fAucLBVg5Fz8kBcCU
	 ovLlZ6mzbFq0+KbiwLPLvqFmu+NWRQN8eiOvPoV8Q8Wt9xjL7d1vp2lWU9Zgo9P63pI/X
	 Tx4fHgGGJLT1LrPCXFsbGDWudW5/aJX2zmcMaQwEsyyKpO+FLGh/vukpTTOb9RSR52nzL
	 D6p+iG980G/0qPmTMrccYo7EMn0441P0ZkmMNvGfKNLceX+EsL2evU/Oq1qEBDQmuF3Rg
	 qRVLl4QIy9HXJA2zi3G6ikl3Feg2t9TI9Qf4HFboHA80KxtCKfp2Gazb/JOS6e5bXlg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789044092;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=FmMLpHQm5g3H5PzSquKTnJx3YwGTE/DIaGlf8ALvbFE=;
	b=WBixsLVej1JKfAH322BbJv9jww421etpUcBv5zy16nCgBJ3mKlMu2ta7YM9/aK+rfIKj
	 1F0UiZrd6okhMci+7cUvs00r81UE3rnVBMVQIsl9faqY0DItcxmojR/UsFpJQ0qGFx6Df
	 j3+v3JvFs1lO49XsDF5UZnNEkjLvJc4QU26wUr/jwVvyMaut7/mt5KuwHs77ly0bT+qaA
	 FVv32pXr7U4Gzy663tGX90Zr9H/zVh+6u/URwhFbcDp2Fbpa7qWXK9y4l5oFSEIW2t1a0
	 0nPd/9MIvlNqhLMH1DjYs6igLnqn9uGRJGkea4+qzImz/SVLGE0nvxVcintgwaNi33Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789044092;
	bh=FmMLpHQm5g3H5PzSquKTnJx3YwGTE/DIaGlf8ALvbFE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=k1WS3ztmjFiSQEmvi1WF6ZyWe44upXZ0I6ABDzYUurAFrNqRXgvgVn42BecQ6maQB
	 iVSFdBBB6v5YthxMQBo2TM/bgM140PSXMCRfhwv/p+CXnVnOsUHn1NTOtM8J6g1qzM
	 B0ZkmCEyhJTwnVoYn3R42ptSI4KqWAwhUlkBRKCnvow5GvufyPyF7OAP+dYOWyekE5
	 O15lmspXh2db4SEM2mk+aVYpvd6BQFB+M+HekxozZhYg4BaFcCkg2UsvHTiMmaq6x/
	 xZ0FKqBkH4qCCoH/b0goG4SmftSo1BP3oxVUPw/FwEpJWvjwlplN6UoKIa5LQXZDk8
	 YY0TAEFZ+cxgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B59E60890;
	Thu, 10 Sep 2026 12:41:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D8DC649D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:41:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BEA5340A37
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:41:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W6nU2PiEl1lh for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 12:41:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A092840A2B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789044090;
 b=H+LkyN0Wy6lLOGG/oPny9/s067NSeZ9RyDwtMxc2pCok+89brkaXdHxph93OjpT/6QPb
 ChjfBdMgQnsJlDuHGjJr05jUhpAh0LvmE+5WCcsrcXiTRmRqqcpdXaQEWv3/nBQaylD7N
 29CGc64nZWOQhFzKyYwWE+eVODWnqTdqJMLc+IJ0ozUem1KoiS8eXJXxWoMCapqdwTWAi
 21ILkRoeU3145i8o/aUHoX7JpRv+OEqhy8r6qUNY3dFS6QsqQ28Ubn4BheLITO9pHSviR
 AHcN5NteLeDPBIiEJYwUE5iDt+skjV4ehvSAHd1r5+pPYyxQI295txCDSYpJtUd1Xnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789044090;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:References:
 Content-Language:Autocrypt:Organization:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=FmMLpHQm5g3H5PzSquKTnJx3YwGTE/DIaGlf8ALvbFE=;
 b=n94NC6nIXFOqIOsiMV1rNrq8n+aWHKRf2JLSZ5r9f3cfWFajnxsaTU5QVZtcxhTiPz9X
 K37dD1v1w7Jw45Y/+5JjITsrtqmbqCzLOMU+R5KMMpGZCJzaTKNhVnerYFD/b/v8Ve627
 Ku+hRQWiAFL2G7+i/ik4uRTejfHk2rY2NWeBcjI0ZsCxMsJ/PM+kZut01yoZscrlta7Fi
 ATdgOUO312PXNqnmYG7tpa9ww9lOpdvbqqdau8bdrb4e0xQLtpETx4ZtH7BeKfIldN1bj
 rPvUr8b5MjUma0+iAqAV6MTozkuYPHGeXKSKzQ2VV1jokd3BZ8RXBjE1dNRIyU7gR2A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=brnw45qy; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=brnw45qy
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A092840A2B
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:41:29 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49d036e0e99so30953265e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 05:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789044087; x=1789648887;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FmMLpHQm5g3H5PzSquKTnJx3YwGTE/DIaGlf8ALvbFE=;
 b=brnw45qypEYnMzi6TQk8vMUMPwFXH4uuHCZ/V5TtPA/OTRxt9L9wsW/5lHqbds0GC7
 Bsr4WL3+X5WcQz0NTzuVu9RngtTQI1XBQRvB7wTyTUQK2h1mJ5MsTE69ZNRiyocvWKLu
 fstvsnvpB0cFBh24AN62NtHb5MGr9oj1Uh+hAEhlVOtgByZoVQOUNOcznLlKVZSUEDuk
 Emx42PUXOPaB1c4pus95bzZdu8jMw8UgaQrY1VRIeNI2b1Pq06CCw7yjjDsGiRX11A+Q
 Iqy9zJ+F8GwStl3+FTfsS6HOIzJGk5NEIEny6CBvtHrMAFAlz3Yu+VsLLnWH7z7RDWhR
 Ydsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789044087; x=1789648887;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FmMLpHQm5g3H5PzSquKTnJx3YwGTE/DIaGlf8ALvbFE=;
 b=N3fpijwHgqTsbqumjRSxFHGekskps2K27VcUe1DACobT+fTFM9z28Q4nCJWXgFK6fH
 xTAIoUy86710hr6uYRmcGGI+fvjPqoC4Cdu5DUHw3X/+2sZNHHhNqqVRjrhKPlotsaF6
 19nHuu3hr5zl1KpTPCQPKk/csGjgav7Afcc+uXpRi/t7lRNjpvi0zMoreN1MyqCl1w8u
 crEHZX9BiRSJkjxnAKO1KmWBfLYlCbuMUG0EOV+pRiBNF5Zim54ovfFrEv6yvIdOH/10
 Qg256FBTKXsOCXiEI1TP1Us3fzmHn13d37Vnf9csDF+xS3pfUD6TPSHYIOn74ffIkOQ5
 g/rg==
X-Gm-Message-State: AFuF++nQWDioKW7lQWmQ4WTwxneu0tGq9y4Dzu3YcSi5FqXWVgsA3Q9/
 VWuAi1vhKFuHnHe0pwsumn49HkyYcMVrH9SJsljXiAKn8mz2spzhn5sGvUN8WTPlfNo=
X-Gm-Gg: AYBFou02x82WtwmKdtwJueR4rgvG5ZIp6mR8sL01ZOwa6dG+bNskZ88Puln1DCuV5J6
 X+ssPV2wjK7GLavEOe4MDHok58BBaMtcryhHHAHc0kQioFD5X4s8MO7D/ms6nG7mFbr39yoqS79
 lxiaUkEMMRe8Lvggcg544fyvgELT+22SH7L18CzjBrjHLe6yPO9kL2Hex6gUU7gXwl6M6zE1M9U
 Y13vprVl33JwJH5+AbbAbscHvflzFzgynpbJCDJ89aDQMjii98p1U+Go8ulHPE+Jzjbuwz07QEJ
 WqHdy+GLuF5Fa5q171aHoGsS2GF5/n3/xlAQCTokwu8Vc0Jx6sA1FT7txqqiphXBRChWYdRnq9z
 a1n0gg+iVrHB+ryyxMgXNXfTvtwBHLBaM6g/BrZl1kcq68URiFZe1Qpd5Izv7yWbOFHLlx3ylxs
 aQ0y7ub95W3By+sQL/ogq00Bioyx6XZV8j/0RggSeg/4+LngzRm4P/3zBrbaLFOk0KBRpRSeOF+
 vxaaJ7zu+NkptSMW4Z9S6E7YaZZdMQRaIW+G7v21ZVbtWTVf4Os+A==
X-Received: by 2002:a05:600c:1c29:b0:49c:fc6c:be03 with SMTP id
 5b1f17b1804b1-49cfc6cc06cmr396674855e9.26.1789044087048; 
 Thu, 10 Sep 2026 05:41:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:edd1:1b07:ea07:35f2?
 ([2a01:e0a:106d:1080:edd1:1b07:ea07:35f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d20fc23fcsm115537715e9.3.2026.09.10.05.41.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 05:41:26 -0700 (PDT)
Message-ID: <4bc5ba5b-5563-47b9-9c56-18c6090264f4@linaro.org>
Date: Thu, 10 Sep 2026 14:41:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/7] pci: pcie_dw_ti: fetch num-lanes from the
 device-tree and use it
To: Siddharth Vadapalli <s-vadapalli@ti.com>, trini@konsulko.com,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.u-boot-project.org, srk@ti.com
References: <20260908051741.868824-1-s-vadapalli@ti.com>
 <20260908051741.868824-3-s-vadapalli@ti.com>
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
In-Reply-To: <20260908051741.868824-3-s-vadapalli@ti.com>
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

On 9/8/26 07:17, Siddharth Vadapalli wrote:
> Currently, the PCI Controller is programmed in a '1 lane' configuration
> unconditionally. As an improvement, fetch the 'num-lanes' property from the
> device-tree and use the specified value. Fallback to the existing  '1 lane'
> configuration in the absence of the 'num-lanes' device-tree property.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> No changes since v1.
> 
>   drivers/pci/pcie_dw_ti.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/pcie_dw_ti.c b/drivers/pci/pcie_dw_ti.c
> index 37c295fdd38..fb39132f7c1 100644
> --- a/drivers/pci/pcie_dw_ti.c
> +++ b/drivers/pci/pcie_dw_ti.c
> @@ -58,6 +58,7 @@ struct pcie_dw_ti {
>   	/* Must be first member of the struct */
>   	struct pcie_dw dw;
>   	void *app_base;
> +	u32 num_lanes;
>   };
>   
>   enum dw_pcie_device_mode {
> @@ -278,6 +279,8 @@ static int pcie_dw_ti_probe(struct udevice *dev)
>   	if (device_is_compatible(dev, "ti,am654-pcie-rc"))
>   		pcie_am654_set_mode(pci, DW_PCIE_RC_TYPE);
>   
> +	dw_pcie_link_set_max_link_width(&pci->dw, pci->num_lanes);
> +
>   	if (!pcie_dw_ti_pcie_link_up(pci, LINK_SPEED_GEN_2)) {
>   		printf("PCIE-%d: Link down\n", dev_seq(dev));
>   		return -ENODEV;
> @@ -332,6 +335,9 @@ static int pcie_dw_ti_of_to_plat(struct udevice *dev)
>   	if ((fdt_addr_t)pcie->app_base == FDT_ADDR_T_NONE)
>   		return -EINVAL;
>   
> +	/* Get the link-width (number of lanes) */
> +	pcie->num_lanes = dev_read_u32_default(dev, "num-lanes", 1);
> +
>   	return 0;
>   }
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
