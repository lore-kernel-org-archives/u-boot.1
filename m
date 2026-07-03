Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE15FC43602
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 07:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E98E0841F2;
	Fri,  3 Jul 2026 09:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="N0eFrAg+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZoRd+Coj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB7F4843B6; Fri,  3 Jul 2026 09:24:28 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 614348407E
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 09:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635rZoD3136095
 for <u-boot@lists.denx.de>; Fri, 3 Jul 2026 07:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=y6RjbY0JVZBwFgmTzxUHGZ
 ZKI5VdwsMzwugOnCFvH5E=; b=N0eFrAg+ktdnWN8ULZr7JKN1kqP+eht/17lNfT
 XU8M3kE0GjVYdrppC5IqOH6X+HFbf4zHMkAvRfcqEP7ZQuPBk744yX0t9Tt41J6P
 DZYC0ou1jbEr1Qt3ATDaBVg1Vx2jsEjtXMuTEKECVosYozJ37LhsNKokIoUCIG4M
 NQ4hXBbfFNXhPMU/kW0I3/YLw6rb+dKlIGXP4Sqme1clE/nLGiLFUc8La/KX93/n
 tPGBFMRm3eTMUWoyOqETQDxtSjK+aVees/F6f64KMR8euiMfWpnpf/KMYbasftc5
 LKuU98CmkuuPLPgINSCnhjf2KW4nk2wO3xakruiTtzK5YRmQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b5964t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 07:24:24 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-37ca4367860so1735792a91.1
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 00:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783063464; x=1783668264; darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y6RjbY0JVZBwFgmTzxUHGZZKI5VdwsMzwugOnCFvH5E=;
 b=ZoRd+Coj/2pnMDBabNDhGPuuEG75GWlff5+oO0dnBh11o7qpDFp3sSeUPm17JWxZnk
 KhxzZaEnArD+g7MkPOziAX9+AI9SzWAmteUUZij0UNVwzNj8/jQtR4VftFBl904HuMNx
 v4481IbvpsP5TZVNv7kNcGdur6urFZkaQsGINanpGwlFQqrXfD0+ECj3XJ/lg+h+N8TD
 jHLFogh+A0tzYgqYoGaVIc/UtxmKrsWeok/uYWK7rwDJeDNWvsI7y424Na6/qgshXYYn
 08IFS3xhBNtJPGANGm/chn4ckRBfbowFLq1mcfye0yJu0DZ6roC14TmX21Hx+x2dJUGI
 NAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783063464; x=1783668264;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y6RjbY0JVZBwFgmTzxUHGZZKI5VdwsMzwugOnCFvH5E=;
 b=Dbbc4abc9CeSJ86FoTbBqiadygUplsKntB9ler1jpkWSYjVGibH0xh1ILa7TUF+//f
 gLqfySBK8jx1mRPOsHD03j0jxMhJBhKvWYPLL3OMEetGeHTprr+hRxAHc575DEPK6EUK
 y7glDZE9Bkn6C1/Qy/aOW0SZzTqW4vqbu0Lr4JzU+Bhj3uvs2i2q0xqNh68UHRcfo973
 +DR/WWRaOQrXjmP+VrxQWabHsWbkrpYTOI7A5UduCP2nZvR3/6dAYt5lCSKWX4LSpg2I
 /jX3BkZle/tWyoSzpYDLRAlofcIcKW37VmSglAg7xe1ehaf7R/W67yur3FlULisyZPHM
 qVfw==
X-Gm-Message-State: AOJu0YzSbchOcP74lIe0BE4vHjlnMITuRcrpYu4ZKswEcOldfesmcfjc
 UvKyn7lCh0MWDmO5jrLAxvLHLq9A99KTe1BQB6idmpw7OO/jxQoKXpdmon2kLcjGCTUgUJ4CZEl
 x6E0+4kIkO8YePtbg1F12o1l6MHjqP+zr0PCLvqEtE1pX0jhjpbWJAoRJ
X-Gm-Gg: AfdE7cnsjdggyHewnIH1TOvW5xSCqYPQw/Pu7S1bjuARDK4oKMp2iD8zHcb+lP98CIN
 xB/xrVtQhjzCJ/TzQMX5ded9s3iy//FZwJYwU4WDjpfkTFPqHiOADt1EWwYYjtBkoC09zOWimA6
 VmmM6vTQhubz/B75y+5VybSwPhFanXNVKblJcy5YWNG9UZAnx4TRfcgzYNhxEThU8DwCwgFgFzT
 QloY0ErCDO8WR6FTjfymaWKqV+r/anfc33HfR89DCN/SAJ1ScqfeXP7Io257I0LdsybT16JPhK+
 YnPVIFtXD1w6PlwEXcpShMRmtRwA4+klwVWfmBWVWrcwvLxvbljE0FJocTz+vMNUyBiyIUYxK8N
 7oqcS3t2QNEZXNPZN2uzvoLgM6R4Oq5vHYrM4L1+krBxFMYqx4xBXr6kN2akOmVsXX18LaeTGuy
 w8zNbVgwaSBRS5DCwkceS48BoDI1SZEKHu6kiwyX9l
X-Received: by 2002:a17:90a:e70c:b0:380:ce69:2669 with SMTP id
 98e67ed59e1d1-381122ebda9mr3562399a91.9.1783063463741; 
 Fri, 03 Jul 2026 00:24:23 -0700 (PDT)
X-Received: by 2002:a17:90a:e70c:b0:380:ce69:2669 with SMTP id
 98e67ed59e1d1-381122ebda9mr3562362a91.9.1783063463089; 
 Fri, 03 Jul 2026 00:24:23 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bc3ea61sm18255307eec.30.2026.07.03.00.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 00:24:22 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 12:54:17 +0530
Subject: [PATCH] drivers: sysreset: Do not end sysreset_walk_arg on
 -EPROTONOSUPPORT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-walk-arg-fix-v1-1-64beca00d7e2@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKBjR2oC/yWMywqDMBAAfyXsuQub2KTgrxQPaVzt0qrtxj5A/
 HeDHmdgZoHMKpyhNgsofyXLNBawJwPpHseeUdrC4MgFulCFv/h8YNQeO/mjTzaciSg566EkL+W
 i9921OVj5/SnX+ZBwi5kxTcMgc226QL5NzJYqaNZ1Aw9nX6ONAAAA
X-Change-ID: 20260703-walk-arg-fix-5c164000c215
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA2OCBTYWx0ZWRfXyGMOg0P4fRpu
 hOY02hwNtVvg4FW6m1RJcB5vb8ayC2UnLWc05lBJSq5kMJ+GbuHDXvrtkDlPtHsxC5scdLc8JuK
 NN8wy1ZhF65fhvBmQeRGD9WzV8AK/Mc=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a4763a8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=onCYJMBbk8cerVHNQbEA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: zMKC8m-t-gc_1xLhDXjIBopMeprcq7HT
X-Proofpoint-GUID: zMKC8m-t-gc_1xLhDXjIBopMeprcq7HT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA2OCBTYWx0ZWRfX43Jh9WfKplvu
 nbc9G1FjlzeTNM70ThcIRK05VdI2VkNZIj1atnl+kQozRBJr9TbUeJqYCRsqXSiESqupiG+1LMM
 S5CNwMIX+5rXYghROPul5OU5suA4eUYUEVzcVr0jBMTKGXLYoXx3Eo7Yqs1C41D3+DIqXcNGtsw
 /BiWujpYYUId1Uh8JwLMcNz0ARK6gPChaF18XgxYLW0xoeSDKtZhOpeatfpA4LB/PHc/US+ZX5z
 uWzfygYaS16QrSdhoMqsVSPvyyp+YGBTuvzK8DFcFQi5rMq5Z+NB020ymlsRBnJ+vfabQ/nTPnL
 VuQD4w7a6GIooRzioSBRLFqU7RpoAfrdQ5TpPSbbm9uk4ilFrKBd9li38HpOloddefD/QcKLvRu
 os/gUC4wHTRrE0hP3vW473ufE98niFw/zApfvigAnlb82oQDW/BZrLeOHya2Daa5lP52TYhjpsP
 lSBtmOFAwBVVelpoHlg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030068
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

If there are multiple sysreset devices implementing request_arg callback,
the first sysreset device will consume the args and may return
EPROTONOSUPPORT if it doesn't implement the given argument. This will stop
the loop.

Since -EPROTONOSUPPORT is used to indicate absence of support for that
argument, subsequent drivers should be given a chance to see if they handle
it. Hence do not terminate the loop on -EPROTONOSUPPORT return code.

Fixes: fcb48b89813b ("drivers: sysreset: Add sysreset op that can take arguments")

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/sysreset/sysreset-uclass.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index f25e09e9cd0..0fc096e7f0f 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -89,14 +89,12 @@ int sysreset_walk_arg(int argc, char * const argv[])
 	struct udevice *dev;
 	int ret = -ENOSYS;
 
-	while (ret != -EINPROGRESS && ret != -EPROTONOSUPPORT) {
-		for (uclass_first_device(UCLASS_SYSRESET, &dev);
-		     dev;
-		     uclass_next_device(&dev)) {
-			ret = sysreset_request_arg(dev, argc, argv);
-			if (ret == -EINPROGRESS || ret == -EPROTONOSUPPORT)
-				break;
-		}
+	for (uclass_first_device(UCLASS_SYSRESET, &dev);
+	     dev;
+	     uclass_next_device(&dev)) {
+		ret = sysreset_request_arg(dev, argc, argv);
+		if (ret == -EINPROGRESS)
+			break;
 	}
 
 	return ret;
@@ -153,6 +151,7 @@ void reset_cpu(void)
 int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	enum sysreset_t reset_type = SYSRESET_COLD;
+	int ret;
 
 	if (argc > 2)
 		return CMD_RET_USAGE;
@@ -165,8 +164,12 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	mdelay(100);
 
 #if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
-	if (argc > 1 && sysreset_walk_arg(argc, argv) == -EINPROGRESS)
-		return 0;
+	if (argc > 1) {
+		ret = sysreset_walk_arg(argc, argv);
+		if (ret == -EINPROGRESS)
+			return 0;
+		log_err("No handler for reset command arguments (%d)\n", ret);
+	}
 #endif
 
 	sysreset_walk_halt(reset_type);

---
base-commit: f605dcee103c897b6f1a8873549a36949bd4e2a1
change-id: 20260703-walk-arg-fix-5c164000c215

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

