Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5C5C28B28
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 17:02:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AF2E81BC5;
	Tue, 18 Mar 2025 18:01:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FhPi5/mj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D26F281C84; Tue, 18 Mar 2025 18:01:47 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89A9E81026
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 18:01:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-30155bbbeaeso4954639a91.2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 10:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742317304; x=1742922104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+1edvZ1Ub0S/tdD8UOPTdWyE6iIorf3Y3khCf6s0NwM=;
 b=FhPi5/mjmtvrny9oWm0EgtPXIoC6RRuD/9QeWOCk3PKNcEVCJPnwXysFT5QmCO52P1
 zQOrwsLW82PmZFGu7XSbTodL+GTJDe4vi2fXMmp8miPbnWlbwU085+aX2thZ2rtDGwU8
 qO0bTw/OfOx4kp08UgJsL3a6E26MW0na0wpUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742317304; x=1742922104;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+1edvZ1Ub0S/tdD8UOPTdWyE6iIorf3Y3khCf6s0NwM=;
 b=H1NZrStVeedbN899X73x3PerszZpdWjXwW4vlVzNdAExWCzGXrCFza8jWtYIwMsT/P
 VJ/i8Pla9TOotblB8DMSwbZ2iiv0+nz1s2lKVrPvOqY5SQ8snVu5oSn+da4U5R3peUuh
 s49mgXctYvRC9wm7fqn/nkWPeU4CUlSrIFD8DEJsF2zNn+sesdfQ+qHVTbGy4r7zNI80
 9xTfrgt2CM6OUaCmpXWZVogkCF7pDSlMgUKPTfkZ9dUbwxPgh6fLyaSwaWWnNTvGgjc4
 3GfRETM1iK3kKmM9otY9AMdPCy8S5i9Ind1WT5syy1/cpC3S/QzCb0BF8+D65zW6zqKi
 nnXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWURBXUdj6AXjff1AeRNgEweZb/V+/Tqh1NNSKLLB5muw6GeliE3l0DL/j/NAi8vLwn6ES4D68=@lists.denx.de
X-Gm-Message-State: AOJu0YxbCbDbKBbJh8B/A0Vlx2igXGg02zxAL1CPcZYgiTjgLXWk6C6R
 wYFFjI1NBDqTVFvznN1nwIwCo36NqCJ43NismalDQkmHEtUIjQQsZoLsHutJrLs=
X-Gm-Gg: ASbGncs6mgr1GLEUCaZ/79o39Lm8/cP6csVEPA+S5jYo018jlRivykZqLAHaka2Qli1
 RD+HlCIdGZYHASHi5UkbdjORlQvjB/AFt6cccZ5n6wltHR5lAJt35MH4O06LXr+mRF4Nvap+uDu
 YvLqZAjDIy1V3MdZ99G5lMXmz2foZTq1W/6cSBD7t3fHOEuZr9XHzlfoDvhsW4znaCUkCo+tqH0
 /YS7nV0J0foFKVW7tecgFY/s8JwQmWCa+kosL2XxTEe/y6S2mKpCP/eku6we1G81GBjBdjHCAea
 gn+5W6BZFLScQ7xudSel82B7tXnkGvpxAOt10JjifU70
X-Google-Smtp-Source: AGHT+IEY3P9/69TRe5or5XXi49FESoprl4XfgmKbhPlhG7LV3BaDqylob7RLTiV/kAaCDLCPrD6daQ==
X-Received: by 2002:a17:90b:1fcd:b0:2f5:747:cbd with SMTP id
 98e67ed59e1d1-301a5b24100mr4664563a91.18.1742317304011; 
 Tue, 18 Mar 2025 10:01:44 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3015363273fsm8458551a91.34.2025.03.18.10.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 10:01:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: j-humphreys@ti.com, u-boot@lists.denx.de, Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, afd@ti.com, n-francis@ti.com, vigneshr@ti.com, 
 m-chawdhry@ti.com, b-padhi@ti.com, sjg@chromium.org
In-Reply-To: <20250305061351.1102484-1-u-kumar1@ti.com>
References: <20250305061351.1102484-1-u-kumar1@ti.com>
Subject: Re: [PATCH v2] configs: j784s4-am69: Enable UFS
Message-Id: <174231730264.1761337.1272571470280536955.b4-ty@konsulko.com>
Date: Tue, 18 Mar 2025 11:01:42 -0600
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

On Wed, 05 Mar 2025 11:43:51 +0530, Udit Kumar wrote:

> J784S4 EVM board has UFS flash, So enable UFS configs
> 
> 

Applied to u-boot/next, thanks!

[1/1] configs: j784s4-am69: Enable UFS
      commit: efaae94c02e7f93b95c7afe505b1b2102c2e45bf
-- 
Tom


