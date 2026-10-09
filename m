Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E048CA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 20:09:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09B7F81471;
	Fri,  9 Oct 2026 20:09:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BV8cJVuuzNRz; Fri,  9 Oct 2026 20:09:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D338081112
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791576569;
	b=pKxopm6k8ggGfKbCpCUTCRv9qM57XH0uIUUGCs6iNirobL66YEIukD2u8ScXrD0NYl8o
	 4Uz6maUDwCV4pRCD4Qi2v9AV+G29EPJbGGBhhdQvRchRBo6/V/3V4xMdRsfHH0tSVW560
	 8OFPj9DyhrZVJEjISopLpWDwe1YryF6sBPY2SZFp3ANdNPi3hOAZ81TDZMIlbKRZ9Crk+
	 bBsrw1kCg3BVPFWVGzmIfANGEB2AdGbNXSgiAo+thodtgcheb8hZS2XlBuxsp0cNp4QFy
	 ZswXFhD6Xsu5udxBWVaDa777iP1XyYV+04QR1BS6DzAq0l9n+MPyFDdI8C3URvu5yXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791576569;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0Q5h9aulu9Yn+ELTwduNFIWIoxhVvZoYMfTwsTvlK38=;
	b=PliITOY+ZBV+0x7dAQ2fkM1ycuCdG2eiL2AysFgP8baybkEVx5rULgeJvs/wCuwFqsul
	 YNBSLmogKeb2FGb+ZxR8RfPzoLSTrMlxU0N0ZE+2BI8tTAsUbPuI+l1m+7j0lj65+JGbf
	 JSlxPMpx+b/CjNdd8SzI3fBKU3+kEWcP4GvLwEdtghDo+jJudPOT6O6wG9CYxlInHFOn8
	 OTJo89Lw/93G9xK+mEkqHZvWCZTx9AabNjsnP74iaR8O0Du46r1rfv6m/7hTo2f+isaC7
	 doD5t7x8InwcecZMp4gFG/W2vNxTAWn/tP8SpF2MSlxOYIRUTvUKaA9zmCN9wOzcgTA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Z10DDkpc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791576569;
	bh=0Q5h9aulu9Yn+ELTwduNFIWIoxhVvZoYMfTwsTvlK38=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LXx21BJ1Q2WInNFm2lXDxhKKEItDVNdEHd4JSM9Bc6AabopYVN2yNzVS5yznp3k54
	 yLorwP6cKPV9n56Anky3gFn71rVNUhtgkkGgNhuxwzm7vCeGyIPs+Z3/sc1tG1ApGt
	 eDBAvWIov9ZBfX2CncSJSohFQEE0YzSni5vBz8jf5CKKDdLijscUNCLilVtYmeXWDT
	 03+6/lZa9qkCR7KuNT4FmIi8FrHJZhz+rpLDR81ffC8exLUbRXw0abGgnMU4mOmF0F
	 pEaZgrpg0pQ4/ZS1mEqbDjwrAVut1e9GBJ/UmMUi8eQrmSXhk8zikxctHzwDBNXWcK
	 g0hehGcnBMidA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D338081112;
	Fri,  9 Oct 2026 20:09:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B8E7380
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 20:09:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 681498110D
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 20:09:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QxXvTjdH1bxR for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 20:09:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 99E9D81103
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791576566;
 b=QG5oCcVFl4H/Fa+HsheV3YQ1B17KdgPH/EeOvONHh3z8k7s1cXxvw2P3NZCLReuJEFGw
 nWdguKiAzVAENzUnj3J6IFzEBoQ+9YY4uNlZO0QuqxwDEDYUjofQ+PJDezfbm+9fn4DYA
 ywOxNqRCsWf5Pd6a26SoQPvizijRg6atYGjP6UNss6hS8c9qLcm1oovu4aQiAMn6cULyf
 5oKh+kSs4KtfD4EadK69xdLyCBSTZXMgE622DHKwW4dyp+cviun6TzhQZn6cO8K2jM+uR
 RzUdE3BKj98ubWqrnGfHY9cXZi+Vj4L+E1NBnv2h0AdYLPWBJDmS6Gg9zS9TPjrUuaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791576566;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=0Q5h9aulu9Yn+ELTwduNFIWIoxhVvZoYMfTwsTvlK38=;
 b=lxmObti7wH9sdsWcV8hdN2l78+TNGgTifuvOoqXTiGeNatEqbdAoxBQ3DUzBsYNQOn0E
 iu83Gm9Ux2AmJcHOpjhuK5SXx10NZMwyDzG4jsAn/YEhi/puRSkHjKN/IKqJGdouKWF4e
 ScBRbA1QddH6zBT4ENhvduKL4gkka9JDhZc09/uVZCt6gL5uVxD1DhhbhpMJoWQ3NaMRs
 gOD+L85M0e+sNCuD6J4PVTqIwTCK4sl1dqR4kAvgrVgJTWn8YsQlBWpUjBYZ2aB/Rd3Yy
 KgKaD8n/Sc6v0oJWDhSgNesmj1eHCOv5wg0NWvcaiq6l/FfHoHnzN36TztKaSGY05nQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Z10DDkpc; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Z10DDkpc
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 99E9D81103
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 20:09:24 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-824329dc1ecso148174a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 13:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791576564; x=1792181364;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0Q5h9aulu9Yn+ELTwduNFIWIoxhVvZoYMfTwsTvlK38=;
 b=Z10DDkpcqCIOK0JzDidNs1Gp3mIfA+a2xr9G0kFeAyaWEcyr2+vtYOqgV4syXGgWZD
 Q6fbgoocbbeq8VfxhyL2/Zu8rUq+83eCGpH5VHMK/gbhb9AyW0njKYYbCguh5kGNmM34
 m9Y43rPiSV8cpoJVE2vrzejtF/n608kDwQZAXwd23ZgyZtEFiq+4PS5yJpfRX0BeNN5I
 5ggND/bIxPVgTZLgZ9aJrn2AWJ1Y4jGAc1EP8t802TL7nx2KLxz7KnBjGnLZFqmfZV+P
 BANS9AaFPpWuSj2zRI/9OXszyh2rWu3VU2ChiW45UeYo4sPsOzmlE09h9ZR1P2PyrwkP
 oYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791576564; x=1792181364;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Q5h9aulu9Yn+ELTwduNFIWIoxhVvZoYMfTwsTvlK38=;
 b=IllY/t7S60PLSt6JHu1tGk1vmvTaLrdt7BKGrPVCPM99Z4ODCrOn3znAsv7+Ry7juc
 C0fszwCWrkNodToU0w8Pg1H5knzZY1ZJRMHrlhDx2WPxAz5BKHrqK/FzZa4JBioxvAjO
 PpdGOxynGh++PO6bGhqJNhYtIFU28GZM4KwI7DKoMwChyCnmdb72vxRDVHtcnk6u4K8O
 kGWwG6c0zBOM5HJyie9upTCquuganNkAtAqiILfgkjB5VzZccVWuAZarf8pOC1+qFDH0
 Ys9XshLfXGKEfBiU1QKWjKYvYW/t0qD2xs3o1xKwrA87taoIAX37l6oPs9inMAVhS1cO
 T0hw==
X-Forwarded-Encrypted: i=1;
 AKwUvByiJi+2cGpDqU4zkdNdHDXhJKIZ5HvZbeOgyjaZOk7EFe8HkpyWV1zAur9U2QSBtlO49phzbSs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lQcCgGZdWhTZHOHAYib61w7kdx5euBQ18V5uwHKZuIEKvO1/Cx
 UX13R4X9HucUYBJVJ9g/MoV+3r24kW30SrI8f630zIfk+jlBk7PnDpEEHL1FNubyauA=
X-Gm-Gg: AYBFou1JN7/YjwTtOjEfAdKTSPNlV/HNbqnLiaASDpoLmK4phkLUM76YNpAw0WP+i+p
 75LWYKFOFrgMZklJ4wq+NYdLyDl7+uaWw8GrDODwWK7g9XH2L7b0goAzJdNIQuGo3VweStZj8sA
 K+yqoOHM8Ba6RvEbSFeZb4Ub2VVQZqoEuqXfNI7Oal94+jRJQlFcsCWSNVfPBNF50oKj7X2f48M
 yKqnNyoiMR05XkvYsHc5jN10hkfkv0zzIg7CoE81inY8orZLCUN/UZ3MOQ5+9++2l+Vt/0cUATZ
 CIlvLatUz27G9/zrKHlbZdV6TdYs7p52WDfVPJX2HxOn/zotH8mAk3OTVVphty9qt8qya3ddnOR
 +HRVscCEtDxNU+tJqpgWcu9xxSNEnA5aQ1+HxoFkoqF4CslErNVEWhb+io/G30+m9RGF9bhLknL
 op6mZfI5zLJQyY/Gzn07VuUd4Z4/eaND7yLMaO98231ax8cu4kH8U9cnZpO3vALrVRl0IsMesQ
X-Received: by 2002:a05:6830:6995:b0:80b:95aa:5c2a with SMTP id
 46e09a7af769-8309506c076mr2471268a34.9.1791576563958; 
 Fri, 09 Oct 2026 13:09:23 -0700 (PDT)
Received: from freyr.lan ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-83039d385dcsm2718388a34.21.2026.10.09.13.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 13:09:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream@mediatek.com,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
Subject: [GIT PULL] Please pull mediatek-for-main-2026-10-09 into main
Date: Fri,  9 Oct 2026 15:04:46 -0500
Message-ID: <20261009200920.2438383-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The following changes since commit 0a55b098d6f5f6bafa84fc2f18b433dd167bf729:

  Merge patch series "rng: airoha: add support for the Airoha TRNG" (2026-10-08 10:41:43 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-main-2026-10-09

for you to fetch changes up to 35ad65d943257d2764b342033aec087961b27eaa:

  pinctrl: mediatek: add pinctrl driver for MT8196 (2026-10-09 14:37:45 -0500)

This marks the conclusion of our year-long quest to reduce duplication in the
MediaTek clock drivers and make it easier to add clock drivers for new targets
without having to invent new things for each platform or follow confusing
conventions that had evolved organically over time.

And the very first patches for Genio Pro 5100 are starting to roll in.

----------------------------------------------------------------
* Fix MT8183 infracfg and MT8518 topckgen gate lookups
* Merge the per-block MediaTek clock drivers into a single driver per SoC
* New MTK_GATE_CLK_TREE() helper for gate-only clock trees
* Consolidate the MediaTek clk_ops into a single mtk_clk_ops
* Match the mmsys compatible for the MT8189 display clocks
* New MT8365 multimedia (mmsys) clocks
* New MT8196 pinctrl driver

----------------------------------------------------------------
Arnaud Ferraris (2):
      pinctrl: mediatek: further increase max number of base addresses
      pinctrl: mediatek: add pinctrl driver for MT8196

David Lechner (18):
      clk: mediatek: mt8183: fix infracfg gate lookup
      clk: mediatek: mt8518: fix top gate lookup
      clk: mediatek: mt8189: match the mmsys compatible
      clk: mediatek: add fclks_offs to struct mtk_clk_tree
      clk: mediatek: merge the of_xlate callbacks
      clk: mediatek: merge the enable and disable callbacks
      clk: mediatek: merge the get_rate callbacks
      clk: mediatek: merge the dump callbacks
      clk: mediatek: use a single clk_ops for all drivers
      clk: mediatek: mt8183: merge the apmixedsys driver into mt8183-clk
      clk: mediatek: mt8188: merge the apmixedsys driver into mt8188-clk
      clk: mediatek: mt8189: merge the remaining drivers into mt8189-clk
      clk: mediatek: mt8195: merge the apmixedsys driver into mt8195-clk
      clk: mediatek: mt8365: merge the apmixedsys driver into mt8365-clk
      clk: mediatek: mt8366: merge the apmixedsys driver into mt8366-clk
      clk: mediatek: mt8512: merge the apmixedsys driver into mt8512-clk
      clk: mediatek: mt8516: merge the apmixedsys driver into mt8516-clk
      clk: mediatek: mt8518: merge the apmixedsys driver into mt8518-clk

Julien Stephan (12):
      clk: mediatek: mt8188: make the clock trees static
      clk: mediatek: add a helper to declare gate-only clock trees
      clk: mediatek: use MTK_GATE_CLK_TREE() for the gate-only clock trees
      clk: mediatek: mt8183: merge the clock drivers into a single driver
      clk: mediatek: mt8188: merge the clock drivers into a single driver
      clk: mediatek: mt8189: merge the clock drivers into a single driver
      clk: mediatek: mt8195: merge the clock drivers into a single driver
      clk: mediatek: mt8365: merge the clock drivers into a single driver
      clk: mediatek: mt8512: merge the clock drivers into a single driver
      clk: mediatek: mt8516: merge the clock drivers into a single driver
      clk: mediatek: mt8518: merge the clock drivers into a single driver
      clk: mediatek: mt8365: add multimedia clocks

 arch/arm/dts/mt8189.dtsi                      |    6 +-
 arch/arm/mach-mediatek/mt8516/init.c          |    6 +-
 drivers/clk/mediatek/clk-mt7622.c             |   10 +-
 drivers/clk/mediatek/clk-mt7623.c             |   10 +-
 drivers/clk/mediatek/clk-mt7629.c             |   10 +-
 drivers/clk/mediatek/clk-mt7981.c             |   10 +-
 drivers/clk/mediatek/clk-mt7986.c             |    8 +-
 drivers/clk/mediatek/clk-mt7987.c             |    8 +-
 drivers/clk/mediatek/clk-mt7988.c             |   12 +-
 drivers/clk/mediatek/clk-mt8183.c             |   64 +-
 drivers/clk/mediatek/clk-mt8188.c             |   97 +-
 drivers/clk/mediatek/clk-mt8189.c             |  112 +-
 drivers/clk/mediatek/clk-mt8195.c             |   45 +-
 drivers/clk/mediatek/clk-mt8365.c             |  117 +-
 drivers/clk/mediatek/clk-mt8366.c             |   82 +-
 drivers/clk/mediatek/clk-mt8512.c             |   52 +-
 drivers/clk/mediatek/clk-mt8516.c             |   45 +-
 drivers/clk/mediatek/clk-mt8518.c             |   55 +-
 drivers/clk/mediatek/clk-mtk.c                |  439 ++----
 drivers/clk/mediatek/clk-mtk.h                |   32 +-
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt8196.c     | 1905 +++++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |    2 +-
 23 files changed, 2278 insertions(+), 850 deletions(-)
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8196.c
