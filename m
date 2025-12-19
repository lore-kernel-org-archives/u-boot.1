Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D33E66882
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 20:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8C848309A;
	Fri, 19 Dec 2025 21:21:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NNoHBZ2G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAB73835B3; Fri, 19 Dec 2025 21:21:30 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84C3D803F5
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 21:21:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c6d13986f8so1783822a34.0
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 12:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766175687; x=1766780487; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x5bonrti5FluwqnbsM1uXHSx5pRT8Ba38Uat7459Eyg=;
 b=NNoHBZ2GnyrXc9JP1V8RqTYXR5vLwjtaYOhXQBXJFrLZebgkP4HXyPuAWKXFwGHRzW
 oVEy1H++u+Vl2+WHejrSlIogHACe4vyJxhFQzXzGEGO3CpOKrqIrjSjhS+mRfOwnqU6I
 g8QAfHqYn14Ti+sIPAeByMGlJlkuqBx50QiVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766175687; x=1766780487;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x5bonrti5FluwqnbsM1uXHSx5pRT8Ba38Uat7459Eyg=;
 b=A/mpbFXubiOicOnDcLiOKlb0kmeRSWBdueTXg6h+AUwLVfzpUIRSzO1OZEp/vdE//3
 KY3vsJqfCq3oOxhScgTlclxhS0SFMf37eZ85SQnGt8wtK+DF5x8y5ObyMeEKNPGd4Llk
 PTIcVgYuSRxfbBAZ+0wwmQYsN8C1nMhtWKi/foeKnm9MUqoZj6PBORLh9XuG4JsnnRW4
 xKuku483nnoEcIe0noOXwF0XDtp/FUbPZEwnYyqiISg9+Z84qfQ2gdGEl7bXyxK5dJ1l
 LhTkqYeRokQxrq4AoW/8pD6FYhXaN+mJCl+98KwgpRJqdvWkhfSxwSE0xDV1EAC8f+DR
 N9gw==
X-Gm-Message-State: AOJu0YwUmpaKwAUKuNFHQhhV+uXzvZJ29YArtVE/uODZkDK/xHzyFVmJ
 Dr3ykAITJGEiBxGv/iODS2XxqYFao0zwYlyk6FWbjiPliwYdVfrBJn3KpgRjXnPmK+sWVvTM8Dy
 DkRwSCrg=
X-Gm-Gg: AY/fxX6uFFi3ABihHj5ahTzCCvAW2D/vu16ciOnOF64gBgG85Z3mntOpluMjyU7P7+y
 ev9c74zqqxLM2ZnJm4hvrCD829IHwllIMag5U3noy0OXOJ0W7N/3EGN9a3Wn4p/kU4dZTVieUJj
 2V4B/Czq41IC8idCH6YjCOVvonRM0o3kRX7CRtG4EuysBlRST5fdq/1Wx0qITkuyECP5+ij6rI3
 po/GjrfZgSEKokMHsahryAaOUqTJLdbDVPSCN6IoEadq7Al7XSpm3hQsxRyZPFMdDBtNg03dywj
 U5RqlD/EuZZGikdwlmS2/9Nw5LwABhHgxHrZHpgdxziiHH+fel+JsvZFyFs1vuFdXAYCDUSehzp
 9oa6dqCdhxrjGBKaiqT/2S4z/eaS7GCGfk7GinSAumzyX36hSeeq8IPKlX8svCfyYnElv2HglHw
 I/cZyHeJCVdYZWK97snGuNpxXKxt05Gnw/uYxB6J3GegoaAEGyADCuuao+8kj3Sks=
X-Google-Smtp-Source: AGHT+IEmmSg9gid3SeScnmFxNyI9qAx2CTv2peA1iAOanu2F5sLUJfZT48J+guUGhsMPmbmd+dRcwA==
X-Received: by 2002:a05:6830:6e12:b0:7c7:ad8:68b3 with SMTP id
 46e09a7af769-7cc592a5296mr3733938a34.14.1766175687066; 
 Fri, 19 Dec 2025 12:21:27 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc6673c32esm2359189a34.9.2025.12.19.12.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 12:21:26 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/3] Enable / require DEVRES for devm_.alloc usage outside xPL
Date: Fri, 19 Dec 2025 14:13:40 -0600
Message-ID: <20251219202121.4180810-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hey all,

As seen by a number of patches fixing memory leaks, U-Boot has a problem
with developer expectations around devm_kmalloc and friends. Namely,
whereas in Linux these memory allocations will be freed automatically in
most cases, in U-Boot this is only true if DEVRES is enabled. Now,
intentionally, in xPL phases, we do not (and do not offer as an option)
enabling DEVRES. However in full U-Boot this is left either to the user,
or some drivers have select'd DEVRES on their own. This inconsistency is
a problem. This series goes and deals with two small issues that were
shown by having all drivers that use devm_.alloc to allocate memory also
select DEVRES and then we make DEVRES no longer be a prompted option and
instead select'd as needed. We do not make this unconditional as it
would result in growing the resulting binary on the many platforms which
have no users of the devm_.alloc family of functions.

-- 
Tom

