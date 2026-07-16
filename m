Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1BEC44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 06:29:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9272584D2F;
	Thu, 16 Jul 2026 08:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WdQCByHc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XkQLpp1w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAC3F84D76; Thu, 16 Jul 2026 08:29:42 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C8DF84ACE
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 08:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=badhrinath.s@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G3wQVg1689599
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=b0TpRQol1LU
 lLB3rnDFo39dBPctdLG+uihBtenXYiYE=; b=WdQCByHcc3YMU9O/lHIlhUOz1W7
 9kTCpcCvB6cda/1UEYsNwZmri6ALiaIO67darZu4w588xityfBOfriiKpVAa+QT9
 xQCjuWMSMu7++Ndb9fVfCaJQ0/x1c3Fan3yzjb4SVhOwNexxsjE6CWEKtzLZDbet
 ZcOCJ/rVvyagZaFTS2LnjSjH5jO18AyEaPb3ow+/xmv6wPW502tkQU2+Dsx08xuz
 FtH8pdeh5DGtwPAY9IOVrWg8utRHw4pe9C7nWSS8JmVheYckL7o0D7ZEOWGmBrIy
 bCOEae6s8Ru4VvgKWUGg11doTjFnQpnpZPmJ2ino4betvQ51oMfptugMfzw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe7nmmbxg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:29:37 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dbf293831so6628556a91.3
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 23:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784183377; x=1784788177; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=b0TpRQol1LUlLB3rnDFo39dBPctdLG+uihBtenXYiYE=;
 b=XkQLpp1w3tZYCtw7E3XWolq0JvEcdAAmPNzrZnkgO+XaaUwqf2+xLKWZzunv87fyDX
 zEuYK9Ub5HNfFMk39lc21whldDnBdYpj05Q3GCqM1JI5eQm1v4QgUWjEfOYXEfAQDPKu
 QM661iSy+l5yn1WqPd66kKy5gjbBzZJ8nG64QmO/UMawn4ZAX6kxlvd983gywFCdCQIf
 JIAGLAzmxIKb9g+2f/qFCyJ8VZt9lTFAU2qjhNDLbAdAgOCMrTNcPCMeajAqdhp/oACd
 /sOwu+hHtqdRMSFvhL9SkOmPEwdVOZ3KH6FrF1fXgyivhZk2+BWJkwb6LCjV4JhOAr0B
 Btng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784183377; x=1784788177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=b0TpRQol1LUlLB3rnDFo39dBPctdLG+uihBtenXYiYE=;
 b=LL84F/m4wA8c8BGR58RoKJRXi/k+Q++4852dG/BlMUnOnPn5Eys/gdOw8Q8PCPAL2L
 8hWHtOzmVx3/6zUW5ngX1okzLS4sUgRitfz5rNLzMSGccPjfqjedv/kxE1lKhpWmVtfa
 H81OtdExk0vSMDEcwv1o4u3Phr+zGneb9pkGuCXh0EKGOYpOhncRQ+8vIJQ6Rz+u+4F3
 W3SRpj/qepaUhW9H9ReoPcqd2BuHCxZFoXf6Jqi7vU2eT61FUcIthk1WxIW5p4HN3ZeB
 6Yf1lE2zDzQjyR7zLEdNzAjF19a24N79xkoo9NgEuRR0NFkuxRX7vr/8zMIyblxdX03I
 gCcg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpB4V+2c5K/u895GKkdhvkssM/Ace3JVn5iRv3+7r29s6PYHfLIYKB/iBu4zWsVKQF2psJa1u8=@lists.denx.de
X-Gm-Message-State: AOJu0YyKtbjrbSS1Fhjdp+sVVOGcbGEU/K8ODInKfPHMJAbRe24Xa8bs
 BTga6M216PTonUp7P/MHksA+0NzqHWXE0Zapsz5QMNzU4/IQxmzObgnwAFHiRg9R6BWj6rmcFYt
 bQsBYsEwluzzbDecrkyBi+N73n2vMuBoXhedxYQ0nwWCIZcsPvsl1cPU3
X-Gm-Gg: AfdE7clfb3hPrwPaG9KzpPFE5L36mcM+Yukd7ICy3JKnn6W4svw+NyvkDYbPjlf/2XI
 eAfta6VJTMaN0JljEsI9uO5RV1jTyn62+jW0k00d9oJQ7Vzs8rOgfZOlbPnFTxRJTr/ARbo0rUh
 TJvHTJ3rJpzeEIGbFRcyzKhXucd4nvX5Y32XnL0H+DoeeSR+JcaFVv4KsyiPUeLfgusu2T9iib3
 02UajMSBeFi/CmYWt1m0P2XtywRewfrR/st3RIziZHteDDj4nQApTnSyGqZ2gC9JvHwD24i5Y4H
 fjzc/KoZ9GvwqTpYqoLQiNLxzNYOeU3B42y+Av20dm8xCGCMRY3N6eYmbMXgSiITfJvYt4BAWSA
 fd10S/VGrpWEvU6nIRjmnFtRwtKTy5Ij7hMEZSki+OsxsNwAwdHMXYAK3tD4n+Nb7cC0p9HhatX
 JYokGmvtK8W4Xpp2s=
X-Received: by 2002:a17:90a:c883:b0:38e:101f:c867 with SMTP id
 98e67ed59e1d1-38e101fc92fmr10452650a91.18.1784183376706; 
 Wed, 15 Jul 2026 23:29:36 -0700 (PDT)
X-Received: by 2002:a17:90a:c883:b0:38e:101f:c867 with SMTP id
 98e67ed59e1d1-38e101fc92fmr10452624a91.18.1784183376258; 
 Wed, 15 Jul 2026 23:29:36 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6c08eesm9895966eec.21.2026.07.15.23.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 23:29:35 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
X-Google-Original-From: Badhrinath S <badhrina@qti.qualcomm.com>
To: trini@konsulko.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, badhrinath.s@oss.qualcomm.com,
 michal.simek@amd.com, luca.weiss@fairphone.com, adrian@mainlining.org,
 danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com,
 david.wronek@mainlining.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 3/4] arm: dts: ipq9650: Add override dtsi
Date: Thu, 16 Jul 2026 11:53:17 +0530
Message-Id: <20260716062318.4121929-4-badhrina@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716062318.4121929-1-badhrina@qti.qualcomm.com>
References: <20260716062318.4121929-1-badhrina@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA2NSBTYWx0ZWRfX5wTgAqNGWpUc
 vsf83LG+Az1RQ+IOUwsmlntEjJsBWZ1DRu1GbTwDP1YPvLOpDvUft5J7Qms7lahLF65vAStZDek
 BJqFSsx9u9M6sw1Wmsk1VCAQ21HAK8M=
X-Authority-Analysis: v=2.4 cv=cuGrVV4i c=1 sm=1 tr=0 ts=6a587a51 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=kOoMYcB8HEV07GVGuZsA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: jCzzUuOdjII-BOv969UtRcoS23L2j8S9
X-Proofpoint-GUID: jCzzUuOdjII-BOv969UtRcoS23L2j8S9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA2NSBTYWx0ZWRfX2hhV2l9Cpi+n
 0n9jjnLucTAwzznT9z8agNY2kEpyk7vESiuZxLkLfdiMGQCgZHEAazFbwuLwZUD7+W+DtxRUGUY
 gOskDyZCCMsmhKtx7cFdy88VQmAG3q4d9hMGsH4mFegEVmbFkl91FDzL8THWBYc0+8cDHBRHkas
 SAi4PlxUdat+05tvqqNnnEiq2hWj4T8SaomXgB0heQ6Bv8jLbg2V+FLWQUiT4vM8U7tKw+PJ3ns
 CG79XRZGyQdxGLkino60naKTN8ez8C1iou8kaOUb7tDFqjBfTX1Pg3pohmec7MmbREVYcPsSFQ4
 OfdXFY1qe+m2Ew27vPJnZsgD0EBzNBtG3qTJ58TELasW7BUq1UX8tgrcVz8IvfxpRKQC3g7EttO
 WQWL+1Kk8Km6uCbBx7f5OXpp+0NWX2ax8ciXJKJaP0AiMlmLb6f/7Sw8h/fhG3KdbJ9HV+vw7+S
 +ZDGh/QAKZNgQFaxjjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160065
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

From: Badhrinath S <badhrinath.s@oss.qualcomm.com>

Add U-Boot specific device tree overrides for IPQ9650 RDP488 board.
This includes memory configuration and SDHCI reset configuration.

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi

diff --git a/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi b/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
new file mode 100644
index 000000000000..dd03de98b921
--- /dev/null
+++ b/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * IPQ9650 RDP488 board device tree source
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/ {
+	/* Will be removed when SMEM parsing is updated */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x20000000>;
+	};
+
+};
-- 
2.34.1

