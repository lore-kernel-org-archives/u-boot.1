Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1821C531D4
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 14:39:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 609BD409C7;
	Thu, 23 Jul 2026 14:39:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bidNGI7tzJ8X; Thu, 23 Jul 2026 14:39:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 431DD40A1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784817556;
	bh=X4nZ2JZT4dGZ33vhUeBVLECdPyNYYi9DTn3TsGVM0QY=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=0ShYBNDP46D89FP7lz31/mt6Ar63vZgbyKG4u3H++zneKKJBmvYGRCRYzJ3fBNLPZ
	 D0TgRJji9Y+nRMu9ijkxv+FAIAW1uCaJL5r1RZcrfadoHbUBxBBlLEuvePSMyeTMCY
	 5W++WeUEs6IC51NtgLwqHEdE+H2gAt0hhe6zilaSiflxYwkDWbTQiyj3UKGPeOb64B
	 C5ZfW/0whHp85e/q/Eettqe3+7rJKn7SFss5f9piFG6tMmbZ0zO6jzhQPVZD9Rbupk
	 gWjU0PSZZgBTY4qr4igOsMDStSpbnx25YTiU4lyWmNcKhsHhHphzo9Kj/ByD56GS+X
	 JLrUz8yjAD+Hg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 431DD40A1D;
	Thu, 23 Jul 2026 14:39:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C364F390
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B3AC9409BB
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:39:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ed62mmJAVXFt for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 14:39:11 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 56FD4409D7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 56FD4409D7
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 56FD4409D7
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:39:11 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9D16846A4; Thu, 23 Jul 2026 16:39:09 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A4FC83E76
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 16:39:06 +0200 (CEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NCvXTo3954473
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 14:39:05 GMT
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fke0ksw4h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 14:39:04 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8eac2620cb0so14234086d6.3
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 07:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784817544; x=1785422344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=X4nZ2JZT4dGZ33vhUeBVLECdPyNYYi9DTn3TsGVM0QY=;
 b=lpGC5Qn32smsj01NfI50ThsqhIsRg1qlcPgOYugqE1ciyRNC0wR/UPX5H5GQCE5pBA
 KgC87dLe0iWxQMKwDgh0Y/CV+nMhgaXu5dV5eLeqbnfJ3TmYj8nbN5Zau/qz2vqa/6/i
 arCJIVXs/u34hOw/WchexBgZLZXGbhS/ZwrahDwn2qIwYimmk4APtN597OcEzxeQLmB+
 GGFZhHCVoCIH5ST3x4EldZud390Ue4i+XpyaWJ2gW0DOGjP6/2juvfCe+4825h/RNUU3
 aea4H3bKmIXSwslWG7CufJFdGyav0SyAvPFTiVsQd8BGSYrVQsVADXDFHlv4oQOCRfT2
 CEtg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYJj0Tcad21RRIuopuVfIOeK8lxX7+afr+Ytjl1oHYdz8Aau0kjtlKsYhLKama62606ZYfwTw=@lists.denx.de
X-Gm-Message-State: AOJu0YxgwR6YjI12s9odnSbkec26EH9LzQ2oMzcZNz1/F6PyLHu9qgG0
 XRfHVgnpBieMLV7jEmPg/z0FbZyDlvkXWaAj+5PDAnAIMz/zLWx0zlMBMUs9hryCxAVl7qeGkDL
 64g6rTsnsZF323kmDT0DHnLu1/4qBTt6VQufRvbt08IbzJY5/ai1KtZ9c
X-Gm-Gg: AR+sD10G9uBQFsC/ziji8wNzv2MRivggimIVbVS7G+zRXXCldk573Z/QPtBaVLrcBUv
 rWe6pJ7H+mJOjiilXfRTZsrHQ7e1BVQ7ricw1lrPds8mjIjmEP9sQMtQ4qUBVit5OthTSzVEi7A
 G5zhqql3NAeqEeSZL3DYTt0F0XLOCf4YxhX72itxeWb3UIzx5JZwYC9gvKTC1X4kd8gV0zzCHTE
 8ByO4vSoNyg5uSJkGdQcIf+x623s5xvw2H9czt6VEZblSCc0PKt2fNt5HsUPeEpS+cs73O2qIDI
 ceuvVONBhdYtHT9lcizBrQzlGybubjpFfyM2ZoA4OQ3GFRF7Gfg5PixQZukps10uOdPMk5IIYGI
 5bcdleJsA+likHMmQ1xV+tR/P1jXOtzasyBNbk9qK9qvzRCbim6Q=
X-Received: by 2002:a05:622a:11c9:b0:51c:1e6f:5c5e with SMTP id
 d75a77b69052e-5283defdf37mr30057521cf.55.1784817543880; 
 Thu, 23 Jul 2026 07:39:03 -0700 (PDT)
X-Received: by 2002:a05:622a:11c9:b0:51c:1e6f:5c5e with SMTP id
 d75a77b69052e-5283defdf37mr30056871cf.55.1784817543303; 
 Thu, 23 Jul 2026 07:39:03 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c67339sm16968193f8f.31.2026.07.23.07.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 07:39:02 -0700 (PDT)
To: jorge.ramirez@oss.qualcomm.com, neil.armstrong@linaro.org,
 trini@konsulko.com, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 bhupesh.linux@gmail.com, n-francis@ti.com, marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 alchark@gmail.com, tuyen.dang.xa@renesas.com,
 yoshihiro.shimoda.uh@renesas.com, padmarao.begari@amd.com,
 jstephan@baylibre.com, hayashi.kunihiko@socionext.com,
 macpaul.lin@mediatek.com, venkyada@qti.qualcomm.com, j-mcarthur@ti.com,
 dlechner@baylibre.com, u-boot@lists.denx.de
Subject: [PATCH v3 3/5] ufs: derive the per-region RPMB CID and size for OP-TEE
Date: Thu, 23 Jul 2026 16:38:20 +0200
Message-ID: <20260723143852.2287208-4-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723143852.2287208-1-jorge.ramirez@oss.qualcomm.com>
References: <20260723143852.2287208-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7fOLLqw3Otiby3F2e2OaigCricanKV5O
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE0NCBTYWx0ZWRfX4pohYbDNZruT
 F/YmJRjOsYrhWMDxV4kWMZSr0j5sBqEnbCm/krqisFowugB1tPUkEuhdzF0R+6IzSCdsKuYfuxN
 0ruET03WJ+uP71xlMHMBmFz3cPzYOuI=
X-Authority-Analysis: v=2.4 cv=S7DpBosP c=1 sm=1 tr=0 ts=6a622788 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=6gybMn4DQ-eLdeHqFBIA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: 7fOLLqw3Otiby3F2e2OaigCricanKV5O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE0NCBTYWx0ZWRfX2COIuY+Lz1PD
 FsE/sGWlFEReeearQKJeXxYuz3mEF1AG2Il/7yNRXqFcCfe9wFer7WvOcgmsmnN7WmY6ybnkEqr
 L/rm9PUptFOiCtyFMfL7UkhkvhCdBXXf8TVM87eSh6OGJ8XBmiqIAmgAmvLcfZT+l1ouf6cT625
 bsu/rKp2BevwpB5Mz6wTuYo4eDZ8LYISgNQx2EmHkFUEbHRSya4Tts5vOFt0xuj0C4K1080M25I
 xvrTZCFCAyDO8jJPW+1cIVMe4OKKfTbSvTQ0XRs/fBvEDJ5baJyvn6+5VRvaeeyq/1JlOYp0XJc
 bxpCLuBInikPmLSkA/sVrm1U6SR+caC74rKLdpIqf6ElzJf5y5NGYVK2eW0lLN0nOl9hdu0GhqA
 EcxqyrMsGc5TYhXyc2BPaIj7uyznfcN/eNyiZWCmchi7oYNnmazXuFOryeD0LYt9I8wmlg94I1+
 yRCAxIbIgX/uxJJY4XA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230144
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=X4nZ2JZT4dG
 Z33vhUeBVLECdPyNYYi9DTn3TsGVM0QY=; b=kE4+cD4A8CbUby5GxHC0DkzWhc/
 9vuq5YZwiUMLZZXA9FHDabo+V5YsEU4TR0TjZJ2zqenM54eUijejYaoGQgRq9CJb
 g20Dk5OR5lWaIBr6WxRkr2JmEAeRPLgya5DKGs6mE9++djc1SXaajfG4StQrgwuf
 I2nw06uQx2Nkl+oOzbKvH9je+jbj5CgHuDcLE6etHO9keec0lI0/iqp4cVB85vZ3
 MMzbNTKLnYaKtrWLkeWAJc3rydcXYrtUHk+ni0KiWFHtELFSfvs7UX30JcYXf6CZ
 kPB8ILCTuFMgRzpgmAT4xaotwcUVrkBjPNRubdcePBeUCCdhY/PUR2QqpWA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784817544; x=1785422344; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=X4nZ2JZT4dGZ33vhUeBVLECdPyNYYi9DTn3TsGVM0QY=;
 b=Au0Nh5yrd9cSfF8251wMckEkxgaVJl5mAHMeHukF6fa4YyYueCuLN9EN/fEhTCTyGX
 nSxNwkwI2gwcM6axGK0M0CCVnl7nPjlrx70Zz/JxPVxlY6gLaHsK3qPhcKhAVhkZBRD1
 ByC6RjTtjM8LpKK8u/NnUEIg18wjBcXtTXg8HnhMRyLgJ7kbJR0xJ1l4/MQD2JL32N8m
 vhoSx8vo/XjWlbVxgJ4UAmVbMUtjS7VxCrID1QnQzK6kXiVCYUXvYD4RrUDGZjGMymJ3
 PHzrvy2ALjT6EcOy1faiblXRAavpM9j2cQfwWpBz1Q+I/L+cTk0fQZmHBDk3DjRwiLQS
 CCsA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=kE4+cD4A; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Au0Nh5yr
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kE4+cD4A";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="Au0Nh5yr"; 
 dkim-atps=neutral
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
From: Jorge Ramirez-Ortiz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

OP-TEE computes its RPMB authentication key from a device identifier, so
U-Boot must hand it the exact same identifier the Linux kernel uses;
otherwise the derived key differs and OP-TEE cannot access RPMB secure
storage provisioned under Linux, and vice versa. The OP-TEE RPMB probe
also needs each region's size and reliable-write count to discover which
regions exist and how they may be written. Provide both so OP-TEE secure
storage stays interoperable across U-Boot and Linux on the same device.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/ufs/Kconfig    |   7 +-
 drivers/ufs/ufs-rpmb.c | 148 +++++++++++++++++++++++++++++++++++++++++
 include/ufs.h          |   6 ++
 3 files changed, 159 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 99160a0819b..d39fcda42dc 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -95,11 +95,14 @@ config UFS_TI_J721E
 config SUPPORT_UFS_RPMB
 	bool "Enable UFS RPMB (Replay Protected Memory Block) support"
 	depends on UFS && OPTEE && !SUPPORT_EMMC_RPMB
+	select BLAKE2
 	help
 	  Route OP-TEE RPMB requests to the UFS RPMB Well-Known LUN using
 	  SCSI SECURITY PROTOCOL IN/OUT commands. Required for OP-TEE secure
 	  storage (CFG_RPMB_FS) on UFS-based platforms that have no eMMC.
-	  The OP-TEE supplicant handles a single RPMB transport, so this is
-	  mutually exclusive with the eMMC RPMB supplicant (SUPPORT_EMMC_RPMB).
+	  BLAKE2 is used to derive the fixed-length RPMB CID that matches the
+	  Linux kernel UFS device_id ABI. The OP-TEE supplicant handles a
+	  single RPMB transport, so this is mutually exclusive with the eMMC
+	  RPMB supplicant (SUPPORT_EMMC_RPMB).
 
 endmenu
diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
index fb4cd42ad75..ed5ecc0a5e6 100644
--- a/drivers/ufs/ufs-rpmb.c
+++ b/drivers/ufs/ufs-rpmb.c
@@ -1,10 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0+
 #include <dm.h>
+#include <hexdump.h>
 #include <log.h>
 #include <malloc.h>
 #include <scsi.h>
 #include <ufs.h>
+#include <vsprintf.h>
+#include <u-boot/blake2.h>
 #include <asm/cache.h>
+#include <asm/unaligned.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include "ufs.h"
@@ -25,6 +29,15 @@
 
 #define GEOMETRY_DESC_RPMB_RW_SIZE	0x17
 
+#define RPMB_UNIT_DESC_LOGICAL_BLK_SIZE		0x0A
+#define RPMB_UNIT_DESC_LOGICAL_BLK_COUNT	0x0B
+#define RPMB_UNIT_DESC_REGION0_SIZE		0x13
+#define RPMB_UNIT_DESC_REGION1_SIZE		0x14
+#define RPMB_UNIT_DESC_REGION2_SIZE		0x15
+#define RPMB_UNIT_DESC_REGION3_SIZE		0x16
+#define UFS_RPMB_LEGACY_SPEC_VER		0x0220
+#define UFS_RPMB_REGION_UNIT_SHIFT		17
+
 static u16 rpmb_frame_request(const void *frame)
 {
 	const u8 *p = frame;
@@ -171,3 +184,138 @@ static int ufs_rpmb_read_geometry(struct udevice *scsi_dev, u8 *rpmb_rw_size)
 
 	return 0;
 }
+
+static int ufs_rpmb_read_region_sizes(struct ufs_hba *hba, u16 spec_ver,
+				      u8 sizes[UFS_RPMB_NUM_REGIONS])
+{
+	u8 unit[QUERY_DESC_UNIT_DEF_SIZE] = { };
+	int ret;
+
+	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_UNIT,
+				     UFS_UPIU_RPMB_WLUN, 0, unit, sizeof(unit));
+	if (ret)
+		return ret;
+
+	memset(sizes, 0, UFS_RPMB_NUM_REGIONS);
+
+	if (spec_ver > UFS_RPMB_LEGACY_SPEC_VER) {
+		sizes[0] = unit[RPMB_UNIT_DESC_REGION0_SIZE];
+		sizes[1] = unit[RPMB_UNIT_DESC_REGION1_SIZE];
+		sizes[2] = unit[RPMB_UNIT_DESC_REGION2_SIZE];
+		sizes[3] = unit[RPMB_UNIT_DESC_REGION3_SIZE];
+	} else {
+		u64 region = (get_unaligned_be64(unit +
+					RPMB_UNIT_DESC_LOGICAL_BLK_COUNT)
+			      << unit[RPMB_UNIT_DESC_LOGICAL_BLK_SIZE])
+			     >> UFS_RPMB_REGION_UNIT_SHIFT;
+
+		sizes[0] = region > 0xff ? 0xff : region;
+	}
+
+	return 0;
+}
+
+static void ufs_rpmb_string_to_ascii(const u8 *raw, char *out, size_t outsz)
+{
+	int nchars = ((int)raw[QUERY_DESC_LENGTH_OFFSET] - QUERY_DESC_HDR_SIZE);
+	int i, n = 0;
+
+	nchars = nchars > 0 ? nchars / 2 : 0;
+	for (i = 0; i < nchars && n < (int)outsz - 1; i++) {
+		u16 c = get_unaligned_be16(raw + QUERY_DESC_HDR_SIZE + i * 2);
+
+		out[n++] = (c >= 0x20 && c <= 0x7e) ? (char)c : ' ';
+	}
+	out[n] = '\0';
+}
+
+static int ufs_rpmb_build_cid(struct ufs_hba *hba, const u8 *dev_desc,
+			      unsigned int region, u8 *cid)
+{
+	char serial_hex[QUERY_DESC_MAX_SIZE * 2 + 1];
+	u16 manf_id, spec_ver, dev_ver, manf_date;
+	u8 serial[QUERY_DESC_MAX_SIZE] = { };
+	char idstr[QUERY_DESC_MAX_SIZE * 3];
+	char model[MAX_MODEL_LEN * 8];
+	u8 raw[QUERY_DESC_MAX_SIZE];
+	u8 blen;
+	int ret;
+
+	manf_date = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_MANF_DATE);
+	spec_ver = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_SPEC_VER);
+	manf_id = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_MANF_ID);
+	dev_ver = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_DEV_VER);
+
+	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_STRING,
+				     dev_desc[DEVICE_DESC_PARAM_PRDCT_NAME], 0,
+				     raw, sizeof(raw));
+	if (ret)
+		return ret;
+
+	ufs_rpmb_string_to_ascii(raw, model, sizeof(model));
+
+	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_STRING,
+				     dev_desc[DEVICE_DESC_PARAM_SN], 0,
+				     raw, sizeof(raw));
+	if (ret)
+		return ret;
+
+	blen = raw[QUERY_DESC_LENGTH_OFFSET];
+	if (blen < QUERY_DESC_HDR_SIZE)
+		return -EINVAL;
+
+	memcpy(serial, raw + QUERY_DESC_HDR_SIZE, blen - QUERY_DESC_HDR_SIZE);
+	bin2hex(serial_hex, serial, blen);
+	serial_hex[blen * 2] = '\0';
+
+	snprintf(idstr, sizeof(idstr), "%04X-%04X-%s-%s-%04X-%04X-R%u",
+		 manf_id, spec_ver, model, serial_hex, dev_ver, manf_date,
+		 region);
+
+	if (blake2b(cid, UFS_RPMB_CID_SIZE, idstr, strlen(idstr), NULL, 0))
+		return -EIO;
+
+	return 0;
+}
+
+int ufs_rpmb_get_region_info(struct udevice *scsi_dev, unsigned int region,
+			     u8 *size_mult, u8 *rel_wr, u8 *cid)
+{
+	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
+	u8 dev_desc[QUERY_DESC_DEVICE_DEF_SIZE] = { };
+	u8 sizes[UFS_RPMB_NUM_REGIONS];
+	u16 spec_ver;
+	int ret;
+
+	if (region >= UFS_RPMB_NUM_REGIONS)
+		return 0;
+
+	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_DEVICE, 0, 0,
+				     dev_desc, sizeof(dev_desc));
+	if (ret)
+		return ret;
+
+	spec_ver = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_SPEC_VER);
+
+	ret = ufs_rpmb_read_region_sizes(hba, spec_ver, sizes);
+	if (ret)
+		return ret;
+
+	if (!sizes[region])
+		return 0;
+
+	ret = ufs_rpmb_read_geometry(scsi_dev, rel_wr);
+	if (ret)
+		return ret;
+
+	if (!*rel_wr)
+		*rel_wr = 1;
+
+	ret = ufs_rpmb_build_cid(hba, dev_desc, region, cid);
+	if (ret)
+		return ret;
+
+	*size_mult = sizes[region];
+
+	return 1;
+}
diff --git a/include/ufs.h b/include/ufs.h
index 1bec3ce73a4..a8b7d370f78 100644
--- a/include/ufs.h
+++ b/include/ufs.h
@@ -20,8 +20,14 @@ int ufs_probe(void);
  */
 int ufs_probe_dev(int index);
 
+#define UFS_RPMB_CID_SIZE	16
+#define UFS_RPMB_NUM_REGIONS	4
+
 int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
 			  void *req, unsigned long reqlen, void *rsp,
 			  unsigned long rsplen);
 
+int ufs_rpmb_get_region_info(struct udevice *scsi_dev, unsigned int region,
+			     u8 *size_mult, u8 *rel_wr, u8 *cid);
+
 #endif
-- 
2.54.0

