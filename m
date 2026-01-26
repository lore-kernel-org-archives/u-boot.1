Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2550D13C3E
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 16:00:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 164AE83EBA;
	Mon, 26 Jan 2026 17:00:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KyYBCOD4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dpuSCWWg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F08483EC6; Mon, 26 Jan 2026 17:00:00 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA5F783EBA
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 16:59:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60Q8OoOF493215
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 15:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=o8GXHwFRa7V
 LkiYalNfJS29NQRip8IsX1b1o1if7k7k=; b=KyYBCOD4E/qrbvM70stSRarLlWW
 r/dPJ8bVeUH/FQaX2CI8Z8aCU0Z2Iwhlb9Od0UHLXKQ7psh9bzrYj+loI831X1zC
 7V6QA0v/HdQziqnFb1rkptnShpIrsQZbPzLQnJ/gMxZfDTYWxN5yC2aEG8JKXPyE
 /XrqlAlLdrosXvjZlJKAqqdj2BofcBxV0f6rao7QwoysCtZq/YkQCGv4XUteE5mY
 uBodMAj2vB51zQIWsg7GAEwR9NQ0ri088MHQEOwkhpXl24HqZpSxHciciPcd8TJM
 Xoxgx7NrQNCUCgOU/4dkk0G3qeb7EoEVFlqZl/jY+Xm582e+5z7tNoO+M8Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvq6uw168-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 15:59:55 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2a7701b6328so9337835ad.2
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 07:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769443195; x=1770047995; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o8GXHwFRa7VLkiYalNfJS29NQRip8IsX1b1o1if7k7k=;
 b=dpuSCWWgNTQP19vkl8kXlKCLn9mi/VCG7jPfbOQowXi/xhg5kG+ccqVk+5J3Ndslie
 kAMkdExjy+chuWq61dDlTjAKojzr9qAIYcbHK8sqdFpRHXtI00kJS1O2HOdNiPnRELJf
 qNaCn8LPfwKBRYxQ1vW/ogL8PiCFTw47cHZNAWGhV522UVRF5NWB7bm1d2lEMgR66+07
 OHKkbkKcoJZ4l4a0BdUox2y+bAWnXOYna4TAbP/z+rlhairWYikeha5KwIai61efGZB0
 dminNgCYWj47tuMw5TVGuhLXrGV8MXOOURURk14XjNSl43gvEnucWGbm1OIYQYqPM7bV
 yE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769443195; x=1770047995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=o8GXHwFRa7VLkiYalNfJS29NQRip8IsX1b1o1if7k7k=;
 b=S6F4EuJkh04eGFv34X8hMO/hgiFLwPE4R4Bx3bQTEmEEm7ysIVDDZscxUJRS+pXhcZ
 jit7eo2gxm8QfhV/vBkqjfX7ohASK/cEzcjeOVV3z5ofd2dx2R3wDI7ayidkKSraNOrz
 ++X9Lc4wcEfx/X75uUOymWbGaOXNL9Ei2+md7mQ/zzjJH4Kw99Ns+TA9Ssxp+h5eHeCN
 Q3kLr27Y8b008GbxotrY9jboCzIQxDLHwwiK4JNJ9cvg6pzaChl7ZCdIL6W1RDJ6viSW
 122kITWOqA6d8IHSqnY+I95e1zzAjHlb8R4EQs+dk44CmTopE49WmqkuC3z5BgSgepUl
 83Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgqvHWPyEXPUbiolMoVC+cJhtOoZIYlZreogfw+W7zmRtnKrh7Rja0Kd91oY+FcE9y2aMs1Is=@lists.denx.de
X-Gm-Message-State: AOJu0Yzha9xUeQCp2D6o3WYEPS3Lh6lvmztSfJG1ej8zGeESbRDakzfY
 g0rRuospe1ZOZLx1Y7ZvHYowBOQNje6SKRfmbbtZdO9nlk/RtkHws9RcD3L1N9m2c5D8/+UnRcz
 Cto7UzD4hOpnD6+r/+XDLeeJYLMfTJmFgQ+rfbZT+itfRU7z/x2ye8/MZ
X-Gm-Gg: AZuq6aI72zGm+75CEf/4f41jWjF5Qa++Ct9/boWiRfBzwUOvUWo2oae2Ub9z1ZzZ1Kr
 Q9Jucobkofi+zR0j7Ohe9/oSLeJ+GN4t5c//UDHSkqGebzrPLsD8eilLnGR6WTTg16ePMvlTafW
 U+hTDWIbwQvN1cHaVoupAxsFLeuxdQ+Vi49IxAOPib8nvaN0qJUrJIZy1e/9g7iWec79Vs2iA2d
 MhdQGjNIhzjyQlutg+AbRWnC3LWCkZOj6PJtiLVgYIxcP2s0m32f6oj4CsfuRJwifq69aLu557H
 wgMNG4lqUKWlcEKUKPiHV2RlW9cJ5HNM7szlYgak55Yhr+eTips+ZMx1RHRkEb09SSPtmP7wA8X
 v5otU5vBvfqmY9nd8fz/KjvaMSkm5jHiCNCnDBs3EzA3XoKaPXijRo8ja1G0ui9TmkIYQd7W6a8
 QDm2+PIItaauSoajpSemdfpycWRGldtQ/VfCsNAA==
X-Received: by 2002:a17:902:dac7:b0:2a0:d692:5681 with SMTP id
 d9443c01a7336-2a84523f973mr47481655ad.24.1769443195012; 
 Mon, 26 Jan 2026 07:59:55 -0800 (PST)
X-Received: by 2002:a17:902:dac7:b0:2a0:d692:5681 with SMTP id
 d9443c01a7336-2a84523f973mr47481185ad.24.1769443194412; 
 Mon, 26 Jan 2026 07:59:54 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802fd929asm93245505ad.90.2026.01.26.07.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 07:59:54 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, aswin.murugan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, rui.silva@linaro.org,
 david.wronek@mainlining.org, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, jorge.ramirez@oss.qualcomm.com,
 stephan.gerhold@linaro.org, quic_varada@quicinc.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 2/3] arm: snapdragon: Remove QCS615 MMC node disable fixup
Date: Mon, 26 Jan 2026 21:29:37 +0530
Message-Id: <20260126155938.2717540-3-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126155938.2717540-1-balaji.selvanathan@oss.qualcomm.com>
References: <20260126155938.2717540-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDEzNiBTYWx0ZWRfXzkzrf9fYReuT
 1r8yUU2KeJ94gcFJUxHkfnrk7BWZRt5c1bGyMLzI2BQr4o06BcQ8ar5+UY0dAexu7louLY00its
 3IzKR872+ebae6v9hbcLmzB5Akffn24rURzmP5S4xfTxEWNREnm36XElFbz3fgGZEQEOX1d4U+x
 cqRKgXaPdLpxbwGuog1SMLHhZ0fax9Nc4JwTJ97VJaKQbbowJsxvn/xD8mRUuRxDsRG6lE1pfKp
 NkNQKhatQNLrYQ7FMFNQ14haklW+vAHzaVQm7AzOivSAIGRndwn6qssiQZ+QAIQP6UK0S60elus
 cqA7uOXr+/PeoojgcpeMe6msD/9MhMHPK53d9VvdFH3/fxYNJNFM3cuY5lBJ+5Y1p4bhUMrUe/l
 1abJd90qP0XmJsqNU/9il+El+KHKnReIXNjrCnLSoWczogyoWiMmXNA/tYoegYvEHSqjjlxfS76
 DCGqbbrh7ODd1+0mfUg==
X-Authority-Analysis: v=2.4 cv=UqRu9uwB c=1 sm=1 tr=0 ts=69778f7b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hNQD_T0YDfm1z0AP-4cA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: -u7k_kezBUqUW8mgpH27ri91esbhiXaN
X-Proofpoint-GUID: -u7k_kezBUqUW8mgpH27ri91esbhiXaN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_03,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601260136
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

Remove the QCS615-specific device tree fixup that was disabling the
MMC node at /soc@0/mmc@7c4000. This fixup is no longer needed as the
MMC/SDCC functionality should now be properly supported through the
clock infrastructure and device tree configuration.

This patch is based on the changes in the upstream submission:
https://lore.kernel.org/u-boot/20260113115404.1448759-4-aswin.murugan@oss.qualcomm.com/

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/of_fixup.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index 9b6e1847489..216cc816d95 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -194,20 +194,6 @@ EVENT_SPY_FULL(EVT_OF_LIVE_BUILT, qcom_of_fixup_nodes);
 static void soc_specific_fixups(struct fdt_header *fdt)
 {
 	int ret;
-
-	/* QCS615-specific fixup: Disable MMC node */
-	if (fdt_node_check_compatible(fdt, 0, "qcom,qcs615") == 0) {
-		int path_offset;
-		char prop_val[] = "disabled";
-
-		path_offset = fdt_path_offset(fdt, "/soc@0/mmc@7c4000");
-		if (path_offset >= 0) {
-			ret = fixup_dt_node(fdt, path_offset, "status",
-					    (void *)prop_val, SET_PROP_STRING);
-			if (ret)
-				log_err("Failed to disable MMC node for QCS615: %d\n", ret);
-		}
-	}
 }
 
 int ft_board_setup(void __maybe_unused *blob, struct bd_info __maybe_unused *bd)
-- 
2.34.1

