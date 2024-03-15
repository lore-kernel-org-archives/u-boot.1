Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEAEC54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 12:19:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF7AF87FE9;
	Fri, 15 Mar 2024 13:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HjrrAz7V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CC7187FE3; Fri, 15 Mar 2024 13:19:17 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56F7E87F3F
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 13:19:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-789e70d7c07so23443485a.1
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 05:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710505154; x=1711109954; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rg1/AOUbeOyy6UmGkCJylAC2IC9u4O1NDpblMdYeHOE=;
 b=HjrrAz7VM9M7pUy2Adnxc4QuTghpzmwmOg2qYA20ey9UlYI0IgRfcMTg5N5mMGn+hE
 oqudQFq7dGsGHX7ezDU84z9q1N0I4soEezq/sgPy0WGh85SKA4+up07QAp/DVJeqHrgW
 y3wtdk+AMk44XQPrn6nDpW/11CssG0w4vcJ4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710505154; x=1711109954;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rg1/AOUbeOyy6UmGkCJylAC2IC9u4O1NDpblMdYeHOE=;
 b=mRAhF0QuhbHx40jc9XFn8aoSpO3IVvHfabOBj1vnlV3RHCRLJc4uNoG/actAzKM/XR
 a7g9TXeCZTbbS1wZI6tRoyBkE4FEYKX9cu8/9vl7RpZnZg9nDIDJKTPLKOxPpd0Pfa4G
 4Vi9137YlV0HdLfmESGSDUwF33bfZTffOrhoEuxQTIPeWBjI1rjnmiBowNCuRyOy64xx
 oKciFyyxhUhFg3I6hO7vzszsUIDoImX75zZK0x2ggYCgwgkVyluNYoeSqvJIwlVpfUZJ
 f1iuR/n2gMzNOrzAIPPGrSoZwpEXSnnjWfbHK/89uztnPV39ZxQ4a6Z277NK4nmYzgd5
 nUjQ==
X-Gm-Message-State: AOJu0YwzeMv2bx65g0j/Fz1hSFSHb9PeQPZrp2LarBP8+PAhEZDVO17Y
 mYiRu1bo+A3mV5esTL37RE6as2+bop+2TxBFvM9K4M8TSbacwC4oqpq8Fcakn1z8kSd78gKfpxq
 o
X-Google-Smtp-Source: AGHT+IGb5fH9nzguz4HuUBUkofiMhTn6fG+TQaExYdECLcjApgoJw/RJxNlJ+L7u/fjgVIbVd/drdw==
X-Received: by 2002:a05:620a:271c:b0:788:136e:e2e9 with SMTP id
 b28-20020a05620a271c00b00788136ee2e9mr4331410qkp.34.1710505153953; 
 Fri, 15 Mar 2024 05:19:13 -0700 (PDT)
Received: from [127.0.1.1]
 (2603-6081-7b00-007f-0000-0000-0000-1004.res6.spectrum.com.
 [2603:6081:7b00:7f::1004]) by smtp.gmail.com with ESMTPSA id
 vu24-20020a05620a561800b0078874565b40sm2009011qkn.30.2024.03.15.05.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 05:19:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20240311140243.2008537-1-trini@konsulko.com>
References: <20240311140243.2008537-1-trini@konsulko.com>
Subject: Re: [PATCH] CI: Cherry-pick reset support for m68k for QEMU
Message-Id: <171050515299.774434.12807410214514210885.b4-ty@konsulko.com>
Date: Fri, 15 Mar 2024 08:19:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Mon, 11 Mar 2024 10:02:43 -0400, Tom Rini wrote:

> In order to support the reset pytest on QEMU on m68k platforms we need
> to grab this change from upstream.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


