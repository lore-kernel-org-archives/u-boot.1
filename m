Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42DDFF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:06:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 402B983BC4;
	Mon, 27 Apr 2026 14:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MkKaBBpK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gtPAAU1b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC33180433; Mon, 27 Apr 2026 14:06:54 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0615680433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 14:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R8kGFR3961981
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:06:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=nMYGjILHp3JkgaQ0C0reCr
 2+sOjvnvBR5rpa/AHsJ6s=; b=MkKaBBpKVfXS+V3fhs1z8+zar27Ulb+XFxuq+E
 wQySd2DfUiPRR+0m65wxrT0hoFaJcOg22gyBGMmuotmjYaoF+swdNRnCDnMka3pN
 nw98gKUZ5ej6ghfpW5l8GQia1yb01cbFHENI77koZuEwSbspTfSbX0jkUgO7AMHd
 eHp4cqA6P1Bz3abRT9q281Mlu5j6thUX/9Za6dYFeuk8Kmhb/I73m6ZQ0GSjjs1s
 4vgjpDtBdqCGb7IY6MGO4zWzVafZRYa7WR0/EMhghdZOP9c73HUItmRXTM7JshHn
 dhr7dYZGfAM3M4+me+UUv5oWS3CNZOb73JSfNtjjsefrkadg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt4k30yfe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:06:50 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35fbb5779e8so10927654a91.3
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 05:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777291609; x=1777896409; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nMYGjILHp3JkgaQ0C0reCr2+sOjvnvBR5rpa/AHsJ6s=;
 b=gtPAAU1bh2zONgfl2Nf4H3kuJKsifiKI6L/rC4BFCbPj7FiWITkkUujqwXU817h4YA
 ZSXhPHLjiSPPKXYZNpQ5EJHWE4BrBBVa3gfycHov1frRVu97aZ8bgCslk4LrVFk7DjCQ
 D3yzjd1bXSWQX7dr6CKDM7zMDT/CApYdC3hIgj7dxPi92wFLXeoCL6nsGYiJlbmc8n8a
 SD77MdwyTIA4W5B2G0IRcJmBvUpoUtjjg3YxeV9ZX1VAbRM0Bco4X2IwClFiEDB/AG5C
 8yduirEN3DcNkRf8IwCDYpUdlwDD36X+3vbXGCx/+D+ruxlW2WWPGRhMBbLM4TvxTSVb
 gn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777291609; x=1777896409;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nMYGjILHp3JkgaQ0C0reCr2+sOjvnvBR5rpa/AHsJ6s=;
 b=nZ3wuwZw07pU5pPj5H2/EY4JCl1et0zOTbDJnkHDIIHGjhSq6WPgDDMlRDSGZ7XSRs
 wa+aGoK9L2GYsaqFL6YyqVkNf+3kU4QQTpwt5DIe1QYbxV5f9ZsuIOUUYeOAbN5ttwCd
 0JmeiMFKEKGljo8Yq+eMS3DvpDE3bhH+wbDD2ZGzYp+7rjB/rfiVMyhAs+AokA9cerZU
 DBgA0XIgo5MJYlVQY6wY8SACxnCKRIC1bWQZp+lu5NA/hAIZGWx3wpLLV4SH64oyFhod
 jOeE3BUwdCZ3wxA4OQU1l2LnCdPEO1Olte6JrXoCCKU5qB1PmDoJZ9a2bo0OANvmxP3f
 Vkbw==
X-Gm-Message-State: AOJu0Yz/STgFvoVSZkhpjAS8YQsc+7L9NJQbnOucYngicau+2CaPKILy
 CUwmh2V9XgY3yEIMJ009vTYp4XeXKogqgFDVMxgHWW26m3Ur+7JxSERpI6ThRvK9Gx5YgrgCKff
 p+dDlo+pG3xKrMY/9jwY7lIEKMUePx//qlkHb5BDIM+a+UZYkL+rZUzg8
X-Gm-Gg: AeBDievX7ZwzGnBAl4+hdeNLxkymL7MfZrqmjJQdt+gbO3V7tLAzBp731RsJnu25rZr
 kr2zAPrV1+7vHSzS/JfHwHT4Zd7v7FNEEDWb4Z5me0fIvsuvES0WVQXU5ZJLlsYXgwEFG1hfzfS
 vL0Wd81hVcAC1iE+ruGdSMg5+ZVr0JOy9PQBsL7QdlsDKqArHRjiBdijvR+4xZ1BrofJG3ws5Qv
 Smz+iCbEBAROlMthr1baonRtqbPKxpvlp7rbn3TNBI90nRADiDHwjahJURab7hY6MXACGnLZFyX
 Isb6+cENU3XwGUnFDuAkbxhxz1xQ+W8YeK/zNFMy/AMEBGWiw+CGTE7k4V2UL9AM9MSAnsmsKno
 QZ5DkYcksL+GvZCW3oX18HWxwQRt0GVRu73j3ogE/jp4DK27Bq9WHBY7AzlEKDGnIFOngC9RjbB
 25Rdk/BZnb4ONIt6vBTyZAL/1Y7ufWIwru91YlTkIn/ARbPmnHlqmJ+OPvshzf
X-Received: by 2002:a17:90a:e704:b0:35b:9896:cbcd with SMTP id
 98e67ed59e1d1-361404b9b70mr40880904a91.27.1777291609290; 
 Mon, 27 Apr 2026 05:06:49 -0700 (PDT)
X-Received: by 2002:a17:90a:e704:b0:35b:9896:cbcd with SMTP id
 98e67ed59e1d1-361404b9b70mr40880871a91.27.1777291608699; 
 Mon, 27 Apr 2026 05:06:48 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36140feea38sm31832910a91.6.2026.04.27.05.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:06:48 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v2 0/4] fastboot: block: Add GPT/MBR and device selection
Date: Mon, 27 Apr 2026 17:36:41 +0530
Message-Id: <20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFFR72kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDEyNz3bSk+PSCEl0LsxTzFDNTS9OUxBQloOKCotS0zAqwQdGxtbUAL6x
 L5FgAAAA=
X-Change-ID: 20260427-fb_gpt-86d7d6595dad
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777291604; l=2245;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=rrW9yGOufwdV1gZZBldba1nrABs276OHi06zUMydFAo=;
 b=NCWJI5uyS44VVEHAAPEdQPjRF+B5483VudambAO2adDQK3O8TRgIm1omef0phkpec52fFjhcv
 uh9iCaYiGXEAUTyHP7IZ2H3rL7A9ZHWzspBouy10OIK6PUtiroSUxt4
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEyOSBTYWx0ZWRfX9+qfY0z1RiKh
 eb8rvdZkTqf3PBRi0ohYK1WMaxSy+pL/JfrWxAhLvPPRCXvoWbo6okNXeT7deqkTUp6PeYda0ei
 A1JVZE0pvpSpQRntldKczZU58dvsP29sw9slw/qgyNY26EQwxJxcFlnJ7ShOW5LuF0lilBjzXd9
 iGd9ByTlACB9ubi4y5HXLzF1Ez4Lj6P64F8VVndBDmpyy1+Wqg0zbO1uy9f/YR6p3pNZ9mvJ695
 M3i0dwLUsdl4rHQbXxGekvrThvuZ3H6ublldvgPnB5JqijyRubu3kPp61iX51FG3nwdxG+zEUfr
 f56jNcnkNgv65EdiKxcSbhvxX605FkdXLcgAcGqI8Am6gxnqMNrKyFBasgWnN5PMNsox6a0Y3nN
 P7SvnnaD8R0sXk3B0aolE3yD9KOrCQ2ReYW24hjlG8hyvAhh7eZi7aV4IqOwDbDxkcgfiDsTZZd
 iHFsAkYv0IV+QY6vQug==
X-Authority-Analysis: v=2.4 cv=a7QAM0SF c=1 sm=1 tr=0 ts=69ef515a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_aTGsJdUfmxtiA1JYQUA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: biEQfBU5Uxmz31TOg_hiTX_JQOFM-b1S
X-Proofpoint-ORIG-GUID: biEQfBU5Uxmz31TOg_hiTX_JQOFM-b1S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270129
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

This series enables GPT and MBR partition table operations for
fastboot block devices and introduces device selection syntax.

Patch 1 implements device selection syntax allowing users to specify the
target block device using "N:partition" format, where N is the
device number.

Patch 2 adds fastboot_flash_gpt_partition_table() and
fastboot_flash_mbr_partition_table() helper functions that handle
flashing of GPT and MBR partition tables to block devices.

Patch 3 adds support for flashing GPT and MBR partition tables to the
fastboot block backend. This enables operations like "fastboot flash
gpt gpt.img" and "fastboot flash mbr mbr.img" for block devices.

Patch 4 documents the new syntax with usage examples.

CI test results
---------------
        https://github.com/u-boot/u-boot/pull/941/checks
	All checks have passed

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Seperate adding device selection syntax and GPT/MBR flashing support
  into seperate patches.
- Introduce common helper functions such as
  fastboot_flash_gpt_partition_table and
  fastboot_flash_mbr_partition_table functions that can be used both
  in fb_mmc.c and fb_block.c fot GPT and MBR flashing.
- Link to v1: https://lore.kernel.org/u-boot/20260410-fb_block-v1-0-68f0c976fe0e@oss.qualcomm.com/

---
Balaji Selvanathan (4):
      fastboot: block: Add device selection syntax
      fastboot: Add GPT/MBR partition table flashing helper functions
      fastboot: block: Add GPT/MBR partition table flashing support
      doc: fastboot: Document block device selection syntax

 doc/android/fastboot.rst     |  41 +++++++++++++++++
 drivers/fastboot/Kconfig     |   4 +-
 drivers/fastboot/fb_block.c  | 102 +++++++++++++++++++++++++++++++++++++++++--
 drivers/fastboot/fb_common.c |  94 +++++++++++++++++++++++++++++++++++++++
 drivers/fastboot/fb_mmc.c    |  49 +++------------------
 include/fastboot-internal.h  |  30 +++++++++++++
 6 files changed, 272 insertions(+), 48 deletions(-)
---
base-commit: 9f61fd5b80a43ae20ba115e3a2933d47d720ab82
change-id: 20260427-fb_gpt-86d7d6595dad

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

