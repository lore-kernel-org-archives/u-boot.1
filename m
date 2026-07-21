Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17419C4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 06:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B30F840826;
	Tue, 21 Jul 2026 06:53:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V3FgMePLDDEm; Tue, 21 Jul 2026 06:53:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA408407DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784616783;
	bh=qDfb46YzobsVANU+EolwDfNs9HeU/Cc2ouZL51kJytU=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=GuCAIrLiuUKbiVcABQFkz6xS+CfLeNK5WPDPZufZm8xBw7rrXEoU472fQZjrMiv66
	 kvoxS8ISm9B0+Ai7h5G0zwtxt1ZmT7O7ZjXRT94xoe9j3AM02ea1kOyTACArzUGeRf
	 C4dV7eW+qIiblcJOaLThGltXxN4MZzeBN727qZJvcbdsmzKl6ZSv1H/71wih+LU9C4
	 JrziAxHBgZksKOsHyBz8waCLQZeGLn3x8eu6xKF/RcKvqM0Don/9/9GRTxclhFMRUi
	 0tOobBOJ3RcW2AO9SyJkJGzdtitQHhGb/K4IBqYDJO+WGp4d/2fyGEr7fqq/R+Ag2D
	 uXYf8t4TeVXrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA408407DE;
	Tue, 21 Jul 2026 06:53:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A97B51093
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:53:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F6A180E35
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:53:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id es0zuLCp2Um8 for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 06:53:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9605880E1C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9605880E1C
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9605880E1C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:53:01 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66L63VRA933522
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:53:01 GMT
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqv5tt9j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:53:00 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cbb20f82a0eso933463a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 23:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784616780; x=1785221580;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qDfb46YzobsVANU+EolwDfNs9HeU/Cc2ouZL51kJytU=;
 b=TYNVbeN7sZ9XRmv0TPOk69Qkqg2bGO2aVz0c+ocnMJVZ+uyYwD6vEhTAMMcxWyJ8Nx
 kgbWGkkK1WNz2P6YdZPkCuqyTlMIcwuWEa8jVHmqkM7Oi/J+nl2UZl8SRmWPfqaHGr02
 74OPHlshadJLmuFo9AL98OoAnocNGF4M1KG4ANjt4WyaHppzIoOVJDKOd2bSKQcrCyjW
 agvVcY6sLwRwCI8iMFSexz4iyz8Msag2GWWUlnd5pJyDit3GJFwoWdaDaP9BKbTHoNrb
 PDqk3klCfLoL1O8d8MtVCyB+08kv9ubhoqxTob6wqyxRj7G3+ChzTkIiTG+YeC3sDFoe
 03TA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqzVT2+B1PZ/9byktAvI/3+VyMrkfEJm022EZWeO11/tctOwQ5PSqVykKMdZbUHgCiirA9K+pA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxPLMGASZ0UjJRHbX6aNf2ciq3eqDBIARGSh14MOV7lwBVSkHy5
 pDAdS9BV5KxhmSa3D3+fIjhh088VayUl87v9NfxWQZtSfV44acgEkur3c+H03qCQT3Jr/XnGfpE
 lTo+/MCqsk4xsUL3l/BG4R2fuVbbrLVDmrqHXKyIsCIeWZcFYgM2Q5m2Zs7miRPIAHd6vndw=
X-Gm-Gg: AfdE7ckI8JouqnljCT1PPNLWOWugh0g6Sybi6b31Opo4r1rqAmRM3MQrKjVaKv0/gIE
 sqqWNSCYZtGh4JXbQJghR31GPom4bwrFxoTceLrBGekrGrVUKSuP8zFjiQOjoCDGx50Q1/XklOd
 pTWhzJkISbaXy1pbz02Cza0UrvNxRXML3EVXA5h05xInWnNgYN/VoB5y+dyR4i3al27e29Tmp/2
 RGOo/LAjv2tduyBu9411bRihW2O+mLUNUy+IQwWP3SYWMx4M9izkz6riK38nf+ubPHEr9Cl2D1x
 tZ0M01cRPo7DQk7bOfE2tt4ISUJ/y1mX3Ckk3dT44/YD2ME6orZRSIt5OP+Wywa7+PgI7FTjjDk
 PyxxehF0o+R7wFSEaj+jxluJyu+E008bd+Wf32AERRZMkF1rgMgvMnd42/A66Uf1MVs06TDew8n
 IPWYhyw4OCsXAnFpY3vOckz7RM/2+x
X-Received: by 2002:a05:6a20:a109:b0:3c3:7206:1e5e with SMTP id
 adf61e73a8af0-3c3ad938c76mr18432862637.53.1784616780207; 
 Mon, 20 Jul 2026 23:53:00 -0700 (PDT)
X-Received: by 2002:a05:6a20:a109:b0:3c3:7206:1e5e with SMTP id
 adf61e73a8af0-3c3ad938c76mr18432831637.53.1784616779643; 
 Mon, 20 Jul 2026 23:52:59 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1dde81sm73931642eec.21.2026.07.20.23.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 23:52:59 -0700 (PDT)
Date: Tue, 21 Jul 2026 12:22:43 +0530
Subject: [PATCH v3 2/3] drivers: mmc: uclass: Set removable flag based on
 device tree property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-emmc-v3-2-35cebc036994@oss.qualcomm.com>
References: <20260721-emmc-v3-0-35cebc036994@oss.qualcomm.com>
In-Reply-To: <20260721-emmc-v3-0-35cebc036994@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784616764; l=2038;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=JnQA6gYp4HDagohD3OYFJbX6uRwuajr302G7ED0F1gU=;
 b=Pmvp6zqghTY5odvPy9mf2h+olTNiLrQHHl1hextUS+Yj2fA41ZYZJu9UyCHyc0vyH8yKYefr0
 I3hibhqKidPBXClBlW3l43i4E+BlR/y61/l9QnnKlBsieNRZEl4k+rM
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: UKzdYB9J2670a25rvzHZgpG2vC2KPPaY
X-Proofpoint-ORIG-GUID: UKzdYB9J2670a25rvzHZgpG2vC2KPPaY
X-Authority-Analysis: v=2.4 cv=e+U2j6p/ c=1 sm=1 tr=0 ts=6a5f174c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=M98AEg7gP8su2nlf_gwA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA3MCBTYWx0ZWRfX7pVB2fSGQldm
 lGpEO1yaXPAjuMPZuqJUh9EZt2/p5fqbze7NqawgT5BI9YnR6SU5juDFmUvy3uvrzwcGm9SU2F6
 lMpExN6MS4HISdH6BrbGkIrXduhANRA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA3MCBTYWx0ZWRfX1v+DjwhJRyH5
 QvTFPa7pFT6VXxrdfe/7oI0bivPgB4hoHG+rNpmhwdNGfoZRFP0Ms60zVtfvHrh44XCBPNAaIUg
 g0dJ8HSIqeopSXYopoDMDeesRByBwOMH7ma1aWFtehCZ11q4y+21u760kWFT/F7+14mXTKYwcT6
 1saydLSimCHlfFC6YQTII+OMudocW2BhrBv8RNaQv44a7JBc16/uZX5Q2sv5Bqr5iXhVwummamf
 kIgx4PiNQVFLcJdg5RhwmqdK1UDOLaPlUBPZ0dWOF21/JMTHlXeqNQSCx/lA2IX4wn2pXFEx/rR
 sIZHuAyca278gTenHqf8nI+tIwQ9w9aI266Wa1dMgJjP3S5wrvP3pXJ4xtVxAclI0AOAPvnDT58
 bYH9sb4oaTEAZQfuuehW2b3J5yUZvE8RHJF+aokhBqOWtSJVS4hWpbjoVu6ObxsMw9Ct5wTugri
 2L4rKtz7VZ/DWMAOZig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210070
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qDfb46YzobsVANU+EolwDfNs9HeU/Cc2ouZL51kJytU=; b=U9qb7ACquA0dL1CC
 QCy18wVUMoDUi63Ms1vra2gmbLt8Ugu2JVzxDXED2Dn33SuheULiS9bWTXjVbnlj
 YrcOe2wX9dj9RSxhjkVhI+aUJN/asU97wqddNC47ngjZP/GFGT11AEEBWekdejwp
 VUJeeAVfo5g7kVUzUYKuqUuWz+fTW9ofXfS61+jz0sVWomQwf1IWgJKEBgKsG+HV
 mCoNqpLqWtITfwY0fjX1X4O0ZtxI/7UpF2HiInUbWt05g15JJEP92aZT+IVDPFon
 2RaNVvNszI++DFVunvEKdt7prpJXye8faTrY9n5LMTGS8HyBFCX2DBewjLfhF6Mo
 mwrWaw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784616780; x=1785221580;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qDfb46YzobsVANU+EolwDfNs9HeU/Cc2ouZL51kJytU=;
 b=CtOkhI5gQ4GQ+AbtqmuoKQPL/tyPLPadQKCfwF55xURpbR9o+TwtxaeP/cEL1nt+jv
 7Fyyj94MGYgpz2ZtrnMPXYj2FXPQw3fj74eJdu7EvGZhHkhv6h2NH38hSvip852X4KTw
 5FetGG8MCDF7vDTWe4RRRrXvqzYf/AKUPXhbGK4xr6eNelVNLIWQwWej3RxbM1kg6lig
 Lf5lf4DxM0RnLaojGTSTGNSgqx8ONIo2kt6tGe9IxvwhUyF3MsNmrJm0Xkz7oYpfz3to
 obaiYPs/4NxIHKBMTScQS0YAfcY9wwAfM3IM+dsC/wsqIt4WEmsW+UbPKkmNKcZm5nZO
 i9Hg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=U9qb7ACq; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CtOkhI5g
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The block device removable flag should reflect whether the MMC
device is physically removable (SD card) or soldered (eMMC). This
information is specified in the device tree via the "non-removable"
property and stored in the MMC_CAP_NONREMOVABLE capability flag.

Update the removable flag in the block device descriptor during
controller probe to properly reflect the device's removable status.
This allows the block layer and upper layers (particularly EFI boot
manager) to distinguish between eMMC and SD cards for appropriate
handling.

The default removable=1 is set in mmc_bind(), and this change
overrides it only for non-removable devices after mmc_of_parse()
has set the MMC_CAP_NONREMOVABLE capability from the device tree.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Add proper error handle for bdesc in msm_sdc_probe while setting
  removable property of bdesc

Changes in v2:
- Moved removable flag update from generic mmc-uclass.c to platform-
  specific msm_sdhci.c driver
---
 drivers/mmc/msm_sdhci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 7bdb02142a2..4d02e9b6cc6 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -187,6 +187,7 @@ static int msm_sdc_probe(struct udevice *dev)
 	struct sdhci_host *host = &prv->host;
 	u32 core_version, core_minor, core_major;
 	struct reset_ctl bcr_rst;
+	struct blk_desc *bdesc;
 	u32 caps;
 	int ret;
 
@@ -250,6 +251,13 @@ static int msm_sdc_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	if (plat->cfg.host_caps & MMC_CAP_NONREMOVABLE) {
+		bdesc = mmc_get_blk_desc(&plat->mmc);
+		if (!bdesc)
+			return -ENODEV;
+		bdesc->removable = 0;
+	}
+
 	host->mmc = &plat->mmc;
 	host->mmc->dev = dev;
 	host->ops = &msm_sdhci_ops;

-- 
2.34.1

