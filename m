Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0177CC4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 23:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21FCE889E7;
	Tue, 30 Apr 2024 01:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iP6mrd6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCD03889A9; Tue, 30 Apr 2024 01:04:22 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56836889D8
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 01:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-790fb9d1b55so105588085a.3
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 16:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714431859; x=1715036659; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zsEwXNTRcaKMiA+cLWw3Gf6MAgHthoZyS0MV2oMKgx0=;
 b=iP6mrd6X2VDc9xEREeJuKBfA/YGK7R0+OahcL4UJdyKtQ5m5aw6h4ZKbSEGDCCphv5
 ozmYYr+hRIa8bXjZxnTveaKS6t7jL1h5BlUqALp/dHBY5JdiuwTJSZ1DlSnRL8h2snFu
 uLYUuE9lLmhkTl4AY5/EazNO89HifGVqdvpG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714431859; x=1715036659;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zsEwXNTRcaKMiA+cLWw3Gf6MAgHthoZyS0MV2oMKgx0=;
 b=dvtWb/7r/OoPNYSFlLH7ECJ1JEfphU97BUt43BwZnfXKsyyjApZTWf/z8ID8mrRVJv
 ZU012g+Wr8HSgi/UML+CRQMbSkN8sarpGvZVTx4w5OT9iI5PTvtvz55p9JSkdCa60rSc
 qkn01GUjwADl72SEb/mIefiGWIe3bQYCvzf66xN2vK7uvDz80QaYf3g3R5G3dMpIMbGH
 vndx8891SQDAi0p4o+u4H848sugTYcO1DAc5Tz5dL29T6AT8H09zRKW3MnKhKQjYTGj1
 4ankHA2QewPwA6ZcwmpfiLOdk51pXIWUL1OtTQPaG4KT4GN4EkwpNTXGCYCCrOPAKB65
 tpPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKa3/lLGIyD2BLgRE4vqRDOzcFHG1RX837oEB7VBQW7DTnoTkj2+8K8EnVNxfm6dKb9JLqldd8FqGykAxqC4wmsBF0JA==
X-Gm-Message-State: AOJu0Yz8/lmsmssEz2aMZX+ET1wvKko9AdFtSbs/K2IQ4LhRj9HzB+FS
 SjPN//urD7zInLmCNEmjGE1OrbgPS4cLDh5XoGD3lgQWNf0RWq/xZA/rnTiz1w0=
X-Google-Smtp-Source: AGHT+IEXqDAkVu4edTnpXAI6tJ1615S5ePtYyhlleISgblYw8Vsgkuts+LbLeXuHlI+gpS9yKPQk6A==
X-Received: by 2002:a05:620a:5e4f:b0:790:a95c:fc46 with SMTP id
 ya15-20020a05620a5e4f00b00790a95cfc46mr938903qkn.48.1714431859346; 
 Mon, 29 Apr 2024 16:04:19 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 h6-20020a05620a13e600b0078f044ff474sm10967156qkl.35.2024.04.29.16.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 16:04:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20240418-b4-of-upstream-build-vendor-v4-0-d404deff386e@linaro.org>
References: <20240418-b4-of-upstream-build-vendor-v4-0-d404deff386e@linaro.org>
Subject: Re: [PATCH v4 0/3] upstream DT compatibility
Message-Id: <171443185785.1749944.11819415619511855123.b4-ty@konsulko.com>
Date: Mon, 29 Apr 2024 17:04:17 -0600
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

On Thu, 18 Apr 2024 19:39:55 +0100, Caleb Connolly wrote:

> This is a subset of [1]. With more platform maintainers switching to
> OF_UPSTREAM I didn't want to get in the way (it has also proven more
> difficult than I hoped to remove only the fully compatible header
> files).
> 
> This series removes only the dt-bindings headers which contain generic
> data like GPIO flags, input event codes, etc.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


