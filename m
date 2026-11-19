Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FB8606A331
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MdCBDFGa;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=jk1K9p+E
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18D2F6072A;
	Thu, 19 Nov 2026 21:38:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j31aaBJWjDuc; Thu, 19 Nov 2026 21:38:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 746F760E1C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795124299;
	b=hD2+yNXDF0pGEVBGmFON4Ar4/GzqgCN3m9HWaeZ5jSJRVGY5XRw8aUkZpPcBnTEcn8CD
	 SL50JMGiO0IuNG45Vo2G+LL3E0m62DnRIbNYUKR79qtOZIzOFvqXQ5pk21cJNk0yrNVSr
	 vC/hO01r+BVeIEnQmhWsUNLxc1gYvn5NDSrVoHLGeBUVNNu2DjrBGCe/6V5wURVWignww
	 7g2ULwn4j5lElcnWepujSbp0NWApasIHk2zC9rOqsbry9ujuyuWKpxQrkzrw8aXBHphe/
	 tIrxBkStpBUUnhcmPTHz7mgF8zS6sUggjAdXISSU90ME279WTXcSdEbtDXvya/SIrgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795124299;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EkeTv06EW8EDbd8sXMkMeKKMcPGC4g/xyj8y5StLC8w=;
	b=LiM4au0aKirtj9GkMknqChF0NO+hgven3TWtTgmVHSl6bLmoBHf4XTINUoa6mLamQBJ9
	 U3dgsqMW9Sdsg7humxpohU/lAM+nSP1Nhn1IO/mS5k8QqW64Kb2Z2240sC+ieK+SMCHln
	 N1yGSLN2sG84XsGxoYjfljjpclFXKMr7c70ihcxyibwh6Z2t/pN1UViKj3B+hCnLrtYqj
	 fkKz08HJMgjZYlSzWn18D/P2dEAeb8AFEP4V6PMWjZReP4s+hZ9lpCvUC3cFMKTn4dy+O
	 KZ1rz1AAgKJ7G4FfElgpca29+r8t5pDdFT5kCF2rVMXmcAF0mN2ICbRAUASnM/qOGeQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795124299;
	bh=EkeTv06EW8EDbd8sXMkMeKKMcPGC4g/xyj8y5StLC8w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MdCBDFGaZn+XSNvBnZhO3ry3A9hNg6EgBDU665IAmgqMoynoAP85AZ7jmat2V9KP0
	 xpfbYVO1oLJ04qRTzsxgSCSiyMI/zHKotEoIcn8Ny2wIBJ+75hTfKyiEa7Xwp/YD/g
	 GRyIZWzaqw4kIyA8GJX7eX8cn7GWAGYCGmNwRLKwYxS8LXk9Bv+xumgoFnVuU5ZbYf
	 XtOIyCz9RE3fW4a8zaPU4VDsoXCb1ZG4grMNPBJPpnLD4/PrOD4AtXqt4ngAn6rBHk
	 YFxQ6h9MHXGcxgyxt62D52ZKX9h6Dw60R2VqwhzOFZY2d+mMW0pSecV4+rnDg6cbAH
	 K2UC8kulaX2vA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 746F760E1C;
	Thu, 19 Nov 2026 21:38:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 387212F1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 21:38:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 29E4640DD7
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 21:38:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id giXzCE6NRIky for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 21:38:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 76BC840DD6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=jk1K9p+E
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 76BC840DD6
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 21:38:16 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-862bb0a189aso115797a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795124296; x=1795729096;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EkeTv06EW8EDbd8sXMkMeKKMcPGC4g/xyj8y5StLC8w=;
 b=jk1K9p+ENg88b2BOVVI86sYFsuvm/i7/MMeT+XCQbMGn3/xA6sxrrJHfPQw5NgVn6H
 1CoyTItcoXCpdYguRUW0OFcIwVlNmijfTijRGAWAp7m2TFrzgRsKuBgCJQ61APbSGtqb
 SnZj74NLBIOjc/29baXTSPUgObP6GSpqhfVKcYaNLY/uh6n1eXByojBlaz9qc2NcbVHI
 Bwx/tSlZjiiQBOnsfai5dHtGKNWDB8V2AOgNP0bhRV52QrdLYzd1UlZqmR9yPAKXvseN
 G0FtkwMAzSBLJiSAazunYB7m+pVZLFXO9nVG9dE2Q11HnWXV6Qoru+jRX4xZraF/dCLf
 8VHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795124296; x=1795729096;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EkeTv06EW8EDbd8sXMkMeKKMcPGC4g/xyj8y5StLC8w=;
 b=g29G7Jrm6bb7jsbzvtjc1l2zhZzbGP3OwZv+o9j8YgbgNbGIKCNIOwYzyKVzb1pVLm
 FjyeyVYcroie7Cmagr/aY/UJL4dpcKJENe5Fspv1m0E7Wjs+d+y2NH88axEM+j1taz/K
 sTVoA19sY/HrX0MSk91hnkTCnMHZ2SCo+u8GqdoMwQ6s6Rx8jSqsKKSq/WjKh+9tgyTP
 bvPEDP4Y/qTmU828T9WPiUq7nFq9Zut7vrMhNSd3m4JQKCiKU7B6yVDghPzRYuH+ZJIy
 u0mL69g8FqkbfUe6SumPqF20I79ZqvEyo32RAlWr4xKE0f+h+r0vdSSvQfjWagWJnkK1
 ckDg==
X-Forwarded-Encrypted: i=1;
 AL+hErHbldZRNXy6g8xRfh/9hPbfzun4cCszHeWz10m6Xo3kGFXH/4+U0H/ULO9NZXGjP7f2WL7CgKc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/ZVF253+ZCt37XeArPFJ8qpB89NQUxTZEfdYkLKEiKUhX/qjx2
 qaaOTAL3HKQDs4qjmnBxuQ7i214/Whb1q0UtWHgTAiP2M3F0JZn3Ews+DyKJNlZ5Fai71CmsnRa
 HhoWE
X-Gm-Gg: AYBFou3Xvmk2lVraeqrPCqwxSG7Os3diyFcBlF46ns1nUZZ8iHjyWEUUIezCvG07hvu
 OlM05jlxWrLuOS4O7D6N1DQHVgOIQOwbB9I5C7cVOT7vENNX/9ZHzphfNvojol1suprrMx5WAtn
 mZ0qWvwNGPMDntJKoktYz1haFxgaNxa/uXAARTolw82nN/YQDLewyGkPvLpkx7OhpUW3ZMaLuOG
 AOYH6GHNYfu3KroMa+YEk1tah+Jr9gS5qe6rPGrAVkXCNZnyb/o31QtF4YtLoNSfS7uz2IY5MDg
 pkZWiE4PPH1Mdov2cCeCsSIBFN8Xnc+oOAUnxq3V4Zp/+0C2gt7gD5M5edxCPLPA9PxIXHgSeZ4
 KiaPB/326WAFCLne/3AI/eme5sfGandwmN9YvtuStAIW5drxmLqUr4NmDxfAYST8VAzisgDmss6
 v0G7QAwxQxZh7HGLPiaSmHsUTjR0gpG7Yg2Z6/gl7nW6mQQHsG0Avw6voeDmqsg6Q3XhxQqJTzl
 W+0U/RxiwHj/1m4GH3uQZ3geL51HVDTUVUfNQQkhGQJWSdHmxvcuorxYxOg00pZQw2Ql1jEJ5OD
 aDAtxI8ySn9kaWGzxih0+p2FsvYFaGyxM66lSVEK0G7YJAJ88iYcEnrwEwvnCPm1JX1krcnIvT3
 MZt4=
X-Received: by 2002:a05:6808:1915:b0:4f7:867a:1136 with SMTP id
 5614622812f47-57a0c7bef2emr1819499b6e.64.1795124295986; 
 Thu, 19 Nov 2026 13:38:15 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:43e1:bc37:7497:58db?
 ([2600:8803:e7e4:500:43e1:bc37:7497:58db])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a35655a5bsm545955b6e.13.2026.11.19.13.38.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 13:38:14 -0800 (PST)
Message-ID: <4cb7bb8c-e562-420b-9c92-8e24ba399360@baylibre.com>
Date: Thu, 19 Nov 2026 15:38:12 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] i2c: mediatek: align DMA buffers and handle 36-bit
 addresses
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org, Chris Chen <chris-qj.chen@mediatek.com>,
 Simon Glass <sjg@chromium.org>
Cc: Heiko Schocher <hs@nabladev.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@nabladev.com>, Macpaul Lin
 <macpaul.lin@mediatek.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20261118-ccaione-upstream-mtk-g720-i2c-v1-0-916dd6cc8d1a@baylibre.com>
 <20261118-ccaione-upstream-mtk-g720-i2c-v1-1-916dd6cc8d1a@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261118-ccaione-upstream-mtk-g720-i2c-v1-1-916dd6cc8d1a@baylibre.com>
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 2:29 PM, Carlo Caione wrote:
> Use cache-line-aligned buffers so DMA cache maintenance cannot affect
> data next to an I2C message. Program the upper address bits on 36-bit
> controllers and reject addresses the hardware cannot reach.

Using cache-line-aligned buffers sounds like a fix (with Fixes tag) to me
that should be separated from adding 36-bit address support.

