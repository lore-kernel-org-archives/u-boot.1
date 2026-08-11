Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C82C5AD7B
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 05:19:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9903B80EF9;
	Tue, 11 Aug 2026 05:19:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LEZOpBtAXGIk; Tue, 11 Aug 2026 05:19:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A17B80EE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786425576;
	bh=kKJTntkplHPGxrMCcgbSnOump43Ipg1d9tw8aCiY8nQ=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=eSxiDslT1Z19LP8NtfGX69+r70lLlwwAx95Cq6CW5C5Ym/0iViXD62yz0W1+YkYYX
	 Miek+9yVBZWGUK33dJipqDHQuAibAnZdqqlFydnd/rAw5hmj1+wTxi7aXSyr7LMSFF
	 AHzir9pNgDfl70C2aWiKxMqSdf9U3UXAosjq2uA3SCaIrpb5EekbRv846sf6+1VAxM
	 rYBZ616oJ1WLkB41oadZowWCkHTfJmb0FAZuOIlm1XoxVSu7L2VO9COEMLfU89C0TV
	 EV8ssKoVjQc/XBksACejLPDU8umJaPftaAizomL4rRWCSD6oW0iF2wgcaObMBUShV8
	 8hXU9Mk4ka8FQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A17B80EE7;
	Tue, 11 Aug 2026 05:19:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 74B48282
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7252E60634
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mAx9wxW4GlKK for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 05:19:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5D3CC60629
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D3CC60629
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5D3CC60629
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:34 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AMpudM1751848
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:33 GMT
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fycgev7k8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cee894b3d8so49411945ad.2
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786425572; x=1787030372;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kKJTntkplHPGxrMCcgbSnOump43Ipg1d9tw8aCiY8nQ=;
 b=EezN+0FnafLKIbZ7ChZYxoIeu39gMz35/gAwuXjPMOGAMgE1bGnpZgP59OcN3FDiHw
 Qgr6GGSWBIlK8CBysQDkZF/SVHrxmLKw4bRK7cVM9FyGL3QgeLOygP/E1w+Hr0TMFY4n
 +JVRqSg1WaQ9Gbn6yzrGAEQ0IqYcW+/NE9skVeAaBGqdafamAUBBV/c/W0jA+YFCE+FP
 VXJ4DEJTkKuftkgmoBgPNgd/7YCXhvIBQQtEWkf0UokkVjOcmoSwHAcVYLkF4ejlaHJK
 ENzwpu4k+phn8LX2T7k+HxGh28esdOP4gus8szL6U9XKFeESl5hAUizPIJjGutjXsruf
 lCDw==
X-Gm-Message-State: AOJu0YwTNAmzQjDlGZFWsV46UdR9rECbAnSKLjIB2RnFDpPlu6fcuT1/
 XsIDBVMC99DN9p9azyO5RrL6J4splmt14EyQiR8oEIWrCKPJUtua0ChfNYHfJRlkZDO5PUzk2CQ
 snxGzZyHJQXnANgBY+h7l84onTwKobGx7MCzD7JI+dYHrzlEBmUojZbCeB0azIyeQ/VtYDPc=
X-Gm-Gg: AR+sD1088fJ2WjUVtZ5aXDX832NHTOkbte35taLWjymYdkbE3pHsdHXwVeED+uuQqu1
 PNRCyPOAn/RNWSrZNs04W8BfB6CgGTZpsREjKxgm9h3tcMReN5eOyDiNjwwU+oz8NpN+OYwAXJQ
 GX0d0mnzKg0DJes31Uwp8dH3OW/EGZwAbNWr1nLQiNWu+EonuuDAgsGX3y6M0HPQx7+SU2Oci6I
 gLu5cTyiGcMDWvv1U9TqM3kIggP/55WGVGMPy3U2cQbSb1L4TGLh9aaNtSmeIFj2g3zUQyMOJqY
 UIUWHgRhqTTqd/LSq3xCuJ81SDiU9YXZa90Rhj9R0QHcveGwvjvzN6rO/EfrkZttIOZc+K4AyP4
 jPMcXA+mzFF4WiwLa9WqTZDpCb9ugHtrMBKbgC+gUMKMtP4G9X1oX9y9LhcV03eZa5gz/UNQepw
 09waVP5/rG9eF3ggGIK6SclpPdmAhh
X-Received: by 2002:a17:903:1ac4:b0:2ca:20b1:3e0a with SMTP id
 d9443c01a7336-2d31776099bmr11679665ad.3.1786425571891; 
 Mon, 10 Aug 2026 22:19:31 -0700 (PDT)
X-Received: by 2002:a17:903:1ac4:b0:2ca:20b1:3e0a with SMTP id
 d9443c01a7336-2d31776099bmr11679225ad.3.1786425571429; 
 Mon, 10 Aug 2026 22:19:31 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31c619d01f8sm1353804eec.2.2026.08.10.22.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 22:19:31 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:48:39 +0530
Subject: [PATCH 4/8] cmd: reset: dispatch named reset modes via the
 reboot-mode framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-b4-reset-edl-rebootmode-v1-4-2e15adc156a3@oss.qualcomm.com>
References: <20260811-b4-reset-edl-rebootmode-v1-0-2e15adc156a3@oss.qualcomm.com>
In-Reply-To: <20260811-b4-reset-edl-rebootmode-v1-0-2e15adc156a3@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786425541; l=3092;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=YDBFLvMYNlHePcTOKGjvxVx/RgUBZ/DWlUrundTRgsc=;
 b=KYKvZztGGAonGEWIZd+lCFvPqCHRr6ohdh2/8TZFkGJcx7BLloFWFRVNPT8ZxqdBffsbcpTLs
 pDfCjbj2h9xDGWLvvcFhWX2Nhw6IiqEuM9MgBDkCJuLtbqrLJK307bp
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: eFqVoUobyqx_FxhFaPKyC-4sEcTCxQyf
X-Authority-Analysis: v=2.4 cv=R4cz39RX c=1 sm=1 tr=0 ts=6a7ab0e4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=tJsu_mfpyVYTNSKLC-8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: eFqVoUobyqx_FxhFaPKyC-4sEcTCxQyf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA0MiBTYWx0ZWRfXyH4rt6cLygqr
 BWTxa/4rUrMt4Qc2db9S3L3mI+R/6Rw2JBaU8C+xozbQYAnZ3KvG6GmMHWwkOGm3iPKk/GXxZ2y
 n44w04Qw7crOwFP7SqSaSsjxYypucc8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA0MiBTYWx0ZWRfXz1dX62q2D7iU
 ktg0J/ECBdM6Tafztee3OxN5/VtLXNTZkc679DloMDDoJrMWXmqQVNINUGoSL4mFZkr7z1oqWSA
 xTHf7NrR8mL8hWILXr2ns3OflPuVCAlSKK+KjmxfCTGON+HcGrO/zWWMTz2Lt70JStoN7NoHY2s
 Sn4PfEpB/J3WXPuxArvKxVplBMBJL7Rpd4DWrs1b6vNQVWTjPJu595nmzq3Xr+dm6X+RRQqWB3m
 7viG1it7KFLbpg7PV1R36OnixuSVTN6JlWzyD835O4drX9QdbrdoFNQGzakJFGY8liVcuXKr8Wr
 rH3wfq5DAO0rA5mzjwvmiunn8CCUxEAOzWRlt60eMJFgEW5ItL7VIv/wcBn48K6BzvCsF+r3J8C
 JRlK1YPjVyxxGVcnRFNvI/HgQs7xgyOlJP5Fjlve9zmUvH+D28LN67PNccOyW1fjshYK2UalXIA
 erB0T1qYoTCemQm5y/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110042
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kKJTntkplHPGxrMCcgbSnOump43Ipg1d9tw8aCiY8nQ=; b=jfqri6cnGAbKc3ZR
 0P3AUl/698J2mMYG9RvXJ04D2hcevTWus5A0Ru8KcXX/768OT+WNybXy7D7B5FG7
 +VsP1mO/WmrBmWmf/pFKokAPx93wkaTM9hi9fVs7y7T0QWz9reQI+58CD7l42+fW
 9/TwBAL8p0dcGaD206dTus/ovoh8UOGgleKr9oPDEC6x5Dpr5+5YRb7r/NrbRnOA
 NopWATbSOlNuGUJfwbxyi9RnxuCdrGPbpfd2IkKa1nyODgRhXF263ObKLOQeEnd7
 J+7Hb4bsG3GvHrjCQJzp4Oohpy3oE2l+3cSjfJkxSowXIutwTWHo6XQlg9uRVkNy
 EK30nQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786425572; x=1787030372;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kKJTntkplHPGxrMCcgbSnOump43Ipg1d9tw8aCiY8nQ=;
 b=kcH1/yx3qNXIYSc85hA6153s1sXt1R0T3zPESYpGJox3ZzyoxOMuXwD5Y86iRj+Pzl
 sG4G1Wbtl+/zHA1RD1D4W2CkgiXzUHV+fYSwwE4fcaah4qGUdq263ar2fJ4sm37v2n7M
 4WV5kKoHKXtVD+XK5bz7OeYo7bB5rtharQVCpgBPDqCuUYmE0+fd4JodJGwicd53DOKu
 d7DDinm+BPK8gLr9fbd4lGuOTqD7aVkklVKtmfCC9nizYuc0+djpeyDGTWTqLHETjuI9
 2YyE/XHUI9jV18sGQrgnt/IxPgUC2kJCZf0mD5Ep14ykXmEUDY8Zv7eJUJy0dX/sZLlR
 xZOw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=jfqri6cn; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kcH1/yx3
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

Teach the "reset" command to trigger the reset modes registered with the
reboot-mode framework in addition to the existing cold and warm resets:

  reset          cold reset (unchanged)
  reset -w       warm reset (unchanged)
  reset -<mode>  reset into a mode declared in the device tree
  reset -l       list the available reset modes

For example "reset -edl" enters Qualcomm EDL/download mode when the psci
device tree node carries a "reboot-mode" subnode with
"mode-edl = <0x80000000 0x00000001>". The command never parses the magic
values itself; it strips the leading '-' and hands the mode name to
reboot_mode_request(), so the values stay in the device tree and are not
hardcoded per SoC. An unknown mode prints the registered modes rather than
silently falling through to a cold reset.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 cmd/boot.c                         |  6 +++++-
 drivers/sysreset/sysreset-uclass.c | 27 ++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/cmd/boot.c b/cmd/boot.c
index 23496cafdf5..5f89c3ed889 100644
--- a/cmd/boot.c
+++ b/cmd/boot.c
@@ -60,7 +60,11 @@ U_BOOT_CMD(
 	reset, 2, 0,	do_reset,
 	"Perform RESET of the CPU",
 	"- cold boot without level specifier\n"
-	"reset -w - warm reset if implemented"
+	"reset -w - warm reset if implemented\n"
+#if IS_ENABLED(CONFIG_DM_REBOOT_MODE)
+	"reset -<mode> - reset into a mode declared in the device tree\n"
+	"reset -l - list the available reset modes\n"
+#endif
 );
 
 #ifdef CONFIG_CMD_POWEROFF
diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index 536ac727142..960d8ddac23 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -13,6 +13,7 @@
 #include <hang.h>
 #include <log.h>
 #include <regmap.h>
+#include <reboot-mode/reboot-mode.h>
 #include <spl.h>
 #include <sysreset.h>
 #include <dm/device-internal.h>
@@ -125,8 +126,32 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (argc > 2)
 		return CMD_RET_USAGE;
 
-	if (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'w') {
+	if (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'w' &&
+	    !argv[1][2]) {
 		reset_type = SYSRESET_WARM;
+	} else if (CONFIG_IS_ENABLED(DM_REBOOT_MODE) && argc == 2 &&
+		   argv[1][0] == '-') {
+		/*
+		 * "reset -l" lists the modes registered with the reboot-mode
+		 * framework; "reset -<mode>" triggers a named mode (for
+		 * example "reset -edl"). The mode magic values live in the
+		 * device tree.
+		 */
+		const char *name = &argv[1][1];
+
+		if (!strcmp(name, "l"))
+			return reboot_mode_list() ? CMD_RET_FAILURE :
+						    CMD_RET_SUCCESS;
+
+		printf("resetting into \"%s\" mode ...\n", name);
+		mdelay(100);
+
+		/* Does not return on success. */
+		reboot_mode_request(name);
+
+		printf("Unknown reset mode \"%s\"\n", name);
+		reboot_mode_list();
+		return CMD_RET_USAGE;
 	}
 
 	printf("resetting ...\n");

-- 
2.34.1

