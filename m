Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB673CA5FF5
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 13:31:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6EECB406C0;
	Mon,  5 Oct 2026 13:31:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fDFczoY_jlKb; Mon,  5 Oct 2026 13:31:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 26B3140666
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791207082;
	b=hXSrfbwGjP8zUJQcetS0+lD+ufIe1+u5VLmOfhxnosHUGwa9eLZeN02kPX7ndGW7KPI/
	 1GGHAXImou8RqfGuMQy9qfxPWgRQ1B5H9yidXyx8zykhXfgjDApA3XYSr0v8+d89PUjsF
	 kOeKshjyAZhTkuiTGk5YAwWspKHyvqVFKyNvZKDKeDyPwyjSUhhVS5ZqmElEvkLghsT0X
	 6t6PHdRC6Yt8j6LWD8D87bR3lqPcuNeKajsSzz18Se6L0FNMYEL3UZO1BMzx86DB4ZXwW
	 oqIu93sf9KAVxX2EJGkP87lRVOovAnlELRisa0/SBLlmfFuZE48+KoOxVC8BRenniHQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791207082;
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
	bh=zP94qRTzg5oDxi7fPTFje05jUbcrO/6ehKUodlF5d64=;
	b=DA/8kVt76cnOzZYRbI3g0Zs+fFaDmfY43dA5J9kVau1et0pHbaaWWwcmxwtiErJvl+PW
	 oR/0UDrmVfhxMcji0cdOMYHrI8Uh5Q/HbZYw9NpES7Vl5uRs3zhFdFaROZafbx+slci/C
	 LuWTzl0dXkyPNvdDnSt4MCWZoOAec3YPZ5pLP+1mUzz/gSRdwOPp2Nn3bG1IgBcQFqpWZ
	 ai2kw4SLUl9fUji65t06Xb8JerQ/pNzdMt1TxYZaPW5cTRyvyLdhZlFh8x7x4lbzhe2gJ
	 SYImajJxZ3Da3hRs5QVKR2HYHw/XeGpViH86XpoKQWSntaODdf8QEdpqWvdNaJ0PMkw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ibCQY7bt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791207082;
	bh=zP94qRTzg5oDxi7fPTFje05jUbcrO/6ehKUodlF5d64=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=iQtTCb/3yviHA/S/9dN3dbJlYiirb+OzW67HBiADOlqED3eOC10BXo38bCuyF9vXE
	 U/hMMhaCXm/vhejZQrezF+o6LVIYWNNhCuUjyVBaHYtQM8XQKrBODLhfAyUZehS5VG
	 PawZITGL+b5Cn2Kfz6FRoFAs0YCVTLu+orXdDcySpXoyK46VMmV7j8a/PobzHOP1eS
	 LVk6Y84xmM1xNYRgVUfR+pAE4CYem7OdawJL3XhWvgqrKSL8ZJJMVyo91H/sP+x2mq
	 h9boKySA0IbCZxSkVg/4RfSSlUBWzTJyHFpaAoSXDAVOgx7UG3hxwlwIZAw+Aw+O4y
	 xENnYKlfjz5nA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26B3140666;
	Mon,  5 Oct 2026 13:31:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C4AE82E0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 09:36:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AA65F40560
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 09:36:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6feq_561OUFg for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 09:36:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 794CB4055C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791192966;
 b=QRbZab5AAY0vdN3jWXetaZ7rF+m5n8dOKliBg14hxOO2/E/vGtq0L6gJGD75JLJg6l65
 b1gz2wCI3/N261OGbOcCqjwebqnAHCud2dEPlNwaLQnniMtPwa51j0MZWjorBad+sE9FJ
 3/3yaLMXCUGNiNJ89vvZeekDw324lA8md6G8q3ulNOwegd5Dmkj4SfNUHYViCVQzaEvar
 2I/gJhfufUfGfw+LTIfTDJvqS5gk5+Cdl9h9SJN6dZDhUNmLFx3h46fl4PGM5cYnMZRZE
 pfaAQH9vjWZJhNQDsyzt959AA3YGlWXYfuNQtf4yB+kA5fcELUkwC1PjJ5tcjVD1YXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791192966;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=zP94qRTzg5oDxi7fPTFje05jUbcrO/6ehKUodlF5d64=;
 b=XZw7AQ0Fk3ScFqfwy8eMsfTvfVHujTmhVIZepUJBCCjTYwHD33RIwCsyGQHMP+7G0zd0
 mPT5NwjaM6F78aLCCSmWG92EWNr2GPLb7DDhdYZzkqgi6vpe+HG/YHxemlH8Ab5RhkEK9
 v4JaNq5NrCj2yC1IwNDbPmD9iBpDb/e+dC73imyCFvNthMoqXoFlmQ9Ny61RcZMAJgZVP
 r91AFpt5a2ZBgfVG8eD92WczqLTihvfoLMnRqomkjzfP+R5rX/z9vpndu4+it0jN61QPj
 AwQXWGBrz9iyLZAGnUv/PrQL8zSqHM7xN35mwkzLcMRqDQut6qDva+laVeM6DzoDK+Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ibCQY7bt; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ibCQY7bt
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 794CB4055C
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 09:36:04 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso16203485e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 02:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791192963; x=1791797763;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zP94qRTzg5oDxi7fPTFje05jUbcrO/6ehKUodlF5d64=;
 b=ibCQY7btqOvBwyC/UdWqaayrIBYdhtr1Sf63PnuanrpaH3Ot7ETdPw3mEFXkxmoLxI
 R/DZbPv3DxohWCVsKGbe3GaV8AfEpU4YUWj+pVpHy2hISzfKAFi7O+222eyU4kNigNju
 OplkBOVOSpIvTlef2SItMhDpHPX7QsjgRgU31Ox0Deh7kyrFru+WiNqL0kGpp6dbgSl/
 w8TfBy6JFyQd2bDDe51qYmaEbUkV/yXSUu4h8WVV5fhPO3xzm/8+1+wcpyVtEtKgVv3+
 XutsAam1tD3avn6vAZicXDIHVr71yZJI8R/4fIcGxyvnp2d2dOwzFAL0rNw2jiP3Tb/D
 dTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791192963; x=1791797763;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zP94qRTzg5oDxi7fPTFje05jUbcrO/6ehKUodlF5d64=;
 b=fVFSKGy5sAjB3ompKSIvYQwrprnL9Gasa3Y2gPfWFQbTx67ow27rEweGPj/qrrMWBt
 eU4wX0fOBCbKg+XQpyE/uJ4+cSt/Cp1lgbtvLM4vI8w7p5tqY5+61rsiIqqC0hxC9pez
 3AngtDVCt+0DX0jpMGSAXL/riN3TKkQ4pgFD4H5RGu1Koh2AfazhAsO8OdHeDbsyzjka
 VySMzDDL7K9FTSuqi7W8MA5SPlHWvfJMHaRbXjF2Iszt1RXrhsPO2+MF3eUEAi6GG8b8
 VM27xzkIQ7lov7hbXgGTa0+cPvsjDnDVQIwOP2NLPtXHph+MX0XpvsJiE5J9U1KtTmeZ
 MIZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByUEXrCU0y/5s5HvcD+n5KN/JYrxk3Yt1SqPkO0a4v7+3KQgYm5d9u9DMI7L9y26nGhjHGqYcw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mOJEQFTigIU4XV3JcmYOOLInq784wY34hdr11tMQh5daJSB/bB
 Sy8YC9OtQnSMFKg6G3AO1gRYPjbTlSYBbSChw338kpdKBj+u30aRjtsle/84WQraDKA=
X-Gm-Gg: AYBFou2X/wdkC4KiS2YXHDekoKAy9miVrJ3zHwZkNvcjq+KEnBxXAimWAv0cJvybl3J
 bfWOtn3CWLOyQmj/X1S8OTptU1eZFVm+RprADBa/bH746ms8EEQF6AG5qi8oj7ckymX4OEzQCQz
 Sdp8HIlGTHqqF7K7JuR8wnfnonNgVQF/AMzHW4IrFvyp+avxIDU5OwZYPvUSuIh2AvN6bsuGQV/
 7rIdGc0yeLgHyCjbhTUeJ6EHVwZE77oHRtgNRfFbTLgbEaqALPEQG+mshPDUYtFs0jcRYjH624Q
 6W5s1An9dNlga/w59lz5aFnVMRy1cOiZoXkO4d7j3jtONXLK4xDJld9mqEF+nM1TYWQ5vmOUG29
 tbvzVvVkqVgBEIFrV+kr0KgxIAc8Dwk9KPq7kwmvzUDEuXz+i1o+BejpgmAdDccFOunFo/0zwjy
 oSgO0bLCmezF8x+I/Ii/pm5v/+Xhs0HHzuESGKw8/rlJIObPkZhZ3FsEOwM5YQ/EvKhZhAWrC4b
 Z6orXO7OJWpAWEnsCAcmmTQWAYXaaXmy2e4u9W0cA==
X-Received: by 2002:a05:600c:3103:b0:4a0:1efa:c746 with SMTP id
 5b1f17b1804b1-4a1680f61damr92207195e9.21.1791192962461; 
 Mon, 05 Oct 2026 02:36:02 -0700 (PDT)
Received: from [192.168.151.46] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c62290381sm2389582f8f.25.2026.10.05.02.36.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 02:36:02 -0700 (PDT)
Message-ID: <3524dbdf-dc86-4312-a57f-7e2f16c87632@linaro.org>
Date: Mon, 5 Oct 2026 11:36:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH u-boot 6/8] ufs: print device information at probe
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
 <20261004-b4-ufs-sony-v1-6-54e71c95ba62@protonmail.com>
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
In-Reply-To: <20261004-b4-ufs-sony-v1-6-54e71c95ba62@protonmail.com>
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
> Dump the key UFS device properties (manufacturer, model, fw revision,
> spec version, negotiated gear/lane/power, and the applied device quirks)
> at the end of ufs_start().

Can you add a Kconfig config to enable this ?

Thanks,
Neil

> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
>   drivers/ufs/ufs-uclass.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
> 
> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> index 7dfba3ac1ac..3cc4fd6bde3 100644
> --- a/drivers/ufs/ufs-uclass.c
> +++ b/drivers/ufs/ufs-uclass.c
> @@ -2218,6 +2218,58 @@ static void ufshcd_def_desc_sizes(struct ufs_hba *hba)
>   	hba->desc_size.hlth_desc = QUERY_DESC_HEALTH_DEF_SIZE;
>   }
>   
> +/* Map a JEDEC UFS manufacturer id to a human-readable vendor name */
> +static const char *ufshcd_vendor_name(u16 mid)
> +{
> +	switch (mid) {
> +	case UFS_VENDOR_TOSHIBA:	return "Toshiba/Kioxia";
> +	case UFS_VENDOR_SAMSUNG:	return "Samsung";
> +	case UFS_VENDOR_SKHYNIX:	return "SK Hynix";
> +	case UFS_VENDOR_MICRON:		return "Micron";
> +	case UFS_VENDOR_WDC:		return "Western Digital";
> +	default:			return NULL;
> +	}
> +}
> +
> +static void ufshcd_rtrim(char *s)
> +{
> +	size_t n = strlen(s);
> +
> +	while (n && s[n - 1] == ' ')
> +		s[--n] = '\0';
> +}
> +
> +static void ufshcd_print_dev_info(struct ufs_hba *hba,
> +				  struct ufs_dev_desc *card)
> +{
> +	const char *vendor = ufshcd_vendor_name(card->wmanufacturerid);
> +
> +	ufshcd_rtrim(card->model);
> +	ufshcd_rtrim(card->revision);
> +
> +	printf("UFS Device Information (%s)\n", hba->dev->name);
> +	if (vendor)
> +		printf("  Manufacturer:    %s (0x%04x)\n", vendor,
> +		       card->wmanufacturerid);
> +	else
> +		printf("  Manufacturer ID: 0x%04x\n", card->wmanufacturerid);
> +	printf("  Model:           %s\n",
> +	       card->model[0] ? card->model : "(unset)");
> +	printf("  Revision:        %s\n",
> +	       card->revision[0] ? card->revision : "(unset)");
> +	printf("  Spec Version:    0x%04x\n", card->wspecversion);
> +	printf("  Gear  - RX: %u, TX: %u\n",
> +	       hba->pwr_info.gear_rx, hba->pwr_info.gear_tx);
> +	printf("  Lane  - RX: %u, TX: %u\n",
> +	       hba->pwr_info.lane_rx, hba->pwr_info.lane_tx);
> +	printf("  Power - RX: %u, TX: %u, HS rate: %u\n",
> +	       hba->pwr_info.pwr_rx, hba->pwr_info.pwr_tx,
> +	       hba->pwr_info.hs_rate);
> +	printf("  Device Quirks:   0x%08x\n", hba->dev_quirks);
> +	printf("  NO_PURGE Quirk:  %s\n",
> +	       (hba->dev_quirks & UFS_DEVICE_QUIRK_NO_PURGE) ? "Yes" : "No");
> +}
> +
>   static int ufs_start(struct ufs_hba *hba)
>   {
>   	struct ufs_dev_desc card = {0};
> @@ -2268,6 +2320,8 @@ static int ufs_start(struct ufs_hba *hba)
>   		ufshcd_print_pwr_info(hba);
>   	}
>   
> +	ufshcd_print_dev_info(hba, &card);
> +
>   	return 0;
>   }
>   
> 

