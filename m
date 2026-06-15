Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0B5CD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 08:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E407848D7;
	Mon, 15 Jun 2026 10:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mq7WGN76";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G1dfhVzi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D732848D7; Mon, 15 Jun 2026 10:49:07 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91C5284895
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 10:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6L3JM3888570
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 08:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7gYCqS1A7VlMK5knjVGwJr7RGWFJsr8SDfv7nmWlhgo=; b=Mq7WGN76cYjVUuDD
 eU1LKHAFBJaVv0+zSZiVXIW+aeHsxg1SCgpGRLsEs0fAI5JbRbfKszlIYqOji8N8
 JxwcaoEQdKHLEq6c2lO558uHBDHrLGncYtTRVRwPIBC/aGfV8KF8M9W5Hm/XmtX6
 vD4sIuqm0+e92rG74pAFylEao2JHzk2i16JYChg2pL2z4SWK2r7sK4NKXkGA5wAJ
 XHbltQTPtEFGdPopR869E9j+a4KPsgLudSsWzZeVhe8JzUd9CtmxI2guZhIxliqr
 tr+LfGnEKtP/6QdbHCMvKZICeGkkUjxzPj77pC7+YH381I60PHG/chkoYtUpcC5B
 E0UzAg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery8wxgtt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 08:49:02 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c85a366b61fso1810536a12.3
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 01:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781513342; x=1782118142; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7gYCqS1A7VlMK5knjVGwJr7RGWFJsr8SDfv7nmWlhgo=;
 b=G1dfhVzi081z71Kxu7okxPh8IOOhGSn6muG73GhtopgViekpRUgIOcoOrrIinC/v8T
 TDA0GKp8lLbgIkW/7yc23F3l/9rMPCV9qNfQi+RXwwDvTC6wM+QVhzSkHBggymgUXgf3
 tAB+Xemr7KERSfh+h8LotiatTk6nmuhbFHytUjUNCbJarM+k5t1+o9VGImhrWVRQEeoL
 XPw+0hkUQxJAGqWCsYxV6yJsJGXYwV8OsnqoRTwQIXbFEDIl9SHsqF2C1v2+Osy4oklB
 bFMG7WFW+Re7s8DiS5khgx9Dy4r/xi3QTlFMycn8mvtcSdNZZYOf7NyrUDAMPVgJu+SG
 vHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781513342; x=1782118142;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7gYCqS1A7VlMK5knjVGwJr7RGWFJsr8SDfv7nmWlhgo=;
 b=OuZYb4mW5NliH3aOBbtatvVNPPr+eMV3O5UB9QseFQq5Syf+veOkem51oF/AExHu5U
 W7v9ORAHKwoHxVhe+Nuwhqirof+9EEmjc1KXva+YuO5YHoSdJMiX6yD+GqrkHFTdXzYv
 A+cRW9SYSuulumzfUrNDQaRFO3gN7efP9PrDz8Jg2qOeiB0MFRHmCzyrwfaeo2mZ0ag7
 IH9iqz+CRAbENN9Bboax+Dv9jfWmgTDPQuIBIyn6PvwIhmc9eVXzgT+80i3dMGe9SQB9
 e4RTxNuIBnrLNu+nyGVtY27NAOd/nwpNQYQWWPtLg7FhAfOZMl7aE/9odOIBcJjt1PFr
 V/Dg==
X-Gm-Message-State: AOJu0YyaxnV7BJGmb+gmQVIMw1QrLno96z4KsA+XuQyzvBDbeXgz9ljb
 yfDsm6M8G/Ky2vYNw/lLId1uty0bklgNdGK8wGKgSqUqVRHm8yRc+WqPzxx3sX672wVgRJ6E+qF
 tutSoimDFjygqjYjVwAyRei4tR/S/pJC7Be7iwpFvLR0mQlglO9rHlHa8
X-Gm-Gg: Acq92OExDr7WldN+Pu6SkdyGV8VBMcDNZjhVJ9jYI5t5MGxhpWm7/vaClLGiNbenB8x
 IPkE0w4YKpLZ4mfPd7VH0Fg37IBr1o+FWuF06EfvC9bQc1EFCb4ecqDn46gbpdl+Y3/93fznTT4
 FJ52x+hbpFfW566olOgP5O1Z4tkXxqtkipzobBrTqc4a+YXny5+trQXfLkNHRnS5zljFlwMqN4P
 Obn2JsS4oroxTWFodG0uEEvAeap3nLA18g4WWPtTQYZbcLNiWQ88G0NVAkzr48POMCr8ReLWhHl
 gFV07LXKpcilpb2hv4nVrXRFQqwZZhSI4OMRG9pUPbDiba86Nnj71kCULYHWfrlU4uDZJ4pnvxp
 V1SYVaExxHkvVH/m8E3XUdV0eVAU4BbQzFb+n8VDp0HjsXw3GX0R4K42yGSIDM9ihTL9MA6qW9+
 xpaxiX5U+hswT5/bcPyIHs0n5uhHr/K6b0PhPgH7D4qhsVZUfdNQ==
X-Received: by 2002:a05:6a20:918b:b0:3b4:6a31:6d0f with SMTP id
 adf61e73a8af0-3b784026f98mr15470838637.41.1781513342025; 
 Mon, 15 Jun 2026 01:49:02 -0700 (PDT)
X-Received: by 2002:a05:6a20:918b:b0:3b4:6a31:6d0f with SMTP id
 adf61e73a8af0-3b784026f98mr15470812637.41.1781513341540; 
 Mon, 15 Jun 2026 01:49:01 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866325d1d3sm8014848a12.11.2026.06.15.01.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 01:49:01 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 14:18:52 +0530
Subject: [PATCH v2 1/2] arm: dts: lemans-evk: enable SPL support for UFS
 and dependencies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-spl_lemans-v2-1-d15746f4a64c@oss.qualcomm.com>
References: <20260615-spl_lemans-v2-0-d15746f4a64c@oss.qualcomm.com>
In-Reply-To: <20260615-spl_lemans-v2-0-d15746f4a64c@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781513334; l=1356;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=pOOf4FHhl24MK2IDMzqrNjHU/QNKR6timqIxTe90/g8=;
 b=VFINXQOf2RxdYNFr03DARS9pjdLBYLdWmATCteOA4+D2bHB+W4Aow0Kpg565wI2eOAWXAuQa2
 sUxuqdiqzt+AZnc2vQadJDmiEq/idM/N+9Jh3rLQ1Vq3L0ZAqovy8eV
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: QrOesXhxxgOcckyowwSj6pfzM79Zu2aX
X-Proofpoint-GUID: QrOesXhxxgOcckyowwSj6pfzM79Zu2aX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5MiBTYWx0ZWRfXxpou2lDdPJJr
 elxf9mBCb/N6EQBcMsI4R6AQwFIEDABFu//2ERUpJ5TcB9kBhuKe5Iy/u+bpe+4OPVtDUWmZZ7z
 YjkE4YcoSML4rBFmDMCtT5rDcWC3gD4=
X-Authority-Analysis: v=2.4 cv=IqAutr/g c=1 sm=1 tr=0 ts=6a2fbc7f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=nQCtNUuqFeM5Ofb-tqoA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5MiBTYWx0ZWRfX8/9BIrEBA4TQ
 jX9VwXMZuJXWojTiQhl5huxL543dgSxdzvEOBEB4U67+a86PrQ84QXl/txCBdobBt+cvIWbNeRx
 mytbXuImCJY4hXit7v6cBg1kod6F66iYxxUcy+Rj1O+mWsbo1TO5MUrbVyMcdtLI1P6MeRWXD3D
 F5tO6U5dBicQ2dt3CBe50EA3bfmP4Gv/jPeCmPuMgqiUsap/PS90zUJoUOCIvDlGNKo2kKke57W
 1ZOJPQb+OUjteemX7FgFQ08h9u3jlgE3EdXvPrxhhCue4pfl5O6W38gahgD5QGgwKzHv0Wm2IgI
 C4muzZtjlBka6tXEAxBEw8MCmmqYHO8miaCoLHdaqSKmeRTKMf8SQMwT5L7pTt+B9/VG0H0KSNH
 6rVcRYUK8uYLsNu5lMvqL0Zea9KxHKKfrFBQ42JZzamRWahYLaqM5591mtFiUX/xLdABKaOClKn
 GjrtcKiQOOW0Y3EiSdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150092
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

Add bootph-all properties to device tree nodes required for SPL
boot on Lemans EVK.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Rebase changes on top of already added arch/arm/dts/lemans-evk-u-boot.dtsi
---
 arch/arm/dts/lemans-evk-u-boot.dtsi | 42 +++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/dts/lemans-evk-u-boot.dtsi b/arch/arm/dts/lemans-evk-u-boot.dtsi
index cdd3d32f61a..586f96522fb 100644
--- a/arch/arm/dts/lemans-evk-u-boot.dtsi
+++ b/arch/arm/dts/lemans-evk-u-boot.dtsi
@@ -16,4 +16,46 @@
 		      <0x0 0xd0000000 0x0 0x01900000>,
 		      <0x0 0xd3500000 0x0 0x2cb00000>;
 	};
+
+	clocks {
+		/* Fixed clocks needed by GCC */
+		xo_board_clk {
+			bootph-all;
+		};
+
+		sleep_clk {
+			bootph-all;
+		};
+	};
+};
+
+&ufs_mem_hc {
+	bootph-all; /* Enable UFS for SPL */
+};
+
+&ufs_mem_phy {
+	bootph-all;
+};
+
+&gcc {
+	bootph-all; /* Enable GCC for SPL */
+};
+
+/* RPMH clock controller - required by GCC */
+&rpmhcc {
+	bootph-all;
+};
+
+/* Apps RSC - parent of rpmhcc and rpmhpd */
+&apps_rsc {
+	bootph-all;
+};
+
+/* UART10 - console serial port */
+&uart10 {
+	bootph-all;
+};
+
+&tlmm {
+	bootph-all;   /* Make TLMM GPIO controller available in SPL */
 };

-- 
2.34.1

