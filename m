Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEBED1D478
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 20:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24BE08415D;
	Thu,  8 Jan 2026 21:15:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G1quM4Ax";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C4CC841DA; Thu,  8 Jan 2026 21:15:33 +0100 (CET)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D82084158
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 21:15:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x543.google.com with SMTP id
 4fb4d7f45d1cf-64b9230f564so5166464a12.1
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 12:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767903331; x=1768508131; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B5povxlq2z17f9INO7Ck08KqGleuNjRuRPeYwJ38ppw=;
 b=G1quM4AxlUbTa5jxE1Zu/itqJKRMEMISCHVE5slsw2lUFgWKA3h+dg8kd+X2T7VxOU
 t6HbrHAaYGd86ehOzNARyEGeWHyPK6WzEeCN6Ju0a22C8TvTnF0AFJCTuMdn38ATJCk5
 eMFzTaCGuI0e1Al1udprrVVUOPdn9Yz7EFhymOTYxlLe09sNkqB2nCjxuvvIelwZRyqS
 cXAD5WleCDiS1J/AS3AFAYb1cLKsm8HZAjweey/D04BQqjpeVg2yLzacexCjJKlupzIx
 HFKQSn6EEr+iwLSqPKGPnhrC0ebYTCylohVDHlfXWI5RtVu1xd6PTqHHOzvpKlX4SZOo
 W2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767903331; x=1768508131;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B5povxlq2z17f9INO7Ck08KqGleuNjRuRPeYwJ38ppw=;
 b=WuFAy7VcYWEhdgVeOBmBLundTlmc/d+yqcbkAAnEX2j2yZbdwBlsUSDU8GBzB2fYVS
 VuOSlQk5PwfjhCN0FDpBKyroyUVVcYF9SF5p3UB21tl0PUXZFyVvXekI7gLL/l0MnCH9
 3MRCCzod209tZMYadXAKjU8pooOuyF4j+9nvXQgbDZju1aU0//JQEbjmqQ8o4f/BjQwX
 5t1Zf3kp4xx0IahAMVJOwqQGaTAT6f1PN7IRXN2WdLnDDEVaJ1usySd/yXMgSyaspvD7
 xiPrGvclTqenhBWpaMD2HK946HDQUsBrWeYitCaa1OjxsbvW/A6xLYALHLLqiKsVWB/S
 U78Q==
X-Gm-Message-State: AOJu0YzL1jmFT5QafroSjy3SFbMYQn8hlYywcUSHEcBagRMMRaiEex60
 MgwKqtVDDiX1EnfGmujKiSir+5O73IaYg5g55gbg14HT24qWQ8QjcvG3V83EvIR4tRQ=
X-Gm-Gg: AY/fxX7LX6gfQrvEOU0g6NK5eapkRpLjsI1fB90i6sS+DmumTn0GcwV9gMfDMTo3d3L
 ZiAT8RMmp9sUKSviouC59sFi+22xpgMNxLnXQapuprSpjHo8yGkeg8Coa+AqmOnxO1Zn+JkAnp1
 ogyjK1YnuxgFqysviExpbotpTu+kl/5d12zBd3UypSiJiEkyvMkdjjdVy+pQ9toEr7C3w/sFojJ
 r816ynlFxNNN7UOgNfiJOFYwU0kd5QUj6eClIqyan8dDXdBsbIwdp462jHISiPkTnXqg4gEdett
 qqQYuAARtwi/5Sczd0g2YVzhQ/m8GGOm3gugirya65oe2BIQElO8TqbTMN4DBOTovtwYUtmX31E
 FSq7gZ3qn3VoBznT21jMnHfHdqOf1HiWLkuGMYeslufdVR1AiwvGsQw7OjjVnEt45GuWnz0hgm5
 w99aWUBgIob0EtzRjDzI/n2lm/+NlDwcbjn2eSrapgvK6+7PlSPXotuQnzOhz8+w==
X-Google-Smtp-Source: AGHT+IGjjt8sS40D5sCGyk2iZomjRlDp1koGLeEITduWd9a72zHzrg7lSQJflyWiU4obny9I2abvyw==
X-Received: by 2002:a05:6402:430c:b0:640:ef6e:e069 with SMTP id
 4fb4d7f45d1cf-65097dd11a3mr5853691a12.1.1767903330610; 
 Thu, 08 Jan 2026 12:15:30 -0800 (PST)
Received: from lion.tail248178.ts.net (p5b29e30b.dip0.t-ipconnect.de.
 [91.41.227.11]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d5e0sm8350442a12.31.2026.01.08.12.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 12:15:30 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2] ufs: uclass: fix potential unitialised use
Date: Thu,  8 Jan 2026 21:14:01 +0100
Message-ID: <20260108201452.3171709-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

There's a few weird codepaths here including some that return err before
it gets set. Clean things up and drop the unnecessary label.

Also make a note about returning 0 when ref clk frequency is 0.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/ufs/ufs-uclass.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 3c8e4299259c..c6ef93dd101c 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1862,45 +1862,43 @@ static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba)
 
 	/* get ref_clk */
 	ref_clk = devm_clk_get(hba->dev, "ref_clk");
 	if (IS_ERR((const void *)ref_clk)) {
-		err = PTR_ERR(ref_clk);
-		goto out;
+		return PTR_ERR(ref_clk);
 	}
 
 	host_ref_clk_freq = ufshcd_parse_dev_ref_clk_freq(hba, ref_clk);
-	if (host_ref_clk_freq == REF_CLK_FREQ_INVAL)
+	if (host_ref_clk_freq == REF_CLK_FREQ_INVAL) {
 		dev_err(hba->dev,
 			"invalid ref_clk setting = %ld\n", clk_get_rate(ref_clk));
-
-	if (host_ref_clk_freq == REF_CLK_FREQ_INVAL)
-		goto out;
+		/* FIXME: qcom platforms don't have this wired up yet but seem to work anyway */
+		return 0;
+	}
 
 	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
 				      QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0, &dev_ref_clk_freq);
 
 	if (err) {
 		dev_err(hba->dev, "failed reading bRefClkFreq. err = %d\n", err);
-		goto out;
+		return err;
 	}
 
 	if (dev_ref_clk_freq == host_ref_clk_freq)
-		goto out; /* nothing to update */
+		return 0; /* nothing to update */
 
 	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
 				      QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0, &host_ref_clk_freq);
 
 	if (err) {
 		dev_err(hba->dev, "bRefClkFreq setting to %lu Hz failed\n",
 			ufs_ref_clk_freqs[host_ref_clk_freq].freq_hz);
-		goto out;
+		return err;
 	}
 
 	dev_dbg(hba->dev, "bRefClkFreq setting to %lu Hz succeeded\n",
 		ufs_ref_clk_freqs[host_ref_clk_freq].freq_hz);
 
-out:
-	return err;
+	return 0;
 }
 
 /**
  * ufshcd_get_max_pwr_mode - reads the max power mode negotiated with device
-- 
2.51.0

