Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38987CCD193
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 22:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFAB3836C8;
	Thu, 16 Oct 2025 00:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="peHd18Sl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ABE28313B; Thu, 16 Oct 2025 00:57:37 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28FA4833F6
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 00:57:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7b97ce4fc60so49004a34.0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 15:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760569053; x=1761173853; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gh40DXMmjAnSFdljiYthiD2vw1FJ91lz5i+NS/H/JZY=;
 b=peHd18Sl1SbUuyITbnRWY+8u/FaQGct/7B8R5Jzwawr6ItNiaPKScAzAppzNfZ4yKm
 hH6g1bPJxoorHhOIRz5BIvwamna3Yh1wiCAi0yq9bDPbkYUpoO1M5BWzjdPn6DoQmtQI
 DKGQEzmiETLtRX3UwkOEcMHfZheFrtMSS57Sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760569053; x=1761173853;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gh40DXMmjAnSFdljiYthiD2vw1FJ91lz5i+NS/H/JZY=;
 b=v4cxFg8dvqkCmko5jpc3gOwr81FHgkgp/ryrGR+ovIHyN2tvXxSYDQlyQVB3rWHygc
 a2p/zrtBJKb3Q+54J5/dECOKJF619rXtK8bPPw550GA32N+NaVHoXZNrn9uEzSh1wHy8
 lmgqcBHg0b7ejVlvYrPBaOYKP6zZbN+SGtnhyHnpCaEKZl9PJVKgIWlqhC0cF2jsBXdc
 LwD7qssoVQcuAVu8CamgpXMB38fv6kyE+IdaogJUJo9SaJm6JpMTGsxH2KZHlUTklsVF
 TWC3Gw29D1iAKYjBkeY5NZVfQnmi/Yf942JiSLnxRqZXbTARL9TX8qLFWenjGySXQqE/
 rN5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3C375cGzMU/49Mp5gvkMF2iYNLiiNNpkscCLzujxdI2VZKxKA+Lo04wNyI6p2wAmd2tmR8nQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyp2CiQia3bSNINboSHbNyMZxCXpD8MqxOBV5YCDqJqEKpKN+oJ
 yrdEaV6ZyXWilXgJSq4Eu7eRH9ZWspjLbJ/hIEFKuUFERR8tRZDUak8X7HYg4tZdQM728YrE+AS
 BEGLlIg8=
X-Gm-Gg: ASbGncuSHAzPbedJd3Or1Cj97rT3zq2NnNb/TM6ov986Xauz5Uc/qov6mF5LbyeRDFN
 d3W4AOo75BjExF5UzWLCgPGDc1AzOXNhwHcw5Z+FthVV16ZVy6XK5unHzhW3AnA1YxSxqhPuKpS
 Sb1KFulnkPXf/QU4M18SVuBZugGtPCP3vyMvYM6byO0y9CdmckY05ek+pbip6a1EnZFwZago+yU
 swgzwHA5wQEIpSqsLBMzxpO0agmbxJsMf/udlBoSo6hJj5G6L27G9uVBd2QSl5nSVZmMmbmpiiz
 Hv9ZxxA3PJ9+e4igi58PNsMmGYdsQpGt0GgqLBnK9gwl/ZZIAruXT+06vFJLSteT+IX4fT4pMm4
 wqXMBoqvxbp13pcd6Ojlr8xwkmZJIC+nWz8HXlMnAL8+GT1rBM+SVC0fsr4tCZk8EzsMkujfMXQ
 35dzcu6BDbjQbguP47v7xpKxh/KTtjlFZo+Jvdiw==
X-Google-Smtp-Source: AGHT+IG5NpJlZEazJYpxsfbMZJZAzkT37Y1y1y4bAtTk9+rvFmc1Ci8f+MRet7EzjZ3aMlKE08dN1Q==
X-Received: by 2002:a05:6830:3c10:b0:753:8592:89 with SMTP id
 46e09a7af769-7c0df77742fmr21038862a34.13.1760569052826; 
 Wed, 15 Oct 2025 15:57:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f911af78sm5774854a34.29.2025.10.15.15.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 15:57:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
In-Reply-To: <20251008070903.370974-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251008070903.370974-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: [PATCH 0/2] fix an7581 panic caused by attempt to support
 multiple RAM size
Message-Id: <176056905171.760819.11282880095744299631.b4-ty@konsulko.com>
Date: Wed, 15 Oct 2025 16:57:31 -0600
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

On Wed, 08 Oct 2025 10:09:01 +0300, Mikhail Kshevetskiy wrote:

> The commit 726404a66c773 ("airoha: rework RAM size handling to support
> multiple RAM size") is not good enougth. It results in pacnic during
> determining of memory size amount.
> 
> This patch series partly fix and partly revert the above commit.
> Unfortunately for now we have no a good way to determine the an7581
> memory size.
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] arm/airoha: an7581 ignores CFG_MAX_MEM_MAPPED value
      commit: 40f57b571c1895fa077be922e2cd1345b27efe2d
[2/2] arm/airoha: partly revert support of multiple RAM size for an7581
      commit: ce175fa9f0e83c5df3ba7131bc4359fee3697354
-- 
Tom


