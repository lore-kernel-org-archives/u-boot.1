Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8442C25B78
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 23:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20DCB88346;
	Thu, 16 May 2024 01:29:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p2AQgDDv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 548088834B; Thu, 16 May 2024 01:29:05 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41D0888361
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 01:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-62050e00cfdso67021377b3.3
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 16:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715815737; x=1716420537; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MHNsVmW70X5AQsDXK/48jHPTYVus6p768K/12tCgOsM=;
 b=p2AQgDDv4Wanzp8CxXLSNvRkChpZ2B2EVz/FIAtfM+8j4GeenSlb43WK68BZSzif/G
 W0kQtgmgLWFPFwWTAsPFUFRQH5uQ/b0QUK/Ym490fSFnRsdP35ENAda7wG6wZRVVmZ8O
 RCXFE8qMNaxFj22M5AfzGM/lkXVvMS0JeGTek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715815737; x=1716420537;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MHNsVmW70X5AQsDXK/48jHPTYVus6p768K/12tCgOsM=;
 b=sGyq9sdKXE31cdKPYEPaTSShPKjPwWpruQC8baKDFAy5N3HsYoR8VqhTUTKX3S0iYa
 6E9yDgxzfHHRCnhWZOdDZMXp2qCwfUaah+lCo5xl+VAKhgmYOxaPwtguuhd9IPQOtUd2
 rmR5tqU6D1RMpd0b3flLe01I1Zx1VlP3+6RNgIPP2Um+hyuyDiuTv6zWc4sU7kMqALhJ
 s3kvHr6PQHrFs/BwbXc/quroslbH+3qWsk6sLLLYVodFqYpEtupbFsOJi9pYGKjH9CQl
 rhZexd31XMB233VSYQ8e0vdOU22BRrocmXAcssR4XCA/75kSbDH/7KE0Oib8IgkjUUKu
 RmcQ==
X-Gm-Message-State: AOJu0YzNHCXi4o9DkR7AnatTt9hsq7zmK+3aO/y2+fusPRytEoLr/H9X
 Wqgg96mV+3CRghBNd+Mz6Xpkf0WdXeGjxuDKRe6K3KHozTWGMqPRLHF1gjGLlBsC4ngFLJ5fqTe
 YQHE=
X-Google-Smtp-Source: AGHT+IGgKhf3+pIuaX5vvQPkU+Bnhfmf1OdVPXcOdTD0KTL5jSHUMaXLq4aOb0mJjlPNMKjVtIvEKQ==
X-Received: by 2002:a05:690c:6913:b0:625:691c:9f44 with SMTP id
 00721157ae682-625691d638cmr32206557b3.15.1715815737125; 
 Wed, 15 May 2024 16:28:57 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e3935af58sm7978291cf.65.2024.05.15.16.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 16:28:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, MD Danish Anwar <danishanwar@ti.com>, 
 Jai Luthra <j-luthra@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Nishanth Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
 Suman Anna <s-anna@ti.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com
In-Reply-To: <de7fe2da7ae4a85252d63904fae61585e4641936.1714117337.git.matthias.schiffer@ew.tq-group.com>
References: <de7fe2da7ae4a85252d63904fae61585e4641936.1714117337.git.matthias.schiffer@ew.tq-group.com>
Subject: Re: [PATCH 1/5] net: eth-uclass: guard against reentrant
 eth_init()/eth_halt() calls
Message-Id: <171581573568.812585.13429362076523742879.b4-ty@konsulko.com>
Date: Wed, 15 May 2024 17:28:55 -0600
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

On Fri, 26 Apr 2024 10:02:24 +0200, Matthias Schiffer wrote:

> With netconsole, any log message can result in an eth_init(), possibly
> causing an reentrant call into eth_init() if a driver's ops print
> anything:
> 
>     eth_init() -> driver.start() -> printf() -> netconsole -> eth_init()
>     eth_halt() -> driver.stop() -> printf() -> netconsole -> eth_init()
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


