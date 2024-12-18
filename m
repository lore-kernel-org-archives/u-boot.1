Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61FAE7718A
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 23:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23EAC8034E;
	Thu, 19 Dec 2024 00:26:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GZ/TXn6d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 303B38021D; Thu, 19 Dec 2024 00:26:16 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA63680241
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 00:26:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-467a0a6c9fcso2162971cf.3
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 15:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734564371; x=1735169171; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W/M4MDzxfcf4H8KbA20QmbB6gjM2PQ4AmeJeP0qxkuQ=;
 b=GZ/TXn6dxN1qbeER8gtv1CEJwyFSrwzCRnS4A0/PSVBKcIhUEAW/gXmZt3w6t7D/KW
 bo760CIgJKgOFOrVmbZc05JNO4PMspZUYKZ4vG4EHDpevBcUt5dQBKLITq0+j8h4rhK6
 /R8xdvqoU1lkdok//oPjPt++jidgV86/mB1hM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734564371; x=1735169171;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W/M4MDzxfcf4H8KbA20QmbB6gjM2PQ4AmeJeP0qxkuQ=;
 b=CEFdDaBOyen5AvgmjTjh0r7A7kXOnDgV7OG4IlblHIyMdKt/NXzI6RKqkCouAOjhh2
 whLxnXqCKlSgX/UFw/o/eGyxqsbDIO4Rb2JBgEfkiLDCd7TrDLQ2PvPkV7gd9qw2/6mP
 VG5mkDJojptDptZHd4EkEOB/voRrhiJsHyx7yH/6FmpAXfbBvscktTny4I/nwcyanOzK
 pCeplH0JFw/XwjUn0pIurBTF0AxHlAEMlcguLII0+7a4zZpS9OwqrooezKsOzEMELwLB
 plwt4M8Sh59RoKoO/uOCpVNOrvS6tGBc56MahxL9WuoErojBvS34+PNSttaFZQc4287x
 5SgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOrwy7y7ZcaV/I+04g40nKNd9xWw3WsowhU49q25HQVRuZrh6b+ZjxX3ZNCjDwjukVWxIWkrs=@lists.denx.de
X-Gm-Message-State: AOJu0YzmCuk31/N7IBej8jWSBkLPYqQt8Pm9ClR6vbmMyol3/IeymC+J
 MIU0fPPuiz51rx4o7meOIS0X8NBJwaxOYAFpmu1uKpagO594f2GuHIl066QzazQ=
X-Gm-Gg: ASbGncu14E50DtkUfEZnpoMgfsjB4D6D3JARdSiFRA05rVTpTpsS7FYEQxXqrpEiwpA
 7h3fpljcu7zczvhk/bWktDO9YJBtKgCKHPgs6hMQLvzzIFqVx2QM+31xPM+C1zsvHhTreTLPK+m
 QR65fwRuEug6Zzny2BUkc/oYRPAXauWzOPOGOyPncSZn5U59EKReuOMItWDdQPkCxXQuN8e9kZT
 WS+JA0W2oQqlOiYoWw4Bpt/dXNDnSJ6It9mtlC2e/1d/kecjDyV7XY=
X-Google-Smtp-Source: AGHT+IE+b+5Wp2eq9O9LCEZSHR57idCIvJREolJsNXD3FfPlmCrG/i6hfgthxt1KQ8p2hGmN63GF3w==
X-Received: by 2002:a05:622a:1801:b0:467:5c9f:9fec with SMTP id
 d75a77b69052e-46a3a778f73mr21984181cf.21.1734564371694; 
 Wed, 18 Dec 2024 15:26:11 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e653f52sm270821cf.16.2024.12.18.15.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 15:26:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Raymond Mao <raymond.mao@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Levi Yun <yeoreum.yun@arm.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>
Cc: kernel@salutedevices.com, evgen89bachinin@gmail.com, u-boot@lists.denx.de
In-Reply-To: <20241202-sandbox_repair_of_embed-v1-0-05aff4b0ccf7@salutedevices.com>
References: <20241202-sandbox_repair_of_embed-v1-0-05aff4b0ccf7@salutedevices.com>
Subject: Re: [PATCH 0/5] sandbox: repair compile and run-time for OF_EMBED case
Message-Id: <173456437018.3535347.17482506843014858383.b4-ty@konsulko.com>
Date: Wed, 18 Dec 2024 17:26:10 -0600
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

On Mon, 02 Dec 2024 16:45:21 +0300, Evgeny Bachinin wrote:

> This patch-set repairs ability to use sandbox with CONFIG_OF_EMBED=y.
> 
> For now, to use OF_EMBED, the following must be done
> 1) sandbox64_defconfig should have:
>   ```
>   -CONFIG_OF_LIVE=y
>   +CONFIG_OF_EMBED=y
>   ```
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


