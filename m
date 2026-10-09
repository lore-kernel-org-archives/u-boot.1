Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF423CA6019
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 16:16:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFEFB608F0;
	Fri,  9 Oct 2026 16:16:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xSCYIaa6ytXW; Fri,  9 Oct 2026 16:16:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3BF27608F3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791562565;
	b=ntPmAbU+rRcnhe6CClLNi3hq4dcYezdj/6SE0SB9fPGEFE2tTktyZxVMEm3LXWx2j9N1
	 6wbJBKQAzB8Z6u3ARfNYfYnix8UaEbd03K3MWVYQDoqL5izx/xnCXILVTmWaH+yYIBkuf
	 OO6enB/FUdZdU/8nfdRigtsFBFHx2bFuslKAgbVU1bLrpMn6gbWTR+VAfCRfq0nJmrUpq
	 WbWDXGws/zwKAlM9xLMW3c52pRrOpSWyZqrnHWb2vDgBhlxeJxp8I0UCfX6eeP7u4YeBw
	 8W3KQHKOxSavEVwz1iRKB7Cpd9l8dX0z+4KBNUKoABuwvP+kndctc08uFKLG2QrgAAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791562565;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mqYxGVNGlzgfM7bQB4Kn2/WLsvAlgwlKRMkCl/TSHe0=;
	b=E2PHD6rhFNrWFXQCOs7od7ab0bVgjKS5AN/XtW4ugTlfWasODK7S6I6g6XyEUJIgVxt1
	 EGA60kCS7/h76Rx99YbtS9R//U7GC57G3F9ZM0wSrZ0JX4oTorZryC2hb2MItaLqrf0C5
	 CVcGWF22OKpslQcFV6JibG0/FGVD9M3HPb5rvi98L//41qMyKUuxw0EkYD6uTJYnJslAD
	 2CJqbTUqlGnuZh5GHHJF1W7MW2u5FrTNLX/NjTewf25EDFQk4hI0p+usy3nLxbYimBfMv
	 e1B0wuVUP6oOdojt/hMtz11SCxEV8V4/6Tm8TyJpGba1ruvgLxJtyBOPA+M6SabqS9g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791562565;
	bh=mqYxGVNGlzgfM7bQB4Kn2/WLsvAlgwlKRMkCl/TSHe0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IXn1MhPgbbKyl6LGYr77NO+ZiZatW39bG3XH3ZLYu6LIJjkxhZWVHetMQV20sA7qh
	 eyKA2X7GJtpjJGZP8ptGmD/xs0pkJJ3AiOFx/j2hV7Gejydfxt7JE1bIn6VTv45tm/
	 1icdR+dUMoz+RiUU2zzBDb0RNVpcIWuoxLVUld7ZovMrcCymG6BlaCvXxjUbznfPRO
	 Vj71quR8zbC+ji5RQl7SN0F3/sZ5qeOotqNIMWDV3epvrJNf3PL27b90JjRH6xuBLR
	 jEOLg6T0KE5Ynu7bz/BiE3mWAZ6banaUKofEjmfWJdV9fafENuRmufjeKYXP3rwxP0
	 aAYOHRwMuM+Fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3BF27608F3;
	Fri,  9 Oct 2026 16:16:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9EDB2184
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 85C09400FD
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4c_lk5U6L5Qf for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 16:16:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BCCC140050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::235"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791562560;
 b=ofvRXe/QPLSQmkz8dyfs+ZWSrzWpl6tmnDe8Rqaz4FBXSLyjirquxZNPF/40LH+v9fSN
 FVVE+SRi/u+ReJLhdgT6h3wxpsXpdppwvIAQgFac2mLMIBKWemBRiUHJSetZ5SzBAmQpu
 Qh2Bd6hx+qySAIgfp3/vDQ7DZY0bj3Rhmjj7Q6yzAf+6P9eEO1RlTlvjo/IO0x4ur4PJg
 cQKhefnqZRDD6lwaz3eOcxRFlqevksjUvpE6hTq+F21l8dM4wy0JbNXa+MQ6be9LXbu3G
 wlv+ne9K/siHSYJiTUBTuZ6BaO1LSrCzOPewqhxkmwlYQPEaOPmbC66kj7sxMhVZu/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791562560;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=mqYxGVNGlzgfM7bQB4Kn2/WLsvAlgwlKRMkCl/TSHe0=;
 b=m6kmiegD95Tt6qP2hSuXGOjvAwyi1sGRWBvNobMh8uxWwbWLuxErmPCfmmgs8HGJJKuA
 wN/gDIMGqtqVjozODROI+5CMPuOD/Zfg3rMqiaTUjf4EZkPrAipUsDh/80/lLaVgW8o9K
 mQfl5L6BnuwtYHgbpNTi2cPqG8AXdn14utxnyIDZTyL8jpjzOyci965eV9VLREsW9kocw
 C3fWYhHAfCpH9rBKcvMTdOkKs4XmMkaZj5sFsn1awKpYNEz8OqQ68IRDxrvE+5GI/BM2m
 g084AlXuNuS4pimX6kETRIlJ6Z8xq6mW1AKDf7f6ixRm8toEN9XZL+9rmiJ8NLwQmOw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=EUefyh26; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::235"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::235; helo=mail-oi1-x235.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=EUefyh26
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BCCC140050
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:00 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4f59e61f295so3115773b6e.3
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 09:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791562559; x=1792167359;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mqYxGVNGlzgfM7bQB4Kn2/WLsvAlgwlKRMkCl/TSHe0=;
 b=EUefyh26Y80krB4K/ZlDEt0F3/fz3IX2Bghy/JVZrjKObCuOwcs0SBtR/1oWanwon+
 gymiM1mwlY7+2YARXA36Ve8OgaEcc0e3CojOoDucrIR/nB5C3mUe907JsSH8kmayy4ZG
 I3KP/Mzaw8gHf/j58KPFoSVtln9WQonuO3liIVls95YVG929EHjHUWSYRMzxKr+kTFY0
 fbqJSgDmdngzr20EYBDvGOuF2eQur4YCJfaPYOF0WF45pKJCrAaNkVtLyduH6NeuRSCq
 YuB6LddoFrWR7BTrcUUYDKXO6VWV3sMVbrPOc9fLLlXNZUqtl8BBCngxdmLv1qWSLmuJ
 07zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791562559; x=1792167359;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mqYxGVNGlzgfM7bQB4Kn2/WLsvAlgwlKRMkCl/TSHe0=;
 b=b5hT9NB2dbQ0b/l9Fse7KYtcSKOLDlL/9c94DQsWUHPBmEQfYo4x504jHwtN+KSEot
 +j1RHl5oFeFHGS+KyjTSkK/LR7FYgrpX1JhbUFK4eBzgXsovHTHvjf1FMbkCVPkM8/zZ
 O9KjxS7LFDI6hW8XGSBt+pcHc3jbpmvSPK54aXo3cobL1fRWwS3djkJIDtJhwNpOMnjJ
 Spqg9OLjwSDJ2vZNWGDbULbMTXipo2p+1W0RxVrlP9Wfp8uJD/aUL0EgVPpg4Bwqht+5
 VpbLQPbD9jNHD3zWynVO2gOmxZSI2qRq6K3/RyFl6zZfWWaqPJckWCjZzS4XVXVJRvvz
 /ZQw==
X-Gm-Message-State: AFuF++mkmj2yMt4IPuNJY+8qlX2DBtfDk6O8kdKvSq3uj8FDa5gBjaVK
 ygxQxFn4VwfiIalSTnjEVjd70eofINTXZ/gdvYDg6JivODFVvAiNDhxy+n+n3m4NW50=
X-Gm-Gg: AYBFou0/TsbRFIqlqU77lpXe2nAjGXGy//eiaX9FaIeqU8uXuh01YvoXZGlMFs/tU5b
 PywCmQSbYBu+LyGS6kCCOyL9oWjlGJzzOkuEvRWCZNEsxUiUIO9EBzwCH6x1PA7q+s79ZDrMWYL
 2D8NusxHa167FMt1nnbetnEQ9rK4NokgfSgZjk7mahmW8aYMMhMFDexpi83ihzozcw9mPIKWrd6
 23VjjX702i3MsDjqNBsUiDKuWgwXbkllqcPBO0m5JYkJXqnHH3c6MK9eA/pGnM17PJWTvicJGTD
 yU65E7ryBKylpX0IUtHkYTV5pQ4RWFB21eVqYCBe3O2JD84Q0ucX1kldm0efZrGo1oq+xKyyjEG
 +wWkZtbzt+HyfDUPOWeuxiUfFT2Kr24yKet8MQ1nyw7+0SUt3v3UmJ3rB37M/Fis4WxFcAZBrD6
 JROWvVbgV8hB/ecvO9C2JcymsIKTYmVAJwtDGE3rqEMn3SPAejXcz3HgFw7vKDBW9sWy4ySHZWz
 iA=
X-Received: by 2002:a05:6808:1310:b0:4f5:ebfe:4157 with SMTP id
 5614622812f47-50c51bc8e5bmr1715435b6e.44.1791562559353; 
 Fri, 09 Oct 2026 09:15:59 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c0c5fe7d0sm2451506b6e.2.2026.10.09.09.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 09:15:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 09 Oct 2026 11:14:09 -0500
Subject: [PATCH 06/13] video: mediatek: mtk_disp_mutex: add DVO support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-mtk-genio-720-edp-v1-6-4fbcf5b2904d@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4535; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=p4eevUuqTV1SX8d117ivRLkcQMwOpexdARP8clqwmp4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqyRL5aTke8PA9aytrKkUWGrTRrwUaeuAoLM/s9
 mV1PomyyKeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaskS+RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AeeMH/Agi8IlI3ajJf5zvmfFtVoUYAJJVe3RiwKIBoOh
 +OL0ZgNWfyDde00Qdu8SATtbJ3imJMQDSfpJbmVKUFR6AWJdvAteDSW6DG3s6Z2v+WvaJewSyy8
 boaKsR6d1pcQbxsR6cPsyFYp37KQRw2F18cXGWb+tR7NMtUqkm+o4kTh1NR9PBQ+4bi9g3f7ttV
 2cyYRTsAdwLDbSUmx6EMfzFJOhBPW7ZPSHWnOyAOaLPPVgXH32zZz4js+qW4///rymqfJ6dWJJO
 0eg9PwfSnr+xFyMf4+hb9PL+mVPkIgIcGF6JQxzMvUhBQhvcst5iBMYbkbLUClzu5ojQ5MX3w7c
 sfBg=
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

Add the MT8189 OVL -> DVO pipeline alongside its OVL -> DSI one,
selecting the DVO0 module and start-of-frame source instead. The MT8189
drives its eDP output through a DVO stage in place of the DSI, on the
same mutex instance and with the same overlay and RDMA modules.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_mutex.c | 47 ++++++++++++++++++++++++++++-----
 drivers/video/mediatek/mtk_disp_mutex.h | 11 ++++++++
 2 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/video/mediatek/mtk_disp_mutex.c b/drivers/video/mediatek/mtk_disp_mutex.c
index 99e46711db5..1a7ea414f40 100644
--- a/drivers/video/mediatek/mtk_disp_mutex.c
+++ b/drivers/video/mediatek/mtk_disp_mutex.c
@@ -51,7 +51,10 @@
 #define MT8188_MUTEX_MOD_DISP1_DISP_MIXER	30
 #define MT8188_MUTEX_MOD_DISP1_DPI1		38
 
-/* The MT8365 and MT8366 DSI pipelines use instance 0 of the mmsys mutex */
+/*
+ * The MT8365 and MT8366 DSI pipelines, and the MT8189 DSI and DVO ones, use
+ * instance 0 of the mmsys mutex
+ */
 #define MUTEX_DSI_ID		0
 
 /* the MT8365 shifts the end-of-frame selector by 6 instead of 7 */
@@ -82,15 +85,26 @@
 #define MT8189_MUTEX_MOD_DISP_RDMA0	4
 #define MT8189_MUTEX_MOD_DISP_DSI0	22
 
+/* the DVO output stage replaces the DSI on the eDP path of the same mmsys */
+#define MT8189_MUTEX_SOF_DVO0		5
+#define MT8189_MUTEX_EOF_DVO0		(MT8189_MUTEX_SOF_DVO0 << 7)
+
+#define MT8189_MUTEX_MOD_DISP_DVO0	21
+
 /**
  * struct mtk_disp_mutex_data - per-SoC mutex data
  * @dsi_mod: MOD0 bits of the components of the OVL -> DSI pipeline
  * @dsi_sof: start and end-of-frame selectors of the DSI
+ * @dvo_mod: MOD0 bits of the components of the OVL -> DVO pipeline, 0 on
+ *	     the SoCs without a DVO output stage
+ * @dvo_sof: start and end-of-frame selectors of the DVO
  * @no_clk: the mutex has no clock of its own
  */
 struct mtk_disp_mutex_data {
 	u32 dsi_mod;
 	u32 dsi_sof;
+	u32 dvo_mod;
+	u32 dvo_sof;
 	bool no_clk;
 };
 
@@ -145,8 +159,19 @@ static const struct mtk_disp_mutex_data mt8189_mutex_data = {
 		   MUTEX_MOD_BIT(MT8189_MUTEX_MOD_DISP_RDMA0) |
 		   MUTEX_MOD_BIT(MT8189_MUTEX_MOD_DISP_DSI0),
 	.dsi_sof = MT8189_MUTEX_EOF_DSI0 | MT8189_MUTEX_SOF_DSI0,
+	.dvo_mod = MUTEX_MOD_BIT(MT8189_MUTEX_MOD_DISP_OVL0) |
+		   MUTEX_MOD_BIT(MT8189_MUTEX_MOD_DISP_RDMA0) |
+		   MUTEX_MOD_BIT(MT8189_MUTEX_MOD_DISP_DVO0),
+	.dvo_sof = MT8189_MUTEX_EOF_DVO0 | MT8189_MUTEX_SOF_DVO0,
 };
 
+static void mtk_disp_mutex_enable(struct udevice *dev, u32 mod, u32 sof)
+{
+	mtk_disp_comp_write(dev, DISP_MUTEX_MOD0(MUTEX_DSI_ID), mod);
+	mtk_disp_comp_write(dev, DISP_MUTEX_SOF(MUTEX_DSI_ID), sof);
+	mtk_disp_comp_write(dev, DISP_MUTEX_EN(MUTEX_DSI_ID), MUTEX_EN);
+}
+
 int mtk_disp_mutex_ovl_dsi_enable(struct udevice *dev)
 {
 	struct mtk_disp_mutex_priv *mutex = dev_get_priv(dev);
@@ -156,11 +181,21 @@ int mtk_disp_mutex_ovl_dsi_enable(struct udevice *dev)
 		return -EOPNOTSUPP;
 	}
 
-	mtk_disp_comp_write(dev, DISP_MUTEX_MOD0(MUTEX_DSI_ID),
-			    mutex->data->dsi_mod);
-	mtk_disp_comp_write(dev, DISP_MUTEX_SOF(MUTEX_DSI_ID),
-			    mutex->data->dsi_sof);
-	mtk_disp_comp_write(dev, DISP_MUTEX_EN(MUTEX_DSI_ID), MUTEX_EN);
+	mtk_disp_mutex_enable(dev, mutex->data->dsi_mod, mutex->data->dsi_sof);
+
+	return 0;
+}
+
+int mtk_disp_mutex_ovl_dvo_enable(struct udevice *dev)
+{
+	struct mtk_disp_mutex_priv *mutex = dev_get_priv(dev);
+
+	if (!mutex->data || !mutex->data->dvo_mod) {
+		dev_err(dev, "no DVO pipeline on this mutex\n");
+		return -EOPNOTSUPP;
+	}
+
+	mtk_disp_mutex_enable(dev, mutex->data->dvo_mod, mutex->data->dvo_sof);
 
 	return 0;
 }
diff --git a/drivers/video/mediatek/mtk_disp_mutex.h b/drivers/video/mediatek/mtk_disp_mutex.h
index 3b97c7020a2..31b6db2d80a 100644
--- a/drivers/video/mediatek/mtk_disp_mutex.h
+++ b/drivers/video/mediatek/mtk_disp_mutex.h
@@ -29,4 +29,15 @@ void mt8188_mutex_config_hdmi(struct udevice *dev);
  */
 int mtk_disp_mutex_ovl_dsi_enable(struct udevice *dev);
 
+/**
+ * mtk_disp_mutex_ovl_dvo_enable() - set up the mutex of the DVO pipeline
+ * @dev: mmsys mutex device
+ *
+ * Put all the components of the OVL -> DVO pipeline under one mutex
+ * instance, and start and end their frames on the DVO ones.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the mutex has no DVO pipeline
+ */
+int mtk_disp_mutex_ovl_dvo_enable(struct udevice *dev);
+
 #endif /* _MTK_DISP_MUTEX_H */

-- 
2.53.0

