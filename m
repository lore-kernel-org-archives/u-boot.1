Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDF5D68BDD
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 06:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF29483CEE;
	Thu, 18 Dec 2025 07:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gKCodGpk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JH9KnJsM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DA7583B55; Thu, 18 Dec 2025 07:16:37 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BCD083CE3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 07:16:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BI1YPj54189407
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 06:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hKwvEqjYm/J
 uBROJ3kMWVcoO2T9r2D6qTXRDYp6DPE4=; b=gKCodGpko5IMPu8QFf9Z/JNvujF
 l+AsHL1bSt3g2CfUItjJCESqI8bg9uw5HsRu36F7GO/ke3+9/YRTc79OrSOE3LvH
 8GEWlTHCnFVYX1jN1/uFSSrpgzaXekBM+XdDKVHQe2N2ssxEhdRrj8Vp7wwUe/HE
 9lLykWBj9pS6lUWO9c+XTiqOH1S9Alhgj11GW/v5UYxO8eCOBfWddpoJ1A9oQ3Cf
 PztIwcz8HHKkM8X1x42WM4Jt16TNGvWU/3ldoh7ETaZOIGjgTC9evrQyKWCybbWn
 3ozOPGNXeCGQV4BhOpM5YnxjUYhCpsr3J5IghGjXLFj4WU4YWAm+aefFYww==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b47pkgqtj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 06:16:33 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34c43f8ef9bso1338269a91.1
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 22:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766038593; x=1766643393; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hKwvEqjYm/JuBROJ3kMWVcoO2T9r2D6qTXRDYp6DPE4=;
 b=JH9KnJsMPiLoFNxBi4L4yZfnnEQ21U4mLtutMWiFQSvb3D96++sQ1GDPaM0ewiRSkK
 luQQfFK3ih5924vfPyBjBdf/W+r4gqFfAxVOXDKeaOZG+f0q5GitrVUdAOP8n8kP4jxy
 qL5fN7KiotKmQ2zO+XnRhHha0QXemHSpUng6tVx4PzsDgJTpzyoGkGeRXDtyj0AwNnM5
 9osKPQpKI/cEdf5HBIgk+0RxE9kBGHWrYTO+xiOgoAeISKPaaRshkauRy42tOaimxOYS
 rZOJOWDDB6W9f9OWTccZFfHgfg2OqPuUdonJVTtEUqwGo/yP1iU+4quAh0RGkP5pAe0j
 8Tpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766038593; x=1766643393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hKwvEqjYm/JuBROJ3kMWVcoO2T9r2D6qTXRDYp6DPE4=;
 b=sPmBOMhzfuR8DRfiRrNoui/AGUlsPZBvwD8KPR2BKudCI+itT2El+ehgj+G475PDQA
 VD8tdCPJ7LINLesiV8a1jDxq1ZiiON84/9QnODeCkGsUU7lSMlTOTlsOAG5eYshQxNmr
 ZIVe+N6CKA/E/RWGZyRuUSd7Oejmv01TkUoJJHEootN4h8NJPUGAI4NK0L2cVdnBE7lW
 RTV6+bG/FEE1JKzlG7akfA5bYthFy8ClJsf3PXFjy709n6c6Ef66ogSf3GBI99bTQs6M
 eF9MVZ40UxOGYzb9uR+/MJ4lvU6J44dfy75BIDbo6kW5ANuXMDuvLcwxw8iLF5+37FWO
 OecQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdyhMwdc43JPYjSDKTGg9FbHf5LjAdtZdPVV/DfSvuhE0h5nBxzP2in4XrCs5E8wHrnBfSQXc=@lists.denx.de
X-Gm-Message-State: AOJu0Ywid6oPZ78asGIkirtbKKiETpOewDb2agJYyZyD4pc/jD5XMyli
 C+NQK5i+l/z1v7WBIhs473+hNzBEcCNZ3fJaTKJ5vlP2WWJAGKVUrgK/9lGS6sZSu9Pl7jBvwOd
 OF8OOfkMBSIDXhTlwNCpS29ZLpi9UodbtXpnoBvZbLuSdAlAsz1IMFWlsEUO4mHJF
X-Gm-Gg: AY/fxX6ckBGAaNTI0HoN5paA5mBfH7ctzDf69GPMJrr9GXa765PRAELeHvldlhXq2ze
 cejFdpgStAQurg9OBvZFGhyrfW1hfmCva2S8q8L6qSAN/87Acp8izX6U4WGm9BesEuGV54Boogz
 px5c+UdIoM/0WaRUr2IFzRZXuxsG4xrdAOKytIvJAu/ItIXBMFtxGT6DSKxmc7tZ3GxL24Tkm7Z
 htzuKPhDkIgy9rA7jvwwvaFFMLRv0/wxk7dTZFrcG/5qEZE8x4xcKzmCUJQMtRuewsI9R+M/DvQ
 v6l09xeaw1tP8+6vjdEL3JgIkgSqE2tL9kEF/jYUXsj+a9Fnps00bNSNhxcOfyhQjmuChLNbikE
 IK7M4Hs4FyBLvPSorxzmJX9F2WRrmrrCUZF9tpuOssPLhHS2vDcx4bJFGDJ3D+4QPVJmufHeES6
 /RxrTD/PDxus0hsZcDcDAC9/j5Nj5v6NCgw/YWmfs=
X-Received: by 2002:a05:6a20:72a8:b0:375:4503:ef0e with SMTP id
 adf61e73a8af0-375520c5881mr2395984637.14.1766038592582; 
 Wed, 17 Dec 2025 22:16:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhGc95L62zY6Ve4HlEniptQFsMZD49JiGvQZgqUStmlOKxKniBV4h16V8KuINdK6eyx17/yg==
X-Received: by 2002:a05:6a20:72a8:b0:375:4503:ef0e with SMTP id
 adf61e73a8af0-375520c5881mr2395952637.14.1766038592094; 
 Wed, 17 Dec 2025 22:16:32 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1d2fa228b5sm1198995a12.18.2025.12.17.22.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 22:16:31 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, varadarajan.narayanan@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 alexeymin@postmarketos.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [RESEND v2 6/6] doc: board/qualcomm: Update RDP flashing instructions
Date: Thu, 18 Dec 2025 11:45:57 +0530
Message-Id: <20251218061557.1999367-7-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251218061557.1999367-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20251218061557.1999367-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: eZC9eMUIofvE3iHERdyfsUotgzV8bEV_
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=69439c41 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=r5MC_wQ6cbKlY4jr-AgA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA0OSBTYWx0ZWRfX1piFCj2vkZhh
 OVjTeb4nWHnWt3i50PEysPx2khtE6q/isInG66C/RRooCM/DtgK3yXJbzia8BZfBqB330AJ4lPO
 MtKtGXUe0YgHCcnHIkk4qaNSXP6lD9YVCHAm0+uqMm9sg/YeEJkam3e/QEnEXvSEDJ8Lcca7yvP
 Jmuq7/XGxxicIvtrHqttSnAxenLk5V8YTMNt4RxBkydOoMa/R0JKyXBu53e0/dDRKiXsRwwatRA
 Bexr39OjElBZb1MSDEchtILXl4+SagUSVqhZXyX+iRP7lbaEK7JkalzszXWHh6gJ0vlGniIz2qr
 pdjvl/ZpbXTR00wUDba4doFLxnnzHPfLvfqmPI/Aua/xLjFR0A1YycVtv/+IEczMFY04oD2LuPa
 RupQV7z7+bX6dA9Gxpg03V50am0DMQ==
X-Proofpoint-GUID: eZC9eMUIofvE3iHERdyfsUotgzV8bEV_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180049
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

Update the flashing instructions to include fastboot.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 doc/board/qualcomm/rdp.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
index 99cf8eba57c..97a64e4677c 100644
--- a/doc/board/qualcomm/rdp.rst
+++ b/doc/board/qualcomm/rdp.rst
@@ -42,6 +42,20 @@ on your device with::
 
 U-Boot should be running after a reboot (``reset``).
 
+This U-Boot doesn't have the n/w driver. To restore the original U-Boot or flash
+modified versions of the above built U-Boot, 'fastboot' can be used.
+
+  => setenv serial# ipq9574
+  => fastboot usb 0
+
+  C:\>.\fastboot.exe devices
+  ipq9574  fastboot
+
+  C:\>.\fastboot flash 0:APPSBL u-boot.mbn
+  Sending '0:APPSBL' (620 KB)                        OKAY [  0.042s]
+  Writing '0:APPSBL'                                 OKAY [  0.030s]
+  Finished. Total time: 0.342s
+
 .. WARNING
 	Boards with newer software versions would automatically go the emergency
 	download (EDL) mode if U-Boot is not functioning as expected. If its a
-- 
2.34.1

