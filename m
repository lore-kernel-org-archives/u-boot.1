Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BD4D0C849
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 10:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBBFD82B20;
	Tue, 13 Jan 2026 11:38:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="a8qnVAug";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TRuVXNNt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A07F383045; Tue, 13 Jan 2026 11:38:52 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57E348004F
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 11:38:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60D75Bt42604538
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=dJc7AiR+0WNhMLOealyWTU8Yw0lyEmYizrK
 ob+zpC/M=; b=a8qnVAugZsj6L9N1k/cw5jK8/8RZeT5DNq9zC6CCe2gJ4/B0jhB
 ovzCk9ljUZFS80Bkz7ya84mcLkSrraVV9YgZ4cM5GP019L/NyTTg1rZg6iI44nhz
 b+8qep+FTNK63q8jZs7Lp158boYGwcKx9voMX3GFhBhs2gQuDSWzKKxLI1+GoUop
 rJxA9NKIEvF1JTq9lYgNNwWpGt+i9elm25/OTZyafhVMM9lSHAkBiZ9hmY8aBtyQ
 pPxCS3pXBF8e5JyO8HRlNWyJ3ry5S3FwrPkhS2/wR1kQF4lOAR2KsvIhVmDK/cSW
 pHbFXot60QTcdkRzAUYtI19KRKdqyvezmgw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn7uytaqg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:38:48 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a58c1c74a3so7019595ad.2
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 02:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768300728; x=1768905528; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=dJc7AiR+0WNhMLOealyWTU8Yw0lyEmYizrKob+zpC/M=;
 b=TRuVXNNtwvwcWYnqfS5C6omnNeA2unQM/pZZc6PFr+pwwI/sju/HRXFa05l4Xq4eWY
 Mr46EzY2XU5Qw3JUs7f4lVMzPun0ig7cMMxU1WpnEWLCgkCIc8UJw+jk/xzuQaklj2Sx
 JUUVqoSkT8gkXIZQodrtMxX/pWazwlSyn2qhIEzzY4Q6Y4VdbOPSTnxVWSdokTlDMirA
 BtCvtjLniE6IJR33DtwwbP0ab8d6PMEDB2XBVv4LBSoE0h6SMDAc+NcIaCYus+j/Sd65
 RgLgizmb2lxkGzvFMj1SvlqeSpsFGqsd+BSiw6lD+zQDK5wQl/X/eeQe6rKfOstvwZBG
 0tew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768300728; x=1768905528;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dJc7AiR+0WNhMLOealyWTU8Yw0lyEmYizrKob+zpC/M=;
 b=arzabVvNpvu3QoJoDQRqunBmXI7PK97jHN2RaXDzIuhsGORgoEtjgT5pdxb6p4Mdga
 WszlXQ2OqnNhNfuU4F6K4f1w0tzKeTR0wIUNSJISPM0lJjFJCYYTpwrwaqR4RoqgxtQG
 Q0oJS1+Wkr5C7oBlQN+oPvFLE2XpZJRINYyJXYUj1Tmx4y8P1W7mhiOTVkI9ovG+4c8I
 6rqs+WrIB+Jc9FZ6btfRodZW/cQKzYxh5RJDyPpRIUdLF4ijrxevy2vjpXcuPgRDmuSo
 Gr1PNmKJIb9dFlxCWJDEqw8Dca8JBtLpwCnGeXOyD7CQSwUm+G1z8B6tWVt6EO2nkj4y
 78ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLGIGjjbmSeGyHfYMBf7biyhQaL4d92cYCkxOErldTqbjfttd71KbtbyH53yEuvyOhdX2wPwo=@lists.denx.de
X-Gm-Message-State: AOJu0YxQZPGugk4AgkVZeA5WjSvc8Ea26A/ht+Sjvpvgq+rACsg7ffW0
 C4XW1BSB1D1hO8q5dbEZUpu6eGD4moOf6Ibdsh5u83R582aw4sYV1aH7Z0B4XX8ockl136mOioD
 ajM2Wk6+GAaZnu325FeBUGSxRG3eI758Ch8NvZjJ6QKCNgsvOrqag6Irs
X-Gm-Gg: AY/fxX6XqW2dx+bFW7RnS5vanljmdnmpXOyoPBe74kwIiUQm/Dbh/lRw3BUuTk3NO8s
 nxmIr4Sg8FpAtQcrHEyNlvbTA7EIliAnOpgTKtfx/aofQGY2KYhUE8bEiz2ONG+RTuANnp9xERC
 jXEhhPFRTb+8mvvEphmRP9hwJmzFXz9m/RjKKaYUU3KtFO+vHQjClDiSRw5KyUE+rVhj0PEtCas
 oMejx06LCGU6z1xsbzGfKk+8vmOBfDVCtTyndDehgg1byShB7FwuMXl7ge09fx7B1dH1Yco9Gm/
 8rxX+l93ucUZCg4Yf/iKwsLIKPQuuy7YjeLVC7MG1JCZlsitoC6XLbcFepcRsEUujDLClXNNhGK
 xR6g+zNyd968p4b4BPRtvLT6dJmomhSJHP5G3k6F19Yb+yn69Tod/APLhxNwSo0yAdwRUQHY1Av
 68Kt2fGaD5BhxrERYQ7FnhHbP+pxHlXFEZ6/VPcos=
X-Received: by 2002:a17:903:1b06:b0:2a0:f469:1f56 with SMTP id
 d9443c01a7336-2a3ee4b7520mr237040755ad.31.1768300727718; 
 Tue, 13 Jan 2026 02:38:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4k3PFxJbYL68bbrqEOU4wKCVidQUyMsUQpSGrqUZGcH0mwMwgB7vy5Rm3Xh9aOMm6GWJtIw==
X-Received: by 2002:a17:903:1b06:b0:2a0:f469:1f56 with SMTP id
 d9443c01a7336-2a3ee4b7520mr237040525ad.31.1768300727186; 
 Tue, 13 Jan 2026 02:38:47 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2dd4sm195286965ad.47.2026.01.13.02.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 02:38:46 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 ilias.apalodimas@linaro.org, jerome@forissier.org,
 marek.vasut+renesas@mailbox.org, christopher.obbard@linaro.org,
 me@samcday.com, michal.simek@amd.com, clamor95@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 0/5] Implement reset to EDL for qcs9100
Date: Tue, 13 Jan 2026 16:08:35 +0530
Message-Id: <20260113103840.1948029-1-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: eLuPadVnqeuJaW5B1BruWfS-2m-QnoNp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA5MCBTYWx0ZWRfX0DObrviMbSwo
 XzF7ZIbZ3y+IPz6TfIyoTjj9KwQWP6KZpBpglZX3tIy/oPCe8hvJDv6mqUoj9Me8upluLdOquuv
 RuyEj+YpHdAvgCfnPCuzieg6ciZKtw1KyaF/0TzDCq5ZjcoY9vFVSPKxGBnt1GJzfmwopAyDi4N
 NilOYEsmlSfIifY4IbObTgDwTPAU+u/iGUuPeP3Bt14qXtWHqD2riUky10WsxTOeHyXiHDpBtWB
 SZzNyBBb5LFZa9KSppaj043WN7IxaFTsq7S708Cr0GIDztm5vxJnHvnqPkI1aCgKeEnshf8QWc0
 m9C4HsT21m6/eePeZ2yVjynApIzV70biy6FdBAdBivigzNu5Np0KgliGsDQjg5/e2uVwRfl3ah6
 jFfdWndUiVLTV3TsaheUs+4fllzLD5ftoMIDYIvdUVvx8Tn0TV+gre3cNkEgIzdPe/GPpbzVPaS
 Y1elwte3H2D7on+XJ3Q==
X-Authority-Analysis: v=2.4 cv=bpdBxUai c=1 sm=1 tr=0 ts=696620b8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=wsBOlPFGP9gUABGrlvMA:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: eLuPadVnqeuJaW5B1BruWfS-2m-QnoNp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130090
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

Using the 'reboot edl' command in Linux, the platform can reboot to the
Emergency Download mode. Implement the same for U-Boot.

v5: * Update author and signed-off-by email id from quicinc.com to oss.qualcomm.com
    * Add r-b tags
    * Enable CONFIG_SYSRESET_QCOM_PSCI in qcom_defconfig instead of qcs9100_defconfig

v4: * Update documentation about '-edl' option
    * Add API to check for support of PSCI functions
    * Check if RESET2 is supported before issuing the command
    * Fix compiler warnings

v3: * Introduce a sysreset op that will pass down the 'reset' command
      arguments to registered handlers
    * Handle 'reset to edl' alone in qcom-psci driver

v2: * Rebased to recent sources
    * Dropped the first patch as it is not applicable anymore
    * Bind the new driver from psci driver

Varadarajan Narayanan (5):
  arm: psci: Add API to check for support of specific PSCI function
  drivers: sysreset: Add sysreset op that can take arguments
  sysreset: Implement PSCI based reset to EDL mode for QCOM SoCs
  cmd: boot: Add '-edl' option to reset command documentation
  qcom_defconfig: enable psci based sysreset

 arch/arm/cpu/armv8/fwcall.c           | 15 +++++++++
 arch/arm/include/asm/system.h         |  1 +
 cmd/boot.c                            |  3 ++
 configs/qcom_defconfig                |  1 +
 doc/usage/cmd/reset.rst               |  2 ++
 drivers/firmware/psci.c               |  4 +++
 drivers/sysreset/Kconfig              |  6 ++++
 drivers/sysreset/Makefile             |  1 +
 drivers/sysreset/sysreset-uclass.c    | 32 +++++++++++++++++++
 drivers/sysreset/sysreset_qcom-psci.c | 45 +++++++++++++++++++++++++++
 include/sysreset.h                    | 18 +++++++++++
 11 files changed, 128 insertions(+)
 create mode 100644 drivers/sysreset/sysreset_qcom-psci.c

-- 
2.34.1

