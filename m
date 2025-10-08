Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051B2CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 21:00:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E34E883EA6;
	Wed,  8 Oct 2025 22:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Um70d/i7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3FC983D40; Wed,  8 Oct 2025 22:59:45 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C91FF83A44
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 22:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-43f802f8712so196877b6e.1
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 13:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759957182; x=1760561982; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H/O/6gf/i2iIWTJxzojWI1QmoXxwMnlG3ULBzUb3vCQ=;
 b=Um70d/i73av3s4nOTdDf6BOPdmqViV466ERYokmL5XlwcCjYOSkC57JkLBw16WZOXA
 c2YRXTA/4HRFHFC4q4my7xiQfYjn01pHgPWaGY/oT3Kr3+B1e8V86pZWSdDwZ8LzrKV0
 zxCsFopHyRcwFB53AtvJ9oWHk/YgHxLqEQKB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759957182; x=1760561982;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H/O/6gf/i2iIWTJxzojWI1QmoXxwMnlG3ULBzUb3vCQ=;
 b=J6YmnvjhPtDORAMIMBNVc0Dn2fTdtYLqD+yjbe0mrXaoqGN38D5SOwWoQ/S3vh0NS6
 pUB8n7UVr1zz8OKSY1Tshgf9uIqB3E7SrgtTNjoHUHMfpak/Qihu+gVfFzEwo5W6/b2x
 CIpWgt8/MFfuTjQVTYUbYi+rmHUxje/4va7hCKguZAvYPVy6VXT6RjGt+6Vq6B1b+ily
 Q4gI3pvM/x4mkpdXi/OuDN1iiuSJ01iCNpOXR0tjBEztNMcDasvcBSfX1CfeXF1qwboH
 MbAcG79BB4Ggb0BT0UMXg1Llgid3L/pOCYR6d8gjCCJiJ+letJE7jQ8b7MSMJRM0prEy
 Ci5A==
X-Gm-Message-State: AOJu0YwZhS6VWYD0raSnnt98ztR4qWTlY6rfh9f9A893ZSqSgsKhcJgF
 sKw6S5EaDDAeIgOzQmeQHYDHgfdmuLd4FtewATC7NFSo+92RivknVD8uRpXttvvOBj2rB2F1nbV
 TzISb10g=
X-Gm-Gg: ASbGnctVuRz51W9XNtEtu71+tvEvcsh04wZM25kEKzWkyfarVQWFTfkt8tizBAaLkJi
 +LMJgnKtEd3W9qEIwmOTpZWWAKaFM2ESJPzEjmJylH54+UpXum+m8d54wqupHDQi/4hV0g5tLm9
 gtSbI00DMRInlr79d6J3BIhEs2ULmQItmI3vyrad1aWzHr0f/Ir2tH9cdyXDrXiFO/DwYKHqobz
 in0lcYiR/IebXxeFK94RCnodj0Bw0N4Nl8Y6WFuN9ckZtRnBTsexk9L9I9dE0VwaI1iWIx8HLsP
 fCG0gf+WYVmbwGu8/JHS6+/DAOdX4VEMkP2YkLASA+7B2NDjg+TGsTbKl2tEctOahBvr91+ZCBY
 OzEF4YsY/b4BVsr14i4UmzVXT0dRNNl/qJZOU1gSd6iOEmUtiKkiQLP/YMswtdcqE8LukcOLvBP
 6OoDsUTVMSs26GatU1kto=
X-Google-Smtp-Source: AGHT+IGAxqOvOtDsH/RJECCCZR0wXQKSYGRlUAHCKsWgd/v3MeLSdhQXQedTbYuWtE3n2AYWQkXdUg==
X-Received: by 2002:a05:6808:200a:b0:43f:9a92:fd31 with SMTP id
 5614622812f47-4417b3e0df6mr2589780b6e.44.1759957182598; 
 Wed, 08 Oct 2025 13:59:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44189a67d27sm226052b6e.23.2025.10.08.13.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 13:59:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250925205612.3562525-1-trini@konsulko.com>
References: <20250925205612.3562525-1-trini@konsulko.com>
Subject: Re: [PATCH] gpio: aspeed: Make U_BOOT_DRIVER entries unique
Message-Id: <175995718181.3059512.1399971836188740741.b4-ty@konsulko.com>
Date: Wed, 08 Oct 2025 14:59:41 -0600
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

On Thu, 25 Sep 2025 14:56:12 -0600, Tom Rini wrote:

> All instances of the U_BOOT_DRIVER must use a unique name or they will
> lead to link time failures due to name space conflicts when both are
> present. In this case gpio-aspeed-g7 was using the same name as
> gpio-aspeed.
> 
> 

Applied to u-boot/master, thanks!

[1/1] gpio: aspeed: Make U_BOOT_DRIVER entries unique
      commit: da93f8a078b40096da740562d3c5c2104f8f3696
-- 
Tom


