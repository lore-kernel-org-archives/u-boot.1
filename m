Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D97B1075286
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 09:37:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AF5183FC5;
	Thu, 19 Mar 2026 10:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ofXQCx2X";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SwK0LYtP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05E0A83F00; Thu, 19 Mar 2026 10:37:52 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C3DB83BC8
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 10:37:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J748k83772189
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=i2wjwJw5f7tjKUtx4DvX+F
 hFZe9jvjWI8KZNILt1e8s=; b=ofXQCx2XNfFY1/6q+11AXFyqU5flnwdRSVpYWw
 AdFLdQOl8meBIY712A3b03Lunr47Yuz4hrm7cTSjtXMMmrU/OIYcr3n2tXgdcXb0
 mK3zVS6r30Y/iQIYDijAJ5H5vBCmISyQPfTDDHCVsloujvJ3b4cDND7C7zZnG73y
 AZqXzH1/A7w4N5UFFQcSFgncmvWdbIpq53Nnpyh8cXD6NIsWJ7xwR8rxZnZWlRIb
 jhSrLF4z6fAZn67rGGzSRJ4eXM41tqSaj/wcOZ65AZrrCJdqzngMzSvTLKOqGb+0
 s4tprJyTsA7toIy8B36Q2N2CDWY7kfyls12ZsDcuwCaqyUfQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d083r97xs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:37:47 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b07bd30b5eso4901885ad.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 02:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773913067; x=1774517867; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i2wjwJw5f7tjKUtx4DvX+FhFZe9jvjWI8KZNILt1e8s=;
 b=SwK0LYtPd2eF/BLkRSWYGOEByN/3EGccssTi8zgc9uzaeh9eYjx2jPZVXSOOWzIF7z
 FJJbcx3Dt4Zd5g8vX6pmxWOXDTDNnvQqrmwxKhP2539SMZZPHGL4M8HtdBWzoJl93jY2
 586XmfYQY9lofXRcLUctGmxn3437y79eAth4LrqqlK6M7sj+tNuTQKMO1mLsuUu3mCYc
 uhlnINZkNKQuMzinw0W0XXIZ/BrdowZiHE+e6GmR0X6BpH6gwf2lbJdNbvYZ3ku5FPbU
 uMLf1I2cuVxem1ft16M7lGDyfDLpHNZFNoxSDxd4aB1HyzeMrZ/vYfCLLQyOipHH/9dE
 GFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773913067; x=1774517867;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i2wjwJw5f7tjKUtx4DvX+FhFZe9jvjWI8KZNILt1e8s=;
 b=aigqD423bKqDV9j6bA7nd3nWLnt8nRZfh9CRmYVsqlscPAspCOO6zqPlAST+3qkfBW
 Cpyly8IlZ3FcM6ZOmDOHUBydX1eiAOA/0cM4LgIEMMolKOdJcba/f0xIgln2/vFrzbsd
 H1/6zWTii1dudiqfrYcv4s2ltJUVB29A13ZyGV89XRlOYVQkQE/lIEXbi55SE3mU/2fr
 7MlXr+KcmwTJiT/+97zy6eA80P19F+C1ZfRwAQb7UjcArkL9+kPAvXGBTx0Pvam4Byb3
 QL7KM9dNULYeE9LwvOwWmX7xHqu0dUX7s/GLbtsovdKaYTBQ0lObQsVMuqPlpjstdXrF
 jurA==
X-Gm-Message-State: AOJu0YwuEHTj8aGex9d5DBCsP5J4A3/xrA+fc84BUMFxwHyvqJO6AevN
 d0JlpI/9TcFOd2lZlIhCv5BHpb4ZtGK+vhYnsYsSI9RHv9PlU9Ga78YdnGIveIozGyS5O66mAKp
 I/+EmwQQ20o2zQqBA+M9r7iCxzkLf+MvOsgkPfELtgu7i8O+uT+MLUYkS
X-Gm-Gg: ATEYQzxlo6LqM5SPmx2a5dJyPS6VUsLVz9kcrtK48cLOXyT0H14I2KAte8fZpps3vFh
 iV+bwfNEvW9qu+Eh2fAOIi6HYp6Z0iMdoZWC5jkrR2pKcj1TCcA/OIoQfq4NOb470BadF5k7TU0
 dbTVc0I0ZBYGebPvcLhIcwmj90WKFP7hW8o5ShfEOB+iQuxbxu+Lpcjg2Z9sCaL/886aRiyZKq0
 78qM0WrfK8WLTAOJnMbmqo3Y3X91yoQ0Ye7guEPY5kyIjilEmFS0E5mmFf/3aBJp8doUUTG4A/z
 G8zFZhkMeVndjJBxWGbfDhq214AO8JJHGT/dTXnpSKwWrYz1ImbLSfqX2iZg8aFX9+nixSf72nm
 ddLAeI83HmXNdOCKWRAW5yT2ogxZmdMwyJJSnbc5GdMegYlgZfh3I/Xlq87NA5EqXFVcEnEY7/H
 l1v79QeuROWa9Ugv1cZjNCR0NMCoL8h9iox1lIvy7UOcAFEuKAQA==
X-Received: by 2002:a17:903:2346:b0:2b0:5306:5f20 with SMTP id
 d9443c01a7336-2b0771d681emr24516185ad.18.1773913066892; 
 Thu, 19 Mar 2026 02:37:46 -0700 (PDT)
X-Received: by 2002:a17:903:2346:b0:2b0:5306:5f20 with SMTP id
 d9443c01a7336-2b0771d681emr24515855ad.18.1773913066383; 
 Thu, 19 Mar 2026 02:37:46 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e441374sm52098825ad.29.2026.03.19.02.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 02:37:46 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH 0/5] Add UFS clock support for Qualcomm SoCs
Date: Thu, 19 Mar 2026 15:07:37 +0530
Message-Id: <20260319-ufs_probe_clk-v1-0-08c085d6b15d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOHDu2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0NL3dK04viCovyk1PjknGxdw0QD48RUI5Mkk9QkJaCegqLUtMwKsHn
 RsbW1AB6b4MdfAAAA
X-Change-ID: 20260319-ufs_probe_clk-1a03ae24b4eb
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Wronek <david.wronek@mainlining.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773913061; l=1442;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=snKnBKRf9ZlrARzXnLvueYhnP2NhUHf/JfC04obr30g=;
 b=9SobU7U0w5nG+47hoIeznYFaSn6msEHH8RcboLKMm4zC6HyhXz5oBjg+DJ4R5AgJm6AHTM+C4
 CcXPqKuAmfaCTvomok3rcoR8fVqiM6xfrGAi4/BNprEwUbATZS53XSS
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: OOXQM5lAL-HLBDnSITt1FT-EzI6SRNOU
X-Proofpoint-ORIG-GUID: OOXQM5lAL-HLBDnSITt1FT-EzI6SRNOU
X-Authority-Analysis: v=2.4 cv=ApTjHe9P c=1 sm=1 tr=0 ts=69bbc3eb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=xQozRo7GZnLi3yz1clUA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA3NiBTYWx0ZWRfX2PYUyaCosf0o
 8OeX8nWDeBpYpOoC+6MgdBu4fO55dtcKT2/CN1pDhSgvjjYx6EtqLCrOXmtD+YpNUpIo632uWq1
 3nrAdCpOk9a5T2rkn0r4t1m8rBICKuO15gCsRq1lcJ6ll6jDwTkSN0IHVjKsjaCRjvWkALOq8Bf
 umK4dzyJNQnSYnyL4XTnPwggRyaFMYYYFRSms5dFtqCLvQnrjsTBWHOvXoekDDCNLJC2H/EQZ7f
 4SGdDLmeF9BHpQv5iafJgXq9+uNRZ3ofE1dIRQb6wLGrc3TTRAD8lv1L7tIgxQwNn7brx8Sq6XO
 XE6BZDpytZ40ggCWHP1yBk6BPuXn4a5mAmpJYCvzuuHneOYqyOSGUCzPqmYWuO/lsx32oefCX12
 3q9O19R+ORksTjaWBA/kM3gXegeTIOooMhQm3CHJDQTE6gLVHUVL5vHpbkVqlQx355ZIFgzWZuu
 epVAVpW5C2mXkt8bGJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190076
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

This series adds UFS clock support for QCS615, SA8775P, and SC7280
SoCs and enables U-Boot to initialize UFS clocks independently.

Previously, U-Boot depended on earlier bootloader stages to
initialize UFS clocks. When these bootloaders failed to do so,
UFS registers became inaccessible, preventing UFS initialization.
This series removes that dependency by adding clock infrastructure
and enabling U-Boot to configure UFS clocks directly.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Balaji Selvanathan (5):
      clk: qcom: clk-stub: Add compatibles for QCS615/SA8775P/SC7280
      clk: qcom: sa8775p: Add UFS clock support
      clk: qcom: qcs615: Add UFS clock support
      clk: qcom: sc7280: Add UFS clock support
      drivers: ufs: qcom: Initialize and enable clocks before hardware access

 drivers/clk/clk-stub.c           |  4 ++-
 drivers/clk/qcom/clock-qcs615.c  | 63 +++++++++++++++++++++++++++++++++++++++-
 drivers/clk/qcom/clock-sa8775p.c | 63 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clock-sc7280.c  | 52 +++++++++++++++++++++++++++++++++
 drivers/ufs/ufs-qcom.c           | 45 +++++++++++++++++++++++-----
 5 files changed, 217 insertions(+), 10 deletions(-)
---
base-commit: 33756fd4a8157d1d921a703c4fa172f6d2eadbd2
change-id: 20260319-ufs_probe_clk-1a03ae24b4eb

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

