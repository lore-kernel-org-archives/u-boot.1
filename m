Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F3AC54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 09:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DBA282D4A;
	Mon, 26 May 2025 11:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pa/4xNIZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8DCE82E05; Mon, 26 May 2025 11:43:30 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AFE982D40
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 11:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q9eo0E025751
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=7ZWG0UvbZG6yUZsulc03OXyDWhEYO+pKXXt
 rU7/e0I0=; b=pa/4xNIZB4Y0nLmmE22RI6e5vp/2UGxGm1c+LJb6XBcgSbVZiXN
 4DOs/Nv+3ZZP+Pm++g/OliCpU5zaIMtoE98TdyjJD/xKZSu+p5Q78MCkU5GHUZjq
 FkAODZOgud8llzWG95+UfMUPYCSU6e44ObbQ74DWPf0YQg7ItRrROR+m7HzVj2uk
 jUEH5zWErtoqp7ydVU5NgTFlvDZdYF/fvOuHMBSiTpxKUtyi3FzabARDT4TN6UHQ
 FsA+8ivISxYpP2wR7Jjia2Zt4WHY5BtlMKhDwMkfT2zNy1zqWVS2z39Vcsx9ywa4
 NcIZkas5tjEiEhAltGg6myYXYeDlTG+g9Tg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u6vjkpwv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:43:26 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c5d608e6f5so581525385a.0
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 02:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748252605; x=1748857405;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7ZWG0UvbZG6yUZsulc03OXyDWhEYO+pKXXtrU7/e0I0=;
 b=EObDCv202CW18pocm4nAsvOsVF4vfTRjCDsblCsEElKzimvWsRMciYzv8pwroQ9vW3
 jnCemurcBPLcxZ4IvTuoKW0uY8f3SQLUgNq8RmwSKNHzLv6xrRqc/JKpU71OjewvoBWQ
 LkTPxUgx5EHJzHW1rySdXZ2Y+WZAJ1EQjaxGSWYhe+uyWqIYvnrJaouV0ypXRqIGJP7g
 oHeeQLnjTGBRGpYMM/mmlzgHAFWmAk1RHj/Y1oQtFfzVN8xwf4RYPQf/3UbA+AZQwNlR
 QC/HE8dIwqwRQAHnBo+JFn02Sn47PDRyIueJr9fLym05FXrqyYQcTgFn9TdqUkEEHygw
 3UPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvybdJgOv3sivlCbe1YoV6rp0LMHZyLame4CRt1z+gg149Sp6vhYef7OFSl6URpJEhSqZHWIc=@lists.denx.de
X-Gm-Message-State: AOJu0YzfS0Fv0UcyZJnA4dK/MJmumNumeWoNulwZEEzVQkkEPFDmyyfH
 F39B4lJIN9qHm4a/O+18DrPA/5xMR45cp638uDF76U60eUfvsDprAAHoh0YiFoKL6MGBosBKTWB
 x9/UESz1AwUXM9h7lz6d+ats5uHur8dCJbkS9nCOStwrOXhAOSWs9VLdD
X-Gm-Gg: ASbGnctLkwdElzvLP2Jq8C3tOqsezHz52k/xbMiy+xyCMStWjoJAmUf1YvbN/3ASZIu
 JW5VerHZicHfJXEkVIxcf8RqRo7oUo0YYQ3rmbdfaqnkRyaHM4A/qiIPyQ9DTkqmcVcVj5iCj9S
 sSFpG5uV18fpPy42a4U/JZozo1E2Ooq+Kc0OW6CE7Yv1K9FRuXxtdcQL1xU4WcsJ3FOwCcBzGNU
 B8/L48oLWS6WTkyuh2CxrkRN22rz4lct1bP2kQMJRwZD6pnsbPOzitmLOr9I5XzUPCLm55BPgF0
 woYPFdqIU6tQK2uaqG5O1oEU+yWwuahqGrfJgRr0dL9Ug5Uk2U0WAP/EyFCzMVgrN4aJ6ZcWprV
 MjvNPdQ++/l0bnMG9lvmjN3tqWKcRxUaflxc79Np0
X-Received: by 2002:a17:902:fc46:b0:220:be86:a421 with SMTP id
 d9443c01a7336-23414fb1a6bmr142244755ad.38.1748251923423; 
 Mon, 26 May 2025 02:32:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/eCgDo9zphNxEImaHIDh4jcpfMw+QL3x3Krow/wiKQvKn6Qgj7BUXUY+QoAtoFQ8Ns9MrAQ==
X-Received: by 2002:a17:902:fc46:b0:220:be86:a421 with SMTP id
 d9443c01a7336-23414fb1a6bmr142244405ad.38.1748251923020; 
 Mon, 26 May 2025 02:32:03 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-233ff290d45sm46633845ad.153.2025.05.26.02.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 02:32:02 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, sr@denx.de, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, sjg@chromium.org,
 jonas@kwiboo.se, jerome.forissier@linaro.org, raymond.mao@linaro.org,
 ravi@prevas.dk, hs@denx.de, arturs.artamonovs@analog.com,
 devarsht@ti.com, nathan.morrison@timesys.com,
 balaji.selvanathan@oss.qualcomm.com, bastien.curutchet@bootlin.com,
 ian.roberts@timesys.com, festevam@gmail.com,
 vasileios.bimpikas@analog.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 0/2] Add Qualcomm Watchdog Driver Support
Date: Mon, 26 May 2025 15:01:51 +0530
Message-Id: <20250526093153.3387410-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UOXdHDfy c=1 sm=1 tr=0 ts=683437be cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=ret7OEkzLnChM7SNpeAA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: ChzwBM3dOi2jzoGVJyZAUUF0lrvV88Pl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDA4MSBTYWx0ZWRfXylmwgb2QxYi5
 EnnJdfMlo3DBzpzj+tneT4VMqJLrR2C+diObuho1xlvTrjpAP/2h8J1sBdsYxX21h7d1FxSlEHu
 kEZVsxaxWsC9nJQ4v2dZkWG7/EuIe5DX2B59G70otOuRQa545L6JLIhakNrjxqfvuj083Q/GeNl
 EwmZRlYhJAc/GmCiQkPcoSLFV59oYrKCNV0s0CLcGqJAWl5aTcb7FSkJH/phkI6DJuTP7ojXLYZ
 mPOEdnHfCSq5naLTOBW067j1X8+LR1gr7qMQx5ADxaHnnvjzJcDz2zLU6e75k+DA8iAGDWHkd/V
 yj/gEjS2+gUJ8KpR2oVMlgdJ+bSNcZHsdHF8uie1FN8qxrt4dDso7Lkfh6l2tSr2eW7/OrRy8K+
 h5eY9b07vYpJxI3ZyCFDzovh/Pe9Zogbdf45I+pzyUFOgiyb+FBTmdOpaXGr5AwDSlOquNni
X-Proofpoint-GUID: ChzwBM3dOi2jzoGVJyZAUUF0lrvV88Pl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_05,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=824 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505260081
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

This patch series introduces support for the Qualcomm watchdog timer 
in U-Boot. It includes a new driver based on the upstream Linux 
implementation and integrates the driver into the 
early boot initialization sequence.

The first patch adds the Qualcomm watchdog driver under 
drivers/watchdog/, while the second patch updates board_f.c to 
initialize the watchdog when CONFIG_QCOM_WATCHDOG is enabled.
This ensures that the watchdog is properly configured during 
early boot on Qualcomm-based platforms.

Balaji Selvanathan (2):
  drivers: watchdog: Add Qualcomm Watchdog Driver Support
  common: board_f: Enable Qualcomm watchdog initialization in board_f

 common/board_f.c            |   2 +-
 drivers/watchdog/Kconfig    |  17 ++++
 drivers/watchdog/Makefile   |   2 +
 drivers/watchdog/qcom-wdt.c | 194 ++++++++++++++++++++++++++++++++++++
 4 files changed, 214 insertions(+), 1 deletion(-)
 create mode 100644 drivers/watchdog/qcom-wdt.c

-- 
2.34.1

