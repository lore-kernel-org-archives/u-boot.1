Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF13F8808E
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 07:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A28184228;
	Thu, 16 Apr 2026 09:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="phr4iM2p";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DnCKnU0s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6907284228; Thu, 16 Apr 2026 09:04:14 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 418CC841C2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 09:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G0ck4N2834976
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=B/v/hNhQCWL
 Sq3FLyP0iXETXUuLD7ymt0h9A6xZYv5M=; b=phr4iM2phdIBQwlGP6KGfH4a9qq
 KWo0xCF8rd8PG2RrXvASL9YROQyypmculizMdwVQGqMTtGF7sF7ve3WK3E4DSsGD
 jd+BEFwaZwiNtQMEmj5tdfTP4r/z5d+0rfDHpCvvq61ZHQ1DbT+MyvX7NdkwIKZ3
 vSeI1WnVJHG9wKALVLTmKIBbqO/EpgtMZjy/qhzxpZUmMVLEH1E9HyZFq0kTk91g
 9EanRH1vlc0jtt96qkW/x/F1/6gPgKk4YRJawfxvPguY8PjbmtwooqDs3td0De0V
 w3BFAddK9Q7utKiyIdNlaLydfMovJ4W2MlmAVTcqBrYekXtaAIxxDCtG93w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djcsvjq53-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:04:10 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b2497cc190so2403995ad.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 00:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776323050; x=1776927850; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/v/hNhQCWLSq3FLyP0iXETXUuLD7ymt0h9A6xZYv5M=;
 b=DnCKnU0spNSsVXYSbC+IX/dcdXN3owTWN7qdSc0rhFF1RBsIYVvjwzPgxrmON2fA8d
 Lby06DZ+J6YEMOlT/uKiF0pYn7lbhbFPAwoj9AnN/9uBqEiCwq7/kwxnX44Puqk/arp7
 SipNeOPM3Ouhup4Vte8BTMtSziIimJYdrTSKhPxO8cx1F+ViVDsaU7ekApcXA0Smawdq
 n9rngxZi8gCKs4VYvkXjKhJgKIP9LT6VFKhHvockE68mGmhtAmr+lLA5un0V1qfrbhUv
 LKZ+Xyld+12EHbEd6EAYjwK82dJYhD+278Zy0LvFP2zepsfOxlj1GAV9m44oeaUkoF2o
 1P5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776323050; x=1776927850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B/v/hNhQCWLSq3FLyP0iXETXUuLD7ymt0h9A6xZYv5M=;
 b=SQ7QS+BY4TU/R+g2J4JSk32yRoXtXNGDMCaSLnKdyv0q52kMt/qOUWc02so3TnbrUv
 /q7sw8nlFguHANGSssF08Nvcun0Oapj5kcy1dyh4Y8mmRie7lgS/LYNCyx1F0G2Xh2GG
 9Q6KwTTZNzBAeF4EjzxgHjXrsZ814/e1EJc8cQySLEpjvM3I6eOpBkcabilO6amf82Gc
 lBrn6Gt/Qj2Hi63cArlbdz9LG45Uf3XKTCHkM00IIRVwzQu8hIleTy7HnmdubFUzn832
 tmJTCNj07+LpBrHXAHF/2MsP4wVcmCto/dPST5K/sjfQ6ZysVf1NxaEAEl8+whoflUVX
 G+9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SWpRnpUQMAkZsBEt2Pa/es36F89LNkBrnAx0Fm38l2QSAcfb4K6O0NjAqqCjsbedLpE1L6xM=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6rdhJql4HvjBFgsHge8Hdi198hffRmEi9f1yCr9nAo8B8geC9
 CZVNaOAMEY1nu7onYZ3wTcN93PZj9FX/g+LCnyKYvj9THbgpr6l7gA4t6yihTc8MOfWdBp5RsCb
 /btvL2/BUSzrtu0FEISqb1H2HpS4dJbgOpEWpKQ6yXA+6cAhP8aMu8p8p
X-Gm-Gg: AeBDieuvxkZfWkREsLh5raNKpOGGgzYefDPhLr02xFMmIq+l0zNrGCS92Pqgt0izzeK
 geCSjmkxv8cEtrIzII/IAViuVeUiwZINd7o/sB5q3vk/5YT5BEwnjjjLR4brrZnYOL9Pc2pHWwn
 qw0UnsEkA3+kBco8z532gU3MpywKEzzgdpXTBzg7v/sUzcE16O92TXA/RrfeEm0zbrlpQhn/d7J
 aiBrT/iL9yeB4nmM013K4cnxzI0VrXSi+OlutPeQjOlhbG5svk4FGP0lC9tNinB1d5WFaiBI/Nd
 QT455owcFtaVfOJSZI2/c/Eq2GQqc8HDuDspJI5jf5rlWcudtghIuS5Svbxf183B58kAfcavvIe
 F1ZzFdoMIj48pOGEKQbWebg/aN+/eLOjaNtcQwOEcEI0EfHDy7NLVYq9PVAeJtZj+fw2au9Oq5o
 Rm2PoE54LuPWpSP7+Fv2WhwLechWg6yZDtAIkoE0Z8MjsNJU1amZI=
X-Received: by 2002:a17:903:3d0d:b0:2b4:6529:7b9e with SMTP id
 d9443c01a7336-2b5eaa50f8amr25581705ad.12.1776323049726; 
 Thu, 16 Apr 2026 00:04:09 -0700 (PDT)
X-Received: by 2002:a17:903:3d0d:b0:2b4:6529:7b9e with SMTP id
 d9443c01a7336-2b5eaa50f8amr25581365ad.12.1776323049252; 
 Thu, 16 Apr 2026 00:04:09 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b4782b1174sm54195255ad.70.2026.04.16.00.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 00:04:08 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, aswin.murugan@oss.qualcomm.com,
 simon.glass@canonical.com, tien.fong.chee@altera.com,
 michal.simek@amd.com, visitorckw@gmail.com, clamor95@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v7 5/5] qcom_defconfig: enable psci based sysreset
Date: Thu, 16 Apr 2026 12:33:30 +0530
Message-Id: <20260416070330.3006528-6-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416070330.3006528-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260416070330.3006528-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2CJTiWetdtWiDt8EoDCHbnkHYlepXRT0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA2NCBTYWx0ZWRfX5DPhceyaERz/
 a/P16E4AtfNeNbYDrOHyUvKt/CY8mReDiYVPDnQJKu4djDhIu4mXX71O0wrVpWK8IZLhEvME5nD
 imj/0wPLxdshWXc6GJ3C96G7X1qg4PxAyg6S0ZeGa7L1xpo+sKBexLyS6QodH6yA6mIRY/XkExv
 hZzwDR8gvzJDzgVZhloFaTLvL0rcmXjSKNQa0Ewj+nCQr/a8Z9N6myMDXC1hc4JV+yq7C0XgRZH
 rT3ICOMDtCmsx/7vDLWtEzIQd7+3EoL0XVE79MSa0bvHdg/d3jN5siOsRfS1uQzlN7oa2A+jkJD
 mZYH4Ci37r0bt6yLsMng9+9pwqYea2SWM4hb5p2ux9JTokhvWy6+D6Cy4Pt07BtKowAFLpgo+7o
 ucHU2QOgm2dBB4DehnJyx/BcpXHPTq7WN0P5EkHq+enSLsCVJcL254fVrBfmaRjGOvzMsH8EmPx
 IdgFohipfCduJOI12hg==
X-Authority-Analysis: v=2.4 cv=Iby3n2qa c=1 sm=1 tr=0 ts=69e089ea cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=uqFMpbG4MC8BjM4yXrYA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 2CJTiWetdtWiDt8EoDCHbnkHYlepXRT0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160064
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

Enable CONFIG_SYSRESET_QCOM_PSCI to allow U-Boot to reset to Emergency
Download mode.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index baad5f09455..d0bf1b81d2b 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -130,7 +130,9 @@ CONFIG_QCOM_RPMH=y
 CONFIG_SPMI_MSM=y
 CONFIG_SYSINFO=y
 CONFIG_SYSINFO_SMBIOS=y
+CONFIG_SYSRESET_CMD_RESET_ARGS=y
 CONFIG_SYSRESET_QCOM_PSHOLD=y
+CONFIG_SYSRESET_QCOM_PSCI=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
-- 
2.34.1

