Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401CFC98325
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 16:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0351A60D77;
	Fri, 25 Sep 2026 16:00:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f1cx0k93raNc; Fri, 25 Sep 2026 16:00:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BE6A560D8B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790352021;
	b=mj/c+JbIhj4/C2ExHeLJYpe/Ba4DN6YUMOseCBdAGIWOElJttUdzFT4xT/B8id0rq5au
	 6YqAT+ejgrxLsmyF3KtRm9sR2tuH89xbyRXyph6iubZYtA46TIhjWkhkuA+QCjatX8wCg
	 /105wsBUWMilZHvsQyz6ZKTu8u3MGq6HA99qB0E2AiNhwGnYwwdPs4+dFCc6117JuoV7F
	 fsGSLhJqv6RrfYoTpc5UVUsHBqGOVgUoP/GdxD8euyXCApRab1nkPhUlNegBU6TDtF69I
	 BzOuV45hSIu3CKjmo9nBdftPuX1SB8Dlcbs48SqUE3btdkpJbKreYvdiMoaHMcnMXcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790352021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ATIi9wY+Huh6Zd89WLY1zHjDIBo5DkgApY/S1QUycC4=;
	b=FTg6Arhfb/m0cU2WD457RxwB9M14VbUdveEVGCRxPmi16GooM/N8boHI+o/aIRN+ZDC5
	 Zdoz13k/lmZEPuv8jumAAZMbxyH4X2Xu/x6hfXb9RC4SygmqKc5JuLAgAMyOG+w6YDyuD
	 /Wv63vA1Rok+HkikIlMzl/NMqDigTRRVqypCxbzdKIqoNpUYgsYy7b9r29d0S15wCFYKb
	 TnmhiZX0+X5FOEG5ankvGpaM64eIKaRSnp8tYMWb+6CuWOtUJ1gcwPf/lQlTvhRpm95Xw
	 WfP4BhRFOolTzxB7ejkwyMvN8PUD3JJGu/h3rJ1A2fx0CB+g8q3AdwB5+tfZBO7jKzQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790352021;
	bh=ATIi9wY+Huh6Zd89WLY1zHjDIBo5DkgApY/S1QUycC4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cCTAlcMgWdYN7wO50/4b5KHeOEy0+bLzb6jhQidi1zK4IqZXPS/kB0TBZFjDw1OEy
	 0UH+8OnqT1eZoUmlf3o32SwELRgwRMCKezyQ74FwUWUz7DpfFfeKbSPyYhH5qQdNWy
	 dcRoTO1ck6pFuTvC8PxCn1Bh1EcJjf+EXKxXZbWzvw+q0pL+U9bwgOcyonPy9vwkYz
	 uw0Pv/PemDtsoFjQIXiXErYiTmK5yNVj7NAcCYUCOI6WY8Jip67pgkB7/npBEJvjam
	 78TJFjNndvonyAVpfU4rVu54o86RHpDeo5b9Cht8FmuGRIDENKKIgWHg8s+cOXmAgE
	 B9V3EHJdZpUHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE6A560D8B;
	Fri, 25 Sep 2026 16:00:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 60C68355
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 16:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 528E440BC2
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 16:00:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4xPWOvP7SAwf for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 16:00:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3799D40B9D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790352017;
 b=B0gP2tuzO5cAOCXRbKQ8PvK5wijpoNDTPCzQJRbI4mGWSPJE+SK6GBMP9WweO856oxP2
 hdrq8zRtA7grVbP4joqaiILchN3vTWKxmfz+wYpteSFob4vuLoI3ZiprwfH13DfvRudM4
 fXocR6dkf/yMdsixMexFWjJdCKb95G+LJCPXIgchbr9uA48LgYZN2HR5x7THoGnOYlsmp
 CNgRYf4web4LCaGNdu80kZ4h8my0fTiqKZjSHpB2Nzx1EqvmNG6iOXrsqV7kqvq1NWTcx
 LG4gFs1Hx7zSd3PMQNMztm5tKkFwexdwz2bJnfAOE3d633/BveJx66asFZaNQErJfQQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790352017;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=ATIi9wY+Huh6Zd89WLY1zHjDIBo5DkgApY/S1QUycC4=;
 b=jZQTmMreDYO5iSuEjMyVx1tGPnh63nxXfvheIlk4WWcyqU7pgH1Dmj5NOQFnNb8FmBlr
 BRFIe57mqVvF96rVhZsBJrDyBXdQtDQprkQV2gbBheguikhZBkrAKOVoX4uwSMfiZtjAJ
 S0RFGHIgQ/GZSzpaJAqZ3U4C33gnTGwz1O2K8jLJomNxHOX63ImbGl2bZ5x25z8okVg0/
 +T8nqNW9ZKDTNgCCagDNsL/JJIBnAYUZIQhYdtGOGjwnljawNssDCmzIvdnF2itgG9BKX
 oYLcGUKviWf10w/RW7yvByASVSZw8C8sHikOEn32Ui7CnEJEiErgXRv50tw9WRHoIVA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=pa+hripF; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::d;
 helo=mail-oo2-x0d.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=pa+hripF
Received: from mail-oo2-x0d.google.com (mail-oo2-x0d.google.com
 [IPv6:2607:f8b0:4864:31::d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3799D40B9D
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 16:00:16 +0000 (UTC)
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b1ae736c64so746829eaf.2
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 09:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790352016; x=1790956816;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ATIi9wY+Huh6Zd89WLY1zHjDIBo5DkgApY/S1QUycC4=;
 b=pa+hripFSVfnU7YW8nkqeiMSJVgSPZVN0i+d6iPJnbcs4ISbQBDkh+p5hRjMAlfXG1
 myCMn//VKlGwEpuZjJS8+8I+2TMlsqO0CeObTAHGt30VUf2MrMzGG07THfpHEchnRevc
 GwyqesZz0UkH+HlOi+giSFLFptiES5wyJ4x2WhyZeDlmJw0Wyq85LQaeIufSEfcFhuqW
 OAopg6dBE6kxC3uT2uZmW2I43SG//JlH3Wmhj5KPHKYB1oY9d5T2OHDMsq8TZed5MLo0
 gXAK8OYw+lD3yi1PaQ6z4K866dSoCk7Y2dXh8l7Fhh/RbGhpDypCJ0nKJI2pKwEfMA0L
 BPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790352016; x=1790956816;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ATIi9wY+Huh6Zd89WLY1zHjDIBo5DkgApY/S1QUycC4=;
 b=aQybBACH3/qCND8fPb6FHIDYz10PvCW4Ota9Ryq+m1dOGzGjvl6ff05e5BQpXeLUDD
 TMQu+ivOkqcRDDWE09z4Rz9N9h41rfy2u/ZVAe/tnm5lGlxVRn5gj/hG4L7Wgz1/BhYI
 xNTJ4gjeUtGcY9dRBaRlWx5bAnqhKdq1iPCOm6sdl22nInt1J6lBc7AYM9fcf+rgA3Id
 D0G6q4/5kemzGfYXWz22xXYjL5YP1OINaoZMYeqkWg7Z1sk5wdd3Su0KF5Y3HDVwQzAq
 5gWV8PWE12jA9IhGDz8FHptIQgP7UoSJnBZ2ZVnuILrSQ0EnlBU+SFjsgZRCzMITxaro
 Y1ww==
X-Gm-Message-State: AFuF++l4Fj1O4B2+FDo1P1yMk7hX3CVYkxs2zahqSjHaixMJTHMSg6qb
 DplSarsIGTboaoH2MwlVfKte+hmbIBVLWzz0Nd6+p7kMXEab19P/2Jiv0p9UJYku1aA=
X-Gm-Gg: AYBFou0JanykEdw0HPtxey4yurSstp3UGBN/73q66MVlK3+Na5lo7s8zqjCrUdrvRsJ
 tJm9/CYHRHV+7OAm5x5C4hZ9I6UTvovee1l6whNd7ScXEea33ye6T9OeSoW7sc1SdmzKf2BPu+Y
 jc76oKHZBg4PXR7QsY5k8IGW9LyIroBBmR6WvJb3E8VF/eWZrRq3F5XrkxVqmjScsyQ6IWZMfim
 SxeNlP9mHqbznfqiTrOjn7SalSDDgtIiSpbDTMh2usAJgc9BL+oloJX6dD4ARqPQ4BWZuvQoaKK
 o38BMkIBC++TOqK/B+C3cCH/k4gbAc4vHUJpsj1140M0gW9JXhVCtgffSfLOO5h+yCaE1WqwR9n
 Q1UDC3aynT1tjthNM5UU94lQWEi9v+b+EA/3LUx+IgyJxMK+hUGnMsmhjvNYVV1U4NBVBOWj1LV
 B4Al2Hy3+fFOJ2kU8kwSZhY01VK6G1asO4FMQ4VxvqsryIweFAcxxWPHoWqwl+9TIMWfDIT65C/
 CQ=
X-Received: by 2002:a05:6820:f02d:b0:6b4:117e:543 with SMTP id
 006d021491bc7-6d43f7a6d39mr6689182eaf.21.1790352015595; 
 Fri, 25 Sep 2026 09:00:15 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ecea:a30a:390f:322b])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-818e6211cedsm2469164a34.3.2026.09.25.09.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 09:00:15 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 25 Sep 2026 10:59:38 -0500
Subject: [PATCH 3/3] clk: mediatek: select mux inputs by rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-clk-mtk-propagate-rate-v1-3-8c7169b4eeb5@baylibre.com>
References: <20260925-clk-mtk-propagate-rate-v1-0-8c7169b4eeb5@baylibre.com>
In-Reply-To: <20260925-clk-mtk-propagate-rate-v1-0-8c7169b4eeb5@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=11493;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=namoiBuuGfMGZC79KH8PkB0ni5Kh6uap6q1pj3xG9ig=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqtpqCaVUZGDYaSnAuliL60QtOtCcxsgjXyyhWF
 JfhMc6+kvmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaraaghYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Axu0IAJwxtqFB9KnzQYJ3m2mEopIhGoiucDGLooMm/us
 SzhouOZdwAbf0j0rfL/S6qImdO6nGUCtqXsZJ9vfSOyRXQgbzt8QsmIcQX3ccYrQQHYREAWnAW2
 piIeyVFE0WhIytqvgO5Xc4yxamEqbOTok1RdEGWDkzlcVqLW7dgzGlqVTsPkaUn2WuAB4Yv2pel
 Igch3BXn5liJad1OhcAeOc3WJ1GPFeebTds/TO/nRM+F/thuZwvWAjRv0zArpCHX+ICqTyH+ZWA
 FCFtACrj3e0kyfwKHMw4m7+URUToB4By0WtZF1wEbPGv6UsMayqz5KV2r3cyhfmqv1XGGEbY5aF
 5kfA=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Make set_rate on a mux, or on a gate in front of one, select the
fastest mux input that does not exceed the requested rate, as Linux does
for these muxes. Add round_rate so the result can be predicted without
touching the hardware. Both paths share one helper with an apply flag,
so they cannot disagree about what a request would produce.

Only a PLL can change its own frequency, so asking any other clock for
a rate fails with -EINVAL today. A display driver typically sets its
own PLL and then asks for its pixel clock, a gate behind a mux, for the
resulting rate, which only works if the request reaches the mux.

A request never retunes a PLL indirectly: it stops at a PLL or a fixed
factor, which report the rate they run at. PLLs are shared, the audio
PLLs in particular feed unrelated blocks, and U-Boot has no rate change
notifiers to keep that safe. Linux sets CLK_SET_RATE_PARENT on these
clocks, but relies on that protection.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 249 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 210 insertions(+), 39 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index dd2d7e4e755..78e02963bdf 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -14,6 +14,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/string.h>
 
 #include "clk-mtk.h"
 
@@ -249,46 +250,51 @@ static ulong mtk_ext_clock_get_rate(const struct mtk_clk_tree *tree, int id)
 }
 
 /*
- * In case the rate change propagation to parent clocks is undesirable,
- * this function is recursively called to find the parent to calculate
- * the accurate frequency.
+ * Build @out so that it refers to clock @parent on the provider selected by
+ * @flags, which lets the generic clk API be used to walk up the tree even
+ * when the parent lives on a different provider device (a topckgen divider
+ * feeding off an apmixedsys PLL, say).
+ *
+ * CLK_PARENT_EXT parents are not backed by a provider at all; callers have
+ * to handle them with mtk_ext_clock_get_rate() instead.
  */
-static ulong mtk_clk_find_parent_rate(struct clk *clk, int id,
-				      struct udevice *pdev)
+static int mtk_clk_lookup_parent(struct clk *clk, int parent, u16 flags,
+				 struct clk *out)
 {
 	struct ofnode_phandle_args args = {
 		.args_count = 1,
-		.args = { id },
+		.args = { parent },
 	};
-	struct clk parent = { };
-	int ret;
+	struct udevice *pdev;
 
-	if (pdev)
-		parent.dev = pdev;
-	else
-		parent.dev = clk->dev;
+	if ((flags & CLK_PARENT_MASK) == CLK_PARENT_EXT)
+		return -EINVAL;
 
-	args.node = dev_ofnode(parent.dev);
-	ret = ((struct clk_ops *)parent.dev->driver->ops)->of_xlate(&parent, &args);
-	if (ret)
-		return ret;
+	pdev = mtk_clk_parent_get_provider(flags);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	memset(out, 0, sizeof(*out));
+	out->dev = pdev ?: clk->dev;
+	args.node = dev_ofnode(out->dev);
 
-	return clk_get_rate(&parent);
+	return ((struct clk_ops *)out->dev->driver->ops)->of_xlate(out, &args);
 }
 
 static ulong mtk_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
 				  const int parent, u16 flags)
 {
-	struct udevice *pdev;
+	struct clk pclk;
+	int ret;
 
 	if ((flags & CLK_PARENT_MASK) == CLK_PARENT_EXT)
 		return mtk_ext_clock_get_rate(priv->tree, parent);
 
-	pdev = mtk_clk_parent_get_provider(flags);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
+	ret = mtk_clk_lookup_parent(clk, parent, flags, &pclk);
+	if (ret)
+		return ret;
 
-	return mtk_clk_find_parent_rate(clk, parent, pdev);
+	return clk_get_rate(&pclk);
 }
 
 static ulong mtk_clk_mux_get_rate(struct clk *clk, u32 off)
@@ -306,21 +312,10 @@ static ulong mtk_clk_mux_get_rate(struct clk *clk, u32 off)
 	return mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
 }
 
-static int mtk_clk_mux_set_parent(void __iomem *base, u32 parent,
-				  u32 parent_type,
-				  const struct mtk_composite *mux)
+static void mtk_clk_mux_write_index(void __iomem *base, u32 index,
+				    const struct mtk_composite *mux)
 {
-	u32 val, index = 0;
-
-	/*
-	 * Assume parent_type in clk_tree to be always set. If it's not, assume
-	 * parent clk ID clash is not possible.
-	 */
-	while (mux->parent[index].id != parent ||
-	       (parent_type && (mux->parent[index].flags & CLK_PARENT_MASK) !=
-		parent_type))
-		if (++index == mux->num_parents)
-			return -EINVAL;
+	u32 val;
 
 	if (mux->flags & CLK_MUX_SETCLR_UPD) {
 		val = (mux->mux_mask << mux->mux_shift);
@@ -339,6 +334,25 @@ static int mtk_clk_mux_set_parent(void __iomem *base, u32 parent,
 		val |= index << mux->mux_shift;
 		writel(val, base + mux->mux_reg);
 	}
+}
+
+static int mtk_clk_mux_set_parent(void __iomem *base, u32 parent,
+				  u32 parent_type,
+				  const struct mtk_composite *mux)
+{
+	u32 index = 0;
+
+	/*
+	 * Assume parent_type in clk_tree to be always set. If it's not, assume
+	 * parent clk ID clash is not possible.
+	 */
+	while (mux->parent[index].id != parent ||
+	       (parent_type && (mux->parent[index].flags & CLK_PARENT_MASK) !=
+		parent_type))
+		if (++index == mux->num_parents)
+			return -EINVAL;
+
+	mtk_clk_mux_write_index(base, index, mux);
 
 	return 0;
 }
@@ -573,15 +587,39 @@ static ulong mtk_pll_get_rate(struct clk *clk)
 	return __mtk_pll_recalc_rate(pll, xtal_rate, pcw, postdiv);
 }
 
-static ulong mtk_clk_set_rate(struct clk *clk, ulong rate)
+/*
+ * Report the rate the PLL would actually end up at if asked for @rate,
+ * without touching the hardware. The requested rate is rarely hit exactly
+ * because it has to be expressed as a pcw/post-divider pair, and it is
+ * clamped to the PLL's fmax.
+ */
+static ulong mtk_pll_round_rate(struct clk *clk, ulong rate)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_parent *parent = &priv->tree->pll_parent;
+	ulong xtal_rate;
 	u32 pcw = 0;
 	u32 postdiv;
 	int ret;
 
-	if (!mtk_clk_id_is_pll(priv->tree, clk->id))
-		return -EINVAL;
+	ret = mtk_pll_calc_values(priv, clk, &pcw, &postdiv, rate);
+	if (ret)
+		return ret;
+
+	xtal_rate = mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
+	if (IS_ERR_VALUE(xtal_rate))
+		return xtal_rate;
+
+	return __mtk_pll_recalc_rate(&priv->tree->plls[clk->id], xtal_rate, pcw,
+				     postdiv);
+}
+
+static ulong mtk_pll_set_rate(struct clk *clk, ulong rate)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	u32 pcw = 0;
+	u32 postdiv;
+	int ret;
 
 	ret = mtk_pll_calc_values(priv, clk, &pcw, &postdiv, rate);
 	if (ret)
@@ -693,6 +731,138 @@ static ulong mtk_clk_get_rate(struct clk *clk)
 	return -ENOENT;
 }
 
+/*
+ * Pass a rate request on to the parent of a gate. The request stops at a PLL,
+ * which reports the rate it already runs at: PLLs are shared, so only a
+ * request made directly on one may retune it.
+ *
+ * @apply selects whether to program the hardware or only report what the
+ * result would have been, so that the round and set paths below cannot
+ * disagree. Both return the resulting rate.
+ */
+static ulong mtk_clk_parent_rate_request(struct clk *clk, int parent, u16 flags,
+					 ulong rate, bool apply)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	struct mtk_clk_priv *ppriv;
+	struct clk pclk;
+	int ret;
+
+	/* an external clock runs at a fixed rate: take it or leave it */
+	if ((flags & CLK_PARENT_MASK) == CLK_PARENT_EXT)
+		return mtk_ext_clock_get_rate(priv->tree, parent);
+
+	ret = mtk_clk_lookup_parent(clk, parent, flags, &pclk);
+	if (ret)
+		return ret;
+
+	ppriv = dev_get_priv(pclk.dev);
+	if (mtk_clk_id_is_pll(ppriv->tree, pclk.id))
+		return clk_get_rate(&pclk);
+
+	if (!apply)
+		return clk_round_rate(&pclk, rate);
+
+	return clk_set_rate(&pclk, rate);
+}
+
+/*
+ * Select the fastest mux input that does not exceed @rate, as the Linux
+ * clk_mux_determine_rate_flags() does without CLK_MUX_ROUND_CLOSEST.
+ *
+ * A mux only ever picks between its inputs: it must not retune whatever PLL
+ * happens to sit behind one of them, because those are shared - the audio
+ * PLLs in particular feed unrelated blocks, and a display driver has no
+ * business moving them. Linux sets CLK_SET_RATE_PARENT on these muxes, but
+ * relies on rate change notifiers and exclusivity that U-Boot does not
+ * have to keep that safe. A driver that needs a rate no input currently
+ * provides has to set its own PLL first, the one its "pll" clock names, and
+ * then ask the mux for the resulting rate.
+ *
+ * An input running at 0 Hz is never selected, as in Linux.
+ */
+static ulong mtk_clk_mux_rate_request(struct clk *clk, ulong rate, bool apply)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_composite *mux;
+	ulong best_rate = 0;
+	u32 best_index = 0;
+	u32 i;
+
+	mux = &priv->tree->muxes[clk->id - priv->tree->muxes_offs];
+
+	for (i = 0; i < mux->num_parents; i++) {
+		const struct mtk_parent *parent = &mux->parent[i];
+		ulong prate;
+
+		prate = mtk_find_parent_rate(priv, clk, parent->id,
+					     parent->flags);
+		if (IS_ERR_VALUE(prate) || !prate || prate > rate)
+			continue;
+
+		if (prate > best_rate) {
+			best_index = i;
+			best_rate = prate;
+		}
+
+		if (prate == rate)
+			break;
+	}
+
+	if (!best_rate)
+		return -EINVAL;
+
+	if (apply)
+		mtk_clk_mux_write_index(priv->base, best_index, mux);
+
+	return best_rate;
+}
+
+/*
+ * Only a PLL can change its own frequency, and only when asked directly.
+ * Fixed clocks and fixed factors report the rate they run at, a mux picks
+ * between its inputs and a gate passes the request on to its parent.
+ */
+static ulong mtk_clk_rate_request(struct clk *clk, ulong rate, bool apply)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_clk_tree *tree = priv->tree;
+
+	if (mtk_clk_id_is_pll(tree, clk->id))
+		return apply ? mtk_pll_set_rate(clk, rate) :
+			       mtk_pll_round_rate(clk, rate);
+
+	if (mtk_clk_id_is_fclk(tree, clk->id))
+		return tree->fclks[clk->id - tree->fclks_offs].rate;
+
+	if (mtk_clk_id_is_fdiv(tree, clk->id))
+		return mtk_factor_get_rate(clk, clk->id - tree->fdivs_offs);
+
+	if (mtk_clk_id_is_mux(tree, clk->id))
+		return mtk_clk_mux_rate_request(clk, rate, apply);
+
+	if (mtk_clk_id_is_gate(tree, clk->id)) {
+		const struct mtk_gate *gate;
+
+		gate = &tree->gates[clk->id - tree->gates_offs];
+
+		return mtk_clk_parent_rate_request(clk, gate->parent,
+						   gate->flags, rate, apply);
+	}
+
+	return -ENOENT;
+}
+
+static ulong mtk_clk_round_rate(struct clk *clk, ulong rate)
+{
+	return mtk_clk_rate_request(clk, rate, false);
+}
+
+static ulong mtk_clk_set_rate(struct clk *clk, ulong rate)
+{
+	return mtk_clk_rate_request(clk, rate, true);
+}
+
 static int mtk_clk_mux_enable(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
@@ -867,6 +1037,7 @@ const struct clk_ops mtk_clk_ops = {
 	.enable = mtk_clk_enable,
 	.disable = mtk_clk_disable,
 	.set_rate = mtk_clk_set_rate,
+	.round_rate = mtk_clk_round_rate,
 	.get_rate = mtk_clk_get_rate,
 	.set_parent = mtk_common_clk_set_parent,
 #if CONFIG_IS_ENABLED(CMD_CLK)

-- 
2.43.0

