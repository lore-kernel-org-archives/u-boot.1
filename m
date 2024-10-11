Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CBDD0D79C
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 14:42:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FC6F890FD;
	Fri, 11 Oct 2024 16:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wRCv23nb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B3018932C; Fri, 11 Oct 2024 16:42:16 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD23289335
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 16:42:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4311420b675so18317205e9.2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 07:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728657733; x=1729262533; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=St0+KCR8ADle3WrgLbtS/B7LfB9Uyf2ehRhy5pA8oO4=;
 b=wRCv23nbDAZ3sd7lTIT39kNT5Y3IyWxD6T1OJvNweccIFPlt05u+PPJOKUccuSk8vX
 kgO1BW5H69JgB53rK9bsfHqgDnwAvh96LR4k027fhdukiHoPFGJUhJB/iYSR4DQvrqXu
 z62Y6gLGTgrc4LQi+QpFtZYLIYvqSLnheScHSIYBq+8t1QLVGDnYGBMngoFgh2MlYbVu
 WesxfVsQQvGbg2aVglL4AfSfmmpKlzNY6S3aMkMVsKLDVe04MsleNd2qD9TNxyy1IXO2
 2W0cZIUrvqZGoQIEvtg7RXLZlbqTOnlT8RMbg+Dsn/VsafxTx9bwDJTslmgkTkdpRyk9
 qBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728657733; x=1729262533;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=St0+KCR8ADle3WrgLbtS/B7LfB9Uyf2ehRhy5pA8oO4=;
 b=SryELymnS9Gw3kcZfIlP+rMPUBNXF7lbO0EsgRMr0KLmU91A1oroI43Wk07sJxMMAN
 MemHb7FmVoAVBLP31KMK+vOyzw4rxsfY8t6n3P7SaPVKYkkZNH413308ECuPv2hXDFFh
 tTJ80+PEJjvZRVD0szpBpqvFAN5wyM7DGVmLc+y6MGquzVCOsptNkeJqjFtld+BRCt1/
 fq9JccLUyo0cTXgeCjbb/b+89oFg8Cda7d3s49AXxlnf7OxGj3QNqmkr4yGhVRA1Hd3Q
 7WdNyA3t76KqxX0HBQnCMKzWyaRUGq9fsVTxdg/+kvYyA3k2n1rFs/vasGh/9svqDGjF
 255Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvdhDq3pvd22/RWTI+nhD5KlaOWv7UVrBH8IoKWW5bszh9p5mgfNCWRaauPCNFew6x2O6WEcE=@lists.denx.de
X-Gm-Message-State: AOJu0YyDiqdqVuepPTWC6qJfaCkaJzLEC/csWpkSkJ+lR1LJ/kahBAuB
 regcHIFeOlGOVePUW6oAJzKoeMW5KpEHpnMyXB+WTnAlYAsRFGlrFS+bX2l/8pY=
X-Google-Smtp-Source: AGHT+IHAEa45lyzdrJPpQSvv5B3hRcoo5cQ+AQEmonuvgFm0+ymMwDgK5x5meT0Kuk/HyaHuN+bMyw==
X-Received: by 2002:a05:600c:c0d:b0:426:6455:f124 with SMTP id
 5b1f17b1804b1-4311ddfe1admr24385215e9.0.1728657733340; 
 Fri, 11 Oct 2024 07:42:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431182ffd14sm43951385e9.18.2024.10.11.07.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 07:42:12 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <20241008-u-boot-topic-g12-do-not-disable-canvas-v1-1-b89659370012@linaro.org>
References: <20241008-u-boot-topic-g12-do-not-disable-canvas-v1-1-b89659370012@linaro.org>
Subject: Re: [PATCH] dts: meson-g12-common-u-boot: do not disable canvas
Message-Id: <172865773247.2734796.15355801164336792382.b4-ty@linaro.org>
Date: Fri, 11 Oct 2024 16:42:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1
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

Hi,

On Tue, 08 Oct 2024 18:23:42 +0200, Neil Armstrong wrote:
> We were disabling canvas, which causes meson vpu probe failure,
> just stop and leave canvas alone.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] dts: meson-g12-common-u-boot: do not disable canvas
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/bc1eba9aa2a5a4cbfe3b2d38a66888e6ce370620

-- 
Neil

