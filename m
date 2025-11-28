Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7FED116F3
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 11:31:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DD348452C;
	Fri, 28 Nov 2025 12:31:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H39s6bxL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 440938452D; Fri, 28 Nov 2025 12:31:13 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EC3584513
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:31:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c6d1ebb0c4so1100151a34.1
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 03:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764329470; x=1764934270; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uWb0NSLfIvJ3HgI1ZbQuacwSeVn2HhI5/7PPcUEIX1Y=;
 b=H39s6bxLUI17t3vlcDtegZfGaBpk+cWZemA7ba1frUM+H8GbiP/NOo5ZrylOEP4e4r
 jM2UsYnlEJjabk3SgsZoRaltiPoTZImdugKRIAEjkom4e5WusS7HTsE1JfkS7swTwCwL
 6YyBFlfWaxWn5tn7FKF8wTGWZae239eo3I8JDSry6Sfb3gzMOiuf60nLpP4vPnd7hK5i
 40h1jebrYWZ/2DFvbl8SrBsrYbbZpf4zCOsSEba1kI0VMpDQYlb+viZwsoymDtIYnJBr
 u7kB+Sj9tlYy7apRwOwHUcO0EfWsB6bstWoI2mrsA/9eHxqgK78ylDj4ITdCmd05yfYX
 NiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764329470; x=1764934270;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uWb0NSLfIvJ3HgI1ZbQuacwSeVn2HhI5/7PPcUEIX1Y=;
 b=BIMiN9PXJEVZlxbkjDnkK2BYVaFPup+lUCK5cXA3NwFf2c1x395ap9Vsb+V4PHl4bo
 k9oCumaLZfX7dLGbX6nt+5Mib8a+FKkR3Vrq6w/yWCGJZsiwRRoMzlHlBIq+cKBweyYE
 RBoUc7KaaBS+MhRKGon1Fv8J1tvQqWnyNfKw2ZgXpeRecMxJnaeBz+H64xBc7yYjMw34
 0+45QJ2Jc5NIbYRRkYzDIRHlioqGapakteTnso+5I9qKH06TqYzMvqtlYw6vlpOawuaS
 6q8015vtoA5PzAfF6dnWAxJawr/1+37JDV34lbbrgKKFE9YZlyO0jgw/5FWUMRhPbiMt
 dFSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRxnN+ab8G0g1rs8oC2i2u43gKh+4A4aeG8ribL4xDWWD6sbCVJTYxGRDSaTqj/Is+FPXcEcU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6h7d98SKIwKRT9H7Aa0r9qbqSgjkOzuXk1wl/r+8ys/04bcO5
 GZyc4OtcHvin9KV+Ir3xUH/W1vp+ypdR++uO0QLfVE5qIbRNNOibJowxsOVSKkaoHnSkirrOoPF
 qNfyq3bc67g9lPVS4mRe5pUwWtZzAaJ0=
X-Gm-Gg: ASbGncvIFT+Y5f5tJgBFNlr+NI3MhoBK238u5weP/K3QU7CbAjURDla4HXHVLitZLaL
 85q4rTxmNPMSRGymTqr6l3FMTWib5xH1c/bWJHyNJyBS6F7lsfW4km0Njja0EnxOq4Gnn4zHETH
 /kHM4SF+WfJv+J9uUogEMsHF3i/cEorU+Mw4kZz/pMYPjuJpPttMFCBsRPCntvZljMcp9xzYbws
 LfvSzXoVpKn4QYhfZ+N0A0M37h2m5CqPX9LBDGd+Heg+abzlay525m0X922ewvw4e0xSGs=
X-Google-Smtp-Source: AGHT+IGW996Ws5SXA+aA/jkPn1HDv1G5cJWMtwQhYNgkS+nEFbLMqtbVk1VyIIZuWWJe3Q1XCg1eD2NW536AE1qaF4g=
X-Received: by 2002:a05:6830:6f1f:b0:7c5:307e:3d8d with SMTP id
 46e09a7af769-7c798cf3f9dmr10481210a34.30.1764329469650; Fri, 28 Nov 2025
 03:31:09 -0800 (PST)
MIME-Version: 1.0
References: <20251127192136.168-1-briansune@gmail.com>
 <1d42f643-41a0-4a16-8269-5bad7bf8953e@siemens.com>
 <CAN7C2SBQOCtCPyJA5+HXd4CU14eNKxkj+GQPCpf+GRsXoAPN+g@mail.gmail.com>
 <66810c5a-f589-42cb-ab11-b692217dd235@siemens.com>
In-Reply-To: <66810c5a-f589-42cb-ab11-b692217dd235@siemens.com>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 28 Nov 2025 19:30:58 +0800
X-Gm-Features: AWmQ_bn5oQeovYdoAHriNVkc7FFmYUzlyr9wDhpNfMu7FuSY2Zu9tvj0A3McvCQ
Message-ID: <CAN7C2SA7pHy=VKPZGjp280p0pbp5cDeFpW3OboEex=HqtBWKPg@mail.gmail.com>
Subject: Re: [PATCH v1] Fix socfpga GEN5 boot by spl+u-boot sfp on RAW
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Chee Tien Fong <tienfong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

> I read it, and I also disagree - one fix per topic, and there are
> multiple topics, affecting particularly
> SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE for any board that may want
> to use it.
>
> I'm happy to take comments bits by bits, and I'm also happy to drop or
> modify patches if there are better solutions. I'm also fine if a subset
> of your current patch will go on top of a subset of my series in the end.

This is ONE fi, fixing the RAW boot. splitting file just for reading
purposes and nothing to do with this patch.

Depending on files are must and required to work properly on this topic.
Splitting to different patches for other topics does not fit this patch topic.

So you will simply delay the entire patch flow. For example include files that
need to be fixed due to other functions using it. One topic

Then for include need to run properly Kconfig change need to change a line.
But then due to the RAW function then it requires another fix on the same file.
You can split each line individually by a topic.

If any one has issues due to unreasonable splits then do it as you like.
I can always git apply after pull and remain this patch offline.

This is why reading your patches are confused somehow on some topic.

Thanks,
Brian
