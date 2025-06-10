Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F176DC5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 09:37:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A67A80E9A;
	Tue, 10 Jun 2025 11:37:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dix3CdYS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58CFF82AC4; Tue, 10 Jun 2025 11:37:47 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D54428070C
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 11:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A99fmH016123
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=V1eHBF1Cx1n9KzHyjAbS1SdzrmdDI4hFtu/
 Iif1/gnU=; b=dix3CdYS3rfFNxjD0xUb+y3E2vjVPdvPDQFGuAVjY5Id+3KK/hV
 s/kf6aY/qd2ciKt8CTbysYgUS8rgI4lkJFRJpxrFxEbJiNzwCQjhMXrRBKRQNXPP
 PScQKKtcDE2fQe44XaDxyz9xD8fHVxZBBHeGUDt+VjE95pYbl/ibmaZzqO+FdidA
 XhuHrFrhfF5OKDOWF3H6EWdJUXt78UFMn7TRm9M4+jIeQKOqYT8+6K1v+IWFzZug
 +97wqOmW6yfB0swoDKNzIg6+R/enTtwJewF9YhH8lbEm5g+W/mp7LpgC1cf7JNyJ
 t1JbTwaae8iVQTyX09FGDMyaFmIhadUPLEw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4762tg29cv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:37:43 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-747d143117eso4139751b3a.3
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 02:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749548262; x=1750153062;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V1eHBF1Cx1n9KzHyjAbS1SdzrmdDI4hFtu/Iif1/gnU=;
 b=MprRZoQPW0gQHsxSBgxaBECpK/OPOY/i4Uf0HsNbYsrqqeOGSrQbic+HfG9v3vEwVb
 Hv4ig5qi7epAZYMFcZ2wVp3C6zNUvu+0fGKIhvWOTdsMCBqNpV12xgNFT2ezciLrRNkC
 TY4mNZJtEkcUiZEZo6qdu4JVDOYfCKzr5lCVrXQfOd1zRBU4v6U8Wmx6fwYwQpe1Wij2
 lLEnbZGA3kKDbVgL7NSL+S7gngjfGeGXYeoLwTse4BY6dOqMyqJ+w2iu+9nNlMdNUg1L
 1nXdyIIOqtiiDjk6iL3cmd7XWuY4oBwEvbjS4k8oUgdAqzFaROEkPkHloT5oCHODhXOj
 NrqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDsXRGU/er27nNMb9E4srFu9FK62jrQcsJf7JwUDkeW/fjSOqs5tS6O3B2/hHGB/q+83fnDsI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3kRQR5i5jT8ujclezocTGhpG2qp5Djkl4mEgyfFG4+367Scu6
 +74PE3A1JfmihN/5jwdp6UxPWzhHCABIYRBPuW4LCnLwTdgRU6fLsphBQyhS9s+KotPjKlKOVGJ
 aCbRdgY0CFZuAwmirhsZMWFNiLw7K5hB4/mP1j3GNR/SICPHuv+N9dcjX
X-Gm-Gg: ASbGncuztsVo52n86nRjEwsPA6SMSg8C1K8q4W/DsXxxciYUEg4AR2MYikCGVJUYgtS
 40RINTVRpSicqYQbfseO7cW1QnUudpDM0pcqW4G4fypUv2/RUwpe+VnMy6j18t8TV2pOTLCC4bw
 TSKYtbeacTqOC8y/R1lMPUiEXyEDL2taFvxyPGQYofJEzWqrA6o5fkA7AHgHxy8PDMK3IQUsZcS
 VUksGUOaUadyAfNo2xXgwqnE1/72CIgLVG60vDcZWfTQycJlPaoqhdvDH2ynSeb/6Ic1erhpY/d
 YA3ychntPdjPCFyF41hWcO0DXDZ2OrQBKrUCtnBffO3ZTL+MPZQC3QkAnywUsUPsBEu7ZlXOzF4
 YFVoqfkPv04rhjeh7ump64oxBi5BBdOzNvaV5fYnTNA==
X-Received: by 2002:a05:6a00:2e2a:b0:740:a023:5d60 with SMTP id
 d2e1a72fcca58-74827f090f3mr24850463b3a.19.1749548262034; 
 Tue, 10 Jun 2025 02:37:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIVLindK/MyJSdZzyOjYqoJ7Pi0UUxYUFs3CXDDZG0kFKto8VjDrmagFKYbE1Q5/EXgQrgkQ==
X-Received: by 2002:a05:6a00:2e2a:b0:740:a023:5d60 with SMTP id
 d2e1a72fcca58-74827f090f3mr24850425b3a.19.1749548261598; 
 Tue, 10 Jun 2025 02:37:41 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2f5ed58b28sm5667825a12.4.2025.06.10.02.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 02:37:41 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1] board: qualcomm: Add MAINTAINERS entries for Dragonwing
 platforms
Date: Tue, 10 Jun 2025 15:07:32 +0530
Message-Id: <20250610093732.2060702-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OqZPyz/t c=1 sm=1 tr=0 ts=6847fce7 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=xtxONwy9lUYu_BizphAA:9 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA3MyBTYWx0ZWRfX4g+6cDPp2OlL
 8VlkVSNHX1CJNH0xg983qYwaNAuYabdtIpCzJdbrIsPg1M+jqZN1n1e/3FO8QTNtBgYerzcrg1J
 4R49kAMU7NhR3dRxUai+4c3jpDcRU1N8MRcpHVAPramJgikRRTnLpTZFi7TNO40GZfY+tB/HnV8
 QPftaUvtuK3AeJK48LwWH8TuNOtCTS5JomeFcDJZdtH1VEXalJSAkV5K02D4uTqrdXB+W2Oc2Sc
 w02R4m/9KHFDju3IfG+g02RHPW4cKRLdO99/4yHMZa7gTINB+YFFJQls4AJ175l5TBzkg+O/QAc
 i4qxI/PoFOLkH8HWAEXySxe1TvVYGcfySlg6OLFarpH5VO4+Ia0WcDdqM7XOnIq/WF//IreOV30
 vUkXxOyJq3AarIrvSiqueZh43KTuT0VYPU7fpgV34KNMXyTnNSGQReB9hY7s9RTEVpmwOwmP
X-Proofpoint-ORIG-GUID: 5IhcZ6JVv86WVX2v0FsE43fSo4Z0lEKe
X-Proofpoint-GUID: 5IhcZ6JVv86WVX2v0FsE43fSo4Z0lEKe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_03,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 bulkscore=0 mlxlogscore=860 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506100073
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

Added MAINTAINERS entries for the Qualcomm Dragonwing platforms, following
the discussion in the referenced thread.
https://lore.kernel.org/u-boot/20250603192206.GK1382132@bill-the-cat/

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 board/qualcomm/MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 board/qualcomm/MAINTAINERS

diff --git a/board/qualcomm/MAINTAINERS b/board/qualcomm/MAINTAINERS
new file mode 100644
index 00000000000..9196310f117
--- /dev/null
+++ b/board/qualcomm/MAINTAINERS
@@ -0,0 +1,14 @@
+QUALCOMM DRAGONWING QCS615
+M:	Aswin Murugan <aswin.murugan@oss.qualcomm.com>
+S:	Maintained
+N:	qcs615
+
+QUALCOMM DRAGONWING QCS8300
+M:	Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
+S:	Maintained
+N:	qcs8300
+
+QUALCOMM DRAGONWING QCS9100
+M:	Varadarajan Narayanan <quic_varada@quicinc.com>
+S:	Maintained
+N:	qcs9100
\ No newline at end of file
-- 
2.34.1

