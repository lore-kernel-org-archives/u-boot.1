Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB0CC5DF70
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 18:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 166C4810D5;
	Mon, 17 Aug 2026 18:17:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NzFxVlOt6dU8; Mon, 17 Aug 2026 18:17:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CBC0E81102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786990648;
	bh=gBe8CcsQxm8wIR39y8TD1tkkfesQbMZhbUDiCeLvjls=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YvRiFmduLaRY94ku0VUNSULesrRiYiYJEUGfxoObkBB/QPgg4RouTo+J9C/FauSGn
	 0vOlpX8+BJE4ocSBXPnMvYSM/Y2t7bX4hAk1RQUkthqSA+Wr0yLQIlV1iqWSy7M8Gl
	 /q+UI/P9jRBsj69r9xnR/a6u+9OspdOY9h4pdnIrzESiM65cqIw8gtI/nAwq2EzBuc
	 rE6Qq+KlsV6x98Bw9tve7K1WSEH3AHREUHuCHanBNHpZffHNwvglMJmLL5cJ20yS05
	 UPBNSBdYLRVpkNdPpNHyEvsqJ+wV/1mdpeoSzr0lSb7gFaOfqcn02/ZjFGAmdjqg2L
	 3wPwHs+Ku3JNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CBC0E81102;
	Mon, 17 Aug 2026 18:17:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 046F72EF
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA6B0401E5
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:36:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qqx0xEK8pIFd for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 16:36:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::735; helo=mail-qk1-x735.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2ADA040130
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2ADA040130
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=i6FhFFWO
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2ADA040130
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:36:08 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-92e65e18969so6973385a.1
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1786984568; x=1787589368;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gBe8CcsQxm8wIR39y8TD1tkkfesQbMZhbUDiCeLvjls=;
 b=i6FhFFWOgWggFU3r2DOnH/AxbzwhM/rdHYHyHYyLwxLyqw9GueAIRGoGvYsNZmRdnH
 nUlwPxCQ0W+emA24bOxsZL0V3npXmLwF82SoMNuJA312oxw2nVzFd8xZfnYnlaSlr+d4
 hnRprrqcM1OHjeUoLpIEx6Ip4d08kF9wL7m9Pl9p7dT6w08W++Ikyv6fPQTylhCp2d6W
 cVPZFwC3OBlIYkZBB/7DADZkYfM0jCnfZFPKcxPvY1Yt3biBs6MfP8mRIohYQd6/ZWKN
 92QejJb6aO8tMJ5ejNIu9h0zdsp3MCQEXoX5ZxWsMro5UqhrERbTDJidO3+hgHSC3XrM
 seKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786984568; x=1787589368;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gBe8CcsQxm8wIR39y8TD1tkkfesQbMZhbUDiCeLvjls=;
 b=oC80NUgd3Fg8m3khjnwNH+xfcvyxnZkJH1L+iESf/VmGRektwFFQorvF9gEEnPcJww
 ym/QGpppY9jtomhPq/y4/M4qTjpEkNnfHGUDh1cPH4U7Zq0kfd3UMqTWuLcEMCqgNCGV
 WFdlZM8/xSj8KwCdJscch9gOCYCHEp35Ps3f1d28JiIQfa3HdhKhjMvOJpW4Gw3rZOny
 GYIijxgo6hM3TWPLtQNJOD/VIPTrW9s1UNd+m2Rz02pRzZiS2+uutxE//6bvIhJdtO/a
 Yngt0L+oFhBrnqiItvVOyDIotq3mxd+K6FVzIqU8ikXo4odKN4xf8wNfFJBZXO/y6Cf+
 mLhg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJVQTh+VLwbnDmReYvJS9/20GRc3ieX+dA/xqDcmfpeXtlSYicvUTllB9twdYOpCF6vkdoGxk=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzKgekDub4hBsGobA4iw5dWv2767llS8ZXHYtCPVetpbhpdvSld
 C5I0HBGbMbN5dxWl5bH4Fc0mviXCTKyrL2plmWmhqhlPAdo636+YUwxLnROODnYL+XLCOiSYu2d
 +A5xGWVV1II3rSQHAbeNkh/Q6myW8iTuKv45OVjNNXIUZu9zWKdmDqI/v8Hbk8chGPA6b9WOfSp
 OmYzY=
X-Gm-Gg: AR+sD10wZUDcZJKp0CtiA+dQ/ZBYEV3WlbSZY35qOlB+jn70OQCPPG5YrYsZm6XRK7u
 mq8BGHizP+EInlarWpfSY/FWDpQRNtANNnrAAStCnOs10EL17EnPKlRbegy/n5m5iUBwU1xeWc0
 fb0D4IIIekBefPDpJdl88MGIQ2Tgvt57H3ouo5qjqKGXSs62BAnPhd/KBAa7r5OyLeeqEdYwhOJ
 sVuttuiKUmzzpBk85B0+SO9jhZSJZ7DEaraA1wsWE6+xXXimYacARaDGfgbru/XXaPd7jH9Vb5c
 txsFTwup2eFyOmM4mX0oYp7dK9SrNzSIDvjD65RmiA+j/9DQKNdVArAf5N9hWnz+3kA/oXrQqaf
 XXFxhocMFXsBEgeIPp7SvC4L7SR4e8VfYLgRIG85JussPjYwlOOxdNYGNrbK2tPZEMx9YPBwB/+
 7RqKFx8v4G1cbdI0zuBhjyyOwFsmJMla0UncbI5mXnfIa6xc/YYeRzarSC7mFwX+fTpCrzI9/cp
 MuWvxPtLmb8YyoLKtdXrD7da6A=
X-Received: by 2002:a05:620a:284c:b0:936:ce17:7792 with SMTP id
 af79cd13be357-9370657a3bdmr50009285a.8.1786984567702; 
 Mon, 17 Aug 2026 09:36:07 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com.
 [54.236.161.35]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-937010c3785sm122431685a.2.2026.08.17.09.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 09:36:07 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sanderson@brivo.com>
Subject: [PATCH] reset: meson: Add s4 support
Date: Mon, 17 Aug 2026 12:35:56 -0400
Message-ID: <20260817163604.1893382-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Aug 2026 18:17:15 +0000
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

Add s4 support. There are no new features, so just define the layout
info.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/reset/reset-meson.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 8c27563ce23..16d2dc19898 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -82,6 +82,11 @@ static const struct meson_reset_drvdata meson_a1_data = {
 	.level_offset = 0x40,
 };
 
+static const struct meson_reset_drvdata meson_s4_data = {
+	.reg_count = 6,
+	.level_offset = 0x40,
+};
+
 static const struct udevice_id meson_reset_ids[] = {
 	{
 		.compatible = "amlogic,meson-gxbb-reset",
@@ -95,6 +100,10 @@ static const struct udevice_id meson_reset_ids[] = {
 		.compatible = "amlogic,meson-a1-reset",
 		.data = (ulong)&meson_a1_data,
 	},
+	{
+		.compatible = "amlogic,meson-s4-reset",
+		.data = (ulong)&meson_s4_data,
+	},
 	{ }
 };
 
---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
branch: s4_reset

-- 
2.53.0

