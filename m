Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D219CCD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 09:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2B0484869;
	Tue, 16 Jun 2026 11:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TKakZEXl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R4selpDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 088F484884; Tue, 16 Jun 2026 11:23:14 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8F5A84869
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 11:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G64KwP2289495
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 09:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lHH2ZqGu7h2F8N5OitDM50OZRxDTUJog3O8hcp6qnkg=; b=TKakZEXl0mpu1UBw
 +29cx041h2l82uXv4ZxJCgQkKxI9YmFppN6dTP8BkN2W7pcv9x5Q21r4mwWCVIID
 8QYfmXZhLaGUqolz31vl+WKd7Y7x6+3OD6VNLDoRlEftSa21ylK7SAmrnQrSM9Kj
 lf/HUBA4Yd2QFkFkmFSVS67VqUMcEclG4TMuwpTLY+9uG1RAuP0UqPyCZi43mmUr
 vhJsT0ojIDBY94rd5cYO+U7ZoZXft5ouaw6omFyknR+l1UJwQR5A1sDrZ61eJUE1
 Ajyq1W24tOmCb5ro9Bwx1/9qnVRwK74n/o0AiF70R74SmrRmtkc36gynu/p4tjK2
 6fWjJA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etx8k9jam-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 09:23:09 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36bc54005a7so5430445a91.0
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 02:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781601789; x=1782206589; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lHH2ZqGu7h2F8N5OitDM50OZRxDTUJog3O8hcp6qnkg=;
 b=R4selpDJZwpeDErBx18C8MgfELwpyHng4vkfeXhOr2AVEeDppDpez3k12Xz8a6vkin
 GLePLYRZGuVk9J/EPun5hTU8nyqoT66NYe+tXf+6p/Xj0FW4A1MFWjdqQKAGMNi2s+6W
 F8LWgu5EZsTkwRi1OTXKcJ/3+IhPjVklVN2S962yjpzAzlTXoLIUzfAt7TDtbeOLJNBQ
 JrljoFKPMCImeBJnd2n1pzmIcL7gRr/OdGezaW6jJHgk4TY911hjDxx+UpO6L6lkV8yT
 WXm3oXoaUyu9U2eAfQzaa6ydTarnUgkwn+8ehNnao+L3aHCWSoqLvBkP1DC9CAO1BrQB
 PFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781601789; x=1782206589;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lHH2ZqGu7h2F8N5OitDM50OZRxDTUJog3O8hcp6qnkg=;
 b=FLeB3EOi/UiS4NmP5LeDhN4I+nUMayqwyJ3gfdiPUtGzxYhS3RCMN+Q9hrw0gx8v8R
 VMV31cA6XO2bwKpCtLad4hEOloR98KEfwQ1v+m7Fe3vh7Nd3IB/6zcm/DdWxoHaJz+YS
 XAlO1U1CQUpoikJINmVMwmByRVuzB9h9Zjb++XhXwwjCDEdyLjj3DXYTVxXyr/d0P3jy
 It20gK9myyu/cYg+NCeatuvPfS3n95y4wxYFpBJNvTEA8ReQ20TMNxVrr3g3s6SYT6cS
 X810Dx6OBSpFgN1uDarVrfvnUVp+/a/8I49mNP+nVGUriDT0HYOu6dqCs0TaB+my1+zf
 TQqA==
X-Gm-Message-State: AOJu0Yy/+EfG/usyFkewcsvIU0LERTlQrItfihZgujI+UY48Plcg4bVW
 z3g81281iYMXXKms2HdzTkesNNZElIwZ8Wfmq2pb/kVwDlkFpXB0uRnl/9QsCz2b3s4v14Ue2Gn
 lmXzqJIO9882H0uBPnlcG9ioQbjec0CQ2vjimYZf21LMa+brJDeIsrb7F
X-Gm-Gg: Acq92OE0uqOi2ycqw8VBZCMse0PO3wGWlzJejMcbr40uqR9En+z2jiiwN9VGv3Qog/B
 2FSAh1LKxaSyT2J0DvHapEwQJ7zYV1w9tJ1NbiBowwouOjpjl+4JmgjyyLYvLQp4dztXHGpz86S
 POJshe+xVCBJVQm5FKTt9EzapmQ9iPlGJOZgxSQwAkwo5vnICAmnKez3gb0snHO77ySmh0v/UJT
 S5s824fqlGQ9Dr2SpzoGsPlGyIsuhUs1zWcaLEKsPBPmLGfc9jJ3gz2IKfqb3VJgGVrB+LUv7Cl
 v3KOwzms/w7MR+0jSAFclx4frFE3Ezy8iRTZZoH3XpsqDYa59SC4SBIbNJECHTTNrP+t2slmSR0
 GDFQTgTFT2wj8BMb73J6FgM6EWtCmuUqBQ/XzehhcyrSKysqzk7owiwh09m+QsLNshmyocroSei
 kdTVYb19yd8xkrVZHGkxflcW0wF1abojaLfnZIZhbQX5OGDAQ6sA==
X-Received: by 2002:a17:90b:4f8a:b0:36a:a16b:5f6d with SMTP id
 98e67ed59e1d1-37c2bc8707cmr15614680a91.7.1781601789258; 
 Tue, 16 Jun 2026 02:23:09 -0700 (PDT)
X-Received: by 2002:a17:90b:4f8a:b0:36a:a16b:5f6d with SMTP id
 98e67ed59e1d1-37c2bc8707cmr15614637a91.7.1781601788829; 
 Tue, 16 Jun 2026 02:23:08 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c522136cesm2360005a91.14.2026.06.16.02.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 02:23:08 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 14:52:51 +0530
Subject: [PATCH v3 1/6] arm: snapdragon: Make SYSRESET_PSCI optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-sngboot-v3-1-6fb0dee8125c@oss.qualcomm.com>
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781601774; l=1043;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=DvWkuAXoQTdnwdArkECGaOdjn3H3F6tCIhFY7We8kuM=;
 b=31mN/OowzYnsG1sJLkWaC/2lwwi8GN2xxtyWAKw2ilpk9NnXPUvp454Q4gVsV7NnOY7Fb1HiG
 zKKqFBcffcIDo9r8/DYOwD3/JXj+8j36GxqRGmpapHVhfuFjlm8f4YM
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA5NCBTYWx0ZWRfX69QPMjb88TBL
 gnW+15Igm/UR/UMrp8IPI9ZjHciiQ1c2tFuM8am/eHdF3CPwOIY6wcE3lSQuxZjXBqGe1BOSIE/
 /Eb+lVSuhbzI+r1N+ZzHDFCwAvv1OvTWL0le7B8xpJekrWarzvXc/MbNUo8obPb8p2ptICFVl/W
 lShXH0W663plQoqMvd/dYJneSEtm1aray1qStB/pWmajrvm/8kjqtsmb6G1+jf6ZkwikXdU439c
 Mh7fEK8Lum9BS1sO33ABGyx/3yo1ENfxiTDKLFJebYNG4JQao5IX2IV5dzseZ1KbuMN1E+JDhuo
 +C3UEfQEDBPKj0lKb6N6W4O0CPUsw/f5D956A9VOW+m/MQrlphVp84jfjf10/RYBN4ZrC/Tngxf
 68bTnZlfGmazzXrITsQQuldywbtjRQo0YoOeTmsEhNsIgWLqEuvYtLGH9LLjJiJKwy+UIsosH/6
 YcUdwwjnjSWYy1tZdWw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA5NCBTYWx0ZWRfX8BTYdnJ0iDdF
 GZ0+OkX1mfKl7GjG1iP9nqj1RLZx8XDC6qNciJBaoGkJ3J1e2jibhZHAFWPmcyLf+k2pABIxWDL
 Me0cuVH0kAB99HDoKujJWPIT5tAr2i4=
X-Proofpoint-ORIG-GUID: b17x4eMT-cYQQH6PuwRZRgAt6f2lYlPJ
X-Authority-Analysis: v=2.4 cv=dZawG3Xe c=1 sm=1 tr=0 ts=6a3115fd cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=JsP0DBLrHHApdgxb0GAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: b17x4eMT-cYQQH6PuwRZRgAt6f2lYlPJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0
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

In snagboot mode, U-Boot is loaded directly by XBL without a prior
bootloader to initialize PSCI firmware. Forcing SYSRESET_PSCI via
'select' causes failures in this scenario. Change to 'imply' to
allow it to be disabled when PSCI is unavailable.

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- No changes

Changes in v2:
- Newly introduced in v2
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 514bf2000b4..a6d36f39069 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1150,7 +1150,7 @@ config ARCH_SNAPDRAGON
 	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select SYSRESET
-	select SYSRESET_PSCI
+	imply SYSRESET_PSCI
 	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
 	select MMU_PGPROT
 	imply OF_UPSTREAM

-- 
2.34.1

