Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660AACA5FF5
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 13:31:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10EDB4070B;
	Mon,  5 Oct 2026 13:31:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wl114p6ybAGu; Mon,  5 Oct 2026 13:31:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7BDD7406AB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791207086;
	b=KlSB5fA1VED5dsjwntGmGUBHLo77KQHcLgZXe3fN9M5pPllVetMHGnkNZ4ttu/sAFLK5
	 PChWRZQ/HpdvX1UYsYaWEqAQD6PgZjKKQb+QAPZjhxDH9oqcNp/wTKIX8lxaExOIQuSlo
	 auCiHT6rXJo9ES9ae5sKFdME1jPmwuVt76DKBpDs7/XgxtlpM0U70kS5NEoE1cYDhRB8A
	 RkudqySYQ+v449EbexahGRuzBa/FKtSEEd8B0MiSGiw/jG5/7nIjCwZ4Y9vLj/RgJP/2f
	 P7RIL7NMm8dbo0sOYGUBiKiIpoP+BK74mBY/P/yG4q0CgoJsblM2BNUuXPaD7Fa50Eg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791207086;
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
	bh=t542/I6qZOjgKvj0+jefBsf4cZa1/SsRnAE3FiJuO68=;
	b=aL3YwIcO6aWhVyx7q10GwWeoISzwnVWzBzhsnwG265A+8P/WRyAnZzhw15jIpkPgWvUs
	 3m0LD/3RT2K5YUt9eIiAy+cUQqnbvpoq6J4Fv8cUsBdYM3HdNNFZbZlcfyYHl20BmZANg
	 uvYoeHpJhPU4yRVEZ938JjuITAhM3CX0aQYjjoSFdLSrzIJOgInsaPZVR+6BRlUKGTvEF
	 sPVDwGtCcwYe/uJlBn+udSW4kHdyL5Apxb2oVT7rjdbbfLzwwNGsDEy/ETbd0T/8oooEn
	 kJcIX6tvcLneq5SKwVRzkXbancHV48Inx8CBiU/Zl4Qyx6hGEHuIhXrR/9qV2CwTgyw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791207086;
	bh=t542/I6qZOjgKvj0+jefBsf4cZa1/SsRnAE3FiJuO68=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=RNBpji4pn0riW5lySnnPG2EUzc4mEYHzFaoog/wHOGgQbtl1oICs26HZl2A4oJ9bc
	 VahWI2QtoKPOl89MDq5MTdX8UGAyjbseM3+b9k0aFNW0/Gg+Do9aHMLWChN8g/oSGY
	 G23FuLJ6d4hZ+acFp3Th3Hhju/ChN8fMPtKxtWE1+YRy8JoEFliammp3hKCETQ2W+P
	 w3dx5U5/aamoSO65mIgYR0sILt1kVH6xBorb1cSup0K4/9x8Yx7hgl3CYE82glh24O
	 TANSvsHEMc9y+AfRdq3Jt/rClwnHszcFL3jR+trg/KN7m9uj4leVOf2UFsCz9ARWEj
	 15VVDXTOz3E0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BDD7406AB;
	Mon,  5 Oct 2026 13:31:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DA7C2E0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 09:41:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 531CA400AA
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 09:41:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m2MTrZdhPG_Y for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 09:41:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 46F084007E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791193309;
 b=gixs4IfxNOIzOBVnkWZQU54J190dlFqcS3YxUYaCRjCrRpbE9h4fwq5CMcfOpLZOgQEE
 2v8GzK0XhBGz4d9a+S/t1INEovo2TMV+Wibk+8x2ablfpJ7RyOYR5ucJ9ubDhWsLzB84r
 /nLrwwoMPmLE5PU6VeA77/+7iBNKpC5lpodqW6XIzj9zYjZdS89WxagTboM0/H34bvjUY
 Yc7Z3UkAkOj+OF9jYRoj22752ku8tckJ5hLR5myZB+mF4+4HIVciJTAzvMAtYJT8mUuJV
 zMBJi5URbmR+0JXGqpB/awDjLZWcQqDnpYn+7Xm6KhjXOVpudJ37d34tXv4rkSRboAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791193309;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=t542/I6qZOjgKvj0+jefBsf4cZa1/SsRnAE3FiJuO68=;
 b=YPbXn5yHs4jv6gsJaEXiOasj0Ap6dLmGS4/BFGB7vNc+1+9x29ez37vfNuI1nR6LEC0p
 b0oECKpOfGNlXf/pyXsS+E/3cATeUernnn9OLbqn8ERDwIuI4/XoDCqapV4b66GjaI47S
 tgzw8DBmWqRqsydlvLhr+h93ZvDpO95nyKOv4vWQfH60PAOu4TRNTzszz0OtSeHwPUVU4
 5Oacran1GFxPkYlbgAHdy+Xdr3PqEAnLhx5GdKc1SRQ3Rf8dg5LD2EvJkEZu/9j3uCBPX
 IqjcxHODrG7E26Fd6YaQHSgOmxbzYF+iZ140YBgfCQcV/AZqfaA7I/6XiFjX7RikdpA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=C7561fUE; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::e;
 helo=mail-wr2-x0e.google.com; envelope-from=neil.armstrong@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=C7561fUE
Received: from mail-wr2-x0e.google.com (mail-wr2-x0e.google.com
 [IPv6:2a00:1450:4864:30::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 46F084007E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 09:41:48 +0000 (UTC)
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48af5ae31d8so1160351f8f.2
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 02:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791193306; x=1791798106;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t542/I6qZOjgKvj0+jefBsf4cZa1/SsRnAE3FiJuO68=;
 b=C7561fUEI2JR7ztUJCvn+Fxfpl9fjLChdlrbxE0myArdDoHpr66pinMLvkeFDgcFhV
 IT+1TfspApVObYBQupu3RVVwFx4C8bHiUvouhJ1sB/fQDxNdssBchoD2kzKQU5F8GfNi
 6UfaWMGn/wtchD6p72x0wurCfhY8fy/LlSJ1+SOwSZ34GwEXI2jbekFt+qF3LIdjkkjN
 7HwdLzEIe35hVXUcRNY5IVNVNCxnT57Rr2jG4qllrpliWO31ymCjTf71yky5wsmhyxMG
 GT7GH2YAVdx7164iqgwSYczAAcqh+YRgYQqbRltd7Yv+YkRpMdmZfYCY3SEqA2/zC0pZ
 DMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791193306; x=1791798106;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t542/I6qZOjgKvj0+jefBsf4cZa1/SsRnAE3FiJuO68=;
 b=1Lmx4Ch0Zr+oANKiIUXQWB+zGiI4B9Svdl5iH7E6qICdEsURn6k7PnOLmBp8kZTMo9
 GZPmdKm43fVU8w3U9R0a2GCe/lKwBhw+Vq41J5GlCAnb+HB++qdC0LhjKBu8uvFzcyPg
 ynFlan3sPSUcBC5KnX1De5NO7DxBvAslwc8TKRxcfkDSfGyBIMY6S6SrQrFKdl5FpfR0
 jbjTV0TL0jkEdAde1J3WPb1vOQAnvMGXSPYRPWqViPWBgGl7LHlgCQUIzRSwDVast6WT
 t6qPMQg47/U/piGt+yuFkHB0ojdn4JuXzzRZAiZh3HMh/YxGOhLlRwpzGm53JSGGNrhh
 8vzA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8gzGC5DRBlszHdFj00UzH0NsBqmKCBmPFJqAlTdfkKkDMX5k2KtmV7oykdWpaTrnk5JGcRIY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLjnwManBj7cKjPx4/i9LxMWMKM5FguPv35/RoNDaQblcSCNAmm
 o1liVnpitHqtFTl5EvDdFxec0DFYyH+DirPi7BX6avPJ9Et2ZULjo35q5yaAleBV2Uw=
X-Gm-Gg: AYBFou0NYewbLHkjTtJO82bGKBfzIbxQL7lkR68ydN7pKgbr9BZWcTJtkUevwxAvqwn
 hNe9rIPO+wqxRQnNTbLXCBa0+x34MtqVAlpwno6t50N8KSd7d3xENym+H6YsDjaQb6mvJ4hceGk
 UZnGUgwug+waG4OSTtqumJNGd+QFkkajcOlP+LvYHY6FjJwSONsYrOTWpwJMHg0jb7gB26ePsO9
 Sg6mz9EsqCk1Lp900WIKwlcimthhoeGHuq+RvBdb2V+R19TXenY8aYIVaMFdtypsIqG0o9/ACJH
 FVWW0sp6xb769OTQ3qG+zFBFc8+SkDhkDLQfirQIR7V65GY4mHUa1Uk3w6MFJDe5/HA7w7MQdQ0
 G47sQviFqfJI4MGPQUZh5jlcKDasEwy08nZrBSjQEVjjVWSadS6iGlzccuaIYEpFJr4cYaB9NGp
 0qBmCzmn4OGpXGmrdsahm82CjYMygw/mEnFP1I1IhKGHO5xuYnJ4DiFo7v18cPp3LrG+1fESIY1
 NJ9aQLVEuXRqZXVcYQa53I3yOvfy04=
X-Received: by 2002:a05:6000:144c:b0:487:27f9:844 with SMTP id
 ffacd0b85a97d-48c1ec3ed97mr17380319f8f.57.1791193306100; 
 Mon, 05 Oct 2026 02:41:46 -0700 (PDT)
Received: from [192.168.151.46] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab326sm2313656f8f.35.2026.10.05.02.41.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 02:41:45 -0700 (PDT)
Message-ID: <a59f088a-d1ea-4ceb-9f91-55b067e12e18@linaro.org>
Date: Mon, 5 Oct 2026 11:41:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH u-boot 4/8] ufs: add CONFIG_UFS_RESTRICT_TX_LANES
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
 <20261004-b4-ufs-sony-v1-4-54e71c95ba62@protonmail.com>
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
In-Reply-To: <20261004-b4-ufs-sony-v1-4-54e71c95ba62@protonmail.com>
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

On 10/4/26 21:22, Petr Hodina via B4 Relay wrote:
> From: Petr Hodina <petr.hodina@protonmail.com>
> 
> Add CONFIG_UFS_RESTRICT_TX_LANES, to restrict the amount
> PA_AVAILTXDATALANES = 1 at the start of ufshcd_link_startup().
> 
> Some platforms (notably the Sony Yoshino/Tama families on MSM8998 /
> SDM845) have only a single reliably-usable UFS TX lane.

Why can't this be a quirk set only on those platforms ?

Neil>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
>   drivers/ufs/Kconfig      | 14 ++++++++++++++
>   drivers/ufs/ufs-uclass.c | 13 +++++++++++++
>   2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> index 49472933de3..266e7180152 100644
> --- a/drivers/ufs/Kconfig
> +++ b/drivers/ufs/Kconfig
> @@ -8,6 +8,20 @@ config UFS
>   	  This selects support for Universal Flash Subsystem (UFS).
>   	  Say Y here if you want UFS Support.
>   
> +config UFS_RESTRICT_TX_LANES
> +	bool "Restrict the number of UFS TX lanes to 1"
> +	depends on UFS
> +	default n
> +	help
> +	  Say Y here to restrict the number of UFS TX lanes to 1. This saves
> +	  power at the cost of write performance.
> +
> +	  This is useful (and on some devices required) for platforms such as
> +	  the Sony Yoshino/Tama families where only a single TX lane is
> +	  reliably usable.
> +
> +	  If unsure, say N.
> +
>   config UFS_AMD_VERSAL2
>   	bool "AMD Versal Gen 2 UFS controller platform driver"
>   	depends on UFS && ZYNQMP_FIRMWARE
> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> index fdf62a69c02..977ffebc21f 100644
> --- a/drivers/ufs/ufs-uclass.c
> +++ b/drivers/ufs/ufs-uclass.c
> @@ -508,6 +508,19 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
>   	int ret;
>   	int retries = DME_LINKSTARTUP_RETRIES;
>   
> +	if (IS_ENABLED(CONFIG_UFS_RESTRICT_TX_LANES)) {
> +		/*
> +		 * Restrict the number of available TX lanes to 1. This saves
> +		 * power at the cost of write performance and is required on
> +		 * some platforms (e.g. Sony Yoshino/Tama) where only a single
> +		 * TX lane is reliably usable.
> +		 */
> +		ret = ufshcd_dme_set(hba, UIC_ARG_MIB(PA_AVAILTXDATALANES), 1);
> +		if (ret)
> +			dev_warn(hba->dev, "%s: failed to restrict TX lanes: %d\n",
> +				 __func__, ret);
> +	}
> +
>   	do {
>   		ret = ufshcd_ops_link_startup_notify(hba, PRE_CHANGE);
>   		if (ret)
> 

