Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBB1D148AF
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 06:50:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5629783B7F;
	Thu,  8 Jan 2026 07:50:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ESoB7lwi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tpcu+1Y9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0EE483B95; Thu,  8 Jan 2026 07:50:00 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71B3083A1E
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 07:49:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 608469dG2779133
 for <u-boot@lists.denx.de>; Thu, 8 Jan 2026 06:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=9/li8kH+6627Sfeu11lHb66kI9s0cFoYO2q
 4Zkq8yso=; b=ESoB7lwiDMRmpUZZKdQWV+jwahDCoZDNWkrfSJFHygZEWARMHgQ
 rQo1TkZCZxm2k8OrXdJjGKXp+gv64I+SRXgkzX0rKYClxVZhDHBtlNvKcng4Tdyi
 ALl1cAfulBsZCyJWbu6GSpUq5qNLxuxCzj2Y1rhymelI3jW0XLu1Lqz/aE1gM904
 vX/KM+Z/MJK7H4KJMAlV2B3gjGk3u3kSWDbq3h5BivCBP1/wqdHr+lsR24oRPgjg
 sTv4SdGgkMcWVaWQze/e6hUJDuoUSsS2UlEzPLOxnicWG6EwFygy0cckNtH3RpHO
 QzV7JFhVDJszIvoucW6KFHhHiATO4etxz6g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj58uge9m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 06:49:56 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b630753cc38so4700641a12.1
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 22:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767854996; x=1768459796; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9/li8kH+6627Sfeu11lHb66kI9s0cFoYO2q4Zkq8yso=;
 b=Tpcu+1Y9F0C2oBNtIZFg60MR/+Pcd26JG+peC0VmWYeIFBTNyJSDIo9zDGuFoGIjWP
 ZA6jKxIICNQ+MUX4O52cRgdrfXQNFG5fT46ov7DcOWrK252xfVPh2jAQS9bX2iCiFnLQ
 sjf9AqXDWzQ0fiSmrTRop6x/UH20Hj+GFcx7Dgr637/GSLHof2GsxbviTsXDL0HRi4q5
 LNScYiP0NUx8jNC+vRpZj9xt77h4yoMTBfvPAkYGHipa7fsVjNDmZ7+cOVUFHf6dDCvn
 JRFLk/kR9tqcOibm1hUaQKRcTW3Y9NzKFlpY2bwbbOGjLw79gKhHcDQ78UTU0+lA7ayK
 eEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767854996; x=1768459796;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9/li8kH+6627Sfeu11lHb66kI9s0cFoYO2q4Zkq8yso=;
 b=Q+st6H3CNFEGSIAkemoe2BpVyCywW+7sH2dHkEexTvWyb+uwePn34uV1E8duUherI2
 aZMcEQKGlvCXFkhJ+VmhQ3jx3anOO0UvdytZc5n6OlmaFESQN2JHt8tZNFvrUrED8GwT
 PFYT1oalY5mpSYu2biXEivpJSUOvZ4ysoJ2eh+vOPmUDEgn2b8rgn+sRBnO60kLXX/fU
 uZMZey73ifCKkHHoWoRn4wWi/4G/k7W5XOKPDop4rhahdVhUGcAFth9SG4ozsnurKN0T
 D3P+DFpP81oUHsvNB1OgcIyJcOJ7V/uy33Nh0kXA8jI5/kituzJHrO2O8kFGLX7bHj8K
 w3VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2bkrs3+xfeDKU2z5nf/sMAqqyYtAv7r3XxdkaBkr58lKOggsyc3OwH9XWW7oM5zTMC54Pghg=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5Sajue5tvHWHGIofzh8cjLEtW0c21QFUg3hKyEK3H/t5vC3rm
 NRJm/5BUisSJhKZGDBTNbF0l5lNjw7NhUqF9gtrOeOkt78xwiS6EpV/vZgYA+7tjxiJO/NJIv+X
 TtLSsPrzUH4pXCtqgjfOBhi6KcxTFBSBh1NEr0W9BrqdNBAwUAmqbyTyQ
X-Gm-Gg: AY/fxX5ueBaggTksnu0h8R2LfJytppXxYm9g3FcJp0+xDvTr+9h0klfvCHqDoxbyraZ
 qqziOLC91QtcUejrcdaRrDzGxfMfFI4jqc9eJ9Q16EJuNd8DcmhgSnCjJySyrMlJLiFfZQq91Vz
 5i/cz6t66kaKez+O2/GShtNwkC7E/o/qd3fgTMHzZ+Zld7XeAtyUpKXZ7JGzV/c0reGIwdPaisV
 ogn1K7g3EhRE0PzWFbJd1MVZ2mnDnbueyzDn4KZZybc97xyAqMi07wxLzZUn41GLVp8rvNDIvnJ
 zkPiylBmg54hYnka1GLORW4F5oSg7X20VlkaVEhUg1RMvAYGuPNkGfUEF0L163gTH3IwWk0y6DW
 CLIBbKDV+YWdTaCqDk8xb+50cCLqCQJPmEJRz976LJKu5+RWqVeDnxg0Yu5oaITXfEjb3zXCBlT
 IG3vlq35ZdqmBm9TP+BH8wRFSPzucxQIgzjkMOpA==
X-Received: by 2002:a05:6a20:6a21:b0:35e:824a:dc57 with SMTP id
 adf61e73a8af0-3898f9915b4mr5209636637.37.1767854995841; 
 Wed, 07 Jan 2026 22:49:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGemecuGm1p0CNWcJRzLfDbsrnnS3HwJlDSebOeNFWEJtf372MCQK1VYJwVteEwDJRRPmZqTA==
X-Received: by 2002:a05:6a20:6a21:b0:35e:824a:dc57 with SMTP id
 adf61e73a8af0-3898f9915b4mr5209601637.37.1767854995353; 
 Wed, 07 Jan 2026 22:49:55 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbf28faa9sm6918641a12.2.2026.01.07.22.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 22:49:55 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, joe.hershberger@ni.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 quentin.schulz@cherry.de, ravi@prevas.dk, javier.tia@linaro.org,
 quic_varada@quicinc.com, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, ansuelsmth@gmail.com, mwalle@kernel.org,
 anshuld@ti.com, jan.kiszka@siemens.com, javierm@redhat.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 0/4] Add partition type GUID support for environment
Date: Thu,  8 Jan 2026 12:19:43 +0530
Message-Id: <20260108064947.3237361-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA0MyBTYWx0ZWRfX9n3TAWL9lktg
 zdqrxMGw0M/uuVVYQlKod/Ubrw1SGbta9s5sUfpexXSziDUSJi5qw2WCgn1bxJEZFc5rR8WVqwF
 UBMTwxTQvaN7/YOWYR8wHwyslbA2W1NctyY3p/jmvDxRCx63MDA5W0XY8PGrz1MbfR0rEnjXfcD
 pG/1ZZRlaG+oQ+wFgAK534d5s7z8G/NDSi/AR65ybhCQuDoWjYDXmd3qTf+5pyrfg9E6+leuotj
 EPt2QLsLa8dj9y4fxelgB3ufl4rErXYjL2StJ9gVOEq6WNBxhpOsJhCfqdBEL0R3r6pqqrqxCXY
 7gKJcJjONhirQLdsL0J7+P0TRKdAGlKNE49BTJbkbWwdW2LLtWJycBvSA2LDfWfS6rBKxjNS/7Q
 qOIaHVJoaoTMf5w9TiP3d6DGJDKKaH4rpvqm/X7VcHas82pO6OBkllN7RlSJJWOLcHvsKI+dXP/
 oxUlO3sIY+9/uoMrS2Q==
X-Proofpoint-GUID: MKu_IzZtUlbFORPbYNGAvw6Yko0UO7ea
X-Proofpoint-ORIG-GUID: MKu_IzZtUlbFORPbYNGAvw6Yko0UO7ea
X-Authority-Analysis: v=2.4 cv=CMgnnBrD c=1 sm=1 tr=0 ts=695f5394 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uxajwLBANOCmf5AMRP4A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080043
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

Balaji Selvanathan (4):
  disk: Add partition lookup by type GUID functionality
  scsi: Add partition lookup by type GUID for SCSI devices
  env: scsi: Add support for partition type GUID based environment
  configs: Enable partition type GUID for QCM6490 and QCS615 boards

 configs/qcm6490_defconfig     |  4 ++++
 configs/qcom_qcs615_defconfig |  4 ++++
 disk/part.c                   | 39 +++++++++++++++++++++++++++++++++++
 drivers/scsi/scsi-uclass.c    | 28 +++++++++++++++++++++++++
 env/Kconfig                   |  7 +++++++
 env/scsi.c                    | 13 ++++++++++++
 include/part.h                | 21 +++++++++++++++++++
 include/scsi.h                | 11 ++++++++++
 8 files changed, 127 insertions(+)

-- 
2.34.1
