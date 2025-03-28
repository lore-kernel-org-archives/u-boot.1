Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF03C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 08:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2744381F30;
	Fri, 28 Mar 2025 09:53:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Oq2BtW4L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53A8481E13; Fri, 28 Mar 2025 09:53:30 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43AD481A0C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso12916195e9.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 01:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743152008; x=1743756808; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PcNdDC5c3NpUW5A44JQ3gHNOzUIbT/swSz4ooWAxiDY=;
 b=Oq2BtW4L0gaZmROHVPGxyu5aC2mmOm/IzDG6u80w9zxLjQIa4qWMmbSzTi6fxN30gG
 SIzVrJ4tQsnqpTb/Qk7+nWdX6g09pnPlsUoAVxbs26h3dVaQWI6tfPJAqmSAAAMh+pZQ
 9v4d6TriZ2qqtlCp+dWgvHvNjMEIqu03VaPJZBGNeOOuc4no+5qDZ1CMJLzbdkEkHuh2
 cQem+SdsKnyuQ0JYk3DV5DE4j5aBl4neo8ewgwxiSWENf+LyM2U4iE4VP1XBGNjChIxu
 85f/kYfZUQJbZtOrBlX7vKCuaqOKNO8oynf/NxpK5zgcWhpYJFjxhuAGIyEMBMehh/zC
 CHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743152008; x=1743756808;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PcNdDC5c3NpUW5A44JQ3gHNOzUIbT/swSz4ooWAxiDY=;
 b=VuaxyGcrMfAM17mw6/U0ZN75Eo+vFKyF7GDV1NNp2wyfD1i10Az4O0+nDbUlv7RRM4
 3ukCgZHg1Ofbfd/4f8KMEalpqN/aNioHJS7Ja72EQSlpyHQrDPakt4pMDo5cPjL997MP
 PX7t4/9Dt9pKu9lmyVnmQajiucVfP5b82/OhaMKjzggc85qcyH11xYFT2w4AkX/f8Hih
 VagvxcekE4pZG78HpEL+TomjxP9GwQXm9zHFQTWk9lru5CHTOsMbAoCbX7p6q4VGQdTw
 e2M5hwj7JWTGKyt4eGdJvmqDh15nBajLadzISDVImWmigwAAkR6M5bNAE1FdpNL7GQRz
 z2sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqZtnsfNwbFE+c8fZ3X10eI48/6U9iLIVcWmUe+hi/D7/wax9n9fJcO+jfi08RUj4dk77Qjmg=@lists.denx.de
X-Gm-Message-State: AOJu0YwvzB/ZywaU5vIalyx69mAWNp4jB0Mgx41RiC6u8IeTsV2mkdkZ
 V9pGitPB8KlRdVtHYduFrkzUsqYKGHfSnQDSUlKK2kl8Q29Y/4LDUup27dwKHz0=
X-Gm-Gg: ASbGncttkGyF5qumInh+KLI2B9hGAEYyx6ebvo8ZKG7TbwnVAi2SdaSxCM7fW9Es/bR
 ztzcnYQi99o8VJ/3Xj6r9SKEqCSr3L6Bt7oW6+kf7Itdj3D+Re8csuj0qzip58Ca4K6y8XwWzO/
 amk+ZEcztU4VqELxkoBWVSPpc+IC3uruM3hHollrJZcYkZHTRj4Y59A0E3SrH90KwzK44fB45yw
 6mmFRBubbZV3/G5EfAUXrEC78U3ZNMxO1EVu0HtTAMe/Ik66m077+2Uh+qfP5Osbju6LsyVlOMV
 OJFR5NdvZ3jCP5ILGQQQoYaWRq4KLIqxFcgz5oktLJEQbYqS7p4+ADnEDwKiel58nA==
X-Google-Smtp-Source: AGHT+IHj1bnSrwuOcVQAP/b0BE4XZ8eUh1dHE0ryI9xChdV+vleBVBZ3yYucsUy+BO+th/RbrwvMAA==
X-Received: by 2002:a05:6000:40cd:b0:390:fe8b:f442 with SMTP id
 ffacd0b85a97d-39ad1783345mr6063379f8f.54.1743152007654; 
 Fri, 28 Mar 2025 01:53:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e0basm1969794f8f.63.2025.03.28.01.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 01:53:27 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 28 Mar 2025 09:53:24 +0100
Subject: [PATCH 4/4] spmi: msm: correctly handle multiple mapping entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250328-topic-sm8x50-spmi-fix-v1-4-a7548d3aef0d@linaro.org>
References: <20250328-topic-sm8x50-spmi-fix-v1-0-a7548d3aef0d@linaro.org>
In-Reply-To: <20250328-topic-sm8x50-spmi-fix-v1-0-a7548d3aef0d@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2260;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=y+9WZsaquJH+tlZ4eFkf2vRdKpR35s1NrW2mHCAui48=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn5mOEvdmj5mz3Eda2AC5pl2qgSpRsre8C61s+bmsr
 Ov4h9uuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ+ZjhAAKCRB33NvayMhJ0atVD/
 9yMoAHMXnKZnP98iN9okB0HTjUSZO6UsaGaGeUF5dBkaMyqlXNbDmMbQCn7yjCtbsrQ9bRbbwCCxJT
 mMJbgbZ/pNdNF2G6vvd0BY35uM3jgHITbfLo5Wr3G16prYbGv8cVQx+L3fVf7a+PTP+5/0qGtF7rBB
 or9TpB3On+ZLHsFWPJEmsPI5Ao/zEElfzX6XeDXdm/LCXTn4Ld2VpofPi5w8QMaMwU8w8K4KLXGyQb
 8hMbKfvs5aH510lmY91RY2D/eKCg7YMThICUt1jWkwTNJgSvdjZg30S2CjixIlG1eSqrbrthaU2/cE
 nxDySIZVAwYKbpYt90ASgXijAdqK6SXJLObVQ4XH90cDlADm1MdWLT5bRiNOHNehpUuPNZUOSStCRP
 qi7vJvjZeq13LV00IX3rbvewo3m2SKVVAHMd4FqA+LyOGd6SOVjqfBLD9Gv+YNF2ceH49PJMDHFwLH
 xGy+3QHTREnAE06e8E5x1WLn2qEt4HU61nA3z71lAw/sn9CNs+CAsmgRTii/ukGEhRgDvHRE2McRJ1
 6b+oQdIAnIWI41uSelstu6wwvXTX4iVXaFn0pVYeCRSAPFeWkKsFiCe/4jry6t4PF+9djX0R9K+UK3
 MsgETWvpqsnwpRfSRM+7jGpI8OmSS4POW/53CcU7VoxxWXNARPDpkDVhE0Fg==
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

On v5 & v7 controllers, multiple mapping for different
Execution Environment exists, if the mapping owner is for
a different Execution Environment we can only read and
not write any data.

To allow us to find a Write mapping for our Execution
Environment, we can overwritte a mapping if we encounter
a new one which we own.

Implement this logic, the result is the same mapping
table as in Linux.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/spmi/spmi-msm.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
index ee3feaf8b5049d51665330a63110ed4949e59bd6..faae54e9fef025466787541631ce5b5171444621 100644
--- a/drivers/spmi/spmi-msm.c
+++ b/drivers/spmi/spmi-msm.c
@@ -254,16 +254,30 @@ static struct dm_spmi_ops msm_spmi_ops = {
 	.write = msm_spmi_write,
 };
 
+/*
+ * In order to allow multiple EEs to write to a single PPID in arbiter
+ * version 5 and 7, there is more than one APID mapped to each PPID.
+ * The owner field for each of these mappings specifies the EE which is
+ * allowed to write to the APID.
+ */
 static void msm_spmi_channel_map_v5(struct msm_spmi_priv *priv, unsigned int i,
 				    uint8_t slave_id, uint8_t pid)
 {
 	/* Mark channels read-only when from different owner */
 	uint32_t cnfg = readl(priv->spmi_cnfg + ARB_CHANNEL_OFFSET(i));
 	uint8_t owner = SPMI_OWNERSHIP_PERIPH2OWNER(cnfg);
-
-	priv->channel_map[slave_id][pid] = i | SPMI_CHANNEL_VALID;
-	if (owner != priv->owner)
-		priv->channel_map[slave_id][pid] |= SPMI_CHANNEL_READ_ONLY;
+	bool prev_valid = priv->channel_map[slave_id][pid] & SPMI_CHANNEL_VALID;
+	uint32_t prev_read_only = priv->channel_map[slave_id][pid] & SPMI_CHANNEL_READ_ONLY;
+
+	if (!prev_valid) {
+		/* First PPID mapping */
+		priv->channel_map[slave_id][pid] = i | SPMI_CHANNEL_VALID;
+		if (owner != priv->owner)
+			priv->channel_map[slave_id][pid] |= SPMI_CHANNEL_READ_ONLY;
+	} else if ((owner == priv->owner) && prev_read_only) {
+		/* Read only and we found one we own, switch */
+		priv->channel_map[slave_id][pid] = i | SPMI_CHANNEL_VALID;
+	}
 }
 
 static int msm_spmi_probe(struct udevice *dev)

-- 
2.34.1

