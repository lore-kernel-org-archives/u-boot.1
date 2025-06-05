Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2169BC5B549
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 03:09:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22FB381E25;
	Thu,  5 Jun 2025 05:09:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S5lCEH7/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A23A38070C; Thu,  5 Jun 2025 05:09:17 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE5E08004F
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 05:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-60ef07eb7f4so273673eaf.3
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 20:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749092953; x=1749697753; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NB6hDrtjuBMrzig3pzqR+ZbkN1uNYbNAbYZnBcKRM90=;
 b=S5lCEH7/nAexslLhm4l20tf8gwP9s6MgmnmlvIOZKKOaKu/qXpuVQXWcvJD2xsghZR
 IdAwlMhz4sQdeyAC2/Gt0C8wp25dm7PVVk0TfAaKJ8welbYCDRVar4CbAKVzVU8DInmP
 1+rshoQxy21UXPU7O7O7NxoE9Nrv/dUJ4eGlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749092953; x=1749697753;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NB6hDrtjuBMrzig3pzqR+ZbkN1uNYbNAbYZnBcKRM90=;
 b=r7/O/WKAH005QpsJYR0F7rDbVr6+Ld6lewOd1/tSrnuEJfaUHlqa+YS/JXY8AYqdrX
 LTfNu11DIpAivy3WLyZdId8XIdftNQd0Dx+9L5Lwlfzns+yEcYwy8pMDtvPQ/uleCObk
 PqBK3W7B0K9bW81lk1dKYhHbSaldveXHAG47hFmeDgbUI6iXm8F2XwNVeUc9NRM4QyhW
 42u0koRJ1uvd8/5zzCGRUAUW728TrWvZQUHoXl3EJ9cO9l59BJwfEBthKjem+PlG2Vsr
 pM/N74532HH5w3hBAWrnv+plxZoW0hbYU/dhXCK1d05HGtZc8XY56qWRxKdGyKdhZG4D
 XSMA==
X-Gm-Message-State: AOJu0YwYXTz55mupAalW9JueuOYT1G6Ph3KG3Pa8ndXuh7jDNFZT0RGt
 HVmsUuCikm196nQrJkX0ZQWDX/+8aYZOYrZY3zFvFwg7PDvuFCCmf9CFHkjuKlVdqnaZaNyBnMe
 bseBOjFE=
X-Gm-Gg: ASbGnctk76zDtevlTaqnQllXxgdKBRIh9T+qYhRGvaphl4CXmAUNCnJ9isJWzA/SBgG
 YOv51d3994CxzytjjLxIeeywOY9O3yOqiVV3m41tDuXGixApUQ4qMV490sIN9mrJh1CCOV1ZOev
 Bk5XLYCXTdrumkQA8seiK82c8598MQYPq8PIk3pAwpOo7pTUo3ZvxqYAM0UNwx6w/lnkK1t1vBR
 92Twonr0BSe/nAwBiCz8rnJ6g49YXSURG8r3H1Eqf8StayU8qLi5q2ZBhS+3+ygJ8q+5/B0ywTn
 g7f/fGbyJMVb319sKjgIJ3UWPykMhkd6xu5xcH8nE1haYYQQXdzLEptA9tuChiF2pmgKnxWls44
 M74FcDpA4d8o=
X-Google-Smtp-Source: AGHT+IHNy93PNZaGG6/B/xHXNLB7d1aTEoujSAhOCC2PznPs4jPqSoSaHASo1kJgJu/KaKutRyl4kA==
X-Received: by 2002:a05:6820:1888:b0:607:8929:4501 with SMTP id
 006d021491bc7-60f0c70133bmr3132992eaf.1.1749092953626; 
 Wed, 04 Jun 2025 20:09:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60c14c70b2esm2518069eaf.13.2025.06.04.20.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 20:09:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Judith Mendez <jm@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250522150550.574018-1-jm@ti.com>
References: <20250522150550.574018-1-jm@ti.com>
Subject: Re: [PATCH v2] mmc: am654_sdhci: Clear UHS_MODE_SELECT when <=
 MMC_HS_52
Message-Id: <174909295204.1989110.6238142906761529759.b4-ty@konsulko.com>
Date: Wed, 04 Jun 2025 21:09:12 -0600
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

On Thu, 22 May 2025 10:05:50 -0500, Judith Mendez wrote:

> This clears UHS_MODE_SELECT for timing modes <= MMC_HS_52.
> 
> When initializing to HS400 mode, the host controller downgrades to non-uhs
> modes so clear UHS_MODE_SELECT at modes <= MMC_HS_52.
> 
> This fixes eMMC writes on j7200 EVM.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] mmc: am654_sdhci: Clear UHS_MODE_SELECT when <= MMC_HS_52
      commit: 2782ce5fce883554c968b8852a5ecfde0f2b9a95
-- 
Tom


