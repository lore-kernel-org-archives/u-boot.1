Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B67C021BB
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 20:27:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D919080EC0;
	Mon, 24 Feb 2025 21:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ugmiz/zu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 330B480F7B; Mon, 24 Feb 2025 21:27:22 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED1A280977
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 21:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-221057b6ac4so93190735ad.2
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 12:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740428838; x=1741033638; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Kz3GYRHSuS4+iFCvQQCX+L69+KBw2a8Ms378Keoa+I=;
 b=Ugmiz/zunGa22iGjrgLTBlONdKxspNYDAPYgj6q7bWuhlm3vUOL1rWvkbTec9ToTfw
 /PcZhVnVkFAOPM9SivKr55MBr4YXzg5/mJtMflV+cczZ1z5HkfwANeDk4riDCRoK0en5
 7harjsXhRXiQ7uxBOY/r1C7lM3NhmhtJZ7PfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740428838; x=1741033638;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Kz3GYRHSuS4+iFCvQQCX+L69+KBw2a8Ms378Keoa+I=;
 b=J7gkiRWRPgKSQi6egsDKgA93BU6BOYjFqpouMQv+Q/ZQQOCmQSWB2cHCmbwz5e9JoQ
 jlbeDuy5DjtMwhzxg3/xKTPe0A7MLB5jtOgj8Q/C5pT/aqLRFFD1k8uKz+5T64zCYtJT
 rr9FEWVVE7RmBQbH8f5cLh0CfsMhTxj9KHTgy+ekP3AebphA+vXvXIObEEoSFHZxkAv2
 6VjkyuSrP07bjnfTbvdcyk8P19w/GXGuBnJ+ngHlLiVIgF0vV/jKxdMOx1lpDejAO25v
 PQxcFzFY5+hd8qT4yn1Xvt2wTqgVZqZCo992taLfECdkirHs+91K/WWVyyMv06qtv9om
 qInQ==
X-Gm-Message-State: AOJu0Yw/xoL96aBDyiRUU9cx1SnnZjwbkBxPwVX8+P7uR69GlP1NK9MS
 FldSIT8uBnu8NyOsvYkjwXxwQsnlI9ykt5BPe9UWG0HuJFQzya1wqeyuBzeEiRM=
X-Gm-Gg: ASbGncufKUUGLL5kSL9VaYuKohYHJMQM//3hCOXZl7NsnhJJRkGDVeLFCN0bJZ7lUwK
 gMzA0E9WLDJRzbO4PueAyVuwPXaKKoh7BulYwS77KX0St2VbQED9ziq7UEQk8oqeL1bEp20zBhm
 3q9eUDcgolawGvHMjRgR0Wu+HRUPHWp5C9SKUPRtfIk4vptawxHX9s/3KpvTzHEsXNdfYcgeVYo
 utzMFGekl2I9e93XgjBVo39Yr+XlFTkO6brDGhuxJE5hwfxnJ4e8o07fH+1EdOaI/3kKtbjvXR2
 WeWjaJjEDWOfgHasFIXXHkg=
X-Google-Smtp-Source: AGHT+IG2vVn/jUmAy8miY957VOFV60On6kgXi8ET5mQv0O8S090ekDbRTwTUPooq+dIQpXkcY1NlbA==
X-Received: by 2002:a17:902:d506:b0:216:501e:e314 with SMTP id
 d9443c01a7336-221a0edda05mr193555905ad.20.1740428838526; 
 Mon, 24 Feb 2025 12:27:18 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a00abb5sm254095ad.74.2025.02.24.12.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 12:27:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ronald Wahl <ronald.wahl@legrand.com>, Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 u-boot@dh-electronics.com
In-Reply-To: <20250129111613.11106-1-marex@denx.de>
References: <20250129111613.11106-1-marex@denx.de>
Subject: Re: [PATCH] mmc: Fix size calculation for sector addressed MMC
 version 4
Message-Id: <174042883644.2441145.7831627238506648311.b4-ty@konsulko.com>
Date: Mon, 24 Feb 2025 14:27:16 -0600
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

On Wed, 29 Jan 2025 12:15:54 +0100, Marek Vasut wrote:

> For eMMC v4 and newer that is smaller than 2 GiB, the JEDEC JESD84-B51
> section 6.2.4 Configure partitions indicates that EXT_CSD SEC_COUNT
> should not be used to determine device size, and instead device size
> should be calculated from C_SIZE and C_SIZE_MULT.
> 
> This is not exactly accurate, the 2 GiB limit is not a hard line,
> there are eMMC devices which are smaller than 2 GiB and still
> require device size to be determined from EXT_CSD SEC_COUNT. The
> hard line is instead OCR HCS bit, which indicates whether the device
> is byte or sector addressed, the former applies to most devices
> below 2 GiB, and the later applies mostly to devices above 2 GiB.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


