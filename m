Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A274B606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UetRnC59;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cdAjqDBg
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC61140824;
	Tue, 20 Oct 2026 08:52:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y4N8oAxizp3J; Tue, 20 Oct 2026 08:52:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 393D94081F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792486350;
	b=WXZiPNfpD94UIB0e6+1YBjzoMwMZshWLTRvoVZRAX1K75vZrSp7arakG9nlMBPJeir6U
	 XcV0JOEm6brVUfggg7+2OWtMano5L/zledIiyYM5R7GVHlLN/fEEf+Ym9Eg6C8pr/RPd9
	 q+/u6QQ8NN7wjfIsStDpRPdlXcIsjecCbY/zAAS8cXLEbHtWZCoz7HtG3tlu8oPgWMZyq
	 0kawRvOPSuiGhnmsEnGYRd24+s6FHUlwhuEbpo7nMfYUxtBZDd6EZQ7XOpHIjtno7FTM3
	 fG/2YEOQF3mwPWnmStdLb5lTPBXmSBHLNEIThIfBrNLcBi42JM4JgE+aiKWOZ8+WMLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792486350;
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
	bh=6skW0EqYxiPblg1iqh5MAEg62c8Jk/goBzNeA16zSsg=;
	b=HdtuaTZYBCiBfHWsq21Y7yYLczn6CZ3IROip7qTFM0NzmotdwEIWSRLrvtfQKUPB/80p
	 dn51Nk1Rwnkdm2k9Ndt3eESxiOlvnhmBLu0ynI/6x7DfNqlDNwNf6GhvdRg1chcM+LrIV
	 rJPYo86mzl263C6pMTAhfiAzLnrN5zbe4yXtXZ7fEd2Z8WzpwDTQvvL9WuhxfUX0p7WA5
	 gS54GH5k2/ZvifC4XcrGZoThTFk/NZwi0tir1xX7a6Ltcfom1gPLWMhU29Q2yG3PfLabn
	 /T8XiNuqUdBg0uUS/1qaTcqn4fSEkClgDVTSX4Qr5il2KtJ5U3zJpH6FLMhTVelNR4A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792486350;
	bh=6skW0EqYxiPblg1iqh5MAEg62c8Jk/goBzNeA16zSsg=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=UetRnC591Jj+Jzegx54GAel5fhDYjwdzACg8FWhJARFAux76CBpgRuUhx58E/7+/f
	 IRlBqqsVWNROCnnAu0Ayq6rSOced0Xicx6L43OJ0Zm7UNz2hA/NruKiORPpU9xEErS
	 /GtQ2fuUVBgyLh4UWcwT2EuF5jMqshk9QsnPOm3d6OGiSy1PsUnCM2sZS5naGAd+nX
	 YOMTrKDS4bbaEG+LsO6k54owx8a3Rqzerrcp4FJtTyEDJkPL8xnKXQBZ7e2k+JrxO5
	 Syj77JhtM+9+bUcjc5n1A9AW4rO20hWmQGdK4mYCHzl0tIH9F3sg2xgEmQYoQBpUo7
	 oyifF6M6o/69Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 393D94081F;
	Tue, 20 Oct 2026 08:52:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A42C12F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:52:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 69A5840328
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:52:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z1I4y9KU1fCD for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 08:52:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5D1C14016F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792486347;
 b=HkwbFpx8BR29OUkLFEAuZwYlY8CHFx1IuKP5vyaAQ7dRVtehFyen8JiPLdSEKLwdeQEC
 eL6uZC8Q1KZ2WrI0FGDzuFHE88B+w4+Yr+F7/rgIth3figfJnuysK4wEL0HpLlqP+ERNo
 w9l6hKsq/7+Sto5T/QM0AFkz6PPhTU8N3++G4IHSTQRndS95KuNMosXc7wZWvsvoUGc7q
 /AAqet5neYdwL+rr6C4C9a6/eZB1I2phN5HhacrdMNRJFkqD5ELyG3HHB+DGFBr1vmtQt
 hYMywwcKgnrUfYfUSFxOGx9MAlMQN54G4F06ZJ/uco5mgDLarQvGtwSWfgBkxIl7KIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792486347;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=6skW0EqYxiPblg1iqh5MAEg62c8Jk/goBzNeA16zSsg=;
 b=D6XyS1D4RgZZ9fQYJvm+GEqA7Kcsvwmo4TMtPsx0iqyQENuIoxxMAXYJz6sPjXh6BjMG
 ARJk/DVv4B3FZe8KQJwOMJ+0mo6tcHdaH6jQuwmhou/lfARf/hCmLxAMoW6OGhpgcxSTE
 HGoBOLfRdxc94ADoU+G4bjlzsESds3Kutd+OBbACfvGlu3CJ13lLA9JXDixh9AqSTGd16
 S4Qi3bOT1qLIuVnF1vEhqWJoHdOOFj5sEsZLwxvvUHY8DbdMQBr44IUOhWcueA69zH24L
 p/2HWA7gYNO4UqB38G0t9gvBKnPbNmC2TCB2VryxpFwUjy5mDyYUiIu8OAQH31rgCkw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=cdAjqDBg; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=cdAjqDBg
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D1C14016F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:52:26 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso1599470f8f.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792486345; x=1793091145;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6skW0EqYxiPblg1iqh5MAEg62c8Jk/goBzNeA16zSsg=;
 b=cdAjqDBgTwFY+BEva5bLws8y8DWudocPm0TLFbm9SLd78sOM+Bx0OxXLQrbE85qoO9
 Kvh5V/+r7opCHqeKOx2okGZ8TIJhsPG76Q4F4vpjPU9ftvyEZMKSMJQV2bXfFjTzwQ4c
 rjuOYEL00UqsPh8h5WF05Cfzry5IQ6Adpx/Zsgla8zqwjj9FKdt3DZEkClxARWzqd/EN
 cADdPJY2T0HHrAx5kp0u3hB/vLA+O87CVov8BlJKK+UodCKAQFRjSb0PNaujtX0HAzL5
 W0/2wvhy8h/tCFM7s9yPrFFLVpw4fZCRyywwuA3ArOWVflN/9OWoQNl0ahU7Ey7MrjvD
 dpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792486345; x=1793091145;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6skW0EqYxiPblg1iqh5MAEg62c8Jk/goBzNeA16zSsg=;
 b=BJmXZ05TKbQbm4eL6lAzi5HzssR4GCLdp+n5jwmRz36/qY9l3oRbyFHV6oQWri1A4H
 p3UpcbvJdGBU0PsRy/Wl3JczmtYKuVKbF+sxk9izZr1sOASi8/7SeO0Ej4huSJmIjXm9
 qoADN3vriwLUr9IBRfLJTZ4SngdoSCEoRBcRF/VqWIs8GQqJUOilyRPHcodGbo78EkBZ
 J3Jnuc/d/BCIA0bXTxQlTO8VaP3HFLCNW70UR+yKw9CaB8s1q6Odg6jD59Df1d19FPen
 yajvlapJ1Uo5xEJRbpnLUG1Qnld5GFrR7QlXHGOzTszwKCR3uBe6Ixsq4wjnxQdbZuaZ
 ldgg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQsbQEqHvsDaI81LUYmlsw8L1jUzhnBAC9rCD8U7rh0hsYBO9AfI9OvszDwE2nvXC3G3RV3Ko=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI7yAD8B8yp+qaQi4vchMPj0bTym9zYnoWKFyb9rMWRYdOVx22b
 oePaFtTq+j6O48ucZfZsdm8sHlfhtCgqB84eYWY3p7eXrE59ZLavrwqFBn/p04mCztU=
X-Gm-Gg: AYBFou08ADb57YtBXXF0dOPHjtRw34/I5hSPp+dUqzU63wdrx/qHR95Ue5Q4RdE/nIs
 Wh1FW4/mKKKzyvjPED1nlkyKUIzY9Qi9vp7Sm7MIHrBL6xtZIv/npldF7EVr84702qqYlXchYG8
 rGa0pvrxC0u9n5zoBCgjnX7FMhE3ISxJl1hRgL2lXNIyCQOY/epVezw2wCZrxS/Wj7xgXNlCRBu
 26z6WHCUrap6W8iz/qHpKMdCvViQch7Fgi++FT3qWZVlBIfOdYugqF20kC3jca5s1lTvMB5Om/J
 vvLeMXsgZ2j8vKWtSVtASRpvx8SSP4Au0laQPZ4acZgdAG0Ewz359FsXPS/nvxSy6CX03WqdvWD
 YPpy7lLPYXXcXwwZpNdPI46ef4KVxQS/61+dTCGehm5mBcgcRKVPag6CkHU3QiQ8YExhx6MAZDo
 eRM27RFLdmIF8iQ7AOKZXUjRNl8buDM3KDibEcybyb/OJpUoyV4BozUMGbYpwPogNRmx/0yLSsK
 JHCv8dK9Y92s0qNT4TwOy0+L6AZ7Er8l6fJuHTQagSOzsgA1iYaQ/ENYTRLOKNL
X-Received: by 2002:a05:6000:290f:b0:48d:deaa:4dbb with SMTP id
 ffacd0b85a97d-48e07fa733cmr19523977f8f.40.1792486344719; 
 Tue, 20 Oct 2026 01:52:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:e3a1:1a65:a394:be54?
 ([2a01:e0a:106d:1080:e3a1:1a65:a394:be54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d8244e1sm4487124f8f.44.2026.10.20.01.52.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 01:52:24 -0700 (PDT)
Message-ID: <19ddc00a-38de-4950-a451-7a502f9c19fa@linaro.org>
Date: Tue, 20 Oct 2026 10:52:23 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 5/9] phy: qcom: add SPL_PHY_QCOM_QMP_UFS for SPL UFS
 boot
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>, Anshul Dalal <anshuld@ti.com>,
 Petr Hodina <petr.hodina@protonmail.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 David Lechner <dlechner@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alexey Charkov <alchark@flipper.net>, Peng Fan <peng.fan@nxp.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com>
 <20261019-spl_ufs-v4-5-61432d0b258c@oss.qualcomm.com>
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
In-Reply-To: <20261019-spl_ufs-v4-5-61432d0b258c@oss.qualcomm.com>
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

On 10/19/26 12:49, Balaji Selvanathan wrote:
> Add a new SPL_PHY_QCOM_QMP_UFS Kconfig option to enable the
> Qualcomm QMP UFS PHY driver in SPL on Snapdragon platforms.
> This is a prerequisite for UFS boot support in SPL.
> 
> Switch the phy-qcom-qmp-ufs.o Makefile rule to use the $(PHASE_)
> prefix so the correct config symbol is selected automatically
> for both SPL and U-Boot proper builds.
> 
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v4:
> - No changes in v4
> 
> Changes in v3:
> - No changes in v3
> ---
>   drivers/phy/qcom/Kconfig  | 7 +++++++
>   drivers/phy/qcom/Makefile | 2 +-
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
> index 1fdadaccb12..8890854f3f0 100644
> --- a/drivers/phy/qcom/Kconfig
> +++ b/drivers/phy/qcom/Kconfig
> @@ -32,6 +32,13 @@ config PHY_QCOM_QMP_UFS
>   	help
>   	  Enable this to support the UFS QMP PHY on various Qualcomm chipsets.
>   
> +config SPL_PHY_QCOM_QMP_UFS
> +	bool "Qualcomm QMP UFS PHY driver in SPL"
> +	depends on SPL_PHY && ARCH_SNAPDRAGON
> +	help
> +	  Enable this to support the UFS QMP PHY in SPL on various Qualcomm chipsets.
> +	  This is required for UFS boot support in SPL.
> +
>   config PHY_QCOM_QUSB2
>   	bool "Qualcomm USB QUSB2 PHY driver"
>   	depends on PHY && ARCH_SNAPDRAGON
> diff --git a/drivers/phy/qcom/Makefile b/drivers/phy/qcom/Makefile
> index 714013dc572..ec99fab4468 100644
> --- a/drivers/phy/qcom/Makefile
> +++ b/drivers/phy/qcom/Makefile
> @@ -2,7 +2,7 @@ obj-$(CONFIG_PHY_QCOM_IPQ4019_USB) += phy-qcom-ipq4019-usb.o
>   obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
>   obj-$(CONFIG_PHY_QCOM_QMP_COMBO) += phy-qcom-qmp-combo.o
>   obj-$(CONFIG_PHY_QCOM_QMP_PCIE) += phy-qcom-qmp-pcie.o
> -obj-$(CONFIG_PHY_QCOM_QMP_UFS) += phy-qcom-qmp-ufs.o
> +obj-$(CONFIG_$(PHASE_)PHY_QCOM_QMP_UFS) += phy-qcom-qmp-ufs.o
>   obj-$(CONFIG_PHY_QCOM_QUSB2) += phy-qcom-qusb2.o
>   obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2) += phy-qcom-snps-femto-v2.o
>   obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2) += phy-qcom-snps-eusb2.o
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
