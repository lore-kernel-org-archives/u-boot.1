Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E673606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ia6BwQGc;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gZ5p1BB0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BA18606E8;
	Mon, 16 Nov 2026 10:15:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rKX6gBddmvX7; Mon, 16 Nov 2026 10:15:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1D37560666
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794824127;
	b=JbW4b6tBo9s+WATY5Xvx7tzy+treff8kAhzaRFWLvbLgb2NHmJo4rn7SIdrI6v5VvF56
	 Iv/SxX7cVv7Vor2xqlME7OG7eimARVMWtXtI3zDkOYUikjmNSyVrjLD23CFIpTvh4G+hm
	 iKPIPHmNTJ3oSEKB3KLMLMWD5lp20FLka0bT82ED3AudbYIFCdt1lxXOitQr20Ytczioe
	 aaJZYqTVjDjTtRmsH22DYoaVRuJZNi0RMYyx1+YKFKwh/AyzCvNTHxhZRVDaQGpqAnmqL
	 MNpW8FoYR7/UJ1hf/ODUH1ImNzTtIFpQuiyOFE6vBkC+OSbsvMf5czocWsH6TJ+gQlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794824127;
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
	bh=KgdO6rAA9pcyAC0yng+bvoVOz731ea0ObolFrK+YFH4=;
	b=RY0lHqS6iVPjdVliVzbFCy1zWG3WjV8Qgjqm7AU3FbIUanjcLjTUXOLcIU8Mj6zRmH+y
	 DDD37b20wMRuuC6mfEV3bnIXnHtoHE+Wr1PylKzPnoty3fn3Pd/EOyKsINc/N1aNknYBw
	 l1nrfP9/fJgsmQjQ2IIO0ZN7mZG5LJLdP6BLn8DpIw7XXvz0rKWo4d+6rVY1U74dR5UbY
	 X3H/BENs+zlApDa5vTfYR3StjFYmnf++GCzK+fA9k0QggoLAqB2Gf37OqYeWTLV28waZY
	 6jKSB04L7c0+zx6R3O+hXvtjjNMLPZ/Se3mzEjj2TeFG9XUaJU2MGca8M4VUxUJBdnQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794824127;
	bh=KgdO6rAA9pcyAC0yng+bvoVOz731ea0ObolFrK+YFH4=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ia6BwQGco+3OAa+gLa31kkmKwrw7lkjLhFnhPrTzHGw0OuG7M46yxB3PIq3Lhh2dY
	 T7iu1Jdb4MvaKRRbuQoM7kyx8yU3DlRwYgfBBp5U91/0OHzoMRvOKEv50giyBzu7rH
	 ITyKfXUSEnNDMWkyNsKZ43/T2dsNPjnXI8x1tLXWmb8uO+clVKPVYJXtPcapj1VK4U
	 zD4MIG8ELqOWU7OEh6KmKVqisye+pIXd+q5nCqDeiouiKsFslf9bUSMBncZ2+o4K2+
	 CB+A4LGaPOch2QmBxmlhsDpfK+7brRme2AyqWHMjQrQCeIGT6Y/7G0oTTRpB4omJwL
	 s+tvt/SOnjX5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D37560666;
	Mon, 16 Nov 2026 10:15:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B3A428C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:15:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 20FCD405FB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:15:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xJprmpLyVMK9 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:15:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E5819405DA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=gZ5p1BB0
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E5819405DA
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:15:24 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4bb6886d30aso10269825e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 02:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794824122; x=1795428922;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KgdO6rAA9pcyAC0yng+bvoVOz731ea0ObolFrK+YFH4=;
 b=gZ5p1BB0f93cyrnoruXeyS3Yr3IfLG7qSFeUhY2j8vCcTxHNsO+2DZdMxHZFUKJ3CE
 g8QgJh4lYJ66J3yPhIUeZU74eYTQzb/CGq/xInxMxPkxm973VUEKxmXTNhmO62132FRI
 1Rd/OSezyub4dyOYkyeBYu0eoWV5HsQYpES/gDGh0LaTt7cbSxIxIzqFVH068IaWzpuh
 /tsmaAqgB1eAat8nKPANQYDqFkoWSVugKyeIuFwhWqF2kffeE8Ye3Mduq86z+zvdWiQ4
 xa8OOl6vmoDlPZPlt6VzXwy12rhqPM9JHMqlIIdUfv6XZ/4l56Ws9tBwAf7wouK9jm7P
 49RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794824122; x=1795428922;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KgdO6rAA9pcyAC0yng+bvoVOz731ea0ObolFrK+YFH4=;
 b=C1aQIi4i5tDdK8HtOdxf/zdDVl2J9aNWBpZsBr5tq0LRXe1mej3vx213d0NgEyfIUh
 UB45Kni/THVoI4e6a/p0kp8KRhzcsEk65JAE10ob1ZWNxwH/a7apzWDp/2zt7AlRC40d
 ri/7jUKzOcnm+HPkX3QB3nXgUbainMwI7gXUVs1/IcyKV5xWrMepCx2Bsg3iBGpp3142
 bM2bQ0owgHkOxl3Ew8yEvA0lHkGsk6tfyr8xHInAunhes+Wsfymk8mMqM7x1k4FVupAv
 Zbgl+gUjAF9kN6LQflIjfQkeynvXWJ6BnieyCL7b7eCtbLOfk9ry4/8GS1uKgsOj6c+/
 VxIg==
X-Forwarded-Encrypted: i=1;
 AL+hErED6MtDtGTERcx92M53awrJltiJuARB53ROGB7g1p3/B0e094L9gA+1C/O8gDyoGMidpxf3iP4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8VBgKoShhkxlcN6NNa9lSGrQ2V5Wwe1BdqP8EYuxUIwUQyJhIC
 hbcjveo87kj3ORj9zhfd4gtWRfU4d0fwJ3jJN5cw7bEYg8vPaXeUx1yo4Ivz1sDT+xg=
X-Gm-Gg: AYBFou0x+EkvKj/eI+AEF+awkaXH8CKfSwzuOdiJ+85gKF9TuQEsOSXPBPItOljywJP
 pIe2p8O9tXR46eduDjkv0DQczK5r4rsp7f9Fl3f8NBU4LAIoH2QMUyNye+o7F076rsX826zsh/5
 rmJZlednQty+gCgCGJ4tyL26fDM2PR6tFYg+ZWfvyv4KjrX1UAnvKGzNC/3bwNGng3o8l5li64G
 lMJO///qpF2Z9GYoLnpHIxVcMYapFBu2aXc3vaoKa/2EDZqLTBJh+NZkrO/R+f2hv80bL2GJnPx
 OvjhaKt4wWMUi6KIfFwgwZIC2OAQ+WHCif/Mk0R+y8uYebOkUVEIskV8NidOz17BiQ0naUMUb8e
 xUa2ZMqx10xbEferq1uxOhHaH08W34bOfcjzF0qZUYa6UfkOCQ/ULFYlgwZVFqtWdG3rDF18pgQ
 A5GBjign8crjwkI+HQR3h9Z1mKad2vjck8e82MFm+J0BxIDlJEmdg14qo6wy5nDuJnrdOJSeLZ3
 YOQ7s9TzxDJ0nnRqB16/Rj/zVIaCXaQrI6hj7/94fOhWXqjOZPOaHEu2k1lJ9y3tMQP5Olgv2Ng
 Rs2krHemVC92VaFTIHze9wskivmvmQkgqxrVRuDas4ML/axVDsZRUV6IaK7lqt3H/wXNDmT0C/w
 ZAMY39F0E
X-Received: by 2002:a05:600c:8b81:b0:4bb:5f45:c97f with SMTP id
 5b1f17b1804b1-4bb5f4f93f3mr147628795e9.27.1794824121940; 
 Mon, 16 Nov 2026 02:15:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:575d:8fcf:e30d:5aed?
 ([2a01:e0a:106d:1080:575d:8fcf:e30d:5aed])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55a0ffcdsm253382895e9.0.2026.11.16.02.15.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 02:15:21 -0800 (PST)
Message-ID: <ae3ffaaa-2859-4857-bf16-8fe1072aa7e7@linaro.org>
Date: Mon, 16 Nov 2026 11:15:21 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/3] arm: meson: odroid-c4/hc4: Wake-on-LAN from suspend
To: iav@iav.lv, u-boot-amlogic@groups.io
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261115-b4-meson-scp-wol-v1-0-80c3e9f4deda@iav.lv>
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
In-Reply-To: <20261115-b4-meson-scp-wol-v1-0-80c3e9f4deda@iav.lv>
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

On 11/15/26 04:50, Igor Velkov via B4 Relay wrote:
> The BL301 that Hardkernel builds for ODROID-C4/HC4 wakes the board on
> the Ethernet PHY only after the AP has sent SCPI SET_USR_DATA for client
> 7 with a non-zero value. Neither mainline U-Boot nor Linux sends it, so
> a magic packet does not wake these boards from deep suspend.
> 
> This series sends 0 or 1 from the DTB fixup, following wakeup-source on
> the PHY node of the DTB the OS boots with [1].
> 
> Tested on ODROID-HC4 (U-Boot chainloaded from SPI, BL301 built from
> Hardkernel's odroidg12-v2015.01 with unrelated RTC alarm changes, Linux
> 7.4-rc2): with wakeup-source a magic packet wakes the board from deep
> suspend 3/3; without it the packet does not and the RTC alarm does.
> fdt boardsetup sends the expected value with the property present,
> absent, and with the MAC disabled.
> 
> Client 7 is an extension of this BL301, so the option is enabled per
> board, for C4 and HC4. The N2 BL301 has the same client, but I could
> not test it, nor C4. The G12 device trees have no MHU node, hence a bare
> helper rather than a DM mailbox driver; I can rework it if preferred.
> 
> [1] https://lore.kernel.org/r/20261109-hc4-phy-wakeup-v1-1-d98784ecac88@iav.lv
> 
> Signed-off-by: Igor Velkov <iav@iav.lv>
> ---
> Igor Velkov (3):
>        arm: meson: g12a: send SCPI user data to the SCP firmware
>        board: amlogic: odroid-n2: tell BL301 whether to wake on LAN
>        configs: odroid-c4, odroid-hc4: enable Wake-on-LAN from suspend
> 
>   arch/arm/include/asm/arch-meson/scpi.h | 17 +++++++++++
>   arch/arm/mach-meson/Kconfig            |  9 ++++++
>   arch/arm/mach-meson/Makefile           |  1 +
>   arch/arm/mach-meson/scpi-g12a.c        | 55 ++++++++++++++++++++++++++++++++++
>   board/amlogic/odroid-n2/odroid-n2.c    | 31 +++++++++++++++++++
>   configs/odroid-c4_defconfig            |  1 +
>   configs/odroid-hc4_defconfig           |  1 +
>   doc/board/amlogic/odroid-c4.rst        |  9 ++++++
>   doc/board/amlogic/odroid-hc4.rst       |  9 ++++++
>   9 files changed, 133 insertions(+)
> ---
> base-commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
> change-id: 20261115-b4-meson-scp-wol-a41de6a7e053
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
