Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF1DCFC5E7
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 17:10:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE4F889139;
	Thu, 10 Oct 2024 19:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GJ4YSB3T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 981DA8912E; Thu, 10 Oct 2024 19:09:57 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89E9E88FEC
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 19:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-45effbc3348so10251411cf.2
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 10:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728580194; x=1729184994; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qbDlIOfXcL1zW3eKWRQv6V5w55nI2+SI/TYp3YQiYsg=;
 b=GJ4YSB3TOLy+liHeN1zWkVEs1UrtbUK+lcAq1OtKAfyj4ezST+39YFT6dMBl8emHDB
 TykLGZir10Jd6XWkvZ4S9Lwc6V043lNEOt9SUTsbTUJuy/K4tinRmAz9EsFSZI4GNNST
 pNH6ApCBHVhgbw4Zu4Jx+9llQ7ZcTfZffDhzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728580194; x=1729184994;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qbDlIOfXcL1zW3eKWRQv6V5w55nI2+SI/TYp3YQiYsg=;
 b=l2fJbfg7lqxnxDAh8rnZyM0Fx2ultEpa0b8LuaCQ9vcUQ4NcTy+ApzffOX9mU8y1Tp
 WNjGk9om4nza/cOm115fVlD4S/9/ahvvUd3/GLCUSVzfWQXV/RyzwngbHFAK8RnVC+qx
 SlJnEewu8wnqyPURZpEAGvLi25aJr/D7PQ/62eXyjatGSf6BtgRgVkOzbGnoU3yXQxhS
 Ofcv65M1Y/2rvUrUjrDwLtoa9nbZfzVhUHKrFl3CpeIdM7qLLaU9/nEalZyWjB1e9Dz9
 Iwt8/X84EtYwZR139r6jAm/V8PZ7LztFLDjaxF8UgDjJgtz4e8/04vTPY4WnHkZN4Vkk
 Aq6w==
X-Gm-Message-State: AOJu0YzDpVFW5YCtabl/eoFqoyC73QmpljV/r4rB3X4EucZuD5MBO6rI
 nNjDVanxNf6TLrKBxgz+RBkchvHmzenBEtj1BpvKgn7ZIp90+oR+R300wJKl9q8=
X-Google-Smtp-Source: AGHT+IFdZAWqJf5XlTC2Bfe40d9OnPL0sUbyomOQI4lZbzFuF0G46px40A2UK0qBv77Q3xRr1P/Uzw==
X-Received: by 2002:a05:620a:147:b0:7b1:f4d:1fbc with SMTP id
 af79cd13be357-7b10f4d2147mr637115885a.34.1728580194406; 
 Thu, 10 Oct 2024 10:09:54 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b114956069sm60577185a.74.2024.10.10.10.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 10:09:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Dhruva Gole <d-gole@ti.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Jim Liu <jim.t90615@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Michal Simek <michal.simek@amd.com>, 
 Neal Frager <neal.frager@amd.com>, Prasad Kummari <prasad.kummari@amd.com>, 
 Teik Heng Chong <teik.heng.chong@intel.com>, Vignesh R <vigneshr@ti.com>
In-Reply-To: <20240906210951.193142-1-marex@denx.de>
References: <20240906210951.193142-1-marex@denx.de>
Subject: Re: [PATCH] mtd: spi-nor-ids: Deduplicate w25q16dw entry
Message-Id: <172858019257.3696879.8842300906726205216.b4-ty@konsulko.com>
Date: Thu, 10 Oct 2024 11:09:52 -0600
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

On Fri, 06 Sep 2024 23:09:16 +0200, Marek Vasut wrote:

> The w25q16dw entry exists twice in spi_nor_ids, remove the less
> complete variant of the entry and keep only one copy of it.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


