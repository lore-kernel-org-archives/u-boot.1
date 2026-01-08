Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C71CF6C15
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 10:17:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 398D884109;
	Thu,  8 Jan 2026 11:17:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BJpIcZDX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="awDPfhoN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D685F839D7; Thu,  8 Jan 2026 11:17:41 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7685884109
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 11:17:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60846Amk2779181
 for <u-boot@lists.denx.de>; Thu, 8 Jan 2026 10:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=X9hR6vHwTTu
 /NL0RsoHunigBTdEz0U0FmhkETgHsdl4=; b=BJpIcZDXzBaZuGaZ/1u/xpw3FSr
 fIVZtWI1WDlqyQx/naj7PyE8IggHwEEsyfQTjisU9w9W3yOiQ9dCL8le+Di5swQe
 5GOP717ofYcyQmVCKUmKbHyKMLA8C+ljTI/HuFoo/0GB8SZWQE0lLpDTGy7crlKx
 inKQOIGFgPrp3i1MuTpHXTbWkllY7n2zPmRVOTazHyymQWpueXblLSicIrGvjAli
 VKNkvAFuT/UjaRrTc7lH2QH1hykNV+NCUQfddQK1xBUywW7U6GkmCio9UweEebPV
 aK9Y4gmysFuqKaee9sVPkBLwNtXaljTPOEkEXVYEQ+z6EpfoIPVDPUCjBAQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj58uh3dq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 10:17:32 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b9ceccbd7e8so3458644a12.0
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 02:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767867452; x=1768472252; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X9hR6vHwTTu/NL0RsoHunigBTdEz0U0FmhkETgHsdl4=;
 b=awDPfhoNubjUClMJSw9JVejvA1BVAEnJ+mIV82dZYdn7udcetjP2y7kx8V57gj6ohN
 MYN30U2MQoFmNt+xD6y6ueyNc5fiZc73B1z9ScdYK9JYfvT6ym4XSonfKF/8cV8xD7oQ
 oNDWCAS8KjBTkB/Qy8wgPoG7nie15qxdZqcJbiVRxipdhLID7U+BSNMACv0L+DYL4w9h
 m/bixRMSeObDZJhy2Hs0fmVkm65ajYqbrUeShvdxW3t1o9pmXnDlnCOcJu9udeT0IlY7
 nVXnCyYED3XC1kMhWUaV+Ji70hg2MaDdu5nTK4GwE24Ave/lbHqwpBDHzshRvqCMnwab
 wiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767867452; x=1768472252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X9hR6vHwTTu/NL0RsoHunigBTdEz0U0FmhkETgHsdl4=;
 b=MAMT94Yk8XChiIET64DlfIN6VVaa7M1dwNcElL5olUfj82hBOvfaaKqDpyb97y0+2K
 SsvodjC7TN7+ZiI2Ww037Ewo0VVSe8C0PBEQQh+JYwbp6VDKeowa13amHCoxI7pB1lcz
 V3UgqtZz+7akoEnDZxvgFgbwZcjK8IlWKLq9qSNhpRl7ptmuxe4i/XaUnzG1fTYm/gTB
 W5VBigb+5Sac79xsMcpBIzKR60WJfiZaJmbKNd5Nm44DuaUVsf2RKKUujtPAHBzhCYT9
 3F8RNbscY81bX9sKMsG80HH31c7NQA+7wzb9JZ+47BfT6n9oFkpW9j9dkiGb3BYQDJat
 d4GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV29NFzi4yUe/rI7CHJft62p+qctEDxfkq30L+/pWMn0RFksSkvnCBHrE3FrBwryibaW4Btwc=@lists.denx.de
X-Gm-Message-State: AOJu0YwBy/p7xQzoOZ7/CmML211UkWi0IGa9WQuuyMm4eL6xHFsVQTJE
 ztDoc5/QB6t7k0X6pm2MPPooiYHIiyxJQpAsU7bfSFS/kBOxLYSZD20EvfAf1kC+SgibOpO4Wlj
 gMDCejy0Uh3DwjfOEMnxYHTaaqiemlPPYjR35x9dt4rTPikuYMu1lGgfM
X-Gm-Gg: AY/fxX7ZczdRgPJlVYVw1zrtjYGfwjeifIGT0VHaDD00FIUsavyc/84rQ6OSq5J2vM/
 ECGuMgeoqJXzRTqNseCySp85Nku9h08sr7iT5OLzpTdH0HcjXr10VgCNU6XV6ZFOXz2Aa1DtDwR
 XNKR68cpYec5FlR21Vbr8XyDw6y5CXFv+R6i+SxI6q2NaVIRKftnXLBoID83VWU/v5MxiAMm6GS
 gzW+xeJbxlKMxAYkD88qe+5tJPGHjIe2lrvu8i602ApD72T9USd3EhiZFGDWXHBQi8L3vqWxm7J
 Hwh+qe19pHxHsnKrPB1HKiQP3a6MCzwbSIFL+OGtPoi8UkVcaYJ1btgcNi/PGwHCHKklrNJZqKe
 XOQniOTSobOMZP4jMsaxEPn8lF+TiMqRQOtLVrk/Oh8AyXMsCCXagm2yEJesxBTZ0W6lzu1os6D
 5BG+g879gVVrPuQYbhun+CQNdjyB0aJs0quXCX9g==
X-Received: by 2002:a05:6300:210b:b0:366:14ac:e208 with SMTP id
 adf61e73a8af0-3898fa5f429mr5382057637.70.1767867451655; 
 Thu, 08 Jan 2026 02:17:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4YBgXoyXdyQn1c6cVgy/9N2EikhAqFzxL/IwqUfT4wunAazG48AI3rwo5AyDbyLlW563/GA==
X-Received: by 2002:a05:6300:210b:b0:366:14ac:e208 with SMTP id
 adf61e73a8af0-3898fa5f429mr5382028637.70.1767867451155; 
 Thu, 08 Jan 2026 02:17:31 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbf29086esm7730007a12.1.2026.01.08.02.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 02:17:30 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, me@samcday.com, sughosh.ganu@linaro.org,
 gchan9527@gmail.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 1/2] soc: qcom: rpmh-rsc: Clear TCS state before kernel boot
Date: Thu,  8 Jan 2026 15:47:20 +0530
Message-Id: <20260108101721.3411854-2-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108101721.3411854-1-balaji.selvanathan@oss.qualcomm.com>
References: <20260108101721.3411854-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA2OSBTYWx0ZWRfXzRlTSft3Urer
 ULmwdhveoIAFA3uNEVQivWT2mXO04gmQz/wq7+LXx9eYfZC9ofAHfYrqCGyOpLjSkK7Dy3sWAN5
 dqLb+ULhIfYYLkTAGnzpIqjceRnURoyF+/8IHAyxac3Xs6I1xKskYyK9bsfFf9eLbJHKDsqhZyj
 sM/c9yVPb0/7eqHi0DN9DNvAxy2ZyaOGF8l4Hsc0MUlchLQoZIxQT0KU/7JDQJR/GhDtiW83nIa
 fVwgsK77wdwarBrozsn7a39ZD/GEbXJw75+nxTONDzCpX2Ut42ayU6wCHSfdA1ob/W0MCTRO3Oz
 zH9WUNEyCKwYzXNfcO4kEsAz0hIGUgTnv2gdxjeP0owQZt27xgyqL4JnYJth1xggqBlaQNX6dku
 ju3t63arKlskfXR/QihS5P0TAmUcyBhp0d1QxIHn40Gmaroq/2zlQnwCVW5nf9m1/fyLNjM6jIR
 eTAtYNduPmPcuwtrVMg==
X-Proofpoint-GUID: PlbDwV9fPxDYxPS_s-2hgl_i7rWpt6Oc
X-Proofpoint-ORIG-GUID: PlbDwV9fPxDYxPS_s-2hgl_i7rWpt6Oc
X-Authority-Analysis: v=2.4 cv=CMgnnBrD c=1 sm=1 tr=0 ts=695f843c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=unN1PjCG58x0RbNQqm0A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080069
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

Add cleanup mechanism to clear RPMH TCS hardware state before
booting the kernel. Without this cleanup, leftover U-Boot TCS
configurations cause timeout errors during kernel RPMH driver
initialization.

The cleanup clears CMD_STATUS, CMD_WAIT_FOR_CMPL, CMD_ENABLE,
CONTROL, and IRQ_STATUS registers for all TCS.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/soc/qcom/rpmh-rsc.c | 101 ++++++++++++++++++++++++++++++++++++
 include/soc/qcom/rpmh.h     |   9 ++++
 2 files changed, 110 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index aee9e55194e..772be401f0d 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -471,6 +471,106 @@ static int rpmh_probe_tcs_config(struct udevice *dev, struct rsc_drv *drv)
 	return 0;
 }
 
+/**
+ * rpmh_rsc_clear_tcs() - Clear TCS state before kernel handoff
+ * @drv: The RSC controller
+ *
+ * Clears all TCS hardware state to ensure kernel starts with clean state.
+ * This prevents timeout errors during kernel RPMH initialization by clearing:
+ * - CMD_STATUS: Leftover ISSUED/COMPLETED flags
+ * - CMD_WAIT_FOR_CMPL: Completion wait configuration
+ * - CMD_ENABLE: Command slot enables
+ * - CONTROL: AMC mode bits
+ * - IRQ_STATUS: Pending interrupts
+ */
+static void rpmh_rsc_clear_tcs(struct rsc_drv *drv)
+{
+	int i, j, ncpt, pending_cmds = 0;
+	u32 status, irq_status;
+
+	ncpt = drv->tcs[ACTIVE_TCS].ncpt;
+
+	for (i = 0; i < drv->num_tcs; i++) {
+		for (j = 0; j < ncpt; j++) {
+			status = read_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_STATUS], i, j);
+			if (status)
+				pending_cmds++;
+		}
+
+		/* Clear completion wait, command enable, and control registers */
+		write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_WAIT_FOR_CMPL], i, 0);
+		write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], i, 0);
+		write_tcs_reg(drv, drv->regs[RSC_DRV_CONTROL], i, 0);
+	}
+
+	/* Clear any pending IRQ status */
+	irq_status = readl(drv->tcs_base + drv->regs[RSC_DRV_IRQ_STATUS]);
+	if (irq_status)
+		writel(irq_status, drv->tcs_base + drv->regs[RSC_DRV_IRQ_CLEAR]);
+
+	log_debug("RPMH: Cleared %d TCS for %s (pending: %d cmds, IRQ: 0x%x)\n",
+		  drv->num_tcs, drv->name, pending_cmds, irq_status);
+}
+
+/**
+ * rpmh_rsc_cleanup_all() - Public function to cleanup all RPMH controllers
+ *
+ * This function should be called before booting the kernel to ensure all
+ * RPMH controllers have clean TCS state. Can be called from board_quiesce_devices()
+ * or directly before kernel boot.
+ */
+void rpmh_rsc_cleanup_all(void)
+{
+	struct udevice *dev;
+	struct uclass *uc;
+	int ret, count = 0;
+
+	ret = uclass_get(UCLASS_MISC, &uc);
+	if (ret) {
+		log_err("RPMH: Failed to get MISC uclass: %d\n", ret);
+		return;
+	}
+
+	uclass_foreach_dev(dev, uc) {
+		if (device_is_compatible(dev, "qcom,rpmh-rsc")) {
+			struct rsc_drv *drv = dev_get_priv(dev);
+
+			if (drv && drv->num_tcs > 0) {
+				rpmh_rsc_clear_tcs(drv);
+				count++;
+			}
+		}
+	}
+
+	if (count > 0)
+		log_debug("RPMH: Cleaned up %d controller(s)\n", count);
+	else
+		log_warning("RPMH: No controllers found to clean up\n");
+}
+
+/**
+ * rpmh_rsc_remove() - Cleanup before handing off to kernel
+ * @dev: The device
+ *
+ * Called before booting kernel to ensure clean TCS state. This prevents
+ * kernel RPMH driver from encountering busy/configured TCS that could
+ * cause timeout errors during initialization.
+ *
+ * Return: 0 on success
+ */
+static int rpmh_rsc_remove(struct udevice *dev)
+{
+	struct rsc_drv *drv = dev_get_priv(dev);
+
+	if (!drv)
+		return 0;
+
+	/* Clear all TCS configurations to provide clean state for kernel */
+	rpmh_rsc_clear_tcs(drv);
+
+	return 0;
+}
+
 static int rpmh_rsc_probe(struct udevice *dev)
 {
 	ofnode dn = dev_ofnode(dev);
@@ -539,6 +639,7 @@ U_BOOT_DRIVER(qcom_rpmh_rsc) = {
 	.id		= UCLASS_MISC,
 	.priv_auto	= sizeof(struct rsc_drv),
 	.probe		= rpmh_rsc_probe,
+	.remove		= rpmh_rsc_remove,
 	.of_match	= qcom_rpmh_ids,
 	/* rpmh is under CLUSTER_PD which we don't support, so skip trying to enable PDs */
 	.flags		= DM_FLAG_DEFAULT_PD_CTRL_OFF,
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index 3421fbf1ee3..da3b1517392 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -25,4 +25,13 @@ static inline int rpmh_write(const struct device *dev, enum rpmh_state state,
 /* u-boot: no multithreading */
 #define rpmh_write_async(dev, state, cmd, n) rpmh_write(dev, state, cmd, n)
 
+/**
+ * rpmh_rsc_cleanup_all() - Cleanup all RPMH controllers before kernel boot
+ *
+ * This function clears TCS (Trigger Command Set) hardware state for all
+ * RPMH controllers to ensure the kernel starts with clean state. Should
+ * be called from board_quiesce_devices() before booting the kernel.
+ */
+void rpmh_rsc_cleanup_all(void);
+
 #endif /* __SOC_QCOM_RPMH_H__ */
-- 
2.34.1

