Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96154CF58E5
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E818893E6;
	Fri, 20 Sep 2024 10:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Za3MdIyn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0E82893D6; Fri, 20 Sep 2024 10:00:43 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A450893E8
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3770320574aso1077084f8f.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726819237; x=1727424037; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OD2sToIpO1cfLByUX2QOz6TvfjoafJN0nC5KVlPh1ro=;
 b=Za3MdIynccu6CO8Hj+IWs6AIz/mc5V9fK/WF3TTiTXUIlziSbwFalAfmo/vulls7YG
 T9AqcSjAEtla09XyejVJWvNwgOwpSnBm2cgm4gF8lVyGV+U6xX+Xg0lVkN2Dx3Ul/CAN
 pAMbUTnZTYkANp5Ux4WPVyScnCxc7FSa9D9Kn4HjHILPyKIdNiJaQoi58NlI1VLSCw4A
 tClN70wYnic8501Nrf55odM0ONxy3pI3Nqdjw88fhYVhURvPb0Iqt+jCHVwImD7rKAal
 CwaQKd9/cThG7DyipldtuGXSyilJrimDpy7fP2veUGuBmQ9sPnmYKVv9ETFJ7b9wwXUl
 RKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726819237; x=1727424037;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OD2sToIpO1cfLByUX2QOz6TvfjoafJN0nC5KVlPh1ro=;
 b=qbae3Ck3qa9xHPZrGfzOtM+t0AASFPDGLKKopumZzZnti22rFXxZpeXaPKAQlALuPs
 i4AbrXbVEBPUjfoLJgDZd7/eUYV8qrSnUhuRUXw72VsNhB6Q9nVQJYyxc5cDganhGDL7
 6LDe6n3KXRi02nbu1ywJfjd4hpagxnd8a6mZvrx5jG7+izpD2mhatyPujIuQrvP+YkVo
 fIxI3Vlm2YUT6yqmK/thzo83KAogF1AY6pdJAbMtP0DVpX0+JrOrsEtzsXGnEqYYQa8D
 BVnLschJENtz6rtMUCABrE32lHZ+jE45dsLTNay1c8ek1FMGfHBzqKHEIm8epws0R1HC
 xPwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+AYFeRGYa3pxTFN8/xjELzzBPzMwx9Ba7L+pVfo27vAdNgQ9RYeigZu8Wmiox+Xpodz7Ky7E=@lists.denx.de
X-Gm-Message-State: AOJu0Ywg3FnQZw0CzUFJtzrxJ6fJSkSeoaAef3ywRkx6Xj2W9c9mGX7P
 2jUUNaiLamnILBxtUvsOXrCH8/DCzjKM3ENxl2p9JzjFbnHQNLnhDis0Op1cr/g=
X-Google-Smtp-Source: AGHT+IEAP3mbl5U+hXVxK1fESXQFYbL/NziCibU//8ysKnKktdZRw400q5M2DfiUGj7eRuuKLL9zgg==
X-Received: by 2002:a05:6000:110a:b0:374:c1c5:859e with SMTP id
 ffacd0b85a97d-37a431ad406mr1022747f8f.42.1726819236939; 
 Fri, 20 Sep 2024 01:00:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e7800313sm17059497f8f.88.2024.09.20.01.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:00:36 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Fri, 20 Sep 2024 10:00:26 +0200
Subject: [PATCH v2 05/13] ufs: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-topic-ufs-enhancements-v2-5-65ae61e73eaa@linaro.org>
References: <20240920-topic-ufs-enhancements-v2-0-65ae61e73eaa@linaro.org>
In-Reply-To: <20240920-topic-ufs-enhancements-v2-0-65ae61e73eaa@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, bmeng.cn@gmail.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1038;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ppGnCnIvQ24RO+CksMocxHg+RzOv3UzcGUUNAD0tfrk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm7SubXZ9XOG23Xgb3DGSVGPgD0pWc1CyVJQVwG5Yo
 rZnhgk6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZu0rmwAKCRB33NvayMhJ0U3TEA
 Cf92rF4SdWN6lG+l8kR5Ovac2sVgLu4+MYI8vhi5IiVucrNkzFrBkNx11yja+O52DtSpJWYzGFUh6O
 Fh1p55AlY4B3tdUpeMCmEz0Dd7eNGJkiWdfJ8IrydUyo/0yj8JHaFJunDrh/duho4PkGm9/NvThE7+
 5y9dHgo0trlKqCrUSqlRTMtuGVG/A/RaD9brKQF6zNRr+FpPRwRIWPLIuRGV1AWGn4Ol0DB+PrX0wd
 2ggn1fsK1Ulstk1Jhmy2geMUML/USUyQoftV0iV2QPWV3RAJGD4SrQA41yosJcFNWOiUMq5OSRugrA
 JHHRDNmdt63LyDNYGx554QZbeYqmp61RBJbpF506uSS4UvSkLpcv0CRMFil/ZnRVDqYEekVZ/LI99A
 SXgCvSbEE6dKAvmlNaYfSI80SepMwP/UjnM5C5d8Tuca0ffBN1Ao9LvJ2kNPMLq1Lpljhahl+rDMhl
 7+o8wJUGvaVEtkI0Y25XYKWaFjzs2Qvxl0kWUyzwbC8tfnacbPuX+f+OD2rgblDxtndE72d1cVaRZ3
 0bLA5I54zBOjziBP3UL2p5Ti0Z8G3ZHGEK68tGXQowcp36S50YWAnZ4QaDc5ayOmBUbuxEVUIEhDVy
 lU5S1fpfYaGf0i/55/1bHsDZqCIReVTYtB2wQ/W67AAGHrtfbFS0ojjV3noQ==
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

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS for host controllers which do not
support 64-bit addressing.

Ported from Linux kernel commit
6554400d6f66 ("scsi: ufs: core: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS")
with ufs_scsi_buffer_aligned() based on U-Boot generic bounce buffer.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Tested-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/ufs/ufs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 43042c294bb..c92f47d82b5 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -732,6 +732,12 @@ struct ufs_hba {
  */
 #define UFSHCD_QUIRK_HIBERN_FASTAUTO			BIT(2)
 
+/*
+ * This quirk needs to be enabled if the host controller has
+ * 64-bit addressing supported capability but it doesn't work.
+ */
+#define UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS		0x2
+
 	/* Virtual memory reference */
 	struct utp_transfer_cmd_desc *ucdl;
 	struct utp_transfer_req_desc *utrdl;

-- 
2.34.1

