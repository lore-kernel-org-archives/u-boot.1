Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A64BCD6E4A
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 11:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96B8683EF9;
	Wed,  3 Jun 2026 13:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SVdzMHNf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YtywSsGi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 858D483FF5; Wed,  3 Jun 2026 13:39:11 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD0E7839A8
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 13:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=gurumoorthy.santhakumar@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6536RLeO873753
 for <u-boot@lists.denx.de>; Wed, 3 Jun 2026 11:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=9PD0ECzs9Zi0F4Wzv5dPHQbiDPwftpv8pzA
 uOI5u1EM=; b=SVdzMHNfzqcUAxSusBv+pU2YeNh/0hVkukJNwdVbJvjEtmZmg5D
 ByEC2zApV6fZizOzh0Zwp9UQOGJ2UFxRk2qfyWqc0gWuQTrPZ7kwQU+Ujcu5IIJx
 rPVtq7pxBHpOoj+rf8tnFGNSStERD6Bjk4Hbo3nP5RkjJ/q7s23Protlb/AsWfso
 BzcN5cz6OrrNw20uyh0MszNJ7O087jiXNekxuAdldxMIeV+bkkbR1fUFo+A3VgI/
 kjkh1l0N8TKIvWcCi0xPU0JM04V+0m7s5hHD9oWczoyB8bEYsALJt9uAJ4Hoi9Xd
 oHeBdFtnr+i2vxOwMHAek8pEXflBuNYuILQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ej6a9k850-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 11:39:04 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-36d97a4e08fso3226004a91.0
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 04:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780486744; x=1781091544; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9PD0ECzs9Zi0F4Wzv5dPHQbiDPwftpv8pzAuOI5u1EM=;
 b=YtywSsGiSeuXmzzTe/hTcF7Hj5TOfINgZUZl2UrikbSS0IS7XBCsq597yiVVvRza/I
 CUD1xQruqsRmwt9JlqEZJY6xsYdGlGWVRXQZ1iA1tEkTuslOwLTPu7xwWvF4g6e4bPXh
 qIsUape5lCwnyxj+gOjDLBUbCZXKrJcSD3qE0haP2tXVxyVqt53wo1jsJPqfwE7QxQV3
 tGvjPnliD82Ub7wMOQQPZlKj+8RedJz8MSeuCy9T9geI9Dbl9X6L2o0fpL1JjOL571FB
 sDZ6eRPXCN9EcdRijWn9gjtda+LsMNqAPGh/k4SYntIJWO4eTqUrYm2G2SXqmMnpnIPR
 dHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780486744; x=1781091544;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9PD0ECzs9Zi0F4Wzv5dPHQbiDPwftpv8pzAuOI5u1EM=;
 b=QZyzPrr2JBJ1DfblBeEhI4gamD3p98ftsCWw2J+KhsMPcVUoREs20zLhUJLtfG0FGT
 iaTkLIPmrELD1ySxkOwk8nvsoyiIzsZVc62vYDKO5csXwlACw/KmOLUMzhP+B6LDS9KU
 J1PhqA/3dmVs0pLgJts7dkxoJll5xBTwvBOXKRN9Q+RdzNlQ7Z4tPOEzoqEegfeaCjHd
 OuzLatQ2a0F59sWXvaSz42oJwmm5NXl6zMg3WZRJ/y1/wGm5X7FPb/BbOso47jZDR/wx
 zL35B3D/7VExodyYU5sy+hEODMN/dMDUsyVwDCWDzDqO6TfIPUNGgVy/1i/O9L4e2Q67
 4XQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9UXmpecKhvdmi5NRy3DxwUrDJfLBDymbk5NGCXp8hvly7l74jzGtmCl7/WemSFmgBfPG6rPUY=@lists.denx.de
X-Gm-Message-State: AOJu0YyEifeKoV9zUySJPnmytuqyY2nh/RGdJBkpplQd+NnRyQpHrUFj
 VwUNFATlWqHBAcJUk5hzbN0G9f8Uhqb2UYUW/5mCi4d7gbE+0E3RPa4H/34K90GaApnEdb0YoqC
 SRtWWQL3CKIqjlMi9Gz+Ckqfeb9ATRboTuihmvAcE6I77hLg4QXXYdHYI
X-Gm-Gg: Acq92OHf0dwNbOMIJGMXyLyL07cUEcOvMs6QH7cQct79PFxVxfMPysdJpennIRPFX7P
 gd/897C5X6/Pr4Gxt9DyAP+DimiFiimBkFRIS40FXnmFD9j6bXNPkScT9rBG9xrqNQ4rzaJ0cPF
 tikCy7psAmZ0bKBLC7FVC4m9uR2tN5gAmg4CMmAH0Ux/EpwRk1s3wDXVi8d4qPdDetB5/od+K9h
 nV79NYaAKuc2Cpx81q5hxoYjNL9pJIDcxTvThf0Eyg5dlbeZrmG4hijwNett+jsUEBPKkEoPVrN
 eXinwzg4AzRggS1Dsn2Msp+WyaRXMhoQJRkRXouoZ9dkKVyJwpYuT0CtM3dfc7Cdtvm2u8FfHaX
 oLy5Voj+PcW4dPsn343DazfnDYlWLQ5//hewW7wNngtUmL6qGgEGbGhcPD3fuWnqUZavWEIHW2s
 b5mdEfibT2UbPgE4JL6vFXXtcmbc+mnPXJD+8hNrFDwm6/sSVhhl6zU470WNFp+O0TOkg=
X-Received: by 2002:a17:90b:5145:b0:36b:9c70:3367 with SMTP id
 98e67ed59e1d1-36e32288971mr2966430a91.17.1780486744048; 
 Wed, 03 Jun 2026 04:39:04 -0700 (PDT)
X-Received: by 2002:a17:90b:5145:b0:36b:9c70:3367 with SMTP id
 98e67ed59e1d1-36e32288971mr2966413a91.17.1780486743632; 
 Wed, 03 Jun 2026 04:39:03 -0700 (PDT)
Received: from hu-gsanthak-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36e702533fbsm1163614a91.2.2026.06.03.04.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 04:39:03 -0700 (PDT)
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, quic_varada@quicinc.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, u-boot@lists.denx.de
Subject: [PATCH v2] arm: dts: ipq5424-rdp466: add chosen node for serial
 console
Date: Wed,  3 Jun 2026 17:08:53 +0530
Message-Id: <20260603113853.3396271-1-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xUjAed7NuAdWojIqLu1nPu0JpjiKkQL9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDExMSBTYWx0ZWRfXxIFXOWVvVElU
 M6kjbokiCb3HGbSo+pcDS/t+KvvWEYRkEgzDXzpu7lSMRUfLdf1D2UrNjq95wIVDl/5mHYAzuQK
 /y62dlTjLk6GbI4NaPyaAjF/MkrzYlULkrZcrpzO0SZhp6o3ICp3TKFAJejX0ws2zAKw+jb+Xcu
 mIcmdGF2dow91o2OXcbxYPC/XrudCDRji3Drkwh+JJFdLb7ZFXv1ugQX4Yg0W+E3whLEGHLenwp
 Eo1I6w6KPuU/qBcQX4Lbax39AVNcsDx3dNxVU/LNNb3vxcle9nbKb6XulKbziaUUB/oX/vsUyO9
 Xo33HaDYHefRzoTAk/oa/YLKVoZ3fz57flMMz4+hSgLYd66QVNmY/SjkmuSzvFQpr3+IkZoppay
 sR3mzThh2YxJsbCmRrc+/dRH8QPMO1/h2tosdGo0iWnF7BpkpzRtuugLLlSUX0ExT5OBRbsLQGJ
 Gfsd5ZynLpudF45p4Gw==
X-Authority-Analysis: v=2.4 cv=I/9Vgtgg c=1 sm=1 tr=0 ts=6a201258 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=b0kFZ5AMU7loIkwuvw4A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: xUjAed7NuAdWojIqLu1nPu0JpjiKkQL9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030111
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

Add a /chosen node with stdout-path pointing to serial0 (uart1) to
enable the DT-driven console discovery path in
serial_find_console_or_panic().

Without this node, the live DT path in serial_find_console_or_panic()
is skipped and the fallback path is used. Adding the /chosen node makes
the console selection explicit and deterministic, ensuring the correct
serial device is always selected as the console.

Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
---
Changes in v2:
- Replaced the DM_FLAG_PRE_RELOC approach (v1) with adding a /chosen
  node in the board-specific U-Boot DTSI overlay, as suggested by
  Casey Connolly. This is the standard DT mechanism for specifying
  the console device and avoids modifying driver flags.

Link: https://lore.kernel.org/u-boot/20260524050328.414639-1-gurumoorthy.snthakumar@oss.qualcomm.com/
---
---
 arch/arm/dts/ipq5424-rdp466-u-boot.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi b/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
index 9e4af4d9f72..36640f31d61 100644
--- a/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
+++ b/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
@@ -12,6 +12,9 @@
 		reg = <0x0 0x80000000 0x0 0x20000000>;
 	};
 
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
 };
 
 	&sdhc {
-- 
2.34.1

