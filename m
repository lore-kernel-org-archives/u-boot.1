Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF23D148A3
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 06:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84B3B8405C;
	Thu,  8 Jan 2026 07:50:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kybcnA36";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a3+1tfDv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA0088405C; Thu,  8 Jan 2026 07:50:16 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5CB683A1E
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 07:50:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6086Nt4F3152513
 for <u-boot@lists.denx.de>; Thu, 8 Jan 2026 06:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=F67pQ4GFsvi
 8KtN0riaIQKRynr5N0H5g6cFIeIPkYmg=; b=kybcnA36EV5ITW/t8FFhK/Vai7H
 DqRwIlmfhmmH0b4UaWwq3m5S80QmM9lX/HSeb9y2N7kOPWEVGAUy41Pi+StN7oOd
 KtSXvFbdpymB3DvMpKHiODrMTUEGTswSCoJ5FaAHrBCCfIVHFAuG8GZFsZtVHFYd
 iOT0TtsfXOP85AClM4Bm71dXv3aXFzGNJe3ZqpWfTbARtwBHthmbm4j4kPCF6Q/G
 poJcjslj0oOHtCp3J5JFTMXw10/auQKGAsRWqZn2rrQgDGGYDMpks5je+7hqcG9n
 WNdF526BTJnHHCbu92ooukBG5X8Lc2HsU6NDodF9MExDoTyo8lk6EOdPcMA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhpjaub87-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 06:50:12 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a090819ed1so21726615ad.2
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 22:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767855012; x=1768459812; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F67pQ4GFsvi8KtN0riaIQKRynr5N0H5g6cFIeIPkYmg=;
 b=a3+1tfDvD/fHF6B7pVnW5/afBqB52NAoL5dbDlSCP2p1SIbv55jRzSX1uh2ATdU2O+
 xPOD7ZgdLILNNDUtXObT1A3R9hc8Q3393UqXuFzp4OgUCNmcmrS/SThXsnDKZzspnbFj
 YAbbm1DpjICnWtjjlzKtI0e97lt66aSF1MDI+06y/45mbUKvB+em7Yc4OUD/RjojuhiB
 JIktEnky5xh5IGZQKiN02fPUY3cYVENMR9xoKaf88uQzGZPDTZvnFG0pNoOPNbGjpxRk
 RSuKUR6X8yf/Gio/fsXBDm7AHyvLGD6N5CdCHM4J2pmV8gg0CYvN2n1As8t//FVMIp0r
 b0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767855012; x=1768459812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F67pQ4GFsvi8KtN0riaIQKRynr5N0H5g6cFIeIPkYmg=;
 b=w8gKTrtY1zdFdBxfckLoZwINHSrZPCxTcd5Wvtn0QTSglaq+ikG3xBEEyw2HNMcl/f
 msc8lYYSGTFpHyJMDXu1V7sJjcUkeAim9f7RuNZHMLqudEFFZC3W0mubPog51tnADjLo
 w/tFY3pkAV8v5m14Nfiyv9NqsW0HhwUn2NIAH7IqnbBM1NraXPEXV38qBiRe7DLdZBL5
 IP/1W+YwQOu0wTV4CU/mRW4p4yJKHC2VgOrpZJscU/vU6JD0651uR5tg6hAMRbs8cCv+
 McPb6HZhNuoENMYPzSQUrhmFP/2SrBXimeYgs448GPv7z1x2Ct+9bAimwQKk19icD54T
 PhQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxRQ1fbsoKqJxzUVi8+gumRlJU+8McHI0hxQQr2hJR+Z1MZL6QmBfFMqzg+PVTArJ7BRPw5VY=@lists.denx.de
X-Gm-Message-State: AOJu0YxOyJr9m+t/qUHmiHbILKT4gWk6avvoa6MkINDWbhKnKmX/l1bK
 wrQZHl2kmZDZIlHdf3dPCkR/uCcuKdC7Cy4BKEqXsiAc02iBdBnZh1ZWRuxMhjtR3Or2VmKnuRL
 OXPYpcfP+Hq0eEoo5sY6tzsglj1ZrvTbncU+ZV0tJyl9Poed9kIEDaCEv
X-Gm-Gg: AY/fxX4ZR45rSyMWP1t3r8TAjRpAqXWAU7kDlEnXtQ3Ud4JQzLiBTBcvTxPTWDniXqV
 UvmtLLa1K07o36sX7MW0NpB6t9/TUd6W1z3Si7Xx1Z5MXpNVeRMVBcbo6NdmwaC/WUxAlGBZdyb
 KtM+SrFSF16bEciEskXEZDpWScH67A/Y7ZbDFKL3aI2qS74fE09itQR0w4vHDO33inysnSHYvcE
 cJcFTz8ZG01m0bWYPiodXgAekrwosUirGhZjmt1zXUw0eDAh+i/jBqkH8ssdenJqR1xuLGtTDB5
 p8Oyhpw3PhFL0if2Os3+RhzGpDR7Vton0Y5CRgbAZBJVKbcx0s9ou2HskAxjfIMZzTjg6S9+odn
 9SPGDbLfyu+HAN5TAFvzNzZJpwCoOw2UVZfM47eEgcV4zOwXVuHItI6rdLLwzfsSXSpBPwu7z4k
 yyWnfxKPwHe/oBLUdmeLdM/+hlbokGPVyREIaouA==
X-Received: by 2002:a05:6a20:2594:b0:345:e30f:d6e6 with SMTP id
 adf61e73a8af0-3898f8f54ffmr4480082637.15.1767855011880; 
 Wed, 07 Jan 2026 22:50:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEksSHoCnVMirKpY43YfmRYt7gSJGGfkqU3cikQF9qWJ5h/Qsz7ttBkyALtTopjk5ebce/qxw==
X-Received: by 2002:a05:6a20:2594:b0:345:e30f:d6e6 with SMTP id
 adf61e73a8af0-3898f8f54ffmr4480064637.15.1767855011414; 
 Wed, 07 Jan 2026 22:50:11 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbf28faa9sm6918641a12.2.2026.01.07.22.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 22:50:11 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, joe.hershberger@ni.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 quentin.schulz@cherry.de, ravi@prevas.dk, javier.tia@linaro.org,
 quic_varada@quicinc.com, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, ansuelsmth@gmail.com, mwalle@kernel.org,
 anshuld@ti.com, jan.kiszka@siemens.com, javierm@redhat.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 3/4] env: scsi: Add support for partition type GUID based
 environment
Date: Thu,  8 Jan 2026 12:19:46 +0530
Message-Id: <20260108064947.3237361-4-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108064947.3237361-1-balaji.selvanathan@oss.qualcomm.com>
References: <20260108064947.3237361-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=efMwvrEH c=1 sm=1 tr=0 ts=695f53a4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=-VGp_zjJvz-jzAxn0VEA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: ArVbWPnTLqsoyoVfb-Vcl74djoyzH3Ul
X-Proofpoint-GUID: ArVbWPnTLqsoyoVfb-Vcl74djoyzH3Ul
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA0MyBTYWx0ZWRfXwy3ZqRftq6yq
 3Ai0iJiHk5e43mdP1M2oGW5vLAqt8dHRdgTGiqzRQDWlJP1UUL9kkCvDnrJlX2MtdScd+TaKaA5
 UcuEx1qAxQnpEp1Gh2YqzYx0RLVHesdA6ZkPOjGCNnuzTQn7L44Q38sXXOznJpyuOynOOAS2eMO
 2oL2iPWtD0Av3X+stLXNKgJm07ILwbIBgRuUnDdwGaNl3lMCgkwIkXkjjLxevRJR3uLC/L60uZL
 C9nb3z18/ZlPkJrRpseb8uD0Iy6njeOTaE9V2osqOqRWuwq/bTa9GRtE0gfDQJwETAmfdkWYzya
 ef38WRvst8Oa9QN7A3VhH0hBhwq6BuWdZtVbder2dmTRaHhh+mW9AfA5tBLfLxEJIa6HbHySaxq
 2JXoC7gipqK0BiToAB2B9PQFDP62CIY+R8LgdIRWZh6KiQpcH+FSGLdCr1EvJ7QOXaTQ5h3jM0W
 uyIHpjJCXa7GrKLiS5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080043
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

Add support for locating SCSI environment partition using GPT type
GUID instead of unique UUID. This enables the saveenv command to
work with partitions identified by their type rather than unique
identifiers, providing flexibility for systems where partition
UUIDs may vary across devices but types remain constant.

Introduce CONFIG_SCSI_ENV_PART_TYPE_GUID configuration option that
allows specifying a partition type GUID for environment storage.
When enabled, the environment subsystem uses the new type GUID
based lookup method via scsi_get_blk_by_type_guid() to find the
first matching partition.

This change maintains backward compatibility with the existing
UUID-based approach.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 env/Kconfig |  7 +++++++
 env/scsi.c  | 13 +++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/env/Kconfig b/env/Kconfig
index b312f9b5324..97cb3d05daf 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -768,6 +768,13 @@ config SCSI_ENV_PART_UUID
 	help
 	  UUID of the SCSI partition that you want to store the environment in.
 
+config SCSI_ENV_PART_TYPE_GUID
+	string "SCSI partition type GUID for saving environment"
+	depends on ENV_IS_IN_SCSI
+	help
+	  Type GUID of the SCSI partition to store the environment in.
+	  Uses the first partition matching this type GUID.
+
 config ENV_USE_DEFAULT_ENV_TEXT_FILE
 	bool "Create default environment from file"
 	depends on !COMPILE_TEST
diff --git a/env/scsi.c b/env/scsi.c
index 207717e17b1..6182ae26679 100644
--- a/env/scsi.c
+++ b/env/scsi.c
@@ -35,8 +35,13 @@ static inline struct env_scsi_info *env_scsi_get_part(void)
 {
 	struct env_scsi_info *ep = &env_part;
 
+#ifdef CONFIG_SCSI_ENV_PART_TYPE_GUID
+	if (scsi_get_blk_by_type_guid(CONFIG_SCSI_ENV_PART_TYPE_GUID, &ep->blk, &ep->part))
+		return NULL;
+#else
 	if (scsi_get_blk_by_uuid(CONFIG_SCSI_ENV_PART_UUID, &ep->blk, &ep->part))
 		return NULL;
+#endif
 
 	ep->count = CONFIG_ENV_SIZE / ep->part.blksz;
 
@@ -83,12 +88,20 @@ static int env_scsi_load(void)
 	int ret;
 
 	if (!ep) {
+#ifdef CONFIG_SCSI_ENV_PART_TYPE_GUID
+		env_set_default(CONFIG_SCSI_ENV_PART_TYPE_GUID " partition not found", 0);
+#else
 		env_set_default(CONFIG_SCSI_ENV_PART_UUID " partition not found", 0);
+#endif
 		return -ENOENT;
 	}
 
 	if (blk_dread(ep->blk, ep->part.start, ep->count, &envbuf) != ep->count) {
+#ifdef CONFIG_SCSI_ENV_PART_TYPE_GUID
+		env_set_default(CONFIG_SCSI_ENV_PART_TYPE_GUID " partition read failed", 0);
+#else
 		env_set_default(CONFIG_SCSI_ENV_PART_UUID " partition read failed", 0);
+#endif
 		return -EIO;
 	}
 
-- 
2.34.1

