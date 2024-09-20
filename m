Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3E0CF58E7
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:00:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D198B893FF;
	Fri, 20 Sep 2024 10:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sVflAtDU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C34E893E5; Fri, 20 Sep 2024 10:00:38 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94ACE893E5
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cbbb1727eso14480725e9.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726819236; x=1727424036; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YpZtPiiI1e1/Vf29ZneRtJ6KxyBl81TQ0/WopswlWtA=;
 b=sVflAtDUgk1F5rFkubM21Qs2Fwv/Wt0ifsxyoI2pqQXHfepcgWxifKpNVe6qWAv4OW
 TTeNVb73BPGBGmC3ngVVQNm8kO95cCydrcl1amf0oXcTa4DVg2r3ytNKuiki+hHrjWLo
 h84y+O9uaL3m/b4M56quWuh71auhkB8Py97TnsXA1o2suZcXnWS78h/Uq00eAGnv3oJD
 cVhV6sZQNDJccMcgajpkeWVe26tJkt00BAxn1zM2uGWRAi1jGStIdtFCYXACOB+NQoEF
 3rrCR43MmVoRaCWGmGj19tYKJseJtevRVj8j3ggsti8vZmamMSaFxNEUgY8ooixyQ0++
 yCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726819236; x=1727424036;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YpZtPiiI1e1/Vf29ZneRtJ6KxyBl81TQ0/WopswlWtA=;
 b=Th1DqFodpNVMUQrUas13Lq6oN6WRZVt84p9J63/MK9CafcQzreeuWlc1zbGUL8tMCn
 aFAhK/9K4k/j62GpJ9Py2PDt5HjW8zxnBf35JMkGnyidVEO0Ko7vgPczD2z4yqq3ykfh
 VlkYz+dX8LzKzb4V/V/GbtoDsXQCcCeqStupnfxu18IQ5+X7wJOBVC56+R2sRIob/4Uo
 0pbPipUt2Ny+1Bgx9drkqtyyfq1jMd+EYa3Mvu+XorZolsurpkwj/PkmkujlJM3Om7RR
 3+KwQFEcy37W6qweL7LNkBiO5A9UhxbGVe2Ce05Y9CijD2Oh8z6jANKieZzzBeR1cH3b
 sLhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBotkgVWc2oFC8vZiE6R21Eb11OJ4/8a/8otlVKOifLP8BjbK6LBZ+sakdPjRXAZuJ7noek5Y=@lists.denx.de
X-Gm-Message-State: AOJu0Ywaxvx5VjBfska5tyc7RPog8mOlW+YsdiTewNxKjNL7xE33d1Eq
 rkPieyOh9D3URPY6Y/kzZl4t+2Md9StZKInK24F8+k0kWQY0lOatO127uVt+mqQ=
X-Google-Smtp-Source: AGHT+IGQ6guk1bKSaqtpDfatZlUsw2LW5EnhnuuYsu93sZm2it2rrnMnA4Wy8c5qgS5KuSw6AgIqbw==
X-Received: by 2002:a05:6000:154d:b0:374:c481:3f7 with SMTP id
 ffacd0b85a97d-37a422521b5mr1301077f8f.6.1726819236009; 
 Fri, 20 Sep 2024 01:00:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e7800313sm17059497f8f.88.2024.09.20.01.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:00:35 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 20 Sep 2024 10:00:25 +0200
Subject: [PATCH v2 04/13] ufs: use dcache helpers for scsi_cmd data and
 only invalidate if necessary
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-topic-ufs-enhancements-v2-4-65ae61e73eaa@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2003;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=nXKi+mna7x+TCnF1EoWcP2ONpBRzk5a7DC+33DXHFa8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm7SuaqyP/6l4HWpzKDcS1g+bRhvbnzgNtC1VsNrX6
 Q6rnR0WJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZu0rmgAKCRB33NvayMhJ0eEuEA
 CQ16t5N/4dkudxHcfbaVKBxvyDV9T5tUJXk2bGjcK6omQl5/f9xYabwjsu1btykvcTAppGkewi/BWK
 Ydku+ALiYuVNIGLuSnMnmYIUd6E3QbtqIpsmIWQmktwTy1ZfqVbhsHtNmFiCCbv3UyPaOfrcZGg+b7
 Gf1ZITIUmePar0t+MoTAljfMke4j4jjPUikmw78la6Wijx8XN6LsnI9UsIRjAfBCsRFjGY/hG6qJU/
 Nrt9Ogd6/VAE2EiOcXKd9IoZG4pMMT6nERQmQ2/mVQdTnPD89V54OWkbrVjaumz7eViy8a6M8AquWO
 EtfWg6qH4wTfO4ttl/+pzhRdhC8FH47HjNtlyk+x2R4WYT8OQsirvy1/cy6RC77Nxub5txFhoMMHRV
 uoGgGcc5WHwJCdqMz2CPtHZ08HuO7//qMQI4ildpgfQjKZwzA/AJm8gYRGyNVREFKf4nnZ8+MX0bRc
 PBCdSl1Vn9CZEu9Qaf8ZIGvaFoVk4HcQR7nIw4f1FoGoGJwA3sqswlVQdPuBpc4YABXa7w92RhXyjZ
 /Hl8N6WiR8+O53aL61Po3BUvFfCBxNLeCFJz2RFsHxg/fj2+339oZlKgDi48mGR1xMsHb5/hLSXJKU
 JJpT/k3i8AkN73s2FrVOuuHjIRkrF9+aV9BBUFwUN7Uitx6PWkv7dn+ZUa2A==
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

Now we have proper flush and invalidate helpers, we can use them
directly to operate on the scsi_cmd data.

Likewise, we do not need to flush then invalidate, just flush _or_
invalidate depending on the data direction.

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Tested-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 5845fd694d3..d99dcdef7d0 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -1468,7 +1468,6 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
 {
 	struct utp_transfer_req_desc *req_desc = hba->utrdl;
 	struct ufshcd_sg_entry *prd_table = hba->ucd_prdt_ptr;
-	uintptr_t aaddr = (uintptr_t)(pccb->pdata) & ~(ARCH_DMA_MINALIGN - 1);
 	ulong datalen = pccb->datalen;
 	int table_length;
 	u8 *buf;
@@ -1480,15 +1479,6 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
 		return;
 	}
 
-	if (pccb->dma_dir == DMA_TO_DEVICE) {	/* Write to device */
-		flush_dcache_range(aaddr,
-				   ALIGN((uintptr_t)pccb->pdata + datalen, ARCH_DMA_MINALIGN));
-	}
-
-	/* In any case, invalidate cache to avoid stale data in it. */
-	invalidate_dcache_range(aaddr,
-				ALIGN((uintptr_t)pccb->pdata + datalen, ARCH_DMA_MINALIGN));
-
 	table_length = DIV_ROUND_UP(pccb->datalen, MAX_PRDT_ENTRY);
 	buf = pccb->pdata;
 	i = table_length;
@@ -1517,8 +1507,12 @@ static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
 	ufshcd_prepare_utp_scsi_cmd_upiu(hba, pccb, upiu_flags);
 	prepare_prdt_table(hba, pccb);
 
+	ufshcd_cache_flush(pccb->pdata, pccb->datalen);
+
 	ufshcd_send_command(hba, TASK_TAG);
 
+	ufshcd_cache_invalidate(pccb->pdata, pccb->datalen);
+
 	ocs = ufshcd_get_tr_ocs(hba);
 	switch (ocs) {
 	case OCS_SUCCESS:

-- 
2.34.1

