Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E38EC79F80
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 08:02:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCC5240B59;
	Fri,  4 Sep 2026 08:02:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CEOhG625Wwsc; Fri,  4 Sep 2026 08:02:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 654B140A54
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788508920;
	b=Qy9C8siBxIUG9R/mcdX4SNqO5cH1tQaopv0Btbr4+6B1Sy4qCeAXROowlN7WwLdQxtlw
	 178/7FzzW16IpaIe2niW/oCSpG6IRFrirfFm657cVxPys1+y5qWnE2g4t2Mi7coebNTRt
	 YVuHem7/N9ikpnFTS0olX7oRbbY1+Uer9XpLkGW16MWMRzrZTVzHsc4ZC7uvuXff06s4t
	 WpsLYjRxq4BIE5wB3gYl8kE+8mgmlcEIc8VP9E0CPEbKjecIHH/xIYir9fbFMCnxua5jq
	 bUf2S1a4qwMEfZVOs2VRHG2qOGcR6aS+3fO+olhSFIsZj8/1sF7ezsbNz8a01pW2zhg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788508920;
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
	bh=h/YMZwgbGNahw/cgN6jHApv9SpDQMWrmVhba03iQBOU=;
	b=kOWbNQ+8dt94JFDBN6AuomEUE357SL2f0vzx5adqlZ2BOlHSxEYYr5hBLGiy10CDJR83
	 Vl2cbrVtDZki39I9XF4V0oAAYyahn8kek0NtGVCqEqFes8H9uESDVADMscM3knzuic3km
	 s8C2OtMTEWwUY9NOJ5ezY61D+fioiGrVqA9qyVTCM/w3yI5i+ruNO/LjobzHAMIBgL+zD
	 XrJeIIIGJ8wBBQbQoh1D1k8AvPW0m9zbh7D1StKA2wyZpCA7J5EeZrG+V2xfG9G4TA9cp
	 u0sSN7J7J/O62La7sff1Po5Hkz2QZHGHvXALWEm7Z4yMaigfEXgDAL6kxmRYoigCb8Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788508920;
	bh=h/YMZwgbGNahw/cgN6jHApv9SpDQMWrmVhba03iQBOU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=zhaPClEPc0N4yN5/cKJHAIJdPvJ+2GFr9nOCPzccQ6vtrkLrm5CnCz1BPXvkb8lwP
	 44bzaXmY9isIj04EutCgCTE5sVTYa6lLsmJMyr6PpyGwWucVxdnFopQK71b5GX1sNW
	 AUjgXqRN3m4pnhLdbhV/y3zZjR+9lFGj9dsSM3WyOzz9ZqvJBBtsooBn9YbYmQvIGj
	 CfvW6ESvXJAChVxxc4q0rrUXJJ0hDWCHCMspdfKUtN2Ep2a+JmP6h8hhxomjtPKMUb
	 Ik2Iv+iaS4A+m+QklQAyhTKIIays1DagP4d6JjLPA377ZXZX3Zj4pe6RYCBqC09MFP
	 I1yxkbPAwkVMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 654B140A54;
	Fri,  4 Sep 2026 08:02:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EC76363
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 452BF4013E
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:01:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YKAdy5P-Fidy for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 08:01:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1B0DC40080
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788508918;
 b=d3/DJnv7Cc46ooKRB3CHdZ/360G05xAgKdSu3dnP3A5PjI1epScQ3UOFDCyJp34vr9m2
 W0PGh1n/Okt+ZXN8UX5Scren/ET2mD7mtHjDnGXdHo0cm4J3CO/ECRQi7dk0SeIOP32Rv
 19FsZuFX7pWHHHCRyt+4zC2lRDLl/AKVK7WJ8htCjOJ+P9eb6wkKeXbwKQtIpvZGr8Be8
 k5xkAvrD0oy8hNVCBTKoRAnn96x8tZoSDKfjY/YUN2vQiuIGELTSWtGdHn2HitQnY4N5k
 lm6tBuXNWd7CHwuuWXzruhM8AwtdDGnDSC3MnZJL7MFeh1cJs1FrDBk58AfxAEVqY5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788508918;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=h/YMZwgbGNahw/cgN6jHApv9SpDQMWrmVhba03iQBOU=;
 b=rak/IxWkaZKdAioyuXJzr4pAJSekiKEa+P6RQoEUL+QoRFa9z4q7CzcXL5adPS2eN5/s
 KH8/OTs8LeMZKr0eyj9RZQCnZM40XJa1HuiAw2ZtXDI4Km3ka/sBE9sbZ1/nGaVUmrCu5
 Malcl4p6L5fF4+U1jsL0CYbrNw53oAtcEJooVAB0mANEl/+TIJps7Zudf2GXQm9rNHIPk
 lV/ox6mB6ZptrhTyQq7JgEf+xjqAba+9iyvYvMNBN1ODXKI27gwQcGAsGM78DtUk2uepG
 Oy5FTkvZT1mvvbAqwb/LQudldu/WYRYWMJufk21W+WPFnpu9rlU3NXEHznDxj36JfnQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=YdCUReeL; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=YdCUReeL
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1B0DC40080
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:01:57 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48436216a98so439515f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 01:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788508916; x=1789113716;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h/YMZwgbGNahw/cgN6jHApv9SpDQMWrmVhba03iQBOU=;
 b=YdCUReeL2eDPonB0Kze+TUw3bEGI1EITd8r7jrAi3PSHfXhwA8eAU11DqbC45ZPh+v
 RiXOIvnPdwdCj6V5+H0AN0QWsBUk0DF7+ea7HZFYA8bq/RVDMIB4tbXQ/M7LkxYtHss4
 Z6HfF1lVl6DyhW3IiN57bNP87Kkd/q07ep+/hU6Lrs2MOx3NT2BQ5wfQEkvKhUV8t7C0
 g42+652rh7demISQoUBrBG/+gOPTPsdD8pEaMqjbHre/DQw2IWytdnpragX13Tf14faK
 Mx/485wrhuRQJZrsYhr/e+c6n1gH0yBXWpXvl7TC9mJ97wJ+1+DGgBGzPq3jnOgc0L10
 84XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788508916; x=1789113716;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=h/YMZwgbGNahw/cgN6jHApv9SpDQMWrmVhba03iQBOU=;
 b=fCoZiaqbOQcPv5W6HUiN4GhOAc5L7P7M7RbN/ee+AlekwlaL3okbcEueldhvSvcZyR
 nCsD0Hi3ljTtT8QqoOWuVvCVUcYphY4UhrrL1rmm89/hO5dEcwhC/hxJzQGXHBYAaiKk
 45/+fp/IK8K/aR2PnMNtydt8xnBMBLI58hfCQuQzsworsyIBCO6hdbR+q3Hm9EILBsUe
 KdHZKWDZHgvi3xrhLjIfRM3ZqwjZ/FeA239aRu+qbUoTgfCCXW+nbug+8orhDjvzJOSu
 rX4TcRiorO/NtQoNa0JdNJYju03GrQSAir7FQgQ7LVHbnWJIjex5Ia0UX5R0RmRPxZGg
 z2Uw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPHBullGBkyfVwZ6gGX0IX8kKUdeO8w1T/bJT3VDpoXG6hmJstITC9w0PgNnTaqi7LVmHKQ6M=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mKzyuABozVqF6XttvvEjAoG+7ZtDGGtqsWcKhptDl9swUFDZr/
 7QTcShJKKXGskHjgcDQwIUrxX1Hy2pm5M7ex03AKvuAlQvigv9gxnCGmm2eFMKZqoTs=
X-Gm-Gg: AYBFou3CLPvZiLKlsoHrlC62b6Xy5djqe8W9w2C27UZzQXrY2xMlePeq5rsqGE1O5GJ
 jEMzUqpgO3ogaA/1oXGM6VSplWHP67z7fsAKUiobJ7PFWk0MABvRq+WdPj8sWdpXnhm7pPZQcg7
 9wOQB7hU5GoC823oil3gJQ8HuCWJhs//YEcuCqsFd1bS3rJek+mxJVCBtQddWZRsEVCIBPKarhT
 1acrS4DZcQMn7oQAYd8gdFV6xW/xMQngJx1LlY+5GKyd6llLrv5nkBiIKM10MoT6cIk5Vk7m8Y3
 NqUuejcgAitCM1cH6qZMwwLMVPyU3P6yxlgp028BoP7xFBsBIjAuP5B653j/B3U95XjsZ64Pkt5
 fvxpl/yK4qgAeaE+TcytpP0egJbhxruqpuFqdGrFowYBQ+imE8X1lj92y28XdLGn2p6EHPlzfKH
 djkdo916xMi9o3OhtNlrdVNldJbdKAQH/546V4OOiD8Av7U9Pwz0eABnYPZjmqDF9C+VBAhfAVy
 e0XmILN/zNTW3lcGms2IRCBVhVulKHOJOID/9pLNTM=
X-Received: by 2002:a05:6000:2311:b0:485:8c17:9769 with SMTP id
 ffacd0b85a97d-4858c17992fmr1378315f8f.43.1788508895514; 
 Fri, 04 Sep 2026 01:01:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:e8f4:b358:2087:5bd3?
 ([2a01:e0a:106d:1080:e8f4:b358:2087:5bd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885b1320sm4656111f8f.27.2026.09.04.01.01.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 01:01:35 -0700 (PDT)
Message-ID: <c850c6d5-2413-4ca6-aca7-28401bdfd18a@linaro.org>
Date: Fri, 4 Sep 2026 10:01:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 01/10] ufs: hand sense data to the SCSI layer
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, David Lechner
 <dlechner@baylibre.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Casey Connolly <casey.connolly@linaro.org>, Johan Jonker <jbx6244@gmail.com>
References: <20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net>
 <20260904-ufs-spl-boot-wlu-v1-1-59aeea16c4de@flipper.net>
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
In-Reply-To: <20260904-ufs-spl-boot-wlu-v1-1-59aeea16c4de@flipper.net>
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

On 9/4/26 09:12, Alexey Charkov wrote:
> A logical unit explains a CHECK CONDITION through its sense data, and

I'm not sure about the "A logical unit explains a CHECK CONDITION through its sense data",
I would say instead "A logical unit exposes a CHECK CONDITION through its sense data".

> without it a caller cannot tell a transient condition from a permanent
> one. struct scsi_cmd has carried a sense buffer all along that no driver
> ever filled, so fill it, and clear the length in scsi_exec() so that one
> command cannot be read as another's sense.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   drivers/scsi/scsi-uclass.c |  3 +++
>   drivers/ufs/ufs-uclass.c   | 23 ++++++++++++++++++++++-
>   2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
> index 39b4c7476d45..54afac6eaf51 100644
> --- a/drivers/scsi/scsi-uclass.c
> +++ b/drivers/scsi/scsi-uclass.c
> @@ -22,6 +22,9 @@ int scsi_exec(struct udevice *dev, struct scsi_cmd *pccb)
>   	if (!ops->exec)
>   		return -ENOSYS;
>   
> +	/* Whatever a previous command left behind is not this command's sense */
> +	pccb->sensedatalen = 0;
> +
>   	return ops->exec(dev, pccb);
>   }
>   
> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> index 6ef01f8e4aa7..acaecfa1e341 100644
> --- a/drivers/ufs/ufs-uclass.c
> +++ b/drivers/ufs/ufs-uclass.c
> @@ -1657,6 +1657,24 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
>   	ufshcd_cache_flush(req_desc, sizeof(*req_desc));
>   }
>   
> +/**
> + * ufshcd_copy_sense_data - hand the response sense data to the SCSI layer
> + *
> + * A logical unit explains a CHECK CONDITION through its sense data, which the
> + * caller needs to tell a transient condition from a permanent one.
> + */
> +static void ufshcd_copy_sense_data(struct ufs_hba *hba, struct scsi_cmd *pccb)
> +{
> +	struct utp_upiu_rsp *rsp = hba->ucd_rsp_ptr;
> +	u16 len = be16_to_cpu(rsp->sr.sense_data_len);
> +
> +	len = min_t(u16, len, RESPONSE_UPIU_SENSE_DATA_LENGTH);
> +	len = min_t(u16, len, sizeof(pccb->sense_buf));
> +
> +	memcpy(pccb->sense_buf, rsp->sr.sense_data, len);
> +	pccb->sensedatalen = len;
> +}
> +
>   static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
>   {
>   	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
> @@ -1683,8 +1701,11 @@ static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
>   			result = ufshcd_get_rsp_upiu_result(hba->ucd_rsp_ptr);
>   
>   			scsi_status = result & MASK_SCSI_STATUS;
> -			if (scsi_status)
> +			if (scsi_status) {
> +				ufshcd_copy_sense_data(hba, pccb);
> +				pccb->status = scsi_status;
>   				return -EINVAL;
> +			}
>   
>   			break;
>   		case UPIU_TRANSACTION_REJECT_UPIU:
> 

