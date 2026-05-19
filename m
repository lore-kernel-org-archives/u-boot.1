Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33298CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B4A1847C5;
	Tue, 19 May 2026 15:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V2SEgdjN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7DD2846F2; Tue, 19 May 2026 15:35:12 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5CF9846FA
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e363c6141dso3019320a34.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 06:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779197709; x=1779802509; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bckbr3m51ZTjmZt4SzFiqGedhhUUB/hldvXRIjCDuGo=;
 b=V2SEgdjNo7uIOKJ9l75//gsBhID4f07PpK1kLua3ZgkYy2kE2biJm5T3hveuJ68QzC
 4ylAZHAMWMzPv9gYaMEYZ4O8B2dZyRmT5JtwaYd86x2+Bn3f2YTvRLGJCNjKFWXGBGvB
 3H4VKW/67k5Y9AS2dh5jAgX4avPYfESguOzBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779197709; x=1779802509;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bckbr3m51ZTjmZt4SzFiqGedhhUUB/hldvXRIjCDuGo=;
 b=jNGHk36D+IPyTxfLhDQBknB5lHAHDtDqL5y4bxV4wkzYV9VUxEe6RRo20zG66bfbty
 1tJe69+XN8BkESpOWdb7dR4JxTqel4CAkx4DIlx9BzBXWxBEBdvaT//1QFU2diMTlL1i
 T6o8s1VycXAppbVSJ8SpicQrCac/sPcM3ZnZqgtK6D0KFSI35eX8tsZicnt9w1F53jdw
 3jJ2iFW1+EPHwgdxhG1CUXMHk2TZ/Lbw0vjtbsqivwPLTEt6AyBjgsIE3LsXm+zzJZdy
 LDewHuuWXo5Ayfp31o8fhWB809rukewtTb1mfgoaIjZBXr2+NYCAbbLadZ2hb8c6LbII
 x/xA==
X-Gm-Message-State: AOJu0Yy2XsvtRhNwVHzZVlGtsZfb7ykjJfjUJwjAW7M2JJEG3US18PLO
 HAV6wKseCWz6ZNJfyTvFWpIQBojRdYCuuADVRZ4nYHfXZ3fNWmnZ2eomXpWn3z7cwy1qJZEkxRY
 bF7uAn/nrfsYs
X-Gm-Gg: Acq92OFdgvr4hpAQdaLbXucuLlvNVUa/3hb1beXy3gFoD+BrWKei0WBvhS1Hq+FefwO
 aHZtLoWUcZZSMqwfoP3SCdL40+IapeqGLDmTtmewiNXPH0xa5PxHazvwCBucgyiHOv/OD1KfF6t
 85kc2+qs5ZqhPoYtCviD3QCjW8SbU8AZgt2sZ6HNTJH2RiPe8eba3yLCoWzL4I8A+e0yvZKpoSN
 Y0+lR6Dar/hpu8wHv4DeNZeqjz+9CjhtQpi+G81x/TsUBb78jVMh3RZ2H3uQDWFo2BDkx2WXm+z
 kAug5zBO9SX3ChhjRR4i4Jrrfwz9NgVmHE8GTTITU6HTeAsH2H9S5hwFRad3kgwv6dwlAHqAZNq
 9DAXVp9PWMbEJTn4XE3JTcjQ6D5K/16oZHAZ3snQO/cvfl5Yh8xgfyZxEVALyRWUPXIlJ6OIJIe
 DYb9FL4COfI7dNk7SgpsDi+B0niDJuS2vSCb1dYv//H9fczBv8RDnYWjMUx+23H03crlyOolqPa
 jBWbRD6we0PqNJcq1/gtm1ePu8Wt9BHVrll/sE0Tlk+aWxdbg==
X-Received: by 2002:a05:6830:6d29:b0:7e3:6b8f:1e93 with SMTP id
 46e09a7af769-7e4ea01c97dmr13529715a34.5.1779197709530; 
 Tue, 19 May 2026 06:35:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7cd6c0sm10826569a34.4.2026.05.19.06.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 06:35:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Vignesh R <vigneshr@ti.com>
In-Reply-To: <20260507220817.209253-1-marek.vasut+renesas@mailbox.org>
References: <20260507220817.209253-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] mtd: spi: bootstd: Staticize and constify driver ops
Message-Id: <177919770865.672258.1518972648593171567.b4-ty@konsulko.com>
Date: Tue, 19 May 2026 07:35:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 08 May 2026 00:08:10 +0200, Marek Vasut wrote:

> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> 

Applied to u-boot/next, thanks!

[1/1] mtd: spi: bootstd: Staticize and constify driver ops
      commit: da1ac763c9819a4326582bb048082ea8250a4077
-- 
Tom


