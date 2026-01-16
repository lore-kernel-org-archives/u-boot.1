Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEE1C982E0
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 17:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0636D838A5;
	Fri, 16 Jan 2026 18:33:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XOjsJp1m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D87D883956; Fri, 16 Jan 2026 18:33:01 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC98F8394E
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 18:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-65f59501dacso1681472eaf.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 09:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768584778; x=1769189578; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+uLGZ+nZfbwrmia+4ZZJdnpZMwA3yR14x3DotWC3YM8=;
 b=XOjsJp1m15DHgxEtCTxqS2vA39hIA/W1LxmI6PkSeR3+/v4Cbk0OG31crR9KWIku+P
 OfGZ6Mx50Jozo7rNj+ZShFH9kXG58pH4KKdysJ1wxGPeniTpsYtsFZ3OwE8jsrhA9rSA
 cOyGjTCXbGulrJaWDw6HV3omD3M3SHe2qEnVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768584778; x=1769189578;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+uLGZ+nZfbwrmia+4ZZJdnpZMwA3yR14x3DotWC3YM8=;
 b=qEZ7xsCRaLzD6hx6RcBKiShxAqteD46NSeanSQGroN2yOzM6++KkkMH8/PST1+6cOK
 QhZFKelV26t4BVaNh+0QZLIpjLSUXP2eK77b0BoLRUIg7t0UF0o2mKj33uX+wwKYvBOe
 SkkSxUrlsKE89SO902FA3fNoaJIAgUGdiZx7xwB61CQOzr0MrOkLKgBE5WZ3qT0DnZRE
 6WEiAqxIvpoDuSl4Z8AsA8qh1HuXYw6ZUCJJG8PI+dhMgtHCBP2J+aaShLzFGg3Aa3ez
 PnGSwKBcHq7t2Ud6/x1aXxZhXYlIeUuuwSIWq336tJM6LALkyjVowja92vw/eSRdxadS
 13ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7JmF3kQKi7JiclfndUbjCtHLq3RJY93k0b/aJsitGlYlNU302pwXzhxjyZ3JaHlcRLrHGhQo=@lists.denx.de
X-Gm-Message-State: AOJu0YxryUad7LsV/WCpiVRX8gKuBzF6LEq3mrphF2qLfbJdITOtsTbz
 b0pC2+agrq3FqjCn0oUdBN049fKheGE/+WVCMXbKv320nSiUpMeU/kUhvk5CRHna5Ko=
X-Gm-Gg: AY/fxX64KNQ7eQN/XWMw08oGmWF0biFDn3b+e48+FUi82jG4s66mbzgF1l4suy//6jA
 hQSHN1jXrWaarY0OIXuYtnW7ECoSvIpsYz169Y2N2mqHBCeNuK6cRJj8t6oL/ao2o3SsAVeY0uL
 HVOU9mC5MmBXPEg77xrKN7ayStp8ULMt4JHO2UsiSLRs570nCRo3VVFhBY9kFujDnJKQPkeGegt
 hVZaTEcDrlQsr07so6Zd4NGd8prIjDQgsdHQQG19gxG3PGO6+Gy9gopo6dqh1xymVztCY/vBjIh
 BkAtfi7PF0tjRHWW9BIshrsKR8/N3HOCmC45jd5IB7n5K0tcEK7mKDUy97HY61as0ZF3rdFGJjg
 0qzE/awQhQkcYKr/J+EJSfzcezuJTUL5K4wJ2Hu4dwTxnW8M2YnmngthuNURDrEpW8ZYgdU6fKe
 qoCRFX72tvijwKcwhS5nUXSiD3l+Yi6+7aiYCVb5hjt3ewp8mrDZoYxLzBkK4RdCnbD7xfxGfqa
 jqeWgj2KAPXv2SWyM2GrbIVinOvc2dzbewRGhCeiuKajjuj
X-Received: by 2002:a4a:e917:0:b0:659:9a49:8e8a with SMTP id
 006d021491bc7-6611795965bmr1650414eaf.14.1768584778443; 
 Fri, 16 Jan 2026 09:32:58 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-661186ca7aasm1494068eaf.2.2026.01.16.09.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 09:32:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260105-mtk-remove-empty-gpio-header-v1-1-01dc6c70eccd@baylibre.com>
References: <20260105-mtk-remove-empty-gpio-header-v1-1-01dc6c70eccd@baylibre.com>
Subject: Re: [PATCH] arm: mediatek: remove extra gpio header
Message-Id: <176858477733.4075554.16537323112384895931.b4-ty@konsulko.com>
Date: Fri, 16 Jan 2026 11:32:57 -0600
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

On Mon, 05 Jan 2026 14:47:21 -0600, David Lechner wrote:

> Remove empty gpio.h header file and CONFIG_GPIO_EXTRA_HEADER on
> ARCH_MEDIATEK. There is no reason to have these since the header
> doesn't contain anything.
> 
> 

Applied to u-boot/master, thanks!

[1/1] arm: mediatek: remove extra gpio header
      commit: dc82599c45b31b84fcbd0e9c0bf2dcf73f004391
-- 
Tom


