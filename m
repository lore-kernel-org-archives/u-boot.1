Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E1DC55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 15:49:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 065FF40571;
	Mon,  3 Aug 2026 15:49:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Efg-gs8tMUo2; Mon,  3 Aug 2026 15:49:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 036EE40580
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785772181;
	bh=KQmwaOAf+IJH7breN7SZ1KmvtOxw5rksSf9MEEOhWbA=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=Wg7+MsBGgaEwMAQe3BOFyggL4gnCpJe5Yn5rNx2Lmz7VQswSE+Lqx1zSVgpa69YfF
	 737yg0lmJJ85fw5Wap49Ikz55PkSHuVzRP0wL30w1WI+5dJpuSnJtgBFvz7wldaqal
	 tWTbD9XP0P2z3u++E905OJSOm5Bo7dd3YiAQ4JxL+AangNTDjCbqT4TSycRPOlKJSG
	 8b/UZm2QHRzhi6ZQmoryS9C29kHbljxKlMF2HKCBmWv91MCZO8RBuwtvV6u1+EuScy
	 0bskEqTRuCge9BniWtRpTiMdHxyqQHA/Huheh5m6+zAEb5f9fmd7Plxw8vu9Mwyp4W
	 o8VRCKrBYv3HQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 036EE40580;
	Mon,  3 Aug 2026 15:49:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 33B7836E
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 22C0940580
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:49:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8n8d6SYaezIB for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 15:49:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F009940571
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F009940571
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F009940571
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:49:38 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673EBvGD1355032
 for <u-boot@lists.u-boot-project.org>; Mon, 3 Aug 2026 15:49:38 GMT
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnrdac1m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 15:49:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38ec0f510a9so8824776a91.2
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 08:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785772177; x=1786376977;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KQmwaOAf+IJH7breN7SZ1KmvtOxw5rksSf9MEEOhWbA=;
 b=dBH8wRwZnijQ2XgpTTT8xO8AHKLZD8FQ2ydvElRWSa6VqWDqM2/ltUGwuTvVolxhL1
 WkGdgU2bWD6kZ/ew6UbEb8Sm1LQ94PYPEsx/mPIHbn1GdCymAp25gN3kD87GsiT2frIY
 KZNvJ++8azoCvYy/qqmzXzftR5jjXwzhRcQ4+eO7SphgPD61EXW3oGcdTKpEsKacrXrW
 hm41u3PmHF54e715ZbG0uah6pM/udNN4QxYjoqlTEmh2bWuP6/zJ1DIYdnSG8pAF+xYc
 awE9mApxD0Crc+n0VZae2WsjUAjyjX8QIbqaKnycmzXCwW+3aHa1khtR8o+h8SGXQIvd
 6LgA==
X-Gm-Message-State: AOJu0YwAzPyPmiNfz+dv6oazjjBHd0Uu216jD7MwZh7i8KOzYbyjr/+P
 78nTQL9Z2awQx3bdXRdqiGSxR300TJ/UOayf3DcsdAeSw7ToXo881ZVaF+7EimmU99oknu1Ozy7
 iNuCq/Q0TYKavfC9S/uTAIgUbkmoKVdEkZz5Pqfs9wrtKM1jECylD3r17/75ieOUoHT62LBU=
X-Gm-Gg: AR+sD10OMQwENBixJbhPmHhFhG56zolSk7N8Ak2LDBpHNXKY6Z28ABNki5yxiGL8c4k
 Rtm49LpPbU2NpOzpuhTEWd/JLNj6txmzXjzuSaG8ySWNGFzquTdD5P7i47wm5prx/5FgOHXyBSH
 OTacWJEgrTlToTK4LDHrZ4YCs2mSmuEltw9m2Tf3G+DXB54KtBHwVY1hTr/JqVvN7rDTVseEytv
 dsa14c48NvK/HgV2Kek58pCzwcqk3a6s64MAOtPSvnNrDIFtwpQgaRVQxuYV6ypv0N5hNxHkShW
 VI14c63IskMzGGf/lkQJ1lUs9/3oqTVwhE59AugPhvYNflaWGlCizid+AMBk9Kbt71PjOYmkam7
 Nps1QuFcUWNKhZYDBjNDQwNXPUA/lbKCBBXFVSHmQbeIagBwHcm/7+0zrylXEn9owsVC46V8JJ0
 r1WYPwGscOVMx+4Op3spoHCheUrNu5
X-Received: by 2002:a17:90b:3c44:b0:37f:9ce1:cda8 with SMTP id
 98e67ed59e1d1-38fbc511c1dmr9460428a91.30.1785772177236; 
 Mon, 03 Aug 2026 08:49:37 -0700 (PDT)
X-Received: by 2002:a17:90b:3c44:b0:37f:9ce1:cda8 with SMTP id
 98e67ed59e1d1-38fbc511c1dmr9460399a91.30.1785772176763; 
 Mon, 03 Aug 2026 08:49:36 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab13255esm29356854c88.3.2026.08.03.08.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 08:49:36 -0700 (PDT)
Subject: [PATCH v5 0/8] (no cover subject)
Date: Mon, 03 Aug 2026 21:19:26 +0530
Message-Id: <20260803-snagboot-v5-0-00ef4542934e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIe4cGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc2ND3eK8xPSk/PwSXZNUyzQzszQDI1OjFCWg8oKi1LTMCrBR0bG1tQD
 IMWhDWgAAAA==
X-Change-ID: 20260731-snagboot-4e9f66f0252d
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785772171; l=5574;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=tVczlhMR8kF5cRzh+uOJVyNtjyDO+3nmhwCD17be4/o=;
 b=kOQ8OLZ53Vft/e+7SIXPoh7tMYHUaaSoTOgxNQu5UQr/tx5/HjR5jaFqcfHHbuBHatBwmhXG1
 DtQfDdGQ+LqDWgM0lFUqJdyRuFdPeXr8Tv8SH+AF06K1R2t2KgEAKfe
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX656gM9hefo7f
 fF+lXuEWkIDaYppC7laWAJzGzEjSZavzsm028zH4DYwBpWmNGIqOno81kL0Zz8ZPnr/Vb/q+9yu
 7QhOqRrH8ApVbudIUM+hkk270/JDuDc=
X-Authority-Analysis: v=2.4 cv=f/94wuyM c=1 sm=1 tr=0 ts=6a70b891 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=4GZlKNTyZuL0fuDD4_0A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: nJ4XMHlLJPI61nyzzR4dLncB6EC-kKII
X-Proofpoint-ORIG-GUID: nJ4XMHlLJPI61nyzzR4dLncB6EC-kKII
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfXwKzLlBuHGdEc
 6ldeU4mLFfS3oRWB+h51Fq7NjPNlIIgv7SXllIcxvQM29o6AFYHdjIE5cIB9w2XiKgaojGVQ2rB
 K405S1iSErJfELoJMSOZCXWYFDNZyo7lWlel/JaA6cFXS5yxg2UijKjej4BrwNA/yG/UIVs76Cm
 XQk2y8SxHK/+82i34gFKgIyxy0yRpuxT2ULKgMce0UMFPDYI6hy5wtDyjd8FjqkKdnXU3UJEFyu
 gH9c9sclIeuuA5SyGJpvrEx5dyrfT3jddUkeDJcOUKbs0iDXy/DQolvAwlhq73uL4NGKXQJkUiF
 6XArGYp4mWVilNGb6nCT7SQRTVm1A9P27NQN+wV7GTMafeMvqoKvWED1Toeue3MSrM9c0g6IKls
 CGstlx6+/rcOVM97YbEct+kSmEV7QaT2cRdLGWdbQwSr58BehLFJgF7OTkyia7lz+30pxH6GneQ
 5DRG7AdEu1d4QXSHvlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=KQmwaOAf+IJH7breN7SZ1K
 mvtOxw5rksSf9MEEOhWbA=; b=Mc/U1HlyC25982ekEem+PNgSa1a9s7K/PKjPgz
 Ps92IJKA+rdu6Uv+O4ZMKaoMyC3ZXx5iPZOlScMUM9D/Ugy6EWCppeA2i74XFpr2
 AChT6gvhMWHxEOtKw+umdWdDCqrhGqy08z81aI7Riq17GpJTNZNtSSvYzRhwbhhg
 K+lKIEx9/6ljLaYUHuaQ3OmmGkt6F4nMNtH056EFEZeSugtnRV2kuj1SsKlkSY1a
 jiAjzMDDBRZhfEafHvw5WYQdWVt2v6KY/0ShHvMY+DoOVC+t9OO7p4YxZA0nmYYh
 8B7sFz3HqGy2OPY6jDcUEpdnng/GkpsinKNh3djtawxufsmQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785772177; x=1786376977;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KQmwaOAf+IJH7breN7SZ1KmvtOxw5rksSf9MEEOhWbA=;
 b=PXfNkLuxlY3ynianUqshV11lFmLn4/tNAR70vjTi9ot1LaXj7HGRmfv9J02c1+MPgq
 VKJrbnpFlS853Jb2/SpVi2CbbM3gip997Jjiut4O+76K7ZetnnBrbsJMLxIw8PjwwLuu
 HzCRW71Ns/Vi5tDQEg0HpFeZjncDK3gtMF7BVQWuxe/x1me9gXZPnmA9mN1437YSeDJ7
 798r8Bk52j8kwi83dkhWT6I4pKfDF3k40oWrivRhJjXUYGk8E8jwiyXUGIQh1lPwk/n3
 OvmRKYzDm0whOusaNNmbAMh9crt837l8eyifyfzpTp+YV0x0SzmJXi3wiJlB4z3hYiPx
 LivA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Mc/U1Hly; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PXfNkLux
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This series adds support for running U-Boot in snagboot mode on
Qualcomm Snapdragon platforms, targeting the Lemans-EVK board.

Snagboot is an open-source, scriptable flashing framework that provides
an alternative to the proprietary Firehose protocol for device
provisioning. Like the traditional EDL+Firehose flow, Snagboot uses the
Qualcomm boot ROM EDL mode and Sahara protocol to download
and execute bootloaders. However, instead of using the proprietary
Firehose programmer, Snagboot loads U-Boot into DDR and uses the
standard fastboot protocol for device flashing.

The framework consists of three modular components: snagrecover
(downloads XBL/QCLib to initialize DDR and load U-Boot into RAM),
snagflash (communicates with U-Boot over USB using fastboot to flash
system images), and snagfactory (orchestrates parallel factory
flashing tasks).

In the snagboot execution flow, ROM code in EDL mode loads
snagrecover, which downloads XBL to internal memory. XBL executes
and initializes DDR, then snagrecover downloads U-Boot into DDR and
transfers control to it. At this point, XBL has left the MMU enabled
with its own page tables and has not initialized PSCI firmware or
populated the Command DB. U-Boot must handle this non-standard boot
environment to enter fastboot mode for device flashing.

Support for Qualcomm Lemans-EVK SOC in Snagboot is now available in
https://github.com/qualcomm-linux/snagboot/tree/qcom-next
Soon these Snagboot changes will be upstreamed to https://github.com/bootlin/snagboot

When U-Boot executes in Snagboot flow, it has to deal with missing
platform services such as TrustZone (TZ), Hypervisor and AOP (which 
populates CMD DB data).

This series depends on the following patch/series, which are already
picked up in qcom-next
https://lore.kernel.org/all/20260508-qcom_spl-v7-4-7d0e22aaaa8f@seznam.cz/
https://lore.kernel.org/u-boot/20260618-b4-modernise-smem-v3-0-472391477988@linaro.org/

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v5:
- Make QCOM_BOOT0_SNAGBOOT_MODE as hidden config dependent on 
  QCOM_SNAGBOOT_MODE
- Disable C (Dcache) bit of SCTLR_EL3 register during MMU disable
- Remove now unused QCOM_COMMAND_DB_OPTIONAL Kconfig definition
- Disable unnecessar I2C configs (for Snagboot) in Qcom Snagboot
  config fragment
- Add build steps for compiling U-Boot for Snagboot mode in
  Qcom Snagboot doc
- Link to v4: https://lore.kernel.org/u-boot/20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com/

Changes in v4:
- Renamed QCOM_SNAGBOOT_SUPPORT to QCOM_SNAGBOOT_MODE
- Make SYSRESET_PSCI dependent on QCOM_SNAGBOOT_MODE
- Place Snagboot related configs in seperate config fragment
  called configs/qcom-snagboot.config
- Include above config fragment in
  configs/qcom_lemans_snagboot_defconfig
- Removed Lemans EVK override dtsi: arch/arm/dts/lemans-evk-u-boot.dtsi
- Removed QCOM_COMMAND_DB_OPTIONAL as now we use
  CONFIG_QCOM_SNAGBOOT_MODE
- Added documentation on U-Boot for Snagboot 
- Link to v3: https://lore.kernel.org/u-boot/20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com/

Changes in v3:
- Brought the MMU disable logic under CONFIG_QCOM_SNAGBOOT_SUPPORT
  ifdef condition
- Moved the MMU disable codes to a new seperate file
- Used "if (IS_ENABLED(CONFIG_QCOM_COMMAND_DB_OPTIONAL))" instead
  of #ifdef
- Removed enabling QCOM_COMMAND_DB_OPTIONAL, ENABLE_ARM_SOC_BOOT0_HOOK
  and SKIP_RELOCATE as they are now automatically enabled by
  QCOM_SNAGBOOT_SUPPORT selection 
- Removed updating MAINTAINERS as the defconfig file is picked up by
  the "N: qcom" line
- Link to v2: https://lore.kernel.org/u-boot/20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com/

Changes in v2:
- Changed SYSRESET_PSCI from 'select' to 'imply'
- Guard show_psci_version() and qcom_psci_fixup() with CONFIG_ARM_SMCCC
- Disables the MMU and invalidates TLBs at the earliest entry point
- Add qcom_lemans_snagboot_defconfig for Lemans-EVK
- Link to v1: https://lore.kernel.org/u-boot/20260409-cmddb-v1-1-b10549b34133@oss.qualcomm.com/

---
Balaji Selvanathan (8):
      arm: snapdragon: Make SYSRESET_PSCI optional
      arm: snapdragon: Guard PSCI functions with CONFIG_ARM_SMCCC
      arm: snapdragon: Disable MMU early before U-Boot reset vector
      arm: snapdragon: Add CONFIG_QCOM_SNAGBOOT_MODE option
      soc: qcom: cmd-db: Allow boot without CMD DB data
      arch: arm: dts: remove Lemans EVK override DTS
      configs: add qcom_lemans_snagboot_defconfig for Lemans-EVK
      doc: qualcomm: Add snagboot mode documentation

 arch/arm/Kconfig                                   |   2 +-
 arch/arm/dts/lemans-evk-u-boot.dtsi                |  19 --
 arch/arm/mach-snapdragon/Kconfig                   |  20 ++
 arch/arm/mach-snapdragon/board.c                   |   6 +
 arch/arm/mach-snapdragon/include/mach/boot0.h      |   2 +
 .../mach-snapdragon/include/mach/snagboot_boot0.h  |  27 +++
 configs/qcom-snagboot.config                       |  46 +++++
 configs/qcom_lemans_snagboot_defconfig             |  18 ++
 doc/board/qualcomm/index.rst                       |   1 +
 doc/board/qualcomm/snagboot.rst                    | 224 +++++++++++++++++++++
 drivers/soc/qcom/cmd-db.c                          |  15 +-
 11 files changed, 358 insertions(+), 22 deletions(-)
---
base-commit: f79edc9ad08ec0c3e40323ff17cc7166ad2b9e71
change-id: 20260731-snagboot-4e9f66f0252d

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

