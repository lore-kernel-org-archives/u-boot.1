Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEA4606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wSY4hdcz;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RH5TG5Ij
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77AB4405F4;
	Tue, 20 Oct 2026 11:40:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 49PZRKVIbv80; Tue, 20 Oct 2026 11:40:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 600C640585
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792496439;
	b=fxZpgR/IyjTZLUMZCJYN3A63YtmpUsU4MCGkICx+hFWkfkkXx6/TgJ7OH+u3LpHgL3qE
	 IVFfc/+xyT+R9NLtGFSOOd4Y/fCpF23z9jDg9mOOKVP7gdLKY01pAL84mN6dsdq4LB40O
	 P4QqJxZhzkvqxtWB6EkyRsZ/weL6m7h3cUZcH+joANhpT+7+DbJznYpBKVjNhN4nj9i7S
	 3O2bsHD1IucSkF6CSU7iCXCCsRxj3AZly3OWFxweE9KbfZo+ZsXIjZ851HC/5nL9zEQ1D
	 M+HnuUh2S4juyFOTu1GZ1bJdbvADwLO3rdnyaeJ72u3LGOqe322emcnj2rIqK2oAB0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792496439;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=M1USmkhbq+Mnb9rVcWsThF094bm2NDxEYPfrova6Kr8=;
	b=Eu8EqY5Q//OXfdsJJ39YZNN5/Bzhoxc2zdNxYVvlWfIeiBdTtt1mbTUsvV5pti3PHESP
	 2I+VEFbn1+Ds0Z8q+6cKsEevnsPuCAbE4yJjAj8UlT/g8EI1F0JuKLf+i/1hsQRDrEqRS
	 r2OUn3Bjdc1oRTaWUwAVye7KNIQHCf+N9LsWkIj6mbmS9LFjNIV6TagCC1/cJMAeMat3h
	 E48ljPs8fs17s66w9kFhxgq8f44hsFSqJYXGMWAI82RpFBuFodMcfnHORtH5bEu8adj9j
	 KYfCpx0qL8RvA0tWQJL1LUOmt8O7tf1O33vpJqPkXn6JfCPumCmHpio/tACYgm+bs/g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792496439;
	bh=M1USmkhbq+Mnb9rVcWsThF094bm2NDxEYPfrova6Kr8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=wSY4hdczUn+E1W0jagMMLf1W0JBlSrHYeBGWpTk/A84pvolN9XFqsvQHlMKqwV4aX
	 hw/31zkWSOOZ1S0yW4Jpwsrd8CLFGoGNWN8fda5wbdr1YtzRyryOKJHT0MkfOE/EgI
	 RjDLG8Q2vdGumAyyoED2Q/yq6CyUjPHbi2zqvHN9N4ilsM1OB+5rjxWFzWgcxD0EJ5
	 TqLMhMTs3nIMqcJvQf73oiBUHKmliKqB9e8DjOq3Rc0trD6GBQiAYDwFr0ZlNc/lWB
	 EyeWVenZMQ5CJY5mcLAcD7KOTxnend1I17wfbVshYMJPIjbH5pjNIcgU6a4HrJYNUv
	 619aT4GK0ki/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 600C640585;
	Tue, 20 Oct 2026 11:40:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1792123A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 11:40:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 09802400A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 11:40:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XMVGNgvy44fL for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 11:40:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A16AF4008E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792496437;
 b=WgfZZGN2S2hiqx45mdk7ZtCNuKPYkTCeDuxymxQcKrcdtKyrZG4foJjKq5jV3wtUE74J
 35AUTFM+vNKVVjeCBUac2cZIJF0IxNn7qS8RbH/FHW3A2YErJ9WND8z88YRwgI/kDD0NF
 owXEuniZpvEltVf/srXOkD1VbPR1SECS+XWxGeK2+tQomR7cx9WMf2DVVXGAfVN30/QA+
 NGAV2LqE/bYOjYnnlC/9qku13U3RTQ42Lp9Ng0g/Mx9gH3zZBGdFCHQqmGkaWnXiGe3nn
 wtmZFzl8Jh8oHNYTVZeWh8IGSv7+gfycOwGijg6LDdT1BCOtO6FVYbg0UZj0rKH6Vsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792496437;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:From:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=M1USmkhbq+Mnb9rVcWsThF094bm2NDxEYPfrova6Kr8=;
 b=cLb1WeIxDIrVYtCYexyNq5sI/PCOSAS0xIPBu0Fng0Wp6BLGJznkzsEXjAwcrCD3ajI+
 HxlLHHJ+cBnmKhhx8G7CQCzcJ1OAqovVg1rNryQsMuw3CNSngspiki6btRHx9HyQsTVll
 LtBNb2XyogHQwKEA8mTsiMB3s/KaR8eYR4BRX+N7Dayj2imTBYC90sQmcvfOLj8UIOb3M
 08s7SoVT73k0Hx3xJJVUNX9G64cPnUkk40NFAakEIwWCafR4QDvTKnZ3NYMI0/tw02UXZ
 LkofnNSUD+EBJygAslHKt7gsRcVqHrLGTHa04h7NvgIjipCKewo6eSLqv34wQn7xMcA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=RH5TG5Ij; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=RH5TG5Ij
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A16AF4008E
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 11:40:35 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so560018f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 04:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792496433; x=1793101233;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:from:subject:reply-to
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M1USmkhbq+Mnb9rVcWsThF094bm2NDxEYPfrova6Kr8=;
 b=RH5TG5IjqXA2HNn4ccEe94B2s520FnI6bBZg9REi4MMOXBJ0lrPdsBhjwvQuOjjoXw
 l7jN6nLBn/Ps8a5WnbLjSs5AJN4X0usanEOd0+g9rv7YOV9FCvaf+zTiO7vVAulmGWN3
 GL4bh6D2MgRyJf0gV628FBzkocpdhg/kXxLj0kBAgXfVxuU0s9E90ZghxV2YqO38D6Xn
 Eh9GsctF/v8NYCKLqqIvvEahR3Ss61oQtM6ITLvQAQN3wPIIxICVgNaO5UkTyJv3jUXe
 or2oVekpj0SZ8/z751lINXi5U6/fqWf45XGIs1o3CiadPIk+xMu5mzHCxAyHDTGhrXYD
 Wv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792496433; x=1793101233;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:from:subject:reply-to
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=M1USmkhbq+Mnb9rVcWsThF094bm2NDxEYPfrova6Kr8=;
 b=nkNdf7IjlGSSbQtEKmV/yltCJoAPUkq15ro25E8nHx4PQ2cXXdGBlx+0Jk3tZn9OXj
 VSHtCro9Xbh2TO3oIj9360jG3nw/RhdreFyQiwcYEoo1fLRNJkWSKv4wvOKYqzjixzDl
 o8IfMY1omZkbGCu/FxDu1SScjsxjlQG1scKOhzxfK8sLNoHAkHKLSih0K7IrwBpu9CMG
 qKb+gRtl/03Rm2MHw0P5rkQgOvT4Ev3atzq/7UPxlFUNRLUecC2wiGAQTHMvQ1t+1NlB
 UJ8fuXiqDmjweKMNoSRPYx8KJs3eJrqrF9IJlJFtZkkuadZJ7D8hExBI/lmdHDAZyCcf
 0VwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwqleRJHkEATFLuVh15qKNs6pmqgBh6TRvb05xVIL9VKmVm8wDPo+wzFnr6C3UWbqUCR+M/7qs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI/BxhJeC8GNcAdnYYT6Ld3azzswoGaFbKKlnX5VPsxgSui2acJ
 7PfvCeJ7RtduXuIC2/mtnTGTLo+i4ulk2OqwdPZp13C6ysKkd4gqA49pKsEUKZUH9IQ=
X-Gm-Gg: AYBFou3NWzaeGVoUARyHzTUc399mWTW8ygWaZc7YQndmTIIroJVoYwgeMwgHu+njzNT
 Ba1h187WWnNugQCGcrO8UZCWpPiSR7JEkr+KcW4DW5z5h2/L8e7wKy7XSPz0CkQDaRX0aiwhHG1
 YOupbpVDV5P12zGlGziKg7IjKas6OYgb9g+/XwIRAHzc5wHVTkuU+xwj5rZoKnOtlveLIHr2SFs
 9TfoUb2sT0wCx+qR4EM27m+OIPBR0qjd5sUJ/1boy+ZVk5NP/kCsbmreszjUdMkoOJMklhgkYPS
 CItxONAUVuI4Jhh2VklXbTKjZoKSyLaF8jPh5Dz0Jp9K7MWysnnjZVlu+L7bBhVB+uXx9Z5/wHd
 odSABYovjuSPJyglVADVODMObiwhhLdAeni9Fye1M6FMpN71SpGwyKvv9qkmQausEyyBVcHHXsk
 4UmrRb/8Lu258GyQt1ibNbOJ4QMOpjzyJyYysMVnQJ5EXrEDCV+dAiXbvWxr31I6FE2dXagkjH8
 U6QQjxTPISkrIxKWcDB5Wn4WWowIemR3Y4XR66xcVf0reh3vji7TbY=
X-Received: by 2002:a05:6000:46d0:b0:48b:437:8fbb with SMTP id
 ffacd0b85a97d-48e1e7d006cmr2706042f8f.19.1792496432947; 
 Tue, 20 Oct 2026 04:40:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:e3a1:1a65:a394:be54?
 ([2a01:e0a:106d:1080:e3a1:1a65:a394:be54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d823cfcsm5582511f8f.39.2026.10.20.04.40.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 04:40:31 -0700 (PDT)
Message-ID: <f4307312-0767-48ba-a5b4-4e8b4ae534eb@linaro.org>
Date: Tue, 20 Oct 2026 13:40:31 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] phy: qcom: qmp-combo: honor USB-C orientation for port
 select
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20261013-ss-orientation-v2-1-8daddb44447e@oss.qualcomm.com>
 <ccf4e1b0-cb62-4950-9265-12731463e15a@linaro.org>
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
In-Reply-To: <ccf4e1b0-cb62-4950-9265-12731463e15a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 11:16, Neil Armstrong wrote:
> On 10/13/26 19:08, Balaji Selvanathan wrote:
>> The TypeC port-select mux was always programmed with SW_PORTSELECT_MUX
>> set and SW_PORTSELECT_VAL left clear, regardless of which way the
>> USB-C cable was inserted. On a board where the cable goes in reversed,
>> the SuperSpeed/DP lanes end up routed to the wrong side of the
>> connector, so USB3/DP never comes up correctly.
>>
>> Cable orientation is reported by a GPIO on the qcom,pmic-glink node
>> ("orientation-gpios"), and is now sampled each time the PHY is
>> enabled to check for the orientation.
>>
>> Taken from Linux commit 815891eee668 ("phy: qcom-qmp-combo: Introduce
>> orientation variable").
>>
>> Tested on QCS6490 RB3 Gen2 board.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Instead of reading the orientation at probe, read it only during the PHY init
>> - Updated the commit message to better explain why this change is required
>> - Link to v1: https://lore.kernel.org/u-boot/20260724-kodiak_ss_orientation-v1-1-d9d8fd271e0c@oss.qualcomm.com/
>> ---
>>   drivers/phy/qcom/phy-qcom-qmp-combo.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/phy/qcom/phy-qcom-qmp-combo.c b/drivers/phy/qcom/phy-qcom-qmp-combo.c
>> index 0d63e482ee4..65141489d51 100644
>> --- a/drivers/phy/qcom/phy-qcom-qmp-combo.c
>> +++ b/drivers/phy/qcom/phy-qcom-qmp-combo.c
>> @@ -7,10 +7,12 @@
>>   #include <dm.h>
>>   #include <dm/device_compat.h>
>>   #include <dm/devres.h>
>> +#include <dm/ofnode.h>
>>   #include <generic-phy.h>
>>   #include <reset.h>
>>   #include <power/regulator.h>
>>   #include <asm/io.h>
>> +#include <asm-generic/gpio.h>
>>   #include <linux/bitops.h>
>>   #include <linux/compat.h>
>>   #include <linux/delay.h>
>> @@ -39,6 +41,7 @@
>>   #define DP_MODE                                 BIT(1) /* enables DP mode */
>>   /* QPHY_V3_DP_COM_TYPEC_CTRL register bits */
>> +#define SW_PORTSELECT_VAL                       BIT(0)
>>   #define SW_PORTSELECT_MUX                       BIT(1)
>>   /* PHY slot identifiers for device tree phandle arguments */
>> @@ -283,6 +286,27 @@ static int qmp_combo_com_exit(struct qmp_combo *qmp)
>>       return 0;
>>   }
>> +static bool qmp_combo_read_orientation(void)
>> +{
>> +    ofnode node;
>> +    struct gpio_desc desc;
>> +    int ret, val;
>> +
>> +    node = ofnode_by_compatible(ofnode_null(), "qcom,pmic-glink");
>> +    if (!ofnode_valid(node))
>> +        return false;
>> +
>> +    ret = gpio_request_by_name_nodev(node, "orientation-gpios", 0,
>> +                     &desc, GPIOD_IS_IN);
>> +    if (ret)
>> +        return false;
> 
> So yes it will work with single-usb platforms, but will severely break
> the other platforms with multiple controllers (X1, ...).
> 
> The real way to fix this is by following the graph to the pmic-glink,
> not the simplest but not the hardest, and there's all the required functions
> to do that in dm/ofnode_graph.h
> 
> The path is:
> qmp-combo/port0 -> redriver/port@1 -> redriver/port@0 -> connector@0/port@0
> 
> get the connector reg and use this as index of the orientation-gpios.

As a simpler alternative, you could try to get the orientation using the
PORTSELECT_RAW field from the TYPEC_STATUS register, or enable the Hardware
PORTSELECT by setting SW_PORTSELECT_MUX to 0 and enabling HW_PORTSELECT_SEL.

We don't use those in Linux since we need the orientation info across Linux
subsystems (UCSI, PHY, DP, USB, ...) but from Uboot we can enable the HW
select or get the value from the TYPEC_STATUS.

Neil

> 
> Neil
> 
>> +
>> +    val = dm_gpio_get_value(&desc);
>> +    dm_gpio_free(desc.dev, &desc);
>> +
>> +    return val > 0;
>> +}
>> +
>>   static int qmp_combo_com_init(struct qmp_combo *qmp)
>>   {
>>       void __iomem *com = qmp->com;
>> @@ -333,6 +357,8 @@ static int qmp_combo_com_init(struct qmp_combo *qmp)
>>                SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
>>       val = SW_PORTSELECT_MUX;
>> +    if (qmp_combo_read_orientation())
>> +        val |= SW_PORTSELECT_VAL;
>>       writel(val, com + QPHY_V3_DP_COM_TYPEC_CTRL);
>>       writel(USB3_MODE | DP_MODE, com + QPHY_V3_DP_COM_PHY_MODE_CTRL);
>>
>> ---
>> base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
>> change-id: 20261013-ss-orientation-d85a156e806a
>>
>> Best regards,
> 

