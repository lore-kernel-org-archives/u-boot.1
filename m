Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548EFC8303C
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 15:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3523982FD6;
	Tue,  1 Jul 2025 17:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N8m9rSNm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BC1F82F71; Tue,  1 Jul 2025 17:38:20 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5950782F8E
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 17:38:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-735a6faec9eso1828375a34.3
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 08:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751384297; x=1751989097; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3D7LTF5TS1ee9m5zd5z0tF6C6ANOkYXj5N+4WrQdTGA=;
 b=N8m9rSNmwuvdCxrTrZ8Bl3bIv5b0EU0RN9QdDpN1GFC4WD+nhsZQBoj1aK6TNygo8b
 XItmX5Q+zvBKtN5KysSD4A+xoxk+lRb/8uHmx+s8qLT/2q8tIhPDw0lFcD0eWur84j1O
 QNPnqEih/p+qtW8gLNu3djMzYZhOzY+KyANHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751384297; x=1751989097;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3D7LTF5TS1ee9m5zd5z0tF6C6ANOkYXj5N+4WrQdTGA=;
 b=DIUV8bV1WNfRE36BXL8pkttWhpQgOClCiUtwBMjF9pToR+Kw2w1lA//gUaXS9eGWcF
 /rmbpYbv3caU0yGJDd2oB9EO41AS0UqbaXnht+Z7KWO9/QYv8D4T5jBih7tSyly1i3E/
 zRz494Ja01kFBG+Beac2BpRDY+TVO4ZWhc7teMOvRJBj9SIKSqhPuIhK+5cdtGbf+9T5
 Ldq65GD2VZOHd6bNG0WhF1x8//2WmzNZHXGeu5EQ0ZZTk2HoV5JE4tMOort2/pXLgi9G
 YhEAcGGyRJdoEOTHymOTQoO7cLqFHoujKpwOaD40idhtI6ipDFRO6ULl0tvPTLM9he99
 UnEA==
X-Gm-Message-State: AOJu0YxM+nsPyuI2YejgYDFJ2lKkGbP39BJ1aisAZAw/GgYdb265osDg
 NHebHdnqYUR+no3Sd4z55rOucCZeoEOxGWuWXe1A0Rr8GmT/KgKgQMpfQFSnAXXGOUPh5vkwY24
 bF5eryEg=
X-Gm-Gg: ASbGncvwX9qncTjCsxCF5sX+02kzzNfugo5qcPYKBcMQM6cTRafDH/cyQNIOtyg6N8c
 mtw7sMaOTCqdlE4fofn/mWfwofDLASaQtRBhWH/n4LD6DYBFhg2QrnLkj73XU18HUDqBbZHlNbk
 xrLcbS18dyh6wq2ErPes7pLOGy1O6Ftb29GqPv+RzK+PX060t2RwWrHGi0EA9CfrEjldrNTg+wk
 a6/bVgcl430cbZ47D/lWAaoDDbROArbKVm7NWlVv/Polz4oGtmHmvmEt27KVQC9hriw5aMsG62A
 dilwaAHGWZ3unbrWWMfxtN9kcOPZDIREWlandh4yVCtP1tMMdHjKfYlon4p6j6XAH13Ggfvu1nD
 45qm8ehoOhtJVSfdUKlIczw==
X-Google-Smtp-Source: AGHT+IEo4aZy6f/R0GR0OEG6UCpAvMwtz2hHfVRtYQ2NdpTr7QVIRC2AE9xC+TXcRYmWuobQgDycjA==
X-Received: by 2002:a05:6830:3c8f:b0:72b:98d9:6b1c with SMTP id
 46e09a7af769-73afc5cf4a7mr18074042a34.21.1751384296958; 
 Tue, 01 Jul 2025 08:38:16 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb0e2f7bsm2127857a34.41.2025.07.01.08.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 08:38:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: andrew.goodbody@linaro.org
In-Reply-To: <20250701072739.374111-1-ilias.apalodimas@linaro.org>
References: <20250701072739.374111-1-ilias.apalodimas@linaro.org>
Subject: Re: Pull request for tpm-next-01072025
Message-Id: <175138429637.3146160.493568422837554118.b4-ty@konsulko.com>
Date: Tue, 01 Jul 2025 09:38:16 -0600
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

On Tue, 01 Jul 2025 10:27:39 +0300, Ilias Apalodimas wrote:

> Some minor smatch reported issues from Andrew
> 
> The following changes since commit 490ae8ceae2d5999c9de863e014e463f5c1495a6:
> 
>   Revert the last two mach-k3 changes (2025-06-27 13:07:43 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


