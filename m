Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F42CDE014
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 06:38:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFD1A83FA3;
	Fri, 14 Nov 2025 07:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QYRqUxbl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b5Vtvp/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BB9C83E76; Fri, 14 Nov 2025 07:38:20 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E813F83EC8
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 07:38:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AE41FUl2263196
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=I/D3A6dmWnz
 2YrEbzA4YL852rUAMUM3QHk3E+NjrptE=; b=QYRqUxblI4Qst9gR2MuWNUobCAh
 eJEi5GO2LOk4zp83lOgtkFQaWn7oljiC8v6/GauzB9Du2xAaEbRUd44cg2DBYIdN
 alpzWHgTERhaf4j4rLJv6nPkzUGIggvnYDzwR1GRnQRGmMYU3gP1m/rZRZnbQY+t
 IO7+2u1y7EpshzUq8CCMPj90iH5sSM/7fA+F5D7vvnxrPrtO0uheOlDv69DiBa/W
 QATK4PMDTuwDYwsXaceoCqbx3Dn6XEu6md+tOm8fq5amhMxQZfw96ugWFAuAATcF
 juurmkMhARoCa06U25MxPRXJNT6qaPeG24sgi5s2JEWRshUMq4GSAeZqLsA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adw1j0bpv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:38:16 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-34377900dbcso2480093a91.2
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 22:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763102295; x=1763707095; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I/D3A6dmWnz2YrEbzA4YL852rUAMUM3QHk3E+NjrptE=;
 b=b5Vtvp/xDvxXWYOk4xQb/d1qMmI9fFxIyequML2dE0nIiBBuLTNmmR6QApBMiCd4yQ
 tFbh0rfmcQoExBE8j/TQdGf8r3iL15v4oVuaN/+ywMo3cfaoxF6Vngx9tz6nMHFQJm0R
 Q+t1irSP2VFZXI9QmFR72152tf+giwbive26V13OsNIVuxypbDIjSiKBlGFtkrt46H8q
 L6IJfkkwvx05rsTROLSRcDdth3eLR4zkvihvbKANPsk8exQEERJmLTDJUDrdaICO9/dC
 FdVT/Ah/X5XRSJ1BByDwk1cnXEu0eqQTqxDgZJbffH90Y+lNGpXdfH51nMZZgiuWZjim
 wf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763102295; x=1763707095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I/D3A6dmWnz2YrEbzA4YL852rUAMUM3QHk3E+NjrptE=;
 b=s2lcwlpk+S6eOr0eKYftVWp48PAyFmfunga7DMPGNm4BiSHGuIwcmf+UlLBVIcrsVk
 RowMVapipY80ZVwdDFChkVUWzN3I0g/RfLtJql0Kz3tPuZu09eiy71TnM4hn6ApXhEjW
 3GzG26YHAlWi1olNmDJ3h1zLwU8J6WdX1RJ5uZdER9cd4uvib8HmDjZLD+MWT213lJTD
 hQy9EE9hc/ntgeNMlYe9s2spo12wpCFajGRG1tZLETyKn8LYwGY2uQ8TdG8TIOaXXxfd
 Upru3qa3AfvEJJaTokBTkjMM2Xmsh71AX7Ys3TDq1X5NRdxZch2C0wKJnkkJCnARDOf6
 gALQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK4qHkHoKauk3dZdu/IhJUmdybk9pX3sRLmImcwnGIqqyhjG+KZDWsMdlybdP+FDxCXwgRMEc=@lists.denx.de
X-Gm-Message-State: AOJu0YyyAd0g9HUxxu1sHevZZoxFjBxihatZlUrxQmtXqCFjT2ZBFXEk
 sRVnHUwEGDndkxZMK7XyNbjPn6RIOc9cpCUXYUopSVrw1bgPGabGZbAh/38JwXRwW4yt+4YNQlz
 i1+ogEnJlSu0XRmdREkzKtDVI1ELy6qJo2izzsOOe4sviQjHpoRaRXN7W
X-Gm-Gg: ASbGnctOpXxOc/lpx7XFBN0E91GaRsiP75k0LtzQXEf9rPVbnTP2BX/WfV7Y2ToMP5p
 BmN8aaN3dNeraZqWv2it6zTyFLjpwlcJnKEE3EZx1x2oa/QV5Fv7sIya7wczQb1prvFnU+3U1PH
 wN8zT6K15kHzuH48THzu/EnqVddfSmxdvUv8IYzPkBCgizTWhfOkhHcCiQ70ib5GkKNirIzFB0A
 m6jD4LHbXqZIOtcDt6BPSEIz7g1m8ZVHjCKBJRa9Qw5WYNcrRtrGRpykkWUHct6/e91xW2nveCA
 mtKUo2vt3iicewNGYtVVpTmX3O4UKdT4WPEWgYK2RNqEPupzT1fOYzTv9ALm0H3nUMnZ+tLmNcu
 9uyLGeBmSOte1D5oPwhoXPBVe26sKvrv3iZZov/FmfcFng94Ijt+79FNp2okavHqfBGVg7t+S/U
 dXUCqDS4JDwLg/HMBXHjdMtxOKoGIt6QQGvmLEEA==
X-Received: by 2002:a17:90b:388d:b0:343:bd86:b5a6 with SMTP id
 98e67ed59e1d1-343fa76c923mr1955620a91.34.1763102295339; 
 Thu, 13 Nov 2025 22:38:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZQmfxXmV8Fu9b8a6cEgvjLCCSCQFE3+PlSnjHLPX7eqq+TCJpKtphObKndZ0m/uKeyro6Pg==
X-Received: by 2002:a17:90b:388d:b0:343:bd86:b5a6 with SMTP id
 98e67ed59e1d1-343fa76c923mr1955595a91.34.1763102294787; 
 Thu, 13 Nov 2025 22:38:14 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343eac7fc34sm2706559a91.1.2025.11.13.22.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 22:38:14 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com, lukma@denx.de,
 seanga2@gmail.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 balaji.selvanathan@oss.qualcomm.com, alexeymin@postmarketos.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 1/3] arm: dts: qcs615-ride: Remove unsupported USB clock
 reference
Date: Fri, 14 Nov 2025 12:08:02 +0530
Message-Id: <20251114063804.3835132-2-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114063804.3835132-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251114063804.3835132-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Jv38bc4C c=1 sm=1 tr=0 ts=6916ce58 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Qin-PeR8fBxZ1AKwSVEA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA1MCBTYWx0ZWRfX9QbY7DN7DFkF
 sS7EZM6naXzgwy+Aom83TlWXpb4UQQYwSEEPst1oAhJYP6HkDODntKY4d8oIL7oFTJc/M0WG0AA
 9dzwtJ0JqXPwYo1KPLk53WdItLxwQuvJImDrtIb+zxcovGIKZScm9NefAhuDh0r4GaJl9VNLlMm
 Pp957twcuwaI4f79h9QAVR8YkghpGQ0fGLhECI5LFfOhBSWyLT3LHW2cWAAmsCakPlA7yn83s0G
 33IfSWXrJFnhhcGV/3ptm0BSjxNzRoft/yXFOafb2EAeIshFBCWt2xXiqcfwblwx37j+sHKjnAT
 DHQZxz9qW/bVpFtsIUWCwtBtfozB7AyBXDsRBZ/aESqLFiphdmG8c2srePXnNtNxkbISQwrjDYF
 sMyok+GncP0r9pYEpmqeC6iv6lAUZw==
X-Proofpoint-ORIG-GUID: fdozmXu59_FsWzAXMBtMvrI1ji0xUXJG
X-Proofpoint-GUID: fdozmXu59_FsWzAXMBtMvrI1ji0xUXJG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_01,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511140050
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

Remove GCC_USB3_PRIM_CLKREF_CLK from the USB controller node as it is
not implemented in the U-Boot clock driver. Keep only the supported
clocks to avoid clock warnings during boot.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/arm/dts/qcs615-ride-u-boot.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/dts/qcs615-ride-u-boot.dtsi b/arch/arm/dts/qcs615-ride-u-boot.dtsi
index 68fffc70fcb..d8af124cc27 100644
--- a/arch/arm/dts/qcs615-ride-u-boot.dtsi
+++ b/arch/arm/dts/qcs615-ride-u-boot.dtsi
@@ -11,4 +11,18 @@
 		      <0x0 0xc0000000 0x0 0xc0000000>,
 		      <0x1 0x80000000 0x1 0x00000000>;
 	};
+	soc@0 {
+		/* Remove GCC_USB3_PRIM_CLKREF_CLK from usb_1 node to avoid U-Boot clock warnings */
+		usb_1: usb@a6f8800 {
+			/delete-property/ clocks;
+			/delete-property/ clock-names;
+			/* Keep only the clocks that are implemented in U-Boot clock driver */
+			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>;
+			clock-names = "cfg_noc", "core", "iface", "sleep", "mock_utmi";
+		};
+	};
 };
-- 
2.34.1

