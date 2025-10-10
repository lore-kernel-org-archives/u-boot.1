Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5DCCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 16:14:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08FDF8424E;
	Fri, 10 Oct 2025 18:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z3T6NXQO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0561F84260; Fri, 10 Oct 2025 18:14:44 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E9B783FF9
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 18:14:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7b7325d8fb5so1497636a34.1
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 09:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760112880; x=1760717680; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jIOIr5tGyZQuRs9emvpayzpih0YWnwitNRWKYO96IOY=;
 b=Z3T6NXQOnwWFayb5pLQbqKA6xtet/um7fpEzYdxPhTNT3P0VDKTthw5wfCbsz3l6xz
 mnM9CN2w/XUNW36MR+PvdULQaPhZbDQ/d/QvMcA4td+RxZJhPnWBEll9o2gItk1dA6eK
 y/Iv9VQHYgsyacfQ16pKob4CUYUtjUiDTbfn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760112880; x=1760717680;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jIOIr5tGyZQuRs9emvpayzpih0YWnwitNRWKYO96IOY=;
 b=Ex3vOEVcDRzdUvVM33Bv3LIIfVonoj2V0RjStjIy5Oh9CdJf89PAXdfNd8nqMgqWoK
 3phTPRlFhpHd1/BdUJg2RPGmDMkXqdvD2x6irG9CmrC28m+zzVIgk7o+gj5lIYShbM3e
 S9EtsUgwpFVrBEIohCB5PV0fWmzHLGK9WP7SQc1J/pWHTOnWBWzJqAIUIerIhqk4VQSz
 PHTO2seuWrsgevjYPDY63nZx1hte1rbLiDTB2EhBsdHGnwC3LPvXP5gy4AteftetVre1
 5lNRmv/h+xcIN3Y86+eNxcjHNVMsTy9uV7QWQyn41VMBItdA6bIzJ+MXn2dYa2nFtPdG
 VPVw==
X-Gm-Message-State: AOJu0Yx6lO8bnysGTnYYvThCrIOgW9MDZ7OPWo/0uvrH7KmsJ34y4SM9
 nsqVV0VREJ82EJfjN6JqN5LyrPO+MnjU7kqWm0WZORpXWm/OjfX6HqnVWAiUtm184DvDP9gQh8K
 fTkHHtpc=
X-Gm-Gg: ASbGncvKgnZQA5lvUQran2kDCINnUb8XrflYIKD06z2rOniB4yLmeiLwPAX6vGJS0q+
 5vPBxwKRKzVoe+ln70/pHbKOnaGUv+aa2Ju0gS53Plzl4jgeU03cpmUxSChru5PCt6RgTkiby/r
 /7ndmMeQI1CoCe7lNhQbwTn4SgAonMtwFh/8uR4k33bJmsMUFSTFfveZW2KToGJbQXfC4/d90dn
 G2g427WPCtTplviU+oPNSueXHQyCMGOQrSQokdAUevD63sKz0VKnhKbKgPIKjC1GGO0Co8Wm9TW
 EGWfZi03m7pj18hDhymu6/J9lQUYLDakbNL4Rd0y0Tka7Nx9vUNA0NIozM0q35E5NRvfU/TwdjU
 nUe8R3kHe1tUCGzBhEy3KpVWeUPSro9WAyWa9xi9bvK0YcE6EIRcgwe99+a4gJ4cD9L0FknWsVj
 cKVtTYmHADJDo9eg==
X-Google-Smtp-Source: AGHT+IFdSDjRgIb9p4h4S+n0hWmFTsh9VpDmu/7RXb1UW6Om/5bc8AjyZeteX8XhMTdkiYAicjjbWg==
X-Received: by 2002:a05:6808:f13:b0:438:bdb0:89ba with SMTP id
 5614622812f47-4417b2bd64fmr4957185b6e.3.1760112880269; 
 Fri, 10 Oct 2025 09:14:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4419889cb7dsm716496b6e.8.2025.10.10.09.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 09:14:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20251010054725.GA17199@nxa18884-linux.ap.freescale.net>
References: <20251010054725.GA17199@nxa18884-linux.ap.freescale.net>
Subject: Re: [GIT PULL] please pull mmc-power-master-2025-10-10
Message-Id: <176011287965.1158309.888636475612439615.b4-ty@konsulko.com>
Date: Fri, 10 Oct 2025 10:14:39 -0600
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

On Fri, 10 Oct 2025 13:47:25 +0800, Peng Fan wrote:

> Please pull mmc-power-master-2025-10-10
> -------------------------------------
> Use dev_read_u32() for sdhci-cadence6
> Misc compilation/Kconfig fix
> -------------------------------------
> 
> CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/27881
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


