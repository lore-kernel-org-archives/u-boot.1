Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47258CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 13:31:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BC2B406EE;
	Mon,  5 Oct 2026 13:31:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0MIqNJQu8XCN; Mon,  5 Oct 2026 13:31:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A09A240699
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791207083;
	b=LmyO5W1Vc2ZAGN6ties89Ak3/PyVws8NdgJFNlhw8ALBbDYeU2+hADNXryo1Gjie/pzP
	 yh0sO9ABMekjANBank3WBJ5bSpKtafYOGTGjpTsk1r/4nbIu/3MiMZlfmVaez7A8QA84E
	 4nXTdPBj+CiZLtMyEL2KmQF1woCelEnzXzLsZ31Dks3ipe/7hI+Bf0TP4KXmf6VDTNmHl
	 JeiDiI9OjlgjB2/euzrhQYC8mff9N8R7Mz3GFl1U+3I3KUwbQZm9S5qPGwhO/rOnKgS4S
	 h+CSFxDetFGUlgfN8pzVs/9Aow3kftKCn4R0yNuY7zYtgn0MKY5Q8owaorGWnMMlSwQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791207083;
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
	bh=TEbBx+q7n3FxiN5ShwGRMrQj9bsRJIWSeWeHI4W51iw=;
	b=piNoNDCtzbsKyVDKJVprhQgYxgjwpaGNv6bYFTj7w9OtdCWLQptIIpK6iLc+Qlml8TUt
	 UeRwEGrhAMRknuaf9lnq9NNVnPZRRePHsr3P4Nrpn9ZH8SxIOav5EwoJvU8U1FVJEPz+r
	 pzb2y9SDugvc+xWu1F9pwPbpqClPGhgqjdKvXmgph5De4cIdtSx9BfckSN0V8hZvnAAHd
	 LApOU5DmPTLxUpig8zUJA+7mpWUzETdtb9LBCVOJd6l9bqc8LRBG/GeSHFHPVguZ5T7UI
	 IInCa59H9qQyio9Vzlnf+SnmMftbMnAH9GRRtvck6XuLhGhO40d9tWaRupMix2cmoWA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791207083;
	bh=TEbBx+q7n3FxiN5ShwGRMrQj9bsRJIWSeWeHI4W51iw=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=YsihVG8+1HAfAy71SDQy7/0sRa7GNaCv4uIESxJqjmamk7IKVFMMywbpdBmdmJYmx
	 og4V6RmxZry39cetsGgsp9/kUIl6TuzWmmR2VxXegWpjtSZhUh6zBcWAQ7Mo2wKwBU
	 yNNBYoIaAJVbCvgjncsKyPK3iuWnmH5IKTbKVWooj4MgUYoc2A2gseRP9NU370S5m7
	 CDqG/sZ5/JwwyglMurKk4Uo4ZWKYLQHz4TqTsFZgJKDumGSlDHk7FjpFTuIXj82Bbe
	 /SX6zfS1YKwbAq8TPl2aIkz+Grwte4hD4sBF9REZGy+hV85Bz35SKElSG/shK9tn2Y
	 wMSetoumx70zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A09A240699;
	Mon,  5 Oct 2026 13:31:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 958811A6
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 09:37:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 867CB80AC2
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 09:37:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4vGXd-WQ2ov2 for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 09:37:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 721E680ABB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791193072;
 b=BXQtXXbsIZFd1vbltctRcat6PnASsQvZEzMvXQotvMjg/lHZtAWEFuoV4EcFgwezEVAr
 xwR7R+oJapXIoKvKhQQXpQ2JjPnW2vALxsLzSgXBBdoFO+CGF6Kaect2AYeJy7CO61hAm
 pNeIF6SZ3DhafiQtTU9Qq0gnnzAlX6XGboy6/RpjmkcBJUjp+/UFM96wwvpzoKgkzBIQw
 +xjOuJhqHFa/BGPgXL/4z4/EAI0pXyLoEhuKDintP7htg6UJRzqbQGh0ZzrWbZGH3f7G+
 o5uU9xgLpTIzJ0eek0+wKcGuC7xG5Jd89AvCVfDwGLo1Omv1Qte1djhfhZS8l82aonA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791193072;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=TEbBx+q7n3FxiN5ShwGRMrQj9bsRJIWSeWeHI4W51iw=;
 b=S316vuRv5yUrt09uK+2uE3Jps0Indiv9D+ECiuznYAgH5eK6rTlhShVtA+zEFc2Z4b6R
 SWxOQ6sb524AAWU59Eq+1AurzRPtlHMPDkUD26ROrMvohcbhFNY7G+uj5ZioaLu51EL6f
 KPaJUsMhMJkwXNmfJL9euWJsJOeRhxxbgVjo262fcXk+P3J+qCLCd8W1nA5E8KAwyNfB5
 iPGhez8vjCzKDq8tcgwk6IZVkWlDa2aZM8VXV+qO0go8l3eVEKcTtOXFg7/EyITmAGrNG
 OdSy9MHxgFqCKSdu9zubY7IVn5hA9Ikn6uH5xfkfTWtX2a8WO9beQrL8fyklluCFo+g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tTwFCEt1; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tTwFCEt1
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 721E680ABB
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 09:37:51 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso16217665e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 02:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791193070; x=1791797870;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TEbBx+q7n3FxiN5ShwGRMrQj9bsRJIWSeWeHI4W51iw=;
 b=tTwFCEt1ANKzMRRrxhntw70RPEk1ceUgzRjJnmqM9kjUSx3mkTQVtUpTYSS7SDvWVi
 5KGZgBDR1UcWgphftDboPvc5mXUeJglwAjmXGVjIX4+GQECWwrQaVqRte6VTMo/vBdlU
 f0moo8/rQUkcNmOQMaJ2QJ3BII2FSgLN/foi+ulVxf8b/OWQ6CjfsESnQb7CoWtxNAZ4
 uwBoUw8eeTylax0K3Zv4enZli3FgeYDBX12+i9LLEQESQWIf6/Z0+bpze+EfbfBtJlxm
 pT9mBs4bUA24bkS4vdnaVuYQeF+xoq2y5+pcfXwG5i6O/r7aXaL453XvcB6tJ4oAnZdJ
 odrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791193070; x=1791797870;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TEbBx+q7n3FxiN5ShwGRMrQj9bsRJIWSeWeHI4W51iw=;
 b=il5jqquMZZDgguJnoDUtRnDu8exVbxenWjlXdq8hmvoBZgTQ1wYaSS7l8CMvIw27fb
 BM65R6w0lMs6xpUv6/QJ0Mgoy0asA1CkDL3zVyara/vrxUUXM/ShXP4hKuLWtOsWDVdF
 XqwUSKsjrw6T4ETZZyC5pXIGff1gs4YDmGVdxe5eE1wX5L/Vv66RUzb4+aA4/f8HdGb7
 flS7ZoUCnOcWQ0HylK8XMkK8c3NLHD0CqYlkrZ6k7NeeR6m5Xp8ebzhJGvNx1W3agMrP
 1GXMjbrMxq9+Ojql8Gz/+j5qfPPC1Soz8/tArwJWGLsblTDKI1berkhp9vQm5jsIV/KV
 EW+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUcMHwmIsHWvYjzWHX+hryUAvKGhKi15SvK4uuZlzNAWvuas8Vns6YsfAeZgcR4Bu1QhboGLQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lPkGQMycs/HXd32DX3crC9vIdgVwcKCB2ktk2M6TLM/BfvByKl
 doCvQjAoz8l8sW7DAjdWNfRNex83FoHVKhIN8wM881Ni9RjmTMHoh2wEhjFTCeZFqfE=
X-Gm-Gg: AYBFou2zSE+PQixI7Gka38daMKO2vbqxErjxKPasKI2Blrr3S5n1NpsAE8TAbSAqi2f
 Ea7c1lCmcTRMKYwD5IPX4uIra0gFJMLDOE66fuB7stIGaQa5wjRA7nMeapCa70tq3D+xuG/+Wfw
 Jzaaoh6OHgJLWeQi13s5T3RHK9crX7R6jlTnts+4FNVsdF3JiJ81BNRlmyvj0SCjuxv+eu543hq
 myRtrA2Rw2BnPNi5ICJKQEiWLiwRs0VaL6rKnhnGaFooj3FF5x0pzx/EmF3LA8lSqEKG9AMjhSe
 Z4gbMkErPZjJ+iqWdSwpM8SCFMoAe79EImk7DnlpDOAwTNMf28GDJPDjU/ffJvXA2zoIZ6vIIsV
 ARezudniyfm9V/n5Le94nfi7ULOISb8K9hhoVAkcAZtzbya0zemMiYTx9KxY3tfbwah38SnPu3i
 3xP/oNu851504P72ZB3U2R9NDsFML6uNT19Omxaislw+gDe0j2t41FHrE2AwmNl5udlnW6HT0sb
 1EdWVhd+/ze8swlQqv5RkMfvP+r/rA=
X-Received: by 2002:a05:600c:1d08:b0:4a1:688d:a41c with SMTP id
 5b1f17b1804b1-4a1688da4c6mr111693445e9.25.1791193069651; 
 Mon, 05 Oct 2026 02:37:49 -0700 (PDT)
Received: from [192.168.151.46] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a16d6295f9sm242725405e9.14.2026.10.05.02.37.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 02:37:49 -0700 (PDT)
Message-ID: <66a2ec2d-ae66-483d-9506-658cdb7c2e1e@linaro.org>
Date: Mon, 5 Oct 2026 11:37:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH u-boot 5/8] scsi: ufs: refuse erase/UNMAP on NO_PURGE
 devices
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
 <20261004-b4-ufs-sony-v1-5-54e71c95ba62@protonmail.com>
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
In-Reply-To: <20261004-b4-ufs-sony-v1-5-54e71c95ba62@protonmail.com>
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
> Enforce the UFS_DEVICE_QUIRK_NO_PURGE quirk on U-Boot's only path that
> can reach a UFS device with a destructive UNMAP: the block-device erase
> op (scsi_erase() -> SCSI_UNMAP). On Sony Yoshino/Tama a PURGE/UNMAP
> erases the bootloader and permanently bricks the device.
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
>   drivers/scsi/scsi.c      |  5 +++++
>   drivers/ufs/ufs-uclass.c | 12 ++++++++++++
>   include/scsi.h           |  5 +++++
>   3 files changed, 22 insertions(+)
> 
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index 50e7d749921..ba7834ea035 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -300,6 +300,11 @@ static ulong scsi_erase(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt)
>   	lbaint_t start, blks, max_blks, blocks;
>   	struct scsi_cmd *pccb = (struct scsi_cmd *)&tempccb;
>   
> +	if (uc_plat->no_erase) {
> +		printf("%s: erase not supported on this device\n", __func__);
> +		return 0;
> +	}
> +
>   	/* Setup device */
>   	pccb->target = block_dev->target;
>   	pccb->lun = block_dev->lun;
> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> index 977ffebc21f..7dfba3ac1ac 100644
> --- a/drivers/ufs/ufs-uclass.c
> +++ b/drivers/ufs/ufs-uclass.c
> @@ -2366,6 +2366,18 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
>   	if (err)
>   		return err;
>   
> +	/*
> +	 * Some devices must never receive a PURGE / UNMAP (secure erase): on
> +	 * the affected platforms it erases the bootloader and permanently
> +	 * bricks the device. Disable the SCSI erase op for the whole UFS
> +	 * device in that case.
> +	 */
> +	if (hba->dev_quirks & UFS_DEVICE_QUIRK_NO_PURGE) {
> +		scsi_plat->no_erase = true;
> +		dev_info(hba->dev,
> +			 "NO_PURGE quirk active: SCSI erase/UNMAP disabled\n");
> +	}
> +
>   	return 0;
>   }
>   
> diff --git a/include/scsi.h b/include/scsi.h
> index 2520a8b8fe6..fc296285dd5 100644
> --- a/include/scsi.h
> +++ b/include/scsi.h
> @@ -275,6 +275,11 @@ struct scsi_plat {
>   	unsigned long max_lun;
>   	unsigned long max_id;
>   	unsigned long max_bytes_per_req;
> +	/*
> +	 * Set by the controller driver to forbid the erase (UNMAP) operation,
> +	 * e.g. for UFS devices whose PURGE/UNMAP would erase the bootloader.
> +	 */
> +	bool no_erase;

To avoid proliferation of variables here, could you add a quirks variable instead and
move the no_erase into a SCSI quirk define.

Thanks,
Neil

>   };
>   
>   /* Operations for SCSI */
> 

