Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DC91075286
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 09:38:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEE4E83FF9;
	Thu, 19 Mar 2026 10:38:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oGbIi/y3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eOY4kfBn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6712983FF9; Thu, 19 Mar 2026 10:38:18 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 417F683FFF
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 10:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J73xIg3771136
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oIsBW2uIK934HPdwY3FYvAwKoqOkWjg/0ksVmr06dM4=; b=oGbIi/y3cz3RzWNQ
 B0822BX6SCftDmIdSHSeqYELbvAF4/CvKlvA45OB8jkGocXoyvLl+Oca4FTtFvHO
 NhJJRRmKGxM8eR2RuvE7yUYvtVU394xNRzoX1JTfh48I/AElyEUll1KorrUFA1Lr
 uugXJSahe4ohGshRbHW0b6YZdLhT+DZPAOnSZC/VtmLDBZv2jKOHEYo1nC/i3keO
 F9PhTwNmD6F6bUUiVbZjl2wbPn0GZpOSCU3QZUvITV/demiVNj/Co1XFl0k0u0FY
 //vBoCLhqf7XcbKpLVPMAflkErgNgHlA096YfssqEu6n0uUZUf8xwSfN3HJ/2G9m
 SOuPag==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d083r980h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:38:14 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3594620fe97so4309121a91.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 02:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773913094; x=1774517894; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oIsBW2uIK934HPdwY3FYvAwKoqOkWjg/0ksVmr06dM4=;
 b=eOY4kfBnh1Xf1qmZVhyOmn8ugfGN/1UJ6SxGh/e136jndQ5xyH1hQtBd5yHM7tWOk4
 nwOK34VE1zGMndy9yTGnVOMQcALxmK2O3OIIkCGlnSPvvRkns4nNMYVBd51zlhO4pzZ8
 Z7ZMEGVK9Scb6IO9N8RJOIVLqU1uX9OKPuqyoRVyI+9eBXyb4+Ew4z6LRuiScE3jfXOV
 d6KHOh1Hza4/epYW1j7viBUiUfIT0IiGIK7bsFRztbtKaM1Ej23VmogK1i7qmQK4oBx0
 +Cv0jtcIZnxU1e8hVUviWFamVviHM46OCtXRtRFlFITt7loDSoEO2NxmOV66SayxzE4t
 UePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773913094; x=1774517894;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oIsBW2uIK934HPdwY3FYvAwKoqOkWjg/0ksVmr06dM4=;
 b=TXp6aGg+i69oyRD2BDBMY1oPeAwI8GYK/Ij6Di3lhcuDsFus+9BBl9B7YEVxdB5sMY
 +VTd9ee/+fDUbV7l68D7u31rmZc/XwdezAefdpHNX/V9cksIwQh6Hk0SUrz5Fw+CqNdJ
 TrzLdR7w2WusZkyBSgGvUO5sIG0U+5M1DrA5+YMIba7yLEl3dGhci7yH09dTg+eGV3Xj
 E0txh2zN+0uIaLNmQsirB0owAp+NKH+J8P6lSelrIo2QKXIpkjRM/AOjLhuotWMiOkc3
 O3kNE0ILqfV5uSHxwTl7Axluwad9Gm/ZjKZ01MGnEDxnHKhW1/GuM+PEXLqeoXBeAb3m
 OaGg==
X-Gm-Message-State: AOJu0YzSbrDl1/THM5vL30nRTUDTPzhWhHP8rfOm4lMwNLcXn5TOBMln
 Mc/U6s6ebo0yF+3XP57QWiTib6MtWHRFEMUfM+oAqcRz2//5VYaxWM4S56e8cdh39LuiRgxtuh1
 iUXEQ+ExHG56dF98CSLAvDh3Ai9jmwojnn7LU0lsHpX9yDNlWa+tkgEA5
X-Gm-Gg: ATEYQzz0KN7rxuceFOF+tV+3zT+Gx5HCeXoY2hL1CWR7m0ceexUSWQrg3i3tyU7oBqC
 TuY9EuIIFK3LwDhSfh64LjzYtwl5K92s/EaJVro9aW99JarUOhNNPAzVj6OxS66USV786MKdNk/
 8pbRIyRjVNOsfjGxi/1TRR3UrwbdvAeJDuk1Acg6l6YNKZE14unRMgMu373NeUVr62Bb36zX2WU
 6vwgJhtZS8j/kYAr5q8RJ5WLrRRlPNmpXFOZnAmdfzcDEaQzL0gnmXi/NbY6y7NE119sh7T4nRM
 nGmlD7QYfypa7hA9SEGGz/KcjL7arCxbwBfJ6khSiNr5hvVojhGza0HaE5YPL+be9qWTaL21b9b
 QARWv5P5b0VX5Rtfh8Cwdbs7QhAOktRwqx3mQD/pLidPVU+4uVd9aW0HWpUQEevVa2QWSd8oUZL
 mMZIrDuT1MtCt0eL09/17z9OGovtqxB4EVDO9ix//RmdPy1NJoQg==
X-Received: by 2002:a17:902:f64f:b0:2ae:5104:571e with SMTP id
 d9443c01a7336-2b06e323a6fmr62786925ad.9.1773913093672; 
 Thu, 19 Mar 2026 02:38:13 -0700 (PDT)
X-Received: by 2002:a17:902:f64f:b0:2ae:5104:571e with SMTP id
 d9443c01a7336-2b06e323a6fmr62786635ad.9.1773913093217; 
 Thu, 19 Mar 2026 02:38:13 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e441374sm52098825ad.29.2026.03.19.02.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 02:38:12 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 15:07:42 +0530
Subject: [PATCH 5/5] drivers: ufs: qcom: Initialize and enable clocks
 before hardware access
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-ufs_probe_clk-v1-5-08c085d6b15d@oss.qualcomm.com>
References: <20260319-ufs_probe_clk-v1-0-08c085d6b15d@oss.qualcomm.com>
In-Reply-To: <20260319-ufs_probe_clk-v1-0-08c085d6b15d@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Wronek <david.wronek@mainlining.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773913061; l=2846;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=bNIRyjqnztUOtSHvAm6syshHIdbouPiqlCxq8QyU5kk=;
 b=Bd/UCq3BIvNVSDwdT1m9XjMlNFz8spTkv/roeue8o57eB3+VeQpj5Ka2sqLQbv1Z1gh6yM+jf
 RcQ8t0hdFZBDyNPsPQf79xziCvZQykFUGfwcg0MmHWrqXeeq26gKejE
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: DqpGFmnvgJlDxj0fHwDh7FLrI_kv8jxm
X-Proofpoint-ORIG-GUID: DqpGFmnvgJlDxj0fHwDh7FLrI_kv8jxm
X-Authority-Analysis: v=2.4 cv=ApTjHe9P c=1 sm=1 tr=0 ts=69bbc406 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=C-Lt6vKPNbzZJwMf3fAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA3NiBTYWx0ZWRfX5MubxnAKBIxM
 ajko6Zxz9DZcnYYBYOeo5HO/r+LjvcJbJRuZDu+ifjevi8pCjJJ4bjTFi/+hLwPUq4Na10SsexN
 1f26bBMBNKEh5pWMPMRjwrtP4imnd0ycZib5IHvERg6mgu+DixgkDW2muNncZ1w0WKNcGA/TSwS
 qS19Eff0T1byVjWqQsgQJ9wqXdXSpH8s9QAHYsmaJCoMOEAUPS/jHgz1peCt8GQeBW6U3d5qVPj
 KF1C49/ne3iCtQnfUAHC/9XTRtSaZGGVHT94pdHmNQm3tOVW9Ffg/EXLWx0Y2B4ZkUoWGMYGXNc
 m5s/ih/XngjKlXqZv4PV4hF1dh15ASRW0N6vYCJ5qFYUqxkuOqn2gsREQc4mGrwchSqxk5G3de0
 ONO+Y6BVzyQQVXUTwjxvStgAfcgGXpprRthwVIBMGgFfRpZGrGXREdJ+N78hhqydWGNZfRHR8dQ
 g6RIORLzRZSMWgYM9xA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190076
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

Move UFS clock initialization and enabling before hardware setup
to ensure clocks are running when accessing UFS registers.

Previously, U-Boot depended on earlier bootloader stages to
initialize UFS clocks. When these bootloaders failed to do so,
UFS registers became inaccessible, causing initialization to fail.
This change makes U-Boot initialize and enable UFS clocks early
in the init sequence, removing the dependency on previous
bootloaders.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/ufs/ufs-qcom.c | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
index dc40ee62daf..c63e550c881 100644
--- a/drivers/ufs/ufs-qcom.c
+++ b/drivers/ufs/ufs-qcom.c
@@ -30,6 +30,7 @@
 #define UFS_CPU_MAX_BANDWIDTH	819200
 
 static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_hba *hba, bool enable);
+static u32 ufs_qcom_get_core_clk_unipro_max_freq(struct ufs_hba *hba);
 
 static int ufs_qcom_enable_clks(struct ufs_qcom_priv *priv)
 {
@@ -49,12 +50,34 @@ static int ufs_qcom_enable_clks(struct ufs_qcom_priv *priv)
 
 static int ufs_qcom_init_clks(struct ufs_qcom_priv *priv)
 {
-	int err;
 	struct udevice *dev = priv->hba->dev;
+	struct clk clk;
+	int err;
+	long rate;
+	u32 max_freq;
+
+	/* Get maximum frequency for core_clk_unipro from device tree */
+	max_freq = ufs_qcom_get_core_clk_unipro_max_freq(priv->hba);
+
+	/* Get and configure core_clk_unipro */
+	err = clk_get_by_name(dev, "core_clk_unipro", &clk);
+	if (err) {
+		dev_err(dev, "Failed to get core_clk_unipro: %d\n", err);
+		return err;
+	}
+
+	rate = clk_set_rate(&clk, max_freq);
+
+	if (rate < 0) {
+		dev_err(dev, "Failed to set core_clk_unipro rate to %u Hz: %ld\n",
+			max_freq, rate);
+	}
 
 	err = clk_get_bulk(dev, &priv->clks);
-	if (err)
+	if (err) {
+		dev_err(dev, "clk_get_bulk failed: %d\n", err);
 		return err;
+	}
 
 	return 0;
 }
@@ -561,6 +584,18 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 
 	priv->hba = hba;
 
+	err = ufs_qcom_init_clks(priv);
+	if (err) {
+		dev_err(hba->dev, "failed to initialize clocks, err:%d\n", err);
+		return err;
+	}
+
+	err = ufs_qcom_enable_clks(priv);
+	if (err) {
+		dev_err(hba->dev, "failed to enable clocks, err:%d\n", err);
+		return err;
+	}
+
 	/* setup clocks */
 	ufs_qcom_setup_clocks(hba, true, PRE_CHANGE);
 
@@ -579,12 +614,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 		 priv->hw_ver.minor,
 		 priv->hw_ver.step);
 
-	err = ufs_qcom_init_clks(priv);
-	if (err) {
-		dev_err(hba->dev, "failed to initialize clocks, err:%d\n", err);
-		return err;
-	}
-
 	ufs_qcom_advertise_quirks(hba);
 	ufs_qcom_setup_clocks(hba, true, POST_CHANGE);
 

-- 
2.34.1

