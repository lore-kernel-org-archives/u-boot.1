Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB2DC61DFD
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 04:21:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF784406C3;
	Wed,  2 Sep 2026 04:21:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5JLlS3Sv9oBL; Wed,  2 Sep 2026 04:20:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788322852;
	bh=8FEAvrOQJ6o86Yc4R42eZcdP+1oQ4XRfcES8B2/7ICY=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=D1VC6UH44mXTzVfYhhwO2DHlQV4CpKVSVa2UVY/S9Jba3ponUFCehdc6sjugsOsZb
	 ZnSoyqN/+GSgB80QzPinyDmA7YieIb0iUzimuKvExG3wi48+V5UGMmjLdjEyL10wDD
	 Zl5M76Cavt/cvtSpSbj9AhKXYqTRrixBJoJ47CG7pmJ7IBV7RGwTTUfBooZykwi/dS
	 PdVpbObn34mD6V/MmJaLWrWJL50DdCzGVvWKm2Kt/cAH3xg25u9PcEl4B4XT6XWaiQ
	 vpyF+g4TAuHgIPoIBXM6aPE/P5TbjFhQioX4FZahm/77D5sPdfJwpZXwmevo6Y1apw
	 AKB0NweIFD59g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FFC0407C1;
	Wed,  2 Sep 2026 04:20:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 597A51DE
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 19:58:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 41D304026B
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 19:58:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 23_i_lKItGer for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 19:58:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=m3Ckjv18; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RNr7jzVX
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7AA4540265
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 19:58:33 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681HgKVI2623263
 for <u-boot@lists.u-boot-project.org>; Tue, 1 Sep 2026 19:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=8FEAvrOQJ6o86Yc4R42eZcdP+1oQ4XRfcES
 8B2/7ICY=; b=m3Ckjv18uuwELbEOPFAtAL1c+n3GPYjEPv0f1gYVIPWfypgXHNZ
 YkGgzD96D1zrA2EpJ3o0YfVMjxev2q2B9hHdeYWx8StlRSTLeh7nXJAiIw+wwPyR
 QjSbfkdaU7oBvc7ZQLDJSLu1KcA6nq8Tp9VhdDIPcnVj6ehEMU21R/gedwWHItj7
 CC5YuZ2MqMnWJbT7NKOzegNmorsHCRRAC21AuHBLSDGgGHVA5G01vX8NdmNopSjl
 d7IriRk9lGWyuT1wF+Q8lu0iqTNCiPaZrz4D6jv+deP82UBeJcW+5Ts2cakGlGOD
 sfspWvYsFVk2F2uC3/U26y/zFqUroR6or4A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge35k0kgu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 19:58:32 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-398dc3d8f0fso1621015a91.0
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788292712; x=1788897512;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8FEAvrOQJ6o86Yc4R42eZcdP+1oQ4XRfcES8B2/7ICY=;
 b=RNr7jzVX3QnB4z5qa5VWYdBoUpjALmebpDEbXeEBV80ewpMYph5Lh8zXBf5Zf5rcqo
 wEFkc57rnJBgA1g5tIMzeSQF7GS8ikt5Q73zbHjnw9isKr/nQaNMwjTMzHHtYJVPjgZ3
 TUC2W+aGjKrfARWRARNCIjOBy8gVCY08DfCmZaawCV6o83mQvEk2KWgZJjkQFdZ9Nrfc
 SCgUBfa7Gmvk6bQgo3+0hRit2fPRwJJpgqkg4ZFI8DEII24+dMhoEFRmVCH51p5TXj6E
 oba8uiDvbryYDBwy0ZSjZTF9cE//ofU2kF2HvkPUZmCTnplZUTGUaDNwIXvEK3U9IAy7
 dFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788292712; x=1788897512;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8FEAvrOQJ6o86Yc4R42eZcdP+1oQ4XRfcES8B2/7ICY=;
 b=MBxBbQdaDbucMaicvZJxNZcXwk6lG7Aq86frRNRVpqZvdmsOHVeltJIy/QMJKBDgzi
 B01UA0aQ5A93p+XjYEiHUcXqDRB1pYZGIHSQxcaU2WpTSq9mH37ofRCnv53uKs8Ks0w9
 3ETSyUc4ucBdq/evrt9KifKk5T7YNjiEFVOqmtq5ENKCtFeRpUJw+2hzPZY2o9kEL1Lc
 f6U3S8Lryj4jiNiNUsJLGwAxzudxwi/+2hC35LNp66a+goinDx3yWjZ0u8V+mTImtdX8
 zFcAIKzbUgLIuXZ/E27m1NP9KBeRD3OtDP9cokYNOXRCsPIWBdDAng3UgiyO5iFm8lwk
 LnwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDhZYXX0Jalo8/csNUvA48qxMKrF0+d58dilNc53EyJVRQ7PFlKcVN8AdVsl//Legm6Yz87kk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lj25qEYTQw3dXpGZRv0sXg5uqjl4SHCRoUXzo7dq7AN6/3ahSH
 DQRwp/69M2iRAmWCJjUezofoEOHkyr4LCJGp8lWztehFhA3q70qUznhCzbf49qAZj5h9gEXHZYS
 mlogzV7nOLs6AS64Ih57xgOAiohu9sAKWK0tG5xuoFV1Z58EuWCKOvf4PxvXSe6entjNZm30=
X-Gm-Gg: AYBFou19k4M4FsqUNv38bWWhcZWHYhdC16aN5YCP4itFh/uWOxgoNR1Sdb+cti0xQRd
 hU1Rg+MLjCp/Nw/Lkn5N5hv7boBkWGFUnqoL2evAwnBzi3Qkn7ui8GzTQTQX+CXfS036mqwhoIN
 S4oFtbLgqWq0/eWFAV6bA99Ye3gb8iGIPOQkh7ehfuO1THA5QLp0g3KRLOkbWYwnpuJ08xaT1nO
 nO5z3UNJP3UWFtdMi03w8RGDBptK/SyjXepuvGxQtu/LLkAT+WxsHEAvSfEui1MOjm4uEcrmaoQ
 TUJtXr5bz/3kP34ofDhY5U2Ia+oeEBrw74Xe8wbtKxc+dVCY6IHFFulfnopoWKoimKZdMqqNCvj
 gJjpoU2bi682MKkFbwUAYLwlaKYv32amZmYvqM7Y8x130NeHiNY8qjankeY0W1SWO3g4t/c8d7y
 Qxlno93W7TNROR5zcC
X-Received: by 2002:a17:90b:2604:b0:398:c0a2:8f8e with SMTP id
 98e67ed59e1d1-3990f90e0a0mr8793899a91.26.1788292712124; 
 Tue, 01 Sep 2026 12:58:32 -0700 (PDT)
X-Received: by 2002:a17:90b:2604:b0:398:c0a2:8f8e with SMTP id
 98e67ed59e1d1-3990f90e0a0mr8793854a91.26.1788292711637; 
 Tue, 01 Sep 2026 12:58:31 -0700 (PDT)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1430eb4854csm726433c88.15.2026.09.01.12.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 12:58:31 -0700 (PDT)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 sumit.dhami@oss.qualcomm.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Subject: [PATCH v1 0/3] sysreset: qcom-pshold: Configure PMIC PON reset
Date: Wed,  2 Sep 2026 01:27:45 +0530
Message-ID: <20260901195748.1192630-1-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3NSBTYWx0ZWRfX4AE+a0Y+FdDU
 QDFzJ+N+gUA1y9EnGu9UnS0l23ZNFE0mo6uciPgcvTQiIGDRDWvlHONiz5iktC/wGofckQvJpO2
 tIujJp29pvoOl5PwMdZWHoqMZy318k2/iPdRNsJaNw2vl/Yoh+zCbzu1IPiK5lK4ZgyR0MwrCR/
 AkOfg4GR9urIhFbMSf+f6Rm0c3hjC7O9O7EpmgZqaz9W2pgN08/dm6yqD8JDrOEI3/A47wlBN+g
 5F2+e/km8e/HCoD62Q+dV+k5GmBS5d+cOJrF1XDUftgIifbGjFaf7K4Y3Lpn29T9ALO8Grl7LJM
 5Hq/NXDp6aLb+XBSgvVm+gZcpOa/boGkm1UcchQn/vhWMlWp0pcWZn8NkPnc8ubP+cGVRYL8HeM
 Cv9W2OCZTmRfLscFhSUbQG6sNWb5e0FLkJj5bG/+JlOWLLw04zDuQbNc8BqJeVriHF+7ZwpjYoQ
 H4gp7xL3Dgkk3mBj0Gw==
X-Proofpoint-GUID: eRd8sDRviYhAA0YiNBv27y4-NlMBc7xV
X-Proofpoint-ORIG-GUID: eRd8sDRviYhAA0YiNBv27y4-NlMBc7xV
X-Authority-Analysis: v=2.4 cv=VLrtWdPX c=1 sm=1 tr=0 ts=6a972e68 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=xvzcR-efelFLnJjPOmkA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3NSBTYWx0ZWRfX92bukoysbM+y
 DHHXhBbW91qfLNLBHec5UqT/1CRgS5x1ZH8BEn9NcihaOtbROyFlmtWpj2JYwptYBHxCX6tXe/S
 ou/DdGRyb0jC2PjDQGgCRcUPsHz4AQk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010175
X-Mailman-Approved-At: Wed, 02 Sep 2026 04:20:49 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The Qualcomm PS_HOLD sysreset driver currently deasserts MPM_PS_HOLD
without configuring the reset type in the PMIC PON PBS block. This can
result in an incorrect reset sequence on platforms that require the PON
PBS reset type to be configured before PS_HOLD deassertion.

Add support for configuring warm and hard reset types through the PMIC
PON PBS interface before deasserting MPM_PS_HOLD.

Sumit Singh Dhami (3):
  sysreset: qcom-pshold: Configure PON reset type
  arm: dts: qcom: Configure Lemans PS_HOLD reset
  configs: disable CMD_POWEROFF in snagboot config

 arch/arm/dts/lemans-evk-u-boot.dtsi     |  12 +++
 configs/qcom-snagboot.config            |   1 +
 drivers/sysreset/sysreset_qcom-pshold.c | 137 ++++++++++++++++++++++--
 3 files changed, 143 insertions(+), 7 deletions(-)

-- 
2.55.0

