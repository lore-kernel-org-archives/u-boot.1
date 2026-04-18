Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD228F436BC
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 06:36:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69BEC83BC8;
	Sat, 18 Apr 2026 08:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YJKUaQix";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V7ekDr6G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AE6F83BC8; Sat, 18 Apr 2026 08:35:59 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 134DF842BF
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 08:35:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63I4V0Zs2013190
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 06:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dej/iyFtDn6ihRvcPDXfYHcsadR6fCdogM1wqzLdN84=; b=YJKUaQixaTopFts5
 Kbg3995AsvPgK6naw/V87HNVz9mJWZb/xL+m/1nDEBVJQaoEHNmJ9wMEOJjgKjYN
 8nbeh5ZY6jkurs0Fo2uSMVEzJbbwiOxxuyGx6RNX/4TvYQTtl/Ub8uP7yfTlsUiY
 uLTTTGIyoo2taA6W1Zqmuq5BpW5xVJjrvpHtNXE3DRAhJnaVdimynKRuF9VesN2W
 zGZVazIj+cTkvq45vwaUvBO8rHbyOl55xVmQjjgMuj7w6fJduhl7LAKFNGcm8IyU
 /1iZvT/VX1Wxs9DC83iDyGuc2UKAVe23VLzMZ7UGKn4YzMLzLt+nR9F0pNWrCG5m
 P8dTJA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm0y60ct4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 06:35:55 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b2e8bba2e6so20286215ad.1
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 23:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776494154; x=1777098954; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dej/iyFtDn6ihRvcPDXfYHcsadR6fCdogM1wqzLdN84=;
 b=V7ekDr6GBcwpYAvVvUtLxwBN1Ng+KSdJ6kk5ieawMDqQ4dmWUN+qsa6287Bx6NYed8
 JLwlGJVN494gWqmVsVXa1ZDpaZ7HE19uk+W51Nc72q/5SphO1Jr9wYlicZdYSs5cEX9e
 Fmmd2k+F9d/UIpcraGkwHA/wGMS+eeEEm5OkLbJ837xLIb5ZjGpHplmCa1G8F3QnV/fu
 864vxCQHMthC0yFI4J7k5PZzPFF3+K8KAY5P637GzWC2SDXcja/cpli2ro5aRqziDCGy
 B0n1dzmyWizjc16OxURb340FFfqrY4ns+YRAvDfQbrj/HsOGpRI6g+Ytvn151hzFFRMx
 Oeow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776494154; x=1777098954;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dej/iyFtDn6ihRvcPDXfYHcsadR6fCdogM1wqzLdN84=;
 b=THpi+5q0UNx8X9K9KPVefEtd5+aKiPurylYo04plsWvrjQeO1gPT0DlKG0XT5w2sHF
 3ddu9zUPXyRXrrNsTJoDxXaPwg3tGZmLv8M/+Bww5R9DOmKxLaMwSBPYtE2JceN0GEdR
 LClVA35nhvCzPprhHVXMPvz0FPVzOZb0Re281ly521+/KoMfRC7++WnAdUsQ/ptXf+Bn
 Zdo7q4yJYcI4vEIzml5BtNSQdsZ2oobT+wiecDjjLYtmI8j+bjpBxPIw1dqPnk3SOZ9b
 wwvjfGxlWpnGWIAmezHq3d48Gkt5ZqZDGcLeUCYka9GEfk4gVSvVzS+RLFD2FQQ+BT7o
 Rmdw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/VdgFNWwjaistYA5tQg2YeQLvOelp+VQWa7JzbyJ5dlqtMDxayRbQEu5c8+YxKDeBpW1U8OnQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxLvPisMErWzrC/kQI7kItGhsvqa7wYggcb9Rd4Kt3+tIq2SmVe
 K3JEJNjgEHnKrRq4Z3JYJ5n/60lBxHFziPeDz2P4HRhzzZzfmqYaEtYew0azaOnxQqRcW7gQZCN
 +xMOWcclqUaMiAK95JeiMD22ccRc7jlfv98PV13UKVSezFX9wzpKG4NMG
X-Gm-Gg: AeBDieuf5A2I5xCqDRWzgOmStcsimJSVrR6slfJHIGYVxZcLI1lM09uFlozXGL3lxQu
 PRvmjzF2LNhSClFFxEsZrHkuJnFloKSh4YKEbsrHAfgJD5UtG7tyCaVnY3uom5mCndSs/9xaMwI
 PQwZPPDPZA1adWGQ9Jn5+ob/Ywm9YtOkyh2nqd/lqb+p4xU77GkwMoWu13H+WvJHpMbOx6MUQzy
 XQKnSHod3aFffGbOJBtnSvK2C5YDd5W78KRyrhXrFBdjrtMkHdxxp2mlcScxnUIo1vywBad72IY
 Hfqz6jGwtH3X5soJ1YC4W77fW57j4iPpVLL+VS6WMQ1dFZf1X/vPUi2Py+dyviP915y+yGF9ENJ
 lfb8/KBeJP/2EHXGjXGcmtZSJZMAY2dYSf1oa9BOuamQKAzHt2L7hU1l06DHO3gYWhSoaKRWSZG
 1v88ib+f0RT5DxHJ2OiECKMJ9wzmqQl0XOleqC4f9/IUHpCp5203S/EuP4T+1Y
X-Received: by 2002:a17:903:2283:b0:2b0:54dc:63e with SMTP id
 d9443c01a7336-2b5f9fadcd4mr67121805ad.33.1776494154519; 
 Fri, 17 Apr 2026 23:35:54 -0700 (PDT)
X-Received: by 2002:a17:903:2283:b0:2b0:54dc:63e with SMTP id
 d9443c01a7336-2b5f9fadcd4mr67121445ad.33.1776494154039; 
 Fri, 17 Apr 2026 23:35:54 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab20d33sm40542345ad.63.2026.04.17.23.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 23:35:53 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 18 Apr 2026 12:05:22 +0530
Subject: [PATCH v4 4/5] configs: qcm6490: Enable super-speed USB support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-kodiak_ss-v4-4-d381670c9d78@oss.qualcomm.com>
References: <20260418-kodiak_ss-v4-0-d381670c9d78@oss.qualcomm.com>
In-Reply-To: <20260418-kodiak_ss-v4-0-d381670c9d78@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776494121; l=707;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=gIyjSsqgR8Vq+DzLQT3etrQNK1xlqOa+JND8AN6u3Cw=;
 b=eOnnM7N0TdbcERHX79hc/cvVbS7k4ZCamLPyGRD465j+0+qGxuNurS4uA5Ju68SDJ2a253J/X
 8iCRzAGY4GQBPazU6nqdgYbaeP821WR3JBgkTO5IM8PFnQbhRceiKev
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: 5TGxYre908h8aNySuTZShWQ5ubIkW-iN
X-Authority-Analysis: v=2.4 cv=Fpo1OWrq c=1 sm=1 tr=0 ts=69e3264b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KbCl6DCfew7V5gVLQd4A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 5TGxYre908h8aNySuTZShWQ5ubIkW-iN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDA1OSBTYWx0ZWRfX8TbZl245FCRR
 3y4p4OPcoIxtYoBDFIF751BjkZPmC+KBmfNdwYVoF9gdrQTMaeacH4UU4ZZHbcr2BLmMQ4Tjamv
 4ImM1y9PytoptxXHE71uRChv+XClSyoT2fHI75L6TrLIkaz9lTDr4Mk9odaiR00TXcyUlKAH7zO
 3Sxi56PfP+mAtpVwifSCCuHz7DMUwJxw2oKpU6TmwToOaoadIi9dPX6ueY2OaelsFKKOzCsnVVS
 Q0noTSf+NIFv3Q6u4zeWHQScvVGAF1mtf863tTNb38NP8mKPcVuU0IQAi6DipWNeWd9vXeFSu2x
 0n4TOPm/nUYyJx3Y90r1eA2FrYWnAp1qnF40mttBhYVjE0uofbclguIifxkJNp226q4VLi+0mZm
 zVtYDMOM/mDDpimuVUdqxYZtC/Li8BCxRL5K1hOo//x/2Ae5C0PKsMnTWVmHIzGmKcHptsEqt3v
 vyz3uWI742CzVkqmlrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604180059
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

Enable the QMP Combo PHY driver to allow super-speed USB
operation on QCM6490 platforms.

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- No changes
---
 configs/qcm6490_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index 618098c8860..9756687d8f9 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -15,3 +15,5 @@ CONFIG_REMAKE_ELF=y
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
 
 CONFIG_FASTBOOT_BUF_ADDR=0xd8800000
+
+CONFIG_PHY_QCOM_QMP_COMBO=y

-- 
2.34.1

