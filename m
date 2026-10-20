Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADF4606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cc8aaHlO;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oyiG8xMh
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D78F94082D;
	Tue, 20 Oct 2026 09:01:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m6qxmxuTv4oW; Tue, 20 Oct 2026 09:01:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CBB144081F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792486889;
	b=eJuPQIBCx9pUpWKjU3eFYe1JY0UIhb4rbFllfnRLk5+gSkQjF3/4H/qs53EFboaPO8Ki
	 lYkn0AxV8orT9PHM8La5Mo6Oogi5Dw1tOT2Iq9ZRATwcj/dtNsp/d4dX5uah8oLVO1ZlO
	 81gUS3ZAYfk1lVU/E3XRPhni8yl52pJTTbQrU/ZvtZULY6Jf12DO8TQ6+wLjDuzdu/I2M
	 V9N+DAK4d88C9A9QxoOCK0xNzghnQfriMJ21QV2OFMLqw1iNw8csMj8GTxsbtduzdZenp
	 eU+R7Z85kosZ5ylP3K3monZuKDermu6Xi72Lh48kv9+IywoIflYElJ/QNZMWn0Pr5TA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792486889;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:References:Content-Language:
	 Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=AlCbr1idVLaLeGwrPNICr/dwSWQie4V+z66lPFg3Nh0=;
	b=omj6oGeoBXwOQbaqGtiyI8ok44hBB7kR53ERP92fwz4kdBLGh6/zEqeTi2Y7T/Xqj2Lk
	 xyaXzoigdDDfj6I1YnEZpU+ttCzNLMPqGRhDWUyd1A4MShvshBzhf7bmq5QkXakOmvdNu
	 6sSoENq4WKebN33F7X3Cfe0tjAi++wNJZWUXVb1NJ64LKKF3uyEXTPjIfVn3o+zbV4iJB
	 5z5C9LiBStjZXZGWjCcC/Sz8Vq/mC07bdd6/MupMBKbd6qf3dLyTvrA1UQlSEudK8pq3p
	 jEcHDgjGOK6TjSPb3kqbLhI4dGMlPtEGoodtxh+CepGPmAyhbZ4pQfu2QyOi4xGi7kg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792486888;
	bh=AlCbr1idVLaLeGwrPNICr/dwSWQie4V+z66lPFg3Nh0=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=cc8aaHlOXgenq5noN99nNaPUsg3qCmsrC6GTorp4VUwedpOuwCpBYkOViRBu5khyR
	 2umrrSVbyWrvd64gPLB6IMnjTuyovaOswUMZn2buz3RooVh4dXnfJXHxm5myChBQw/
	 uNssM1j1QEgr5XxDTJwYtEtL/QJK+0oC/jFoJswkX+p8JLBELkVpfynpcDhRkTB/hA
	 mFlNwks5cYqU6Sx2u2tZF5dvWvgUCMGRx9BYlf83V0d2koEJL+pAx9AW/BG7CfOONb
	 6AFffKVVy7FxBEbJ2gnThMsV7UuOv5Q1TQweEKLZgbDc5tvgQC+rDXUxlp52OJdwD+
	 ExY+BBlbdhIGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBB144081F;
	Tue, 20 Oct 2026 09:01:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D7F0D1E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:01:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BDF5D60856
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:01:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4iEyKdcIkbHE for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 09:01:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8D1F860854
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792486887;
 b=LUlayLcWG+Qy7jL92OAaq4C/2LvzRSueskk5a2EK7wWhTtd2fTmbVC7aw7IUgBnRpJL1
 bXpmWbcNG8/YjXQZBA8WjLQd3321PZ2ArLvZttB0X8gqiwYDcDoQxNt+a0fSoLlnzvSq8
 8MWSfsg0BMtlm6PGRSRfPJn+d4DbZjZTjyXRO805ppbZUHjqBRDD1EHyS/FVFxmmvXg+p
 fEEeRIxjAadQ4AgrPDTcR4lQmRSEI4JRC1Q9pMoXchIN50mA9puiVqORTGbVSlXAtwv0N
 +H7G8MLjqZ2jSzhdW68AMD7iC8fBirDSqm5XXfhaNQ/Dsve4Ulvx3sBDdpqXPGeMkOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792486887;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=AlCbr1idVLaLeGwrPNICr/dwSWQie4V+z66lPFg3Nh0=;
 b=OVq7eUwVVi51fsXYNTjPTp20EKUPXL/Lua8QqSSDWWwG1DEhxH6v8kweHaSkFyI2qb7Q
 kN6TEKrsJvI8wbby9OOoq+35gqY9TQMVp4wq+zhJ47YOUjaJl0VItOFwX6xrP6BXHwJ+R
 VGRFg0eEIDgKnc3C3QvEIgjtHeriIexbSeDYaAI5DOZ15FM74YF0WliRQYJHmIdZHYKJA
 qsa2y9m/4HA4RbeUF7qkopWUsRA9eweXzxvgX4zWfy7hY+vhd4a02/62/4nIt68EC80DF
 L4wrvKxhdavXMv/L1kz/AG05cc5MqI9dVKxnDdx9RLCXP+4KqZhYI0oeoTb1JbMHJwA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=oyiG8xMh; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=oyiG8xMh
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8D1F860854
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:01:26 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso1796053f8f.3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792486884; x=1793091684;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AlCbr1idVLaLeGwrPNICr/dwSWQie4V+z66lPFg3Nh0=;
 b=oyiG8xMhrtCl3nISalc50MIl2gLojCKWSCjmnCKb6gKsUzsfLRKfY5XEA2MPzVdvWx
 qfsvBzmovJhnk1E9GwNWRFj0PFTQtsbehsEMWxSIrVTZbkWSw+ixdoOeO/IPfRgm5AQV
 l0L1rp8aVQimyUnpzhkewb6YGQU4eudNzu7s7hKlxU3T1/wbuLkjxAvN6WJuAU/jGo/r
 LEUvIPF7ue6T1EVMlMjsX38nAdHyMozJXsiZ0YgxKgPbLSqA9Ac8SCksp5rGASqzQZfB
 9+gaVoWG50u0s/N0pEhuPhYEeU4jAW1SUkv8xP61Y0nkL8peFumvnFVq6hsoXc0enNI2
 kvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792486884; x=1793091684;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AlCbr1idVLaLeGwrPNICr/dwSWQie4V+z66lPFg3Nh0=;
 b=ZFOjwUMtEaydRg5fgICljYuzNebG9kmTixiIDfs35S65XWcgszkw2/li2J6NjxtdHJ
 Vw9VGmlHtRKdrU8kqup5cE9exO33oWRWw261vFPEzO6t0xJTIion+yiTzIdfIWI7NBNI
 J0gNxrNHWP3H2SKLNSyYC+t6n/e3WmZtA5PX8TQW1E7VCEsLQdzODtVe6JWT2wxO+HD9
 mII+u9JxoTB1DwEx25HgMFC676QzAQZ4hOIgr9+r8DZI1LYNmimPLDeW5D2ycfBHUHDO
 EIt4iyaQiLSfWSmNs/5vQC1WBXvL5D1xtKaHe9bbs8KBr6WXzEtBzttBLgBT6iXdfsdt
 +o2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPedfx+IJINLEx6V6cj4HtTvg0zKrUdIsqvBXRHUzW4Oyk314w5AsCY7WYEbc/gLq9R+aABH4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJIqKUNsX1+PpMjae1Y/VE2n7FLPNnn9/aieMmihxM0Ou5QC56v
 ITlllecpIgjTXGyLIFGaQFmfGRT/nxCDdM2udyi2oWhtz4R1sOdFACgmrUKXq9Niqsk=
X-Gm-Gg: AYBFou00bjVL9jvAMoD5MgCYKmiu3/fV5UZjNWq5jMm8Q1pbZKBDeBo1KMwxGLiam9/
 4lp4gLrtjDuTO16rsm2FJ9BbMHM+LKoJfPTpbVy+L6W3WyjNCp8tVSFFIJQcCI3+NlE+tdFVB7C
 vuGW4jaFEHBZr1dWF9Sx6TygrYoWiPK4XSK1itPRfOLiuunTx+I+tSWxeyxpN8hDXweI6CJkVW/
 R4bx8R2EEoowvgaMCojlYeivWeJo9rWsYvFeENzxyDvHdYGVdPhqcItF76e7z+GZQQb6+Ikyfu1
 B8FmXWiDwBWJQXsg/ASKFPANp/gWW8jFknGDcux5Mf2kzNfhtYOJnAZCDLJScesXggtt1xpqqb5
 qs7iF2SrUiFepFgN4eENiDtSqPrk/SJNiN6jSG6bhPYFX6ecOcoe7CZksx/V1j5yNxI53dkfusw
 eGwnbIBD7U1HvfRsrWhNGDlgTH/1o52FWv+q+HqUcAd0/+xM0ayKNn5El7tXVL7bFBxySkM1R40
 fDEM7L+IF08FAeUrIMx4twl3CaGQvpN+X3nbUIGtQ/804x8BUPdjg==
X-Received: by 2002:a5d:64c7:0:b0:48e:e2a:4093 with SMTP id
 ffacd0b85a97d-48e0e2a427amr16803383f8f.19.1792486883576; 
 Tue, 20 Oct 2026 02:01:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:e3a1:1a65:a394:be54?
 ([2a01:e0a:106d:1080:e3a1:1a65:a394:be54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d817d69sm4787756f8f.22.2026.10.20.02.01.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 02:01:22 -0700 (PDT)
Message-ID: <d848cc76-3b8f-4ac0-9328-2cab69910a21@linaro.org>
Date: Tue, 20 Oct 2026 11:01:22 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 0/3] mach-snapdragon: Add early EL2 hypervisor switch
 support
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 sumit.garg@kernel.org, quic_varada@quicinc.com, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261013110525.2465737-1-aswin.murugan@oss.qualcomm.com>
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
In-Reply-To: <20261013110525.2465737-1-aswin.murugan@oss.qualcomm.com>
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

On 10/13/26 13:05, Aswin Murugan wrote:
> This series adds support for exiting Gunyah hypervisor and switching to
> EL2 during early boot on Qualcomm Dragonwing family platforms. This
> enables U-Boot to run at EL2, which is required for supporting
> hypervisors that need EL2 privilege level.
> 
> - Adds early boot0.h infrastructure to exit Gunyah via TrustZone SMC
> - Creates a reusable config fragment for easy platform enablement
> - Enables the feature on QCS9100 platform
> 
> Changes in v5:
> - No code changes, rebased onto the latest main branch.
> Link to v4: https://lore.kernel.org/u-boot/20260703172634.140515-1-aswin.murugan@oss.qualcomm.com/
> 
> Changes in v4:
> - Updated Kconfig and gunyah_exit_boot0.h header comments for better clarity on platform support
> - Split config changes into reusable fragment and qcs9100 platform enablement
> Link to v3: https://lore.kernel.org/u-boot/20260515130934.388894-1-aswin.murugan@oss.qualcomm.com/
> 
> Change in v3:
> - Corrected the logic to accurately detect the current Exception Level (EL)
>    and fuction properly when U-Boot enters either EL2 or EL1.
> Link to v2: https://lore.kernel.org/u-boot/20260515065632.90772-1-aswin.murugan@oss.qualcomm.com/
> 
> Change in v2:
> - EL2 switch is made at early stage instead of doing at the very last stage in
>    the previous version
> - This change is based on the patch [1]
> Link to v1: https://lore.kernel.org/u-boot/20260419173829.1074404-1-aswin.murugan@oss.qualcomm.com/
> 
> Aswin Murugan (3):
>    mach-snapdragon: Add early EL2 hypervisor switch support
>    configs: qualcomm: Add Gunyah exit config fragment
>    configs: qcom_qcs9100: Enable Gunyah exit support
> 
>   arch/arm/mach-snapdragon/Kconfig              |  8 +++++
>   arch/arm/mach-snapdragon/include/mach/boot0.h |  2 ++
>   .../include/mach/gunyah_exit_boot0.h          | 36 +++++++++++++++++++
>   board/qualcomm/exit-gunyah.config             |  4 +++
>   configs/qcom_qcs9100_defconfig                |  1 +
>   5 files changed, 51 insertions(+)
>   create mode 100644 arch/arm/mach-snapdragon/include/mach/gunyah_exit_boot0.h
>   create mode 100644 board/qualcomm/exit-gunyah.config
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
