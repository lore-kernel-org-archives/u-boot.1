Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E868C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 11:14:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F90381FEE;
	Wed,  4 Jun 2025 13:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QtUQKFPn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F87682B07; Wed,  4 Jun 2025 13:14:36 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ED3680F9C
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 13:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a367ec7840so4701757f8f.2
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 04:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749035673; x=1749640473; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5dGG6edBfY1EOBp33nV1wsMr7MLOPvGgxZHSuE46qsQ=;
 b=QtUQKFPnbfB0+0juUFqEWIaKb/j2nJEhwA1V70z3qnOWv1nIKqpYjosyz/24wS/ioL
 ukpuBTLKOJfU/SGNq6F++oCQ17VgDfvS73WpZbBCbaxLceeh5sAcCeL+/KPPsvpReAkm
 CkYAgfwn1eY6q1qLNp4rgJM85gE+wavdLlad9diTv+aNUKgqC/4T/1SoZ/NUCoGIGE1z
 QjzN41qJGcdjlcWsEapLzmKMUYkwsUMhzOzVHYpCL4kGgaviBifTQayCfSt1hmWzAbTA
 ++rug5Qil6Q+CCeH+Zed4AGDVwKAIMq6epeu4y0txz3VQSvN3c6hk3bke/yXb/P23665
 ANJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749035673; x=1749640473;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5dGG6edBfY1EOBp33nV1wsMr7MLOPvGgxZHSuE46qsQ=;
 b=BarPlxmWvyRy68YpnoQOhsBCpHha8r1KzjWw32NutAfVjJx+RBCiLgWS5xoED9U/9h
 1PnbvqGHCu8igJWZUxkB8iR3Zw79gZt/nsIPAJDiw2tpjIUhF7zzICUjD89duPCnhn05
 OWNIZ4rOwnJb8iBF/nP0I64qjf0Ch7eE77yP0aNP3oA4jA47dsdNOc56tNCgw51mvRsG
 jE2nz5OvY5UzJprYfKDvi1uJb8xyzQvtkQ751SbE1Fruq+nL31A2ch6mP4G+w3fMFIYP
 gYQEnYDYRe55fyUdseu0dtNMEfpq3njnljYql73aFlQfoS1PZI6wXrDsGktUuPJ+asO5
 vEzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgEPr4gFb1fLGuBDpJeY3ImlG0J3TCBzBDyC14NdePwoF1n7LZXMwmoTAVXsOeheS5iOtzCpU=@lists.denx.de
X-Gm-Message-State: AOJu0YyMqxjwSEhMIID0KTI9FnpRa8YeBiypwR9mzunB9m9WgGF9CWV4
 NcdRgeDuuMhDI9zOS35hK88YurYpXywZ6HrFFdjygprsMcuO+7kRELKENkRdFXhoh/w=
X-Gm-Gg: ASbGncs3ka2piB7PhjxobOTYkWKPkAsTLw/So5qPuxXSpj7OPOZpmnJdTtk3V+G6Cz2
 0+m4yVOK9bsbKGq3gzFH+ry0+sEVxaGGu/OkRI1fDX3Q8wFFRHVVWwRDbesNAmWudN+b7q1bP3L
 A0/+K3R5N1Az3YiZ2DkUAdu4LwugWquX4WfwuxB8JXepXj6zk7nq7RKgdeWEMX/yvY7y475nrRB
 YLk9Pm450FaPNofFh5XMhqMxUL1TiWVEpB0qtd7tlfL6EpV9VjJ/GqmAezCZgeUkjnQg+j2un9p
 UkXDfF0bzulEJGP7uG10wMCnkinwbZXn1RXJfWiNf6mcyKQwuKEIk4FZzFL4NCOaFDbY39I0J9J
 YUOnOhVLPAaSlOzpTnfljpK5Xrw==
X-Google-Smtp-Source: AGHT+IE0ZaXsr2c3cmIdLZkD0wPvqjlDry350RRoSTwFx+y7HVqzV3trUfmh9kTjKtjFLMywEHrI6g==
X-Received: by 2002:a05:6000:18ab:b0:3a4:f41d:6973 with SMTP id
 ffacd0b85a97d-3a51d91b9d8mr1949559f8f.13.1749035672951; 
 Wed, 04 Jun 2025 04:14:32 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:968c:2df3:c75e:5a31?
 ([2a01:170:117e:fc:968c:2df3:c75e:5a31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009748fsm21115303f8f.80.2025.06.04.04.14.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 04:14:32 -0700 (PDT)
Message-ID: <faeaffdc-cac1-480e-b1ea-671cea446a2e@linaro.org>
Date: Wed, 4 Jun 2025 13:14:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] tools: add mkmbn tool for Qualcomm
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
References: <20250602-b4-qcom-tooling-improvements-v2-0-c7d19c0d4a8b@linaro.org>
 <20250602-b4-qcom-tooling-improvements-v2-3-c7d19c0d4a8b@linaro.org>
 <aEAOoYg_wFvkI66Y@linaro.org>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <aEAOoYg_wFvkI66Y@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Stephan

On 6/4/25 11:15, Stephan Gerhold wrote:
> On Mon, Jun 02, 2025 at 06:10:54PM +0200, Casey Connolly wrote:
>> This is a fork of qtestsign[1] with modifications to integrate with the
>> U-Boot build system.
> 
> I think it would be good if the "library" part of qtestsign (cert.py,
> elf.py, hashseg.py) would stay unmodified if possible, and you only add
> a new frontend on top (mkmbn.py). This would simplify syncing upstream
> changes in the future, e.g. should the v7 support get introduced at some
> point.

Ack, I thought about this but way too late...>
> Have you changed anything meaningful inside these three files? Copying
> the original files back in I mostly see re-formatting at the moment,
> which makes it hard to see what is different.

Yes, I made some changes so that I can construct an ELF header out of 
thin air, since the original code only lets you parse one from a file.

Sucks about the formatting changes, not sure when that happened.

I will open a PR to qtestsign adding the features I need so hopefully we 
can keep them aligned.

> 
> Thanks,
> StephanKind regards,

-- 
Casey (she/they)

