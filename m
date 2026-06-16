Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68894CD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 09:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C457848A2;
	Tue, 16 Jun 2026 11:23:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YgrRHxBI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mpyt6/cx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2E45848A6; Tue, 16 Jun 2026 11:23:20 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A7A984105
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 11:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G7TLad2528215
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 09:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NBL9DcZxKmAOyYKeSmAEt7qAkjfQaa2YAhH9X3oNKQo=; b=YgrRHxBIXbTbBo6O
 M6GgA8kuyfRey25K/JroSt191FOFc0Lu5jWLrtXWJM5OyKMOhT9a7L7nY8S20Nl8
 OsliKxKUZuqOMOCltV5M6BSM8hXPKR32RiHWGsVScbaAjRuR8JgfiRtIIeqDjPxK
 dsDtRCrFmRQLq2TEiJ0thcAu8lw0hDnGzFoaujs7mAPl93BWlSDIRVvwk/XgA5n4
 n+1xySYD6/pWAPEuDPkBJMsCXK4vUt2UkpNSheP6oaaBf0d53fZUyShA6q565Hgb
 LNqxjbYmPkDLAnbiwWkq+q9YIatiq3gH1qN2XcpOjVMO4tuHMuglndxtz23/CGLu
 oovQ4w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu253gft4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 09:23:16 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-36d992fa39eso5085543a91.3
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 02:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781601796; x=1782206596; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NBL9DcZxKmAOyYKeSmAEt7qAkjfQaa2YAhH9X3oNKQo=;
 b=Mpyt6/cx5ewVAzSdRHB2wiRd5t6QLskdZeJh4trMu/D1jzTIYTJeyHvywGlXmuO6gc
 k0KKVqTI49xQW+4NURt2Kyxm5KNgf9eT0FXmDJP9qF+gO3R1KxMU7BIiHckisKw5fTfp
 uGE0/8Zb5pPgakhyGU2wjF8ay9GRe6uY8sqcTT3tXXOxUqfxUuYWS/G1qYcjQV07YVhB
 uy7VBEGVfmltWDk8fwHjF+KPpBeHQwZD+9zms+DG+4kvAcPcfrvlGjd/VKH+dEDc/ycD
 N5Ldp6Tgcst9c+Jw58EQi820yyjxm1CVJiGqas1PrzgdKNklsWFS5PhVHjhFR1ndFRcZ
 3NOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781601796; x=1782206596;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NBL9DcZxKmAOyYKeSmAEt7qAkjfQaa2YAhH9X3oNKQo=;
 b=pxZ7VbLNFI20qgZRRzGUkQBIIrGzGHplGM56H7KAXVfIE/xNFhVdaV2xKNfTfaabYI
 pf5qAzIcvx9B0+V9mlPyhkxhyhjmdT8S7nHkfaZdYp13cKf/z1UC6/4/H0E94Tnv4i8o
 gPv1F06PCEDh3kKVsF34exnBkbqH0S2bOjrunA4njt0LHQGl2R2UsbD0jKKTHJiSOOcV
 8FQPCGtVnUB3SuQ1q92RHPM1ilRWKLq4ScIshMnKPdsMrWJQsuceHZMZN3NOyjPfOdoa
 7u7fi2sXe9PLou+DoPlT9b2jNfygAlp+KJ3tb5nx0brKFidb4tsdqFmEtqUMMBrTVC1K
 XOQw==
X-Gm-Message-State: AOJu0Yw0IUeMJteRy78lKydQMWm8Yp0loAYWxZd8y0mqlc4WHV+f0msd
 FvN80ZRSkTFzMZbrvyFJLp8e4cIwMjZzaTwPlgxYIBJOKmubqEj+Tyxl5dIsFoavMFPnpalAwu1
 A6L3mHsbFxOwo4M9ZZthMPaNAFmUJaeXzV6x6kl8Vsd8RT94Q+MAeUftr
X-Gm-Gg: Acq92OEZXpnU8qh8T6YEk9oz6xMnuFFvsEh6qCtUEhmXmAnAANZM/l4cFvxwZ8+4rsf
 iS/d8EhnlFfQpvog3zfXVZGOXeRFyRExulw+F2RTEzfB3bEPCkjtMOVAmYhHdWOnvY3Q87kW/zU
 VNnVsG6Iom2HJsPjGRyzptJT+MKg3YSjLoArzD9MfBMetezTjcBzR6JKYcnIE3YH46INV/8z6xU
 V68dsLdxorpmcueVL07S3K59KPgzgjfIZUSjmfQ1pK72jYUtHIizsFxkxAmo+VoKLRtmRMsKlqR
 yx4h4RDL3edN40PKBAdTfWebapC/27sh1gXjT2n4rknCsoRSgxuYN2J9ch9afgvmcq9nRSQytXO
 kIIptPY+MimVzGuNYr17l7B7dDcWyTUZ/inlAEF87xMSSsUVURCjqfBJhHOMtH5a53bqvc6PPAn
 S/s6M0Cl8DFCC2ZRJB1UPomYk1ikLba4l2mF4Md83TRGHYYcpg/Q==
X-Received: by 2002:a17:90a:d44e:b0:36b:2179:6d23 with SMTP id
 98e67ed59e1d1-37a01c36da1mr18828245a91.7.1781601796177; 
 Tue, 16 Jun 2026 02:23:16 -0700 (PDT)
X-Received: by 2002:a17:90a:d44e:b0:36b:2179:6d23 with SMTP id
 98e67ed59e1d1-37a01c36da1mr18828210a91.7.1781601795759; 
 Tue, 16 Jun 2026 02:23:15 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c522136cesm2360005a91.14.2026.06.16.02.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 02:23:15 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 14:52:52 +0530
Subject: [PATCH v3 2/6] arm: snapdragon: Guard PSCI functions with
 CONFIG_ARM_SMCCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-sngboot-v3-2-6fb0dee8125c@oss.qualcomm.com>
References: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
In-Reply-To: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 George Chan <gchan9527@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Simon Glass <sjg@chromium.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781601774; l=1355;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=AG5CCFOaAjxzSBzkDWGPd09RSLzFrOT+SNzdRhlJ8xw=;
 b=8BH5JYlh9gkeUVIQOxKVpNa69AsDJn+dICc2a8FQTlG/+vqutx0t1DI7Vmr/42P1CBLz2i8T0
 tmTklfvJ35EBqJq3mqLZZPpwuwqsmuVc+rN5IOG6xOmIeMyFIuo2s8v
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: MQ5wYFAl0656yExv4DfIVk57k6V9lI8G
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA5NCBTYWx0ZWRfX1LaMHTJgpMzo
 ylEmVSHR9Ed2NI4LkRN6mfZsZOBr9RhgUwUfluBfCpo7YR3EyvDeHo3iVWTWnQZQ33ZKpqs6XJn
 BuZex86KNSi3LO7uXqItaTnj0Zc6+90=
X-Authority-Analysis: v=2.4 cv=WNdPmHsR c=1 sm=1 tr=0 ts=6a311604 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=xAI3I7ZSbV2oIbCD5NEA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA5NCBTYWx0ZWRfX5XL+AqOY1m8E
 +r4+omwMvDGAIFUe5voQ0zAZwzVDxV+Tb/8U/9y6aWbE1CCf3Rfq+zN7Q7GKmajX7U2kFrUsvcG
 kFjYWBK8/+m+1ay0kOKzDDMQH1YckhGLoybthaxdpMjCyTprwv0CPJeBUH3Jimp+ugLkvwc9k+K
 SfxetWul9HtXFnzjFh2alAh6umYAO03AEsXZH0/L+EVcvrAKd5Mj0tc93tKBesHOCKFANJHXnCi
 TqGNvLS0gjbuR8YboGtiRYyo2O2MvjQ1Cpb5wEE2WDUUtVvZL+FuVuMB2oqJNLUovFDfENt85GR
 w2JfCVaDOB4/wsJIVPGLpl7Pt9Bi2COg9/SktOIIu1kz4mk5JvdKaIqHWY2OFw2knahpnpD5wkf
 1AuH75VNoRPkcazOmdnCy0cXM/Nr2t34DxrE9rUzOhQuUHYVUzBG2sUauGb6ZY6Y3O36eQDEJlB
 zNrXzan6uK+8UWhj8LQ==
X-Proofpoint-ORIG-GUID: MQ5wYFAl0656yExv4DfIVk57k6V9lI8G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160094
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

In snagboot mode, U-Boot is loaded directly by XBL without PSCI
firmware support. The functions show_psci_version() and
qcom_psci_fixup() call arm_smccc_smc() which is unavailable when
CONFIG_ARM_SMCCC is disabled, causing build failures.

Hence, added CONFIG_ARM_SMCCC guards to both functions.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Added CONFIG_ARM_SMCCC guards

Changes in v2:
- Newly introduced in v2
---
 arch/arm/mach-snapdragon/board.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 829a0109ac7..0066951a6a2 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -162,6 +162,9 @@ static void show_psci_version(void)
 {
 	struct arm_smccc_res res;
 
+	if (!IS_ENABLED(CONFIG_ARM_SMCCC))
+		return;
+
 	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
 
 	/* Some older SoCs like MSM8916 don't always support PSCI */
@@ -185,6 +188,9 @@ static void qcom_psci_fixup(void *fdt)
 	int offset, ret;
 	struct arm_smccc_res res;
 
+	if (!IS_ENABLED(CONFIG_ARM_SMCCC))
+		return;
+
 	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
 
 	if ((int)res.a0 != PSCI_RET_NOT_SUPPORTED)

-- 
2.34.1

