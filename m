Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD841CD6E4A
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 12:23:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7143484671;
	Fri, 29 May 2026 14:23:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QRDsR4KA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FSgzitA4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92358846A3; Fri, 29 May 2026 14:23:01 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 313C8844CF
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 14:22:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TAKvsY4193438
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 12:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=J7quj7/w35HlNqaJGyRwrY
 mTtrqiXQFymNKiQDGZ9VQ=; b=QRDsR4KAjvCd48p5X/gRjfAQKECweiNM/SLFv6
 UDEvjNbheThcqM1VPieJ1AMGyQ4fFhXOTWl/rcUnSOVLV+m0mlS3O7wcyN55YXM3
 GyxK7gW/R9JY5t3RaKqbORHbjAEBIJS44QHH/An/gClgMMr8Wjo39QGg1GBPVf1Y
 JXB1RwwtMEH61QkrnmCnNgtjhhggAV70oNrFWqDAeH1SD5YPzTJcvfHFJ410fqp+
 aJcN11E+7tPcMqF4x6mBB65XQTtOca/Y3XUsROZJTRJ/qWVPO/VqmBVAV4GQO45q
 r1JT59/B6hoEHi2Up2AV/xd2TMViSTceMFrwyBORccfmWzLw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef3te1v0y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 12:22:57 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c828acf7c1dso18620562a12.3
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 05:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780057376; x=1780662176; darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J7quj7/w35HlNqaJGyRwrYmTtrqiXQFymNKiQDGZ9VQ=;
 b=FSgzitA4OyCHPv7l4EytfBXc+M75CKPHwKbWExD5zwrvAsDN+E0p6EV3V4Y065SqzC
 SdbVqOQmIrfFl1iyFfdLQkpIJ+OaodDkCr/LE/GgYJL9JiVqPT0b1nZW8sBMmFACps6z
 5nKcXw9Eg7ZokHFkdW4uUyqO5YEE/gL0DRKOtKQisEjQHs0t/UD8C0C915HpOUDUc3e9
 +Odc0pJHH0DYVd+zLPxclM8SxOhFrRkaFEVvL3RE6JD+KEEcV0WoDFLK9GBhbVFm+vNN
 YmQA72r2N0SbfoJlKIBKIRsGQH0+kiz8UD1jUuenGSJq7pzQiHcGhvAJHrtlgos9F8Ab
 BzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780057376; x=1780662176;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7quj7/w35HlNqaJGyRwrYmTtrqiXQFymNKiQDGZ9VQ=;
 b=Cn0Lwv+j49Zrt73oiV44pH5BuHB6eL1QnXCVh43da/j3utDAMNeUEJelXmOHFLaBJo
 bcYlmLCmPipwBgIDhsXgmxqSk09eExrkTvLHz4Cl/8kXUbrcOqENT9JV/b6GmVT7Tsg+
 yJDBRFkdKmu63JrS1EVzIgnwwJ85h1ngUV1MRtcu6+MubEdfC5RxYmFZ2dUeCraI0XKM
 M4eS/NUidbFTOnRuGLidAP5GR6bMQDNzCVgARoCkuo8WFN1GrbtZirCeAEHT940Z4qZY
 IyT6zPwOlhlmsU0QZ8oCA3A+EDFDszG6eqaLe/z0XAfucPuMC2X9kaDI3z4XNYfGUpAC
 l3gg==
X-Gm-Message-State: AOJu0YxFbrnlbMlNacGopfs+p765yRaZhwlrb+rUIr/ZtYRXk1ogIths
 iG2jVcVREJuV6rVbSZt23fLyqI7fALbyqPHAEcXGp+8c9eYSnNH6P4O2r+aUYYikyagUeNT94//
 y6tSQqbzEKgE+vRUYjSo0pQ+zpOvqXKaBWUu0iPtTKWjdTpAtpzUlbIxeybD86FFW
X-Gm-Gg: Acq92OH8O+9o2V+nNC9O1KfvRV3mMnGuhGLlGJlfl0Dg+Fku5s5n4AlDk+XDZFqJ2lT
 IDJRtHvr4z329cppDl+xxzYx9roig3cg12z06yyO/zSax1CWQREvXmpDE+GXiUknQPauDOFUM9b
 q7VXmAkeFZGPwfFWjSbuEP/xm5v7USuIEv2Zs+bwEuzq8+4vr2L3Qk4seOcic0pJCfuRiuZVU2L
 awG0UFqoy0uHqgRRKC96aRYSPqTlrRt9iqTFkPOJqOwvNuL1jdc3vvTtztVKyXmNl/sp8QWHaHl
 EADK1ulNfgLmcHtEdYKbMMzLVofTItgbBa59ZbcUjb9+ieT0cyBiiTqWAaCC6avpKHvHzhiia4I
 nudo8dbNZzTNsTL/wRqUWFPiNjcJ8wIaGh86EyP9i4jVsYjaknNiGMEOV5GwEKZsHrh6xfU2MxP
 rU+YyX7ETQOsx7+kaOU27N3x2HIqzHNjLT8EVRAMjCyqTIU7mgKn7drT3eMhTY
X-Received: by 2002:a05:6a21:1f8c:b0:3b2:b1ed:d1df with SMTP id
 adf61e73a8af0-3b411de037emr3047466637.29.1780057376465; 
 Fri, 29 May 2026 05:22:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:1f8c:b0:3b2:b1ed:d1df with SMTP id
 adf61e73a8af0-3b411de037emr3047425637.29.1780057375950; 
 Fri, 29 May 2026 05:22:55 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85772993c9sm2042305a12.15.2026.05.29.05.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 05:22:55 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 29 May 2026 17:52:51 +0530
Subject: [PATCH] dwc3: Fix fastboot re-run failure with flat DTS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-usb-v1-1-be5bcb911f40@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABqFGWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyNL3dLiJF3jJLMkExNTU8vkZFMloMqCotS0zAqwKdGxtbUAyi0r2lU
 AAAA=
X-Change-ID: 20260529-usb-3b6b44559cc5
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780057372; l=1676;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=O/tqSsJaXFiTFEBZcPUWKrKQi2P9d5JCk4DBTh6lag8=;
 b=oR5+m+MetqK3ZxyZELk5tVRSL0TDJf+sFZmluHFUw7ccEie+6rRZg4P4SUzff+t5JCncjnI8E
 iMxLQTW+tORDMnYCcFrpgZF/087Aj21nwbK3ClKCqMBA08QjPxIbns0
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: DhRLMX8CnshWSyoVgJh3o2P6G4VXOoJw
X-Proofpoint-GUID: DhRLMX8CnshWSyoVgJh3o2P6G4VXOoJw
X-Authority-Analysis: v=2.4 cv=daSwG3Xe c=1 sm=1 tr=0 ts=6a198521 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=BDfHEazKS8CqUbUxIdIA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEyMyBTYWx0ZWRfX69ijwViwmuvN
 BwFtcQN+cLsy0BS8/nNV4cE+cvx4udb/2LfTcolNtPDlo6L0gp9V+IKpDgCcPWLM3UViAtVjaLU
 x3zliVsr7dBBIX6T7UERS3k8QJfQ4XjqMi3Gib2oV2pt32yNJaN5kjIojtgZshVgdwFrn4HRUU8
 UEsGWZYG//E/BF2t/hCIl1qV2hexAwo6LC0Mr9K9GmpghHWkqaJUflVK2YvzRr9pL2Z/IuRItmD
 mkoY/byxwBgB5VCNGu0AAdBQVnSt1+oxOTrCVKkkqobpgcs8iKhQaVpZ3YIdcvaapXkHYrGXc14
 DhHuaCSpO32gRaXuCJmv+NLdCfpYST19rRDfdLfbSeP89fIOCBSO6PZS8Mpc8Jb+ekZXuoYrm2M
 qsx7ybyK3EQzsg6rrZqmQEdVZT3xIVpxs6b74D9cJvCT6ykweSQ8DOCpsXbEbNtJFo5En7xORPd
 X60udLfksZjpupYdHMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290123
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

Problem: The first "run fastboot" works and enumerates on the host.
Subsequent runs fail, with no USB enumeration observed.

With flat DTS configurations, the peripheral device inherits
power-domains from its parent (glue) node, as both reference the
same DT node. During teardown after "fastboot continue",
device_remove() of peripheral device invokes dev_power_domain_off(),
which powers off the shared USB GDSC.

As a result, the next "run fastboot" fails because the power
domain is left in an uninitialized state.

Add DM_FLAG_LEAVE_PD_ON to dwc3_generic_peripheral to prevent
power domain shutdown during peripheral removal.

This aligns with hierarchical DTS behavior, where the peripheral
child does not own power-domains. Power management remains with
the glue device, which persists across probe/remove cycles,
allowing repeated fastboot runs to succeed.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/usb/dwc3/dwc3-generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 22b9ef0b24e..788fe6fc819 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -220,6 +220,7 @@ U_BOOT_DRIVER(dwc3_generic_peripheral) = {
 	.remove = dwc3_generic_peripheral_remove,
 	.priv_auto	= sizeof(struct dwc3_generic_priv),
 	.plat_auto	= sizeof(struct dwc3_generic_plat),
+	.flags  = DM_FLAG_LEAVE_PD_ON,
 };
 #endif
 

---
base-commit: 987907ae4bcc5d6055bdf7d318a3edf53e14d5fa
change-id: 20260529-usb-3b6b44559cc5

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

