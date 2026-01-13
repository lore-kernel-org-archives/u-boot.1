Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5232FD2D0E1
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 11:54:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E6C2830CA;
	Tue, 13 Jan 2026 12:54:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="A5ZIRe5i";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CWlk+HHR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ADA583045; Tue, 13 Jan 2026 12:54:33 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD29182B20
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 12:54:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60D534tf2865767
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 11:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=H4r+GEoWlt9M9OUEm6mXBWujvlop9Fpteb0
 AyHtBv5c=; b=A5ZIRe5idIRgrgKNN2YnmllvjarXnjQjQvvWh/MBq3LSttRGqGI
 Q+bwYWsCl/SMV1wlRh2VBmWOG4+9xNzIThQWgkWxY8RL6rjoQprxQkjeC5pHieqJ
 sgnmDhU0jgX3RN3uGO3ygAmz5FV0ABC9QZmM0JmwCen+J3GgDGhS1KoDL1frNlAL
 VIA9VXl3CLg8nxIzt6oDWV+wW6u8zn2GRPZFgc/hIV6+87H3PVDUxaSy8yPVogzn
 lK5UFhqBa1yg6pQvyAf/o6YzzHHwBdgH+uWbwfKwjWC9+nLza051e6iMkhV8iUhF
 nM270rcNI19N2Uj+VG0d5PixLsljV7K7T0A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnfjh98xr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 11:54:28 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b471737e673so10131582a12.1
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 03:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768305268; x=1768910068; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=H4r+GEoWlt9M9OUEm6mXBWujvlop9Fpteb0AyHtBv5c=;
 b=CWlk+HHRmfI/d+gKvq9+yMVW7ANR2P/drdVGH3G3PU3hdI+EZp6XIiIfNowD/Kwj1g
 MDDa/A4lZSz5Ve/xyOgRez6Al5w0ElMGf7ZJtZDgdODq6vCXb7CPo/RPKYMID77ePdEC
 KuY9hTmLiJEmx6fmdIyQJjcFCOMgKBv3X6eOBakFQCjHCjwi0o43QP7/ghwoBVKPmg/8
 TYe3qhXtWuJdaxn9R3JG/corgcwxLYrMuGmkma/dXjuehLFGEQe54oOIuXKGLxa3++Vo
 ynJl3LElcFI8w3G9wjYvTO2ENtfZOCDHREeHCcu9qCaOtvY7kwq76wvvETDBr46/YFnd
 FkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768305268; x=1768910068;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H4r+GEoWlt9M9OUEm6mXBWujvlop9Fpteb0AyHtBv5c=;
 b=sKBpeMl4t4VD/CH0mpcJvyYzddzC9sR3Vm73RBaf9kMNjU7JFB0PiGQOdQnC3wBHou
 j6ovlzbODB4ABqOl2qX1n+w3d8G4O+DlWvi2MOXy1LJsfi/z5YHuKemNwq0VEtQ4jjJX
 FSE5SIZZxovEKRpUloq7UDBz04rNxu8ScUu04PDt3Fr4jv/M2ZiRX3GCykuiW6Ak4iNk
 fYtjpaoQSEB0tJeMFiAdKXKstsY2w24yYr6L4zzwWr4hwwnI0MBgymcHvU82bLds1k4k
 dTqRMztXtcYUMxsOibYkJm/WWugpsh+dzWYEAe9iJdcJPqIWFQLf3mbpPTiAMj7+8ib2
 ax9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUks5gT1e1NQ44J9/fYxf4yFSi0yqHzfEn/VWpeprK8bJE/K/xJLydku6b3KWgoMr6HTxdtihU=@lists.denx.de
X-Gm-Message-State: AOJu0YyMH4qgWMaVB+QmfwjIvQtNUtBVWmXbKcwOrAhYSWHqNRfmE7xZ
 ogthKi2UrP068TSaudv4djjk40fu2L1HYh6LvcMI/bNA/9LPDyGBidQE76ShMc7vDEodtFLP+2G
 //Ffeo/mHQK2vQoIlL5TtOFTfNbRvysYcMW56GwP0u+7xc/sH9DomhIFf
X-Gm-Gg: AY/fxX4BywuvHzkNiih57a7zY4ZO2alZyE5c1DQBk/mx9UA123NQ4iHGoFebQr7A9Ul
 q38voiKQpLHS3twJcno3P2cZ2npyBpSDyYh1hDbgXI+QSkFbiWv9n+Yy6NjfDgZN/7HPptt7YOV
 qi/WBh7zJIP96A2cywjBRYAp4hKe4Mvp1xTrAxcT1grUnbHe63kWc4OQyzMQXPQ3qglC+DTwfMW
 SbENCYrXHttRQOnbNCSRy/mQ+++7BS68VZXIdph6EscnR/anoufFSuoaYEvkXQO9mdRIKcHKcsU
 Pk/4inZ3egnD27Rnv4jE+AwEPyRFY/H1hxaYtP6POeCbiBE94B7YVkWmf42wTY2qxdC7C3XRjRq
 R/GwtkyqZYjZmbiegOihMVC4igg7+8cUh1kVQl7vQTSzEm/eCZ8fzrm4e/4g6PIE9Zto3uqx64G
 GN+RBudcb63MUByPzBFOuC4++lC5s5
X-Received: by 2002:a05:6300:210a:b0:320:3da8:34d7 with SMTP id
 adf61e73a8af0-3898f8dde13mr20688144637.22.1768305268151; 
 Tue, 13 Jan 2026 03:54:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7M+Iww4UbjnfG4vQ3G5ec9lZhIeff94itt8+jeh8bTPzyQAY4/Qc3zHpQqgEIClrA3xtBmA==
X-Received: by 2002:a05:6300:210a:b0:320:3da8:34d7 with SMTP id
 adf61e73a8af0-3898f8dde13mr20688117637.22.1768305267678; 
 Tue, 13 Jan 2026 03:54:27 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbfc2f481sm19734073a12.10.2026.01.13.03.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 03:54:27 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com, me@samcday.com,
 sughosh.ganu@linaro.org, ilias.apalodimas@linaro.org,
 rui.silva@linaro.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 0/2] mach-snapdragon: Add OF_LIVE device tree fixup
 infrastructure
Date: Tue, 13 Jan 2026 17:24:01 +0530
Message-Id: <20260113115404.1448759-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDEwMCBTYWx0ZWRfX79/jX63g+D2b
 Ac8e7jDbIg94kWLZOza32umkRsWwzrdTtqNblFATqttFxFeftz7KYp+0xo88jZKGZMUzyWwG30B
 ecfQahQzx08dzd1RqUhttzzXgqkPFR7mKYlO+0kWE9CDw2ixhoqoM2euTvSI8ud2kRyhaRWE4tt
 BNEnq6lhzEGMgpkqVJPOQF5iUvWDo/YvEnYbE2C69/q9ftZQ/9itcaqjYPlA2mnGLHK+sJQXv/N
 7yEnKOIaKbn4T2hKdJ+c25Ydz2D8sB1OOa9qYlOD01er3TLb3oe7+wyqHv6RYDVSQF9rKUR4hv6
 VNMITFjnNfa/JyCGKGEIznI3aBPXqrS1misiYt0OQi5ZHN3T7VmVRGv474XksxDadO2mdzapbAX
 fLRQOq71UB2d45j1btPsTLo+PdQhb03a9SSl4LPAdiSqX6tSxNN/2yjWgPIfADgv1j+qStN0LQt
 2+9K+MESpfqQ2ijIICw==
X-Proofpoint-GUID: eqnp-uGYlj-URHzjA4SJvlh2oznr3gUf
X-Proofpoint-ORIG-GUID: eqnp-uGYlj-URHzjA4SJvlh2oznr3gUf
X-Authority-Analysis: v=2.4 cv=XJQ9iAhE c=1 sm=1 tr=0 ts=69663274 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qOUf4dFsRFytsKYPrNsA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130100
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

This patch series introduces a comprehensive OF_LIVE device tree fixup
infrastructure for Qualcomm Snapdragon platforms. The implementation
provides runtime device tree modifications to pass platform-specific
information from SMEM to the operating system through device tree.

Qualcomm Snapdragon SoCs require runtime device tree modifications to
provide accurate platform information that cannot be statically defined
in device tree source files. This includes:

- Board-specific identification and variant information
- DDR memory configuration
- Hardware subset parts
- SoC-specific device node adjustments

This patch series depends on the following patch [1], which adds the
socinfo header file.

[1] https://lore.kernel.org/all/20260106122134.2047864-3-aswin.murugan@oss.qualcomm.com/

Aswin Murugan (2):
  mach-snapdragon: Add OF_LIVE device tree fixup handlers
  arm: snapdragon: Integrate OF_LIVE fixup handlers in ft_board_setup()

 arch/arm/mach-snapdragon/Makefile             |   3 +
 arch/arm/mach-snapdragon/chipinfo_def.h       |  90 ++++++
 arch/arm/mach-snapdragon/of_fixup.c           | 114 +++++++
 .../mach-snapdragon/qcom_fixup_boardinfo.c    | 228 ++++++++++++++
 arch/arm/mach-snapdragon/qcom_fixup_ddrinfo.c | 214 +++++++++++++
 .../arm/mach-snapdragon/qcom_fixup_handlers.h |  70 +++++
 .../mach-snapdragon/qcom_fixup_subsetparts.c  | 291 ++++++++++++++++++
 arch/arm/mach-snapdragon/rampart.h            | 236 ++++++++++++++
 8 files changed, 1246 insertions(+)
 create mode 100644 arch/arm/mach-snapdragon/chipinfo_def.h
 create mode 100644 arch/arm/mach-snapdragon/qcom_fixup_boardinfo.c
 create mode 100644 arch/arm/mach-snapdragon/qcom_fixup_ddrinfo.c
 create mode 100644 arch/arm/mach-snapdragon/qcom_fixup_handlers.h
 create mode 100644 arch/arm/mach-snapdragon/qcom_fixup_subsetparts.c
 create mode 100644 arch/arm/mach-snapdragon/rampart.h

-- 
2.34.1

