Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECE4F43698
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:11:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A39E484246;
	Fri, 17 Apr 2026 14:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QzA/o8P6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cIIvlaBF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 163588426E; Fri, 17 Apr 2026 14:11:09 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F22A084262
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 14:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63H8BvVP667583
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 12:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SnPlMUNetFH
 L0sDPmGUWlauykHp9vqViRfmE8moct58=; b=QzA/o8P6RuOLqtHo0kktlXPRs5X
 8xOKqC3zHMlt3/VxXmRgagXSdr9u71B2mYMuTNsdxo+nZbrCJRxa/qn88OZJSWpg
 RKQlhHXp7s6rMdtlkVAc6tqqjX+3+FRt6wU7mk6r/OrvPB2389MVn+37rZ1zKqaz
 JA0qpoOeTcNLIFNchsVjcnnQAr3zrCnTFbPVLsod60kDxdF+RudroRWT5iV6Dxsl
 nINWfs4Gw4kU1xqtpRkfjB7yctstn1ZSxL6kTDY+Ix5yfb9Rsh5Stc41QP5giz7E
 PaX7P9QvCEsesy1wKjK+sbOnCMGaB7QWhC0kGuFIu3VazsSvsW9tQ65tL2g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkaxct609-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 12:11:05 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82ce34a78edso756338b3a.1
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 05:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776427864; x=1777032664; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SnPlMUNetFHL0sDPmGUWlauykHp9vqViRfmE8moct58=;
 b=cIIvlaBFPY7UkfxFUUuIDkuqqAcljlwuZbK5ZuwfjFyY/Tn0b+BPlHof5NCj1qV9BD
 jbVJOtwBNGDaTlI8mZlOUzamT9H5htUPmp5YATCOLF2VqrbHRaDb3yRtLwmOAamlGjuO
 oS+7xWtOVDdBs9T1jl6dbKlWaUe2pFUQjCsqYyaZzVuHto13mBrBSFhQYTTfuWB2IcU9
 dvGL/rkNYv8hi/zxZIAhId5Orbdpuke/c/PT0Q9wStws5Uyo8YL2P8SoUc3kj63SI5V+
 Z6vXNmVwtQk+yE9N8touqgxZo8oJucln1ZBoqFtbt8l+llTO61GTb8Hbn9ksJeGSFTeC
 3fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776427864; x=1777032664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SnPlMUNetFHL0sDPmGUWlauykHp9vqViRfmE8moct58=;
 b=XcRNcyatNdPDesBOyP7uVI2dje99ToPakAmYDE60dtRwhQKnNRG/KxQUUbi95M5pIz
 UAgoQrLCmJqrvPB76Ep2X+M2AzclrYjMKKBjtOdRuKuoVyn1Z+3oSKJ1Jh+wkgQ4rVVm
 +2/PtzTwf5Xh6PicPFqZA/QQkc3XhesROMfBuv3oPcl5Auf+hJRGK8evFZ4I/XmlgnLG
 2qYknfoY1AJJIEKGSaF7ftih+w8CA0c63WNAzWQ/GfcEL6pU9ABPy795NzEHRk/dlDEM
 65k+jaXfxXDbqgvDLpWQ7z+IdIVJ9lrgPPE3u2NGQUETF20G9QW5fsD6C7u3nEsxqFTj
 9V/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+YXPdz+JivaE5S/E8///3T5ZWdOO2MVz88CTbjJCGV9jkWOQhADraFQ47fnhsYLqVsiSgGMkk=@lists.denx.de
X-Gm-Message-State: AOJu0YxbqD+aCsRqdcAzXr1ILOf2TCkBplRllpoDBzsUiVSj87O9snAY
 TESZgesQGbOEAauHIbX3A062hOCQ2bTJTibFoDvP/V8YZ2kQ5iu/UfZl4iyM65U9bWTVoUd/JEM
 HUD10iI5Qg17xz3cOsG+ZmkgW+f53EOIOw67FQ2Ssn8UebrAC+xD+f9nD
X-Gm-Gg: AeBDiettuvD+wpYfgo4pzBf+oeF5bn7hVbtrzD5rrOTB7logtnuZohpdIcOWaj2ZF1U
 rQcdrwnqXP0jAew5IxqdjzUJVbJxbTBUIa/sFDz7TkMMc4MohLsEDsfsZ+NfyfQrWK2yc6LQVGb
 td7ERrWfi9KyG2hY6WDtFdaEXL4L6JQi4rpji4C8d2CK+J95QAGN1r22zmBLp7qxvUmbPD74gH2
 4mQ0UzdrjHl6Ai07807N1Eaj00XvvWLi58WO/O4fJ+ddk4HeufTKvKOIhOfkVwJgjkl4khztPAU
 zqQ8BIP/C49+7lv0HJVYWJr/ObeF21d9Gusb2h1h9h7jgQLCRI6ScH2WY6MaEJ9qCw8F7Rl6C+M
 BEkk6UN91q879iTmeGZkka7iTw2BD1H1LR0ktgRvR3wgUgjFhycJ94jkrfB4E+CTT9wPp3JCx1w
 0+oOSSdR4/rPwEyqQv4JHLrjjfyiAUTEcEokOImbw8Y6c3PIIjSS8=
X-Received: by 2002:a05:6a00:3498:b0:82c:20be:57e6 with SMTP id
 d2e1a72fcca58-82f8c81273emr2748094b3a.11.1776427864466; 
 Fri, 17 Apr 2026 05:11:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:3498:b0:82c:20be:57e6 with SMTP id
 d2e1a72fcca58-82f8c81273emr2748045b3a.11.1776427864043; 
 Fri, 17 Apr 2026 05:11:04 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9cbb28sm1744641b3a.13.2026.04.17.05.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 05:11:03 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com,
 sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, gchan9527@gmail.com,
 mchitale@ventanamicro.com, maximmosk4@gmail.com, jonas@kwiboo.se,
 marek.vasut@mailbox.org, quentin.schulz@cherry.de, peng.fan@nxp.com,
 sajattack@postmarketos.org, balaji.selvanathan@oss.qualcomm.com,
 wolfgang.wallner@at.abb.com, e@freeshell.de, yangshiji66@outlook.com,
 jan.kiszka@siemens.com, funderscore@postmarketos.org, hs@nabladev.com,
 kory.maincent@bootlin.com, jj251510319013@gmail.com,
 carlos.lopezr4096@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v3 3/7] configs: snapdragon: Enable FIT multi-DTB and
 configure IMEM
Date: Fri, 17 Apr 2026 17:39:47 +0530
Message-Id: <20260417120951.3454249-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
References: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JcqMa0KV c=1 sm=1 tr=0 ts=69e22359 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=9baf_Ect29FPVBM-dAMA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDEyMiBTYWx0ZWRfXyInJqaa+c1ds
 hvEwp0JGb2fPOWOEXNRFkPun5H2wGp/eyuMS3dN6ArjAfhl1v+FyvOG3QplTUGPYWohf907cWJR
 G473MBQS2EdwP1HzWU4v8z5X23IfYIysfouiH10CcCJsnSyJ0upLXR11C9ol0XWmo3HWtR2hazz
 2GzH9/fiAnRkiUylqA/D48B5UZQQujE2lcQVQ7zO0CR0AB/wYe1EdG3KwkSoHIYE6l/T30MOBI+
 zllNpIwfFws5Tk8SwgfM+tod0fdb+T8p3aHvE2puo0ZIjHpog/769x6Lrk0Mu32/Q9kb0BXjeOG
 5QFwEGzVpqP9KAyljSSMVr7QCUrHB1W5IrFO7CqT+tyEhAFGx0VBCwK1hf8i5bu60D61FELIM8w
 DJ4qqmj/XbEmsQqnbJrs87PEPKdEWnqyTkGKasdXhlLcopAUtAE6nYiYZcWJPwWjqKPbcfGttOO
 +xulTNyXtiWvzJ9DJbw==
X-Proofpoint-GUID: 4uiEaEgu9Ru3W3uO926Kq5h9ZH_JihHT
X-Proofpoint-ORIG-GUID: 4uiEaEgu9Ru3W3uO926Kq5h9ZH_JihHT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170122
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

Enable CONFIG_QCOM_FIT_MULTIDTB by default for Qualcomm Snapdragon
platforms to provide automatic DTB selection from qclinux_fit.img
with overlay support.

This allows U-Boot to automatically select the appropriate device
tree based on hardware parameters detected from SMEM, improving
boot compatibility across different hardware variants and reducing
the need for board-specific DTB selection logic.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index baad5f09455..36ec8a50a63 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -12,6 +12,7 @@ CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_QCOM_FIT_MULTIDTB=y
 CONFIG_BOOTSTD_FULL=y
 # CONFIG_BOOTMETH_VBE is not set
 CONFIG_BOOTDELAY=1
@@ -48,6 +49,7 @@ CONFIG_CMD_RNG=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
 CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE=y
 CONFIG_ENV_DEFAULT_ENV_TEXT_FILE="board/qualcomm/default.env"
-- 
2.34.1

