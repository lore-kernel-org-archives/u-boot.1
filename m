Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC8ECAC583
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 14:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FE98831B4;
	Tue,  9 Sep 2025 16:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DNh3F2AR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 612B2831B4; Tue,  9 Sep 2025 16:13:24 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A826B8313F
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 16:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3ffe6666f8dso13255895ab.2
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 07:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757427200; x=1758032000; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ju5RSt5InxPsQL7oM7ne6Ilhoki9oCUGzBVwamg+L2s=;
 b=DNh3F2ARPm+Yye45S3vwSTfnVSGux1VfKKggo1DP2DLDod9WGelBycPKQAGLVM8KFf
 1ubXwxhSSd8+DLNFonHjOvdD9f9L43ZLQaSiSiJ43DGj6OKcmtrSeeIbEjx4v8ITzkCQ
 DZb+uFC/sVlg5/J97yB7QBlvJ4KHovW/EIh/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757427200; x=1758032000;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ju5RSt5InxPsQL7oM7ne6Ilhoki9oCUGzBVwamg+L2s=;
 b=RZhbz46PdcRWRMEYJiqPZWw3Ccb8BFLtVM33+oWSsz6LjGafqzKCDY/Y1drRS14Tzk
 zvJ2oukHArjfNeUEftGV8M86iUfBH9yj8ydCLwV5uZu8cQ5a6zo2OI2zjyDapO+aOgy7
 LQ9PpHvSNkaLkfGy6+gHdoqEA95nv9wdTKFLeMMldsfaWwu5PEApTu2YIBwztYCwO71I
 2tUVANzGH6aQbw1B+9xCSHskXSxdemofYD64H8x/8Rvkoyx/wWf0E4LRiU48A/kEBHJr
 wG6vXKLbhhFWVGKI/RHQ8P+8E8oxS4R8oZjPihqm3ZOLXXtmZnhaYszSsAycYU9j8IDI
 /dfQ==
X-Gm-Message-State: AOJu0YyNff8o05AFa7bEJpVJ9OQBaysNmleect7DrX2Binzs5fJvNsHy
 eo5j5orNPfiQW7vTkKcsKEdu925mfVmMdYC+KKEkx4ZC2yEQJE4YBDPK1gcM/qSTfgCXGODqsB4
 0n5XTHjs=
X-Gm-Gg: ASbGncuFiaAo4QW9TxFjmKiO265QaFCLdUSWFCj2K0mwCDex9oePqf3TmnNt/TCRwdb
 5jc23wUOSMcE7IFZCC4Jc7IMlfKzqJ0qQCcf6zgxD6KI/aFfADM4UwFaZ++tjFhj3Fn4PNmug83
 t7rj/vskZZ7tRkze/akZOd18EDF7adQOH60f8dtRqarKfUvfX7sjssjl10MRUP6SFDLpayQsUR7
 6Scg4AEmD9LA8vnkGXwacDO3ZH7w62ZyyKxBOcizolAHeAkQgc/GYvYWuH6YSmJx1GP4vHpm+VZ
 Qu8TANOavjP/uA8D37w6C4bovo8dWEesxRSKU82wwvxhZVhsbvx05AQnUa7jlOpukRP2X7t1fsF
 In4YhO3ryKSQpwYftyuk2XYXIs2Urk1hylgnQR3U6RnGcItAr0MEL/CE=
X-Google-Smtp-Source: AGHT+IHlfogZYhmPFJtPiG+MHk4y2tPcYGb6sXf/lj+R3TiER0VzIzS6ksV3j8pUKNgc0ZKOlnwelQ==
X-Received: by 2002:a05:6e02:3781:b0:3f6:5e42:9ec0 with SMTP id
 e9e14a558f8ab-3fd8e9913fbmr173721695ab.13.1757427200197; 
 Tue, 09 Sep 2025 07:13:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50d8f31d0b6sm9669006173.42.2025.09.09.07.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 07:13:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, E Shattow <e@freeshell.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250901112748.676541-1-e@freeshell.de>
References: <20250901112748.676541-1-e@freeshell.de>
Subject: Re: [PATCH v1] configs: starfive: Add visionfive2 CONFIG_DNS enabled
Message-Id: <175742719929.1649309.9266872764656995759.b4-ty@konsulko.com>
Date: Tue, 09 Sep 2025 08:13:19 -0600
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

On Mon, 01 Sep 2025 04:27:40 -0700, E Shattow wrote:

> Enable CONFIG_DNS for visionfive2 board target. With CONFIG_PROT_DNS_LWIP
> enabled and CONFIG_CMD_DNS disabled this restores DNS functionality
> displaced by LwIP DNS refactoring during the merge window.
> 
> 

Applied to u-boot/master, thanks!

[1/1] configs: starfive: Add visionfive2 CONFIG_DNS enabled
      commit: 1a7882de8c859467ce931ed23761db1e391aeaff
-- 
Tom


