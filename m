Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6E3C3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 13:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79F1E81E06;
	Mon, 31 Mar 2025 15:34:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vC0DGCUf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1743D81E47; Mon, 31 Mar 2025 15:34:53 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C806C81F44
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso30133885e9.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 06:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743428090; x=1744032890; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tOEFFePs0ZtCAxKHAL3D1k6jLG8wfLc8jhMHMQYjAAk=;
 b=vC0DGCUfIihu0iHKaJ+AfHK4dgwlo8Y+//28NRYjvoawBQJV8gdnhJ/3jnACiJAZ0J
 K4BnUgahtvQI698B7Dj2I6/YNxTeI07kEZYR1FReUlIRk+TpPYH/Pw6Dwnb0rU/n07Bz
 HmUgeN2zDv0rCo+zhPbanMNsm9BctKzUssMhM/sO3x/9aPOTg8Zj2DinLVKBCjiC/sEl
 wGs8Qrht3YiJpqRKYLwx5wWww9kFkMp7AikxEO/mE4vNNwhrtevdtw9zArweSr1Z3Ox8
 pVY8NWLkMljA2SW8HKPqBU4LCXf69Y794GzZg62+BVVqR1Kz9XHtpcNxioJX/M88ilDp
 q5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743428090; x=1744032890;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tOEFFePs0ZtCAxKHAL3D1k6jLG8wfLc8jhMHMQYjAAk=;
 b=ZZLTxG2oFWhEVKVTqH2zk3grSdpPhdPr5a301MiUqvjCPQWr4yeHcJ9WH/D7U22j8x
 ZZp049HrtufmfwLD+0nqYdl9fbEh0anlXK73S06M6qN3X1JpIvVn3Ae70da0mAzkqNet
 cpsMl0HMGvOcepPkOY/q7vq+RHd/z9k3q3gtmJXkd7wjFAD6sr3d6uN/fG+kv/db/ejG
 PCuTpQuL2on9rTo6+3kJudC/p/8Z0/wPbcdj/jqJu2KtRowDlMluCihVqvLG8HrGTpJd
 MPIhBKa0PycqFD2EAGityHJcBKnJwU4ZjH9VUfJE/V94oyZuwwcacAtg4g0w8OOaERlh
 s0kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHUBh1dTLGVuHbvLM1sPhhOKQiGKPhWjC3U+j5cWONYCFLeOwgVFzMi3+aG/Mdf4w15vDbR8Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwzRKAfzZXNK2khpax1FUPCwTinRU8RdbfDVAc3mBvKW5OCp36O
 ysAyqk+q2Liyp/wmBXQojlcvX3rqaMyEBHjD8eJwIc2Uh/Tr5JkhpJEQGXq0UN8=
X-Gm-Gg: ASbGncsjbldvnbHbEsa6EcArT4UM6wDHNc/LaEldlQ8g/kRrZIH/AZeANvAXjZ3uWTs
 PB3INLpINjFH3Wh7ttliDpC+3nvMhyLdTxycmmUieM+9QUdtQQt87pMVNvi8NsjJWRJCuayXhKL
 7n07yCrBMo9YVHY8Z7Zn4bz7CwaPYCzK8MfriiqJl/eQ/lDrfqQFKZ2TBHZVus7i7pAzcrU/T16
 W27Bs7927MhTSOJEcLpjf2JxUCRtR6LqOpQRgH6ouNwnbamrDs+M0BPFEDp0+8k6fshHWiwLNrd
 vMteE6p4kI2qiAwbpND9lYZvc7kvJV4Yk08+ZlxEMUDJwkYZMwwhGuhOZgQoYJ61u28IsMNnVek
 f/k82dq66Q6Lm
X-Google-Smtp-Source: AGHT+IGdbhKpj6JrU4PpDw7XPFCR/hK6W5bAFLqTHAh9EXal0jpdaiMdMgAlWfercwzYM/Pd58nfLg==
X-Received: by 2002:a05:600c:3d0c:b0:43d:8ea:8d7a with SMTP id
 5b1f17b1804b1-43e8eeb6696mr52057165e9.28.1743428090273; 
 Mon, 31 Mar 2025 06:34:50 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82efe389sm164266095e9.19.2025.03.31.06.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:34:49 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: jh80.chung@samsung.com, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, trini@konsulko.com, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <20250324113030.2597986-1-quic_varada@quicinc.com>
References: <20250324113030.2597986-1-quic_varada@quicinc.com>
Subject: Re: [PATCH v1] regulator: qcom-rpmh-regulator: add support for
 pmm8654 regulators
Message-Id: <174342808883.411395.18250992625236748039.b4-ty@linaro.org>
Date: Mon, 31 Mar 2025 15:34:48 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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


On Mon, 24 Mar 2025 17:00:30 +0530, Varadarajan Narayanan wrote:
> Add the PMC8380 regulator data found on the Qualcomm SA8775P platform.
> The tables are imported from the Linux driver.
> 
> 

Applied, thanks!

[1/1] regulator: qcom-rpmh-regulator: add support for pmm8654 regulators
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/b59ca233b903

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

