Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AC4C3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 23:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34A5687F8D;
	Tue,  6 Aug 2024 01:01:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gKsqmyqE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97A1E87FA7; Tue,  6 Aug 2024 01:01:16 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 779F187E96
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 01:01:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5d5b1e33fa8so28235eaf.3
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 16:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722898873; x=1723503673; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rWZd+OzQfd5rHmYtxJkH5yjQdEO1TqPsBYhkurUBbmk=;
 b=gKsqmyqEDj/0oaaiovRuXOsWD8FrkCHxplUr2xKq6G+NZUz50zxRkVycevztTFQOgw
 C0BJuh/TDKzmk3x0HNd7Y2FjzMiTZrJ9ZG5yZICQ51UEnfPTLQZKPRHSx+zrggLOJjrX
 CjWpBPuQhOA79+tTOq1kuWzZWkFNofOb0aZZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722898873; x=1723503673;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rWZd+OzQfd5rHmYtxJkH5yjQdEO1TqPsBYhkurUBbmk=;
 b=Kpyecxj+ZAuet08iPdHQv/70l7D6O2ZnX13xGqAph2GwLTGL0wwrrfDInsKiaWJGob
 jq/nZ86VduCedGZBXZ1bi5Ezqih0TdE+SJd8mINEwlxfJBWDxc1ecCfvy5vPm8M8yxcQ
 EAX+YPF5wS3s9iahT+1mRNSOpM/Vzj/VW1FpEUZgH5hQMWQbHnaYWOKS0Su/6rf8x6iC
 T+pNnF04vVCsuN1vtSliRmLd15J9w2IDFNgq2PBeSsCxMgMxSWcTVqTjmzcfqwcKQ7pi
 u7/9RB3toCAeUTdM+COBuzSeA5DBkqB4FZ+7Qpf9u3M9MJmR/2jEjAXHpeuDrgSb0oFG
 rTcw==
X-Gm-Message-State: AOJu0YxZCFWsyM88+us33/SPfZ2fbZqrfD+1KMSLb4dktv+sY/MxxTy6
 GmI5mtJL1O9aMBJR0QjXLyESGXkTtCZD92/I3jSuZW4tlgfIfIn404GzIPQFT2o=
X-Google-Smtp-Source: AGHT+IH6ajCKELSHr6jQ1weP4HENqAKX1XaUNVgGY2ez5J+ODaunB86HtIRGbKW9rzPuHaFrHkJDIQ==
X-Received: by 2002:a05:6820:612:b0:5d6:f4b:8fb6 with SMTP id
 006d021491bc7-5d6636d2cb5mr15455657eaf.3.1722898872884; 
 Mon, 05 Aug 2024 16:01:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d762052af1sm2246436eaf.28.2024.08.05.16.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 16:01:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Jeffy Chen <jeffy.chen@rock-chips.com>, 
 Jerry Van Baren <vanbaren@cideas.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 huang lin <hl@rock-chips.com>
In-Reply-To: <20240731144908.795290-1-sjg@chromium.org>
References: <20240731144908.795290-1-sjg@chromium.org>
Subject: Re: [PATCH v7 0/8] Bug-fixes for a few boards
Message-Id: <172289887175.1534766.18425865217287640060.b4-ty@konsulko.com>
Date: Mon, 05 Aug 2024 17:01:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 31 Jul 2024 08:48:59 -0600, Simon Glass wrote:

> This series includes fixes to get some rockchip and nvidia boards
> working again. It also drops the broken Beaglebone Black config and
> provides a devicetree fix for coral (x86).
> 
> Note that since this series fixes bugs, it is targeted at -master
> 
> Changes in v7:
> - Reword the comment
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


