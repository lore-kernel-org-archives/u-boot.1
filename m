Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0312D606B35A
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VO4hOlQl;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uJ9BRP0S
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C900C813EC;
	Fri, 13 Nov 2026 17:31:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zOKYy0toEUJm; Fri, 13 Nov 2026 17:31:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 30E4B81501
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794591066;
	b=Rj8xGnvg5PO3H49fBqJiHzTD0KXr5ZufnTxLdL71Tx/hzAnW1HitZWRgYUpy3ISAiUIk
	 eocNqJFiohnxPUBigx3DxjMGg02O9pSwe+WpeaARzvP1lxViE+W/kMx2Cibq2Sgptgvt0
	 24tr0ozr6kizbCa1ER/TkT2W8QFpEsUfvOqrRdPBDls0rXQTbkp3Jg757Pa7OpdgG+u6Y
	 S3QA9iSaOfrLmEQtIBDszAhFAfSJ9IeecmeBcAq5SRKlUimhRHUGwioatlwQ/zxHYBvIY
	 2zI4Xvr20vQc0Gw3RdUHZQGZsP/5DuW0Jx9cIqhqDzLWP3c/9BWScuQwS5xgXi1LgcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794591066;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:From:Content-Language:
	 Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=CEzrmz5bmONqpF7jse/Wi41eSb2eQumsSEjHqT9MT5Y=;
	b=DSVYl2Tt2VYzrN21jrzl0p6A5AoEMg9w8Do3+s8zEkI2NY9MoRbhd0dk0PHVRZLmYTGk
	 goKaM+QgOIEDMXt5GG1TpacNdLsm4//Eaz/pG4oRG+lf+ifV1wmz/CXu9NCGutKIzdbKb
	 Z0+AsXX4mYH5oQaOQWORXp2/XzJ0lO8HPX9ARHS2Rlc4hb2Re8yRlkr9RHjVCa9LKSUu5
	 rRKDgq2PTCs0Q1bz52T2WbjOT+yV149EysndY3Qu07WskO+hT/4yjERcn4r/EFIubyUSx
	 Y+SRpZigklwOjpbnHrWXJ+rRPm7o7rJsickACSdTVgiq4LJfGiu4MV9mCMTNwiDHMfQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794591066;
	bh=CEzrmz5bmONqpF7jse/Wi41eSb2eQumsSEjHqT9MT5Y=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=VO4hOlQlgPBD6aEHK9hdP+8y82cNfTNtaVhISLDxy+O5pgL3Eq81rCxNlEW1kH/qm
	 fxmCoRlzDMo1TTtOFNEUyr63zqicp0H7bY9MDEeS/CeE5LyWDidRCClTz8bg+Gbek6
	 qek8uwchBsoS72cEJT5dkTkKiI1iyFwMEV7syOh/ef5gIZlmL5CZtfPKKPyMdQFot9
	 pakOhHX2QmvV71wt6ihKVlT4w3diMrjmEK+0hAYwhdQTpp/unyXntojHiZRB9s1xeT
	 h0A6W2QyDxbGftL88BENpXMfcM/cpP0JgrTWpuosOrACmyHaKwN6HVqFko5Q1WWyHh
	 StoWT92ICoJHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30E4B81501;
	Fri, 13 Nov 2026 17:31:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 91869F46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:31:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 83085400A8
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:31:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0PRiP_VEGoSN for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:31:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6887E4005E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=uJ9BRP0S
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6887E4005E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:31:02 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so6335445e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 09:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794591061; x=1795195861;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:from:references:to:subject:reply-to
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CEzrmz5bmONqpF7jse/Wi41eSb2eQumsSEjHqT9MT5Y=;
 b=uJ9BRP0SZ8dXfPLw20RU1HsnuD0dwjKAX+y+HF/vXsrbrUNV45nh4M0tiQdZBAN+lU
 tQeqnXCeyYzIeVGaUHx5naUKuzMyUr75ZE1Eb93C69Y+Hp5p9UdUOW4kNdA/53qFY9SD
 d+ViZBEt338idK1V3ou47rPbE6x8cqGPMcGBIIb6S+pnWq18QcimZUGuSXRMwVRnClY/
 cym6mFsm7SjI2fcpeZUoamNmMbxADjdqPjp+cugv2ZWfAholIKEeBKOZqmDPnJLk0yR/
 bpLvsiB1lTdNva0Uw7e7S6bqLOJ7u81Wp7lr9e6lrWwDFblBqhDriCCJ9FQTpFD/f7W4
 N/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794591061; x=1795195861;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:from:references:to:subject:reply-to
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CEzrmz5bmONqpF7jse/Wi41eSb2eQumsSEjHqT9MT5Y=;
 b=dpNUxeK/sGS84YoX12rMckH0M68euDfhJVkyH6sx1JOV+dVsL/vqbH4ZZi6f/A8vd4
 kvOgC4jJ0BPY8La26OrVL42euUnCsZnZG120KGaTCSFy8puq3RnLqYbbhSGW8zPMsu1U
 rMK6bIG6nxFE6UkRtK/dcnikqIV4fdaIYUBPCPNobRkOv//Bvjg9iQ3ZTaKFvJG0/2GT
 VgG3B5G6Qycf8hvXJWgjYbMlLsMCd2OTDyM6YAgVzsEH2mObbSoYMCy+KiTvm4nhLqkj
 HTRajmmkt5WBN2q2Z+p0SxIpTgt6nKKwL5X5rlyrftTdBX9l775Rb1aH9R2Afq6RRrHg
 sYxg==
X-Forwarded-Encrypted: i=1;
 AL+hErFUm9V6JaUT8cvclNZhr9mGQn7hXUtmKdoKrIAJ7pGg3kJjrNsJyVf79eqVK3Kavixxd3aAtyI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+U5HEiGI14O963rj8PwdM1gL+3YMQpsfVO24/P5F9kG6YbRRJ8
 hzkPEioj3ZAP+2GmD7CW+La6TfizRu4oeVttszWh3JS+pfAWsnBGomiQSmPjnW7Ytq4pi7Y3WnL
 gYrefW3o=
X-Gm-Gg: AYBFou0rrTOE3JDg+3m+FHe9WbNZxh3VBkPvtv7w8qBSZ6PVRh8HSiovhvTjeThciBU
 x81kU8xpqAuQkaXGuv/W5ubrdl8dn6yZSLxVTOevEeOGkY2EJRk+bwh5BMFJ5G6K5SNZQ2vDYEs
 hDvrx0snjvAcbPOgHk8kcxOhULcoy1/bg86Rs0BbPuCchaz2UqZ9w9dDvFspt/NYgED4Y+mcYUH
 cov5B5FCyq+f/HshPnWkWOq8AdcrkAKvooWqX+fsGC7AxURSKp8jcpbgcSH6mT9J20rxrISIgJj
 EZF3NGzmBKysGWKipb1UEaH8A25LbpVMWpYNIKWOvvWkNfNL8O7o37mDl4xgRcETGbwGoHoAHZk
 EMHLeXhvx9tFZMvWTVOojLL9UvctLgEVBdISfBQl2zHAq+Cg06v8BsapPbLMiChqnqaK7I0k6cP
 ieXVfw0r+pdJ/Y5yzvZpmQowcXmlnXzctOwy8aVITqZoIKI2pk/DQiHbvQ+5oX9CalcoaPo3xbb
 ZdQKcEkOa4GJX/cZCiariXqgltVtM8tuTKDwJvt4zMdzGqiLdyWtOUCBRsSR613yUgzrRaj0ruL
 Tf1PVqzT3h1xhDOlvvnywbRpecRZdrYy02k8LDbVs1b+J0c+nLA6dPlP7mrNcIz/0f7WwOsOUnJ
 Fed1dj0Ee
X-Received: by 2002:a05:6000:601:b0:498:be72:636a with SMTP id
 ffacd0b85a97d-49c722121a6mr7308314f8f.32.1794591060596; 
 Fri, 13 Nov 2026 09:31:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:425d:19c0:6d18:4379?
 ([2a01:e0a:106d:1080:425d:19c0:6d18:4379])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60021375sm5884439f8f.29.2026.11.13.09.31.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 09:31:00 -0800 (PST)
Message-ID: <069d3ede-5727-4c3a-a7be-b9dce9eeba7c@linaro.org>
Date: Fri, 13 Nov 2026 18:30:59 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sandbox: Take over maintainership
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261113154837.1214404-1-trini@konsulko.com>
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
In-Reply-To: <20261113154837.1214404-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 16:48, Tom Rini wrote:
> Take over the maintainer record for the sandbox platforms from Simon
> Glass.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>   MAINTAINERS               |  7 ++-----
>   board/sandbox/MAINTAINERS | 42 ---------------------------------------
>   2 files changed, 2 insertions(+), 47 deletions(-)
>   delete mode 100644 board/sandbox/MAINTAINERS
> 
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
