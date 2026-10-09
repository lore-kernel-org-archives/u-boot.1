Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08804CA6015
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 16:16:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7853608D7;
	Fri,  9 Oct 2026 16:16:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a_bu5KO8XjR7; Fri,  9 Oct 2026 16:16:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EF601608F5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791562569;
	b=m/L+h7icPGk42BMZfZTEcU2tqy3QNDif1k2W3GbANugu2vDrbpBYrFYl8Sg7kEcOez5c
	 vxh+RnB0h9x0/G5XPEHyGS7yCB7GwY30akbyeOdUmxSO/MEegiyHPZWu74qNWUV0Toj2R
	 9f4HhWmkVWBgKyPdbznb+vxqUhI21jv/z6+WMbFln56v/KKACjASHe759ZcYn1NXwYxNe
	 x+t67HlxU8SQzdfcfkPT5bppj32cNLIznMDdtS2jMOwSIs4zx0VP3k4PIath1+S0GBG6r
	 0Bu8CR/tjs1Ff+FDNtr9Esn9w3aZiTlDQQLMyVpMfU3VG10oFvHGAoz7mmQWMZxfGig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791562569;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Q/Pf1i3ZPkseTU1Biqnv/sYVaJjFxZ9y+JdUjSZo9g4=;
	b=eQusnCd79WPeXQuYrr5n70tRBunYnU1MjTONps5cgYmS8eEe4v8gtZsL81ZcPEdNAcXl
	 yZOH1GRQZaN5zUIFH0eKkLE/+JgjO5k0wcrm/fkVPI6pgJ07hHClxJc29w7qGYUjSbwYv
	 uAtnvjQxmDEmbpsjC0X8h+KSguZ5QwODoq/MmYWx3eLmcc/fuwNkmQ49Ti6rJohw4SKTw
	 B/pTQTPEI5TVI0Nq+1DMmiN0plZZnkabrs1C/ka3lWTLSW5aNBltO3JFZcdx7n0ONs/5Q
	 +9kGGePWbFdxAyIl+/eNHmfiU7q3/fvfqtGwuAUq4sRm7aN9+YP/YsqKoAlhnmnZTQw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791562569;
	bh=Q/Pf1i3ZPkseTU1Biqnv/sYVaJjFxZ9y+JdUjSZo9g4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WCQKS4+RdPjI17sC7putvYEjnPmOZU7L4YZWAAgYWsrz9cDx2qs3rz60SsN2/hG+f
	 sP4JuuzMUVUdF0mRnz6iH9BTzMDkHecEPNEhm/jLHcSWNdv0JlKLGukaBLNN2Fs5wS
	 VIYMuKbXOIdbU/g3FbJDZ45Ir7PT0qZkka7a67cUXOg0IppBWqOUvTV/cgG2HI4zBo
	 22QoQUi5Tt45Hs1StfZElLEuLWgDORDhRS9ne6qa1Chj7Fsw/KUVSE/6XNXaKop6rj
	 UCOyWInKsUmXayECfm8gbZwj3AiYjQu2l6ZwhCJp3LA+14YBbXZ8AVRTSLjBw8TLp/
	 KDgGV/HM4bRnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF601608F5;
	Fri,  9 Oct 2026 16:16:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C90F6422
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B986940050
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lJXs7RK-2pre for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 16:16:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EE4AF400FD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791562565;
 b=ZeZdkyutd+akR7PWPmqm5MREIGHb3KdMM9bD2XZ8uuaEf/jeu1P3Aw/Z1CRCiFTvNblG
 d5eI6ztv+7qJo/ZgLmf5qFa5I2RCsf4P27YttUDLomwg4nJ1aUXy/gnAhYmjIVUtjSBUs
 KmXeazZvP1QkSNR8bHy+eb8Ee1BYvbe2UCO7LYDWtfCBrVcWO4uGzm4UJ0Lv1eaxUtsGk
 oxECwwJXgxxLyxuIV6nsbUpHZYY1KNJ13wFb+FP7hdBSO6aY9g8jyVfdtdaudSjOuPkb6
 8wyz0APmJqmN4MEe2KaWVKlhT2D9TNsTT9g8gN6SZka4MlJwzvPVFdB5BTnLWaNzmtQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791562565;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Q/Pf1i3ZPkseTU1Biqnv/sYVaJjFxZ9y+JdUjSZo9g4=;
 b=XJ3iRFPJQMINjaa1qun8RkkRdgqmkan3jTS+jVBP9LM6cpWe2hnI/U3S+j98xCF1GNSk
 gglpdzW8HYtHdrghZ3wPW3M/r6S+7gl26X08L5Xf1P/O/GmHf4TKtpuRn7IzFE6zhg744
 RCL5Q+SiS5sfIg0HGvNdOmdBXsxbcxwxVJG78yD/jq50DRA0ON3oQcT3yUahCMS54KM6I
 LARkNLAh4y+JdN8v/G0DJHEfEXWlusR9QdZknlkm5CxAOsTLOUX7qHTSMsfo/OmzMJHN3
 fqWnx6Bmb49GK3cC5NKUTAp0zR2Cb3/KBPuuUxDhngpasSL8167e1CGsqWpc9yMt/pg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=RdScKuXt; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2e; helo=mail-oa1-x2e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=RdScKuXt
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE4AF400FD
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:04 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-455ca262ccbso1317fac.1
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 09:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791562563; x=1792167363;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q/Pf1i3ZPkseTU1Biqnv/sYVaJjFxZ9y+JdUjSZo9g4=;
 b=RdScKuXtxhFf90TBSCsqv9uR/e6V+r6YyaXHZuAWUFfrV5NoBzJ0emi0AYigPe14SI
 ADxkUeHoEw9ezkkdGaxIaIuI5Dobi32YvqoYX6ZafCsuDX7cNNhVQVrPrs1TQZAr0L1n
 mnCld1xLc5XSxaSJc8Co1x4i3fURwDzGc0ANBGu1Msvm4xuQE21+g8HQmi3V7GhkCPEn
 ndPE6ooOJybpSJpWkimVrP0UWPFe584stL5qKQS82IO4y3fWZmyNNCprteohsmMQh+ls
 e2MwgHMA+rNG+QAI5MMdhI9Gf7SNn+3EIqPmIA4BBete3tncsahlwS65tZIVo0+gaCds
 Y7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791562563; x=1792167363;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q/Pf1i3ZPkseTU1Biqnv/sYVaJjFxZ9y+JdUjSZo9g4=;
 b=CUJRa2aQ/ePFaPql8sXL8WVLqgdkANin2YTG+U1bFKmjCbeDdJQnSGLswNyGKdrLkz
 qE6IB3Bx7sXooljgFJ90+1h4udo+tuBzL++3NKrX5HqPDRYTyR5BsY28WJfn/oEpl7R8
 N3faMPl+ZPWkHpLg8SnpaAfOZ+69kH6dQ8i3YU//Wdtp4E3DbbN/BagZ7U4JbFy3ESfu
 wg9/hK183K8uett1XM7wOlAVTZ6xcDb2gsMVvRV2VDI8zpKOgQ7aZlpAqQzs/uHx8ayR
 /1AAqcs73LoUGx/Ex6Jk7frc5xeX059Ellk6ckqL2PZkOimdFYs1eXc2wosCN+p8YN/p
 UU6g==
X-Gm-Message-State: AFuF++nSWJ4MrqcrCJR2cFyCKPMXySeaL9/C/5cMj+sVJpw6wU/n5drj
 7ynJLESMZN2wph6pzQZIpFopWibUVouHKm5hlRadA+v7FiWpZAIEs726MSnFZq2h8P0=
X-Gm-Gg: AYBFou1bcHSG4xpCOeS5FNUyyIyH05r41YN3D5R8AzMAYmBEQ0HSthrXtZliTawcwEk
 7FV+nFdyErf8/hcgZzIrcTc3YY4TEPAWFjA/5yLkQjTsrA1Sp6h2qM1wOa0ZjcM7vsygaitngE1
 sC4hue5zmpOfYwQwOjLfDhNjV5f64SNXCTUdmruLYIP1xv5ow+IOUgLB6hyk7gh1FDm+BitjAwp
 sJDPTRjotWv+oYdRJvorvI8oMmEZOh2IZQUtU9cNIh1l5i9bk0KzDAzEokalgx9Uti+BvvmW9Lt
 3segEC/4v3Y21LzMHtOpYAlUbQz7llleTGp1JMwrcuSFX3WZcpiJ34aDlY1rPmuYGyYT0q1V8C3
 oNY0lInLM1nBA+ZI/jlP5nYpHbGHYHRw4D3CuH2o+ehFA2cc9A+Q9yWyYLKmMdhlFa4SOZB/OR7
 Xk2h6IV0yuAneo8vuQ0/OBPg2ZodcIxwtKAPO4oOVYDm7yZd8OWbv77WS4FqNf1KI/t5InWnXKL
 vY=
X-Received: by 2002:a05:6808:1585:b0:4b9:a829:f015 with SMTP id
 5614622812f47-50c556ae29cmr1844311b6e.33.1791562563433; 
 Fri, 09 Oct 2026 09:16:03 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c0c5fe7d0sm2451506b6e.2.2026.10.09.09.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 09:16:02 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 09 Oct 2026 11:14:11 -0500
Subject: [PATCH 08/13] video: mediatek: build the overlay with the shared
 pipeline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-mtk-genio-720-edp-v1-8-4fbcf5b2904d@baylibre.com>
References: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
In-Reply-To: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=DHmFGVDDyPsGZpf7LIHyL1BddVj3ohCqMFzS9wTMjxs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqyRMHmIfYyTymAsvtnVYpZqTf1KP7ZWlO/VEHS
 Hz7UBNwxnSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaskTBxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Aa2EH+wSX2eDW4Q+YJoYSyn2yTg3P/FJP4EyknhUCXrl
 PfQfVvYbB+1tDEZyde7nMssiCpOR9WkivZuhjg5budPlXPS0h6TQNNigwJgdrJjf7yj6euGkhHr
 ff+7rjvITj2z6Fzw/0xhs68sKCvBw6pjjFsKN0oCXR5KYJGDk0puGoZcvnViS0pgJZGmxIDfFKc
 6yoRurTToUsxrGkxXHgbhRQvWo0n0lBdzEFiD5QtNhnjQbB5V/ZL9+lmOVDnjZi70pclxM9/XLz
 KVyx0yQEcsaxprpVFkTJL5lcas/ydvnFHaMTHeuWG1F2hwC62/Sf8ep9OzyX2y5uDzitMyKww84
 dfuA=
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

Move mtk_disp_ovl.o from the DSI object list to the
VIDEO_MEDIATEK_DISP_PIPELINE one, so that the eDP path can use the
overlay without the DSI controller or the colour blocks. That option
already groups the mmsys routing and the display RDMA, the part of the
vdosys0 front end that is not specific to one output, and the eDP path
drives the same OVL0 -> RDMA0 -> crossbar pipeline.

The DSI path already selects VIDEO_MEDIATEK_DISP_PIPELINE, so nothing
changes for it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/video/mediatek/Kconfig  | 2 +-
 drivers/video/mediatek/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/mediatek/Kconfig b/drivers/video/mediatek/Kconfig
index 88cf3d11b2e..6e9ad26ab54 100644
--- a/drivers/video/mediatek/Kconfig
+++ b/drivers/video/mediatek/Kconfig
@@ -8,7 +8,7 @@
 config VIDEO_MEDIATEK_DISP_COMP
 	bool
 
-# mmsys routing and display RDMA, used by the DSI path
+# mmsys routing, overlay and display RDMA, shared by the DSI and eDP paths
 config VIDEO_MEDIATEK_DISP_PIPELINE
 	bool
 
diff --git a/drivers/video/mediatek/Makefile b/drivers/video/mediatek/Makefile
index ee3d7eed618..3bd69617b74 100644
--- a/drivers/video/mediatek/Makefile
+++ b/drivers/video/mediatek/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_VIDEO_MEDIATEK_DISP_COMP) += mtk_disp_comp.o \
 					  mtk_disp_mutex.o
 
 obj-$(CONFIG_VIDEO_MEDIATEK_DISP_PIPELINE) += mtk_ddp.o \
+					      mtk_disp_ovl.o \
 					      mtk_disp_rdma.o
 
 obj-$(CONFIG_VIDEO_MEDIATEK_DPI) += mtk_dpi.o
@@ -19,7 +20,6 @@ obj-$(CONFIG_VIDEO_MEDIATEK_DSI) += mtk_disp_aal.o \
 				    mtk_disp_color.o \
 				    mtk_disp_dither.o \
 				    mtk_disp_gamma.o \
-				    mtk_disp_ovl.o \
 				    mtk_dsi.o
 
 obj-$(CONFIG_VIDEO_MEDIATEK_HDMI) += \

-- 
2.53.0

