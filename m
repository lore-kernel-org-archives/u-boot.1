Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C910C83F34
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 19:43:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1751836C8;
	Fri, 18 Jul 2025 21:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YTi/LZop";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72C2E83537; Fri, 18 Jul 2025 21:43:29 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6599E83537
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 21:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2ffa81b41d7so850173fac.0
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 12:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752867806; x=1753472606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dK0zDCn/d8D6jjnTcT1/UZexvhgHCTSq7PXqc6FQf8o=;
 b=YTi/LZopotHKXX+0V6EAC4pk9wTyh42YKFEx/c38ttrJR2nd3PLZzmXruw+1CwTXOy
 FzAjijvrC88HRny/yL5FFXSGXAyWbBCAzJgIDA6EK4tLwwWlQTtFFOOSM4R6W9ZvVFxv
 rlohudK+PFAvmyvdbJzJlzL1Msvw3KhOGXRyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752867806; x=1753472606;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dK0zDCn/d8D6jjnTcT1/UZexvhgHCTSq7PXqc6FQf8o=;
 b=F9vw2f+vOy5F+s4h6TjRnHTH+CxomqZP9h2jsr+KHqqErfgCg21GPaNOsgRhY2I4Nn
 aEQtTtHanvvS+Rqa3qCiw++pc2rrTx6WvKqN9vy+lxGbT32RmvuCfUgcttB9QbsCEkGw
 dUmnOUys9ik+69XPB3yrExBXi7m9u0fq0lAvMKxGULbSJ/Y9nlj/NIBcJA8W9ACijhB0
 G/wWzaZYJoPwF98njjF1JSdKZZLvYpotk1gwDoNch5m/fBdsV34nuKGhoLq1y7yPTuYf
 PTSq+UxziMGnq1gkfi+BJiby40DufbtBOxedQ4oRyK2DCY687XTC2KOntGJ5Vcp1TMcp
 yA1Q==
X-Gm-Message-State: AOJu0YwZOiyuUTiVKNqpZ6R5+uYsYaLDFstGZqBIu08lxCkpQDqNqr+K
 4PxfTOAWJ45o+sjwkkMCHkkqHexl6hwD1VEy6rpH4M2FlS1dv3Z4S36O9anpfwhTH3YbMsV8xch
 AijrEsTs=
X-Gm-Gg: ASbGncuKMwvDQeINc/Q3HIjCEAQuJnP43LECH7uljI0pMeo7zH+z381+hCxc7Bx8Ktu
 ZMBTOHGX4+n5LdXpke+s7wM9+yIr//u4aorYYLOyk/3LX5pg3PwahbCRnga2OshB5geiIIgNEDz
 jTn0AfZ/bOsDb2gwhviNBUD1xyGomI1+UAXeabKTiq10HxHs5oWO2otpWl2NMpeKMfvFXTPyzqn
 f4E89PRkbbs1WjYojOqHDtCaX/c1gvVWY28KlWfhusPuIu0CKVG5ygdwPmDy0f0xeqN6XMl/+Qg
 IKWotCcU0iK6GyvGY4A74bHolo/TXxECq++lqt5OqyxVUQOC2zCKoTXiWvgnRiKG5x96/z+M5sS
 vwBhhOsm0p52g7hXrAD4gOXbFdCaQE2zS+nj+bnEVw8A8YoW4QR7XJbs=
X-Google-Smtp-Source: AGHT+IFktyMIkvGHiUFMK6nodxXuDZX80WYCVWrJ3rsgL4+G11dnVN1pZyopFFFRUp7yzfcmeu7Nbg==
X-Received: by 2002:a05:6871:7383:b0:2d5:ba2d:80da with SMTP id
 586e51a60fabf-2ffaf5c8720mr9300734fac.36.1752867806023; 
 Fri, 18 Jul 2025 12:43:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e83b0be4csm871076a34.39.2025.07.18.12.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 12:43:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250711152016.2225486-1-trini@konsulko.com>
References: <20250711152016.2225486-1-trini@konsulko.com>
Subject: Re: [PATCH] sandbox: Add dummy sync()
Message-Id: <175286780462.1647311.14387154250431154943.b4-ty@konsulko.com>
Date: Fri, 18 Jul 2025 13:43:24 -0600
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

On Fri, 11 Jul 2025 09:20:16 -0600, Tom Rini wrote:

> In order to compile more drivers, add an empty sync() function.
> 
> 

Applied to u-boot/master, thanks!

[1/1] sandbox: Add dummy sync()
      commit: 786e1f6dea07126b0265fcb6e8f5010d8d3e0e40
-- 
Tom


