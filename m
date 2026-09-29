Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3971CCA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:36:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA0A2607EC;
	Tue, 29 Sep 2026 12:36:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JwGlsYMSIiOV; Tue, 29 Sep 2026 12:36:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B24B3607E8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790685409;
	b=oK2KpU/jQV1n+6ScniYR4EmAsytsP9e4D6DBhIgyQMtCRLLMP4Mi0s7pnozShS/bnn+n
	 N45x+K2eSouNnFx+m1BUe+8WD1CdWQ9iUgqv1P0OPK2WWjmZYxFljCz0KBaSAUYkowrZR
	 1gG1dPg9X7mxxjy+7RYtaT8+zuUq6/jx2vQvrZL3SKaQChammY9CwAT7H1pv1KkYfakPK
	 bRBBcUJ2CXWde7OAe5ElbdFGyYqoDjLMhRh9j+E2qWNVhmI8nToMEw43C9urbFovOc6aD
	 NBoOjYIBb7rKasN040DnR2v1R2oztihE9zo8C0+xZ/9YXXRcSElToQ6+GttztM2n6Fg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790685409;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=F3BGDsH01E5hq2Yc2u1y7qQROhtrgxZABwnR9ybWN3I=;
	b=ErKB95U00yr+I2xkiHr8Lo9kCCauYFQlHN3R1g5GiBYH4Kh963X7/N8jmy+bL+3RWpty
	 uqOVsWXst8hhy06xsgnwSkxTA8MtCCEL88R4MQrYAo9Ie3hHfixCpOz7y8RCqQ+8zrCAl
	 3o8iBmSUKGgbsnfxpYoh1NpPSlW/rC1drXklp8SlLcN9mcDTIApTw+d7rbzEJoJoBpvei
	 Ao9Hio0T97DduX7+cxZeBJc76hAxyjPeh8Ixwyi74oWUeb4fy0GY8QOu0WLMUWhIFsrm6
	 YcRtAxYojAeSv4LvN1+LpRZnbjwWfr6q+SEAuZtmzpyZnmqGulAOnKPLdRB2tEXGSmQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="dcrWL/88";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790685409;
	bh=F3BGDsH01E5hq2Yc2u1y7qQROhtrgxZABwnR9ybWN3I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vvfw83mR3Aq3xihvbbrG09f8BZ4nYjvth/vVgdcvvHx73Ju/jY0qC+cmjhXFq/Jis
	 T23BuWJxN46jtvJRTwtudekXvlVM1YG2PJYnA0tdnEErqFFHm1It608Qf0Awz70lXg
	 ToWQNnwLpj4rPhRGBZd0zv0YtwjjarqgjSs0p0VIvx5GS8pV6EXz8SF5C+ZImb3Lz3
	 bW6VysilUictKxWSKMZC8+d7eOegoznh/R37x3Ff0Td2PYa1RsiJNsj75XZ3hCrzry
	 fzSQhF6/GKISCiBBZOfLwwZxdJV+HOnavyAiZVPGgMfkdCELUIjcTqdz2lOrNJ78xM
	 BbS/a721Bf15A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B24B3607E8;
	Tue, 29 Sep 2026 12:36:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A614335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F17AD607B0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Cczybsa0cTR for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 12:36:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2B910607BA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790685396;
 b=lTPnWu9LQ8ajMiHoY/w/VuW9Frc70NEPNAZarVQP77g44Yk2r80pEyUtgSzPcfgsQ3VW
 xIYMxtUD5KZX5ls86UCYHPtVvUQSaF135I/1z5v42FzEpy70QBMiBOQ5PCDa+qjHttD+9
 3+y1zPaRTAI2ty/Q3c/wKcLenw4Cv+KYhAqs8Z5o41eHDdx0UIEk9/Gzgkhw/8cEXTp3J
 9/O/fc6iWZVgCg6ayNou40T64HJquFqK5MMVKl5VN0vmkd/H+6Bj0sUUTJ5FBLznCQ9NP
 YEwBxPgjiqr5dXG6qQqB0pIXySsC83ASHomydIgoN3yU6NmGs6+AUYVZi+pfqC6HRlw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790685396;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=F3BGDsH01E5hq2Yc2u1y7qQROhtrgxZABwnR9ybWN3I=;
 b=hNwNcmkXQ6WC/vxG+yjRS68MD+5PfDZ8kCov+M0ZqmU829+ojvagko6N7JXntGZSwUrD
 Xv/44BmJjAiw7UF9bCj6Ky668DJlWU9mkMt6LkpUGjff2EaDii3pSb3otJQEa3hD/HhQu
 G/4TIzilko62K8D9xMu7C9O/nYiw4utqRyOis3ILMk9HugBlPd/OTcvVNtslSMTHalHf7
 ZxlSQB2ub07+fGazibNkSixAUFIhJ8OMY0zjLVEhPJXe5rU1pmRD/dwYC+5b3YDBV0NxN
 u0oMYUkgjs443cDZXNBaUEfWDWJ7pnjHttOBi7reGfPEAL5cs4BdFws943cGRc30++w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="dcrWL/88"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=dcrWL/88
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B910607BA
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:36:35 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e66390995so23241085e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790685394; x=1791290194;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F3BGDsH01E5hq2Yc2u1y7qQROhtrgxZABwnR9ybWN3I=;
 b=dcrWL/88+1hckhVB/PhMiyfZfjNmRK37nTVulyrh1uI4QNuyj9QPdqccP48wjOUYGD
 ZydPTSLsX3gxRS5PqWhZ7BjldS4iFQMWQuW1+2VNP4XTDbqj74ggmWfQPXU/EXWtV3LH
 BssqPdbNh8tZ8M/chR5U6qXpBvsahDSUF7U4smiQ4fIDPsFb31FBh9JaCVg1HmmoGyX7
 UcV955mE7C9Z79wz58KU1FKGxOSW8Dbl5WORlOGFcgpYMqNX4ZfDzUPp42VsxvzFYleK
 ix2TLyTdK8QIKAz7ZLoKYqacwSP/trc+dK1xd5wdxx0V/DCmPc4cyhiBYAy3NiGUa9bc
 J8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790685394; x=1791290194;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F3BGDsH01E5hq2Yc2u1y7qQROhtrgxZABwnR9ybWN3I=;
 b=JDzwaeT8DG1Os1/oR6P0zCbWVby5aUrFy0qgonXP/wtFqSx9lP69p/LKBCuzLDftpc
 dOf6SeBmA6f9icGZti6G5kkYW9yY5e5fQAtIHXPCwTcHuVcXZk6sg8vP0EN9giyO31gT
 7o/P99TYxddU4mxU6yAbVrOlLZm7JuxfFE31p1GvpxAFg+V2QykioIlcAVURcZ/wKCBq
 2w01WF+t5J4gA8ow30GVG+I7WIe/VqkFsfZeR3OJFCkvvvdRDT7Gs7gt6ETH9i/hM0o3
 /iq70f//w4gD4afZB5JTfh08gAqGZaDPXra5DP84JSf5dGBtGCM0Gu20xeUVh0IIT2GH
 1iMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6I0Rvad10K7mfMUeJr6kHw/xIb/psFtge279tC0eUVk6D2UOaxbbVYoM8LxundA8ERzfu/f0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ms6N+SjKZXbRr0IKkd7ViNgUQ76Dv42Uju6SnAOonHzA4Ef1uP
 j/0exFvwc4TJ/jhTuU2mjzv0UtQ3cnzs/+v0/UFdAGm0CX2tDhOOm4Hn96DKd0rPL6g=
X-Gm-Gg: AYBFou1HS9OEGrrsJfpToYK0GgLI5RSqGmCiggvH9OWU+YiK4S9elmC2gFmBKqT3Ssp
 aftC88uia0g5IMypWqqPBfFoWAQNWAJMTzYedFFnNHCe1zhx2d+0lmlm0cuSswvRYVuY3JfYrSp
 Y0oALxbolR3XuiseSykEzhnjQfkm7kI3J6bRCavMaI/5mShkd5crEN2lU6fq3FZq8OkQ5cjWkK0
 EQraWFJDmkXVyNuQAdR44lZvvTUkCrywjAxR4d/9mpmmSrFza3W2ajlao+Rt31URnEripn0gShH
 t5R4nwiTn8l+RfnwD9jYmGl1jobEjlUtGJx+0bSs6+vmHzuoMFh1qzO0wbHxKMkjoYx2SiYjxrl
 6fiuLAYF0TdrKZxYgf61SE7J2Lgw/STNkP7iaJCbJ776tR1gzdcYgovAZs6b5dFGj3uXzAcRIph
 Ko+ZZj7sfB2YmQLymjhtYOVQrASBMo2bM8oUduDOrgu2mqemT/iH790MOFpkQry9MTkX6f6rIC8
 0JZFQ7+0mVqs3KmU84+3DfGYQcULCnYbKiKVqNiLn4Q8ffG59rA7XjKWRK6YH8+LeuUdczBmAfg
 NCxtQedcMSnE2dnuFkeesnfpBf8reSascrqfMWjKBiIaY/sms3Ft0YM=
X-Received: by 2002:a05:600c:3ba9:b0:49f:fe48:d177 with SMTP id
 5b1f17b1804b1-49ffe48d294mr187463815e9.32.1790685393722; 
 Tue, 29 Sep 2026 05:36:33 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a013cfc788sm450305e9.2.2026.09.29.05.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 05:36:33 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 29 Sep 2026 14:38:45 +0200
Subject: [PATCH v2 07/11] clk: mediatek: mt8195: merge the clock drivers
 into a single driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-clk-mediatek-cleanups-v2-7-b296bf3a4a93@baylibre.com>
References: <20260929-clk-mediatek-cleanups-v2-0-b296bf3a4a93@baylibre.com>
In-Reply-To: <20260929-clk-mediatek-cleanups-v2-0-b296bf3a4a93@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 "irving.ch.lin" <irving-ch.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
X-Mailer: b4 0.15.2
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

The topckgen and infra_ao U_BOOT_DRIVER entries only differ by
their of_match table: they share the same probe, ops, private data
and flags. Merge them into a single mt8195-clk driver, the way
clk-mt8366.c already does, so that a new clock block only needs a
new of_match entry.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8195.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8195.c b/drivers/clk/mediatek/clk-mt8195.c
index c67735e314a..6bc323a895e 100644
--- a/drivers/clk/mediatek/clk-mt8195.c
+++ b/drivers/clk/mediatek/clk-mt8195.c
@@ -1606,15 +1606,11 @@ static const struct udevice_id mt8195_apmixed[] = {
 	{ }
 };
 
-static const struct udevice_id mt8195_topckgen_compat[] = {
+static const struct udevice_id mt8195_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8195-topckgen",
 		.data = (ulong)&mt8195_topckgen_clk_tree,
 	},
-	{ }
-};
-
-static const struct udevice_id of_match_clk_mt8195_infra_ao[] = {
 	{
 		.compatible = "mediatek,mt8195-infracfg_ao",
 		.data = (ulong)&mt8195_infracfg_ao_clk_tree,
@@ -1632,20 +1628,10 @@ U_BOOT_DRIVER(mt8195_clk_apmixedsys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mt8195_clk_topckgen) = {
-	.name = "mt8195-topckgen",
-	.id = UCLASS_CLK,
-	.of_match = mt8195_topckgen_compat,
-	.probe = mtk_clk_probe,
-	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
-U_BOOT_DRIVER(mt8195_clk_infra_ao) = {
-	.name = "mt8195-infra_ao",
+U_BOOT_DRIVER(mt8195_clk) = {
+	.name = "mt8195-clk",
 	.id = UCLASS_CLK,
-	.of_match = of_match_clk_mt8195_infra_ao,
+	.of_match = mt8195_clk_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,

-- 
2.55.0

