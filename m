Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B1E606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 09:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YI2n0YMK;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ktcLQgak
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A9E460830;
	Tue, 20 Oct 2026 09:03:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jg5WHyu_Ek9f; Tue, 20 Oct 2026 09:03:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2DF68605DA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792487031;
	b=O0eZeW7uZ0rlpqqWQuXWe3KmyNbMO7eg0IxIkp7eemFe/LS/lVfowS0x5QXZx0dZkOUm
	 IPHW+z6AtM9gAIlOx+drgRi85JTPhC+MoCLwTktfRJzn2D7tV7rJKNC/0qakdOXo6GV7S
	 EytoZBwNHr29x98AcGLBqMom980ApqKRPgejoAgcg3lNNwBNWQ4mCGYPnJhNWoHyGvx7v
	 8cy5Dqko7yJXIcfYdghgCavH4qSq1XdPzhtaiYTmZAETnrPJzhTDwUt7YEatOcVsibHpA
	 H1UZA+KvPzXhtC23MF9fWtZ/8lOylIeJuAuY6I3QxX/xQgMLgMs9qkWJix3dazlH9Rw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792487031;
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
	bh=Qq+UP3tIxbYZu2XNDcXlYp7xSe393KDYCnzGdHWxTEI=;
	b=iw6lD66nT9hKQXj0d6oKUNguh99r1NKQfTl9Q+JHDha2Mvbwwl1ZACJpPLOW5BQ/IMRT
	 3+3upgyyVjoG2aLQVf/VueyIqMzDAd3cJusAQEUQr/ZR8zjHINzoZG6GjsLrENRuRszoh
	 1jCJSzUmGpFgu0hRCytYmKPzhhcyZWSm530KIwm6BIgRO43fC1VCsxRf4+MrG1/NOt/8y
	 nYYlcdXeAfycFpTAZrIePI1E48lkzFHxqDIsNeXeCGdqSmpxOEnee7UCvXud37jCaRNbw
	 yKhmyGhwPW2hJyhwj9UR++7NXXm0YcMNsVidUzb9e34HQsaSDNauY6vg8OpE93iWlXA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792487031;
	bh=Qq+UP3tIxbYZu2XNDcXlYp7xSe393KDYCnzGdHWxTEI=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=YI2n0YMKmbxERG5rB4jKf4XF1ET32jr0eT0Qz6c5QJTHMiwn5aq2w2C0IiUkNDJCn
	 WBUs2AmKR9oH8nl7mmtlole73O2YtqtalQCJ0sl2HpKdRVTKPqlk2W/BLf2ISzyODZ
	 M6kzI1me61mv34D6ojlfKcYKXgO8wcqgr3JrJnPaXNCBU9LlP7KdRW5LrgWpMUH1vp
	 dn0zSg6Srj429kvyHlYoctF7EWHyBbo+qsN4GTmWAnSe4YqB+ffoKpV9dF+lDrEtfH
	 keHv9/c+2Vre2iMu6MiE59Ulk72YDLuGlkp6x14NCbc4Y4AKtRrlczWcHkTXWo2j9v
	 6QbqEajI5Mo/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DF68605DA;
	Tue, 20 Oct 2026 09:03:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BD6291DE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:03:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AF67E40328
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:03:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VKgu5IiadL68 for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 09:03:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6F25D4016F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792487028;
 b=eiHN1B2hzHQth2PfrsS1MB394KTvUT8HDOnx0GzCIddcg60gkGz8o8W1wDKpSZ/NL+Cx
 pyQH8bhqkWngOFuAnU6yPYxaUjgJJgAva0q2BOkJsrm31u4z3JQ4MQY8J1FwA+u0PCSmI
 x46sDruGS+u9QeRFzRKQINUtmuXgHLnnTj3DU1okT1GzNhTLi1004ERC5fOT+tRZWEH6C
 mSzSpuZg4UWO8q3BUF4WQdF35/c2fBBMPoBJpO/kpTkFs/MuNimO3aYbIhID8zMfNrwSP
 5JJEfDIHdYprHJDBfrSTq4d5p89qDTeM0N+/lh1s6jas2mMrVAWzi+4CYXT5vagMOIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792487028;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=Qq+UP3tIxbYZu2XNDcXlYp7xSe393KDYCnzGdHWxTEI=;
 b=thCuJMycn35mh+5+3Q5iOGqfU8MR2Z/eQPcyzFGIz8vfASLObe0e0z9Eo9y5hj+lh/m2
 nP9uL7216qUW611g102/cXwzs1T8eyswY42ln/o4iL25WtzgyXGAdjdE97s5kg1i/QksV
 rlx+qwZG5t2oiHaFnznyFAYI+qqbDhFZW8ih2MQAwMs0868FjVoH3KzAhK9QEhJ+IpHh/
 SQsUnkZkGY9KPV33yZiGIM0zGpI6h36b3JLQDL4FdKjstrNo+ZaOJQpub46PUhm2WVpbO
 jJLQgb+U6zwNWh3e+hyGLB5pc3pNJ9NRsQIR6+Y+W2k004B/75gPl2WSg6XUhIavqWg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ktcLQgak; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ktcLQgak
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F25D4016F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:03:45 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48b060ec084so2064815f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792487023; x=1793091823;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qq+UP3tIxbYZu2XNDcXlYp7xSe393KDYCnzGdHWxTEI=;
 b=ktcLQgakmtshNJc6BEWiXCVmhdBkYT32qNM+DErs6Qc+KhhmQHUVaTInAA0QUxW3KD
 OCkCvf4FPgUWmniAH0sBuGyYwXCSxFLHtdvUEDd1kORH6jRmtXV4Gd/tPpcq4yoPDIJU
 312HwA8jv0TKRZSebTECRWMLE3oGZYpv9M/8gTo3dSb1jtSOlzebrZ7G439Is9Hxk1Fc
 6XEAl1G2w0j02LAhhkIe0ujQPVHOlRCdT181QsmKWCOlqJGyeZMC3cv2vjgygZ14K0mB
 KDI7JW2q4ZAChCTIoSeXD1I9HYh4hmr+SkPJXZKmEQZBA2I8nodlJkKe/0W3530iwRfS
 7zDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792487023; x=1793091823;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qq+UP3tIxbYZu2XNDcXlYp7xSe393KDYCnzGdHWxTEI=;
 b=youvWFMwbgqlCUhZh/vCKZdH6YmnR95oyxXdd8VIHvb5rKiSMpywWrvcDDUcNZ65T9
 guNrk+udFVVJun63ntjjsUkLy1OsS/F513Tv1dGilGi8C4ldDWE/2pY/wxesyIdgfvU5
 Z3AnVjYjXOdOcFRHDXtAsmjMnBq5v39+xcf4w5aBWmQ5Kazd3y39K27oWNXKtPtAFGTK
 4UKK/mugrqn2hkocJBeZcd/MhGKOT/GVhDpLoFkHyTNts26K+0P0KSisG1Y2hv1o+Xxs
 FXCc1CDoSj3Ln6lFMhpY62sCYFQa0zd1MWdgsubDRPbicfqFPDud3/ymK9XGrA7Srj40
 qgig==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8TjZgDc7YxZ5xfvNwPd5vkZ85lE+XWYIS/DBNAtLgIEwTTquQulZEz1uxXyThnhsqYRN4IuM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJi1Q/y4TVR0sF3HpnYiesxGxcVDVp4tOmwEhWiry+Bo7bcNYPC
 hcZoZIaaoWmG2i324pIV+LaDeBnkeMlUrGrGlKGKQsdsmGeSLThKOFKN3sJJoBkls2s=
X-Gm-Gg: AYBFou2LxYOA0IMdIiFLV1nfMnj6kgPM/SLtOaXPiDc6z/YcmwMioTnS0fwAKL/TSB8
 WlLQ4NUdCTXSv1bNEZlONqHJT24cnaSXj2JfRNDbxwGBR66i1JHN2+Tf8lnr/QRdTVOvgPRPxu2
 hTIA+c2c+cECLGFhBRetw5s2voBmW+XEMCOEJX8Bxr4S1Wdc+8qemzdIxMbxade6UFg482a4KUn
 o+c2jRrA+4jBrzJPie112tJbfYiEsEQ9pOCslPYEsyCXIPi2LW1dYt+JgwBUGrpk79DT1T2J6QW
 +xKV+/NDW8Mawi76bLm5Kp0gyIZvoE9aRIto2kjM9qMYwaXvTGhUVjTXTv7ZwRW+8Pa2eLxsQpW
 WD4dkOTudJiKaclJIus2W9TEiZQAH+oPvaS7fNkH8NgZ91V3JRKgC3YF7YJVamm1P2iH8MbFpjq
 R13hvCYOJ0q5Nv2xvEMc2oKoTlD0JK3RjtZjBwJr7K/VPVkPTg5KHfgK/5Q0u1zNHMUSoP1FS4B
 rcLaPJ7evClX6DkKcJ/90bYF5fRDeWA/lM8msO1sH4FprV1i4616w==
X-Received: by 2002:a05:600c:5492:b0:4a1:d992:9476 with SMTP id
 5b1f17b1804b1-4a1d992951cmr207480965e9.23.1792487023391; 
 Tue, 20 Oct 2026 02:03:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:e3a1:1a65:a394:be54?
 ([2a01:e0a:106d:1080:e3a1:1a65:a394:be54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2d699dasm61104385e9.12.2026.10.20.02.03.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 02:03:42 -0700 (PDT)
Message-ID: <3780de1d-4101-4e53-a8f4-702dc72de78d@linaro.org>
Date: Tue, 20 Oct 2026 11:03:42 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/5] i2c: geni: Add 32MHz clock and chip probing support
To: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>,
 trini@konsulko.com, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 casey.connolly@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 hs@nabladev.com, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
References: <20261007174151.2590649-1-gurumoorthy.santhakumar@oss.qualcomm.com>
 <20261007174151.2590649-2-gurumoorthy.santhakumar@oss.qualcomm.com>
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
In-Reply-To: <20261007174151.2590649-2-gurumoorthy.santhakumar@oss.qualcomm.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/7/26 19:41, Gurumoorthy Santhakumar wrote:
> Add support for 32MHz GENI SE clocks through dedicated timing tables
> selected via the qcom,geni-se-clk-32mhz DT property. Also add chip
> probing support.
> 
> Depends on:
> misc: qcom_geni: Add minicore support
> Link: https://lore.kernel.org/u-boot/20261005-spl-v10-1-c4ca29bf27ed@oss.qualcomm.com/
> 
> Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
> ---
>   drivers/i2c/geni_i2c.c | 76 ++++++++++++++++++++++++++++++++++++------
>   1 file changed, 66 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
> index 7498cbcb41a..9edba3dd551 100644
> --- a/drivers/i2c/geni_i2c.c
> +++ b/drivers/i2c/geni_i2c.c
> @@ -96,18 +96,35 @@ struct geni_i2c_priv {
>    * clk_freq_out = t / t_cycle
>    * source_clock = 19.2 MHz
>    */
> -static const struct geni_i2c_clk_fld geni_i2c_clk_map[] = {
> -	{I2C_SPEED_STANDARD_RATE, 7, 10, 11, 26},
> -	{I2C_SPEED_FAST_RATE, 2,  5, 12, 24},
> -	{I2C_SPEED_FAST_PLUS_RATE, 1, 3,  9, 18},
> +static const struct geni_i2c_clk_fld geni_i2c_clk_map_19p2mhz[] = {
> +	{I2C_SPEED_STANDARD_RATE, 7, 10, 12, 26},
> +	{I2C_SPEED_FAST_RATE, 2,  5, 11, 22},
> +	{I2C_SPEED_FAST_PLUS_RATE, 1, 2,  8, 18},
>   };
>   
> -static int geni_i2c_clk_map_idx(struct geni_i2c_priv *geni, unsigned int clk_freq)
> +/* source_clock = 32 MHz */
> +static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
> +	{I2C_SPEED_STANDARD_RATE, 12, 9, 10, 26},
> +	{I2C_SPEED_FAST_RATE, 4,  3, 9, 19},
> +	{I2C_SPEED_FAST_PLUS_RATE, 2, 3, 5, 15},
> +};
> +
> +static int geni_i2c_clk_map_idx(struct geni_i2c_priv *geni,
> +				unsigned int clk_freq, bool use_32mhz)
>   {
> -	const struct geni_i2c_clk_fld *itr = geni_i2c_clk_map;
> +	const struct geni_i2c_clk_fld *itr;
> +	int array_size;
>   	int i;
>   
> -	for (i = 0; i < ARRAY_SIZE(geni_i2c_clk_map); i++, itr++) {
> +	if (use_32mhz) {
> +		itr = geni_i2c_clk_map_32mhz;
> +		array_size = ARRAY_SIZE(geni_i2c_clk_map_32mhz);
> +	} else {
> +		itr = geni_i2c_clk_map_19p2mhz;
> +		array_size = ARRAY_SIZE(geni_i2c_clk_map_19p2mhz);
> +	}
> +
> +	for (i = 0; i < array_size; i++, itr++) {
>   		if (itr->clk_freq_out == clk_freq) {
>   			geni->clk_fld = itr;
>   			return 0;
> @@ -262,6 +279,38 @@ static int geni_i2c_xfer_rx(struct geni_i2c_priv *geni, struct i2c_msg *msg, u32
>   	return geni_i2c_fifo_rx_drain(geni, msg);
>   }
>   
> +/* Probe to see if a chip is present. */
> +static int geni_i2c_probe_chip(struct udevice *dev, uint chip_addr,
> +			       uint chip_flags)
> +{
> +	struct geni_i2c_priv *geni = dev_get_priv(dev);
> +	u32 m_param = (chip_addr << SLV_ADDR_SHFT) & SLV_ADDR_MSK;
> +	u32 status;
> +	ulong start;
> +
> +	(void)chip_flags;
> +
> +	/* Add delay before chip detect to prevent the bus going undefined. */
> +	mdelay(1);
> +
> +	qcom_geni_i2c_conf(geni);
> +	writel(0, geni->base + SE_I2C_TX_TRANS_LEN);
> +	geni_i2c_setup_m_cmd(geni, I2C_ADDR_ONLY, m_param);
> +	writel(1, geni->base + SE_GENI_TX_WATERMARK_REG);
> +
> +	start = get_timer(0);
> +	while (get_timer(start) < I2C_TIMEOUT_MS) {
> +		status = readl(geni->base + SE_GENI_M_IRQ_STATUS);
> +		if (status & M_CMD_DONE_EN) {
> +			writel(status, geni->base + SE_GENI_M_IRQ_CLEAR);
> +			return (status & SE_I2C_ERR) ? -ENODEV : 0;
> +		}
> +		udelay(10);
> +	}
> +
> +	return -ETIMEDOUT;
> +}

This probe_chip callback is unrelated to this change, move it to a separate commit.

Neil

> +
>   static int geni_i2c_xfer(struct udevice *bus, struct i2c_msg msgs[], int num)
>   {
>   	struct geni_i2c_priv *geni = dev_get_priv(bus);
> @@ -468,6 +517,8 @@ static int geni_i2c_probe(struct udevice *dev)
>   	ofnode parent_node = ofnode_get_parent(dev_ofnode(dev));
>   	struct geni_i2c_priv *geni = dev_get_priv(dev);
>   	u32 proto, tx_depth, fifo_disable;
> +	u32 clk_freq;
> +	bool use_32mhz;
>   	int ret;
>   
>   	geni->is_master_hub = dev_get_driver_data(dev) & GENI_I2C_IS_MASTER_HUB;
> @@ -538,19 +589,24 @@ static int geni_i2c_probe(struct udevice *dev)
>   	geni_i2c_config_packing(geni, BITS_PER_BYTE,
>   				PACKING_BYTES_PW, true, true, true);
>   
> -	/* Setup for standard rate */
> -	return geni_i2c_clk_map_idx(geni, I2C_SPEED_STANDARD_RATE);
> +	clk_freq = dev_read_u32_default(dev, "clock-frequency",
> +					I2C_SPEED_STANDARD_RATE);
> +	use_32mhz = dev_read_bool(dev, "qcom,geni-se-clk-32mhz");
> +
> +	return geni_i2c_clk_map_idx(geni, clk_freq, use_32mhz);
>   }
>   
>   static int geni_i2c_set_bus_speed(struct udevice *dev, unsigned int clk_freq)
>   {
>   	struct geni_i2c_priv *geni = dev_get_priv(dev);
> +	bool use_32mhz = dev_read_bool(dev, "qcom,geni-se-clk-32mhz");
>   
> -	return geni_i2c_clk_map_idx(geni, clk_freq);
> +	return geni_i2c_clk_map_idx(geni, clk_freq, use_32mhz);
>   }
>   
>   static const struct dm_i2c_ops geni_i2c_ops = {
>   	.xfer		= geni_i2c_xfer,
> +	.probe_chip	= geni_i2c_probe_chip,
>   	.set_bus_speed	= geni_i2c_set_bus_speed,
>   };
>   

