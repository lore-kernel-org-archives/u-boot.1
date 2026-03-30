Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E231061B18
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 17:14:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2624783F5B;
	Mon, 30 Mar 2026 19:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="X2PieZlf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="baUCd+MO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0828283DBF; Mon, 30 Mar 2026 19:14:47 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7738083DBF
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 19:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UCZuvg703490
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 17:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=HxAM2580loD1atp5f1o567
 V/4hy+JS8Wsu3gMETQIag=; b=X2PieZlftEgVcHAqDohEvesij3tOPRRcmuqYWa
 w6mCZVnqKlzX/a7KqYhUleZuJIQommkLtTjVY6BqwEsR1EWcREbq12TccY+cDvr/
 nFDYOdk9UNf/1LZxkq5xewSVCyxNmngJCsXozg0sdDNtUdhSWTuQI/2BJurmRk4t
 eEM9HhhH3NRpZIaeKdFGDiqLiHPIjItXFaQaUVaOrSh4/9DG+lk78iEBnAm/3rG7
 D0eUKIxuyFFIJG336BEPxzatPDkpUwpolIbmTSat7PdGeoqKWiXqAmf3T2NCdQam
 sJ0hcC0zPaT38p8G/dcHOujJRluli/bkP3pmipsd39t+sDzA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7sans5md-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 17:14:42 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82c69a72aeaso2990864b3a.2
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 10:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774890882; x=1775495682; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=HxAM2580loD1atp5f1o567V/4hy+JS8Wsu3gMETQIag=;
 b=baUCd+MO9D/4emUYyEm9GhHjdCchhO9ZrySM4UBiU2RemHs3hPoTKC2rKPCLL1Duxv
 dwIJTkK43pf+U80YaDaj6oXFyw2asCaszZ3J1kVPflyvJtMQp2PN1Hm5WFJJRIVghB4o
 ij7sDMh9M990xJgyqcNvB3qPvvr0MrYOWbl5jpDko2PvZSdV05EnoFF3VZBr2kDwVAjc
 FJW9VBwk6QxVjDzD2CF2fHjNVsGxmMFRj9uqdM89FsNmEe/PUR8bgR1POQZ1AZX2eumx
 9DXkVb4s+CPVatVh2NadIAefyZ1qQMGb9cuw6hHGH3KSMk/v5WW/akOyUUM/Kr6TH2Jd
 NSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774890882; x=1775495682;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HxAM2580loD1atp5f1o567V/4hy+JS8Wsu3gMETQIag=;
 b=OVHwANFeSJf9BtGkrf/U2PFuNT7xRD2QSuPLTHYguf1X9pqcUyd5Pge4W4RxcKoK1T
 6S9MXw3gCCzpzl8V6m0fuQ6jgt+WBwxuZKGFI7kuFoTkBME6zzuP3sh4xj25T+Hxdorw
 OD6Ujbx0LE076NPrvqscThg5J8btKYXPeHwJ2axx9b70tsgVsZi32BpO8o0S3274gU9K
 iMT32rK8TqiadYEecRE53siPPsK5IpLd/wu7YROopFKkVbHogidBS8Qyiz9pn01JCbR5
 1nKlPt77qx1pNYQz93T4yAblTQyYWDyQK3PWUUE3+/lwdriCSpmqQGDdl4Pdz1YYCl6C
 mk4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0MNfpKIC9P6IyitsA2kTvDRtveHtqW3FH6y1lzCul68AbK8CC1SsND8QtW3xrwlwm1oJUyIo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9ldD7b2h6Ypdcsda3UjJHc7DVTFby0TfC4ojU2f+t3xCfqZcP
 SyrRiLuWekIYoNg49nUUeV/w/60JkG+2kNSSr2Rr4iYMPWkmWdxsif5kPXigxoNETiRnWvoo3V9
 e98PCqYxb+ua43MdKkoRw/s0CEueZNZNm71q8pGRBAU6B2NSFszihSto+
X-Gm-Gg: ATEYQzxABZdYjwVjqjN2jZp+HaEGqA0R1mPbwLbVMkX2Rmv7Bv0caYwjlwSXbfFivPD
 JvfEnnJ2e9np1H4X595ocUWT16zHAup11mPQXeC12jp+CddcYjWcnBQ8twCjM0Q43nHvDCczmkT
 zNtq40clHHtfB+qY6sjwNzgKcX/B5rWAnyNL1ay26Jp0AEm1pwcJGoXu8ROiRPCtK8Z/2THyDAN
 09J5eN5HAxV3srNjfA6nJ2FEEX/JdrtORtKspJMbEt90quhGnlh6n9MF1N6DdcvV5jfFGyn+nfJ
 ++IOO+vW2n+vaoZmMho3lUcfwLAVot7D3Osejlscnz7MfFE00hvuz3/2pqbutoOSzbXhFlLKwAC
 74tcgG1YsJ+oLXMW2P33ogD0D+wB5OJG4aSo9SV4otWi4peSD/1+ra2wnWKrSom5NCQgNMP+tD7
 JS+JJYV/ohXFokU7+LQaHGkxSlPGgsDw63/u9d9KG5
X-Received: by 2002:a05:6a00:b486:b0:82c:6f07:2d8e with SMTP id
 d2e1a72fcca58-82c960932camr11742175b3a.54.1774890881943; 
 Mon, 30 Mar 2026 10:14:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:b486:b0:82c:6f07:2d8e with SMTP id
 d2e1a72fcca58-82c960932camr11742107b3a.54.1774890881155; 
 Mon, 30 Mar 2026 10:14:41 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca8626518sm7349777b3a.52.2026.03.30.10.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 10:14:40 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, sjg@chromium.org, seanga2@gmail.com,
 sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, gchan9527@gmail.com,
 mkorpershoek@kernel.org, hs@nabladev.com,
 marek.vasut+renesas@mailbox.org, msp@baylibre.com,
 dinesh.maniyam@altera.com, peng.fan@nxp.com, quentin.schulz@cherry.de,
 kever.yang@rock-chips.com, jamie.gibbons@microchip.com,
 justin@tidylabs.net, xypron.glpk@gmx.de, n-francis@ti.com, h-vm@ti.com,
 ycliang@andestech.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 0/7] qcom: Add NVMEM bitfield support and reboot‑mode integration
Date: Mon, 30 Mar 2026 22:44:12 +0530
Message-Id: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6zbqouPwtjR44NVLIWu6UbFGGbZnTN2n
X-Proofpoint-ORIG-GUID: 6zbqouPwtjR44NVLIWu6UbFGGbZnTN2n
X-Authority-Analysis: v=2.4 cv=NofcssdJ c=1 sm=1 tr=0 ts=69caaf82 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RxCTT1kfdlTa0MEHILYA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE0MCBTYWx0ZWRfXwaH7SFYaHtJ4
 PDt6edDp46NyuqAieOYY6enHHwj7sS5Nf0H3MQkbmTZTgR6DfY80MYvG8EUukuJpQWJCtxGIVws
 fEGwwO7v/ovN9wpy7VftotRABGkNMZ43FWIWHufWo397Ox04sQTp0f4Hx1vpKHrySiUHrALrRNm
 wake6JtpPI5jxmqqhEBJ+YEk+NbO5R9Z3UbsO2yrLgfcR1EftUs+IHEV/P9d367DCKtdZ75U2No
 4MBw1Gc+CYa2e1qnX4kx/htjpNSezaa09E3Z1SpUEXdxPx4zHUjiNI+19ZWLmBrQ485AUzFPtjq
 Og4fNHTutGjP/S9Ucn87zi5nWONmSknySftuw3/9eRw5cp7oLlYxpxMBSDSFm9hnZGta47Ybric
 sjUPy2ngVv+JnfYYE2xcTZBEShBuE+DN/V/JIQfweUQsTjZtihoow5ePYbys86cTDNMbBq3Anzy
 zAW/hnrydls+KfulFyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300140
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

This patch series introduces bit-level granularity to NVMEM cells and
adds complete reboot-mode support for Qualcomm platforms that store
reboot reasons in PMIC registers.

Qualcomm SoCs rely on PMIC-backed reboot reason storage to implement
features like "reboot bootloader" for entering fastboot mode. However,
these PMIC registers often pack multiple fields into a single byte,
requiring fine-grained bit access that the current NVMEM subsystem does
not support.

In addition, PMIC generations differ in how reboot-related data is
stored: older PMICs use PON (Power On) registers, while newer ones
provide SDAM regions. This series introduces a unified, NVMEM-based
approach that works seamlessly across both architectures.

This version also integrates reboot-mode handling into Qualcomm board
initialization, enabling automatic fastboot entry when the reboot reason
indicates bootloader mode.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

---
Changes in v3:
1. Simplified bit field handling to maximum u32 size (32 bits).
2. Enforced strict size matching (size == cell->size) when nbits == 0.
3. Enhanced test function for NVMEM read & write
4. Updated NVMEM API documentation

Link to V2:
https://lore.kernel.org/all/20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com/

Changes in v2:
1. Replaced custom reboot reason handling with the standard U-Boot
   reboot-mode subsystem, per review feedback.
2. Added bit-field support to the NVMEM core using the new "bits"
   property.
3. Introduced the Qualcomm SPMI SDAM driver for unified PMIC storage
   access.
4. Updated the reboot-mode driver to support variable-sized NVMEM cells.
5. Added device tree configuration for the QCS615 RIDE board.
6. Enabled reboot-mode in qcom_defconfig.
7. Integrated reboot-mode detection into Snapdragon board
   initialization:
   - Added qcom_handle_reboot_mode() in board_late_init() to enable
     automatic fastboot entry on "reboot bootloader".

Link to v1:
https://lore.kernel.org/all/20260108065533.1143179-1-aswin.murugan@oss.qualcomm.com/
---


Aswin Murugan (7):
  misc: Add support for bit fields in NVMEM cells
  misc: qcom: Add Qualcomm SPMI SDAM NVMEM driver
  mach-snapdragon: Integrate reboot-mode handling
  dts: qcs615-ride-u-boot.dtsi: Add reboot-mode support
  qcom_defconfig: Enable reboot-mode support in qcom_defconfig
  test: dm: add comprehensive tests for NVMEM bit field operations
  misc: update API documentation for bit field support in NVMEM

 arch/arm/dts/qcs615-ride-u-boot.dtsi |  26 ++++
 arch/arm/mach-snapdragon/board.c     |  56 ++++++--
 arch/sandbox/dts/test.dts            |  12 ++
 configs/qcom_defconfig               |   3 +
 drivers/misc/Kconfig                 |   8 ++
 drivers/misc/Makefile                |   1 +
 drivers/misc/nvmem.c                 | 159 ++++++++++++++++++---
 drivers/misc/qcom-spmi-sdam.c        | 200 +++++++++++++++++++++++++++
 include/nvmem.h                      |  28 +++-
 test/dm/reboot-mode.c                | 137 ++++++++++++++++++
 10 files changed, 595 insertions(+), 35 deletions(-)
 create mode 100644 drivers/misc/qcom-spmi-sdam.c

-- 
2.34.1

