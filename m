Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97165CC6B2C
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 12:19:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31A95403F4;
	Wed, 14 Oct 2026 12:19:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id viRiNOlR-B6G; Wed, 14 Oct 2026 12:19:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6B73E403F8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791980395;
	b=EGAqHPwAptK5v2lKUHv2WnzCtOMGYwNZt5V4WnfFD0ds8s0GlJ2M/OuQ4XYgOqu3RPhD
	 pJ0V+srPmoAfACFdCCh01ICEVM7x/TzRMIFh96yUuHchfg67gvJG+YmQQ3a+TBqgVdHc7
	 fV5iNByU4+iLV52/+86f7khpAX/caO/MGjTVGbliwZiT4Dx228UOjkPsWy5hywX2bQhyi
	 SVY62YGuQjN4cYoK7SPW+zIMPoDxSEQ3yI67uV0zdjSP+0hXJSvHlSFTFURNdt4O5TBUT
	 ghbHL0mcdXbVKVPMnCDTE3l/gnxtSKH9M7pndVUzBPEih5aePxKBUY0p4nbeaNOGsfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791980395;
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
	bh=+qv7iQH1oGXgjdyc8ann0xLPWymHu3TYUtIlxSZ/YMU=;
	b=EIyPNIrZmFC6lRIXhbTkVQLMz764Is0d4cBegOWhClhoigOYjJ0nNQLzXtlBkJYC45z9
	 fkNETQ7IZ9F0smh6mb312Mk9Ti+MQxM5p5syv4TYZU/2/la/aJvRDvsNF1HkgELLOn4wh
	 kG71tfjrJT1Z/sY8D6d4Kuvw+waAKRnEhc5f0VzwQ9wTnqbUp0FzPym3q/D3+XPo6GrDq
	 kwuRV48R2C9XWBqCzFp57cSKNpsQB1Z7MmpAiGcNncH+bt+ZnUYkw5skas4QibP4SZ0TH
	 G6XfkAPv3cJjbUFzg6xVqhJl6S37w3XJJ8iSNy6Ugp/Wr7Qjpi/AAkuUQhFBy7DyF5g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791980395;
	bh=+qv7iQH1oGXgjdyc8ann0xLPWymHu3TYUtIlxSZ/YMU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=MtIcv9e+BRR1szIw57/KVwcJCc2200myE/jEPPHHiWcr2rfJl/UQ4OJ1Pa9ls1qd0
	 eRrBCKJ+VGEV6vFEh7q0vIEzt0PNVwGZ2fJYfbv1jHNieZ/FDEn4I6gUCxg6a+trBX
	 HoK/ebiG8srMR6oYn9d1BTQtAy86cVKZayGKEUYvIknko/QDgxkqkGGZt33ebWUQcT
	 9uvsY6rAAcIhEMOxFdNL8H1NREvHE7uiVZuWtLY++6UhlrtMGMQrYLDJuOpudFikAQ
	 edGXp2AFbNpPE/7G6TLLD36YRTRE5GBDceEDnfb6ACKm+5SuupP0lxbfdTFUXwzO0T
	 8/XjykEeo87Vw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B73E403F8;
	Wed, 14 Oct 2026 12:19:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 37E9C4DD
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:19:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1DCAC80874
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:19:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4-jofh2E45gL for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 12:19:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DE84080865
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791980393;
 b=lRhyKkRllOuaQ0sxLuJr6w6IltYPRyoYuDly7LxOqKRy5tLDmDhrk8f2Tcr4f7vUJxuA
 B36rdrWMB+scv/yHXyKlHRBtvDreixPMrFzg8joAuuZCO5M23N3+GTeiMpg9nrdVr+tmU
 BCsBS//O63at7putJrrQqBlXgFlgMlGDzN+At4plf7VRqmmMg0R6mPtDLQBAy3UeeH2O8
 MjgANQC+p3xT7J+Rspvh4dE4nJEDD89p+NCODQbYqrv5WKHBG0cLfAc3Zp4EF4gw/kjXG
 HVQTzW2Fzou2JjISvnTgRU1RfGnLrvLbpC7YIWWE0Bf2KMut2PS7xDksFmwz7gKzA0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791980393;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=+qv7iQH1oGXgjdyc8ann0xLPWymHu3TYUtIlxSZ/YMU=;
 b=YEsdRxR40KdxahsQEZP6u8kbF1BX1B8KlXfhPLTGjtDajd4wSl8Lp2n2m+ercBVngLOv
 cPT+wN56/+C1YRBviIG+9zY4VsMxv/JjzY0cKXIQBi9Xy6V+UfzRMehcOauXSFWqp4mzy
 U7OwHo6aRhskgoCU8xPbvop/GJ8aVmN+/NuutyKq0yy2nXO/vM0KFx1Hj0YGSD6JVRk9c
 +kdEpOBW/1kXl2oLbd+gWsOxUAcyioGd/5sPD9TnNBWUoahOu5KaapOxFslcaonDsF7py
 cXNLaMGpb4ePQbPJzZsEfJtmSpVS37ElZts1mmA6md0wbNKK8i1+eoRHwOIbWE6MD5g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="IoCY/MMQ"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=IoCY/MMQ
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE84080865
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:19:52 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a1635f7c89so9075215e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 05:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791980390; x=1792585190;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+qv7iQH1oGXgjdyc8ann0xLPWymHu3TYUtIlxSZ/YMU=;
 b=IoCY/MMQ2u8iJrjvkqEsQl1IhoXdSVWRrSzdTdgXtuLgxURcNc6TIiuoQ9Nvo4PCL3
 Joi5UG+9HPVSgf3TpmPjn0oRyYKfpwqN1vgMKmBWieNFwwedR3hobURx/Vt1ZxjtevCb
 sXWmJ5E9365xi93ajQqZEvmlDUm71xtD0agp4FJ39cQ+qiQNBmVuxeS9fVgqqQAb4TSN
 +0f06SpnZVp+88kYhWX8TGn9/RhAn5NhDRNNXKu/LuXoVxYeeiH07KBRJu6xMitR3tnt
 +DSBECl5j9Qa+xmcb5IiBetP2Sg0o9/3M3LQ+3D3L1bDJni4qXx5O66gnNRpKKHq79kR
 IJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791980390; x=1792585190;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+qv7iQH1oGXgjdyc8ann0xLPWymHu3TYUtIlxSZ/YMU=;
 b=S+PYyF85kmSi4+xlLqswOViCXZkNfP1l+u0XrQOuYNhZ1fszu96DRHgww/nvI5c4sV
 6rLNFPJ4BtVAf2iw5jjNqSVQYkjNBOusg2dE9PtUEcfbE6v4tvyHRPQRZCAsX/1v4s2t
 xjOGpmXtcVNdKSKiQ1NtyvfAz7qXzxn+JSbTI9kgiEeuu3ixBbxwW5BGbCeDFNTohm4c
 5vHjLMGDjZkC1xJH2bs1bnCIeDnpt1eXLZBierwizDl8YcN4vt59pdkK2bHUXZsn2YIP
 P9lhRTai1DQ9fr0ZRfCSYA++6h8mUFUKcGo4KX70Fy2/tn8JM5OGGlnyNvPC0+6BjCPh
 EBKg==
X-Forwarded-Encrypted: i=1;
 AKwUvByL+ILcFX0FV1qm1Pm/1LIfZWoj/wgj9ojES384agUxYK5GrFixcpCbxhbbnR+s6fjgh/YhEas=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLih3oZhYl+Ev0CqbGM8J0rmofmFcV7874yjhIjmzFgdNkUaDef
 mKh1ewMK48n2NKDOoLsBxMuktQ/iFE4tcBBLn1kDF0f2CIw8BmC63eGt2wtNx8Uc0aY=
X-Gm-Gg: AYBFou1o5ISbrDybCWQQYWMPn4Jc+4iNjn3SWrNvKwA0hWUbBBvbYRbt8J05HEJKnL+
 10qXLbo4cgbU7uLHwcAXc8vtY0yQnZxWjZcQqsZlmfT4TeFYqLt/cPf+bQ/CwVue7sm/62hhpGR
 JOXVkhfzUxJrUZl5PspiJMa89XsOvnhHCDF4atJ0f433iTv7LYz1EyTVqMqHuPYwiLOjztxN7cS
 oJdfntgGECGFC/vwO5yFJ3ynWJv+VKNwCakA1h8b2xEygbHmg1i/sFyORAI2sVNTKvDheflpKQM
 +gRGyysAoWitk3FtYXMSL19RvU6AG1Fa37stkXKKf/11G1o6xwmpvPN0LdysaaTRbn3Q4AvBHIG
 ZDE9e6QqE7XB0tZRyu40AvgNkL77lEbdDVXfciSI97X9mSUxRvLzE3sg37O3I7+06VRzeSX17SU
 7rKHxHwny7vjVUEBxim9N8sHjk/afhyqU96PR5gJ5u0xRT5+XSvcwXk6hqqPJhQFgbzwTa+mmkG
 hEcLG7Bm31GTsW5VkUaIHZH39Sx9iVYOJykKL6l2ajeJZ3g3OFdxw==
X-Received: by 2002:a05:600c:8214:b0:4a1:6425:be69 with SMTP id
 5b1f17b1804b1-4a18e4b4db8mr314702105e9.17.1791980390238; 
 Wed, 14 Oct 2026 05:19:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:fdbf:f373:6d5b:93e4?
 ([2a01:e0a:106d:1080:fdbf:f373:6d5b:93e4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18c198134sm446929125e9.15.2026.10.14.05.19.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 05:19:47 -0700 (PDT)
Message-ID: <3e646bf6-dbc3-4bdb-9a06-98e4059f25be@linaro.org>
Date: Wed, 14 Oct 2026 14:19:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 2/6] ufs: surface sense data from ufs_scsi_exec()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: dlechner@baylibre.com, trini@konsulko.com, jens.wiklander@linaro.org,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 bhupesh.linux@gmail.com, n-francis@ti.com, xypron.glpk@gmx.de,
 s-vadapalli@ti.com, michal.simek@amd.com, jbx6244@gmail.com,
 marek.vasut+renesas@mailbox.org, sumit.garg@oss.qualcomm.com,
 jens.wiklander@oss.qualcomm.com, u-boot@lists.u-boot-project.org
References: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
 <20260918200641.2286077-3-jorge.ramirez@oss.qualcomm.com>
 <CAC_iWj+MuqZ1LnPCD0SmK5ATgegWZVix3Uj99NwcqkRsWSVoDg@mail.gmail.com>
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
In-Reply-To: <CAC_iWj+MuqZ1LnPCD0SmK5ATgegWZVix3Uj99NwcqkRsWSVoDg@mail.gmail.com>
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

On 10/2/26 13:16, Ilias Apalodimas wrote:
> Any chance we can get an ACK from UFS maintainers?

I was waiting for the rpmb part to settle down, I'll ack them
so you can pick them.

Neil

> 
> Thanks
> /Ilias
> 
> On Fri, 18 Sept 2026 at 23:06, Jorge Ramirez-Ortiz
> <jorge.ramirez@oss.qualcomm.com> wrote:
>>
>> On a CHECK CONDITION the UFS device returns SCSI sense data inline in the
>> RESPONSE UPIU, but ufs_scsi_exec() discarded it and reported every
>> failure as a bare -EINVAL, leaving callers unable to tell a transient
>> condition such as a power-on UNIT ATTENTION from a hard error.
>>
>> Preserve the sense data and SCSI status in the scsi_cmd. No caller
>> inspects them yet, so behaviour is unchanged.
>>
>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
>> ---
>>   drivers/ufs/ufs-uclass.c | 25 ++++++++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
>> index 21aed9f97bd..3d96a05281c 100644
>> --- a/drivers/ufs/ufs-uclass.c
>> +++ b/drivers/ufs/ufs-uclass.c
>> @@ -1657,6 +1657,22 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
>>          ufshcd_cache_flush(req_desc, sizeof(*req_desc));
>>   }
>>
>> +/*
>> + * On a CHECK CONDITION the sense data is returned inline in the RESPONSE
>> + * UPIU; copy it into the SCSI command so callers can inspect the sense key
>> + * (for example to tell a transient UNIT ATTENTION from a hard error).
>> + */
>> +static void ufs_scsi_copy_sense(struct ufs_hba *hba, struct scsi_cmd *pccb)
>> +{
>> +       u16 len = be16_to_cpu(hba->ucd_rsp_ptr->sr.sense_data_len);
>> +
>> +       if (len > RESPONSE_UPIU_SENSE_DATA_LENGTH)
>> +               len = RESPONSE_UPIU_SENSE_DATA_LENGTH;
>> +
>> +       memcpy(pccb->sense_buf, hba->ucd_rsp_ptr->sr.sense_data, len);
>> +       pccb->sensedatalen = len;
>> +}
>> +
>>   static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
>>   {
>>          struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
>> @@ -1664,6 +1680,9 @@ static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
>>          int ocs, result = 0;
>>          u8 scsi_status;
>>
>> +       pccb->status = 0;
>> +       pccb->sensedatalen = 0;
>> +
>>          ufshcd_prepare_req_desc_hdr(hba, &upiu_flags, pccb->dma_dir);
>>          ufshcd_prepare_utp_scsi_cmd_upiu(hba, pccb, upiu_flags);
>>          prepare_prdt_table(hba, pccb);
>> @@ -1683,8 +1702,12 @@ static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
>>                          result = ufshcd_get_rsp_upiu_result(hba->ucd_rsp_ptr);
>>
>>                          scsi_status = result & MASK_SCSI_STATUS;
>> -                       if (scsi_status)
>> +                       if (scsi_status) {
>> +                               pccb->status = scsi_status;
>> +                               if (scsi_status == S_CHECK_COND)
>> +                                       ufs_scsi_copy_sense(hba, pccb);
>>                                  return -EINVAL;
>> +                       }
>>
>>                          break;
>>                  case UPIU_TRANSACTION_REJECT_UPIU:
>> --
>> 2.54.0
>>

