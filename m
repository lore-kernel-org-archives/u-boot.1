Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E831EDF154
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 11:27:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F48783D71;
	Fri, 13 Feb 2026 12:27:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="op8BRi10";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cs84S2pO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C16F83CEE; Fri, 13 Feb 2026 12:27:46 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34A9D80B98
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:27:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D5KIAc454948
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jo7U6bY8FVt
 CHQQXv4Uo+kCfOL35EfCFepM5/ovJ738=; b=op8BRi10WR2xShLTRmY0I3E0Hrf
 pQoLZeZQiEytCGajwhqDbAds5VYoZj45BLmtgOBNh3j0C13XRbpVUP2C5XYZbipR
 FiF6e2v1bbVmJjYxmYsemJ+ymMjbMnpa0C8YzdmiLMNxPwVAlp0IibNjU03B2f3w
 CF3Cf48v8+NItlwygmN+O0WrTu/vHHS2kucpEAELXZ2qIk9W1PDECPkV5kJQE8i9
 vinJmOWWZ89fDegLI8tXi9GbnJ+TGA4UMpkFV0wHC/mEeloS8ajYbYvZTCe4gj86
 DcaTvRGz0UZO1V0wWKtRsOTpl9jfrWWhjS9lNk6eDJZ3VZzoUWS47TMfd4g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9mev36nj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:27:42 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-354c0eb08ceso3190979a91.1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 03:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770982061; x=1771586861; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jo7U6bY8FVtCHQQXv4Uo+kCfOL35EfCFepM5/ovJ738=;
 b=cs84S2pOduymGNishNb5qnHk4u98Fn3VUtQMyRKHCuLV4QOSUFQOS4J5/aNqlQl6vx
 7r3S2xbFrq+rIpWMK3Esnds06TRLsyOK/s5/EnVkYperIL51+RCz/TYicw/+pbFhr8CD
 HMeUXQPTgH5sRtfvs+OXI0HlExPZDIxbCsZZFTX4ablw0U59QveG8vQUk4RuSTpwn/K/
 oOqFShgCaCq+50L0wULtpvFPjFecsxwSL20zgzZoSahmdPqy8qN95jzOs6TW8Y1LVa92
 Q3CCVJedtR1aa+QNO+7otVIboF2UUPzKDoc1sUoMNAi3yx3phAyahsvUK04ba6+QGe7F
 WwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770982061; x=1771586861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jo7U6bY8FVtCHQQXv4Uo+kCfOL35EfCFepM5/ovJ738=;
 b=iVc5PyolaFgU8+ojqs3z8A0rO2xNoGEqc0mj6E0SqGvrQd6NjLFo4ubjydUxdeJBe4
 TxevogL96e4X45A4Rh6/KeScGA5XkeUYLhlZzuwDNfUBCnoHH50PHZo/c6ocL5x2VRww
 TW8RqJ/LYGjp5rm+x38ZEo4c1WBskmIYCo9ZfTM9k09KDlBASjHseOAc0qHmwJx1TQRK
 JQ73twq74C2Ag2DScnBT1vJQJJbu6FWU0w03fX0izTLmvGUM2ubY0nXuUH3xOEa97MK0
 j+YOZW4pB0w5h8w7YBLGXwjAxqyASyL8uXXYXluA9IB0s3eQFnoSbwhD4FEy7Z2MFIF6
 xooQ==
X-Gm-Message-State: AOJu0YwlGezaHbofgxa8ELRFLe2NHj66jze/71BYxmu918DCbhvG8ba6
 2fuae51grPQ4DupKRXLs/6oInv3kgWywmYn61/ffQYJ9fZ3zwjNiKIfIEXis3Iele5OM+NNwJU8
 SAfLSKkgHWTU4/Nesycz8CDgaQJk0ONm531fiZyJj/MZlAseYunhjPC9Z/P9dz2mG
X-Gm-Gg: AZuq6aJjregYSykR9KUuSINtpN397ISLJnlrD/o3ZHtWHq+vrlvH5jiT/FPFSkcjQEV
 W13zWs4f8f3RaYcDrBT0ej1q+SkmXuxnCQfreGZnCA0oAld3yElmGORoRCYTe2pCMFg8hoqpp2t
 jCJx3rJS/nAMhp6YvcrTGVjnbrc81kQdYyWyXw23VCb6QQelXE8BQXkCGVanDF2330XZh6kwSd7
 T2K6xkU3iDLm8cy3vBtX/S/rtNy+LGA+pFmlRZuSBLNGi8YdYd2pE4d4O2pSuBGUZVnUeGOA+0k
 OCXEn1pREe7MZUs+hTqYwXKnk3wP+9EIs3DVxOTGzFAyKn8FADPvRzxAYiNn90+gVSOmPyEQv9m
 HlL7DXynRhgb6B3HfycUGsonO6qGBJz2G63vbzBkUjSJeA6wBM85KUaVWW9GW4v7DAv8hIXGPir
 IWBnvjqmjRFOwKCiRQqzlqsqMliuxid+9Y8osIJpRZ
X-Received: by 2002:a05:6a20:3944:b0:34d:d030:6739 with SMTP id
 adf61e73a8af0-3946c797043mr1657472637.31.1770982061158; 
 Fri, 13 Feb 2026 03:27:41 -0800 (PST)
X-Received: by 2002:a05:6a20:3944:b0:34d:d030:6739 with SMTP id
 adf61e73a8af0-3946c797043mr1657448637.31.1770982060705; 
 Fri, 13 Feb 2026 03:27:40 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e1969f314sm7996939a12.8.2026.02.13.03.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 03:27:40 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: u-boot@lists.denx.de, sumit.garg@kernel.org, casey.connolly@linaro.org,
 u-boot-qcom@groups.io
Cc: seanga2@gmail.com, trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, peng.fan@nxp.com, quentin.schulz@cherry.de,
 n-francis@ti.com, xypron.glpk@gmx.de, h-vm@ti.com, justin@tidylabs.net,
 jamie.gibbons@microchip.com, ycliang@andestech.com, me@samcday.com,
 sughosh.ganu@arm.com, gchan9527@gmail.com, ilias.apalodimas@linaro.org,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH v2 1/6] reboot-mode: Use actual cell size instead of
 sizeof(u32)
Date: Fri, 13 Feb 2026 16:57:12 +0530
Message-Id: <20260213112717.1256823-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
References: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Zq7g6t7G c=1 sm=1 tr=0 ts=698f0aae cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=5QhIOPboivaRtBlMk4QA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: tXjYEibwNuo0LTMTYceVXJk5z-Ia8A0M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4NyBTYWx0ZWRfX3gwCBwJv9ctx
 pNUzjX4lsMHekfWybPn+fZaiiTGj1bG1klqa9Fn31svQXhyF7DS1Zua/C5iAX01YU7CcmjbQ6fa
 pKfcxbcvpgZLwYfwmwKCiBymWlTTbF+RGIfutUOtSm6Oi07G23KG996CkcEvjFeoQ92fFHq01AM
 +FU6tp8i8182/Ks/5ZGaXjbUlvoTJi3CH3xvbIcF/vvCmFMWd8Cg0uNIif52LajY33C2i6fKxvT
 /0qXiMZF0FBR5W6pWEuqDaaiwb3COUaJV9vZ2NvQF1AQIBEOdmPnxs0YnXi1SH7KRM4mhHwKR8W
 MQnncOveddwvhUN+DI9lniWtQu4H0HbWRa6q3yGOPHCwlnNxjJyohnk31LoftMV44kvb4XI5pEE
 z23z2HhLrZBjyuzDlsb39UswWOAKcqV2tdo7Ukmfq7FD9zkDRM/qmPp26qSzn9E0HQZ/yoMfHYs
 DHeMcFlg1WjOJh/s3yA==
X-Proofpoint-GUID: tXjYEibwNuo0LTMTYceVXJk5z-Ia8A0M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130087
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

The nvmem reboot-mode driver hardcodes sizeof(u32) for NVMEM read/write
operations. This fails on platforms where the reboot reason storage is
smaller than 4 bytes.

On Qualcomm platforms with single-byte PMIC register storage, attempting
to read 4 bytes from a 1-byte cell causes the NVMEM subsystem to return
-EINVAL, breaking reboot-mode functionality.

Replace sizeof(*mode) and sizeof(mode) with priv->cell.size to use the
actual NVMEM cell size. Also initialize *mode to 0 in reboot_mode_get()
to ensure a clean state for cells smaller than u32.

This allows the driver to work with cells of any size, from single bytes
to multi-byte words.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/reboot-mode/reboot-mode-nvmem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/reboot-mode/reboot-mode-nvmem.c b/drivers/reboot-mode/reboot-mode-nvmem.c
index b9af242520a..60307cce49f 100644
--- a/drivers/reboot-mode/reboot-mode-nvmem.c
+++ b/drivers/reboot-mode/reboot-mode-nvmem.c
@@ -18,15 +18,16 @@ struct nvmem_reboot_mode_priv {
 static int reboot_mode_get(struct udevice *dev, u32 *mode)
 {
 	struct nvmem_reboot_mode_priv *priv = dev_get_priv(dev);
+	*mode = 0;
 
-	return nvmem_cell_read(&priv->cell, mode, sizeof(*mode));
+	return nvmem_cell_read(&priv->cell, mode, priv->cell.size);
 }
 
 static int reboot_mode_set(struct udevice *dev, u32 mode)
 {
 	struct nvmem_reboot_mode_priv *priv = dev_get_priv(dev);
 
-	return nvmem_cell_write(&priv->cell, &mode, sizeof(mode));
+	return nvmem_cell_write(&priv->cell, &mode, priv->cell.size);
 }
 
 static const struct reboot_mode_ops nvmem_reboot_mode_ops = {
-- 
2.34.1

