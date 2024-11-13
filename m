Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6FFD41C02
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 05:02:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51EB68952B;
	Wed, 13 Nov 2024 06:02:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mK/fCPqa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A87D89534; Wed, 13 Nov 2024 06:02:28 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 061C8894FE
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 06:02:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9acafdb745so73465466b.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 21:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731474145; x=1732078945; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PTrLx9rGOU4GevWWvms6euuZqxw8xH5TTZS1820SDPQ=;
 b=mK/fCPqabKfkeRMCNA/XcgWxW99goC97nB0gjLVsovMGpZRPttDzm6P+m4ncskjSkv
 VR3aMzx02orpW13aimPiXw2s6hb4ho+hbs+mFzhnHQDvv4YQ59yg83p3HhyfvSOsjHyx
 oL/3ih/PGQolUzwWHVq8RzIkyWIfIa0OXOU1ow3TV+iqMC3Ouja+F2UXZHZc0dXc1l4H
 i1HtD7hreTu0flLiJcYDLzHMUxzG0CCyyDjLi9JELdnrzUPkHPsopCQk11qmu1MNj3r3
 wWA6LsRPDxI662MEvqpjA8lnhzt3xm+H8G/yj32t9ez+u3abjFiChoBWlJevFbAzK3Ef
 bxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731474145; x=1732078945;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PTrLx9rGOU4GevWWvms6euuZqxw8xH5TTZS1820SDPQ=;
 b=Heaot26VNmwKqYstgO7yLKIKMe7q6tLL7gFJNwJdWdyU85OHG/YG1Vq/DuLRMV+As9
 oyWyGZDZnGAKf5bw8wVWRKqqObyFXSYjYpNP6vebElD5APNOt2hZVcyqzrkC05sOLA7O
 IryE10LCny8rANcL6QEs7cM27jOoyYYTnugfYwSFSlE+F7AXe8M9rk6WhQxJksWWh3f7
 imcfGYfdQNjCHc0+Bd20Q2IqJ/atDy0Y2jrW7GeGV3sdkmO9IGJS5/pQjOh5Wq0/hv7C
 rT+mvaEBWh+KrjI2M3cwqmCi1bnHw78j+l+KnCxdCMv6aES8BMJz1dtpHMwax/3Ul9jo
 45lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZDN1TSrg0/yW/tlvMFudyu2Zn5F6lPZi7wOW7MYmxqDWiacztwQFyca/1bw43wBry8AJU25w=@lists.denx.de
X-Gm-Message-State: AOJu0YzuLKByVRn1E0UwyVRMqGDbzUNshWANthiukf3vCZo7GdSfuM18
 2UMlgz9cUifNkxDzw7H8+9/Bbjo6wF1edjw5QleSeRcp2/J7cJ1fa7lkflH8O4w=
X-Google-Smtp-Source: AGHT+IGeR3fwGyyrodveEArw4f/HGwjSDlLGDougUEd8Xjp4FUqI3KISVwznNenlsaK194kSegyhQQ==
X-Received: by 2002:a17:906:ee8c:b0:a93:a664:a23f with SMTP id
 a640c23a62f3a-a9eefe3f3famr1852503866b.5.1731474145348; 
 Tue, 12 Nov 2024 21:02:25 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0def87bsm820905566b.143.2024.11.12.21.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 21:02:24 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH] iommu: qcom-smmu: allow SID 0
Date: Wed, 13 Nov 2024 06:00:56 +0100
Message-ID: <20241113050214.1845595-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.47.0
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

It turns out this is a very real stream ID. Who woulda thought?

Drop the 0 check on the SID, there's no reason for it to be there in the first
place.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/iommu/qcom-hyp-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/qcom-hyp-smmu.c b/drivers/iommu/qcom-hyp-smmu.c
index 1b5a09bb7b39..7e07487ad384 100644
--- a/drivers/iommu/qcom-hyp-smmu.c
+++ b/drivers/iommu/qcom-hyp-smmu.c
@@ -133,9 +133,9 @@ static int get_stream_id(struct udevice *dev)
 	struct ofnode_phandle_args args;
 	int count = ofnode_parse_phandle_with_args(node, "iommus",
 						   "#iommu-cells", 0, 0, &args);
 
-	if (count < 0 || args.args[0] == 0) {
+	if (count < 0) {
 		printf("Error: %s: iommus property not found or wrong number of cells\n",
 		       __func__);
 		return -EINVAL;
 	}
-- 
2.47.0

