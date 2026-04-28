Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0BEFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:32:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94CDC83FB5;
	Tue, 28 Apr 2026 09:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z4EWvP6r";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GujbWTcE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F04E845C8; Tue, 28 Apr 2026 09:32:05 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C796A83A91
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S2PQIn1237201
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=QblVuGgO04TdDTtG9j+vF8
 Z3YrtDWAfDMSJm++zFjPE=; b=Z4EWvP6rlUBnfuT4Mu1xOxaIhkjD8fTJ4+3+MO
 VF/UTYCYmFvUYC6Wl61CgGazbzcGgFgx8PKkF3EmnNNrMR34SEt2cui5OcK4XYHf
 TdFfXsg07aF98ytMhUH8bqR8ud3xmr5x0214ERZ2LkvQR6fVp4/GbHrkqOGId1KT
 ZL5bVCibgDYp1DACtAZpROxtUp8XcFRkAYtVUcjFZUALYc2TwaHnlZUEu+37wsED
 9ZVNJKTEyi3vWg7SSwoEm5Jfh7lIz6Wslp026qLow1HarTnOYOZSA/ZD8FtqssUx
 OBzEf6EAKJtdsrR59y6GnD0v3nH/EWuR8DvG1hsBUVRs+mfQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt6n4m5cf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:32:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b7a77b8ec9so14636185ad.3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 00:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777361519; x=1777966319; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QblVuGgO04TdDTtG9j+vF8Z3YrtDWAfDMSJm++zFjPE=;
 b=GujbWTcEAvIxEqa0pTCpabhoTaskILewdJCKDsmYkmM+TcGKe7yZbquRa0el+N95aE
 df8FZoa559AVO4JsZnJIdjixJ1li/NQv40b5dKFZ6Dxc2aISkhL0VslxURAon54I/BPD
 CwaxBCMQTyhhnSsWyBLNWvcvbivr+X+Vy+AaJwl3vxs3MS/u7hgyJW/qbmeeRt14nsnG
 evvU/0Fzy969iCVWZfSzhyVPufHZFiJJdIvb5ym5Eg4CdExnoECnKznMxS8To++4BS6y
 2ddPqZHiGZuMcFjIfJBAkfEcLSDgqWf/uWtBrq5Eh1PHPh0C2G6RMsFctZmOaR+9p55N
 n4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777361519; x=1777966319;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QblVuGgO04TdDTtG9j+vF8Z3YrtDWAfDMSJm++zFjPE=;
 b=WMDa5YwavkaKJWo+CpdqzosBetXmXyqprXJQ/GHKy7mKhRT40mwoDEmQfOsmMxl+xU
 6uROVqi6DmOiOTndnqG6TUAOVCv3JcAohxoyqGDet5A7ab24KomIY0HE/XSOcq9PFXyr
 XtP5lssn0xzXezAEyEj68U2jvkNbRb65OPA0e2H+bYErN5y2/+RvU0rNnEBZCrYsfV9v
 Zd8ftqoB4v45KuJMOEFZ5NGKRijyy7w3UvCcD6zLGf+mzr7dQA0PrU5zIfy9p3OQXYE8
 omYTq/A+GN7rCriVlKZbOa5vCDK5aa42nerUyvz2GaEsG9/Y+ce34uFEv69Pj701FgMU
 SWsg==
X-Gm-Message-State: AOJu0YwmIqJNf8T81vhI41VJHwxlP46hOSl+r0ovnkawgO/fqhYmQtL2
 90l2XcMQEfzHVgpfp9ihxGvIZJ5a1JnbZMSrgFOBtbcGsorkgYlzowWMedMZc7+7zkB4Au2ZRKz
 ZqsVyFRm7Ql/W+uUdDtZia1ob7qHvvnbu97BtClCNYuK5YpA+PLX3lBq1
X-Gm-Gg: AeBDievXG8pP5IeynHNtM43e/qxo6yLvioz6wfsrBV46G2XY/x9Gxs5aspUZdZvr0yU
 77STO5EU8uSv089kwpPkIugssb1l5NEpZPMpSpHG8GohCdYCMW7pSmcC1VyJPDbbKWM9KY7OY9m
 p1+A2saj11d9ghpSOCVZ09MQuUnTUYtzg25hQ6/q5YPkn5MjrS6VFbDpsFqJWTNhoJanSGQWSck
 aVDIHI1MMkePh+KA3NfGr7/e0mc1C69uheyd3/iBmswDf0XPLW1W7udzhG4p7euUme7B0zuXd9F
 WI1AxSzWOlvttscgk52aQxqsbHxwHNvJhbwz8sxQ22nczn8tFeJGF0Yww9R0uOs408ZTytnlO/3
 DW/zdazU0tSTapACL5VxECkeSmoBnnOVx4dHqtQbWjK9+9ptM/DBFb23MZn4DwOkoD1a1WgMzqR
 +BwLvo9sDsrL//ADMyzZUPPaUyMct2KC5Ic6UNjL3yeKwLOTYu8LjkW5Qx2elr
X-Received: by 2002:a17:903:124d:b0:2b0:5795:9ead with SMTP id
 d9443c01a7336-2b97c02550emr19213765ad.0.1777361519080; 
 Tue, 28 Apr 2026 00:31:59 -0700 (PDT)
X-Received: by 2002:a17:903:124d:b0:2b0:5795:9ead with SMTP id
 d9443c01a7336-2b97c02550emr19213505ad.0.1777361518419; 
 Tue, 28 Apr 2026 00:31:58 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b97aabaecfsm16054405ad.36.2026.04.28.00.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:31:58 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v4 0/8] Add partition type GUID support for environment
Date: Tue, 28 Apr 2026 13:01:42 +0530
Message-Id: <20260428-type-v4-0-b7051dc45a88@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF5i8GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDIzMDEyML3ZLKglRd85RkCzNzYwNLAwszJaDSgqLUtMwKsDHRsbW1AHKRVdt
 WAAAA
X-Change-ID: 20260428-type-7dc867309086
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Javier Tia <floss@jetm.me>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Simon Glass <simon.glass@canonical.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777361510; l=3558;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=sP8hRHQonJQrA2icgVcNggf7hwLQxCLrcmhd1k3sJAo=;
 b=nTN28nRkvv+l7qSOu29cKxKiqUPnZVVl3vgAhpm5RZ/c3siHHK9gOOBuKQzFt50vfW6sudP9a
 PK255bzG5KXBkJTYNwek/+KOkANs+F3SEk94bHejXo2ghza5sTjvYOH
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: VAAaXdo_zrrecXpL0f-C6x27aVg0KoPT
X-Authority-Analysis: v=2.4 cv=Xba5Co55 c=1 sm=1 tr=0 ts=69f06270 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7xg0KvL6PEYBae9vmDQA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: VAAaXdo_zrrecXpL0f-C6x27aVg0KoPT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA2OSBTYWx0ZWRfX5uV31iDJPnIM
 ea5pXhBznGJIjBD2cdyOhJDtJCYRameI9FzTUZMk19kZa+AuJRSddjxGYqyY0M2cE+MFqrImBbS
 Np/lGmuLoNkwpYZjqAkKh6VooCPINV2qpq2ZabTwDxgy7SO/SNUyTfJdeXZvTjuiF8zPAlNfpe7
 NWYG1nigY3lFwxBIpVeA4BeKWrO2smEQFaO1/iIq6RmLSHh7VoPlx7Fu507Bhi2BMPdVDIxXt5D
 k6H6FK7uWaN9QvfzbekDDfS++u57iUzfgxt9FblYGlzTILsvvL1Ng2glbvCZGsBWM9/t5USj0Gv
 oJVvk/XgX6LAN4XEZYaHNrG0R3WeAJ2GFzzxK4cXUQ4TmskTJIZJx8CDWVoW2BsurdGsdBjjMVz
 Fpu7/wbKpJC8oPbKJD1r5InaE3/uVMSrxYXYnWbSkyFFuMx2gmCX34iRcnMiP/e0tqfYhNcU8Y1
 q23vhDhklvDvYTCwDvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280069
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

This series adds support for locating partitions using GPT partition
type GUID instead of unique partition UUID. This enables the saveenv
command to work with partitions identified by their type rather than
unique identifiers, providing flexibility for systems where partition
UUIDs may vary across devices but types remain constant.

Patch 1 adds part_get_info_by_type_guid() function support
Patch 2 adds scsi_get_blk_by_type_guid() function support
Patch 3 optimizes scsi_get_blk_by_uuid() function
Patch 4 corrects default value of ENV_SCSI_HW_PARTITION config
Patch 5 adds partition type GUID support and choice-based selection
Patch 6 refactors the env/scsi codes based on the
SCSI partition selection configs
Patch 7 enables partition type GUID configs for QCM6490/QCS9100/QCS615
Patch 8 adds unit test for the partition type GUID lookup functionality

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Create a seperate patch for scsi_get_blk_by_uuid optimization
- Create a seperate patch for correcting default value of
  ENV_SCSI_HW_PARTITION config
- Update help section of ENV_IS_IN_SCSI config
- Add 'select PARTITION_TYPE_GUID' for ENV_SCSI_PART_USE_TYPE_GUID
  so that its selected automatically
- In test code, add more asserts to confirm its a kernel partition
- Link to v3: https://lore.kernel.org/u-boot/20260419-type-v3-0-ec49acd6870e@oss.qualcomm.com/

Changes in v3:
- Addressed minor corrections in Patch 1 in part_get_info_by_type_guid function
- Refactor env_scsi_get_part and env_scsi_load functions based
  on the choice configs in Patch 3
- Add unit test for the partition type GUID lookup functionality in Patch 5
- Link to v2: https://lore.kernel.org/u-boot/20260109070912.4106466-1-balaji.selvanathan@oss.qualcomm.com/

Changes in v2:
- Compute blk_find_max_devnum(UCLASS_SCSI) only once in scsi_get_blk_by_type_guid()
- Introduce a Kconfig choice config to select between UUID-based
and type GUID-based partition lookup methods.
- Enable above new config in qcom_qcs615_defconfig and qcm6490_defconfig
- Link to v1: https://lore.kernel.org/u-boot/20260108064947.3237361-1-balaji.selvanathan@oss.qualcomm.com/

---
Balaji Selvanathan (8):
      disk: Add partition lookup by type GUID functionality
      scsi: Add partition lookup by type GUID for SCSI devices
      scsi: Optimize scsi_get_blk_by_uuid() loop iteration
      env: scsi: Fix ENV_SCSI_HW_PARTITION default value type
      env: scsi: Add partition type GUID support and choice-based selection
      env: scsi: Implement partition type GUID lookup
      configs: Enable partition type GUID for QCS9100/QCM6490/QCS615 boards
      test: dm: Add partition type GUID lookup test

 configs/qcm6490_defconfig      |  4 +++
 configs/qcom_qcs615_defconfig  |  4 +++
 configs/qcom_qcs9100_defconfig |  3 +-
 disk/part.c                    | 37 ++++++++++++++++++++++
 drivers/scsi/scsi-uclass.c     | 28 +++++++++++++++--
 env/Kconfig                    | 70 +++++++++++++++++++++++++++++++++---------
 env/scsi.c                     | 43 +++++++++++++++-----------
 include/part.h                 | 21 +++++++++++++
 include/scsi.h                 | 11 +++++++
 test/dm/part.c                 | 49 +++++++++++++++++++++++++++++
 10 files changed, 234 insertions(+), 36 deletions(-)
---
base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
change-id: 20260428-type-7dc867309086

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

