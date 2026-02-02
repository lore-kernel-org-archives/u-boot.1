Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F125EE7FDF3
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 23:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F33F283F53;
	Tue,  3 Feb 2026 00:58:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b9QAVtfg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5F3C83F75; Tue,  3 Feb 2026 00:58:46 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7A6483F26
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 00:58:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-45f171cb842so173666b6e.1
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 15:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770076723; x=1770681523; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tGleeV7fdUo/8mVvOIv5yuKKEbe1tIkEkUN0wOxN37s=;
 b=b9QAVtfgQVefoXpxp6xq3cmgWyHgRhGN1rQUQebXsXuO7AHQ0FdsXqRbz3kRaTg0Gh
 Ch9ao85Jkl0FcKm18Dm03CvbwK5Nw2aZAsMpuNrvLgPlXm+wQJA/M3V94gDBJzTwj8MQ
 UqwxtfWVg1QhKbW5loCb6i0zSwxif+/c2mPM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770076723; x=1770681523;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tGleeV7fdUo/8mVvOIv5yuKKEbe1tIkEkUN0wOxN37s=;
 b=nu10T036EVgSXs7Fw2+IZE2PB2aW/Zy7JTZMSyciH3cOLQ2HAM/JB8MJp2wXPoP/gl
 xidQue1crUw97Wl0R9JXHBUsB04/ri33307nwL9hXH/yIKblAqVjctZ9AEqtkT+lfyiD
 NkJ3nfQfZJ0GnIb7uHiL1pGsOdQL+XEb5Zm7Ff6DuEZC6UX7E9fVL9VgEhX1gRZVVodT
 JyTXOs/N4B+34ZPEBAIcaNmznRA4lztPZH6LuG1qcrh+lXvTfUAr0cSocD6Uu0sGMbxZ
 RzCpEXqCHE3X5a8ViLoo0+xOHRqhtXLTuejotci5ROQ1GYv6zNnL0RH9h5RprJYOy7X/
 dpdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIJV7f7wHnkI9YE+TB7dftW3uSfleXQ3m6sxlG/E0JNfjPbndh7o1MbUYnQVmrLmYdlCNzmmU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/EK8Nqp42HklLULQIIIuhwPr1CKGoVkBtNWTQjvcQKWO10aNZ
 ZChIWxPd/iiDftvBnFrIbeZK0bXk/V0FwQC2bS6FTGqK9H/SGnJOAXuQsdnf8rveUHoyp7s9FCj
 eAW5iIa8=
X-Gm-Gg: AZuq6aIPO11iVg95OiE83epVHPYyt17HRuGmewJt+6/klTvBmoIKk3vwU7NCUnLXX4J
 GhQlcUk5vc6NBxQTGNt+RIdl+lgDW3wNvHPOPhqT2JR/0W/6o7uNIqGbl/iyzxl4LvG0pFN1bDE
 P6OwcfRd41mNp4eC9a6RmL5JLxZFEeBVNJLATj/WvkgrnyvhL73KMiwQuPNxs9/a2Y6pEd5qknk
 VHa8U1ojOyNcm+qRjVsvrrz7OfnnIkS9FVO5XtV3b4ILsLNAy0As9MIoruK1UfVO14gDiPIJ+Ha
 /gBboH0U/zrbT1a8/0O7mSWqTz/ocgvgE8iJx2QG04XTO9zMC1rAtVFokZbaqeR5fLCmiyyuRHg
 7T9y92l9SPpadjmPhpmZds7GcuP2if+KdJtwICbsZzQ+MJBUAUjTuwNn71+n7lcopJNYdRqucNa
 I5B18YMK1v830OVNPGzX1wK7ywMNEq4Exbx5L6ZdG2pepSU4T90VF5Pw3PHVU71Occy6fxk8r7H
 5VPQKzGtkhYUrpJS8VYBK6eKtkmz3JmRcK1tQ==
X-Received: by 2002:a05:6808:11cb:b0:45e:e070:4733 with SMTP id
 5614622812f47-462c12a6fc9mr609820b6e.33.1770076723436; 
 Mon, 02 Feb 2026 15:58:43 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f08fb635csm10081404b6e.21.2026.02.02.15.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 15:58:42 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>, Dominik Haller <d.haller@phytec.de>
Cc: upstream@lists.phytec.de, u-boot@lists.denx.de
In-Reply-To: <20260116014116.767555-1-d.haller@phytec.de>
References: <20260116014116.767555-1-d.haller@phytec.de>
Subject: Re: [PATCH v2 1/3] arm: mach-k3: j721s2: Provide a way to obtain
 boot device for non SPLs
Message-Id: <177007672182.4123720.15307098187425616366.b4-ty@konsulko.com>
Date: Mon, 02 Feb 2026 17:58:41 -0600
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

On Thu, 15 Jan 2026 17:41:11 -0800, Dominik Haller wrote:

> Introduce get_boot_device() to obtain the booting device. Make it also
> available for non SPL builds so u-boot can also know the device it
> is booting from.
> 
> 

Applied to u-boot/master, thanks!

[1/3] arm: mach-k3: j721s2: Provide a way to obtain boot device for non SPLs
      commit: 22d24ee4f6b4d53acd3a56fcd271613e60f66417
[2/3] board: phytec: Add PHYTEC phyCORE-AM68x/TDA4x SoM
      commit: e9fa9a2fe325e7030f01f3bd62bf4d571ec6a6c1
[3/3] doc: board: phytec: Add phyCORE-AM68x/TDA4x
      commit: 2a6935eee25e09584dbbe4565b00e33de9ef325d
-- 
Tom


