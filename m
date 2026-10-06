Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B1DCA6001
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 14:33:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12D098087C;
	Tue,  6 Oct 2026 14:33:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FGxj30Ww7hMB; Tue,  6 Oct 2026 14:33:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 51D5F80A5C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791297195;
	b=tNeph9FkXKupkahyhA/03oQFlaipyq16/Z5RDVQ2AW8O8MyTNINxwhdfAdXiOkp/PPUO
	 JEUgLvea5fOgP5AFIGheKpqmVIzJdguMAAbmBNKnCv1Ie0DKO5zhn5InD1aHDcDaD2cCm
	 ZU3FCih5vTOkSH7e0JCGeN/OagUucoUbgNprD7/KuQ3ywcKujte6rHqi54armeMe//WD+
	 YkDhPC7SaOgdNQpULBrL8rv2ch5T/MB5BgtlYXWp8sSIaOvLIOxUzhyNPx0DMjk7Ir0Om
	 y56sl6DDk7FM2ho7hKqJ0cDvKC62//HCEOyZflTh9dxVzD0hh5wd74uL62DqHbTefyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791297195;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=5ZDJkmZ4jECupWD4h2HgpPLvqT6zRPOUQTYkBIYiXAs=;
	b=RK4aCi28kWI60i20mv4lB7skywBmRgQf8t3TCGgW/+B0NRzc4gSNg9Q86cEtVR2wDxyR
	 eVvKkdIuKrr7StkZn6Vk0nBP3gXYvXiRuP1M1Mq/6As4RV5ECTB0Xoa+mD6oPC5ao0Gix
	 EGXyN58D9ejKHL25B+hnBXExX8hpzXZPNWua3Crf9fydmEYx3uUZO/YUyAXmD0gswFMM0
	 9Ti59uHuL7/AwV6SElu9PvYCV/P0v5ucN4K6WbCf9ZBqBKvgaTqXK/dp0frH2PTwWbwFA
	 IE6hnL2odqMQ0LFvdm1BN7znkJeuyItLPEsd6mWZmd3/xJwF364E/0jKO/qwavATTSg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791297195;
	bh=5ZDJkmZ4jECupWD4h2HgpPLvqT6zRPOUQTYkBIYiXAs=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=brwbwuye1WtP39AW4U2GzZcm7HguXtSxGB3fNvt9v9703mf50irPKgxO77MHE8LXu
	 A3zjsYSm1r8xfy/KTmLWIYBJycyh+43MKKnaJV9rCu86QlWK6eC+PA1ELFaYa2tU1c
	 Y+vCzQ0lIFZtYnhW3lXUyYkdVVrpwBHh2K0I/QQ5FxnpRa4XR16RfpmX6qgj3ywEHE
	 j/yBFxjF9W6CJEuRma6yoHWs8db5HlbmXLkoJyW/5LJtWzk6hyBXdmOedLODc4TSTC
	 rbOjV+Zjn3uAPCwMojzO3PpeVC8diQe5FnLyzI4npG04aPv6cx2TyfIlOQNGHfvjCl
	 a7QOszqk7Zz6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51D5F80A5C;
	Tue,  6 Oct 2026 14:33:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 70DE61D2
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 13:31:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6192F607C8
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 13:31:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 32u9DRjkX4OX for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 13:31:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D234E6071A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791293513;
 b=qNdUVtMIfUFZ6GsjFn8hROFr18G0hQdNR18tGYs8WDmO14VudFjuqo0Wk98RUsL+6L/D
 RqZCpP2QKNgTzsmWtjX3RBZmop2C/aAyFPv3NPSKhswugJSjCo6Kl0nRFjHOPrT25VBgv
 6z2QZv25XBbuhIfbZs9383/CGz/O2SzdZpXnGdlQ/MkAvT/xr0MHAkChjR9rv6VPCQgnp
 kA3ABG579F/SnSR6Q2HQYaq6uuEvd6ELlVUwdP6gnP5yfkyVLXtBzd8uap2LOnAHI09Dk
 OTLWKYdz86+xdTCOfXG3mz94JCg+TfCYS7Lje6GH6HpO2mY6UjSDHbgXk8AX5eU6dqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791293513;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:References:
 Content-Language:Autocrypt:Organization:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=5ZDJkmZ4jECupWD4h2HgpPLvqT6zRPOUQTYkBIYiXAs=;
 b=arLEwWvTM/4zsm5/5xgS6kh/39xbI+IimyUB3tP13HPqNF0y+M/mJw1OH9BoeYexD1Hr
 wDdLOmSP4UgZX+LHoJr0b5c2PWloh0UUU10E/Q8lwqNDQXmHJd4B1phzbWAobGXWjHl+a
 uU80ygj7AA/4DuNn3448Jd4Ad8gpbLDov5u3P7EyHqnF/1BrqZVqpJBFkn5H1iqejfcMt
 UzXY0NU/nbNMRSttblZfXbbELwG4VjXG7z2QYLCUah+3nvVmIfeogHmyUDQo2se3EoMhw
 HBS06gEKxbGK96PGifhdwwV0Wff57lvtPTSg1aAK+uC5zBt9isVBCnA/rviPn93o2PQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=WzXMeAcb; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=WzXMeAcb
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D234E6071A
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 13:31:51 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a1682bff3cso15602545e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 06:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791293509; x=1791898309;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5ZDJkmZ4jECupWD4h2HgpPLvqT6zRPOUQTYkBIYiXAs=;
 b=WzXMeAcbpjvG8Bmn1VIJUIXJgeDDR1rdwY8qct3mwrG3kmqtyfKC46lpeC5+Q3Qduy
 /NMbbn8DgZPnoCBDlxik2DWHW0EOyW3h99ftEJaPRqqH86mpYNm9IkEeb1yzdJHqODQJ
 vwmEZUjtMIFXEHMt9QeZofHZRoA6FEROp0azK3h52t1fyqf4WLFZF2Nz3dqudrVM34ka
 4CUVGZaLJXpd/DJD6ioXF6tIx9rH3G2Q5z2V6e1HFtxTtRhKlaDzyIsBv4s4dzOnVLof
 TdoYfS5nyeb6mmD+A+oxFWqezWggJbUi5L7YiQzH6a9sCmEkG5aEdJFmoTQAJG3ELR4+
 r0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791293509; x=1791898309;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5ZDJkmZ4jECupWD4h2HgpPLvqT6zRPOUQTYkBIYiXAs=;
 b=OgNsyZMVW/qj0YxuVpL6x4NLMKobHoiUIYTouYvrnY2q2JJecOSoDU2P1M2GW+SBry
 lzRXGGuAUxdKzagP38oKxR6Aa1Jb8uMnl/bpCjYUv2o4XXnyQgUkJf5ZkO4JmvWhnSk6
 M+cNM82j2fEJCCjERKmObk7Rjk3y4cW7I9hSgD42mUw9mxLrMTuX1YZc3cs+BwaXQh6j
 +U26tSWB3iHQtsmZGEhF6mozMncNKXAX4wi1oMcBw9QyrsVSEi7gFWieizlnr7O9l4U4
 qgZ+xQ3yLLSKJH2IrdKZxFQpGmlg10ktvEL9nllI9u0wbzHOekNlxIGx9yLDs6FCRj8N
 sTBw==
X-Gm-Message-State: AFuF++nlMWlKYxhFmDZyPa7ao3XczykJ2BA4mVUYzWcgl+l8WN2Eg3FF
 SqRgAHawzhfhRjLiWr6XyqokC8MKyBTL9aqDOoF4iA3hGAS68NINDskaXc0psvzFInbUafkEUt8
 lIxMDiRog+w==
X-Gm-Gg: AYBFou2tFeVvgD5IulDWT7374vTcujEHiN4SVUFpkSPRg1bMyOvP3onKda5t6x88+Zc
 CNzKvGayS9s98rBwi95YrZrxXUTAl688A+UESCk7HLyPN+CQCI8yfEQWWZRarKQBTNGJuGZej7n
 zN6GYlYzXsS+SudFert8driddD6GLKlSEEgxLbz0oaDgq66RzLMlOiFC/Cxifz0BTLkBplICrlp
 MTNSTMgo9Fm8bRjRoXe3kX1U6LKdV7+/Sdv6QYRcFZmplgigJtfc2bXU5kcz6gIorj7sps7Wc0O
 IJ89Fmt/cy+USyGEg1JkIHIahwoyFAtU8CyZxv/VSBF+femgVO/v9Rjt4fO8ya4OakJGFza17fa
 v9koLe0jkzSVcHQTEXNtjvO0Tf04Jj5DFXsDLN836FztHsYtGyhiMr4hOsP9F825HPbJZP3CpTt
 6CQToSKjOHzv/Ob+xtygSuQHw2ARobh6QNza8w9/Ts1a9cuVIGd3rTgI4Is8rrmHxDjC/BcUeZI
 VCSl/Lrak3/MoeA4dp8Vd9E4YHvbtzzpKqmT3He+A==
X-Received: by 2002:a05:600c:34cc:b0:4a1:6a10:4dc8 with SMTP id
 5b1f17b1804b1-4a16a10504amr150505395e9.28.1791293509130; 
 Tue, 06 Oct 2026 06:31:49 -0700 (PDT)
Received: from [192.168.151.96] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6228d948sm9758752f8f.23.2026.10.06.06.31.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 06:31:48 -0700 (PDT)
Message-ID: <189b5ad0-6ccb-42b9-a053-244590416407@linaro.org>
Date: Tue, 6 Oct 2026 15:31:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH u-boot 2/8] ufs: add device-quirk infrastructure
To: phodina <petr.hodina@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 David Heidelberg <david@ixit.cz>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Jared McArthur <j-mcarthur@ti.com>,
 Michal Simek <michal.simek@amd.com>, Udit Kumar <u-kumar1@ti.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Alexey Charkov <alchark@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, Bin Meng
 <bmeng.cn@gmail.com>, Marek Vasut <marek.vasut@mailbox.org>,
 David Lechner <dlechner@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Janne Grunau <j@jannau.net>,
 Julien Masson <jmasson@baylibre.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, Petr Pavlata <petr@acrux.cz>
References: <20261004-b4-ufs-sony-v1-0-54e71c95ba62@protonmail.com>
 <20261004-b4-ufs-sony-v1-2-54e71c95ba62@protonmail.com>
 <44f92663-e15c-422e-ab48-eec68904ad49@linaro.org>
 <7rKXOZ-hfdoWG6W8EV0KZMZEQoLnN88eTHGkjZyZp6NZVxWMVMNEzgxIpFVVt3Bhz3udjTeXmGWrrxbUqMlBjUdqrErfKptrs3PmeWl7RAA=@protonmail.com>
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
In-Reply-To: <7rKXOZ-hfdoWG6W8EV0KZMZEQoLnN88eTHGkjZyZp6NZVxWMVMNEzgxIpFVVt3Bhz3udjTeXmGWrrxbUqMlBjUdqrErfKptrs3PmeWl7RAA=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 06 Oct 2026 14:31:44 +0000
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

On 10/6/26 15:23, phodina wrote:
> 
> On Monday, October 5th, 2026 at 11:40 AM, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> Hi,
>>
>> On 10/4/26 21:22, Petr Hodina via B4 Relay wrote:
>>> From: Petr Hodina <petr.hodina@protonmail.com>
>>>
>>> Infrastructure (ufs_quirks.h):
>>>    - struct ufs_dev_quirk plus UFS_FIX()/UFS_FIX_REVISION() helpers.
>>>    - ufshcd_fixup_dev_quirks() applies the table (and sets NO_PURGE for
>>>      devices older than UFS_PURGE_SPEC_VER) from ufs_start(), before power
>>>      mode negotiation so link quirks take effect.
>>>    - hba gains a dev_quirks field, distinct from the host controller
>>>      quirks (hba->quirks).
>>
>> In patch 7 you set the quirk for the Sony Yoshino/Tama platforms, but
>> I'm not sure we need to add the quirk for those UFSs on other platforms.
>>
>> Is this really needed for all platforms ?
> 
> 
> This is more defensive approach to enable it for more platforms.
> 
> The reason is the device is a production unit with secure boot enabled.
> Therefore I'm unable to provision again the device non-volatile storage.
> 
> Also there are no EDL loaders available unlike on some other platforms
> so restoring the device is currently impossible.
> 
> Even with the loader just physically desoldering the UFS BGA chip, then
> replacing it with a new programmed one with the dumped data and soldering
> it to the board it would probably not be possible to boot as the RPMB block
> would be missing the Authentication key only the manufacturer posses.
> 
> I'd assume this issue might be already fixed on newer platforms.
> Would be great to compile a list of the platforms that definitely
> need this fix.

I'm aware of this issue, and I have a Sony sdm845 I'll love to reflash.

So I understand the defensive approach, but I was wondering if this same
change was sent to Linux ? I can't find one.

Neil

> 
> Kind regards
> Petr

