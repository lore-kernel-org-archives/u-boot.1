Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95F4606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dJZKh9MU;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kBs8JMh/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB74060830;
	Tue, 20 Oct 2026 09:01:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n5-5MYzBHyxV; Tue, 20 Oct 2026 09:01:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DC15660846
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792486874;
	b=WfawUoX1YMI+dxEsoe3rrebTQxRBOINAHEnJpfIgM83v6Syx0WyuiCmIuMqK/9ebuAKL
	 aRjkbZ1Ad/eKQNiJYSeLo96yZs2U3oh3IU0eRyDiuVP/jaPIJaxIYmto+MzkXETGlXfoD
	 9CCIiqL42i/AbsOuGCMSCXC9sn5xO9dfwRj3efUxPg3vrCPqUzRfYPLNOocVANxZg8z8n
	 ROCboM83nvRBumlhZaVF1Azr3yTnItejrKl4GAMx7OgvYy9Pj8KF76m/ubK9fyc3BNss1
	 hDpjAvAYW0Cw/Difw3hH1/zAxUiUxG1SrpYz1DPpG7w7rqEEdSnRtqfElAky8iZbOQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792486874;
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
	bh=CxEXXvse09AMavIOXbVHNyWEDtYQm5ohLhtSPP5IcGo=;
	b=fy8DSs/eZ059reDg9FYdG0qxyB3d8bHM2vqDUxayPaqxJsreNPUkmj1avKr47nrKjdNu
	 gl0yED+jU+8AtI2Z1mz2LHm4xnX9pX7xPJDdVYA1cZjXSNWpjg2aLt+wpCYrxfMMHHGpX
	 vOIiAHqEybmgZhA4MIdKWPkZcgF120BCdlor8EiUZLgidv8ZHe1eV+NaePKpWsHVKdwp/
	 snGqZxs2G9BJObVVqhGwfSp7aedmi3+8WTBo3wpTMRkx+4DFpBExHvrZqr8ecLV+/wBSA
	 5SBDx5EmPkj6RNdQ1q3WteYUKaIKM3P+mcDZSddgHJlUTlRDhUc5Em+cLmlHeaUinNg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="kBs8JMh/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792486874;
	bh=CxEXXvse09AMavIOXbVHNyWEDtYQm5ohLhtSPP5IcGo=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=dJZKh9MUS+jNF+QDPm2yh8CFXeE8IhJ7za8w6LotamlrWGIitslV9boYc4HdhJozi
	 mf2WeW5RjxnauQoHCPfmdG3Z13Qam38cpPwXBHJ9zrMLEjvCzRuzImmXXuOH9RhCFv
	 AOYR4brLyBIZqS4z//qEBjx9muLllMHgvHaEJUySxKdt0QkRFRecPzAVGSnT8yWFXb
	 j8Rv3PLBj0Z3Zr5Hz/mviRHQfkE5oJvBuTSg6eb6MIwtefDuT/1Hr1QBSs7AyICdW+
	 x8n49hBB4QBdhM6/HuXPushMbqv6Tx827YAyx2v8DTPvS+idFlSjOjvQb63OW+IRcI
	 iCxxAP5DK7j9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC15660846;
	Tue, 20 Oct 2026 09:01:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E41101AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:01:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D614160846
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:01:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7YsH0jDF1-HQ for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 09:01:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AF3F160830
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792486872;
 b=YUHczt/X42cysGooT4a65DL31y37V+dliGpgPK1iQdr7UXmBDuluoPkKG3ArxV7fLGFo
 NGwAT6JdrwlgTfAfnf8MTYTO4ZerDlOCSzAKNDMF3+7oEvKFnpiDr6u+WZAj7fzwypEya
 YxiHc0ksaHKzvXRXhNozceBy31ynE2wnNgD6NcKoS4KrJEs8BPXfye9xJW9/8OSaIvO2B
 k1G6tEwGXKDQoyhFQ3AiCmCUGsfz2P2YDdes2Zgpuh1FOSfSHRPPd6yd3emJ+xKGnpu7K
 Fhq0at86/hhWAh+6SgpBaStkpgJm3ttHhnHf2lw77UrCwnkZu+eUT3HNiyDJ+vywsKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792486872;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=CxEXXvse09AMavIOXbVHNyWEDtYQm5ohLhtSPP5IcGo=;
 b=VJVwreYcEnw3IuOxcYXsWeBMj+HIxmvex9N7j6txhyHkliqL3kIBSjNm3SA2lIB3YgxW
 XK8O7GRd4NpmCrvs3oM43lvwg74djJ3CtKsBiqIsZHnRfamUyUD3OqHgvtAbHWdvt/gxG
 WejJ9DVpAWw49OJ21nUsIh6oUcDr7rN020o1gNx/eCnN0CgPPPtsN2cGqfmaaOowxNCZ0
 xDajHN99SVTjxtJTbFW1770WDS/7CkX/e8IWn8uU2FG0QRfgyMZyxFt2mj3c+nFsRPD9W
 t7v6+KKbVvM8KACALwdML/P/qZMcNiM706EC0asBYhJMybIjUcj69VssyAe7Ghr+/Wg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="kBs8JMh/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=kBs8JMh/
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AF3F160830
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:01:11 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso1684135f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792486869; x=1793091669;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CxEXXvse09AMavIOXbVHNyWEDtYQm5ohLhtSPP5IcGo=;
 b=kBs8JMh/NxpqKFi3u0Sz3RqBB3FboTjlzNq9H1RKMqLlPR/sC/xq9Q7srdl6KuJP5G
 G8nX/RzDvFb0+IaT3Jn83pD9lqUFrHFyCPnyZKMqw0Kh4oPgohfobL4ITTcUk17tzEPQ
 p+PSPhZCajHzZyHg/zCLG7G/ryemBM9xnvoMWuBH30NF5xUxzl5PCwx26F/KPNg04Ukn
 YrrDlzBdK6Q30PnMml8jP+z7BzJeaCLCHePjRyVJg7tLPGkdiXmoYAVK1YxDlzqPdvJ5
 /9AV1aOVvMbpjSGFXg52Hird/Y3SrPbztABacqAoCr8ADWuHwmpsTsvxg691TVGZppNa
 jNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792486869; x=1793091669;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CxEXXvse09AMavIOXbVHNyWEDtYQm5ohLhtSPP5IcGo=;
 b=A+hplFaTy085EnHJHnB2mnlQ4q5LWMKDN+uT0tUpAZsAgxP6gsKyYfmvTsvlhTeang
 uY1ja3xGvAU/R/ExODeY3XSOtiZKzW70hj8hw8AYONLI2HkwemEKKRMuvZDtDoevtDqJ
 lpF3f9rrP8ZZVne3aipyQPbGaXYOFrFNTe4ID4xdDH7SViQ3ht7HKfbzywF5pDulFq/s
 lZsYF89KRywG1aIllNd7WuYlV1qnzeZdhxWTdmDSMCyafje5OqzjnCrK49fxEPBEpfGM
 ZUekkVvSHvdmG7TCtdOwVf8/tUS9kDD0f/VFIpMYV1E0IGR2NjaxFOoMw+q97nMPYxoH
 xO1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWR7BdvE5icEgAOc/Ll7Y1b5qouAeX0OuqkzxoddDAGe4AV+AB+9+FnxOcTLky0KbGmg0mRUk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKJ9h+bumjAjyxBeVbMYt/AJWqzjEO3+OyTWNTejM/W46q9CPsx
 lK4eVyrbxBSbvpr6ipDrCmdshA+v49TDlqcbBmaXrfFqaLp6qoF9HrlhKKK1xPz0m1g=
X-Gm-Gg: AYBFou32r6qaE0Rt4P/ozoAqaQQg0JJIoTCQv1OJbVPmTOHl5tqTzHl0BIcCdEag6kF
 QVhwxUzUD0KuTKhIRb1KDYXHv58UU0nDaLSxUpfyK8EuqjWaRl/577aWBHUGgUidjU0h+j1zI0k
 zJ1h5sZKQO5DuM5nLMPj07Dp+7/bDARSaM8qmxXT9fVAnF6LwMw5cFxtOgC4zzN4o0d1TX5mHzX
 beqtiSxaO558BdqvcwaXPLarbM8QuA/C946ExCLCs1bYmyODKdBlmPSDOuoEOS8/H6MNhjwdKi3
 9r+vYrA5HLAyY8tnUr7uLmUagx9iKhyWBTustH8ip9beqvkXIM+9qbeL79nskNZXoKjylyLi614
 pewK3evxUw6IteiH1E+3LRv+MJa02or7jqXfEEOOvwVeNcLioygyfj7VJsqfC8XF0VIZsIxS74I
 e5au0RIrJ3qzk5hgS7vEMX6KGU4kix80lvB9k5iYOjufoDoxU/xjr8YZXVjjFum97uBnyaIuBiS
 JwGHN8yDvJD5hvYko7gX+3LVJVjvrTIsXsXp3izHUQoOEztZawfQg==
X-Received: by 2002:a5d:6dcd:0:b0:487:13f:f612 with SMTP id
 ffacd0b85a97d-48e07fa8cedmr16780083f8f.37.1792486869005; 
 Tue, 20 Oct 2026 02:01:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:e3a1:1a65:a394:be54?
 ([2a01:e0a:106d:1080:e3a1:1a65:a394:be54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d82ff70sm4674047f8f.52.2026.10.20.02.01.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 02:01:08 -0700 (PDT)
Message-ID: <12324c6a-cef1-411f-bc32-6046d881c88b@linaro.org>
Date: Tue, 20 Oct 2026 11:01:07 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/2] sdm845: prepare pinctrl and clock for QUP0 SE4 SPI
To: petr.hodina@protonmail.com, Sumit Garg <sumit.garg@kernel.org>,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Cc: Casey Connolly <casey.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 David Wronek <david.wronek@mainlining.org>, David Heidelberg
 <david@ixit.cz>, Petr Pavlata <petr@acrux.cz>
References: <20261016-b4-sdm845-qupv3-s4-v1-0-672e9be21fd2@protonmail.com>
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
In-Reply-To: <20261016-b4-sdm845-qupv3-s4-v1-0-672e9be21fd2@protonmail.com>
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

On 10/16/26 22:13, Petr Hodina via B4 Relay wrote:
> I'm working on a GENI SPI driver for QUPv3 platforms and the SPI
> controller on SDM845 is QUP0 SE4. U-Boot can currently only describe
> the UART9 pins on this SoC and its clock driver cannot set the SE4
> rate.

This SPI driver doesn't work for you https://lore.kernel.org/all/20261008-spi-v6-v6-1-2a8f6c05ebb8@oss.qualcomm.com/ ?

Neil

> 
> The mux value of the SE4 pins differs per pin which the per-function
> pinctrl table cannot express.
> 
> Therefore the first patch makes the lookup per pin.
> 
> The second patch lets the clock driver set the SE4 SPI clock rate.
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
> Petr Hodina (2):
>        pinctrl: qcom: sdm845: select the mux value per pin
>        clk: qcom: sdm845: add GCC_QUPV3_WRAP0_S4_CLK case
> 
>   drivers/clk/qcom/clock-sdm845.c       | 10 ++++++--
>   drivers/pinctrl/qcom/pinctrl-sdm845.c | 45 +++++++++++++++++++++++++++++++----
>   2 files changed, 48 insertions(+), 7 deletions(-)
> ---
> base-commit: 1bcb2fe324180d0a8cfbdb0511737eba1d5b8550
> change-id: 20261016-b4-sdm845-qupv3-s4-18edc95821d0
> 
> Best regards,
> --
> Petr Hodina <petr.hodina@protonmail.com>

