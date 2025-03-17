Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445A4C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 16:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A61180F4C;
	Mon, 17 Mar 2025 17:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i7OCd/Xu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FA5F80F70; Mon, 17 Mar 2025 17:15:12 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D234681101
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 17:15:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3912baafc58so4018842f8f.1
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 09:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742228109; x=1742832909; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RYoNDWBd1pk52lnnae64fQWh33wTs+zkh3+IU/o8DjU=;
 b=i7OCd/XuMR0CPn4ti91HqEtQAaXi/qO8vNgaWVdByF2P7OQVIHFSngmJuT2mp43IeV
 uc8s0pARWsBhOswUJ5SvEJPSCBivLV8b0fNbgAw9Om1iMiJkL4NuYPuLLzgcaofvbglf
 H6IYXRbXRdQUHHfBTHHTazO9ov222fViQ/0GXWMI5X9ZcGFJi0/nHPvYOdzQJEH1n9DY
 5FJDQZ9hjaPVo0w1pWFgZfX6b1m9M2RjLteGRStvZA78E3vkjDmbYRsCkdohSrzKm4Cs
 +x8aq6VIXJqi5tI0uSRWBtJKIk4Ad4KvpRoL3nZMVp794kocVFUWPyjYS7Dd36DjVCff
 4SNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742228109; x=1742832909;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RYoNDWBd1pk52lnnae64fQWh33wTs+zkh3+IU/o8DjU=;
 b=QR9tXUeJC/AYifgm/qV07fLk+hQ+Ia2vcJhfmkfODCHzgBbzhhMKjpXoCYb1d0xGB+
 iHOrxSUIBSBvrNngws4rDD2uzOHZy92hfEBrpxh/yQGTHwhlTXb9erAAwMbLIabfdSr/
 aabWyXf8hAtbEjzjDFXnAUqCOtf/aDsgmAMzBatAG7n8+csLPHROIpJXmZGbFnn2QO5/
 KchZvP1fHMM7PlsDs4Dy7y5KgIMC/vN8WG4kOvl8uiXr+SgImRkcRicoHU06smwXeTDU
 2gqaO72dho671hq0R2xMcwJFqWO/W6O8M5GHCUKewUytM0cFB35tj6JoN9JgVqMFMHt4
 wCpw==
X-Gm-Message-State: AOJu0YwlMTWjkvklMwGNXgAQE7zY2DuL1vyIF925RZnlxjl+b0eiGQJR
 TJgTDhbGVZHEMRz3Tpjuy1FCbXpkCOqNbeDuIMWGymS4FQfPrG6FQXO4zhrdGuU=
X-Gm-Gg: ASbGncuuijO6G8S9s6hHebluN8ea5nVl8dFFdaCAjpLNbMSIdVUxisTgKdYNx3XLrOU
 U2T1cQ9YkVSqxGMnbqS8HxMJFkU6afwWwsgkgkK12nKiZlB7FanFfITTByv2K+mLOUjoFgQNMmo
 bATGImIM52AYfBwNZlp1BzONfg+er0ImppqdKIvoO40XAHwH8LXmoE03bdWUuDRlYddOKTNq2YU
 36ddHszXtIHs7xK60+KNJNv+TYtQbpfIvOe8la8dIYr8+0Li4AXf89M6VBw2y0QsVCrNwhQqWpb
 F657Q8ZP25IytWb5qDOG68sqVXAXQqPdJeoL/fizR95ncTqIm0QXeK6xM1GnPJK/9CND2Lo=
X-Google-Smtp-Source: AGHT+IGsV9O8mR2Gus96BHIsf9kiod8x0OARZO6Y34FSNcOWdzVNqR/ZgQWa2+XZlLIVxbe0p7uFyA==
X-Received: by 2002:a05:6000:18a8:b0:38f:4fa6:bb24 with SMTP id
 ffacd0b85a97d-3971f41160emr14942250f8f.39.1742228109209; 
 Mon, 17 Mar 2025 09:15:09 -0700 (PDT)
Received: from [192.168.1.116] ([2a0a:ef40:1d11:ab01:670b:cd84:4753:5ae9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c888167bsm15382001f8f.45.2025.03.17.09.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 09:15:08 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 17 Mar 2025 16:15:01 +0000
Subject: [PATCH 1/2] clk/stub: add sc7280-rpmh clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-sc7280-mmc-ufs-clocks-v1-1-38e05c16511b@linaro.org>
References: <20250317-sc7280-mmc-ufs-clocks-v1-0-38e05c16511b@linaro.org>
In-Reply-To: <20250317-sc7280-mmc-ufs-clocks-v1-0-38e05c16511b@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=786;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=mxsTDUVNawHPfqewlS9Zkb5/HM4q0L138+12OiETZFE=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn2EqK42tJNjcGd976fwELG6km5G9PMddFOA/+p
 SJucNjvi22JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ9hKigAKCRAFgzErGV9k
 tonLD/968pgiQQTKQhamqBztWwZpn9hp/9Abxd9WvuS7ccFpuyktivDeytfHZv+hjaUktBPBv1C
 fjs7G+oF56WTUiKb6UPKNGf6e4nJTWj6kdqDiLl2X9JHBn1BCuyffVW4BZsFuyCJl3Aol6Koupy
 N9uozniSmspFABKjsp+RTpXp8LuHBatLwXy1PCYAeqOOJuJ2J30A1OFEw3eRVv4QXxAwNGiTb6y
 F6Mp5oZ68H4dnKmA/2DvFvdS48nchJMgjxMm07p0k1wGBwVwKfLzljA5FSD4iSddu7zTrpdrLNB
 uWm9Ztr+SynMVtfDqLZlxY/rbGrTzlnh5Vx+nIg+6PoGGaX/2f7EJzU2/0vDnUWgRUebGpC2LcL
 MOwkKJAHUe2fJqrjPK629yPafIS9c+JQQK3yj9Gy19qDT7zTlNKLhQWk5ccb0m6PwT7Cq7KJA7g
 xtyVYRQzEX/CoouEBstgM9Jwvmtbw0SdhH+DiZH60QdlFmjLJtbcbo+5K/k+CYo18+wOM3P488/
 WyBYoXQWZfriC9MHFqwq3VK7AQ+5XllKL8A+E5/tGfydrqWBzDwUPj3S93FFPnbxfubFt+u7Trg
 6r5nDuwmWNUuoi9BQ+kQQYB6+BQmp7tc2i1cxwTArotRtyfo62Lm9RyVPRsEKrtq5BRQaWOroU8
 GEQqV/XATA6bcoQ==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Stub the RPMh clock controller on SC7280

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/clk-stub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index 5fbbb07b7f7b93e619baf596064c4b3a3bfeecc0..343fa5cd3fe1704c6bb15a8c9852b9b4e4990351 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -49,8 +49,9 @@ static struct clk_ops stub_clk_ops = {
 };
 
 static const struct udevice_id stub_clk_ids[] = {
 	{ .compatible = "qcom,rpmcc" },
+	{ .compatible = "qcom,sc7280-rpmh-clk" },
 	{ .compatible = "qcom,sm8150-rpmh-clk" },
 	{ .compatible = "qcom,sm8250-rpmh-clk" },
 	{ .compatible = "qcom,sm8550-rpmh-clk" },
 	{ .compatible = "qcom,sm8650-rpmh-clk" },

-- 
2.48.1

