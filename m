Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFCAC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E6C8887FD;
	Mon, 15 Jul 2024 12:08:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nyQKkXdu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 123BE886A7; Mon, 15 Jul 2024 12:08:13 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7F81886A7
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:08:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-58ba3e38027so4283907a12.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038090; x=1721642890; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TmBsez8SJ4gp3OXyLBaZGeolHr60Zn+8FMmZ9V7Bb4k=;
 b=nyQKkXduGvSmTC4Zo5DG4Xeif8QVO5jbP6uAHb40piBaWcWPAjbe30cA6UrjWf00H0
 ojJDhiQ1ogzg0tzgnOPG/BtPToYR69vTltbACdSzzg2K1X3H1cUiVLt8VMiCvROmQJRL
 uW9Wy9jaFSI3wo7TuwiREh9cB3QhnxdRcpauwOkoWECyl7Yr13XyKhxQymV8iqyeA273
 +rQBaHvg67g5O5/GkZpsqy+TR5dplFd0vMoQvqnSU87mvoo7gR0FtuZX3g9R5VcixUTr
 qRP3SpG3htsk1/Nd4iNZvQLHyeE7gpS1HKb5APeNl7svw7NJYeHtOC7SpKZw9swwhrUJ
 QFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038090; x=1721642890;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TmBsez8SJ4gp3OXyLBaZGeolHr60Zn+8FMmZ9V7Bb4k=;
 b=NiOGtUuXAcORXjmYS31RvKlNQ5gismOt6bdOMkHRy3Vd5mu0lK+coex5tlSwF/rH7H
 pMUduoRmev+TcOO92+GgwezuLe7biYPDnzcSIVR5bwgDuDbrQcvKqbxaJJGgB1o7enCN
 e08oan+5gNRKMRu+0CTNJbLBEOTERtqCf2yoXTHdryD6iwdMu0ZOTMZ1WG5wQIpP0vgb
 9JrgpLK/3eeRkkK3Om6vB3CzpinEmgZxfpb58iMIiva553DXV6RiSY3r8zMUsTVRbW6U
 Cnkp2cMW1yXfo14Fi22NpZuAlARGvKJ8TC6yR7fbCWTHYaqdUh1d9EH4mNvyMJGPK9aR
 lajw==
X-Gm-Message-State: AOJu0YyPI1RzmnrX6rZBfurdpiYbQ3Iqqk/UAv8PNkMEWwl4O0nSaCWb
 TDRHwqk2lbo2yF2K8O1mJr/O+XBhwnSSszcSqgNov95gyS6iMAd6GAF3QQkhm41RJyA4EJDlvRj
 ABpE=
X-Google-Smtp-Source: AGHT+IGq4lgrB1bUF4Oi1yu6G3N5hWKTcMwBttResmhHGoufyhJnGgV/IlcBDaIcl0T6qiV4moj46w==
X-Received: by 2002:a17:906:6c93:b0:a72:6e13:a4b6 with SMTP id
 a640c23a62f3a-a780b88276bmr1238512766b.58.1721038090261; 
 Mon, 15 Jul 2024 03:08:10 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7eb4sm198102266b.60.2024.07.15.03.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:08:09 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Jul 2024 12:08:00 +0200
Subject: [PATCH v6 01/24] dm: core: scan reserved-memory nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-qcom-rpmh-v6-1-0c948a25d018@linaro.org>
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
In-Reply-To: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1031;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=PKEZ2Kyos2XwfSr6YrxzmuKdb9zzBCK2fAEKAd2yAJ8=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmlPUFlJ1jrr59HMtxhLRDzKa1jmQVb6a5QLuEW
 rYBpuWfFjGJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpT1BQAKCRAFgzErGV9k
 tihdEACVwuCnh20wgkVW/XP5whnjW0te7bNghtDZuPuntfVMc53e0MjZuD2BACxJdC9kn2UePde
 u4fhSOfQFflp2uhqVA8syDjmHlBN6Y8cvkS6lzfzS1nScbZXLbTeYYMGz+jwwTaAtp8SVfjTvQv
 aYDcBxhnUbMsdIIL/KTsBlbxrGsLp9YiqTM/L3r+d75GLYdCWPndPJoli/KmEv9MW1/SukgVJ0l
 Y+iivJ6AMYuHAEBuH+RWLs9o522Na0FpUTxLMjndkKWai89WktmVeVoY53aV7aE1xjuCSIfPFGe
 +6wX6qWETZhx3yu6p2XXfoLIhGUenC6pGnl25LJfZbLCkpZtI2lnV+M5gH/ItN1p4miV8Xh9NV1
 rT+zunN8aMRt30fnWrCtKSGiJdiTat+KDQS3V65iYuK0vP1WJJnD3Babb8K1rGMMiZ6OPBJwNMD
 /HvvL3QzubLdOYlGhMUQUkuWxwuTRoLRmoc8d+LPI89wVxBMgWrmNY+K0n/KtkL6YA2dYVB3Xnl
 8ewdEKongysJy4uWHCr+oCrTiQkckpKBPH8mI6u0iZ/KtD6YnogPKi9dJuuDBr6Kby7ZP48sOf3
 eAWN8v3YeyV8IAYfDLMTW7KX9xn/neFlGNPMG15aEg5Px42QYamRbWkA1XotnAqeZLRoHrKMdjL
 wkSkp8Qe0zHz3lA==
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

Qualcomm platforms may have drivers that bind to reserved memory nodes
(cmd-db [1] and smem [2]) which are relevant to U-Boot. Include
/reserved-memory in dm_extended_scan() so that these will be handled
correctly.

[1]: https://www.kernel.org/doc/Documentation/devicetree/bindings/reserved-memory/qcom%2Ccmd-db.yaml
[2]: https://www.kernel.org/doc/Documentation/devicetree/bindings/soc/qcom/qcom%2Csmem.yaml

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
To: Simon Glass <sjg@chromium.org>
---
 drivers/core/root.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/core/root.c b/drivers/core/root.c
index 7cf6607a9b7b..7a714f5478a9 100644
--- a/drivers/core/root.c
+++ b/drivers/core/root.c
@@ -242,9 +242,10 @@ int dm_extended_scan(bool pre_reloc_only)
 	int ret, i;
 	const char * const nodes[] = {
 		"/chosen",
 		"/clocks",
-		"/firmware"
+		"/firmware",
+		"/reserved-memory",
 	};
 
 	ret = dm_scan_fdt(pre_reloc_only);
 	if (ret) {

-- 
2.45.2

