Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17496D6AAEC
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 18:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E9F383D8A;
	Thu,  2 Apr 2026 20:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fQYDhcIz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76DFC84099; Thu,  2 Apr 2026 20:46:04 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 048DB83CF5
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 20:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d744d9acbeso485071a34.1
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 11:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775155560; x=1775760360; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=imOIsDEI1LuedJfO9LCO10gRNRxuLRbTwvS3zQYfoaA=;
 b=fQYDhcIzGOPfSw4ODtwfG3uwWT2KVP8NLQJA5uBkhd1oa27lyLyTAQfXDg2IQSDiqB
 eQHFi7vfBvlHKdUiFGZyyka1wS/v5MqnMoFrNlApL1lap0REQojzW3xj+vDkXvATH+Kj
 XM5iYekQ8pBZ95PNl8vsHYfCsiH5dINv5a6RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775155560; x=1775760360;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=imOIsDEI1LuedJfO9LCO10gRNRxuLRbTwvS3zQYfoaA=;
 b=jGdrPtlaxhpCBBVU4oJY3FVT+lKE0g+emSOzdY1+4r7St42LZ7K5LIGlfJNHPct3lu
 7/qjtcysUoMzl69DwkX8BTbDraHVBfsWRrNHmuqWC2KiNaRBDiEjxVRSevECIQkRERL4
 48LhDUWhfRNBtHEuF7uvI8oyUrQZuJ3Uec5buEdWQV8cwSD0dPS+9kfc2w3E4EClNa98
 S/Ni015y0hL65tPedEM1ZFQlAuaYWHdvfaaVWeVlGQ9NRExvGuoYfLsqtBU4G7bMA18F
 WWbY71byWYW/xuxVOgd5+EPkgDnNanMjw0vB4eYPymHX9MI7zxUg3d6WhRsRqpvuT4TU
 nTKg==
X-Gm-Message-State: AOJu0YwzK3KKqpIMrA4Kk4hcgUT5+F6X2XU1VDvow6uFqqO0bv4e+MTX
 9eWCp2lavQQS/Xi6TFK0/0EqA6+4DqUb4ocs8P41IakUZMwOvyGA2J1acqs7/zYCqlY=
X-Gm-Gg: ATEYQzzH+Dlom/R8kph6LzKSWwQtYC860WQObws9m0AhiRp9fRanmeahtzNxvCiy0jW
 C2GuDDhS4RsnvwVW8guumerhHIJV3Amr6HJLiTJdvtM9rEfGplDa5jKJVQobDLRM+Pu01m8HYgc
 xR4tqXmR6P1gUidBtcZa8T8BVbxwoozLH7mI9XAA8+jZ/OsBMijVgXjUPPSXLT5Y5rE9UNnDxxH
 2Hj87JDVE/o9tc97NQR1vRt22o+R5/4pUKDtLYNReXwqSYpavIjDptfMiFZT59pCpYXrJxnix64
 F+noCI4gyvD4i7zVbmvG9ghkwW8pgwjHojqB12NIJRFXLThXANH6g2W3JZrRhoN4g5CJlkx0DXs
 933qDbRdu+62cNuOCqUYn+Bx52Iwrnjcrg3LmrPCTwfYQp37bHHoEVkFafi7aTknYZ4pi9PXrdz
 pWmqEnhqKSRQhpw+Scyhjhw53udT9keZKNUeroZCqnhTejXaqUCgFplw1Y8EP0nqoQI/8H3RbQ+
 DTVvkxNskTzldt/a5vNYU/0OnKcD4VfjPKT0rU085KUqLEARzMwHW6L6A==
X-Received: by 2002:a05:6808:4f64:b0:467:1c9e:2121 with SMTP id
 5614622812f47-46ef4f07163mr277735b6e.1.1775155559626; 
 Thu, 02 Apr 2026 11:45:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46d9044725dsm2085830b6e.8.2026.04.02.11.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 11:45:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Udit Kumar <u-kumar1@ti.com>
In-Reply-To: <20260329231557.332469-1-marek.vasut+renesas@mailbox.org>
References: <20260329231557.332469-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] arm: relocate: Make data-only relocation mode
 non-user-configurable
Message-Id: <177515555837.1935668.3910713476575027256.b4-ty@konsulko.com>
Date: Thu, 02 Apr 2026 12:45:58 -0600
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

On Mon, 30 Mar 2026 01:15:16 +0200, Marek Vasut wrote:

> The data only relocation mode should be selected on per-SoC or per-core
> basis, make these options non-user-configurable. The SoC or cores which
> require this have to select this option using "default" keyword.
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm: relocate: Make data-only relocation mode non-user-configurable
      commit: 91c27b21b10f6cadc906af66355197e12409a543
-- 
Tom


