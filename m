Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02758606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H/SjRnCI;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=g+cxwnum
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4164A4082C;
	Tue, 20 Oct 2026 08:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 23jixyUCpQUw; Tue, 20 Oct 2026 08:57:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6FE694081F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792486664;
	b=RwRNDx4sC4I+/A5o2A6F3/03KgQEYd3FJAgvEWhd8fTnJRl60D0Aj6C350+/yWocF7sI
	 H5s5hhO5WGOoziD11u3Q6f9bZ6MdaH0268Ah4lijrkHho3Mg0XgBdDrm8Z9TU/m8hq8bG
	 X53Z/aB9RfqnS53Px356eHBhWbbg0iawEJtOuNGreHM50Fsn4s+ZdcvUYPfhlru9m1zNg
	 5cKZSysDLf7tIRrOkgKopHLulXVYp+gBcxVYKK6SjtKBYlY+Nj7O828c7dLXd7T+4bS1h
	 rmlHBni5Qa3bJ1XVQypg6dO4q/9ShjY470FcssSgRjunqn31f8FNebEkCr9HHRWizjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792486664;
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
	bh=w1dvuexSdkH7Yqr+disTfUQPOZQYTREvFn8YpJEaCZI=;
	b=Y6mzVR/IktQeIL1GAAj6uHwVL6sGyjFDKUCaob2Bsgv+LQiXl4rLcgcL8nWinqJjKZTE
	 suEvffp9BmTr5PxhvEB/lq3hgPibt1SJCYm/pUVvaD5J5Vq5VgFL5ERborQzyuT7VRHWT
	 e16SewSV127UJNvW8F0uuj21hnShkZsMkS7egGwrfOPG4wx558y1OWawoK0HHtH462XTj
	 LuV8V5wE91eLsM667/4rYRWPCouw9fPI22aSkdk5phaYCvh+0wfy/tC1C/GhzKbKhOGMl
	 Fy2n9k3Q0qvIHaqdq8CkWUFpPlsQxYwp6Qgadum5gS6TSzInle7zpJb0V372m03yMsw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=g+cxwnum;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792486664;
	bh=w1dvuexSdkH7Yqr+disTfUQPOZQYTREvFn8YpJEaCZI=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=H/SjRnCI4s6qyLscSoBU8SWw3LDmbo0T12na8QxSq8j8O63KNEJPDItVoT6Ihy+bQ
	 0Ez4IOi+H9UJilf93sLyMCY4k6MIGVX97TNdhd9TrtIe2tk82hKaCrYroQb3vfvXYG
	 lhAMWXj6u8mkzi11I90vOggvBe4nLG7P9qjZlMLQncrwKfDKr1+zO3eY2XHGFpcaUi
	 Yc7n0lu5DvHbo2RJ4TPKRpZvu99prYobbg9uQtq5NYI1L/qcFzpT0ar2RJoIvaijvP
	 FtkAMfSXGzsPOGDJwCc7sgu+ujxLJ+hNvIQITLF29K207Gt31L3t7kwDRMM7DemAiu
	 9jry3XqEAfffA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FE694081F;
	Tue, 20 Oct 2026 08:57:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0ABFB279
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DDF9F4081F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:57:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QU50r31dPXoH for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 08:57:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ED6AD40818
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792486662;
 b=QZilyjgc3quVUa2EZ38x/mCY4xe6UW9vr6m61llCax91wyEkgTnlTQje3Muz4d8Pqps4
 qoQsIn7HxWYemCzkQFArszkw7ACkgSk07vUpoM7ZO2WK15KWlN1BUU4tYvJ4IvIC65Zvu
 dXocnT1HxdeR4X/M4ne2JxC6hxj0/Q7d7Jpe+c1gee5LpDlmhVRoe0fJYE3tAFy8uAntj
 j6mBrBCABY2AsvIrGNbBk2nx2sezflBAlnJtylXPdXuc1G9Qub6bPuvxKjMC/Nmm6BCOa
 2wsVH/b4Ap9+QAJvhE4pFSodZ/YJPQl69EAlxBS59n05svlvwJ3Z/u6HSzMXe1QSGHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792486662;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=w1dvuexSdkH7Yqr+disTfUQPOZQYTREvFn8YpJEaCZI=;
 b=ALGvrteMX+lZYpUhbCJfe7ARwTJRs8hOwge3e3geRKCrnupjvaD4EbDteFoyio2S0iel
 cUp9Nx3pic5T0uytfBungyuik9jEMocspjV2//kgHwZVdWpS00t5BFQbEfStF2zlkz/do
 5I9tmb0tRuf5sz0GNP1t4MXT0FniNY7KACrOTYUf4RPZ2TDfDZGz9+S3kcAUnql+veex6
 PpFmihB0W6KQlMJD00qaw6EUHLGfgWzwxoMaPi4Cnl2KE012GLY7qt8AAxiCJ51pCehhu
 F3TAQbdsn3Zdz0DHk4WevgaWPO3OApHon03ToOHd9R2GChMAFbB+Dpd8oHZXQmG8mPg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=g+cxwnum; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=g+cxwnum
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ED6AD40818
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:57:41 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a1df146015so17251355e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792486659; x=1793091459;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w1dvuexSdkH7Yqr+disTfUQPOZQYTREvFn8YpJEaCZI=;
 b=g+cxwnumCPvrPU+BJTQk60VlSoadFkv16nE9CVrqbfC6v2Xh2eceN6z12PVFBatep6
 aIyWL23S71iKg91LoXMEmXpD/aUoNvm5Q1twNtbPHfvDTjmEeLqMjiSlX6BWXA7icjVq
 D4CywaIzmxREWSCTpRGQRtFpn1eAnbioRoiT2bG7ewqOwqjbwamPcqvx9jouLxtJpCQr
 BIHi1IZv3VaD+dXTSXPjxO3wlxUHRdALYlz5plt37YclAJ05MO7iVXuMSHGYrt2ajRUW
 +1U97/MXgAMDv2iYDOGqi0PbKAzqVdma1KdCeoua633s64HYRzrccHRJ3DCqJ1iJ0L8Y
 Kb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792486659; x=1793091459;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=w1dvuexSdkH7Yqr+disTfUQPOZQYTREvFn8YpJEaCZI=;
 b=pz4ta4L+w69wx9W7ZOhkGdvQ6eBFaOeIWGHG2ccnUF+EkhHurM5rC2dMlr74Vck3eW
 Ih+2IOXGuIK5Q9OcgmlbvJ4dfyotQ/xak1pBCbe9R6DDGwjK1FkeunoZ7BaJUpJLabXF
 wrs9zav9oioTQ+Yk8aZ3es+AcDsIL8dAXqKsx9IWUHr+JK/o+AYsDqbRfbgBU8Ugslcg
 Hhw+6B3sccaXQHimXy4dxj5RHfCLtmD3H+Q/xGbtxk2rKJzEjQ4ZIZrBpTHMXyJ/PIow
 3HWJP6j35qgTb6UEL1isAYR7/j2HhDqtZVBTtGmB908fj6UCOOJ4LiF/E7PET4oiZ8Wv
 RDkA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFm/6jAmYn0IfqWKXNIyxvWLs9HqZ4Gcb18f5eGoDUuxWziGTUFN8wXoUhGh73dPCivoLlz/c=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKhpr8oVjjjrueZyuRW6MzPfMPlGoXIemOOlZ8k4+gva3oL/OrU
 bLucE8r5qFndxcYqkJTlyHFKH7DB+4xq9nSFheCyxxgxDV6TyKRmLwxRZYCgtqB75qw=
X-Gm-Gg: AYBFou1StFlGLzPfd/aR6YnWuMJxMy6qO8xvc9CNPnabeFU2fu2keggvHVLIoBYLCB4
 FQaVmwaxWBgFdkF9gtLWQP/ptNnqANcISQqOUYxx8U8srWsOluV7HrOZZxhb4Je0vIsqqXd6X4U
 shxAjgYyW8snRrcINmIOH1Y/spjZW41Zpa0HIilwrt6vIkOVEbhtqYMWS1suMTxlwwH77x2lBh2
 uZeITSeS0ZL9nrTcQKrmcxGnSZzbFnEnVsEHpz75ZbGDmtG0PC2Ju4+KMePFNiJd2Uw+rm7F7eY
 5oqLhce2o8YJQdenC6M/IesO0+1Fu/4vsYypHYGQ8IoXfSK030lBgEI26pEQECXClBHzMwSoQDI
 kfjYrHSXPB1Xg1ngAbR+uPHpsNnxiqpWEa0VdTdbmS3NdtL859MNeGT/D30xPXUjkt7ZcR0l9ID
 2KyYq80SWm803/1EKSTihKza/Ocra2tQ8aYRo7JH+oIK6Dk93GDPUqTC3hrM5pj7R79TWnWA5sX
 585h9FAcqHLi+OAu9eIrBh/l57PA+5fdDcJO+iqGowdQ16ZP3u5Jg==
X-Received: by 2002:a05:600c:4fce:b0:4a0:5b:7bc0 with SMTP id
 5b1f17b1804b1-4a1d7611f69mr234416385e9.21.1792486659130; 
 Tue, 20 Oct 2026 01:57:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:e3a1:1a65:a394:be54?
 ([2a01:e0a:106d:1080:e3a1:1a65:a394:be54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2d324f8sm50363435e9.6.2026.10.20.01.57.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 01:57:38 -0700 (PDT)
Message-ID: <dbc27c68-4caf-445b-9aae-6ddf61bee7d7@linaro.org>
Date: Tue, 20 Oct 2026 10:57:37 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 8/9] spl: add UFS boot mode defines to spl.h
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
 Daniel Golle <daniel@makrotopia.org>
References: <20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com>
 <20261019-spl_ufs-v4-8-61432d0b258c@oss.qualcomm.com>
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
In-Reply-To: <20261019-spl_ufs-v4-8-61432d0b258c@oss.qualcomm.com>
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
> Add UFS_MODE_RAW and UFS_MODE_FS defines to include/spl.h,
> mirroring the existing MMCSD_MODE_* constants. These are used
> by spl_ufs_boot_mode() to select between raw sector and
> filesystem boot paths in spl_ufs_load().
> 
> Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v4:
> - No changes in v4
> 
> Changes in v3:
> - No changes in v3
> ---
>   include/spl.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/spl.h b/include/spl.h
> index 390d18fd9d5..0b2527ee90d 100644
> --- a/include/spl.h
> +++ b/include/spl.h
> @@ -29,6 +29,10 @@ struct legacy_img_hdr;
>   #define MMCSD_MODE_FS		2
>   #define MMCSD_MODE_EMMCBOOT	3
>   
> +/* UFS boot modes */
> +#define UFS_MODE_RAW		1
> +#define UFS_MODE_FS		2
> +
>   struct blk_desc;
>   struct legacy_img_hdr;
>   struct spl_boot_device;
> 

Drop this patch and add them when needed

Neil
