Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367DDC3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 13:35:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE33381F44;
	Mon, 31 Mar 2025 15:34:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rnyFcL5B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78D52819D2; Mon, 31 Mar 2025 15:34:55 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3252381FDE
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:34:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso50124305e9.3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 06:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743428092; x=1744032892; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0KVgrhWl0/FNo65RvMQmyueR9qs/53fBCWHKy483Ioo=;
 b=rnyFcL5BPb6U2tV00PTNVwgQ+bRuKW6JEy46VBXLogJvU1Ku2OlJiTVkejPCwUgyHN
 1qV9+QxR7E18CE0qTmuCtgQ6Exj+nBmDBlw20qFsfD5Hu3BOU01xWzHHt+eDPmm3SBQ4
 XRhj79zk2yg0DRQmNtiBJA0dtx/2lSQjuNRz5R+K2ftWzp88JKkii3f61w25/Ooq3HAK
 vdpsm2BumWYcUygEpPbNqPjBtazKKIHaa+o6ExhyvsAATi5y3wGSqw8Yv4MRNUvHnTiv
 qNRssexW9iB5SkMJksClEo4sCmYEJInK7lZfDwmBqfEktBlnnj/Zmb8CTKJ5Rhab7Q/g
 cR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743428092; x=1744032892;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0KVgrhWl0/FNo65RvMQmyueR9qs/53fBCWHKy483Ioo=;
 b=mWZnASlTWX390AAU5XwSUaaeBa0/dsO0lQbDqdIaEVVsjCzqWZfpw+ePIb1WL5IkeB
 dDTBqpZ+nzPdBUjO/CJ/Deo+LTnMcAzA0EW7HrEsN2wExfQ9q7CNswsn3323eBM/2AQw
 bHxRYlu0tKgPYoI8UFTYpCky0LzUffeqeaU91ZIhvxKn505cgim1zVoIUQwJ80s9fWCM
 Gf4Iak19l+QSR6ID/l8lo0SKz7Sb1r/pcZ3EXz0+O1SuU80M//m03py/FdZ7kzx3brQw
 +GUYJ/qrrHCZnJ12eQi/yQFmZEysLt/l+njs84JmJEkcW3z2GftUc/K11fV+0oMNhuig
 483A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLcmB27LwloHyfIZ27SAAV06fdOQIngFCXQlgohFPMVN+db/iZ6SPcpNC8aIjHLH5rX/0v3Zs=@lists.denx.de
X-Gm-Message-State: AOJu0YxN+XlCsJaufHW74deJVMDTVtH0ZfSXouOhwNOWtaV6rLmTXQaD
 tx01Ku2hY+WoPof2HmK94lxGhD9Yh8olSFnEaPUxxkrd1a+O7YypSfPUtZpmUzc=
X-Gm-Gg: ASbGncu750KC81g+g1ynlnt0flRzpMFmuWAcwxJorfn4f9NbpSHfJ6HF0ZXjKdzcrpd
 15l+2Ds3xVD8Mp1WyfQi2PnzjAoEtGpuVZYgtrYz62O6qp8IjWTIkq/R/+VCSwN2NkAcvBoj3vi
 T4Ju1aV7KsKGYY7YkdVWE5h5a1KFRXRIBaxYyW7TYCpPZLv7J9xhgjjO6Ekl+EQhPJdJYagGwA6
 5HJxQlZppHd0hJVI226sBKtf104NYRjVFrJApGTJlgCVl1Z2IM3AT4MdMvwIkpv7+KfxwMoY1+E
 yF5qkLopSKXwFCab6disOctq8uRWLgYN9qdhfNjUViyTPuY4l60OQ71JFscuJ1BurB3bWCw07/h
 tAppiFX1Rdop2
X-Google-Smtp-Source: AGHT+IHUQP7dJ8Jd0JCeD5qKsiZq3Vs33qR9x3xsG6fAaRWgEXyk+TfMxyOwZTzoTUYu8xmZcjmhFg==
X-Received: by 2002:a05:600c:1d16:b0:43d:49eb:9675 with SMTP id
 5b1f17b1804b1-43db62bff8dmr68988345e9.22.1743428091671; 
 Mon, 31 Mar 2025 06:34:51 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82efe389sm164266095e9.19.2025.03.31.06.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:34:50 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250328-topic-sm8x50-spmi-fix-v1-0-a7548d3aef0d@linaro.org>
References: <20250328-topic-sm8x50-spmi-fix-v1-0-a7548d3aef0d@linaro.org>
Subject: Re: [PATCH 0/4] spmi: msm: fix pid mapping for v5 & v7 controllers
Message-Id: <174342809036.411395.190467317879491780.b4-ty@linaro.org>
Date: Mon, 31 Mar 2025 15:34:50 +0200
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


On Fri, 28 Mar 2025 09:53:20 +0100, Neil Armstrong wrote:
> The v5 & v7 controllers has complex mapping for
> different Execution Environment, and v7 supports
> two busses within the same controller so it needs
> some special care when parsing the hardware map
> table to get the proper read & write channels.
> 
> Test are welcome, especially for v5 controllers.
> 
> [...]

Applied, thanks!

[1/4] spmi: msm: use real number of channels for v5 & v7
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/66399360db72
[2/4] spmi: msm: factor out channel mapping for v5 & v7
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/d2f9f2ce5335
[3/4] spmi: msm: introduce SPMI_CHANNEL_VALID flag
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/7706c62fcfa7
[4/4] spmi: msm: correctly handle multiple mapping entries
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c03a52e82616

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

