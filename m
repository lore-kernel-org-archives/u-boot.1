Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FC5C9830E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:42:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F85F8131E;
	Fri, 25 Sep 2026 13:42:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NHDoJ341ty94; Fri, 25 Sep 2026 13:42:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E1FF181347
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790343760;
	b=WRvD2kSYGhSXd0dI7oEdPtA7DUIsOmVEW2Fqh0yvM33r9cpJMgi+xbPvC13WNFYZ4BTv
	 D4Pu4xqc/z269qI5cGNQgFKSctV7h514PROhXQ+5cJ/VXFzoYGqoYIPS9rUS/N+/j/fIF
	 6gbmaLEL8CnzLqccfTw3Fk+gbasigekxlFSbLWgyWl99BLkS3hIz1f+E7FTINPpXj+vhQ
	 siYudSL30a7LSdUau3nVLmiWDlZ2m9WvXV7rebqOssDi820H5+mBn1/vZqiLZqrrqUOCe
	 JaDEscaX90CSqdHxMM0iGyI5mFEyp0ZytOqa310pOPdpzvrN26wVTLFXd041BUxR9Fg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790343760;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WUnXu75ZRdLjaFEPeCJjU2KgvMwj5O9XkDhrT82NxTk=;
	b=RneXt5v43bLTGrOJpHCOAyTyvOREJa2KbUdAhHqwGqOX6ifEszvZCYXDVkv9PoIfe1Uw
	 wD2MDCbO6adzRgpIQnRrkDbSrXyoWkpltJ5+xObNYvxkIcpyB4W6Spa3T/JyjUYkGGugo
	 hS1KpKso3uTcfwsmy+mqyOQR7s7mi3Pu41Tqqt3cDY9Cg+G1dAi49KhRRXcC8QIu7VYVI
	 g5VtxKx9x+cSdccj/Gy/birR3w+Nzul34rehaaMKDFWz4IlcCcrqNHPpnuXuoM2PWT/pr
	 jP7ISJkTZB3mwg3Bh/4ubUgCvQa3IwHh6Cg2r0MB1MZfjEsAoGz33LaKFx+1M7rQYqQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Us6Fu3rP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790343760;
	bh=WUnXu75ZRdLjaFEPeCJjU2KgvMwj5O9XkDhrT82NxTk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hsRPJzJzxveG5w1TT76azbSKOxfKpuPpe82Ofnukt6hEVfelSiO5+2mnyOvEGeQJS
	 OCDzeSOpWzqubdEAMIfSgMIgAL+xDBCq9wo0uVcYjhgGzQRpjWyA9jpI7idYOvqqHT
	 PBMTNY2Kw6uFgiji7OxihuSxZMPGG6S/BLEPN+54hhkkvZDjTcXQwxGgZSXOzo+74P
	 rH7UeVVBQSuPJZfF6nAwCijPtE1SYonl+d+0vpflfb9JoH76y4pErRTjuWmA9Neg0z
	 djSs27FxlS4Fp6IlgBDoKzfQ66oXVPc38VLGfj6q78fOtdQIPTaAdMzK+a2sw1lcnN
	 XbYlc6TQqc6yQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1FF181347;
	Fri, 25 Sep 2026 13:42:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D4F9432F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:42:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B9AA4811D0
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:42:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9RlWRVQRNv_m for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:42:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B2C478115F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343755;
 b=ZajQ4uRyTlBsOntMx8cv5NpTIhErBokjH3TteriIh+dsxwQ0GUCsh8sfvYfdpC1KB/ih
 QrtEXGXKU4aX/f6kqSVgedmi3e8wCCu26gcnIoO+o6XxZmOjYhiPubkg9zwSPxmpkHQhJ
 fmRgehlOKUZwjZmfHJKAh6YNDr+gD554DcdWmq1g2lo85MxDdPB8OAirsLvbM4Umz9W7y
 O4Ny1ymchgdOVQfGfpKNzzoP60BmoJLhMN9uUIpKnyYl2EZmdmqL7ixCiMjGv0n+MY+Wk
 u8vkFXBlJ5EVuy9mTuRlrW9zGK4B4HGmDiCfM6rivtt2jnEJGTW7MhNtooYXAaKUXYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343755;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=WUnXu75ZRdLjaFEPeCJjU2KgvMwj5O9XkDhrT82NxTk=;
 b=sq5FHDsCM0Qesm9DsAtYf9dmQYjUQoG2WVEaT4nOCKw77Goxf21Uu7BDM5/qX/g8Sj5e
 hvPJXLwlrO60Wf0NyHAmm5ofjyOEnqrmPxE44zdTVuc7h6m+ksD0Af62ppgyWWPCeIhnm
 +/e3s1aH4OdmJos5rCsFY/ISd6sJ7v653QWUZeo+mjlZUEQXlJqi+9psuc4yeVwagVIY3
 dB8WIXLCun868Rf/IEH4Y5ljTwPUCTLwDN7dZbRP9Av6kFcZ0QoyKnkqr07ceP8FPAwyt
 JoBpSwJwyB7rkF0ioRCK675dmTdM199iw29fhtoOOxw1zVIaET3rWy0ufO8ysKXCmWg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Us6Fu3rP; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Us6Fu3rP
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B2C478115F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:42:34 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b91369d18so6372365e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790343752; x=1790948552;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WUnXu75ZRdLjaFEPeCJjU2KgvMwj5O9XkDhrT82NxTk=;
 b=Us6Fu3rPTunXxD711z7xvKkyAcvSZyusoK+WJKGrH0OsfqMyVLvdiBJHudipO26V35
 AVzzvslozZMUUMLztvfl4DoIGutaOVj1EG6v+VYyeHY5LJedFwVmusRX9xy1q+Duf7Wk
 nWYtJpgosq4c9hpVD9N9Hkk3r4i5T8Y6gC/8SeeE6seXLByo4TaRvS7q1P+TKj7f7oTh
 1hxiq8Pd0/hp7JnFH8Musg6aatSDfrokUxcYPdAJz70lS6yBt+/cms62DL4hMbwIKbwE
 nE/uUHJ9DH6ye2EG6MhYKSKdpOrRC7xNZd5flWlq4Ki723yN88NTkb9hOXf5owJl3XOa
 h4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343752; x=1790948552;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WUnXu75ZRdLjaFEPeCJjU2KgvMwj5O9XkDhrT82NxTk=;
 b=f/K6xhlLSQ1LfTARa5WXp6ZAm9OdSZJpOgkk+qxaewZc9egGEfrGTMVKFRQDPZy3Rp
 +BG/RJOIPWWmOTCh7q46ALePFHjrrejAQVGWF2fXSzG3dPDLJ+lcMCUl1VT3Ug3pVGZX
 mevy8c1W1rJdZ7hyvU8oqP4qsHYkWHKQEUtdiRAnCzS26jHPiX6C7oSfF+uJ/O/Gmzfa
 7vgncKGEFgq5s0A7aykGYOniFrSLQZesMGkvL300odKz6EpsRWr15IhZhX2ZTDdpXVSL
 tY7ZBKzez2QteQj1DUr58QmR06TAmwV5NNjJoyxYrFHvR5wGxv+OLJ+H9HGQ/s3oOv9/
 TjHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwryQKC+tV/0p61aEU8R2tGPd+uO8MfDzs5XAhyDStdHIr/TFCJDgzoDv5QOIPRPcjTFw7o0UQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mgCpmGUm+RrJO7apK8v7y89tqrpvZS9+DbwMkikQ6aVZ5SKPMh
 U73Hiohc750BgkzmiGCmtoNWuEABC1SupZs7y1XWvHXQ/iOFKmH6HIWKllLoJYtJSPZNeGJ88o2
 LW7ugguM=
X-Gm-Gg: AYBFou123qrn8b0MHCogtTf3qrt5p5RUlH/89Puae7M8SMAAYt1w7swrQavxJHYglPz
 qq1zFOgoz9LwEyiCw8Qs19W5gGizQshvnSRFmbAtuLCvkwxo8eGYP/YiEnotNmlIG4g4PkyXXJg
 1YL/Brhn0Epbs0nG2CflRWR/RkvB1lrrnN9Hfir25psM00S8E9CQfYemqAGzDqni0yakcF1lhY9
 BLwePGUUPy/hRR5FQUvUhWpMr41BURMTanzKfsn+lrCfjfnnpv7GR71G06H6Pdw11DQyBfgtDoM
 s/tLBmq//YfIkMN8fWcqUryYxNOz3SnV3Iyzmlx+K5WVHDdIyaAMNRV6E3cPDaGUpTCLY0zCZVX
 dr9XUvxWWlkUl/O2VFHsaIg7CDWOyLmuEVvr5cBK0hu5DQrr74Q9I2Uy8+AbM6mzLcnZtfqT6ap
 P9V79spt1U0DfR1JszcM8MfUnr1VLSMaZ7lEZsyLIXA0RRSF1Y7R9L/rFeNWoR
X-Received: by 2002:a05:600c:8719:b0:49d:15b9:2a2a with SMTP id
 5b1f17b1804b1-49fe66c6373mr110505875e9.10.1790343752559; 
 Fri, 25 Sep 2026 06:42:32 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::642d:5bda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff42b7074sm34738125e9.6.2026.09.25.06.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:42:32 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Fri, 25 Sep 2026 15:42:27 +0200
Subject: [PATCH 4/4] configs: khadas-vim3: fix the Android DTB index
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-update_vim-v1-4-fddf7ba4dc34@baylibre.com>
References: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
In-Reply-To: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
To: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.16.0
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

The AOSP vendor_boot images for VIM3 and VIM3L contain two DTBs:
VIM3L at index 0 and VIM3 at index 1. The current adtb_idx values
of 2 and 3 are out of range, preventing Android from booting.

Use the matching index for each board.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 include/configs/khadas-vim3_android.h  | 2 +-
 include/configs/khadas-vim3l_android.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
index 18632bb95a0..607e3bd6e24 100644
--- a/include/configs/khadas-vim3_android.h
+++ b/include/configs/khadas-vim3_android.h
@@ -39,7 +39,7 @@
 	"board_name=vim3\0"                                          \
 	"bootmeths=android\0"                                         \
 	"bootcmd=bootflow scan\0"                                     \
-	"adtb_idx=3\0"                                                \
+	"adtb_idx=1\0"                                                \
 	"partitions=" PARTS_DEFAULT "\0"                              \
 	"mmcdev=2\0"                                                  \
 	"fastboot_raw_partition_bootloader=0x1 0xfff mmcpart 1\0"     \
diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
index e84820a0d6d..ba01622166a 100644
--- a/include/configs/khadas-vim3l_android.h
+++ b/include/configs/khadas-vim3l_android.h
@@ -39,7 +39,7 @@
 	"board_name=vim3l\0"                                          \
 	"bootmeths=android\0"                                         \
 	"bootcmd=bootflow scan\0"                                     \
-	"adtb_idx=2\0"                                                \
+	"adtb_idx=0\0"                                                \
 	"partitions=" PARTS_DEFAULT "\0"                              \
 	"mmcdev=2\0"                                                  \
 	"fastboot_raw_partition_bootloader=0x1 0xfff mmcpart 1\0"     \

-- 
2.34.1

