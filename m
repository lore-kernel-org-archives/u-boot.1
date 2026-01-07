Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E758CFD647
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 15:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B29B8398C;
	Wed,  7 Jan 2026 16:48:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="p10SzH7f";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G1QX+Yy7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E0E5839B1; Wed,  7 Jan 2026 16:48:45 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4163838E6
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 16:48:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6079dvvB2593341
 for <u-boot@lists.denx.de>; Wed, 7 Jan 2026 15:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=VoiPeHjE5NA6S8RXpkM/75ua5zatDVspGYs
 NZ7Y1+Tc=; b=p10SzH7f6p6PWB+w9kbTZ0cLRiOnnlSzSJeoorF7O1u3w+A5tNW
 UARshKIkmpi2Nn277wJ4rMTlZZbnkgEVpjue+h7ZL+lfFt1zCh31K46iceD2moS8
 AOlehYakylllE47hA8I68mdpwD5rH/BfO+AuicwouI8yEdMQFV6cqzR/0kZ18/WF
 QS5xWZl5bysoK89FvjionZ/2k94wzJhh5AaWmMBZg9QF7CQ4yTSI9F3rPX2XoOH7
 s/1yENqYXXhprwHnogLfDZV+wm9ypP8lZQAPd1jXEa9rXEnjWK3/beg8vTDM75QX
 fgf+OzV+XHOqoIR6KpF93yZjRSG1KlF1RzQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhn2913pq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 15:48:40 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-29f27176aa7so36386395ad.2
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 07:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767800920; x=1768405720; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=VoiPeHjE5NA6S8RXpkM/75ua5zatDVspGYsNZ7Y1+Tc=;
 b=G1QX+Yy7opZ/TKfwKLp0rfhtgrTu9r2rdeSHryL7sxkIiNaTt4AqueC88fVQNuCJVk
 TLO/4OjciMP1gxrkpkVVjagXgOLp0SBBH7zEVQ3idTjsu12G8gmygOBKuv+s67ZJNX3R
 Pas4Jw62853DkWpDiUcU8Jtq5fiTuFmsn4rSk7WIKy6J+rytcJ3f9TSqzFyrIN5ruOu/
 48JfiQhMGs/kS7LTLS9fB1hTaLUhKPROhNZIUDIb8yPwdMDvyFZHwiKwf0x/hu/yAKHg
 eQ1mx0dDiHVx/k0vlC9yd5XQ4yy7QZ2rWC1gf1TxNT20pQXnRzFvdGRjcrWIO2CBeaeJ
 ENgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767800920; x=1768405720;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VoiPeHjE5NA6S8RXpkM/75ua5zatDVspGYsNZ7Y1+Tc=;
 b=nus3JB9lDM/pT4cqB8D0gWnSLA/JrkpQ9Y30CW5Xc/k7ADAvOCglhjlTmAyoDsnvvX
 iqWpVPhzKpoye/yf5hM6wP7+x194miFMY6Sij6yKb/fCJyQvB2SGxnU4NdDsTOc7qjer
 1G+It00WHBTOC1CDq7c9Sn6iA+jOwMC/X+/DAIgrIV46Fml1YNlZrQBwLEQj4bqiVu/y
 aLy8ZHbPvzRMODpn4kJx+4yTKprImBKeg4DPGPagR21BUlepHjYotMhbSqkQJGS7dbu+
 aQJKA1M7d7zLarDpuwzmEwnDovKbEL0txSd55/pbL5+Ut0kIsNv7ljUQJqHfE7gGWn0E
 Ivug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuBtEx/tWF21OnfGvXty4jtIuDPUfaUwOmxQJyIpGy4IE0ylsqqSsYwNLJ1sppFP7NLK0Z14U=@lists.denx.de
X-Gm-Message-State: AOJu0YwsA3qowXWLwxdgfH1zMmqjM4k/2AuOAEvpmaQM8BTR4fPUVKTa
 rIJCbJY/UvCMEgx/NDSVLjedqwwK+qxE22kgG4wA6BQcgmPv8/9xitrqnpCj/AyJYJDeSOWrnXJ
 1smLXbzdQPbSu2ygx1RtCmhe1+3bPheNY/kLZjDQGe75NOoaI908X8UGe
X-Gm-Gg: AY/fxX6j7fUd4zOHYBFfbWjiYhPrixy14sznIwh1YFhFcmsEQ2TadikG3Bd5RCt76Gu
 f9zNPlV8IydraCwcmzGPFw1En+ti3xW8CwtSH4x2iyec+ynFsVZUrN5f40gGK+gpFp6SIkZC+49
 qsi1RBJiez5yms7Oj+ZLWWom+CjIleYtHW6B253nKL9QqwUlhPjQ09cDhRyz6yzAL/DjUlp0Jhm
 bANt9ppLDc2rm4Nqw6P/1xniLkJWSsI/vNqX1nDgiC9PdYqOtmGe+B8bHouh5B9ujlIcAfuX4Wq
 pmM5wpJ3gi9nYn0QoQGDfrgCZGdibrbqc09g8CAae0ED/uildrm8WIY+mAZ0PbovVdpX4CG5jVC
 MnwD+A4ZFNwuAQ8iVRXSyLlCH8qyale8KbL/o1I+M0UmLwG/yJ8U1dolSiz2fn7k259BPM+9teO
 1DAL4skgm1ptsmRvq9XnyQHomY7z5/
X-Received: by 2002:a17:902:c407:b0:2a1:14dd:573 with SMTP id
 d9443c01a7336-2a3ee429d3amr29296545ad.23.1767800919925; 
 Wed, 07 Jan 2026 07:48:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdYN5o3ZOXx6GthcUW9m2hOufhwiJ4gnNLE5nnXccagu0UFP2hAUbWGG8l/osnoZomRKnc8g==
X-Received: by 2002:a17:902:c407:b0:2a1:14dd:573 with SMTP id
 d9443c01a7336-2a3ee429d3amr29296245ad.23.1767800919456; 
 Wed, 07 Jan 2026 07:48:39 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c47221sm54219005ad.23.2026.01.07.07.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 07:48:39 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 christopher.obbard@linaro.org, quic_varada@quicinc.com,
 marek.vasut+renesas@mailbox.org, alexeymin@minlexx.ru,
 danila@jiaxyga.com, david.wronek@mainlining.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH v2 0/2] pinctrl: qcom: Make pinctrl drivers default y
Date: Wed,  7 Jan 2026 21:17:43 +0530
Message-Id: <20260107154745.571319-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -KXzgbXm5Lzc7oC33yYAWYCgAgJpbVoc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEyMyBTYWx0ZWRfX/pZ/HSqH/2/j
 lvKfzq5BcSOcumpXsRQCK+lJgEICOilzvr1KjwWDxNPeMP7VBUcwoN9EP9gslvSHDDVtaYlM62U
 rNmW7XA0WT/YGeBJGVsxtYRANt0tTbHdffrQSjAsCj0rbolxuyuTYINNPQKWlnDLCBFfBWFrfRM
 YaqdNLqsQZs2bIQ98y9LPIr5HVAxLY6VfMybU/hZRK6G852eFv6TtnO8vS+HOdQkZ3WBhDfBDaY
 sYIWL3CKmzfIMplanfMVCzJFtYgYcXu8ZFrPSxyD8UkBmMJJBUnZrWTflX3KF9xPDamq+f20/Vd
 n9roNH89LNjvhXdL1hQRg5L6AZuAc4VCAVdclirzdOhw9rSwbk2hbpMhrvp+fVNwdNGFyI4kITn
 ouV2nQhmh9cWI+J2+8FrKgeD9UFGxFE7QnUE+IuGxkwk2eY6oRCRrG3LKtGjw3sSxCkneAGA4hz
 W9dxdMAosnrLxb6GXpQ==
X-Authority-Analysis: v=2.4 cv=P7k3RyAu c=1 sm=1 tr=0 ts=695e8058 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hFpiHMTvZr1_hkbVHtYA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: -KXzgbXm5Lzc7oC33yYAWYCgAgJpbVoc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_02,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070123
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

This is a follow-up patch series to address review feedback on the
QCS615 pinctrl driver addition:
https://lore.kernel.org/u-boot/20251112164758.1560041-1-aswin.murugan@oss.qualcomm.com/

During review, it was suggested that all Qualcomm pinctrl
drivers should be enabled by default based on a condition,
rather than requiring manual enablement in defconfig files.

This series implements that suggestion by:
1. Adding 'default y if PINCTRL_QCOM_GENERIC' to all qualcomm pinctrl
   drivers in the Kconfig
2. Removing the now-redundant explicit pinctrl driver selections
   from qcom_defconfig & enabling PINCTRL_QCOM_GENERIC config

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v2:
- As per review comments made default y for pinctrl drivers
  based on PINCTRL_QCOM_GENERIC config 'default y if PINCTRL_QCOM_GENERIC'
- Link to v1: https://lore.kernel.org/u-boot/20251222115144.2146964-1-aswin.murugan@oss.qualcomm.com/
---

Aswin Murugan (2):
  pinctrl: qcom: add PINCTRL_QCOM_GENERIC to enable all drivers by
    default
  qcom_defconfig: Remove redundant pinctrl driver selections

 configs/qcom_defconfig       | 19 +------------------
 drivers/pinctrl/qcom/Kconfig | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 18 deletions(-)

-- 
2.34.1

