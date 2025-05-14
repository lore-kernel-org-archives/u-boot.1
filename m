Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C467C3ABC5
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 04:43:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73FA382A25;
	Wed, 14 May 2025 06:43:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VHSeVNF1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79F7B8294C; Wed, 14 May 2025 06:43:05 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A0158129F
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 06:43:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E1NkjC025957
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 04:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nohyAaVMl9f
 KrNG+Fi4p+nqAnPZPCxzqX/rOIQHL/cA=; b=VHSeVNF1LT4zk3GUAs3SBE6HTER
 kuD4kpAM4AOR2ahe0P9gDd7tdni1MyGAP50nP/1TY8AXGrtkC3+ZQ8xdjU1HANhO
 O/r4nLgbO2gHYi3XxggKKZGD93/9jRYMZohyIbpP5Ms3SuUOwtxwJzmY9aSxIJM5
 Xid3K8tSekPaba6YvxxEeX95iPGix+cBGbReahH+PPYRwb7AZc5bhp6Ebetg2Ur3
 ggY2tB27KMzxcgM5C+5FjhjQmJkcZZDcXDpiWwU9jAV91QLquhfbGKGTVmj50yWe
 rgUEOztGAsluF71lPoRQytJ1c47jG76iLss0024te+4jvOOPgq4NINHGx9A==
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbew1c26-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 04:43:01 +0000 (GMT)
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3da707dea42so152785805ab.3
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 21:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747197779; x=1747802579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nohyAaVMl9fKrNG+Fi4p+nqAnPZPCxzqX/rOIQHL/cA=;
 b=DchzDdFflI9+8Uaaq++fDmUBQ0eURrhev9UMosHgcGqKH4y5efWuwNzZCs2T/D7cvi
 jl3Lzy6Jq4trIY4J8SXubNaw3dDeS4C6H8EpWka2bHm3fRPyPSgKbqmchFirL/ZMwohR
 r+BHkuyU6C132b/gH7ZdHJdC2RBn8oJxDH3FAgqvs4Q62/otGeVwYr2vCumgLAxOFQ9k
 hHUmLfItxjThvaaJmh4F9ASPD6zEuQzO3YpNH5U/jGX0uV89lrqh9V1jqhcCqZgMwSNI
 I3KxLtLhGRND2yCcpleG9Xi5rowcfcWdYNerHnhyfycMtg/z5JLjgcCtOc7hqWbexoEw
 ffuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXNNERWpV9eB5E6Gwv7/lCAdhoIDW8LQfY692pcb+P/TkawHixxhmed/Q/WJCzfJwq3uId0Wg=@lists.denx.de
X-Gm-Message-State: AOJu0YxBaQourP4hjViK7AaNRY62Bz37FiPlvBmdicwChaIuHNA45z6Z
 2XQUanPR/nQT3rsQfFABsKVVAo2aQOHHuTUUbUPmKvgVU5rsINjaCUv/2SngToTmZDDgU8nDc16
 y8WJdqLYcyTJ48p67EQ2+5ZfgqVocgkiRSz3m0tTr9dOKUeL2JM7tX9/rq8/b
X-Gm-Gg: ASbGnctvkSQSOIsnErCz/VAn0Peg3mKpOmUTZDPssSuWJr8S9SefjRF6wMN12mmyNvy
 P1OGphIJ7FZFmOZx1Pkz9nY1Wy1fnXt9wF/UT/otm+7SUwqNL2Pj1WZA2I65p3Qf2+D+LZ/DkL7
 qHbA9XM1UmlPezwIaWRSRwcppqRltOG8d3JjKr02GKmLjzGvbHnlnvDWFGVXe7DOxvtNA3L8xSf
 f2hhmGqbGnKzVynI/U1Y/EnOrk9dc31DWW8r90kPBCtTWWK2czgrm1UGS23klOak64z2j14PmFP
 0i5T/Qe7+154wNUSIQQyJLR/8DEen83EkXsw6sMrK0/YQB7MO2l0YM8nqI4ILDsCi1CO7IwTlZO
 j5DT40SXgmlcC4dxiyIrZH3/EdRNkUHcFP4RzV5f2
X-Received: by 2002:a05:6e02:b45:b0:3d8:1b25:cc2 with SMTP id
 e9e14a558f8ab-3db6f7ac93cmr22115105ab.8.1747197778879; 
 Tue, 13 May 2025 21:42:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkR8/YuXLP6L+Cfcfo5SnnZ5bgXEGqknNOXyaHRp7s0yEPXUHvpFziS06QnbiH7+F0+o3XMQ==
X-Received: by 2002:a05:6a00:ccb:b0:736:5e6f:295b with SMTP id
 d2e1a72fcca58-742892af2ebmr2839600b3a.12.1747197767637; 
 Tue, 13 May 2025 21:42:47 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237a3dbfesm8889588b3a.138.2025.05.13.21.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 21:42:46 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, sjg@chromium.org,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 5/6] qcom_defconfig: Enable QCS8300 clock driver
Date: Wed, 14 May 2025 10:12:11 +0530
Message-Id: <20250514044212.1422714-6-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514044212.1422714-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250514044212.1422714-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GOVGmtJ9pPTJ3zvNmu7xY0lNwUNh-D3e
X-Proofpoint-ORIG-GUID: GOVGmtJ9pPTJ3zvNmu7xY0lNwUNh-D3e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDAzOSBTYWx0ZWRfX4Fg/ojxUQljY
 4IMjVMT+AbzgdX/LNlW24+Re8AoFgJMJIML72zxHC7NC3lgd92id/On0FxQW5fDegdYK5YkTgOp
 fO5p/wMT4tzcW/N7zMm6JycRFoyH1355pLt/3mPakHmAL/78qQjL/QwDYbHj58dTO7Ff/I6QgH5
 A1qTtIWgRjrw+d47orgylMLY1eWY5qE8PH7rGdPO4eaV+Gxx8zKi7FgeMYuDzcymHbuWck9OEdy
 NjWYOElsvSVXEt/y1L95O/aQbi5BbdmCXT0hk6iq7tNNZBi+V9qUesL5nwkiblUeXExHYcgDx+6
 ljH5gWEUwyrJDByTAf6tReGaogOyKHAkkFTbp615E2pHYV7caiOzB8gfQYrPMGkrmVSEk6I5Mwo
 2HGiLvBveG+XDb5MfpA+fMK4x0SDi5I/Fgp6fjkA/Opa2kgSHuTi01mtFyyoBNjJTcUIsN4N
X-Authority-Analysis: v=2.4 cv=LOFmQIW9 c=1 sm=1 tr=0 ts=68241f55 cx=c_pps
 a=i7ujPs/ZFudY1OxzqguLDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=UEOwZ0Wwne9dpINdEAcA:9
 a=Ti5FldxQo0BAkOmdeC3H:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=795 impostorscore=0 bulkscore=0
 clxscore=1015 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140039
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

Enable the QCS8300 clock driver in Qualcomm defconfig.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Arranged the configs in alphabetical order in configs/qcom_defconfig
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 537806450dc..e27505bca22 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -51,6 +51,7 @@ CONFIG_CLK_QCOM_APQ8016=y
 CONFIG_CLK_QCOM_APQ8096=y
 CONFIG_CLK_QCOM_QCM2290=y
 CONFIG_CLK_QCOM_QCS404=y
+CONFIG_CLK_QCOM_QCS8300=y
 CONFIG_CLK_QCOM_SA8775P=y
 CONFIG_CLK_QCOM_SDM845=y
 CONFIG_CLK_QCOM_SM6115=y
-- 
2.34.1

