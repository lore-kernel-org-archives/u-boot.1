Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDB4CA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 13:31:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33BCC4069F;
	Mon,  5 Oct 2026 13:31:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EUQ9rtpNYivo; Mon,  5 Oct 2026 13:31:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 264FF406A0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791207085;
	b=ONdo8gZQnZp1/xgqIm88ul2L1x6g5LimFevUgFYFWoAWqA9suloGFNR9SLyIcOC8Xqjd
	 Rza8kuEKvW1I7hQyJ2sFzDz+soqJi27WM7ExUykGqDum6CxH7Hk1B733+4kCB/9sxD08Q
	 zHwMrljUeqpxsGZY6QOS2/6lhxqsXQL/O7m9IHXZQ9dWfHJdalrv+xiTS+pU8opMuApoD
	 0QhCGV52H4SrE4i4KYFcdyDWvichy6BVrLN+5x53llu4GNbxe3Hu4hPJjMjINbywLtY8r
	 Hrc15Oc2dtdRYAaNapUcK5lokWJdv05oECLw0OCLK/dFHfcel89SzZJCw1TrFKhZiDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791207085;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=dAlf3BnWIahnqpHgHvutfzt937Q3zY9pO+OdLH6qgNc=;
	b=FEJ6mSRgQlt8ghf3nYNV2aFBp9T5ivNEcwqwXlLMFMmSxv1Tna+rUCVDbytOmFeGzUcc
	 6GQ/ujvnMuwLvS3YzFhejgVtlHHnU6Rdlw67sju1/EVpmpS+GAj6J8wxUx5NCoZ5mrCwC
	 Y2JYtiAJiHRaMIHWzlM57UVKrQMpKI8FVZ16hmkLuaD0WBmhcVBu/cqJyaT+qF+dGRXuG
	 6hPQAW8VJBNjaaIahbEBsOZOQgtIMFpMA2vGr5K8QU10Awq7Kdi4VcdZcsKYD106fMfGr
	 Ayw4is+f6fxjr8jDJhFvZq0XpqMi503EFMlNVeqUdQDgYOsWw7x0MDMv/N/sXhyWEqg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791207085;
	bh=dAlf3BnWIahnqpHgHvutfzt937Q3zY9pO+OdLH6qgNc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=YCABKft3zCASxz4yOuMN8Fwo0+hJzW0rQN/APcOFsMQBwPZTh+yvfrIFo1Tsi3Ut+
	 sb81wreJOkfnzbANZCP+P60E458dgCtvd3WlG6/kR4BuycNW+XJpLmMbTVfwEsxwQ4
	 dwn4trqUn9aMrpjr/sJ7vEK1xYQ3o5jzz5HJOWk6OmeoBuAouD+PuieWG3iWL86Zqn
	 MbRiLglxOSRshOE3brkz+oz3TyWpiK337TRKGRVWLIG42fcZ1LwT+R7jIlHPe8gMGt
	 xQ4ZbhXUBq7hzBGsREwAATYWSPEOTqZ0X1B7iKFPcugW4nSY/9iDm8lYzf5TETACgs
	 /tYLgmiWdFVJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 264FF406A0;
	Mon,  5 Oct 2026 13:31:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AFF12E0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 09:40:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5CECC400AA
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 09:40:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gOYT6vG4Do7C for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 09:40:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 23E0D4007E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791193241;
 b=jfcCWoLcQdCmbUwCuAZsFx/hTO23WAsISw7H6ZrA2ifVUyVnrgvqhyRlmD+ryhoEK7Tr
 KcXxahYT3gG+pAQu/UU9qPlIt5Qlvwc+ssWLVHaZRBdQFqtac3HZNfy/6svBH/722e0RK
 UOWMxCq4BblrYVa859aNzkCRmTQMAMnQQ43KRRqQQ2biorYOPJ99DRCDPACpJDpJRpWHF
 qxlSBqon77v0UUGY0pWRU4sV6J+t3+wtl8FX1n0PSVRioNC25CmxHEwhMEUCCh9FJXeVj
 9r9uxk2ZpYf5IbUIKHragRn9GZSX11drCgeSrE6WVrY3S/fnu36NM9Rm+yyUjVYVFcQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791193241;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=dAlf3BnWIahnqpHgHvutfzt937Q3zY9pO+OdLH6qgNc=;
 b=aiZE0huf7qcDpYkaptgnJJhqEZMo60tJMUkAkqle5WnhruS8td4vUpWYW9W9dG3YNOYA
 4hKEg6EO/YnHBM5n/vL7i33YfZBKZJCQIrXmp5ngNc9ZvEU83bzLxJ8nc0vNIHeqhSs7Z
 /aKQqTGwmh4GlzyL1dkaXMwWetgSNPoKfvt9h+SyW0XfMTekLk3Xl4BBNtZkAU2KNPZRI
 DRS4RPU7pLXcJreWlrHiWeh4P6HgUs68eVQ/VLd34JWW9Ja6Gzvd7lquJPwhQUV3fWovV
 RhodBm9B7hJT9tpLjNpImdX3Y/5eLsJAlUpFcmy55LrkigC4GPIukmwpH5lF1CjbSDQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=KZrhevju; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=KZrhevju
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 23E0D4007E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 09:40:40 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d822dso13217985e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 02:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791193238; x=1791798038;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dAlf3BnWIahnqpHgHvutfzt937Q3zY9pO+OdLH6qgNc=;
 b=KZrhevjustsVYPKdd8ybaEMKuBzb7dINAigiiTx4MWrAX2x6OMdShdmqZkt9sYEFf4
 c556ia6UugirTmkR5RWy1rpFeQxpg2u1XFhhAqf56SsipfALF5n+DJj3MfmuSy68IKJp
 yLCuMnU6i8payymFfXQxPIGDvATUQj/gAjFWyXSCrJNfQEkQHsmthyDlI5UjFLUd2Ich
 2WTKHv9h2LAI02toljZbq3hjNSrP8BiZEvqq2nWU4Kkod2usLFlaTGssSre5A3YYJ/ih
 eBhIyZcwHQwBQskf4Y0F18SxsQnzH/ZYpkePJRLedB92ZIQOIhhvK71KtLSG9VDWEZjW
 KUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791193238; x=1791798038;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dAlf3BnWIahnqpHgHvutfzt937Q3zY9pO+OdLH6qgNc=;
 b=Zr0Rb96fCPlI+ODeL/O9g8V5WasKyBZHpmN2+IFuYbglA9HOYiFYCpEGmHdQUI6rUa
 Kn+47QBG83fO4rOAXWt4GdlPk6DpzfvvS9+YOk9sUZjF3S+85jW/RNcAbscgTQssdTYI
 zlthZeWot3Wz6Hq0Ir9YpGSdu4u0zruHt4H/R/2I0ctlz1kJRhNIIMuTYryvkh89JnUZ
 qSMT72rdLyiyg0Y+UxjYdEw+U6JSx3Kfot4DEIDAZWcgLC7YiPv6fkyZa7PmacHgYDFX
 Tl4l3tC044Mk0vZ31WohjFri9lMFT6Ep5CY3+aeooIbW9s66znV9I7HRjXkvSq9cjl5c
 TpFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+k++krKSVwoyERhH3WnMO5NtIH/NS4y6XXpSCbgNmVe2XAZJub09APVxVaPg/VOu0a8bL7HQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ndm8FlShXgzxnli8dSPS43/b/9f69n09CCcKn3Nf2KwCNPZkPv
 lke//oYOMbTQqknTuf6S6FB4NW6YyUfdxAzF9jD0/7WRsrdO0LDuEiaiSxRM4BM/Zss=
X-Gm-Gg: AYBFou3ifbpXc78IUNJn81WPBNrmSjmfQMptiS+E1Bwtlb/Qbyb6RMdAxRl+ZMYw1Vh
 E3wd7Y/VBqxgghPyihfxGUxdRxqecMNi9yPA9smpCjLv99kFb2wAsN5H6abcvvu9zkFEM2RsT3R
 RXTejsk7PhJbQsxsEYSklj25NGerGVCeZCNtOzf8kYPPbiAfJfbSOaywr4jCnkdAyaqXt+ptnge
 lSv0aj1Kw/WIlMon/dUgWgF+b/8Nue5fx2S61X7KKWOEp1rWYx6ynzDlUi0CiFzm/tq17XGQMzE
 RUUv+nqSrh5maf9QQz7QzuQIB08kcQekMvXA7pbZp6xb17YayPQyIyP3vUMu3W/MgQl4k+U+p4i
 C7QK5cQLPY14hMiFXfuR403mq/Seunvo13j8KBZj0dsWC6DlxX87FOWYsNLVWRP7j+wVZNcLhXp
 KpE07kpNbrdYnvuUZyqxUtn+9S+oQS1a03OQdjVGLnG8NzYGvUDtjAs4Yo7LkfvK5Qrfmj7YcnB
 XuorBrUkRNQ3ArGQN7z/S0HMhkIQVq3bQ9yky48sg==
X-Received: by 2002:a05:600c:46d0:b0:49c:fa21:1c84 with SMTP id
 5b1f17b1804b1-4a0275a28d5mr178501935e9.25.1791193238002; 
 Mon, 05 Oct 2026 02:40:38 -0700 (PDT)
Received: from [192.168.151.46] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c62289b62sm2659753f8f.20.2026.10.05.02.40.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 02:40:37 -0700 (PDT)
Message-ID: <44f92663-e15c-422e-ab48-eec68904ad49@linaro.org>
Date: Mon, 5 Oct 2026 11:40:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH u-boot 2/8] ufs: add device-quirk infrastructure
To: petr.hodina@protonmail.com, u-boot@lists.u-boot-project.org,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
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
In-Reply-To: <20261004-b4-ufs-sony-v1-2-54e71c95ba62@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 05 Oct 2026 13:24:22 +0000
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

On 10/4/26 21:22, Petr Hodina via B4 Relay wrote:
> From: Petr Hodina <petr.hodina@protonmail.com>
> 
> Infrastructure (ufs_quirks.h):
>   - struct ufs_dev_quirk plus UFS_FIX()/UFS_FIX_REVISION() helpers.
>   - ufshcd_fixup_dev_quirks() applies the table (and sets NO_PURGE for
>     devices older than UFS_PURGE_SPEC_VER) from ufs_start(), before power
>     mode negotiation so link quirks take effect.
>   - hba gains a dev_quirks field, distinct from the host controller
>     quirks (hba->quirks).

In patch 7 you set the quirk for the Sony Yoshino/Tama platforms, but
I'm not sure we need to add the quirk for those UFSs on other platforms.

Is this really needed for all platforms ?

Neil>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
>   drivers/ufs/ufs-uclass.c | 52 +++++++++++++++++++++++++++++
>   drivers/ufs/ufs.h        |  2 ++
>   drivers/ufs/ufs_quirks.h | 87 ++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 141 insertions(+)
> 
> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> index 56118a0ee46..05b95c510b4 100644
> --- a/drivers/ufs/ufs-uclass.c
> +++ b/drivers/ufs/ufs-uclass.c
> @@ -29,6 +29,7 @@
>   #include <linux/dma-mapping.h>
>   
>   #include "ufs.h"
> +#include "ufs_quirks.h"
>   
>   #define UFSHCD_ENABLE_INTRS	(UTP_TRANSFER_REQ_COMPL |\
>   				 UTP_TASK_REQ_COMPL |\
> @@ -1866,6 +1867,54 @@ out:
>   	return err;
>   }
>   
> +/*
> + * UFS device quirk table. Entries are matched by manufacturer id, model and
> + * fw revision; UFS_ANY_VENDOR / UFS_ANY_MODEL / UFS_ANY_VER act as wildcards.
> + */
> +static const struct ufs_dev_quirk ufs_fixups[] = {
> +	/* Sony Yoshino/Tama: block PURGE/UNMAP to avoid bricking */
> +	UFS_FIX_REVISION(UFS_VENDOR_SKHYNIX, UFS_MODEL_HYNIX_32GB,
> +			 UFS_REVISION_HYNIX, UFS_DEVICE_QUIRK_NO_PURGE),
> +	UFS_FIX_REVISION(UFS_VENDOR_SKHYNIX, UFS_MODEL_HYNIX_64GB,
> +			 UFS_REVISION_HYNIX, UFS_DEVICE_QUIRK_NO_PURGE),
> +	UFS_FIX_REVISION(UFS_VENDOR_SAMSUNG, UFS_MODEL_SAMSUNG_64GB,
> +			 UFS_REVISION_SAMSUNG, UFS_DEVICE_QUIRK_NO_PURGE),
> +	END_FIX
> +};
> +
> +/**
> + * ufshcd_fixup_dev_quirks - apply device-specific quirks
> + *
> + * Sets hba->dev_quirks based on the UFS spec version and the per-device
> + * fixup table above.
> + */
> +static void ufshcd_fixup_dev_quirks(struct ufs_hba *hba,
> +				    struct ufs_dev_desc *dev_desc)
> +{
> +	const struct ufs_dev_quirk *f;
> +
> +	/*
> +	 * Devices implementing an older UFS spec must not be issued PURGE /
> +	 * UNMAP, doing so erases the bootloader on affected platforms.
> +	 */
> +	if (dev_desc->wspecversion < UFS_PURGE_SPEC_VER)
> +		hba->dev_quirks |= UFS_DEVICE_QUIRK_NO_PURGE;
> +
> +	for (f = ufs_fixups; f->quirk; f++) {
> +		if ((f->wmanufacturerid == dev_desc->wmanufacturerid ||
> +		     f->wmanufacturerid == UFS_ANY_VENDOR) &&
> +		    (str_prfx_equal(f->model, dev_desc->model) ||
> +		     !strcmp(f->model, UFS_ANY_MODEL)) &&
> +		    (str_prfx_equal(f->revision, dev_desc->revision) ||
> +		     !strcmp(f->revision, UFS_ANY_VER)))
> +			hba->dev_quirks |= f->quirk;
> +	}
> +
> +	if (hba->dev_quirks)
> +		dev_dbg(hba->dev, "%s: applied device quirks 0x%08x\n",
> +			__func__, hba->dev_quirks);
> +}
> +
>   struct ufs_ref_clk {
>   	unsigned long freq_hz;
>   	enum ufs_ref_clk_freq val;
> @@ -2175,6 +2224,9 @@ static int ufs_start(struct ufs_hba *hba)
>   		return ret;
>   	}
>   
> +	/* Apply device-specific quirks before negotiating the power mode */
> +	ufshcd_fixup_dev_quirks(hba, &card);
> +
>   	ufshcd_set_dev_ref_clk(hba);
>   
>   	if (ufshcd_get_max_pwr_mode(hba)) {
> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> index e3368a516e4..d4bcb7a1773 100644
> --- a/drivers/ufs/ufs.h
> +++ b/drivers/ufs/ufs.h
> @@ -707,6 +707,8 @@ struct ufs_hba {
>   	u32			version;
>   	u32			intr_mask;
>   	enum ufshcd_quirks	quirks;
> +	/* UFS device (not host controller) quirks, see ufs_quirks.h */
> +	u32			dev_quirks;
>   
>   	/* Virtual memory reference */
>   	struct utp_transfer_cmd_desc *ucdl;
> diff --git a/drivers/ufs/ufs_quirks.h b/drivers/ufs/ufs_quirks.h
> new file mode 100644
> index 00000000000..f5aa47722db
> --- /dev/null
> +++ b/drivers/ufs/ufs_quirks.h
> @@ -0,0 +1,87 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * UFS device quirks
> + *
> + * Ported from the Linux kernel (include/ufs/ufs_quirks.h) and the
> + * Sony Yoshino/Tama downstream UFS quirks/hacks.
> + */
> +#ifndef _UFS_QUIRKS_H
> +#define _UFS_QUIRKS_H
> +
> +#include <linux/bitops.h>
> +#include <linux/string.h>
> +
> +/* true if s1 (the fixup pattern) is a prefix of s2 (the device value) */
> +static inline bool str_prfx_equal(const char *s1, const char *s2)
> +{
> +	return strncmp(s1, s2, strlen(s1)) == 0;
> +}
> +
> +#define UFS_ANY_VENDOR		0xFFFF
> +#define UFS_ANY_MODEL		"ANY_MODEL"
> +#define UFS_ANY_VER		"ANY_VER"
> +
> +#define UFS_VENDOR_TOSHIBA	0x198
> +#define UFS_VENDOR_SAMSUNG	0x1CE
> +#define UFS_VENDOR_SKHYNIX	0x1AD
> +#define UFS_VENDOR_MICRON	0x12C
> +#define UFS_VENDOR_WDC		0x145
> +
> +/* UFS Samsung models */
> +#define UFS_MODEL_SAMSUNG_64GB	"KLUDG4U1EA-B0C1"
> +#define UFS_REVISION_SAMSUNG	"0100"
> +
> +/* UFS SK Hynix models */
> +#define UFS_MODEL_HYNIX_32GB	"hB8aL1"
> +#define UFS_MODEL_HYNIX_64GB	"hC8aL1"
> +#define UFS_REVISION_HYNIX	"D001"
> +
> +/*
> + * Devices with a UFS spec version older than this must not be issued PURGE /
> + * UNMAP (secure erase) operations: on the Sony Yoshino/Tama platforms doing so
> + * erases the bootloader and permanently bricks the device.
> + */
> +#define UFS_PURGE_SPEC_VER	0x210
> +
> +/**
> + * struct ufs_dev_quirk - ufs device quirk info
> + * @wmanufacturerid: card details (UFS_ANY_VENDOR matches any vendor)
> + * @model: card model (UFS_ANY_MODEL matches any model)
> + * @revision: card fw revision (UFS_ANY_VER matches any revision)
> + * @quirk: device quirk bitmask
> + */
> +struct ufs_dev_quirk {
> +	u16 wmanufacturerid;
> +	const char *model;
> +	const char *revision;
> +	unsigned int quirk;
> +};
> +
> +/* terminator for the fixup table */
> +#define END_FIX { 0, NULL, NULL, 0 }
> +
> +/* add a quirk for any revision of a specific model */
> +#define UFS_FIX(_vendor, _model, _quirk) {	\
> +	.wmanufacturerid = (_vendor),		\
> +	.model = (_model),			\
> +	.revision = (UFS_ANY_VER),		\
> +	.quirk = (_quirk),			\
> +}
> +
> +/* add a quirk for a specific model and fw revision */
> +#define UFS_FIX_REVISION(_vendor, _model, _revision, _quirk) {	\
> +	.wmanufacturerid = (_vendor),				\
> +	.model = (_model),					\
> +	.revision = (_revision),				\
> +	.quirk = (_quirk),					\
> +}
> +
> +/*
> + * Some Sony UFS devices must not use the PURGE / UNMAP (secure erase)
> + * operation as it would erase the bootloader and permanently brick the
> + * device. This quirk disables PURGE-related functionality for affected
> + * devices.
> + */
> +#define UFS_DEVICE_QUIRK_NO_PURGE		BIT(0)
> +
> +#endif /* _UFS_QUIRKS_H */
> 

