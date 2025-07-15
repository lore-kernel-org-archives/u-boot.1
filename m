Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EC7C83F22
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 17:20:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA605830A0;
	Tue, 15 Jul 2025 19:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WDFjtBjd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A090A801BE; Tue, 15 Jul 2025 19:20:25 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90CEC801BE
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 19:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-73e58206ac1so349151a34.0
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 10:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752600022; x=1753204822; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W0VaioHUcIrt2r7oMa0om8N4Rn9DjyPKAR9xUmG07F4=;
 b=WDFjtBjdYgVhQ7oRvjhSsfR7+BCH2s/0nCn2C72Rc08yl2U+/TygSmT5xJ5+pvKx5z
 S7GSKVM+MndWu+Ei7DaGuwVvFNa8DrQpkbGrKeuqXWb/xz/tNoD5r1rl3bn2pDvdiiy6
 RzatwGmljZmGXSQaO0gvueMCv6yxqxPqIektc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752600022; x=1753204822;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W0VaioHUcIrt2r7oMa0om8N4Rn9DjyPKAR9xUmG07F4=;
 b=BwxB7NeUc63qSU7AGEIIJxF/XRKJmtuHHN4w2oGeXNwMVIHt98rUj/j29u/agf/A45
 gbNDcJnieIuKn8LhwTdsSJdI/dsRYWiIp1acENQx4Y8WDsxq5fnsF3psDa9m6JgNK4DQ
 KDYv7BqmmK4MSlmcs7TANTrBxBeSiZWvHMwwJMNZgT1EXgo2kn9pq0T6HfuNiN6CO5s7
 YufHrB8H7VQTER8wyuzJ0mlY7v+2xH9xIj6PLsLthC+axpDBdN+XX6n/eG3TeZGs/Etz
 3b2CHKZBOp5HAJO1agEKI1H6yuSCG6h5O+4ggtxNXsnEAkWv2Z3mKcSWlE+bsxZ7CwIv
 nJgg==
X-Gm-Message-State: AOJu0YzbntJhFxEU/LuS4WFSu0X3AMk3fR9TVwvjqX0wL3SVX1rMs4is
 w8RySwETzWx4uMSAm+ivPY24HeEk6O2pery+MJLzFXQOCdUBqq3clwSO+DEAxeBJOUQ=
X-Gm-Gg: ASbGnctVDie4+UGEKbjpDKt4fWQI7ySX34MxFggyjfqTEZVmuIWubuq5dPvwZ2e+u4g
 2lG1i15kYYEeXDLabnHRtBQEM/fdrehjcRFCEidY5eMpDQvKM/XWoHw0C+yA6J+9Qwk3/ib+swj
 f5ckSqS6hur1zi1R5TAAnT9uPCNP8Q9NTGbARVi9P16mFOn8XKlr7DcO5w1A7OSWqMcU7lyV9hW
 sYtwV1vAqILbWDXIbobPfMllKpcdF7IOK+Q2RxG42kw0BNuFGHsimJCtTCLmF4MulUTYG/QTpwS
 hr1b0honmy652vkIKG/qO4svRa3gnrAzT1qarDiLejVpdY/Plb+vmR6zLe4XwbAlQ03BR+L8gjN
 9B9dA+EzSDCzPI1oEWjPFKCvbAqfqhZSyZNYuS7wQzShR9bNs0MKSwAM=
X-Google-Smtp-Source: AGHT+IHzP7cEHu/mYkSI6HGPIvVJHL2q5vwTGMkGRtrzDTPjROUlMj/bPf05ztgKon/7am1l4La+gg==
X-Received: by 2002:a05:6830:2c0c:b0:73d:baa3:830b with SMTP id
 46e09a7af769-73e649f7a87mr208553a34.7.1752600022174; 
 Tue, 15 Jul 2025 10:20:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6142b0961fbsm988894eaf.35.2025.07.15.10.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 10:20:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
In-Reply-To: <20250708100707.89070-1-weijie.gao@mediatek.com>
References: <20250708100707.89070-1-weijie.gao@mediatek.com>
Subject: Re: [PATCH] net: mediatek: correct the AN8855 TPID value in port
 isolation settings
Message-Id: <175260002117.441891.11694532561355921805.b4-ty@konsulko.com>
Date: Tue, 15 Jul 2025 11:20:21 -0600
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

On Tue, 08 Jul 2025 18:07:07 +0800, Weijie Gao wrote:

> The TPID value should be 0x9100 instead of 0x8100 according to the
> datasheet.
> 
> 

Applied to u-boot/master, thanks!

[1/1] net: mediatek: correct the AN8855 TPID value in port isolation settings
      commit: 70db2be9fbae747a869ec5d7af1055685a9c01f3
-- 
Tom


