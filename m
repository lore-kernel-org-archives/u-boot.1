Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1F4D6DDCB
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 04:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 395ED896B4;
	Fri, 15 Nov 2024 05:27:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CGZbJku8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43D3789353; Fri, 15 Nov 2024 05:27:55 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1286F896BC
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:27:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-460c2418e37so2320051cf.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 20:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731644872; x=1732249672; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JCxFfT4pSpZPCGgOOzwqYV/Qod2tt2AiqMxE49ptt5g=;
 b=CGZbJku82KvyEYdn1lJSyH9z+DPoMUBYCt5i/cLt8bcdrRBwrhWAmdyTqJoXyaCnWO
 BArHeJz+cfk5rSYUHiCCgWB+EBHdXsPVtIBMuN5liB/GE+B1A4CRa0WDKU7UsyJ43AqG
 +uAr+4ltjozVSP4+qRFckJmCJD3VomajHpuMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731644872; x=1732249672;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JCxFfT4pSpZPCGgOOzwqYV/Qod2tt2AiqMxE49ptt5g=;
 b=XiLXQmjGzAq2A49MUxv8StYz6ZBAz9Y41GJFBlhwky7nw4fIV2xy+WGvIpfwsafkdR
 jvzCRVQYDmJoZ//Fxpknga2CJK9d1R6BmlyUsdEsKCzV36ML5QHCdDNGHQzFRlrta+uv
 gjfpk5LnsB4qssSvEbxAYV6DppwPy1Tg02ejb5qIv7EsNuEr0D8uG/NvjlcuBYU/VVr3
 hbfHETmvDBodz2BppsbmOknOPFTAnQ1eLx3absVfjJPWAsPZB1tPoSREljRxHENsiYp8
 ThR3eQ3uKei6lKgo62IPP6SqNyHFoGnCqPr0UX49KKS7lUKRQimsIrsB4ON0WYO7G7lE
 Bv5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqQYLBEb6N0CMQnkziK/zEFapWJcfZfrltKyom390mzKwcUlFzS1E/vJiFsXOWHZ8g4WI0pQw=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5BaZQP+cNfKJEX8cSZ/Qhes722g4SkMv+2SfiBYEuvF1lotTT
 IPl1wafUFYvGfT+7Qw842ah3DZ68pY841IbZvJCARpvWaIIWRzFZKyxZjutAg470eosbscq0KqM
 aNCU=
X-Google-Smtp-Source: AGHT+IHxWQHhjL902Ms+buh2QKgCALxKDgCPbqVD3SSBHWfANCfHaICejJZk0kcXHFXAuL//Y+mLXg==
X-Received: by 2002:a05:622a:30c:b0:460:cac8:bd1c with SMTP id
 d75a77b69052e-46363e97f64mr20764521cf.43.1731644871974; 
 Thu, 14 Nov 2024 20:27:51 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635ab24bbcsm14415041cf.58.2024.11.14.20.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 20:27:51 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Neha Malcom Francis <n-francis@ti.com>, u-boot@lists.denx.de
In-Reply-To: <20241102143020.129450-1-heinrich.schuchardt@canonical.com>
References: <20241102143020.129450-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] cmd: upl: initialize unit test state
Message-Id: <173164487019.1205089.2684650653105412500.b4-ty@konsulko.com>
Date: Thu, 14 Nov 2024 22:27:50 -0600
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

On Sat, 02 Nov 2024 15:30:20 +0100, Heinrich Schuchardt wrote:

> do_upl_write() calls upl_get_test_data() which may increment the fail
> count in the unit test state. We should initialize it.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


