Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93A6C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 02:17:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A888A81F0D;
	Tue,  1 Apr 2025 04:16:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cfxQRCh4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C58980584; Tue,  1 Apr 2025 04:16:45 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E03580584
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 04:16:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72bbead793dso3817659a34.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 19:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743473802; x=1744078602; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kHsOGuo/y2X7tDLgqeo2HFgtXO2ltDDUAGY5i0n0CNQ=;
 b=cfxQRCh4XyjmfHwqjet73HG5VV4gbsJTUohbayQsWAHFqD44MprRsYtFBGNXCwFH9L
 dp03mhrEVgoyCkfTfbbzp2+loGGhWV3P2IbrVZ8A+VleGszg2vjQOHlmpCayPcecwpDF
 j6JR2GgwnmtV26NktuA/WEO2Qxj1PvtZ7fYfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743473802; x=1744078602;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kHsOGuo/y2X7tDLgqeo2HFgtXO2ltDDUAGY5i0n0CNQ=;
 b=uqqnqi1f9B5eoJ9siqwJYKEwLmfGCcSFYUYOK6TIdeRDlS9ZMAIjpPeAhgds8q7ArL
 bkR8p6W6gv0pzPaGHjFR8sB6p8ZWp41CHBKs2nJIL953C0wsQsddnoCzYvHYlkB1veDr
 M04L6UHzgyU56kUWhZPK3hgztUyKBqlLRdSDw2wJ8pTNdZJbcXMYBONRfyvRb3Z44og4
 ORW4SfBt4RlVnFTzjkSgEI66Ygei2LgIx3KxUP4w8SWpkMQlMYjme+UCwSng2sq/sBm6
 8jtiRAw3nNazYm8GlkS1zLsTZZgj0KEeanY3TVHVYQTDBwIeBa2gJI7fGxeLkesPGo7Y
 Arwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPHkQfVDwDMI5pYHhJ1ctPPE0GNhYSKg9fqxS+Sw5M8/0q8e/E86Je8eg8UiEurJrlzA60RpQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/ZNmmQQULyPg1tYKM9eBep/544R/7FCRU69ndBsTiimrxWuue
 EkSLFaZ+8x6DQKwLFuC5k7JHyHtqShf/BTtoHaVozxxlXp4AnxcXlLB2OnWrZEU=
X-Gm-Gg: ASbGnctiitcd4OHAFYDByKLT5KlgkIZRXujuAHO+w4DDdkIZ+2TA6VcoKUCZT56xXd/
 LvxckDR/BQHVr84ETHNhRWkdiYmV/YPv8Kgnx25jyiom6v1+dzMih4+4sh1OyWzz44i5+/kvuMe
 /gOwvDzPtcnT4GCDpriB+MqKnJIQaPahT6RbTgCnkKRgpme0LsoHPNgWtely0nbMo/WmSMy6sA1
 QWU3GLrzwxdBvs8mpGkf1SakH5t3vgaYzFnamsQDRGuxMwaHR3/r7nsX4UHf4wIIri6ecVVF43t
 A1PZFQYq/0M9UvC4DX2rDMint2dus/CrqOxcA8u+QJEnkDPKO0NPyq2De8Sf+/GqfU1DxuIM90Y
 LAcbC
X-Google-Smtp-Source: AGHT+IHqcPhwebwS8VVHdIITBOKiJY38jT1t2lajuJtbvJK48AXo2/6RDmh7lUGH4hEfyczSD8LSSw==
X-Received: by 2002:a05:6830:2808:b0:72b:9dc8:7f30 with SMTP id
 46e09a7af769-72c6382d179mr7488092a34.20.1743473802105; 
 Mon, 31 Mar 2025 19:16:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580b5401sm1704892a34.18.2025.03.31.19.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 19:16:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, Udit Kumar <u-kumar1@ti.com>
Cc: n-francis@ti.com, u-boot@lists.denx.de, nm@ti.com, m-chawdhry@ti.com, 
 j-keerthy@ti.com, m-shah@ti.com, a-limaye@ti.com
In-Reply-To: <20250318184628.3309548-1-u-kumar1@ti.com>
References: <20250318184628.3309548-1-u-kumar1@ti.com>
Subject: Re: [PATCH v2] configs: am68_sk_r5: Enable AVS config
Message-Id: <174347380077.47384.1079392171958740238.b4-ty@konsulko.com>
Date: Mon, 31 Mar 2025 20:16:40 -0600
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

On Wed, 19 Mar 2025 00:16:28 +0530, Udit Kumar wrote:

> Enable AVS config
> 
> 

Applied to u-boot/next, thanks!

[1/1] configs: am68_sk_r5: Enable AVS config
      commit: b0899e4451d839dd8e6240d999b33fe9779b895f
-- 
Tom


