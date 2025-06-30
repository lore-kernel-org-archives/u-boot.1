Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C159C7EE39
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 07:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C987882B20;
	Mon, 30 Jun 2025 09:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kr0wXuw1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F08C6800C1; Mon, 30 Jun 2025 09:00:54 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE70E800C1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 09:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TNUXhe015033
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 07:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=J4q4zrc23IKhgQLmqvuPLPvrExF9OQE8HqQ
 pQZzFcHU=; b=kr0wXuw1LgN/CvLjCnewL0s+7+B9AuK5xO0wOa5higsdn3I3kBL
 jDx7kOsbXoUWH32xDjc826p2bAMWkYwSD34q3qBPVa6kSg73dDpc/sSf3zLjMZ7w
 FRONeN3A4fxK61G6NvagjHapo9gNrWdrxRo6ZHPmpdXHwLjQuc0La8fMNJrlKfxS
 YNEtGaHjxlrBKt2dfZr0qzzbrILwmvEpO6uM13+PNuSa68Rx6cP1RJMpK2BxBtGf
 qFFLrxvpPOjKoatUJYX70w9IRXdoHbHR51kYgHvu8xFtiVtPGDaElvotgdS047rU
 WNBGH0BGpoBgG5uyzkv9kCDxpgYsYJSx5mQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j63k3ug6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 07:00:47 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-7489ac848f3so3324779b3a.1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 00:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751266846; x=1751871646;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J4q4zrc23IKhgQLmqvuPLPvrExF9OQE8HqQpQZzFcHU=;
 b=qwjAXqBfoGLnY8md2/0KQrG740XaP49mfgRzCeEDCBcP4KcmO7j9lcx/ayYY4Jp8Fh
 JkWMSDfX87wHem634oFp77fcHjWb9ZB4+bQsWvQL2qq2IqdkJdcZ2gUHADs8xphU8+IT
 IySplxsLXXemPUj1h/OMfDvd8TdlCKTdQ/tr9JuuwE6t3F/+O6mXWGHEod3hpG1SSbLG
 lP+zWUt2XWfdv7QQdsj2d/2hckEkIbrWmgKl/RscqTuPt+xGcfGxNb9AiHi1xQ+3SseX
 fxoBqLOdj1tQTZJEQDDfzdHwGxqFvrtbu5Fxum8D7duc1R9UZ5QGZMRV86/plvPjh6aY
 a82A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKreKWGBRsblAQhyyA4AZNDX1U+my2pCZzkj1QZ3N7lKPKezUsHSzAMGrLGBIMhwM8NXLtT3k=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1jtS4olSIfeRKkndLjy0QjM3HuE7GUblFdF76vKhYvFDbOmnf
 jWYG94OLf4zROYghwurShzV8EP4qlFAT25ocUdTccBoKetjkMC39RFZ0eNBivthYYI/Scig746X
 iJsAbQyZVY7NF4/GTHh2/to2QNPpHVu2EWkrqqtzUiRDKu46bW3ryBn07
X-Gm-Gg: ASbGnctstGd454CiZjVNH1OEPStTtidR+QgojU/wK9MjXb7kPP6qYzTz6cAcI94OuDe
 co3cmNqxI5AtiCJCI76a6Iu9gq0+JOTE0+9vzh36NEs8hADkXPIHVisnN4feiej25OgmGSOqUW8
 c+Cos8UM6nclbixLdnbG95cn9uwbViErI6kU64jvlXcxdaa9I7F8QSKpobynQuTX2vN4fyCQ3p9
 2LCKrngh3qdT+z7bo/+y+dOkbnrto9TqusR2+OD8q3R2qbKLvLY10qwZRsx+psaOLz4VRVYmB1s
 v22Rvpj7F8qszSnkll2Xy1OUP3iIanjKE6Yy3DEtXxSHojSioM9Rd/qfcHqbxkng2lghD/vQK81
 julrGXGpZjsBrFiZHoBRZTPU+71c+9997XHINkOgSzc+LU99rGaI=
X-Received: by 2002:a05:6a00:1953:b0:74a:d1ac:dd48 with SMTP id
 d2e1a72fcca58-74af6f80730mr20720020b3a.23.1751266846273; 
 Mon, 30 Jun 2025 00:00:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0rIyKepXSOhPkuKTsbkSSELFbbIlJBBH65O6aiIOvPkBoS/O04IyzW+fR8A9G53cxaqFaEA==
X-Received: by 2002:a05:6a00:1953:b0:74a:d1ac:dd48 with SMTP id
 d2e1a72fcca58-74af6f80730mr20719968b3a.23.1751266845839; 
 Mon, 30 Jun 2025 00:00:45 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af540b443sm8383634b3a.15.2025.06.30.00.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 00:00:45 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 balaji.selvanathan@oss.qualcomm.com, quic_varada@quicinc.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 0/2] qcom: qcs9100: Rename defconfig and fix fastboot buffer
Date: Mon, 30 Jun 2025 12:30:38 +0530
Message-Id: <20250630070040.734486-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZKfXmW7b c=1 sm=1 tr=0 ts=6862361f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=6Iy5jrY6g4MAEiLFdioA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA1NyBTYWx0ZWRfXytkPHAQnRyJ+
 PwHFHy6L5b5P/jn2kCOualxDLweieawiD0E400x6Y5dqPUixYwvqli6c+qxI4oXwM3npcYpg4MW
 PG1Pi3rqY21aMoQedDLpmq6IHl6OzUtl8faNGK9TylBEDf83WX8ync3QRx//eVdiaoVETDijaz9
 63dWFQAw3l+uOZwXXKr8KQkE0IVzvYFhq0G/6zfdtIusIqrGGeR2RLwGz56XTSGwpDbuBxw0WM1
 tRrgLh1zeuLb1/+eySIJLD5QRra6vnxhcg5U6dDx8+Yd6SdNkgmCQATebiyYdz1O7aliN4ZkySq
 5vSO1EHeNc8PNJrwNfIXtjo7Bd1x3nrcxIKB+o13UdKPId9Dt81GXMKfzSJrQOATFf0d79hBNh6
 Yegzg8zKirZNnIbkpuEJCUMS/Xvx0zrcoShANTAUZTbuyPBJAN7gA+hxdNryqKTnyGgLb6kJ
X-Proofpoint-ORIG-GUID: gWjhhFtqoWPwK_KIP6-iqjp9HdUEt8em
X-Proofpoint-GUID: gWjhhFtqoWPwK_KIP6-iqjp9HdUEt8em
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 mlxlogscore=440 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506300057
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

This patch series improves support for the Qualcomm QCS9100 board
in U-Boot.

Patch 1 renames the defconfig file to follow the
standard Qualcomm naming convention used across other platforms.

Patch 2 sets a valid FASTBOOT_BUF_ADDR for the QCS9100 board.
The default value of 0 leads to NULL pointer dereference during
fastboot operations. The new address points to a safe and
sufficiently large RAM region.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Balaji Selvanathan (2):
  configs: Rename qcs9100_defconfig to qcom_qcs9100_defconfig
  configs: qcom_qcs9100: Fix fastboot buffer address for QCS9100 board

 configs/{qcs9100_defconfig => qcom_qcs9100_defconfig} | 2 ++
 1 file changed, 2 insertions(+)
 rename configs/{qcs9100_defconfig => qcom_qcs9100_defconfig} (93%)

-- 
2.34.1

