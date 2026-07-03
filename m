Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFC6C43602
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 20:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C8FC84A5B;
	Fri,  3 Jul 2026 22:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i2PUY5iw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6EA584AB5; Fri,  3 Jul 2026 22:51:01 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CBE684AA6
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 22:50:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-69eb8b6bea8so407959eaf.3
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 13:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783111855; x=1783716655; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tzhWOJT71HGN+n3griNYdnr34QZljLFbmfhgpoLPRQ=;
 b=i2PUY5iwlbdvEDK9r8g7+KmYm4uiiItK/U7hl5djNsxBLsMOBcIHaJ9FmigE+pbb7C
 auEzqQ1bFPovdEWVYDhdYtplYKlY531v/wF1Sr8q66YnGE5IV2u/PzWzPgnxtMk4iv6I
 yWfeY8nsR8kJhCcdkZcA+ZT+GkbfxLE4stFP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783111855; x=1783716655;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9tzhWOJT71HGN+n3griNYdnr34QZljLFbmfhgpoLPRQ=;
 b=aWqqUTllpg6QvjauhXjrgptCFGkOKExAXiCZhArJH58C5inu9PRGa3rf1rxpOD98cQ
 GAm48Vb5lxPLtMq7TYb5WBDlyw8oiXBTJXefFxrZY4xxPbKkb3XXpHKs2da49ULra/wO
 pXs+IXQ04Kk1K0QrtcIaUVOBuQY56R9Otw11rOfmupLWgnxOk2wOf16y2zQuF5q4ykd3
 GZRubOIdpty0fxJJhd1qcYZj3FAOtE9W6+ZodeWjyugN50j82dAcONB7kJj28phbU8/E
 l+rtuFefTxtRH4hzGePuw/gQUpNYpkXy34++aUrjk2pRVwAlqtchHQzyz9xSxx7AAT6Y
 JUyQ==
X-Gm-Message-State: AOJu0YzVNK2M1R2q3k4eDIl3EiRaf4wbxcoWX/fLqpKfJWy25g1488nG
 ZlvWieONqY/5iIbDMEgTyBnNrQR+M3ANJHE4tlRBqsB9mrClS5EemXe3At+RsrgDxJdGrlqKfz6
 zp6sYM2A=
X-Gm-Gg: AfdE7cl0MW0L2VCDpcPBiLKNvvC0ki0a0WNcHrjChhnyZpnp0lj8h7VV+Ob0mwV1CR9
 pIYEA9OGprrAFPyAKM+KAl67B4TvL/m//OnsO/gIHDfMtMwCsyB2ko9h7pyd9fpPQr0SGBZerVZ
 BfpL4ZrJZ9B9ioFrFtLGuawictyJM0OPFaK0N8/V+qgU+FJ07m/8if2TTfLVk2XlIkEt8aqvlJj
 iv75j1nZzUkztnCxNLWNlOdphNH6zDNw+GEUE1v8Q/VtIX2/JhZXPP1o2OA3feWSXExK8/tSu8y
 /8kle17qpMjeObIDakRaHhh/tENrltzsnwoBx4tQ/L8Vrrs1+MCfLRds8dMsuXlNmRG56J07Yis
 cOv/aL1pUcEMMnB6qr4R8jUqskLi0MF/MbKZSU8loa6R3PCwG8GnmwPcqkqlJ1+H/WOa653yd3J
 HJhwGiO3UodRXp/E7yHKT3OlQ0edBY7dDbHg1qI4UvZ4R88YvCRgVLdSMCy77Xj1FO8nF/j+S1y
 bSgvDq1ptdyeouGukSv2K6hSH1i8p1B/dvH
X-Received: by 2002:a05:6820:810:b0:6a3:873:6163 with SMTP id
 006d021491bc7-6a32f56b4a8mr366373eaf.40.1783111855142; 
 Fri, 03 Jul 2026 13:50:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb6691d1sm3088491fac.17.2026.07.03.13.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 13:50:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, 
 Simon Gaynor <simon.gaynor@ezurio.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Alice Guo <alice.guo@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>
In-Reply-To: <20260625-ml-switch-ml-links-to-patch-msg-id-v2-1-1f15d8655c8c@linaro.org>
References: <20260625-ml-switch-ml-links-to-patch-msg-id-v2-1-1f15d8655c8c@linaro.org>
Subject: Re: [PATCH v2] treewide: change email links from mailman to
 patch.msgid.link with message-id
Message-Id: <178311185366.3143424.16176671305549432685.b4-ty@konsulko.com>
Date: Fri, 03 Jul 2026 14:50:53 -0600
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

On Thu, 25 Jun 2026 17:36:15 +0200, Neil Armstrong wrote:

> In preparation of the migration of the mailman mailing-list currently
> hosted on the denx.de infrastructure, migrate the links in the code,
> comments and documentation to https://patch.msgid.link to be future proof
> and always link to the expected content data and uses the message-id in
> the URL which will help find the appropriate e-mail in the future.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] treewide: change email links from mailman to patch.msgid.link with message-id
      commit: 08028efaaff1aacaa69ada124aae03dbfd16b4b7
-- 
Tom


