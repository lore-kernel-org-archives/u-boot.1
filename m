Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0339DC5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:44:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A91B5405D1;
	Mon, 24 Aug 2026 08:44:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z4iJTw_-4_jH; Mon, 24 Aug 2026 08:44:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561071;
	bh=gJkoVXt4hGH4IJvS1FUdBPojdGRI6LLmZ/Daimf/us4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X/925ih9sQF0WtlZiVByK5L5fTJTBViRoeDM9JkrqAdYbUzJugosb2pWnI1IugK51
	 QuC2u7DnyeLQWaB/XBJUnHiBObbGTi+/TXnBXOtxFQXUY9cp65gVrWzRcTEj23P2Z5
	 iQkt4PYAXDukwyGl4hYYR1dfYMt8l7sxyVX9RSbdjZageS+pSow9cDcIj989sDKpMp
	 rozuZRPvUqHMthWa9jC2Prs7YjOPE17AJGs3VCVSawPuPmEEUjk5SUOCzJKSYGMY76
	 gpxBDgdQJro+KjFf6M5tNO2G9AkFOje/e2gS2yjrlYs+f/A+JDiwyMyUcpF88nZJCB
	 RLbuPfzDndtdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 460B54053D;
	Mon, 24 Aug 2026 08:44:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E97E3AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D208400AE
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:44:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OxTbhHfhuTEw for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:44:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=b0DzeK1o
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C66E14005C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:44:28 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-47fd4531020so1826745f8f.3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787561066; x=1788165866;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gJkoVXt4hGH4IJvS1FUdBPojdGRI6LLmZ/Daimf/us4=;
 b=b0DzeK1o2BRwtmNb4AnLZgyAbEGsj36lHu9jA78wAjNKrfVfm5fmn+IX6+5+hDG7Ww
 xmo+CFirqvRxW0lDEZOSLPX2lFwukJbuB69kBkqJD/FbB0rKRPUt40VO8B6pcRn4C2Kj
 OrPoE7NHCS1r7w4CA+FJOmWYuSl4akbYmOTLCVCRHEf1R5skV0C1vo6MZxOgMfZIrekO
 ctxYgCpXQU1/7aXqmKLCF+RLaaqIsv4g9qbHl1LWMpk3+8TJNTDcPxQQ9tuCYbEA5ji7
 NK7Pe6CQxL7oU+zGjppKsl9xZAwRUc9q4YzJDiFrnTMurDqe1d9X5SuFkU/9QR46dXza
 JjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561066; x=1788165866;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gJkoVXt4hGH4IJvS1FUdBPojdGRI6LLmZ/Daimf/us4=;
 b=OpWBKdJi53g2ubvdxc/OxzzIfveSnUju1VWwSc6hftWOYejYd7pfgHpiTD4JKPDK5i
 vZX9L8r+jMbJwXJIWS1XszJK1ikGX4RgH3q4139vaT6DZ91v8B6biaMvzQWTpOubXWO8
 IzCP5k/jNaNETqJHmJ+j9kK6O0vJ92vinSbSQFOm2oWtG8QnSwcxYpBCXU/cUhDLThsf
 cdCmz0M68k/JGQW+Rq6FhfePCh5zefdSPns/R5v8C2vt3fLL1VQ9OfntrZ1cVnxrfF0A
 xle3k2h3WnZTp4TA9pRFS9PrzHQ+6bQPtC0oUS/LYZUxvcvmfoTE749PJgyV4xJMbDvp
 34QQ==
X-Gm-Message-State: AFuF++lhmd7FQfNaUmXDSPyVDMQkq/Q/dCmFNnaZZM8SjAofHRGHRFUT
 OpwbYKVs+9x1UHfZHZ6gLEUrPiiPGLOQAeljovNqfBw8497aZHoLFwGx12tlhArSe4g=
X-Gm-Gg: AR+sD126I5s21tjXGQdGFe+j20BSXBbT1JFqbY0VNVqlxTnAYUqGuMbeT9Ng+GHmXJF
 KguGxbPALCsoskRZYEjE+ZjAOOciwgD3mO7oik34QL7j/r4Hi8jgR0s9E2FipyowQV4xkji3NOB
 uZ4Y3RT9geMFKpELKnllGbZBK//hX/ijrSJtyE5NU/+FWdFw7JdEPw1n/+l1tMkmsMQ8uFWRgwR
 OxVt7x3C470n7DR5xR7ii2EVBO6QjgO0V1YVSdrIMpnfEXcZnTJnOu1P/nI0mK4UjLx+MJEIeRs
 lei/a1I6pdnDdtIRTNhI2Ber5hiweEm6wMl7uy8MBfYMGynfQUofSBy3WiRShGZd3tGyekPmjXF
 Fx4V0bK3aWFLqzcd/KlRW7nItnGTw26xUsiIyaWZNyn1h5800a9cJpiFJJ5DsXDUonwzqnGetzQ
 nLWuYnWqTMG+3Xmdpg29aTCL5yHWlm7DacBUYpWX0UHWzQAhuBVxjMy31KXzeKRljbR3Uq7H7Dk
 i4lqm2wpt1Me0FXxAicsutfu/1QCRy9emJgZlfphUNzm9F+L6h/G9lsNslkIie/qmu8urO3AKwI
 Zx0p8zCw3vsU+U9OF9v0uEVsWioPX0o0odXA4gsi93PnKA==
X-Received: by 2002:a05:600c:3f0c:b0:499:79b9:e226 with SMTP id
 5b1f17b1804b1-499c178db57mr179937565e9.0.1787561066313; 
 Mon, 24 Aug 2026 01:44:26 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499c35a1aeasm79788475e9.12.2026.08.24.01.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:44:26 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 24 Aug 2026 10:44:17 +0200
Subject: [PATCH v2 2/3] dm: uclass: use dm_err() for a missing uclass
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-improve-logging-on-missing-uclass-v2-2-4bee2cdff72b@baylibre.com>
References: <20260824-improve-logging-on-missing-uclass-v2-0-4bee2cdff72b@baylibre.com>
In-Reply-To: <20260824-improve-logging-on-missing-uclass-v2-0-4bee2cdff72b@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, dlechner@baylibre.com
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

When a uclass definition is missing for an enabled driver, the board
cannot boot, and without any extra debug option enabled the only output
is an obscure message with no hint about the root cause:

  initcall_run_r(): initcall initr_dm() failed
  ### ERROR ### Please RESET the board ###

The existing message used dm_warn(), which is not shown by default. Since
this is a fatal error preventing the board from booting, use the new
dm_err() helper so it is emitted at ERROR level and visible by default.
Shorten the message as well to limit the code size overhead.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/core/uclass.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/core/uclass.c b/drivers/core/uclass.c
index 5365ac68f9e..83a67dfb4de 100644
--- a/drivers/core/uclass.c
+++ b/drivers/core/uclass.c
@@ -60,8 +60,7 @@ static int uclass_add(enum uclass_id id, struct uclass **ucp)
 	*ucp = NULL;
 	uc_drv = lists_uclass_lookup(id);
 	if (!uc_drv) {
-		dm_warn("Cannot find uclass for id %d: please add the UCLASS_DRIVER() declaration for this UCLASS_... id\n",
-			id);
+		dm_err("uclass %d: no UCLASS_DRIVER()\n", id);
 		/*
 		 * Use a strange error to make this case easier to find. When
 		 * a uclass is not available it can prevent driver model from

-- 
2.54.0

