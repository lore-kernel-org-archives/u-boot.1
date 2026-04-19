Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80166EA7195
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 10:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9B8283B99;
	Sun, 19 Apr 2026 12:24:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GbsIrbMD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dm7Y5zL8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F3E183E81; Sun, 19 Apr 2026 12:24:20 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB2F4839D9
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 12:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63J1pw193982252
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 10:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=RrgPRSqoXiDcyAGD5d2gJT
 dUKNQLdRsQ192u3JziwAk=; b=GbsIrbMDlPlJcr+JmBUGDZcgnel7/zSR23bFNN
 JRzlmBycwVYOjERc9l/Nmc+CQple0Iv+qJxKHcPvNPKt2x/JlNIOwR4sGnY1Nel0
 Fp0mIFVOBpAc/9YL1c002XzJTDFIofEaZs/nL+wFFYv/j9HSCEbljRqqFw7gAn59
 wSMm0LAP/UHT+V57cuw22tYJZ0GLhdpOca9/YI+vz38BvYpet3ZkHAEbMPUPsWz2
 yQk3LHZlvwYNw7MHgac+rPfLVWNJKSw7TAJZpulxsfMaoA+X16kI2kcjzTozqEgi
 UvFF4I7pxJAH1G3dBkpzGY3h4Ri4WS81gKhXVfrUyCztxvzg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm2qajbdu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 10:24:15 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b2e8bba2e6so28975075ad.1
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 03:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776594255; x=1777199055; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RrgPRSqoXiDcyAGD5d2gJTdUKNQLdRsQ192u3JziwAk=;
 b=dm7Y5zL8vsQd8mope/5Jis4xEykw4C9nOQsDI9UQbF2kwyyfpiSwadGxHWtJy7L/jP
 X8vHLWyQuYMinro4GCVKb6VjVFgOlUPB78ZTW1gfTit02J5HPdrau5Sh6pVza0QWBicS
 KTQsza76zjLy8LjICypaeTuPHzmwfAEb7tm+y8cig3u8zBRoifkJD5CuC5vDtVDLVLQk
 /FD0PuMxUlndcx4vrUffMn4LY3O0QvaKn/EpFVvQ4iVvkr6+UYtKwrBFrk1LVp8Suaf4
 asEVUjweJ1qWa00zmbntk9JwavUnLNI4qUVyLQPCCFfZPxpOsdcgnCZ/3KEzgYG1KPaV
 0aUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776594255; x=1777199055;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RrgPRSqoXiDcyAGD5d2gJTdUKNQLdRsQ192u3JziwAk=;
 b=ISpn8Syl6qg641wreMGdLC0P8LfVWKE8Wgogt6kEBASO6Alt5uh0thkMeS86RtmT7+
 bt93BaV4Kg2deeOnX07htYLcVqCIu+HHJM5D/EJw0UVaUyf2tg0pRCJNvQfb1fhnLE0c
 cvGoPAY7WUT1A9Xt5imU+h8uJN5oCpuiKTq7SYzNPLhLefVftRHQs8YGO5IOswicPu7F
 eqGJ9oew5vRO2rYu020MEW8h6KpukHygimh2qQUvsFI9+B5ZylsUizyNmloIJoSF46xh
 d5BcjkqdNEn/MnvuoQVtifTTZQ9GHgxKco77/Rc0hNfn7X3Pymwy009Q8R2zq0GiqZaF
 vTDw==
X-Gm-Message-State: AOJu0YyPCqVVekhwO88xWwA0kRT0pfNqZV1nb6uumXgWtlqt3ccNpepI
 KDIgUN3ut3CpJdcfPtAmX7pEGpxn5FhEQ0xYkUgRyeH2OHYNeqsoAwpWKc6TuRDHIsnX/Mck60M
 eHyAAZW2V5gLbT7MTmZh3rNSGNwQHwNYiziHvsdaYEz+xyjFPt2Xyb45TdJsBfz6p
X-Gm-Gg: AeBDiesNqgSbYx3tfoGeDBwoUKHJMeamCilNiVrms7nrMSlI0UARCmJpSwk46TtXFiS
 024qCFCUqArsGg2fv/xtFL41E7EUsEm9dMcyyKCQFTZKRhhzFVRTv7DuNamTHyCzZLhrInrBBMK
 FSlrDCKw9fMGPcCy4Mcw1gJM3ukxGKTjscBbNFrp5v9K2zU0n7oM1uPS25yyKvqRrmahcHkny/s
 RcN6HhZ0WATY4JWcao9DYbujlEegHoA2MzdtmCYhuLcmDSlG97I/Mj3Mn2g8rqbXsWDTsyAjQ0m
 b4Q8W6zSVOvfzJ0zuVi/ErLtDyi/S7DcTMdCkFFbIEVvCfM5IXzYS9iw/eS9adSjE+kHkfGZ8vV
 vqJh8ub8DsSqCl/f25GKJjwgPvMHr+eF4c1gOu50N0Pv4CgRVST6T1be5kswYbxmNZB90a7ZhZ9
 btnD/cSV92+sNbXiZ/S8g7wvrKQ5GvBTzwKTAMVOB2E4bzV9NO9+Tt8KDagvpF
X-Received: by 2002:a17:903:17cf:b0:2b0:52b7:e82 with SMTP id
 d9443c01a7336-2b5f9ed031amr97418835ad.16.1776594254936; 
 Sun, 19 Apr 2026 03:24:14 -0700 (PDT)
X-Received: by 2002:a17:903:17cf:b0:2b0:52b7:e82 with SMTP id
 d9443c01a7336-2b5f9ed031amr97418575ad.16.1776594254401; 
 Sun, 19 Apr 2026 03:24:14 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0caf1sm72754675ad.42.2026.04.19.03.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 03:24:13 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v3 0/5] Add partition type GUID support for environment
Date: Sun, 19 Apr 2026 15:54:02 +0530
Message-Id: <20260419-type-v3-0-ec49acd6870e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEOt5GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0NL3ZLKglTdZLNEE4tEw2Qjc+MUJaDSgqLUtMwKsDHRsbW1AIu7Xtp
 WAAAA
X-Change-ID: 20260419-type-c6a48a1c273d
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Simon Glass <simon.glass@canonical.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776594245; l=2671;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=9K90XtDd9BAJ38cEa2RGRHpXSRRJiqjVo2Skx1BAEog=;
 b=yZNEC+/YDMTxIpV3an/W2k/an4ej8OMt4xPZQTFR/jioHyxmHr5GpoVvabLqxVCkNtbMbXWAB
 0JWDUMBhoQkDmZ3pianY8I5StSD+TMx/ZBjL+esGd4E2AuoyqTpjrr3
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: Hio1N38ygChqCb6-TWlt1b0foROzNBR0
X-Authority-Analysis: v=2.4 cv=KdDidwYD c=1 sm=1 tr=0 ts=69e4ad4f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=MqmbOINMHaTB6spGDmEA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: Hio1N38ygChqCb6-TWlt1b0foROzNBR0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDEwOCBTYWx0ZWRfX1hzg87GlCTBz
 9uHsbHaygYrjtsamiq4ZfUUtWRejn673Cz8jv1aVdooB88SmcHhjegtoM1s0QVWdQKlNizEqJGD
 f99Iiynry76svNTEwcXsy9PM2HryHXTieb1PjJ2S4JKmh7d3/iQmS6nmPO5w10NdDtKvtuWbnuz
 g4D4ak+/Q7XEhcvMXXr3fXbellVrcnEBdxAS5wCvFC9iljK56lsUW9pE5u3zZTiDXDOqGs+gnvK
 2pMfTH0cTms1zHTNhciP9ui71ud/S6MgR0cCbPom2retD8Vmy8qykortI36EPnMrk2tj+TZlTeT
 m34sN5zPRTfOVGEughTvOW0IdRJ08Xk8PQbcD/180A+XycGu7CKLqBwAEmIw+CHNqynYnDtpMnr
 291ioxcn+R4/fnrKBk6p4ev2iLPKssZnRvJC4T9dNyQT4imUyg6+7paIBuRUa9o+jF5BO6FCYF4
 6E35HSUgPZnZWakVSyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_03,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190108
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
Patch 3 adds support for partition type GUID based environment
Patch 4 enables partition type GUID configs for QCM6490 and QCS615
Patch 5 adds unit test for the partition type GUID lookup functionality

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
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
Balaji Selvanathan (5):
      disk: Add partition lookup by type GUID functionality
      scsi: Add partition lookup by type GUID for SCSI devices
      env: scsi: Add support for partition type GUID based environment
      configs: Enable partition type GUID for QCM6490 and QCS615 boards
      test: dm: Add partition type GUID lookup test

 configs/qcm6490_defconfig     |  5 +++++
 configs/qcom_qcs615_defconfig |  5 +++++
 disk/part.c                   | 37 +++++++++++++++++++++++++++++++
 drivers/scsi/scsi-uclass.c    | 28 ++++++++++++++++++++++--
 env/Kconfig                   | 51 ++++++++++++++++++++++++++++++++++++-------
 env/scsi.c                    | 45 +++++++++++++++++++++++---------------
 include/part.h                | 21 ++++++++++++++++++
 include/scsi.h                | 11 ++++++++++
 test/dm/part.c                | 48 ++++++++++++++++++++++++++++++++++++++++
 9 files changed, 223 insertions(+), 28 deletions(-)
---
base-commit: e3405917a1806971d9e72a94186b299f05581e1a
change-id: 20260419-type-c6a48a1c273d

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

