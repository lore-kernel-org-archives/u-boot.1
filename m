Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FFEC55174
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 20:31:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA66780D18;
	Fri, 31 Jul 2026 20:31:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YiG4bGF-dWD3; Fri, 31 Jul 2026 20:31:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C529D80B88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785529914;
	bh=JdI7aOb1osiIOZMcUQE2bri3pHUevDCPf7zpG34SVS0=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zVq3/UhnxW2mEbpIEYz+8po8rABr+QC65h3pFwTOfpG9OpE4CBUeTSCXxEDdcpF3i
	 OPanzPyz6wOIf8suQrzIQY+FsGV9PK0gzZNV7GUTA3m7/NmTi4Tky8WKZOUwNx8qCw
	 b66ujfAzIqtSFd8DhIj/CId1/lAMU+l294TEwWBbtYiYMz3JP91yK/Ydcwjl3IrPLc
	 VVYuqLS8vr/CVdvXVhQvrol1ViSBdc1jywZnKO5fiM0wO9rTdUPMoLcqAb4zsStjBh
	 spxeHJblIH9cWwz3TOtYZraX9661n/5WYfh2Qf4dsKadaaqibswyt1vefWj+kpO6Mp
	 iALfoM6J/g78g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C529D80B88;
	Fri, 31 Jul 2026 20:31:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DAEF636E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 20:31:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C142F4011C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 20:31:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SdE46f9Q_yp4 for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 20:31:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22a; helo=mail-oi1-x22a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2A1B440119
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2A1B440119
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A1B440119
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 20:31:50 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4a456e44e01so756927b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 13:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785529909; x=1786134709;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JdI7aOb1osiIOZMcUQE2bri3pHUevDCPf7zpG34SVS0=;
 b=QJNoIdpzQTjIrtnkrqDLQLrbv3x3lvRsF/UBCk5oyDKER8q+KmVa1TELyAgLuVGRkr
 FTqoNnEUSY4qCMk7F6vwJdKJowzj1qGfInknV6eeGjShsx7FeSGTU4XleFzNFmUQ4AuP
 lFDYhv0aLBe9zoYJ1vrwudKeEE2sFHBoCltRUBdY3nCt9wYEfh63E/Y7m+yV935BJ4N9
 ikJB17lfM0RM01HkSDjJBV48cSYWmovWtd6TDMvg+a6k3ySJPKtrPHo3HEE+f0uPfFsu
 ZTJgLsLIWoNkKfIeiU1LdrFEkBvBpBb+wyA2lFVxOQNVPMFKSxPjw5wW9QKdWV4BGXys
 OBsA==
X-Gm-Message-State: AOJu0Yzg2sdHZHIk8V+GuEZcqd8KO/T38sheGOi3d/2vim+IpVrXja03
 MIJ7lAuDMUivrn8rMTloSGvFIVyl2SqyTXyaXp43PoeSn77EP42aCgmy1vU2L+xIdWo=
X-Gm-Gg: AR+sD13W2t4zB5UW/iqr46jOLDjGrWj7TUpSVkw7XXFu/KuELt0vM+Bi9Ni+kWAyc+G
 oxFOTV6bODkkuKy0aF6188CulUsSPkkhj9LGNd9rG0VDzxF0rngQKRj+A8r0AEvfIeVJfOKfFmX
 DuEuuawoRPZ5SRl/VB5rSevXQo4sdf930SAJL718Qq+9W+W36T4l45rFwsW+uNLuqaXX3ifJvHi
 Km88HxgOEK3r4fMSxbwV1YVmGMaV2H9UNBKpp/vYeumgfjerTYprH4On8oOQ3ENK7+u6/9Nqa4H
 HmfuF7UcZe4OrP+nMKIEfRbEQWSX9A2Vic0BJYAHGvzf840uRfyrkDvzB2mmOf0Bpu1RJajRBLc
 MSGB1i/V68vxF8Ah6awmKoeRvbrgmj/tZ0jvphef69b1+3ZTj9tju0Tv5JboOsABFO7mJeX8UMu
 jvJytaXEUs9DWr89ihTdmsVafiDbarJu3EO61vIWfqmtDHpLj9bPIk0xWYT5Xl9BLfY+SpMqo0l
 YVk
X-Received: by 2002:a05:6808:384c:b0:4a3:f4b7:cbdf with SMTP id
 5614622812f47-4af5e2725cemr2639329b6e.15.1785529909349; 
 Fri, 31 Jul 2026 13:31:49 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fa40:746f:401a:3b75])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4af58ce0a1bsm1445791b6e.2.2026.07.31.13.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 13:31:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] arm: mediatek: use phase-aware PSCI reset
Date: Fri, 31 Jul 2026 15:31:25 -0500
Message-Id: <20260731-mtk-mach-phase-aware-reset-v1-0-90b918aa52f5@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBAF0KuQWTsJhWgTr2JcDOVjRwOSTlESw
 t2tunybt5EhKYzO1UYJLzV9TgXuUFGIMt3A2hdTUzen2reOx/zgUULkOYqB5S0JnGDI7MS3Hh3
 CcASVYE4YdP3ll+vftnR3hPwdad8/BNv7DH4AAAA=
X-Change-ID: 20260731-mtk-mach-phase-aware-reset-1a737ebecf5e
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=754; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=oppungmdgIkonDAAtOFlxUBjJ2B8q/j6buyy64QojUE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqbQYgCUm2OmRoVqiI+n4fOdPZ5cMG6l8/MP+8D
 0epH3Q+itmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCam0GIBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AiOYH/0KX7xqHGzykbWahXDe+l4mR0HEX36rhItG+tDr
 EZf8dlV/rC1AAe2esROtX27pjVLNnXcy3gamymfP/6ZpTZxSEFHvNCzpkY/4oVmAzQ/PvxKfVst
 eAzSuaZijwe72hEFZOXSeOulxHhT479I25SCvwE/2h0hz03vT88s5aRZM6qo0fsf7ba9gTrymNB
 7V2tOgJzPh7bNxivmbiUGkSCjs624MxpNYJu9N1KKpUM62GfVcz6/O9wUhYYq9kDOirbadTwnT2
 BWhCRuk+FkrIEZce2KDtOblkiLg7vmHQtLoAFRF/jcsSw/gZj8SIq7zghzeFycXEaE7jPPdZJrq
 JjCU=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785529909; x=1786134709;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JdI7aOb1osiIOZMcUQE2bri3pHUevDCPf7zpG34SVS0=;
 b=Sxm3Hu/I81S/BF7P7N8u+DhSENFzKVGIfQiUVXexyZsfmdifdDN6+ocCdVOKAFHF2I
 9qfrxozJy/vakEeKDXF3XpzfzHrmAjh8NEV9dnMJKHym3q8eDK4DVvdZ+FN2IT7oPZPt
 eKHCfBziALWo9T13a1oM8Mgfm9ebr5hPSqFF2ImCwXWkCdeOT0U4XQRQAw1Fvkii+UYz
 v83mUkaUxz4NgIULMQHBT19tCtf8nqT/MieOfvKj2sTzlASsL1UGRAGZOPu+UiZr9bg7
 b2ZsWOfolUSv+j1HEierDQPpPbi3NKHaiTkG6n56LfwXirWdYARQErqxksspO91tq+vd
 H1og==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Sxm3Hu/I
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Similar to [1], a couple of other targets need to be fixed before we
can enable SPL support.

[1]: https://patchwork.ozlabs.org/project/uboot/patch/20260724-ccaione-upstream-mt8188-spl-reset-v1-1-08da6554ecd8@baylibre.com/

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      arm: mediatek: use phase-aware PSCI reset on MT8365
      arm: mediatek: use phase-aware PSCI reset on MT8195

 arch/arm/mach-mediatek/mt8195/init.c | 2 +-
 arch/arm/mach-mediatek/mt8365/init.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 0d8724e128d17c106074d4789e1a8de60e4280ab
change-id: 20260731-mtk-mach-phase-aware-reset-1a737ebecf5e

Best regards,
--  
David Lechner <dlechner@baylibre.com>

