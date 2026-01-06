Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F85CDC192
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 12:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09DB583F64;
	Tue,  6 Jan 2026 13:22:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="p5kAL5L5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ArkUjJu6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CB6583F01; Tue,  6 Jan 2026 13:22:28 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A76D483F63
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 13:22:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 606B24JK2255188
 for <u-boot@lists.denx.de>; Tue, 6 Jan 2026 12:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wQc4d70DnnH
 PkXtUTHk3fQLVW4fJDePX83LZOgJA/bc=; b=p5kAL5L5TZBykJpa4IL6MHDQ4FB
 UOiNHEMdqsWKCk7qSahw0Y3IpxCU/mDVrM9n4MPXd+yaI/Vxf6ahOKWRIxPBnewk
 IRQd5k25wANfkHlSjh2HvNLTIOT4EVdliYRwLpk+4j4ZMRd77PcHo1OokKRY0znA
 FDSGsf/189W1khA4+TgHEwcP5SqeohVypbLZOXfP12QqM9uZzVsSMu31DVnwZhK1
 MeAdaHUnBB4FQ0+oCCdnd9iYe1OXBIM1X7+rDm3vpII7MFQEfaziArVMDLHBMyVt
 tEb5GGKg54c188Ry5C6SY2aCLJnlP4AffKc3B1mD98eii+diDCCMQzGkDMw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgu421av1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 12:22:11 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-34c5d6193daso2158541a91.1
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 04:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767702130; x=1768306930; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wQc4d70DnnHPkXtUTHk3fQLVW4fJDePX83LZOgJA/bc=;
 b=ArkUjJu6Xcsh0sev6JyHQdcQ3IOLLgvmsOv43GKA2QpoMLBdrKjwmzSBaHE/LJi1zh
 ZlAmc/q4MODDrCPDXItEO0NAklUJsVLcvcx6NGOmnQgZUXDBgFTZ8LNRpz+dnIJ8Y9eZ
 6OtzGbpMlykgXKEUUOXtRIxNZZ/sBExbrdTuXo81r88bp35v4zhSe5Z3F9AgkfML4FjS
 B0W5OBI8cWr78VP4YkeccAfDBXQPiljbkikbf+YeOCBdtPGNFDz2VfVAQKH3V65Izh9Z
 xm79zfyf5aQeIWUOYdw+dOKvlA9qtQ3NjOpsCOad/7Xhb4wDpQHglits6r9nYeL+m3Vr
 s73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767702130; x=1768306930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wQc4d70DnnHPkXtUTHk3fQLVW4fJDePX83LZOgJA/bc=;
 b=f+PybbAVtGFfXP1qbzh8fdczggLtAB/8IOlpcb/Xg2V4za3wFPfJ4r8VmSOmjXmL28
 0VCvn5wRgduvF/TNzBlQwMQoJQnWzRMVw+tBgGQicteEQrJDEIkFpCgNTjtQQeyLP5mo
 ClsutMJGdM+CacA+IrMO69GGPP3b4Unj6/yH9YtZ6vH49cdNftIpUAwDVkg+gRc3G33B
 vr+MPSn0PApKZKvjSfKT3/JhdxTMp8MMsSDVspZyFzaILNF6O/YnqCaHuK+tYd+OhHdH
 iCn4ASG5Cbl6dtqhncxACHVb70yovzBcqXT9Yjtl7Vcko5lqa3tgsChqxFSABbDy4CC0
 OCxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0XFZv49vcVSkXuDBH9BA+LJcJcYfVkxmHELOBzTSZu23Q/rPJY5Go4/c5vkbwe0VKyQNB/Ao=@lists.denx.de
X-Gm-Message-State: AOJu0YyC8OUXiFu1PAh9Vb6yehFhrbhUpaDxR/Ubz/dnfPq8OTSeYR63
 DHgx+/Az/ckfggM5tMhw3G11H8Vh5jr6Dv47VWbxozBIPAuncrvdjGPnKguieLDhn6hbWLtvhDE
 4CbXi32PTckg/VG1/oz32XbgydkKf3S4OqW07aYQ9QVYDe9oMwUAPdmlc
X-Gm-Gg: AY/fxX6vDHxS36sOLS9/LtVnhrFIvV2KnI0FZRlAGDawYV/G5jAg7JkZQqGKq/BoqmH
 PJwXiCQ3XIgt7g4tHkXl/wtIrla4itgZvuvYc2z9/KL6a2YXn2e0VLldiLrB+dhUjb+rQTLrFkw
 NHNZ4cupI4yzPozdE7WGN8rUrU75g192ee2w/mbuicBOb2CDbFTPM5acrFQjlkPrmLHt5tWZcyn
 MNbSTA0IGEDHEubVRLmx35RJksDqhH2Zvtvx7ks+J9DsfZgaRpec7rvniWhdnH3aemraZRQ0jh7
 si4bc3IvOet+jhUeJL4lxu+A3TH8TipBj7eKTF1sLRX6HiFyo8ow941QVPqrmqcEAvw0l8Ft0i9
 FPvGRmaLUk5nP5wVVopnTtyuAgw3I/+0PoPPzBYFE3qTDyq6WU6bA2FusSKAUXzmRUz8a8KVrk/
 L7q+4JLD0Xeu1g4DLTNrfDfS/Bfa+V
X-Received: by 2002:a17:90b:554b:b0:343:f509:aa4a with SMTP id
 98e67ed59e1d1-34f5f32e7d5mr1959751a91.36.1767702129833; 
 Tue, 06 Jan 2026 04:22:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9c5s5oy0hWUZjQXGxeKRYzSgmIK8TKhfoLGpipMeQHHnVqGbAgeVoTip3K2O0VUSfh+9DHQ==
X-Received: by 2002:a17:90b:554b:b0:343:f509:aa4a with SMTP id
 98e67ed59e1d1-34f5f32e7d5mr1959719a91.36.1767702129372; 
 Tue, 06 Jan 2026 04:22:09 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5f88efb5sm2231509a91.10.2026.01.06.04.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 04:22:09 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 adrianox@gmail.com, paul.liu@linaro.org, sjg@chromium.org,
 wolfgang.wallner@at.abb.com, javier.tia@linaro.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 1/3] efi_loader: Add platform hook for FDT loading
Date: Tue,  6 Jan 2026 17:51:32 +0530
Message-Id: <20260106122134.2047864-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com>
References: <20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dYuNHHXe c=1 sm=1 tr=0 ts=695cfe73 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=b34RTg_B1F0iJdwLwDYA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: -E8OiYHbl3zldGO5nlfIdtIa5-3-6kvp
X-Proofpoint-ORIG-GUID: -E8OiYHbl3zldGO5nlfIdtIa5-3-6kvp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEwNyBTYWx0ZWRfX+y20VOlypL1d
 4SqDzf22VFsa+nkvOWpH7u/wL5vbJwdsN9NvTTQ31NPZrs2xi/kYqkH4CUh+IL8Hv9bu56fiVrM
 uz9lyX5OfJH713Q2EOlFvb1PqbAzbmmtVHMI4LOoUw6qdezcvkFKw6Q/PrDBbcJTtsuRYHSfsZO
 SVkbA3TXbbpZy9wm15BbKwAt3UqNyMMtz8tidKKrbL2Z3o83XHNyt8iZGHeFzRgqHGg0COlZnc2
 uiEikFIb8/Fm3roZ+MD5GXoick9qdJiPqQZcJC8DmDpNVNN3vjibyz01PM3vkTdrlGi4mKQUx7C
 UBYW33QqshMqzZASv8kgD6LMUq5YEegPJaUZIs/SHze8eSEewg8YmYIbDm9z9PhINw8BJ+zz9n1
 HmuqHJcwv4fHhejW3A8jztl6ptI526Ph3J8uEobWHG8fTsFRz1T0dOM6MLCeifCAupZvo5eS4Qa
 lleZMSm48R0AjuIV5jQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
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

Introduce a weak function efi_load_platform_fdt() to allow platforms
to provide custom device tree selection logic. This enables platforms
with special requirements (such as multi-DTB selection based on
hardware detection) to load fdt.

The default weak implementation does nothing, Platforms can provide
a strong implementation to load platform-specific device trees.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 include/efi_loader.h         |  2 ++
 lib/efi_loader/efi_bootmgr.c |  4 ++++
 lib/efi_loader/efi_fdt.c     | 23 +++++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 3e70ac07055..62c3df48f71 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -1303,4 +1303,6 @@ int efi_get_distro_fdt_name(char *fname, int size, int seq);
 
 void efi_load_distro_fdt(efi_handle_t handle, void **fdt, efi_uintn_t *fdt_size);
 
+void efi_load_platform_fdt(efi_handle_t handle, void **fdt, efi_uintn_t *fdt_size);
+
 #endif /* _EFI_LOADER_H */
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index a687f4d8e85..ed06a65feb7 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -1332,6 +1332,10 @@ efi_status_t efi_bootmgr_run(void *fdt)
 			efi_load_distro_fdt(handle, &fdt_distro, &fdt_size);
 			fdt = fdt_distro;
 		}
+		if (!fdt) {
+			efi_load_platform_fdt(handle, &fdt_distro, &fdt_size);
+			fdt = fdt_distro;
+		}
 	}
 
 	/*
diff --git a/lib/efi_loader/efi_fdt.c b/lib/efi_loader/efi_fdt.c
index bfaa9cfc207..bfcfd933adf 100644
--- a/lib/efi_loader/efi_fdt.c
+++ b/lib/efi_loader/efi_fdt.c
@@ -78,6 +78,29 @@ int efi_get_distro_fdt_name(char *fname, int size, int seq)
 	return 0;
 }
 
+/**
+ * efi_load_platform_fdt() - Platform-specific FDT loading hook (weak)
+ *
+ * @handle:	handle of loaded image
+ * @fdt:	on return device-tree, must be freed via efi_free_pages()
+ * @fdt_size:	buffer size
+ *
+ * This weak function allows platforms to provide custom DTB selection logic.
+ * The default implementation does nothing, allowing the standard distro boot
+ * path to handle FDT loading. Platforms can override this function to
+ * implement custom multi-DTB selection or other platform-specific logic.
+ *
+ * If this function successfully loads a DTB, it should set *fdt to point to
+ * the loaded DTB and return. If it cannot load a DTB, it should set *fdt to
+ * NULL, and the standard distro boot logic will be used as fallback.
+ */
+__weak void efi_load_platform_fdt(efi_handle_t handle, void **fdt,
+				  efi_uintn_t *fdt_size)
+{
+	/* Default: do nothing, let standard distro boot handle it */
+	*fdt = NULL;
+}
+
 /**
  * efi_load_distro_fdt() - load distro device-tree
  *
-- 
2.34.1

