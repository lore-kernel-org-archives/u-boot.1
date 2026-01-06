Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6997FCDC18E
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 12:22:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85DBD83F20;
	Tue,  6 Jan 2026 13:22:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WtTT3E/x";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cvP3uvSY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF3CF83F54; Tue,  6 Jan 2026 13:22:15 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64FB383F01
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 13:22:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 606AYdE93052779
 for <u-boot@lists.denx.de>; Tue, 6 Jan 2026 12:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=C7jzKouOALAO/gdaDgZz+0BEwSwuHkDUxvy
 BjqFqOOc=; b=WtTT3E/x1CQTI4Jw5Xs6lCBMyHXjRbl0XtJ6iKG9sJUaj5E3jY7
 NZBP9vkk/yHxr59DmF9RxBFdBCwFtziG0PlAe6rUXFWgC4aE+lLkmKasPiXJh5rP
 L6CGfh5ysTq+FhwHUmOh9fS0fqEebKi6POqdezNenH6OMAWXohAJ0/Z/0fHFJaAO
 DDSuaSRvuf/wYl/P432BQlk8ev4A74jVcduy4waTMdlV2DWde8tweIgmiAgHRbWO
 CrmoqZ2otZYcw52FX7COFsYvQSuJcGo6GksnJP1B5gD2NQ3tMkCdFoqpX6kLDJz4
 0KOLpdud9U2qR+K5PquDqixDGCpiBKJbjlQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgpn9sybn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 12:22:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-34c314af2d4so944767a91.3
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 04:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767702126; x=1768306926; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=C7jzKouOALAO/gdaDgZz+0BEwSwuHkDUxvyBjqFqOOc=;
 b=cvP3uvSYmmVNUy/+wgST683fID5uULddqxrctWy+0tR+1AIHNCFrOCeUgsQNxhM9Qz
 85hVttkA11hiQk7SRYjrygwcua5ziD0hnfeyTLfgJfldB/NcOJHgmUWyOJ3wqi5KROK2
 ZjnGZnRpBcw255belMp8bR5pwsTd2gO0Tm98a29Mw7cU6CsHPe9HLI3ZksnP3WQcnXKl
 McexCk9ABZfR22Nsqi0qPDUMTqvXEWKWa12y5sxh5PZQ/HB4Af+GpqVx8hJ9ScfQVMYP
 aypTnb4rjL8yBWJxGg/l5v74lNsF/9fJL5TeqBDHwODfVdpDpUT2NrbWvgQjBqOFfXV7
 oDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767702126; x=1768306926;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C7jzKouOALAO/gdaDgZz+0BEwSwuHkDUxvyBjqFqOOc=;
 b=P4XcUt4xNxuluDw6oY2qXEBMT2QTMpLNYeGU6tOLqcujroyvzVOb5DA1UGYbk9YrI+
 gO1o+B2sNjtw5zmiVjuBLc9ohz62psw7Tm0XTh9X6VG0+7ewQXj0ECkpUmvl40b2uWV/
 ZPRuSFmdrQbp+llrGLP0zcpTN4ktLikcety3ZPVkf/sSz+s/8o0wkWgdhTs4zlE6z2f7
 ht5YM445ZhPjC8onO4TS5gzNY93Hb+F24uCmgEf2FXzYpXJB/oBCDwgmKMHdHZgTWRL7
 vo5+UY3Z/ewFLjS07JFlikqRYDvVGowEH8dYGH4PnvBEIb7Kxx5/qZ4khf52ajcS0x7F
 XVBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOpCDigIuUxkvJXwrz7+hX/xS/lnyUZj1/prdBcckDeqFn9GKW4p3ULLmPHSMUrE1PEQdkZMo=@lists.denx.de
X-Gm-Message-State: AOJu0YwMPf4D3Eqgp9Ck7VSHTACWCc3anDyVA+OSEnQ7mCc3DSJNnyWB
 EroPkCkXS4vogGsIbaV4k0iJ7Mg1tL1gcMCYylMkSf2XvPOU84cAaCF9MfnN9//R4Bnyq53eNYx
 PDoJKUpL8FPfX3BfujcALVSBQbo2QgVx2I16Bl6dcji7n1RoEKvU9XoIg
X-Gm-Gg: AY/fxX4EiQCWjg8ZoKT6S0ZSpwJPPrOG6epmjwoQTTz/tGnhcibdyTiNZJNpVb0UAuw
 QWMTKQj+LE66zMqESEgUopyEOfpQVJm+MyEUzM7zH6Egjs+eDzp6XbNu3oA16hRepU+bD7t2dYb
 lDjIcMpzpHFaJCZkXyEl7HgfslRbFHSoL4UmGFFU65Il4WQeya0rIfJ3EtAn9K8R7SjeOw6ZgdC
 JxFWOs4ngMhQWrNdPMVQhPK783sw/se0RJkkpHgjD2Nr/MEXrrHVO0CJQ3Y9F40OJlWx+CBuHtL
 SP66CQ0Xcs5szcF+Cw6/gkzJNw6uAziq3qOoV2JDabVhg2ih//A2kReemzMxUm6Kf74ZJZSxKMN
 s2xza8TGynMQq+TAeSBvfZaOS/E+PP0HCXljYdwFRJeXH7GmwcFPABetGQ02+C/O/H8CYZrmcyV
 HYIZPLmBnDnB7u5LkrLftJNq8SC3iN
X-Received: by 2002:a17:90b:3b86:b0:34a:8c77:d37b with SMTP id
 98e67ed59e1d1-34f5f286e05mr2745630a91.16.1767702125735; 
 Tue, 06 Jan 2026 04:22:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuMW8rjNVIMjGxqqGEIybTzrVYt/yh+EYg3CofJpDxafopR99USfr6BmjgrHfJURfmxXZAaQ==
X-Received: by 2002:a17:90b:3b86:b0:34a:8c77:d37b with SMTP id
 98e67ed59e1d1-34f5f286e05mr2745595a91.16.1767702125209; 
 Tue, 06 Jan 2026 04:22:05 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5f88efb5sm2231509a91.10.2026.01.06.04.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 04:22:04 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 adrianox@gmail.com, paul.liu@linaro.org, sjg@chromium.org,
 wolfgang.wallner@at.abb.com, javier.tia@linaro.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [RFC PATCH v1 0/3] efi_loader: Introduce platform hook for FDT
 selection
Date: Tue,  6 Jan 2026 17:51:31 +0530
Message-Id: <20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9LsCSzADLJP_agIJHsq55jkz_ScmiRVK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEwNyBTYWx0ZWRfX3mM6fxD8+DFD
 chXKlrPykai2cR7unQ/ssjrubhnuPMmyHhbs5Nms3awV5ItHya1R8NFv9OtbRaUzdKPljoKzKvf
 0HISTDgnN97378FqkT71LzBlw5h2KnJNgsZYW7Lswnc43saa3nZhtJ5t9OUoEDUuDR3K1v2cFKO
 /H65gbNKafRpheBdcLUZTr+sz39XdcXtK8bGuxIMpZzNkMVgRLzpgh57zNAgZIB5PpYRXUWPVO6
 1b1++6T8np6DzhKZZ7/8N7uHiSGEyTl+J3r0uLqsHhA8Y14yjJFvraOSTclkK7LO7ruqkSJvrjV
 IjJ4OowS5f54mjgGj0uTQQSbw53UjgCv8uYB8jFdNzgEMixnrGRgC+bqo4sssX8AnVc18d59Ri+
 uaIZZ74dkaJW3ZWfpu69aHj5/BiW1LDalux1Vch0raJe59HKdoRYwRJT5mYEYKEUQ/5coWKeIYJ
 OP6+zxSjvNNZ89QC0GQ==
X-Proofpoint-GUID: 9LsCSzADLJP_agIJHsq55jkz_ScmiRVK
X-Authority-Analysis: v=2.4 cv=KfnfcAYD c=1 sm=1 tr=0 ts=695cfe6e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6VeyERFXlScAp4yk_u4A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060107
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

This RFC patch series introduces a weak function hook to allow platforms to
provide custom device tree selection logic while keeping common EFI
loader code generic.

Background:
Currently, EFI loader supports loading a single DTB file.
Qualcomm platforms require special multi-DTB selection logic that:
- Reads hardware information from SMEM (Shared Memory)
- Selects the appropriate device tree from a combined DTB file based on:
  * Platform ID (SoC variant)
  * Board variant and subtype
  * PMIC configuration
  * SoC revision.

Solution:
Introduce `efi_load_platform_fdt()` as a weak function:
- Weak implementation in lib/efi_loader/efi_fdt.c (defaults to no-op)
- Called from efi_bootmgr_run() after efi_load_distro_fdt()
- Qualcomm override in arch/arm/mach-snapdragon/efi_fdt_qcom.c

Aswin Murugan (3):
  efi_loader: Add platform hook for FDT loading
  soc: qcom: smem: Added socinfo header file
  mach-snapdragon: Implement Qualcomm multi-DTB selection

 arch/arm/mach-snapdragon/Makefile       |   1 +
 arch/arm/mach-snapdragon/efi_fdt_qcom.c | 339 ++++++++++++++++++++++++
 include/soc/qcom/socinfo.h              | 114 ++++++++
 lib/efi_loader/efi_fdt.c                |  34 +++
 4 files changed, 488 insertions(+)
 create mode 100644 arch/arm/mach-snapdragon/efi_fdt_qcom.c
 create mode 100644 include/soc/qcom/socinfo.h

-- 
2.34.1

