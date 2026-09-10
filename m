Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABEDC79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 12:51:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FFFB40A9A;
	Thu, 10 Sep 2026 12:51:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ai0MKpTaYCy2; Thu, 10 Sep 2026 12:51:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B77DB40A85
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789044661;
	b=Vr0EedCwlbrhL32lvYgf+Vl9I5Wt5mhBGbeeoP2e60XQn8ig9yZBy/dS4rsoyAi/7mQc
	 JQrjc+U3P63B/JpBNMyO5h0xJr8hHRuFJqPsB/wyzARQJmPMoW6uOdrQ5ii2TOzDvS0QR
	 /5Z9W/bZlsqioXQigStVmbA/TGpDiw2PaHUArofhPlt9nFYAbOFD3Hy/wIK/1spy9hiH6
	 9gs9tGcvX67SEmA958vj3l2GdBh6+fOa4QfyeJIX1LH9YCjwdmovNtQjVETkJZGRT9L2m
	 xa/h9uZ8ASFaza1CnEjAGsfJs+HMkaVRqALeTv44PXGzZibJNMoUT6XKhtXgFhm7yIw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789044661;
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
	bh=F7ouTMdPmZ8hd9UFGYyWN70LwxlZQbyrqeVXClcevDs=;
	b=pr6SsIwWhtwsgpuEBg3zfmm8b9+g5oYjnUbtFOYtZjIEVRZXx2Qbi7u1d36sTm1M+FHW
	 +BX75u+qYTxZwi1/21gYEcVL25fwYbGvp8rq/es8Jzowm1VGGwDGFAHS3eWpGRDfZidfO
	 ggDkUBpBbSiqQEbCmCuIcxrrYcSyw8W887K+VG2bxJE8XtNfHXHqjVmEnU9MicPT9iYSn
	 qdC9RM78Pb0WIjGMOmhb30UpXS652LzZKVyxzBDY1vxgP+ez46E2ONLkUUA0pA0YpJKFy
	 O3Q+lfD1INzcxhGNIywMgC22KNyRI7JxBSvt60NBHpGJ8PasHdpSE9jgE7YYK/Hj21A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789044661;
	bh=F7ouTMdPmZ8hd9UFGYyWN70LwxlZQbyrqeVXClcevDs=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=WX/z7R6/sttKO3D7nxNxUnt1L6YhCuWdFkPaG20LiHn6NRbyQ3TqvdqC5PP5XrlSQ
	 b32PN8LmdHxvTo/Vbq0MGSuN5Y2k/BHH46+PA5uQu5Eps5jAP2iIVZpTYDMDSpWjx5
	 PKQDDwR3Bn0Z1784kaqcc7trijWFUAgQbw+6UhEPFMgHtpQ6EiwBQd54yLK+sSRiTP
	 DLAYFsmKyU/xZBNqoxIg0hcqTyG1MNsQk0iNBbQXOSaiK738aYnHTWFwOOqUzkadzY
	 N6tY9Rb/TGH3nzbYBFZEObKm3wjeiBRM8Psj2auboxiWlgR22IzeYZI5byVvdMAHJJ
	 rhN67lEEavALw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B77DB40A85;
	Thu, 10 Sep 2026 12:51:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 24702268
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:51:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 09F7F60874
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:51:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sJ2V_n46Y6sm for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 12:50:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 038CD60608
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789044659;
 b=odmUqZ94wDLJe3cTzYGwdON9YfexhqpLRPwv3up67D8N13l5OUri3MgzUlQ4hfiNZOZz
 o4uqMV0YBjD4ipacRXIwcEzyYRZnXppiRxd2w1UqpYr/6RY3kmDNbA7g8HUItWBKF+gbx
 0jFU2b/Z8NbYGwBs3q6cEoHTWsFAOvB+wqqFLnrh6rvJ9PbPeThMCEX2pVrorILV9NKhR
 4bULnCSzl8m8NwGzJYzb6m7ujEIHbPVJ2yJuNVmKEDoMfziucbuTzBbvJr5mOSi1PC6DR
 KE2o+6dec7BtoB1HC/7AmKamRldvKRiz4K/r6WV63s97g6pvMx3oKuqYqv6NCrWrybQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789044659;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=F7ouTMdPmZ8hd9UFGYyWN70LwxlZQbyrqeVXClcevDs=;
 b=Z7+gxyE2TyzlyonjxYeIA/pTxR2iDqGXzZtfKXAZuamNDA2m4IsAOkYFlwBfCWiY8NnF
 6/kkBg490rDooBjyMFuCnCZBzah0t6qsqCfe4S1zs0ck90L70j4dnVDMRUgDU/91MI8hn
 ImAEs23Rsrb4TjHFDPh5gUr8t3CKEhj3pJWmQE1n7kuk6boumIdcv+OWRrDD9FWZ9cIWE
 QWgs/mwkFSUhQCXpdbsnwOnnHJHCsVQyft/iO0qql/fyc0ptC2UbOJB2uX6UffF5tAgIs
 aKY+wr/WClgCv7PAEd8CcEByIXcKjbHvXtIdBCf+WTLmysw12Q5yzrr0olnniTuvUyg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="mfFjPot/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=mfFjPot/
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 038CD60608
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:50:58 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-482f2ee53e7so5116974f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 05:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789044656; x=1789649456;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F7ouTMdPmZ8hd9UFGYyWN70LwxlZQbyrqeVXClcevDs=;
 b=mfFjPot/XQnwx/LncDfO+P6hWdqogdDMsIFesfDXljHG/MLucIYs2fMj0NGZ40YbRt
 Tresc/OnMyc5FjfGn6kN61YauwRVpZniXj2V4wzDj9cbAxx6utqq7IM4VR9ekdS6yyWZ
 Ad9AQWkSNBqsE/Q6SOgROXY5guJ0yIEbsi33K9uEf4M92by7uS4zToYSxU7s1z8yuY0I
 9UyLlKRQ8ufwe9KFv7ulIhODNzcBsaG2AS8l5sNQO6vsg1WQclVi0G7Gp6dW7w4mijho
 nuoGbjYOqgz8RE7y5bpLQz9Z9Gfmc0r8a6UhHGl7jnILPxqolCNtdrpT9wf09LA1hM0X
 TVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789044656; x=1789649456;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=F7ouTMdPmZ8hd9UFGYyWN70LwxlZQbyrqeVXClcevDs=;
 b=Tlw5NRYc/eNcGwwJUfCzT4jSLQ49Yws7s95tlSGjbddVRxw4BLkmPwr+6s1RpAlIgf
 GsXzVSQUEsD0TSe9mTNnTr2XrOc9OPgpruTh4IoAKJ+ZsmKtMCWo3tUBJQ+PTwKWjxuZ
 3AHY4TWBSJ9C9VhIvtgsZXU7eJYtNfZvVTEaV6Tqkhdg+zIncktKr/N7gdKx65WZVEHK
 MRHP50iF33/pz4jb4ytdRFZhAgFcrngFWSauLwHz/mJ0zTtPLA04NGY6LkkxcZCAsBwq
 MW7wUjY2L/v/Z/sCKtiU4a4LJ/EyNmM1Y1wdap5b9D0+2piDPKihr8f9ea7ZdtHCyyja
 NjnA==
X-Forwarded-Encrypted: i=1;
 AKwUvByk/wYLOPY7JwV87mawnnS1aKYE8tkH3xdO9qVimD/1GX2x/UQccEe97nYlgB8pKPY6GPr4kyk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mKTQzqXR/kcU9tUXfaHkbzGyCMfjKCo8aJJvaGQi5Iu2iYjxtP
 ij6OmzQeRf5HzkyBZ6f6TZNGxHej/zn8Zrd+bNuRCy7SPCHaITbMzblpMCngTMFybuM=
X-Gm-Gg: AYBFou07siT8mXWvcaovAyaHSc4e6yKInI/TjeX0sCjUuMfP5Bvtmm56YMc6Ro6Moj5
 cKFTDS7es+9/96o+mx/1YfxedRszSARwR10d0DCKXXnsfIgnTLGM4JHCREnPyUGcGOZ4AEYcSg1
 l5KUTkgNHnAfK2/TmBiz51+/1KHr8Mbrf3uhPbyLYgBBj8FP7puQITq8QGTGmc9/lGQLg0qw3Fl
 Yp8bVCG06qon77th7xEoDKuYRMf3XDz5WfeXt7MtfEjfbOlNvLSdgiNMaC4XyWLRkGoyszVvQNW
 iUI8amUN3sYnztIqUspfg3S4BlmFumP5ffzmICUCylGbMjy7wDeIyJn3DauxsZwzm+KAVs/ZBgK
 TqB3vQ/DwbZsbabpT/RzR4GwbV2jPcG2EitSJsLt5mG5dY8XNVTpin90fRdGoMdgl2vD+RMtb9a
 uHHc3q1jLfmcX2ii2/q+QWcjVUjpEdsLtIHq0VywdXtP8bJbYfCmhzHJYLTPrVJjNY8T0M1IyPr
 y4/1BVcGp3rcVSgNrNU8WdU2a92oK29UhlAPWQCzr4gAXnv7lXy+Q==
X-Received: by 2002:a05:6000:25fc:b0:47f:e886:6dff with SMTP id
 ffacd0b85a97d-48587087196mr43966709f8f.4.1789044656254; 
 Thu, 10 Sep 2026 05:50:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:edd1:1b07:ea07:35f2?
 ([2a01:e0a:106d:1080:edd1:1b07:ea07:35f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858e239862sm45517857f8f.9.2026.09.10.05.50.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 05:50:55 -0700 (PDT)
Message-ID: <ee1107a5-700c-4479-bb4c-0fc0d56b4f3a@linaro.org>
Date: Thu, 10 Sep 2026 14:50:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/3] pci: pcie-rcar-gen4: Avoid repeated link attempts
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20260809013431.444164-1-marek.vasut+renesas@mailbox.org>
 <20260809013431.444164-2-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20260809013431.444164-2-marek.vasut+renesas@mailbox.org>
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

On 8/9/26 03:32, Marek Vasut via U-Boot wrote:
> Avoid repeated link attempts for these controllers. In case the
> controller link is up, this is a noop since the probe() already
> finished. In case the controller link is down, a repeated link
> up attempt seems to require reset of both PCIe controllers, which
> is not desired. It is also unlikely that a repeated link attempt
> would bring the link up, as U-Boot does not support hotplug anyway.
> Therefore, prevent repeated link attempts.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   drivers/pci/pci-rcar-gen4.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/pci-rcar-gen4.c b/drivers/pci/pci-rcar-gen4.c
> index 34561406641..044bceee6c7 100644
> --- a/drivers/pci/pci-rcar-gen4.c
> +++ b/drivers/pci/pci-rcar-gen4.c
> @@ -112,6 +112,15 @@ struct rcar_gen4_pcie {
>   	size_t			firmware_size;
>   };
>   
> +/**
> + * struct rcar_gen4_pcie_plat - Renesas R-Car Gen4 DW PCIe controller platform data
> + *
> + * @probed: Controller was started

This commit is not sufficient, please explain that only a single probe off
all compatible controllers on the system can only be done once due to complex
reset reasons.

> + */
> +struct rcar_gen4_pcie_plat {
> +	bool			probed;
> +};
> +
>   /* Common */
>   static bool rcar_gen4_pcie_link_up(struct rcar_gen4_pcie *rcar)
>   {
> @@ -404,10 +413,14 @@ static int rcar_gen4_pcie_load_firmware(struct rcar_gen4_pcie *rcar)
>   static int rcar_gen4_pcie_probe(struct udevice *dev)
>   {
>   	struct rcar_gen4_pcie *rcar = dev_get_priv(dev);
> +	struct rcar_gen4_pcie_plat *plat = dev_get_plat(dev);
>   	struct udevice *ctlr = pci_get_controller(dev);
>   	struct pci_controller *hose = dev_get_uclass_priv(ctlr);
>   	int ret;
>   
> +	if (plat->probed)
> +		return -ENODEV;
> +
>   	ret = rcar_gen4_pcie_load_firmware(rcar);
>   	if (ret)
>   		return ret;
> @@ -447,6 +460,7 @@ static int rcar_gen4_pcie_probe(struct udevice *dev)
>   	dw_pcie_link_set_max_link_width(&rcar->dw, rcar->num_lanes);
>   
>   	ret = rcar_gen4_pcie_start_link(rcar);
> +	plat->probed = true;
>   	if (ret)
>   		return ret;
>   
> @@ -569,5 +583,6 @@ U_BOOT_DRIVER(rcar_gen4_pcie) = {
>   	.probe		= rcar_gen4_pcie_probe,
>   	.remove		= rcar_gen4_pcie_remove,
>   	.priv_auto	= sizeof(struct rcar_gen4_pcie),
> +	.plat_auto	= sizeof(struct rcar_gen4_pcie_plat),
>   	.flags		= DM_FLAG_ACTIVE_DMA,
>   };

