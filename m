Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F21606A331
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BL0Cm8p4;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=D8uyMmow
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7E8B60DD8;
	Thu, 19 Nov 2026 17:45:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mMA8Q5j2qftj; Thu, 19 Nov 2026 17:45:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A46EC606F0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795110324;
	b=o46VgoGgx0QaQC+HCP8et7kA6o0Hh7aj0NlcksWL1wpCo6Hl3F0rPc2wM1mNt9wbpRxx
	 GRmhy9tnUeOnuKHRTAkRFuUTeiVWfG2R9hrVEehf+CQ+i3eL9XqwmY/upQ8UXislpgJX6
	 zTYSrtH5O7aTBOuRmKRwPLrL+IUNPQglzcOh7lf1oYTGSxYl0jkzaiUhc7T+eoCG3xXMZ
	 KhB7A59qtmidzhayl+igIg7q+6Z1yuFXbCAH9M+a7y0NvaRwn7qbhBNLASpzmQvZyIcT2
	 0hcFeyc52flzFh9UhLo4HZM8gh08oZ9nucrTdOGbytY1DtcGxSnOgVauP9+M9EPHgdg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795110324;
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
	bh=RZgSiSQus7qzsNvMWDvrCHhMhA8mpEra5WUvOu0FaDA=;
	b=cvwkTe779jSibW44ib0yCTRwqDVil60sYbXr4iW6ydeM3mlkIMOLLaINRgjVUyjl2B9h
	 vnJyNsEUlJLjPQcJWiXq9NhTPUXU1tRmk7PPrwoSrQ4EfyWuuRJ7j5QWrCoXU/9fVDt5Z
	 PJSzLj/JqhiRZZExUbQmEis32jMRs1VHdBjwT+eRk0qIhXJESE9C8091mof0Da9HuTWeT
	 /j4C1RbGFLulK3y5HvC7wQpcuvzm+u79eiC66ZllMl8+0/JXPrUeHNdRjLikUVPoaK5TQ
	 n82O0S0Lr/1h9SKAiqHx9UJmuJf4ZzK+L8XZDFNeuhvG1B9WrPnlV+ZgKnkAOZmKxRg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795110324;
	bh=RZgSiSQus7qzsNvMWDvrCHhMhA8mpEra5WUvOu0FaDA=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=BL0Cm8p4OtN9JCUMBP7TdjkgT4ZNNEW8eW2B8xDNfm0CLiTiiCMaHFftyd39QJ8+y
	 1g9XdCT0UJ0c/Cxt4NzIGPxrJ3lJa1jKEBj3eapIuGfgM3kcQBrBBQVGQ4kyZbBlsw
	 wgGJFikxolauB46A/A0WtUda7lWlGvRw+n7hx5ty0JTd8nWmHV5KiYzhMmf5/kglOB
	 q8H2mf2wOGtJrcNpAsUDGAiqscSku/vMAlvDnzvczcUrJ5P9wFrBeB557ZIFCTtnms
	 weL/BCRZc55WwRWH4X3SZkTCEuAfW0TYBgIkfw5VT6HhFjwYJ35ugwgASdVCxzDnXV
	 JSSAaViUEFPGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A46EC606F0;
	Thu, 19 Nov 2026 17:45:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BAB82F1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:45:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 58F8640B4F
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:45:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ylr7tdvcxnCy for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 17:45:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0F85D40B22
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=D8uyMmow
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F85D40B22
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:45:21 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso19808285e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795110319; x=1795715119;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RZgSiSQus7qzsNvMWDvrCHhMhA8mpEra5WUvOu0FaDA=;
 b=D8uyMmowmTbRdHqC5IIS4u+fGCdC8p4sbqRqT7iTzyPdgNfarxDyr9uj7Ec6DCMAPc
 JLX6qxJr9BzhgdnFMTq6NqAt+DnPSTt3asNbl/FwkhD/KizjpU6MT+dYPTsYwsK0Mmb4
 hpIlKscmneZkMR/lYawo/ONguEXu92b+9+eTT5cURlYPcSnn/kSH9leJprAXs1Gw03TD
 tDBxuaL23IpVSkm01d3JL3NZzIoQELSm+r29aPQyyLNbdcQrGagFOT37K4Upy1QUkynp
 GIYY5xXZExBIZ+3BOfg8e+3eIFxGZOLr5F42mQUFaG/6J39CnBvD1uRH2wUCw+32BNHo
 umVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795110319; x=1795715119;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RZgSiSQus7qzsNvMWDvrCHhMhA8mpEra5WUvOu0FaDA=;
 b=vcomE0zT/er8sDHU5EcfZYsfTD2d/+fdDEB+WgbRH6tSz5/p2FVkaFD5LEy7B/dU4H
 uu8VR8g4ZFpytx56doYz+SJmJ2rEcGtQ0anMwP+Ei4dbbcCHJ30yqQCb+a48f94/1yY5
 Jzfz7yu1CsBbEXAvQKBmEEP1OT8YYdU7gevEeo5ZPzKFv70Wcr7/Qt1QS6lia+d/I46R
 RH3A3aSXUitIOTqibhbHTEXJTnzsNGdR5waNs9+oIp3Mml7l+p/mDmH0AFIoL9NpWTRz
 lxUoLffeHiLPHEZbPVYcTcn0/ksk/yRs81/ikZ9v/hfTzSIGVZ1uJJJeUNuzxGnmYDJ2
 UIGw==
X-Forwarded-Encrypted: i=1;
 AL+hErGID7XpLQaSEkRVKZtk7L4FlLYpZGWZZXLN9TFI7Q0fK2OcsdmkIil8BCtGbTMdq45fId4m77w=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/rzClI+1xWzMjnaXLauUUMB1Ve7OeteLu8BGd2UNtblOWwmu0m
 8GBvx3lS7hK303AejFX+TOkrNZoU4+odC7yk7wj2XnXuPPZ9IkDSgGwM9yQjrn5xKrY=
X-Gm-Gg: AYBFou2SOfGuyMiogdVoNkj45qRPCd3tuP8YL4q7t275th7EOU25gBmXGliAc/k9/lR
 lXvochL9P1xcmka7gx/5SnN1/MjnQ1O2fpevkDM1Jh4gtvkpK155JVOo27uxn9RKa+ScEaRUMob
 79j557QPHuw2ke9/HYVcHz4nEX0B+366KrM2PLtLPqX23lqqlqMXO0upaBBH+aGcW+/OGM6/gfw
 K+LOpidaMoRHuFX4wU7yI5GFrEC0sAuK8q23++pcUrqEJ/6Z2ikB+n4myOwASM8viy2v9Eztr7k
 AP64g+N093ZzfOA337lqK2AqESFTSCm2q+P41VlPOIxdHLKe4CPMzApo+TySGBRkL4dlg2lfGD5
 qfKaqNWRUDpje8B3ydFX5NRi1jk5vsafWR/TH/HrLuNU438wvwkWXT0UbUWwFt8oECe+uGIBnb8
 bnvsUkJ79QeQkM2NwYubc225jD89OhfY9N3ZL1sJ5adAJhPnOoRBg1dTQ/Gw8CtE0CfUgqcjNOm
 l6BLQHgcLKdoaxZi6vfnaAeFQ2CkyXp8rWdy7xQvUCGYLFpOZVaqZn8c1CRBeNxbGa4Q9MdCKE0
 /iH0pz53f+B+JHdBFQ1DKOPRklxPZMy/ed1VZewaEcSzj0WeFtvGjy7f3aIZbx64smtl8s0+89g
 inqDAMiro
X-Received: by 2002:a05:600c:3b91:b0:4bb:7e4e:de53 with SMTP id
 5b1f17b1804b1-4bb8881059bmr6462765e9.12.1795110319222; 
 Thu, 19 Nov 2026 09:45:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:e468:e6df:6b68:a79b?
 ([2a01:e0a:106d:1080:e468:e6df:6b68:a79b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a3a3dsm13860825e9.10.2026.11.19.09.45.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 09:45:18 -0800 (PST)
Message-ID: <22bed14d-1287-4a11-8dc2-31c0f5cb60e3@linaro.org>
Date: Thu, 19 Nov 2026 18:45:17 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 1/4] ufs: report the active boot logical unit
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Denis Mukhin <dmukhin@ford.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Carlo Caione <ccaione@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20261021-ufs-spl-boot-wlu-v3-0-064e73cd2209@flipper.net>
 <20261021-ufs-spl-boot-wlu-v3-1-064e73cd2209@flipper.net>
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
In-Reply-To: <20261021-ufs-spl-boot-wlu-v3-1-064e73cd2209@flipper.net>
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

On 10/21/26 18:04, Alexey Charkov wrote:
> A UFS device boots from whichever logical unit carries the bBootLunID
> that bBootLunEn selects, and presents it through the boot well known
> logical unit. Resolve the same mapping on the host, so that a loader can
> follow an A/B switch while reading an ordinary logical unit with
> geometry of its own.
> 
> Walk only the units the device can have, as bMaxNumberLU says, so that a
> miss costs a handful of queries rather than one per possible LUN. Pass
> over disabled units, which cannot be booted from even if they carry a
> matching bBootLunID, and units whose descriptor cannot be read, as
> another unit may still be the boot LU.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   drivers/ufs/ufs-uclass.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/ufs/ufs.h        | 39 +++++++++++++++++++++++++++++++++
>   include/ufs.h            | 17 +++++++++++++++
>   3 files changed, 112 insertions(+)
> 
> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> index 2ca4fb2a0209..969bcece5e42 100644
> --- a/drivers/ufs/ufs-uclass.c
> +++ b/drivers/ufs/ufs-uclass.c
> @@ -2296,6 +2296,62 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
>   	return 0;
>   }
>   
> +/*
> + * A query the device rejects fails with its positive query response code
> + * rather than an errno, which a caller expecting either a LUN or a -ve errno
> + * would take for a LUN.
> + */
> +static int ufs_query_errno(int err)
> +{
> +	return err > 0 ? -EIO : err;
> +}
> +
> +int ufs_get_boot_lun(struct udevice *scsi_dev)
> +{
> +	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
> +	int err, i, num_lun, ret = -ENOENT;
> +	u8 max_num_lun = 0, unit[2] = {};
> +	u32 boot_lun_en;
> +
> +	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
> +				      QUERY_ATTR_IDN_BOOT_LU_EN, 0, 0,
> +				      &boot_lun_en);
> +	if (err)
> +		return ufs_query_errno(err);
> +
> +	/* Booting is turned off, so no unit is the boot LU */
> +	if (boot_lun_en == UFS_BOOT_LUN_DISABLED)
> +		return -ENOENT;
> +
> +	err = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_GEOMETRY, 0,
> +				     GEOMETRY_DESC_PARAM_MAX_NUM_LUN,
> +				     &max_num_lun, 1);
> +	if (err)
> +		return ufs_query_errno(err);
> +
> +	num_lun = max_num_lun == UFS_MAX_NUM_LUN_32 ? 32 : 8;
> +
> +	for (i = 0; i < num_lun; i++) {
> +		/* bLUEnable and bBootLunID are adjacent, so read both at once */
> +		err = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_UNIT, i,
> +					     UNIT_DESC_PARAM_LU_ENABLE,
> +					     unit, sizeof(unit));
> +		if (err) {
> +			/* Another unit may still be the boot LU */
> +			ret = ufs_query_errno(err);
> +			continue;
> +		}
> +
> +		if (unit[0] && unit[1] == boot_lun_en)
> +			return i;
> +	}
> +
> +	dev_err(hba->dev, "No enabled logical unit is boot LU %u\n",
> +		boot_lun_en);
> +
> +	return ret;
> +}
> +
>   #if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
>   static int ufs_scsi_buffer_aligned(struct udevice *scsi_dev, struct bounce_buffer *state)
>   {
> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> index 9f55735602b1..6ee83042a645 100644
> --- a/drivers/ufs/ufs.h
> +++ b/drivers/ufs/ufs.h
> @@ -399,6 +399,45 @@ enum device_desc_param {
>   	DEVICE_DESC_PARAM_PRDCT_REV		= 0x2A,
>   };
>   
> +/* Unit descriptor parameters offsets in bytes */
> +enum unit_desc_param {
> +	UNIT_DESC_PARAM_LEN			= 0x0,
> +	UNIT_DESC_PARAM_TYPE			= 0x1,
> +	UNIT_DESC_PARAM_UNIT_INDEX		= 0x2,
> +	UNIT_DESC_PARAM_LU_ENABLE		= 0x3,
> +	UNIT_DESC_PARAM_BOOT_LUN_ID		= 0x4,
> +	UNIT_DESC_PARAM_LU_WR_PROTECT		= 0x5,
> +	UNIT_DESC_PARAM_LU_Q_DEPTH		= 0x6,
> +	UNIT_DESC_PARAM_PSA_SENSITIVE		= 0x7,
> +	UNIT_DESC_PARAM_MEM_TYPE		= 0x8,
> +	UNIT_DESC_PARAM_DATA_RELIABILITY	= 0x9,
> +	UNIT_DESC_PARAM_LOGICAL_BLK_SIZE	= 0xA,
> +	UNIT_DESC_PARAM_LOGICAL_BLK_COUNT	= 0xB,
> +	UNIT_DESC_PARAM_ERASE_BLK_SIZE		= 0x13,
> +	UNIT_DESC_PARAM_PROVISIONING_TYPE	= 0x17,
> +	UNIT_DESC_PARAM_PHY_MEM_RSRC_CNT	= 0x18,
> +	UNIT_DESC_PARAM_CTX_CAPABILITIES	= 0x20,
> +	UNIT_DESC_PARAM_LARGE_UNIT_SIZE_M1	= 0x22,
> +};
> +
> +/* Geometry descriptor parameters offsets in bytes */
> +enum geometry_desc_param {
> +	GEOMETRY_DESC_PARAM_MAX_NUM_LUN		= 0xC,
> +};
> +
> +/* Value of bMaxNumberLU in the geometry descriptor */
> +enum ufs_max_num_lun {
> +	UFS_MAX_NUM_LUN_8			= 0x0,
> +	UFS_MAX_NUM_LUN_32			= 0x1,
> +};
> +
> +/* Value of bBootLunEn, and of bBootLunID in the unit descriptor */
> +enum ufs_boot_lun_id {
> +	UFS_BOOT_LUN_DISABLED			= 0x0,
> +	UFS_BOOT_LUN_A				= 0x1,
> +	UFS_BOOT_LUN_B				= 0x2,
> +};
> +
>   struct ufs_hba;
>   
>   enum {
> diff --git a/include/ufs.h b/include/ufs.h
> index a8b7d370f782..1c307569cdc5 100644
> --- a/include/ufs.h
> +++ b/include/ufs.h
> @@ -20,6 +20,23 @@ int ufs_probe(void);
>    */
>   int ufs_probe_dev(int index);
>   
> +/**
> + * ufs_get_boot_lun() - find the logical unit the device boots from
> + *
> + * The bBootLunEn attribute selects boot LU A or boot LU B, and the device
> + * presents whichever logical unit carries that bBootLunID through its boot
> + * well known logical unit. Resolve the same mapping, so that the caller can
> + * read the active boot LU as an ordinary logical unit.
> + *
> + * @scsi_dev: SCSI device of the UFS host controller
> + *
> + * Return: LUN of the active boot LU, -ENOENT if booting is disabled or no
> + * enabled logical unit carries the selected bBootLunID, -EIO if the device
> + * rejects a query, other -ve on error. A failed read of one unit descriptor
> + * does not stop the search, but is returned if no unit matches.
> + */
> +int ufs_get_boot_lun(struct udevice *scsi_dev);
> +
>   #define UFS_RPMB_CID_SIZE	16
>   #define UFS_RPMB_NUM_REGIONS	4
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
