Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B22CF6499
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 12:44:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 542A888E1A;
	Mon, 30 Sep 2024 14:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TJuazYdy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BF6D88E89; Mon, 30 Sep 2024 14:44:39 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3069D88E61
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 14:44:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cae4eb026so41806325e9.0
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 05:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727700275; x=1728305075; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YpZtPiiI1e1/Vf29ZneRtJ6KxyBl81TQ0/WopswlWtA=;
 b=TJuazYdybs7be93MKiALVgIvXe4nXrPjfCKGnl37e1w42VtXA+VKLMsO1SD/hrnVzi
 jkONDX6DlIb3PL8Trp80MYKVyw37emaHXgZ3caIMVTaw8yKfq7xvnCvmwi7aviFFxcWI
 mUoExhpCH+YgIjBLcPAeZTKrKohtf7fQ38h8hiKu9cv3YxH5ARky8hwuEzn44wDr2yGe
 4vN0pkHemlRx46QQ+KnbcF5VFrT4RCJfKxDcE0UZMD4bI40ryZZkMbIldJMdmCzr6bpc
 W56yN7vuPhYK7yoWA2Xu/VOVNU8oI49M2VF49+g/jS/Pul6p0h26ghX2+0CvHiuqnvrI
 8y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727700275; x=1728305075;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YpZtPiiI1e1/Vf29ZneRtJ6KxyBl81TQ0/WopswlWtA=;
 b=M4a0ke50llMJUiQr1X+gOML+RMRN9MqSE3a1KWncl0EM1l3r2vjRV58iKClO0ctZsW
 sMk/KuCjeowtzOBFecDyjUywlr2gQ/l1PliXG/OMNGoPXKf0PD5icCBpazz7geubTD0R
 U3ZuONO7gqMvbgQN6zrQf+2uOn5j8oOKD1gMAcw0pqh+HNPs/rqIj2cfyGka0PL4AK52
 ak0iC5j3mQL/VNVrFtfXvSfCkPiicZL6gwyk8zSwfFJszoM16QpfUF7R4VjTJ7bqyplH
 /S72H4Xtxv/7+WFUPGbDT3/sCbsxMjuyYaGRPqL+z3ZuilPPFmiLLwwaHcHwjv6GKC3z
 n1UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtNWy9Na05xvQ5583hiYUVNlsg/Bep9CU/3K8MOqaM/3jvABcJSmleqg7klfVOskTqlAwPpf0=@lists.denx.de
X-Gm-Message-State: AOJu0YxK9mqJsW34QrQs/SsFKb3TcuTemzbyVE9HFYlM2flBOagSUE/n
 HM9bIQMCRP3LX2q1JHKOiERFNjfh0ILBnX/gOq2TVXlZgnjGyV1hvQd4uL9F+uM=
X-Google-Smtp-Source: AGHT+IE4SxOg0bXOxHg+xIcBL9xbozClALsuhfs/2TkYrD0B2KkajVBxIPcERlLhcvTQwuh0f4RbEQ==
X-Received: by 2002:a05:600c:5125:b0:42c:cdcf:2fef with SMTP id
 5b1f17b1804b1-42f584481aamr94420605e9.15.1727700275624; 
 Mon, 30 Sep 2024 05:44:35 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a36597sm149362745e9.31.2024.09.30.05.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 05:44:35 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 30 Sep 2024 14:44:26 +0200
Subject: [PATCH v3 04/13] ufs: use dcache helpers for scsi_cmd data and
 only invalidate if necessary
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-topic-ufs-enhancements-v3-4-58234f84ab89@linaro.org>
References: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
In-Reply-To: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm+p0pffPJm0NKiYNwKcjVELx3FtQ2lZ7sIOZa1JZH
 i3NXndGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZvqdKQAKCRB33NvayMhJ0aeCD/
 0V81l2HMQBjK6Ley5nwH10tXbrLUQdilExEb/f0VQBPX7yMqC2yb1H+xKeWdU1+JgkgwfwslWxCiq0
 jQwcTKX8/LLMH0WizDEm4hXGsU/O6CfDhi0RsVYZFOaQERVs9wYEgA5Mv+vfVBNXyPKuNFAkVJYhtl
 N0l8q/0JJXJKXPJaHt2j9SOGpz4xBf8uxBhaRf/1COQ+cPmE3JV8tAj+b47gc4kqLgg+FSFxlU0ti8
 fo9Jv80cwSiMWWovViKm3CP9WT9GmtZAj7RBlemNndTyedgVj/Yr2ErSvR8zNSeCbC9eGH7W5ipBT3
 OZmZHHf4xP1nrCh8+d/zG3rNsAXuHAMBEBGDmlD94EtdFLomlN79+n56ZMcQ47f46T1YuHb3k+3O3v
 tRXzg/Sivly4TliVKo5HGtcArF/nSNRs3TBYZ02Psm2JL3ryb4VF4S8mv3Pu8Fj2bT2DbxAdC1M0T/
 XJJr/M94EzU5+6ndI50Aet/dD2+Ug/EG4c0TyaimtCDrTvHEsxqM4BZo+0ObDI3uK5c4J+z+/6N0vp
 cI35ycb6gdTHIq0CqHQ6pcu4jQu7jij4XhzP8qhPMwEnOSLrP9C5s7aPz+UdVBtf67RNMlkReVAdau
 XWFcfhVc1Q1xT9Ra0E681vkPNZ1du0aMqqMJ0mE1019vEVc8znmEMNG2C99A==
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

