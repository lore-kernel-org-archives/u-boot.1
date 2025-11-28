Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FE6D116EA
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 17:41:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14B3583BEF;
	Fri, 28 Nov 2025 18:41:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UTg0xK7I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46B7B83BC8; Fri, 28 Nov 2025 18:41:26 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BC4383B24
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 18:41:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c77fc7c11bso1565532a34.1
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 09:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764351683; x=1764956483; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8LEO7vuIBluFZEPeq7HzrQ6PdIu0RpsR1PYmYSGvRFo=;
 b=UTg0xK7Iuz4FFgOdROy2ZcTHwHLvWHL/IqvmqX9zfxaRAI7GAlOiBxstA6ZeCGI4h2
 DD7ChES9apVXhOgb13CabuKENdAQL+c5rAVi+lXiEN9U7eRV64Ox4Ofu0Tws4fmWgz9t
 MUbhzVCSpB0awJ5Ov9H6X3MYGGF5G5X2uMdho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764351683; x=1764956483;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8LEO7vuIBluFZEPeq7HzrQ6PdIu0RpsR1PYmYSGvRFo=;
 b=SBrl/kTrjrG0uoiXpOCgbpHQFBzGnojdcVEKGmjw54KitKlVpmNEtvpWNHHjzZxVNV
 D0/MLjIGNPM0FB1Kkrq0aIbIGNEqtUy4wzTfzWVfDR7aEwWPZXdxIlLwft2mwLqq7ywT
 cloPj2pje9T+95lTG5kMnyh5VkwJprbDHjircxwlM9mTy2ftGF4ABTS+RZLv5CJzn4mt
 j2qCra6M/m1hauYxxebO5bCzibiA/xSrvxPUe79fm1EIT0SgrpuNpBKCz/eq5E6Psasx
 07hik6IlSLom221a6L7yIdAaBQyKtQOOBsjlaR+jlCO0renggzgJVsi34zC/68mBM/is
 ffUQ==
X-Gm-Message-State: AOJu0YxO2aB1U9XNocWoQPgtbSfWcD7u0tHZiE2FyFLdwYbWkvR7y1J5
 4AAvKubTsjdFuVW7+VKuDpTohQ4fHrMfV3cvzsPnpZfb5RE33RXXLZKLvxlUe0XhIRU=
X-Gm-Gg: ASbGncuP+uulfyUqSvMX3pr5a+UO25ZJ23bQ9Qa7ZUlpPUZCztTg6FvMsQzyfFXJZ03
 QaoCsLPBblhpQK5loQpvWq9HAwgQG9S0awq3zE3W3g9ZDw87aGMYbha2pi08AvL1tttiowXcLeD
 UTV8wea6mKYknsIEb+1z5f6fmc+qw+omPAR1yzqHT97MY31hKjgSQ1uIH565IvWZ4c1A7uYXD45
 dSjq9n128cjIyZScZFhyfZAwCvcHhX+yazs02hk4jP9IZfGEKC1qBBB2yIASRx4d4u0QLt51udO
 Nj8R27Fv2RLNpJz4KESyhPRe5GP+phLeoVnbz/wTHzKZcwn+lxRKAGgv9sDwcC1tKcV8TfeYtDC
 WyGMj8Pf7yaf78oGXNGC2RxzX7+iAyb+H7k7037r2S1PjB7SziBRjWsgeCeEJcvdTVGFyvhSX2M
 kfEe41gCi/MeZ1PBZNEQVTHGPeYOR8Vsph2eGwg7hb9qxBl19+
X-Google-Smtp-Source: AGHT+IFWGlNThiJGgl+S8yrG+q+IoHIqBgoTAQ+NsslgxdMe22MeP2i6CqI7pxYXXtKJEcTKeY3afw==
X-Received: by 2002:a05:6830:1296:b0:7c7:53bd:23c1 with SMTP id
 46e09a7af769-7c78eb37c5cmr12142767a34.17.1764351682981; 
 Fri, 28 Nov 2025 09:41:22 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90fe0f650sm1771543a34.23.2025.11.28.09.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 09:41:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
In-Reply-To: <20251113115539.947871-1-marek.vasut+renesas@mailbox.org>
References: <20251113115539.947871-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] arm: qemu: Eliminate fdt_high and initrd_high misuse
Message-Id: <176435168204.233357.8916957152135655009.b4-ty@konsulko.com>
Date: Fri, 28 Nov 2025 11:41:22 -0600
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

On Thu, 13 Nov 2025 12:55:28 +0100, Marek Vasut wrote:

> The fdt_high and initrd_high have nasty side-effects , which may lead
> to DT placed at 4-byte aligned offset when used in place, which then
> prevents Linux on arm64 from booting. This is difficult to debug and
> inobvious, with little to no gain. Remove this to let U-Boot place the
> DT at correctly aligned address.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] arm: qemu: Eliminate fdt_high and initrd_high misuse
      commit: eb726cf6ae0e202f36aabcce88e21358cd3a7c5b
-- 
Tom


