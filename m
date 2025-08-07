Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B1BC87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 22:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA7808469C;
	Fri,  8 Aug 2025 00:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XYroMRTq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5FC083C65; Fri,  8 Aug 2025 00:34:37 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA96D83C94
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 00:34:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-61999e5fbb1so918374eaf.3
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 15:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754606061; x=1755210861; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHY4L6ucwpfFSzbmiMOpz+pu33kSuZz643NZTHYGTj4=;
 b=XYroMRTqEAjSdzDFSwZHOJjid5Gb2RoQ/ufrkWFl14fUMx6Qm4OMO75SdlIIc4phH5
 kMHxss914qTdLtqb6AZR9DH39yx4qWqQEs7GyJ5LpnidpOohvwJbC/1l6tgKNR+dZdDy
 BFe1CIoZ22WbYdyAFcNOZN4eAOYn4fkcKNADY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754606061; x=1755210861;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SHY4L6ucwpfFSzbmiMOpz+pu33kSuZz643NZTHYGTj4=;
 b=IrKuVr+OTrAWh31rBJxmW69ZExLmk+5ehU3xJ9tjbDPjHthn7qS1ZNunIVGOvzbM9t
 JfyURCmo6dfuQu9CVlkrJg+ctXTt2rxOxjCM/iHxe4AlerV8RrG+tVF/V0Du7xhCTQF1
 SKbJ4Rof+2cFrU7g6YbCQmgOR7SWRHOyz3P1r/eMJKrXBCchh0nj/+LAFZ/E/GzYZhXZ
 jzwRXIIL5pJjCEUp0xR0Ge2wlMbwU1H5LqClry5fJBGLBc8cEn1x3hs+Sx1lnvPe7/y9
 wjCG2vXGyrzbhJ+rd8StS+CArVweuCgMoDqX09wIzrUhlQ9Xp99JMrTSkCDf/eBDPtge
 8BFQ==
X-Gm-Message-State: AOJu0Yx1NW2FXUkKrsSSSDQaOguPLewzh9a4cDzPpbZP+ZZ3T7PxPnIM
 y7Or+UzgJbQi8+wV/Hk6v6dOPT5PO2Hgrdc9yeXSuLD/iXWg9P+ChP4igbJ9TK7VdZzOHUZB0Ma
 Zg+SN7Bs=
X-Gm-Gg: ASbGncvjhssu85qAdpl3CUQfomv7xazWfNOMFGOnT2er8Amn8LUY9DsdEhWrQ75Rgzq
 USlwxqhpeDQ8D1Tl/Jy4QYRxzufxyVaSNpC3C5mVHyr+N6KrlD+PHpeqCBVkJC+XmmuTgT5Aap3
 LT5LZ6oiwdxoo5H8E3+cHSEyzQzbvFHa1gzwj/5s0IFJhzf+38803ldJW4QqYgc7FEEEqwltRqN
 FbOK/c1pv36QNJbLzyingDbwHr72wlSNCufHVbHPHfM/i/jmb5SN9kJv6cy6nwiienBwcTQmGjP
 QcC2cJcbvOZ5FTPA7u3YqrF7gark3znG2g6dsoaWuc4FPwADf417JE9BjuSaSt9LbJKEzRi633L
 8r32SH6uzpR7SBbcipaJCswGQAFYuiEtfPwjdKBml5RAMXg0Mpuj4agQ=
X-Google-Smtp-Source: AGHT+IHgjIwNcqoQ84eXh7Q8g5BzA4hd3k6u9agx53qY2PoYIDfgf2M+dSmgp+tvzVESEYv+mKGA4w==
X-Received: by 2002:a05:6820:22a1:b0:615:ecc5:c07b with SMTP id
 006d021491bc7-61b7c1ad9d3mr391479eaf.0.1754606061614; 
 Thu, 07 Aug 2025 15:34:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61b7c6eaf6csm73309eaf.0.2025.08.07.15.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 15:34:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Shiji Yang <yangshiji66@outlook.com>
Cc: Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <TY1PR01MB16764FB6BEC2FDBCE2D96060BC5BA@TY1PR01MB1676.jpnprd01.prod.outlook.com>
References: <TY1PR01MB16764FB6BEC2FDBCE2D96060BC5BA@TY1PR01MB1676.jpnprd01.prod.outlook.com>
Subject: Re: [PATCH] meminfo: correct "free" memory region size
Message-Id: <175460606067.3039738.13992669942920352487.b4-ty@konsulko.com>
Date: Thu, 07 Aug 2025 16:34:20 -0600
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

On Sun, 27 Jul 2025 15:42:01 +0800, Shiji Yang wrote:

> The size of free memory should be $lmb_base - $ram_base.
> 
> 

Applied to u-boot/master, thanks!

[1/1] meminfo: correct "free" memory region size
      commit: c60898c9c6988e34d33a7c5d5b79c0bcc14da719
-- 
Tom


