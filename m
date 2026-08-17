Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB472C5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 18:17:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 838E240872;
	Mon, 17 Aug 2026 18:17:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Y2z53hMDL88; Mon, 17 Aug 2026 18:17:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CE02E40863
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786990653;
	bh=gv9AMPQihGRdITLoUHsBCtm8aBk4F/JBgXJrs0GQkGk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Y2pjtumrRWGnl8vyweERjFqZm3jiem4FFgGVafM9nC0A6OLui/ZUHIsBTglwYWkPx
	 OYLFNvswnFrXiRvQOm8QXvkpmtUS1KiuNGD/YcjgkWSAXUlI3UYXoOsLRLxMmEYdDR
	 pSaH30dBdHeEC+/3+up/bjpveRyVD4yW5lZHwWvcXbLL8rZfrmVzYe7UoDkxw2alaq
	 Awd8oX9m3nAV0Wq8L5AQbRB9HgkyqHedqiRnDHE2Ye1KqYbgU4DHFZUU6P2QA3UccS
	 FXjTLWS9vkwkK6yQguKavymPleXYcL/sojyCh5ClEHw9cLC9q5e2tynL0flT318byA
	 UVmkQNetuxuSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE02E40863;
	Mon, 17 Aug 2026 18:17:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3379E334
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:03:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 25099407C2
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:03:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8U3VKi5A4hFt for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 17:03:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f33; helo=mail-qv1-xf33.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4C4D64077E
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C4D64077E
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=EEDFv+UU
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4C4D64077E
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:03:16 +0000 (UTC)
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-8fcc43c48f7so35312766d6.2
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 10:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1786986196; x=1787590996;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gv9AMPQihGRdITLoUHsBCtm8aBk4F/JBgXJrs0GQkGk=;
 b=EEDFv+UUgNHE2l4OyLXmAztGQfeps7O69eXydsxGWmRGBUa1K/+74GPa6+TPwDOhqr
 lO2kcUaSyuKykwTrtoqoD4mEKM88u5NaEqbKFE3Yq85nQVBVcVgglhrRk5k2MaNPxfRr
 hahoEORJeyBoUPyJHc7QN/RHqlOa8dx6/SHRoMXgDhwyWYanCNaiVCve6OVY1NdMnAhm
 KxzK7lzxcFVyq1W529gg38ZhQaikUh4sz0l6kOH57Q79MmygrSii5fpVEEsCRB1cEqKU
 WJiPXruMArY25w2v39Pq92rYikcxPi4mO0zewZiBSjnQ9w/vPXr4R4Aoo9c2m8wtVkgH
 ONeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786986196; x=1787590996;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gv9AMPQihGRdITLoUHsBCtm8aBk4F/JBgXJrs0GQkGk=;
 b=dNNSXv/VH348nO9mSYs8fK9oYoq02anHEURAZQe3p94VWCGpYj5Hhwbz2jQbofUGYn
 j+xZDuoGcSZ9AwHaCIp54q4xIXK9hA4N0WSIgAlAI5M3krN/qm6v4i1CO2ov2TN5xKwA
 +m9QbAScq3xXFOBHTjT8VrQ5LwAJGdv0q6EWLllVe8OnXPimLJAOQ2pCSsjtHDM5azjP
 QxMMAPQs0urAqrgPAr2paiQwOUZg6UX4POni5PcPZ1YIuzq5vEszg/giLcfbl3PqO01a
 3FbPO47i4R6vBtdicdlHiovnO/ZAThUen8GbMWIeRTwrQUVWPN1UXgIJlcfviS9qSIy2
 harQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rox3sJVK7STB/Q1vmADFf0AG1F6TKI1ybrMCYm93csPBqdQwXPoEj+KYw/tyV6h6hMVXEEnNeY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy8nXx8eyaR3impAt2HKr5NhZQRsy0hsXKI2A1QNy+knHARnq+9
 /WWXPw741B9r7h1RxpShDM0kyYSRFL0FKNPlw6Z+2rwUheTPILvAQM7oHELk7IvUNw2d8UFXcA9
 /3WN3rQox5wWjOFg3jd/vWUgXCp1W/hDLgup7jYzhDovxNYK8hQMfzh5zg+3ij1/IUqx9B9wu0N
 wjvfg=
X-Gm-Gg: AR+sD137aQ5Eviop+nCQig0rYEsAAwZpWmOWQkgB8iY1RmW+Ak1KD4dnc7oHeGvjw8M
 QraYK5kCTL4S3SvM2D0fZcUUP0F0rNgRqn+Z84bqR+cj69hPKdvN7C4oLPSpbGWoFB7d0KiaWJ5
 N4646N8FZRCDm/CByAvV/K+YvUpaoKTdeO6lQegjLAabRcyGg3CDaJ5OxgMAInSCINWYbsVzmCK
 TA2Ayuk2t9kT1WoOXPQaXjKrB4EN6ktiit1Os7mfH9d0e3WPAOqyvwRAEcU6KBnRhEP+o1M+zHJ
 +I+CFWudpOPYfpHmh9UQN+zJtzahYV7UMb4ZZaRNJYI907H1sFcENKrK+v8KE8owpqqvCbCjxZI
 n4VQK+N/PV0EC72IVP0fhyIvDoGfa4N+Y2a2XOtag9YAGRwRajLLa5mFd/iPq6G+21dLTM+Gmn4
 sBH3jri5CUSXfbUZ4xMXW+YeRX9O/1zIuvCetxKyG7J8AgyqQr4rKv7iSi9kF8vXOz1PRSAibxy
 FJXxoqaq2dwxE9/wZubbvxR4XY=
X-Received: by 2002:a05:6214:1d2b:b0:8ef:ea2a:2728 with SMTP id
 6a1803df08f44-90a91de3181mr304960456d6.19.1786986195663; 
 Mon, 17 Aug 2026 10:03:15 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com.
 [54.236.161.35]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c45857fadsm12931096d6.18.2026.08.17.10.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 10:03:15 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io,
 Sean Anderson <sanderson@brivo.com>
Subject: [PATCH 1/2] pinctrl: meson: a1: Use gpio regs for ds
Date: Mon, 17 Aug 2026 13:02:32 -0400
Message-ID: <20260817170313.1940219-1-sanderson@brivo.com>
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

On newer SoCs, the drivestrength registers are included with the rest of
the GPIO registers. Linux has a rather complex system that uses a helper
function to fix up the registers for each SoC before registering the
pinctrl. Instead of that, just fix things up in probe.

This silences warnings like

meson-s4-pinctrl pinctrl@4000: drive-strength-microamp not supported

which I encountered on s4 and which I assume affects a1 as well.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/pinctrl/meson/pinctrl-meson-a1.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-a1.c b/drivers/pinctrl/meson/pinctrl-meson-a1.c
index 7e9ac6390b1..e9a7522ce50 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-a1.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-a1.c
@@ -856,11 +856,21 @@ static const struct udevice_id meson_a1_pinctrl_match[] = {
 	{ },
 };
 
+static int meson_a1_pinctrl_probe(struct udevice *dev)
+{
+	struct meson_pinctrl *priv = dev_get_priv(dev);
+	int ret = meson_pinctrl_probe(dev);
+
+	if (!ret)
+		priv->reg_ds = priv->reg_gpio;
+	return ret;
+}
+
 U_BOOT_DRIVER(meson_a1_pinctrl) = {
 	.name	= "meson-a1-pinctrl",
 	.id	= UCLASS_PINCTRL,
 	.of_match = of_match_ptr(meson_a1_pinctrl_match),
-	.probe = meson_pinctrl_probe,
+	.probe = meson_a1_pinctrl_probe,
 	.priv_auto = sizeof(struct meson_pinctrl),
 	.ops = &meson_axg_pinctrl_ops,
 };
---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
branch: s4_pinctrl

-- 
2.53.0

