Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7560C7EE2A
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 23:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0EE982E35;
	Thu, 26 Jun 2025 01:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ddo9DYPV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B40982D21; Thu, 26 Jun 2025 01:52:14 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7405582D83
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 01:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-73a4c557d47so156358a34.3
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 16:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750895531; x=1751500331; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qBuKYD1Pgoa1qVp2GA5Gn5dRjan6tkOEBYXW0z1Qh6Y=;
 b=Ddo9DYPVCioY4FANiWcehwu0Wc+btQtVyPDVMfpfknYJ7mlOMogAFiZrRY7BUiN+6l
 RazVWn1Ch+XVbMBNv2GGHWr3zASczTAPgUm8EsJ7af3XwpduGhJeRcyA77iOZRIjD8mR
 lcc2ttZT9DqWm/KWVzJG83OV3XxGLUz9+5rS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750895531; x=1751500331;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qBuKYD1Pgoa1qVp2GA5Gn5dRjan6tkOEBYXW0z1Qh6Y=;
 b=HWcdKSGrworElt9dOrVCIRj/uILCZ8vbCAzyfJoMYtkZE6643lYlHdMHtUtgsCpNAP
 DuYKmZp4Inj+3GWtOmccwTiCQeeWRnjK36SDAwH9i+mvawkXQxYiK/w/IHPaOaKpMgmY
 HPTj0SV97XD4xgtlWMqbv/s8At6a787E8cnblErn6kInFStT9mgBu/BhNNFQcYXc+DPh
 afYdQcUMg4IgpxYSJ86595Ep9dz01fOeb+JAjcT/FOyMzXRcEiTGvTYnlLMOTR/XKkSq
 X+hX7tCtTfYwRdBJjf1MrKw7MebwVX45shAiIUPe86PjWg5JnP0biolOsjYthfKe/B1R
 RFJw==
X-Gm-Message-State: AOJu0Yxe5vyAE6n0FQBA9lmdvBEBtN07FyhmX26ukR1cFNsm9JD/vE6z
 F4Sowfb51TZB8VdYc2fZ4b6KwTyNwypD3DC8VT3b+T4UxmectSyLMp97RQqxYJhZHCHPsiL6a8q
 +an/yKv4=
X-Gm-Gg: ASbGncv5dL5Ccxj61ElRqXGfb4Ym0ZIPgFNTs/R73/LJwkfq5B2vBwqDnFn7NVz/CJa
 wd10An0sxsZVIangKq32fuvZyt32KsEECquxzCNmMDtsNi8TX6oOCA8HO2tEz2ce8afSMNOMLEL
 u+MY6d60OxLjJZDw0po9Zkg1jQLoTqe8TU5hPHfLbEiqW2KoasiTYPFioUa8orwk4G5t8lMSVpi
 T5HuXn5YGRV9rUKU4JKFj+QpiCcoJmq206NPCcGpfEyjfy0uLdiF3c0Lx9kvD0on/dajxg6uV1I
 CKnAxDaQXNrVAGlYeH/HSQ+8SKWcpk+/ysnO1SI16G8xbz6MkU52kUv+wckS3tmqwdvJ+PbEdiF
 vaOVHzi9gsGbVmBgIfDk5ew==
X-Google-Smtp-Source: AGHT+IGr6WmUCW/nEozedNwADTY5u/lv5S7xWT4ztuNHa++Z5+ctpcJXJ0aWywUEL9yJzb25G5zvqg==
X-Received: by 2002:a05:6808:bd6:b0:40a:f3d0:cef7 with SMTP id
 5614622812f47-40b05728c3emr4559776b6e.7.1750895530985; 
 Wed, 25 Jun 2025 16:52:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6115b6b3052sm1751134eaf.10.2025.06.25.16.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 16:52:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tim Harvey <tharvey@gateworks.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Vincent Fazio <vfazio@xes-inc.com>, Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20250602162515.1316263-1-tharvey@gateworks.com>
References: <20250602162515.1316263-1-tharvey@gateworks.com>
Subject: Re: [PATCH] rtc: add ds1672 driver
Message-Id: <175089552949.1525333.16238678778751950245.b4-ty@konsulko.com>
Date: Wed, 25 Jun 2025 17:52:09 -0600
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

On Mon, 02 Jun 2025 09:25:15 -0700, Tim Harvey wrote:

> Add support for Dallas/Maxim ds1672 32bit counter RTC.
> 
> 

Applied to u-boot/next, thanks!

[1/1] rtc: add ds1672 driver
      commit: e63e088b600df84b2259a06fcd0929cfe31c0cb7
-- 
Tom


