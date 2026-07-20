Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D96C44527
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 10:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 381B1838D7;
	Mon, 20 Jul 2026 12:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XGOcnQqb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G4BPGitn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7532842FC; Mon, 20 Jul 2026 12:26:02 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BCD880517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 12:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K9vZ2P2238486
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=aFvUjqmSZ+RwJKARGDxqnA
 cFeZ/HIFdhN5j/TJ9R+N0=; b=XGOcnQqbQRKOstv08gjd2TTCSbSb8R/bASPbuJ
 Vws+6kjtDlWFAjDiMccTrx33EzNGqRiSfSnti5BFXMnsXhm0QfLr+WmqAsSwbXb6
 9lJJmQQwTC5tkIO5k6EHMCY0cz0x2k7tM7kDdXy3EUzrktbNi1PurERhAXd7Fi2T
 yk0ZEPZtLx72i2JptwsMDmsYpmFq/LMYBdX72uM9MXNC2WUrtqc2fk9Vv7LWRGU3
 ShEFDj6cADWcu7mmpBFB6YBG7LfK6tD09QUBG2B40/7CTNJ9/g+Tm22jvEgHtka9
 Fn2k2tNM/TYLVp/J71AgnrMT3kPtnPx/pUC35IHmh3ZK9yWQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgre8amm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:25:58 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c7f385887bso243217515ad.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 03:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784543158; x=1785147958; darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aFvUjqmSZ+RwJKARGDxqnAcFeZ/HIFdhN5j/TJ9R+N0=;
 b=G4BPGitnIMRes6anTcnaVRfIx4dvXh0SEXJHuYh0DpjJmitoFStPo0fmt7BVDO9mts
 PBWPLxjok4YSXvvC3DczCB8A6+LRIXdX2ZYcbucwvB1UFhwqtxBh0kMehqXa8iPD7d3n
 QwIHOC6lRajPeMvM82i+uvw5kZDgesFfPUksJXCdQzLdEEIdOFcPN5xrkOOcsnpINs7s
 wVFK1Hq++WipGxEZYfM73DBSYNIgHDULDR33heWw1pua1DZvFZHvvbgxZT9g5C9a2/Mw
 hzfcwtOa8d+IqG+FMXa/+x1TxwLtr4YFDDuG/7M3e7cZDs2t1qiEWcxzykG1Cr6j3OAh
 oT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784543158; x=1785147958;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aFvUjqmSZ+RwJKARGDxqnAcFeZ/HIFdhN5j/TJ9R+N0=;
 b=MZBzslgnzZtHjY53K9x12bbY+FW9rbq/WoFF1h6OHQg0SFyO7x70b01TgDKS+WQXjo
 6/GsZlgtqyYnJFt7PHm/ZBipPkrTwSKUH23f208ywvOcC+gFpicy18HO/efcKQdo/gDM
 ldKtNzSf5x1v0hejCo/Xx64cN7mCb9phCBNqPSuEaSN7r1RUKXWPr1bJWi8mB7l5dsJX
 WVW+wcQFNhSlJOjIdOKvXPjj5wJokCNWKIDhUFb+45yiGI4bpHDSCzoKujxyDBfSpZ0U
 Nb5ha/61Gmc83alywZSZMYBMgdxj2x7QOG/cLzKoKbBST70lqyzfZzUtQZSDIQXnnZpk
 0mXA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp0ZS+FEYRp284kPhmDpqQo/p0PC7MtnrxUwZnwCtV0G0cxlvH4oV1Se31X+LB0Bgfv9lX0skM=@lists.denx.de
X-Gm-Message-State: AOJu0Ywr14HBHyi/x40B/KPTc2aRxsdGbYrGxLldFCJHZz+pvkELGV4B
 tTnuqWt3u7Pxr75jZ30xUKfrPMXfC24uLIIlNI6cFTQe803hUA/LC2NdufvBYkdpkOSBoBYRJE6
 IuLmfVuj/EjExeR6PsoPYCGuVTmr7howorPzFEXT5Wt2RNR20Xwa96AZo
X-Gm-Gg: AfdE7ckyvefEDwXw3k5iQrQGztk5QXu72IKoF5XNwNG04mDTrPnk1Jukioba0DE1xud
 RbjP2F17c7e6um0qgpo0dZJpnTokL5UuikSLGck3KYsQ9VohRgNFtDqKldALhH3SsRZp0ES8iPi
 Sa1N12PLM0INlUb7I825YThb6yF2/E8Cv4788zuPT9P00aKcfdkd8GnjX0V6eUXT8GpoCQza1X0
 ElIAPtFMpX+vMW97ipsI77FK2kMPJ7aLTtk7CXSHAW9Z8dKRX1F9iK/wtpqYKJcjTiROJ059sqb
 +vh8dwCr1XhMfGPUVWAV2pLtMFrPRJjqMZdJ5+d6a5rbVpaUsIG8lEE8FG8zQri5+kUL3R/gB2d
 3KlyjT554uNP0Nt59wXUQw3MhypK0LBbexveiazANsMS9p7cCcFMKmtWa7/Wqfub99jd1vNlWDA
 LTPtGs5cVVc72mlifY5hV4Pb9Qzp+b
X-Received: by 2002:a05:6a21:3b89:b0:3c3:9070:96b3 with SMTP id
 adf61e73a8af0-3c3ad7928e9mr14419878637.3.1784543157910; 
 Mon, 20 Jul 2026 03:25:57 -0700 (PDT)
X-Received: by 2002:a05:6a21:3b89:b0:3c3:9070:96b3 with SMTP id
 adf61e73a8af0-3c3ad7928e9mr14419845637.3.1784543157455; 
 Mon, 20 Jul 2026 03:25:57 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29c2a48sm25889663c88.2.2026.07.20.03.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 03:25:57 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 15:55:52 +0530
Subject: [PATCH] configs: qcom_defconfig: Enable EFI variable runtime storage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-runtime-v1-1-7f904b4cb3ed@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAK/3XWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyMD3aLSvJLM3FRdkySDFBMz8zTTJHNjJaDqgqLUtMwKsEnRsbW1AOI
 JUXZZAAAA
X-Change-ID: 20260720-runtime-4b0d467f5b73
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784543153; l=1301;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=t13w4/pQjahxZs4VJLg4/Eq0KZTnhdLa28BL9CZTOCw=;
 b=TsMgUdX3AjRUtMLcwB0zWQ6Gxa2QpEGjNl4tUz/45jt8OaAm717wYD9JEYzGAibxRO9IY279p
 26CvhO4AFNMAeD2WnYaHdYduBIBJvt9CAFMIdkv0dnkusGM1hHOQlhY
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExNiBTYWx0ZWRfXyTbR2wOtStNz
 VMZtQZBTA2raNJJwGFWy3CLIOoqnSWj2S2Lo7nZ7x1dQB13phpaiJOBRBpqo5VD1CykMWmEw+Al
 bdabTXq1ldJZCbj/qOFI21YH8O2rw28=
X-Proofpoint-GUID: Eeh0zCTGkxhsKh-l_EGbe1HW1k3WxHFO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExNiBTYWx0ZWRfX0NgjMVGzXcXj
 MyM4A6yt1ZiHKgBNqJP8gqRR0txUS1tuvceJBo+lJUenctMBZ907u9F+enMTEfnq+rOpzptPbRU
 VOlVrDCqzqgXGZCYmj7q+QYWHND8GvR8De+lhV1M/G7Q3kzhQUM2DtaQTKf/3eDvzyNpoLyoi/6
 h+e5l7/iaYK6Gz3+w1dJ97x+CNiM8cEXFIsZ+xwNWVKreP/x2h7195sX1Hska4B3oT34flXHigW
 phAbRn7DAw6Woc/16H6VVG5wmk05vNnB7S/BjfrTzKbagOk34gNQNu2fwqYATsXRAxbltN6hubZ
 0H9RLChk/NV19O32MhWHPiocRxfXIQ0UKkMV57fMi+zIE1/m/ilymA7fLuD3NHfRp9D903T2pYW
 rqmaLMouiLW+bkQJ692HcqNACD6MXygF0yRQgSm4e1vpFHUuXOjn4F4PP6ruRG/lyL9ZbAcg0To
 YCfaCAJivydmBZj/f1w==
X-Proofpoint-ORIG-GUID: Eeh0zCTGkxhsKh-l_EGbe1HW1k3WxHFO
X-Authority-Analysis: v=2.4 cv=foLsol4f c=1 sm=1 tr=0 ts=6a5df7b6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=WAKu7lI3Ms2ttr5hbzkA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200116
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

Allow SetVariable at runtime on U-Boot's in-RAM EFI variable
store so the OS can write EFI variables via efivarfs. With this
enabled U-Boot also advertises EFI_RT_SUPPORTED_SET_VARIABLE and
exposes the RTStorageVolatile and VarToFile variables, which
userspace tools such as efivar use to persist runtime changes
back to the ubootefi.var store on the ESP across reboots.

EFI_RT_VOLATILE_STORE depends on EFI_VARIABLE_FILE_STORE; select
it explicitly so the option is not silently dropped if that
default changes.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index c52f619850d..01c70c25c66 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -10,6 +10,8 @@ CONFIG_SYS_LOAD_ADDR=0xA0000000
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+CONFIG_EFI_VARIABLE_FILE_STORE=y
+CONFIG_EFI_RT_VOLATILE_STORE=y
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y

---
base-commit: fdfe2ec48d5c1c2ed03073d73edd3fdd3fe1ffa1
change-id: 20260720-runtime-4b0d467f5b73

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

