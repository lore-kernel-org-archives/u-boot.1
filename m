Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FCFC5DF7F
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 18:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E1C681166;
	Mon, 17 Aug 2026 18:17:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L-u3owNB8Es7; Mon, 17 Aug 2026 18:17:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 83B6881112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786990659;
	bh=gIJC71MvXoGSMHM+hoGJCWybiSoBjCDRZKN0lFU7bCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gYfdcRiNr742l/2qJ1QMbn3V7rbYiOs/GHRjANt+owzvMT+n2BZXXr++RYFLSDH7v
	 zzc/ZyRq5FzMlGjrsCqMSUNWvmcRG2KvgF55K1P0lRQc6KgkPMoGC8w4Ee1eziuXJ/
	 noZR4AQBAmeyafI8glr47IiWEVRJSBZBNw3hOyzVyFg7u/PcNZSkTTpT+RNSdEotWF
	 j8K1SehrJettX7A2xfQN00UeUiKpYecZtYrANkiq5m9EAb0KjsPw3+Qo6OygJqh7iw
	 pprihu77kyL6KWVYFivkzd3+JK1twa2Qut+/IrEz3/RTDdSPYGCEzAGUfcX1mzWXrF
	 oLc9DKBg9559w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83B6881112;
	Mon, 17 Aug 2026 18:17:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 489B233B
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:16:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 46999607C7
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:16:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nTkwQOZVhxOd for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 17:16:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f35; helo=mail-qv1-xf35.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2849F607C3
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2849F607C3
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=jvr3gLCf
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2849F607C3
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:16:29 +0000 (UTC)
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-8efbafa1bacso19415046d6.1
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1786986989; x=1787591789;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gIJC71MvXoGSMHM+hoGJCWybiSoBjCDRZKN0lFU7bCI=;
 b=jvr3gLCfunVq3/aSS03wGUBVeFrQNUrC3AipEQ+x5nSil3v6pYim3c9f7rSB99WWyc
 qumJM19Hbf8k5Oxptf0dQp6aHhdbf5DuJ7PAZjDwPkHt8iWtcCDfQj8xk2nDpb1pCjB8
 RrjD8IS/RLF1a8T0NeAeWLSpUwXgUk+30EcBqZAwEo7AIYKc92JexCcM6erzNvEu6spl
 I3tqYYsEpYN1rM/1rpLcDNel+LJ1TfxxvD5ukYRyb8tEVjKfxUjNSS5nJqfSnUKLVMEo
 gzmKSSbzhzlJeb36PybSrDCAHgvYqSNCODakPYpkxib9Ff+yiDTkw9obsGv1lRCvfsrr
 i9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786986989; x=1787591789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gIJC71MvXoGSMHM+hoGJCWybiSoBjCDRZKN0lFU7bCI=;
 b=Ga44rCaWL4d6oxoqMRmzjh7cq+efGrP3n058N07VGbhmfi/mwzCshsM0/aKr3B20VX
 uti17yrMzFpfzvdm1/qPVuTAsHSMqzwFLV+DZjRYFndNwotwhSGXoELvbJPePBAVNqIT
 D1Y0QLzu4SVhzmeNhgC6lsiBUAgfeq5CXsTr9QTURMsYI6D/efHwItsG+44bAWtUwDTC
 0tuJeX89FmD/SoYymtAbrzJdu5do/XXMcFMRIoIBoDOnSo4V+Hazqu7PZg/QxXyQPoL1
 JqYY4u5o3WWfkAU+oXXzQdhmLqN8bhFhF557HSuJsTL5jFIEyl7xUfith6aWItmnzAMG
 3Qog==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+RvyVi2cgXU7SyF/e+MyxzYgIrMVXEKhh2/MF37VfQYmSIQDwI2DSXDcX2z7+ZKi1fo9Sats=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yzv95L05wSEJ3gvKQeyW4fKNWHUka2fXEyUMNlqiazTl0t0VTxt
 GdHlCvUsSd/VsFM/HIIjbXo63xUrApDNi2FDqn3E7THJvHYPAz5FisOfLb2q46YqB2sWAlzSUaz
 PoH+FeK4+3S4oeShk6/KCrSJeJ+3xsvUUrKdf59hEL2tUPqDCNzlKDi8Vz21NqvI=
X-Gm-Gg: AR+sD12a7gf+YVcu9gFQ1HH0aUFZfKKIiWdXjsS353ciiVja+5d7zdb508rxO7YRWuH
 uPjuE0Ammr3qszT8SO+ht53xm9Q186UYhNc7xuji3fHTV8/WqvSfzBzkP4NarkWfiv5Qys9j+du
 Osxkur2VG5tsZ9Cu1tDZ2YHGHBytx7KbQb1f/KY2go5h1EFaZU1aCB1j6SEYKiqOoK/D1XhCjDz
 JOj/0ogcPnN+Ne1Oa4ROM2oaqR4vgjmk9uVWTC2Uaare+vonNY2gcDCCU7PEwsZiPfhXt/LUZNK
 2MEjBvRvivztyGDsbDGHZD9d1/mv2vbhjaUIt+Z0bVsX3DLmljbRqHyvNU5ZiQDx2IkbLE2NTTQ
 YzNtW+Q2vqF0AozJmpYpETysb6qpsLxgcaLZB5nA7ez8jFqMjhkmzXssYUn4EmBG9U4S9g2/i65
 QlBUxuURHGKEScEgSg1OTA4381kJky2HBm19+sVP5zBbBCvUXcStIAuc2wCa0EdC4n1HgZDIMDf
 wSIvSSaA9MGjtLSjd+1hftgszA=
X-Received: by 2002:a05:6214:e89:b0:8cc:d066:54d with SMTP id
 6a1803df08f44-90a91d8c3f2mr297402926d6.24.1786986988248; 
 Mon, 17 Aug 2026 10:16:28 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com.
 [54.236.161.35]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c459783a9sm13637976d6.43.2026.08.17.10.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 10:16:28 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sanderson@brivo.com>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 3/9] clk: meson: a1: Use clk_set_rate from meson_mux_set_rate
Date: Mon, 17 Aug 2026 13:15:14 -0400
Message-ID: <20260817171623.1943847-4-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817171623.1943847-1-sanderson@brivo.com>
References: <20260817171623.1943847-1-sanderson@brivo.com>
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

This function is useful for other drivers, but it's tied to the a1's
meson_mux_set_rate implementation. Convert it to use clk_set_rate so
the drivers's set_rate implementation will be used (no matter what it
is).

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/clk/meson/a1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
index d0376663069..422cdf5f4d1 100644
--- a/drivers/clk/meson/a1.c
+++ b/drivers/clk/meson/a1.c
@@ -523,8 +523,6 @@ static ulong meson_composite_set_rate(struct clk *clk, ulong rate)
 	return 0;
 }
 
-static ulong meson_clk_set_rate(struct clk *clk, ulong rate);
-
 static ulong meson_mux_set_rate(struct clk *clk, ulong rate)
 {
 	int i;
@@ -542,7 +540,7 @@ static ulong meson_mux_set_rate(struct clk *clk, ulong rate)
 			.id = info->parents[i],
 		};
 
-		ret = meson_clk_set_rate(&parent, rate);
+		ret = clk_set_rate(&parent, rate);
 		if (!ret) {
 			SET_PARM_VALUE(priv, info->parm, i);
 			break;
-- 
2.53.0

