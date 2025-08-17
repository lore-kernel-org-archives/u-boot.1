Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23D7CA0EDC
	for <u-boot@archiver.kernel.org>; Sun, 17 Aug 2025 15:25:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46F1783B0E;
	Sun, 17 Aug 2025 17:24:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KDE7blhT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DAD783B21; Sun, 17 Aug 2025 17:24:54 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FB9883ACE
 for <u-boot@lists.denx.de>; Sun, 17 Aug 2025 17:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-30ccec50c0aso2700112fac.3
 for <u-boot@lists.denx.de>; Sun, 17 Aug 2025 08:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755444291; x=1756049091; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1t+EuW0xhYHzdDDjtiLA/oIGF0XFW7MAGWqK1Gs1A4M=;
 b=KDE7blhTyop2dkx6ksKvByIb47rlvlb1zu7IGNInO/KOw/iRI9ZEsh9jG6LkX8tNjt
 +Hzoz+4Ie4eLTrmuhiw0Fen7euivEs/0fs8R8ZsLKyJjgrtg7UcQK8LdeaQo7SqHQspK
 JLD5j7h8/+BgmQBN8De8NfZYBdVmW3bAe3yQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755444291; x=1756049091;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1t+EuW0xhYHzdDDjtiLA/oIGF0XFW7MAGWqK1Gs1A4M=;
 b=ASF5ocP3xV2bs1ywzvLoLhvMGeVM4yapVsz9TswKOEdS92mtNf5qq5PI/z6lKdPyR1
 07bFAwZkobNBlOP/PRj0X35Os3kZx2oZYAcUqYPTOw83ghO/3dEKJouGMO6uHiw28Ur3
 GonlJ9AIjyDcAzVyZjq46rqWme4T2shG7tGx5oDvUbzf33tKk6rcC0aHFIUDQxNpPuOn
 ynEhYTZZ0zzcADToinhAnVPk6i0xBtXgl4yi/RZ4ik3SOSYBBYKIH9x/laGCR5gij8Uj
 Gtv6sh7UwiBV3FoJpACfoXubEqlEYoGCFxXd1eDTvHPKMUMsi1nkj5IZ38jxhvpRtXbn
 Z6+A==
X-Gm-Message-State: AOJu0Yy/P2utJwSKazd8yEbSxZ4bUYob4xvDnzbmieS4cnUK+ymGm992
 8lrEqcOV4nVSG4go033sPNCLb7sFGUdxVY7nNoenPuF0MOeRHlmZ/BlnKPmh2CnYYti6Z8SqNne
 NCf0d/Bs=
X-Gm-Gg: ASbGncu+QL74099XYVF7yrBB79P1Kee3CPQhk+JocPdiWBVqrduKWR28Aqb6xSfC9vS
 8fCz+8QRtaF55LN747C/LjSeL0ltPikJ/KyG+W3iizFfzVJXtCZPg+mMMyZXDwkfRgMLb3onMNG
 GawG889575hVL7EaYYe2i8JKHq2h0+978dDOM3lSOS8P62RD9vQSawB10xeII8jA1Y0I3MtZ0sK
 gIuazFjj3csXOKdsf7K7Wv/gKsWuFJ0i3lib6vBlDXEl2e18QByDTEyAROMjN5TX8+/XZPmTHdF
 HNHVOXzPzbrFcPdIwJZaJ4eK3dnD8Zr1u08yj5o8gjrM4EysN3hn0X0eMbcnCZ6pxirfidWt+a4
 ymb7tfudL4Vgn1JahlF9QEDLspj7lL1f1MRLyUeGWQPvASH9WjybFuEo=
X-Google-Smtp-Source: AGHT+IH9OJL8GdT666eq53kjM2gc/LZOiX4/sUKCRGYur9p2zA7LeogEm6b8bVz2HhFeswLn7zlYmg==
X-Received: by 2002:a05:6871:7b07:b0:301:eb97:1f7f with SMTP id
 586e51a60fabf-310aacb473dmr4326687fac.3.1755444291177; 
 Sun, 17 Aug 2025 08:24:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-310ab878a4esm1998472fac.3.2025.08.17.08.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Aug 2025 08:24:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250806-keystone-usb-phy-v1-1-eb7d42dd6b6f@linaro.org>
References: <20250806-keystone-usb-phy-v1-1-eb7d42dd6b6f@linaro.org>
Subject: Re: [PATCH] phy: keystone-usb: Do not negate return code
Message-Id: <175544429002.372553.2139338338590851408.b4-ty@konsulko.com>
Date: Sun, 17 Aug 2025 09:24:50 -0600
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

On Wed, 06 Aug 2025 16:47:46 +0100, Andrew Goodbody wrote:

> In keystone_usb_init the return code from psc_enable_module should be
> returned as is rather than being negated.
> 
> This issue was found by Smatch.
> 
> 

Applied to u-boot/next, thanks!

[1/1] phy: keystone-usb: Do not negate return code
      commit: 26d9bd1ccd6b344d1cc9ddb3d50981b106fed3b8
-- 
Tom


