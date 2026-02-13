Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC20EDF151
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 11:06:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8894B83C4B;
	Fri, 13 Feb 2026 12:06:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KdB/OOJ3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eKt+/IBs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A32B683CB5; Fri, 13 Feb 2026 12:05:59 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DABAB80FA1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:05:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61DACE8n3259044
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=yc/nQRxrwWSQobtGlvqV1i
 KcmHwWmgD84STHisIngS4=; b=KdB/OOJ3j0iFRScK0EpSkLfquGYbNIcID69hY2
 ESMVdym3mNhf0+NDaq/4K0hkSRh7ZHl0mLTDX/SPNKSDZ8pZqWLrjd5WChrGWHxt
 a0n2S5FtHcKDcp83li2Svm65ixaggfQkqaR9dJ3I84Ynx3koo94SuVVs27cSq6mL
 2eJTK5Sr7OiCy0/5CO9LHAQXK2nRrE/9ptiZ0PXMTqkeVG20z1oRyqxa4kJMmMXk
 ykhhF0o1dI56G1DdYuRftFiAJ0xREKjWIYg8lnVrFfcSK4bH1CAkq29pOcyBVtX6
 /cBYzH2PMZWG5LOz8/Evuc3IlCL7qa4dDTVfLK/4/jSYSCrA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9ptv2h0c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:05:54 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c5291b89733so643274a12.0
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 03:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770980754; x=1771585554; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yc/nQRxrwWSQobtGlvqV1iKcmHwWmgD84STHisIngS4=;
 b=eKt+/IBsi7vXjlQQWwcEToNAyGLtpApiUuM0R2rtwhFo42KK98qRkCAii4bD3wLODD
 wd2lHHsu1+xa5OILXDdQsM3O7YEwdcOGa0YHxWp2IDPdUTADYvgWZiSUbX9s1YywBnA3
 fDTKQlCqZukKdMUkbEZpcYFsPGwMlG9TnHdrXDTKTfPR6EJ+K3r6F0GC5swvt23ZxGWj
 OniJi6L3gBol53o65OW2b5YYib7PH4VCer6xrhiK469neJpkTdXhTym1u9xY3uZ/TlUM
 blohlD43j5YZXbdo0HRHuH7WD4+Pdo5G47Jugi4mc12/YQvOqh+WlZFpXLz8x/+txaPA
 PjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770980754; x=1771585554;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yc/nQRxrwWSQobtGlvqV1iKcmHwWmgD84STHisIngS4=;
 b=YhwaNsiHBFSwsFMLzVqk6X/gNuxMuemyQ+8R7dGuwTKfyvE6IHE/7BqsI+stlUlfZu
 YXwiyyQ+sfArhrJxbwfneXq8+/yWyk3Yao1MgKyV8w7FMOc2v4aiPnt9u+Ry1o+UGfWq
 mAF+SJBSH0uTjQJajjOqxnb49KnlQ7KT5zJHvtX7nzUrS7qf5jdQkD/8J11PLQOeJpeK
 PEIEOt2LTvyGMz306A4PcaPq2kOLTWdnyvOeavnIRLxv1fTthw4ZdsRjvrUfOQoBgm4A
 0TT2YdQ6SpFv304J+mARjOfxBGlUObv0vTk7wEsr7UBVIin2MTyieqyCN5HemRg1/OvS
 VFXw==
X-Gm-Message-State: AOJu0Yz9Cy142jfuhemXJtvv6FAwpVw1NOqs5mXx2P9ieFSuuGRn7kx4
 OUzP6HhXFfSBbpHySZGcbVFueXrw2BWbfp/jDtjKi+sIuaAVIIGzHXDWNozTEFKL43Pfz1M6gRj
 bgCgXfBOjBcR5e5bCNqp6ny9H0Ku5ixp6czfVFaQr7vARAvfIGCrVZQYRXO2R8vpi
X-Gm-Gg: AZuq6aJmuy1dNOO+SSBeRWdTqeT9p4PudGmdaCb8FVj2p71PrzmTaElENmbWRgOYnjp
 Ui4Qete+W6R4pc6RQqgXWet+pF396HJE1fsTOD1e0+QZMHNKscv1luACQ+jeBoSBidJfHKGNOV4
 bICXS1/DUb6KESdjQ6d93ujZPnD2UG/zpVE3k0RHTWZ4Hg1GjaK1NeuinU1L1hudFvpZjJXwP4x
 PDiLGYPtthBTMco6azqggZvCamN8XR1yo3Dyw+ZDC3zoQ7R/phaOfg840uz/MEG/l8dJpx5XNFt
 UILZ2iU+Jc3ZDPxOTikj8pSngEeW7wqLW66EnSlx1rJ8G3YIObLdS+9EvHr707VmImYI3SbJmwO
 CU18yMMopOMZPOJNyAquACfDUqS0N+ks3I3yHJYIwookF85eLeviNS02gtZybOpTm+XzGpdL9tm
 YOM841f/JbPpuVmWM7GK6ruqKAjZKSdNv2GYhueFvp
X-Received: by 2002:a05:6a20:42a2:b0:394:3344:a6a3 with SMTP id
 adf61e73a8af0-3946c8cdd89mr1495365637.57.1770980753972; 
 Fri, 13 Feb 2026 03:05:53 -0800 (PST)
X-Received: by 2002:a05:6a20:42a2:b0:394:3344:a6a3 with SMTP id
 adf61e73a8af0-3946c8cdd89mr1495340637.57.1770980753446; 
 Fri, 13 Feb 2026 03:05:53 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e196a3663sm7943908a12.9.2026.02.13.03.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 03:05:53 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: u-boot@lists.denx.de, sumit.garg@kernel.org, casey.connolly@linaro.org,
 u-boot-qcom@groups.io
Cc: trini@konsulko.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org, michal.simek@amd.com, gabriel.dalimonte@gmail.com,
 jan.kiszka@siemens.com, paul.liu@linaro.org, j-humphreys@ti.com,
 neil.armstrong@linaro.org, me@samcday.com, marek.vasut+renesas@mailbox.org,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH v3 0/2] qcom: EFI PSCI runtime reset handling and config update
Date: Fri, 13 Feb 2026 16:35:25 +0530
Message-Id: <20260213110527.1254098-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: trgiHQLLFZdqkbTJGatvxIS8zQkWZUJT
X-Authority-Analysis: v=2.4 cv=eaowvrEH c=1 sm=1 tr=0 ts=698f0592 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=V4Ys22k1LlpJHEvYqh0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4NSBTYWx0ZWRfX+awVvX6gGOJ2
 99nLWmPe5bxtmPQNdpBcz6Ldb9dITAS6hYFyLyXNfwCYGNB+kmvADUzU7wGMymdjJS3yUKR3GFX
 WOPM/8JNEKUdkc81nSo96JItxOLE1VCCu7Rup+KAOw6X/fYknlzvJMJvFWoWZ+ZbRWeHP9LyLlq
 Lq02fjiVob7g1nrvpPQsZmaqcgv88QZyTue2Qr+EGkoUKwZfiWcPeiRVnbnhOALenefHT8QmZ8p
 zm+8jPjlhLUM2GZvtjnazftHPt5vmmpsv0OXNzIjpUViUex6GJgxLiSLRv/M2ZrDzH8oTyVCO2t
 1fb4zcNxPjex51apm9wc+Za7tP2+m8e0D6HHgUn/5Q3kyqTU5vuxebdPlpU6hvsAq1BPvRwNE70
 eYqhYPAWJjKyKdx05WymXnqDqEdMwDsCBFouXlhBTL5CBSZ6H21M0n+yZKtoFsABEkDwPp4CTgJ
 suYNXxffSRDJOoVO17A==
X-Proofpoint-ORIG-GUID: trgiHQLLFZdqkbTJGatvxIS8zQkWZUJT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130085
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

This series refactors the EFI runtime PSCI reset handling:

1. Introduce EFI_PSCI_RESET_RUNTIME config to control PSCI-based EFI reset
   logic in U-Boot. This allows platforms to disable U-Boot’s runtime reset
   handling when the kernel needs to manage specialized reboot modes.

2. Enabled CONFIG_EFI_PSCI_RESET_RUNTIME by default in Kconfig as per the
   discussion in this thread [1]

2. Disable CONFIG_EFI_PSCI_RESET_RUNTIME in qcom_defconfig so that the
   kernel retains full control over reset modes (e.g., EDL, bootloader),
   ensuring correct behavior for advanced reboot requests.

[1] https://lore.kernel.org/all/20260108143742.GT3416603@bill-the-cat/

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v3:
- Updated the commit message
- Changed 'CONFIG_EFI_PSCI_RESET_RUNTIME=n' to '# CONFIG_EFI_PSCI_RESET_RUNTIME is not set'
- Link to v2: https://lore.kernel.org/all/20260114111624.2321852-1-aswin.murugan@oss.qualcomm.com/

Changes in v2:
- As per review comments made default y for EFI_PSCI_RESET_RUNTIME config
- Disabled the EFI_PSCI_RESET_RUNTIME config for qualcomm platforms
- Link to v1: https://lore.kernel.org/all/20260108105146.1285450-1-aswin.murugan@oss.qualcomm.com/
---

Aswin Murugan (2):
  firmware: psci: Refactor EFI runtime PSCI reset handling
  qcom_defconfig: Disable CONFIG_EFI_PSCI_RESET_RUNTIME

 configs/qcom_defconfig  | 1 +
 drivers/firmware/psci.c | 4 ++--
 lib/efi_loader/Kconfig  | 8 ++++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.34.1

