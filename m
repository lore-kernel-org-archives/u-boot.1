Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF1DC3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 11:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FBEB88001;
	Fri, 19 Jul 2024 13:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WTD1wGPe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE1CA88B84; Fri, 19 Jul 2024 13:00:19 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F99388B8B
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 13:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-426717a2d12so8014805e9.0
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 04:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721386816; x=1721991616; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pRXlMLo+mMrIjbw8kD9NHKRqyotXea3NhoC7/eGbktQ=;
 b=WTD1wGPeTTFlj4T9m648Bd++Ynva9Vz1IEmr7igt01iiTi16Klabj1FwWHaMHNVsZh
 ZTjmmXBhU0FC0V5KREE+g5KP8lhvaGgnaSpWgqlazhzEGojcub26yPq9lAVNXimCSa2V
 FgmlrmD9Krch2dMBbdAEI3xPwB8AuJsH9xwdEU9zy/y4HEgS/bCylZr3cezf/3HIRnAr
 eszXk3yrSCcVJEXqoQt8Azw/oUAPGqBVIvg6Eoo/cwQoSjNKfFVOB5cAG6KQ/frqpwvy
 bl291MVs4n86hG9mut2763LZDmBN/RFlI/t2Ca5hYJBQfgOjamNEhqJfigCuzijNv8hw
 GqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721386816; x=1721991616;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pRXlMLo+mMrIjbw8kD9NHKRqyotXea3NhoC7/eGbktQ=;
 b=cWvJRoOvdCuBALUqx6WWtdCorzm9YIyrc9uhnhPuRGAiIxN6tbQeSjt+WQ/j3yOM9b
 zlPMsTvaGFdQ/N1mCYUiQwd4kddLheOAbhHrEIUSrlggetpZAgTT0gvp14Z8Ryh5Nt/v
 DMRAdz8wDWMsXHQKOu305YU27qBolVkJGA03r63jtfrhx1XJiHRQsh6kMr/Ssf3kJToq
 EwyyclZsqTuPzM1TLCrfWXx9WtUyrGDfSQhcJFHCtNqc7uZKJw6zVaONUlAlni1OysWj
 b3kvVaYPpKHaC+RVn7INGW2oCnc5RmuKzigYZ0HiUKZP9+X+msru/BP5XdR8Arw3NEc9
 sBUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGl4nv4DE+PkK4MxST4dSe5RGSmGcVORw6WP+9e5DEgaw7g85gVlILmPwozM6OSYwc1M0Q+bbBqEc2+WCLvEmaM5bw2g==
X-Gm-Message-State: AOJu0YyDHKkMLHsZF0Vh2ak4rNjuWQbTwyepnDcdYsJoinbX3MFnBgn9
 Qq6FrCsoRQmcQ8M501xBH/i7M/jltSiBbcW1krqEv63fA6OwcmJyFEo+iEWxNbEwqIWar53HOv9
 J
X-Google-Smtp-Source: AGHT+IHx9AsC7bFocyYkVfbG4rKZnZMRJg+wdWO9kNyR0pVHupnMU4lBQx/0q8HnMie+QnsA0Ou1CQ==
X-Received: by 2002:a05:600c:5486:b0:427:aab7:976b with SMTP id
 5b1f17b1804b1-427d2a8e1b1mr28609585e9.5.1721386815817; 
 Fri, 19 Jul 2024 04:00:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6697c3fsm20556055e9.0.2024.07.19.04.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 04:00:15 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 19 Jul 2024 13:00:10 +0200
Subject: [PATCH 1/4] ufs: allocate descriptors with size aligned with
 DMA_MINALIGN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-u-boot-ufs-dcache-fixup-v1-1-b044fc9564e9@linaro.org>
References: <20240719-u-boot-ufs-dcache-fixup-v1-0-b044fc9564e9@linaro.org>
In-Reply-To: <20240719-u-boot-ufs-dcache-fixup-v1-0-b044fc9564e9@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Caleb Connolly <caleb.connolly@linaro.org>, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=9uuL7WgYDcbYQ123de/k6aM9CyjgPchU1v9LdgwJNHs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmmkc8jaKIBed6JukbM3+trpgoq4vS5+0dQOv+UAkE
 O3P5lFuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZppHPAAKCRB33NvayMhJ0SAJD/
 4qpmUovPRHm56EUxriUvTZPVlgCTeKI05cBHlBHuiMHnvoZNZUn7ysgelA89MNWmcdoPXKVznTFUJO
 itBVLtOiHtGN5fljVHCdLedfkp6C6GdsW9uACzlCva4/mih4US80Sdl65V7YZf7C9/73Q85xATE3iv
 bE3ccXdMa74VPjrLU5OclIMPcNrQvQTd6apqFgipWVgVx0VqTcrybD9vncO/ms/OCLKRL+Z3wlUXSk
 3PmmJI1mz8j3jTmPXfWGMsqC9Y0jR3BLLE/KFhJHlfi0Cr8glXLOnUJJWRTpCSe17WP29P+5zyNpUn
 5oXxUGJj0604obo0IQYaneoxsK0JaoBRBWJ4OeDIZ5Qem52014TeH86wNIjbc3B9hVoZ5o98YoyD8w
 MdbnHILP3Ju8ZLENyj2shSkdw7WHYArZSBPOoKk8aWsUA7gs9I+IfdU3q+IclKHzxU+RGxs28aap4o
 jWKfjoeDV3uTxF4PYbqVVfo7dbRZiKjg0dj4+JYQkResNcGup+dymUiuq6wLS80dMQYZdXRlktiOzG
 RNQCiSn2m3PjvmgAmplm8g4ZwGGAmHa6fh4ITsBGpp2TanXtMUc6simyfBreW1VE4ji3Vf3q0RB33h
 tGjtBK6texbnug0br8+txGSMsQLAMZGCI71BEdwDFQvgdh+hlNPv6ZPCQsYw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Align the allocation size with DMA_MINALIGN to make sure we do not
flush/invalidate data from following allocations.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index e4400f319a7..bc86903245c 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -634,7 +634,9 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 	/* Allocate one Transfer Request Descriptor
 	 * Should be aligned to 1k boundary.
 	 */
-	hba->utrdl = memalign(1024, sizeof(struct utp_transfer_req_desc));
+	hba->utrdl = memalign(1024,
+			      ALIGN(sizeof(struct utp_transfer_req_desc),
+				    ARCH_DMA_MINALIGN));
 	if (!hba->utrdl) {
 		dev_err(hba->dev, "Transfer Descriptor memory allocation failed\n");
 		return -ENOMEM;
@@ -643,7 +645,9 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 	/* Allocate one Command Descriptor
 	 * Should be aligned to 1k boundary.
 	 */
-	hba->ucdl = memalign(1024, sizeof(struct utp_transfer_cmd_desc));
+	hba->ucdl = memalign(1024,
+			     ALIGN(sizeof(struct utp_transfer_cmd_desc),
+				   ARCH_DMA_MINALIGN));
 	if (!hba->ucdl) {
 		dev_err(hba->dev, "Command descriptor memory allocation failed\n");
 		return -ENOMEM;

-- 
2.34.1

