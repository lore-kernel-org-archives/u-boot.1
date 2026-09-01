Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145ECC624D0
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 04:21:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7C5A40556;
	Wed,  2 Sep 2026 04:21:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wKGZKAYdr6Ay; Wed,  2 Sep 2026 04:21:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788322859;
	bh=7wJ2OQzNYdnNmFEUmDubJSlvYKgsATJRdA+hN4ap2ag=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gq7Ud2NYqOthk/cQqCgNSP/MD8cHGrQ79S13frBT5FGoxqe1YeDmwf6Sys1r5PG8U
	 cNFjL33E5CQvBafJq/ZcYOpMuPGFC1QRaWEXrTl+1vlOPWz3nDb5hoPBkz51PTZUyE
	 Mm00SWfpFSFawxNYSju3Cc81xdFKvYjOnw5cj12vAi0OpWLjVnP+IYU9HvImoX7yiC
	 XoPDStEREvo89HkGgxAKP8IgPZ3xsa1R7QF4b1ohDCgH160QZ5c3PWGHuzrIyOkfsw
	 RZPwtYzVfUvBHrJcEg1Ai/CAHHnNv6vwmRme1zYq/xwCs3pggf5nwfyDgFcMvZ52Zp
	 0bIwyi8AHqXDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D416A406DD;
	Wed,  2 Sep 2026 04:20:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E46F2FE
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 19:58:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 60D004063E
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 19:58:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MnTnKsj4vVxR for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 19:58:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=CCvMOQl2; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WnCgIADx
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 609AE40641
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 19:58:44 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681HgDPf199658
 for <u-boot@lists.u-boot-project.org>; Tue, 1 Sep 2026 19:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7wJ2OQzNYdn
 NmFEUmDubJSlvYKgsATJRdA+hN4ap2ag=; b=CCvMOQl234YaoHR84/U7tM7L86m
 tYU5WXDEfzEWgM0x3so3oUxRstoz3fqYoz9nI0Gl9Cl9W8y6JcZ46o/Iozc3gZzd
 EXbBf5gUncbcFHQxOU+ieryWnloRNNPQP36oJ353O+ww4Z41tPMmw9CdiSQ0yW23
 StwEgEzIZuJvqoDm6wFGhgFLihgnKQvORnQWvGbBHTfYHlqx+169X0xQe1DP7Fki
 Pzg1lD6XV1Mi6FkUI18k1Rmf8M83bHxQpohpu+caL1RFB6/vzeOmJADMd0f6Fe7q
 KS7yynin0jYaCDMv2O1Z2mLs04uSLwa/ID24AnyPGubRY3y2jkSx/s7me8A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdsnu3rg6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 19:58:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e475f83a2so350331a91.1
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 12:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788292724; x=1788897524;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7wJ2OQzNYdnNmFEUmDubJSlvYKgsATJRdA+hN4ap2ag=;
 b=WnCgIADx4OiABp/C2AvuCCL343QSvAHo4Aj1+3spzr1MBjoFuFyjnmYulUY+Yj4x7S
 XiclgO32yDfa9fIiCKTPfmBnnp5oW9GAkPcs5ZX1DjACvAEKk4iphZNtJfdGFkWaRR/T
 nrpGbRx1T9VugGHtIBU/34a9kgAclAZS2dMbt8VYGh1iNS3zyxVW5WUnamdzlv8742B1
 w4mRrXFh92CkqurdKBrH30tVAJJ70LSyJA3Yo8OiboTZDpEEdk/7leA2F9j+dIdxhzV8
 xVXsG6dgQyd95ZImijQqIoQPJjPhs9eVEj2lnhKCyGGiodi3clYfz+v26rnPF2kK6tLf
 7CaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788292724; x=1788897524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7wJ2OQzNYdnNmFEUmDubJSlvYKgsATJRdA+hN4ap2ag=;
 b=pcmsrqTvj2nMckAB+Y6kaCNbigfM7VA+XBLrIE/mVHBL6EU8MglvXaFxMgVicdL2Uu
 53ZjLKj6vIT3NYy7YwOoA/jcdEQi1hUVUqbpseREj7dp5QPbLL/7DL3uXVdcWg56iRiU
 8141yP9BRlr4fE+mNolzKJUIIbvkCUMWxQ5S6PRxQ3NzEQb9iHDVxhCwri/aN/WK1pwt
 cnGbxJsfVQaLK7bxYXK3EztdaFBfqJiZuXQNfXoGC+Fg8eEtvlc3o+AfsG1hOS6/e0X6
 XNV0op4Olcsi4yA0PfCBk0LGRiKgM9p2tPnBv/pCNKb5FvkDCECR9ffCpJYL5+IzPYRV
 85Xw==
X-Forwarded-Encrypted: i=1;
 AKwUvByWw4IEJj9JjiCcbXFBwzFw7LjqV24w9U77MtqRbra67cdDVA1oVpayaJ/Jm9daCSkUTScSPE8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mQoECXX8H/D0K3YZNQnZG2M8r2e9XcWfHurKdhFZazaALJxr6G
 vQUyImVoJYsfnkdFY8LKk9oRr149JPMjj9qO8N2WRp4kmja3epzWc0FoVJ+PF745S9KKvOeLJCs
 ITh8TZLlS5QZgBVC7lN8GXJP8mENDvYdePu8gAKFozJxqSAqwPGg4KGs4Vu3Jez3JDOkGdyc=
X-Gm-Gg: AYBFou1p66BihATy22cKWQsK8UP+cYHzX3fs/4i2x/6YJwvx0ecy0jCQo1FRHshYJLl
 wATpDC3DGGP5fVmKsBsUqFPIwmWVrxYhiSxQ3TH8ke1cNC86JudlZo5nkX8jEKA74dex6d0Gde5
 D+Zc1KQoslxdLvs/HJqIgokpJbliZCfAkthV1R9obzgfWBX0HetaOc/6Gr7lrA1L9AOHKDAo5/m
 wcB7a8518ADsfM1Ny85HQAwNeh5u1WJy5ar5G4cV4XAJ5FcVK5x0qpfQBrE45NErefUdobb1OtQ
 zpWMZI4hNJUK004UIBWIz8QFfTAa7zf5hI7tgX8aNWRq1rF9higtGS94gjp2H909XTuIWgQWjw0
 HdHr1hht3aoJC8swYpjLjCBDZ4MVZtzf8aqdMfymIWX/QCrfXB2L+eWnj85+qPteMTAufp9QwYe
 1kO81l2i/DKPyQSyug
X-Received: by 2002:a17:90b:3904:b0:398:bc52:825b with SMTP id
 98e67ed59e1d1-39907e82897mr15022116a91.21.1788292723629; 
 Tue, 01 Sep 2026 12:58:43 -0700 (PDT)
X-Received: by 2002:a17:90b:3904:b0:398:bc52:825b with SMTP id
 98e67ed59e1d1-39907e82897mr15022040a91.21.1788292723119; 
 Tue, 01 Sep 2026 12:58:43 -0700 (PDT)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1430eb4854csm726433c88.15.2026.09.01.12.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 12:58:42 -0700 (PDT)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 sumit.dhami@oss.qualcomm.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Subject: [PATCH v1 3/3] configs: disable CMD_POWEROFF in snagboot config
Date: Wed,  2 Sep 2026 01:27:48 +0530
Message-ID: <20260901195748.1192630-4-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901195748.1192630-1-sumit.dhami@oss.qualcomm.com>
References: <20260901195748.1192630-1-sumit.dhami@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3NSBTYWx0ZWRfX12jYTN9ffq8i
 GpyFxPagLSpORL2R2kfrVZM7oxOuyUvLUJsU75MAXQFGLY2Agf/L4zWvIri0CMhrIuKOW6pn7KB
 S0Ol6pMQN/k71OVPkOfh0gWR55pJvGQa+DhpSPmreLtuR/xU+Wq8wdp3XaXjvDmSc3/ORK/lGoQ
 yjPCNLzMQWdHL3bFJ/Npkb54YUXFpwIHKqvtOQdzyNzuGlr8YzNoIhxoniRu0fCn6yGHFDhNqCA
 uS53dxpNq2OfMAvxOT8JnSdqR9iwnoY5jStCpjFy/2umtxi2WTrJdRPoOd9jGE9sRgU58sXH47h
 KP9LDJi+wV3dKAK2qfWBQHoUP+xplItaczY+reR6h5U+d8JpyLvNqeiNphewT1sXtT+IVZa5mMi
 mNq1b5bOF5D95rhTkJ7vub3L2C5dSM+yj/u0I0UUEXO0aZJgb/zMjDo0Uqe1vgItnApH0VgwLzZ
 YRTgYwKhk16vpaAqFKQ==
X-Authority-Analysis: v=2.4 cv=L6ItheT8 c=1 sm=1 tr=0 ts=6a972e74 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=eDiLCjgS2gUGnAqvYTQA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3NSBTYWx0ZWRfX+vwkkkrZj/AK
 vfXbXfjkKVEaUpi2jnyDJJ+rFpHD6kP5jVmfE2S0+uWd+3mHi7dpDURGYv6xWtb7fsKG+8gY6ME
 LQFVg6FXGlwLHfb0KifKinve3dH7oxw=
X-Proofpoint-ORIG-GUID: i6mECGzQuQj2_orDzWqFlETHGFpHdvEG
X-Proofpoint-GUID: i6mECGzQuQj2_orDzWqFlETHGFpHdvEG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
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

CMD_POWEROFF requires do_poweroff(), normally provided by psci.c,
but PSCI_RESET is disabled in snagboot mode, causing a link
failure. Poweroff isn't needed for snagboot recovery, so disable it.

Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
---
 configs/qcom-snagboot.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom-snagboot.config b/configs/qcom-snagboot.config
index d19ad453029..579bcc7732d 100644
--- a/configs/qcom-snagboot.config
+++ b/configs/qcom-snagboot.config
@@ -8,6 +8,7 @@ CONFIG_QCOM_SNAGBOOT_MODE=y
 # CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR is not set
 # CONFIG_IOMMU is not set
 # CONFIG_REBOOT_MODE_ENV_UPDATE is not set
+# CONFIG_CMD_POWEROFF is not set
 
 # Use default environment instead of loading from storage
 # This ensures snagboot mode works even with corrupted environment
-- 
2.55.0

