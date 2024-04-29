Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE247C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 23:05:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD11C889CB;
	Tue, 30 Apr 2024 01:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UXl4PlL5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 421CE8899F; Tue, 30 Apr 2024 01:04:13 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 392D4889BE
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 01:04:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-78edc0f9636so340008185a.2
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 16:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714431850; x=1715036650; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DUfMNoqsF5Q76BwrQ4UYbZIO25+hcdXDTPAliUjI82w=;
 b=UXl4PlL5aEnDTqk68vK1lV1kta+cVqbON0cn3XzuZHcYKWaW7FgY3l/6I6Np3mgOyO
 DwTqV2VgrbSbxDIa0Q2IPQiX0OZ53pe/Y4zw3eC9jL62beJcYUWxACAf3V6ciiJgIP/D
 uR0TpD2SUyovw4n3koLeTmHGcKXW3k2dRpRro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714431850; x=1715036650;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DUfMNoqsF5Q76BwrQ4UYbZIO25+hcdXDTPAliUjI82w=;
 b=Juqi/YDeXS3xei+N+P102VoAjmMX/9DWJRP4L32g7lyIBifM75atng1zafC1txEh1j
 c7lSn4YQ35GuXF8iX7v7elMx3MPiL94m2wvFohtLCARBSV1xXkEdUdc4Sls84RMLgD6q
 7q5SPu98fyk4703smURY8pvrt/YrgsTPkoUYRrv/NaZYQ7xxhub/yjbYbqGvapL2hKSN
 DSMWKDkX5HBK7I+ozEKwSw7uHVwzpDa4s5Xy7TVX7V08a8YIQo+yEWDafdUk7Vd+wdxN
 F2kZGuI42kd1lpHgc7ZwPKfeXsg8g5MDi67GYvIF7KcPnuvuGmMRSXU2fvJNLO4GfE9X
 AbhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfyAWjG2q/2loDiW2sDTnky2rTpxWn0IKfhPgXC4ekrbGt7IIs+GUw87Jpia+RxKPrfUQd82Ibj1WF/ALcsFiHAawZug==
X-Gm-Message-State: AOJu0Yz3/zaPI89IbKtvu+4NZCZPDcgvmwwvwEpw/+ezFO50Klel1+lJ
 GBjmVGyR+SVqpWSaTfrJC4IMJOsOvpnOkB7t342tqv1Lm3ugI8Zvo3/8JtQ/jhIb9iq5PiHSaQ1
 mJplp4A==
X-Google-Smtp-Source: AGHT+IEFspbxtJyOadX7bd7DI4sb552PLDYXO9eSQDPkn/77yipJ4MSDVIynmIoyoPmW3mPeuHJj7g==
X-Received: by 2002:ae9:f401:0:b0:78d:5f1d:23bf with SMTP id
 y1-20020ae9f401000000b0078d5f1d23bfmr11721360qkl.29.1714431849723; 
 Mon, 29 Apr 2024 16:04:09 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 h6-20020a05620a13e600b0078f044ff474sm10967156qkl.35.2024.04.29.16.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 16:04:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: ilias.apalodimas@linaro.org, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20240418141112.141948-1-heinrich.schuchardt@canonical.com>
References: <20240418141112.141948-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] mailmap: add entry for AKASHI Takahiro
Message-Id: <171443184870.1749944.11865838004487420827.b4-ty@konsulko.com>
Date: Mon, 29 Apr 2024 17:04:08 -0600
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

On Thu, 18 Apr 2024 16:11:12 +0200, Heinrich Schuchardt wrote:

> Akashi-san's Linaro email address in not valid anymore.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


