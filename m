Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4C9C02192
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 22:07:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B32A5828AB;
	Fri, 31 Jan 2025 23:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Af8QGkFK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E83B680FA0; Fri, 31 Jan 2025 23:07:10 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5DB480F95
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 23:07:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6e1a41935c3so32472426d6.3
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 14:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738361227; x=1738966027; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tLMe4IXlsD9CsUMcpo0bdSCLquxFqjoVuo2i+2a4+co=;
 b=Af8QGkFKn85uXSi+qD0XPdQIHyN2hRYbDqaMIm4Xy/PK74eMs+U5cO52st5IPDpw76
 KOeQEKwXatC+Sx9k+wW6514qUyWFQlCeQEFGkP0+Xf2/u9EFxIYQ+ykgEqp8bpwwVLeW
 KC27v3hzowzyYdSCr9mxcw+ENEbsurCw408Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738361227; x=1738966027;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tLMe4IXlsD9CsUMcpo0bdSCLquxFqjoVuo2i+2a4+co=;
 b=W/cYm4ZFcN9/L9dsOx2HcMXsvr1+4wFA66huLrEBtEX1xVR7+4Nieo2RJjplM+iFWT
 yf9jX4o6hYe7rGf0hrtfjJ5py/3T1d5ALrFw583B7sFjH0D3EKadQsMBN6CBM9D/UZ7S
 l4wur64XFFu1TwRAiKldgofGQrUpulIQfoIgSO2yQTMkk9+4jAxbAlY5mzt6GK4HHy6/
 RZ2dvOlnlrozcmqnzdW7RN3OkHcVSisrZLchiR48eVyAclzQ/J6vqjJREeyabOD615kS
 LUKiKpbrzvA+h9fNqUd/gI0gWUqHWscQp2irKk1ydd52awWTyc8goTWGwe7hNE89z7cO
 Nutg==
X-Gm-Message-State: AOJu0YzDxrt2i2MWAn2lalJ4YHf2KFN90WgyjI78HGI3xbhR8gJEO37J
 N+c+CRS8Phy4Z5uEcM6M05zHLgBf9IojyRvs2Cfl2FnXt6ML0a6Gjp/cxdyF4yY=
X-Gm-Gg: ASbGncud1k0JTyLV8Ww6rocdccAVszxMYM+5Rq4/AfDf3/BD4c8+P52K7z8DkW/+A7X
 /HjH7Hwbnl7M14pkr4apwvZx7Lgsvr6LXW6pixkLQb6q3+Q5nOCR2ON9Xm5++kilcVSr6RaQOgm
 xl+ok25zcosLND72Zj2WBFZtaZDbNh2mCybEBTvgs7j2npRl09bGWl+V0Y/w1a3TLSKG0lYUBDN
 u2BEE09KrSVzvp/3HdkRG1FvpSCflp8Fi5F12boyOMfPd6E8J2sliyrcnEgrnHeHVSztJQmZ/iB
 LYhw6pyUMNZz2Q==
X-Google-Smtp-Source: AGHT+IFNnomUbOH2eVEnGtYT81/PzhApMBOiadk8xpcMPITadUx37XEI2eZvX+9i4EZnEFbS58PrwA==
X-Received: by 2002:a05:6214:1c4c:b0:6d4:22d4:f5b0 with SMTP id
 6a1803df08f44-6e243c678b8mr195669706d6.33.1738361227403; 
 Fri, 31 Jan 2025 14:07:07 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e254819a57sm22141986d6.45.2025.01.31.14.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 14:07:06 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
In-Reply-To: <20250124080428.195597-1-weijie.gao@mediatek.com>
References: <20250124080428.195597-1-weijie.gao@mediatek.com>
Subject: Re: [PATCH] net: mediatek: fix coding style of AN8855 switch
 driver
Message-Id: <173836122543.3060818.15958960839389461879.b4-ty@konsulko.com>
Date: Fri, 31 Jan 2025 16:07:05 -0600
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

On Fri, 24 Jan 2025 16:04:28 +0800, Weijie Gao wrote:

> This patch fixed the following coding style suggested by checkpatch.pl:
> 1. Use tab instead of space
> 2. Use BIT() instead of <<
> 3. Use mdelay for long time delay
> 4. Remove useless parenthesises
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


