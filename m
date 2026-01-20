Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91A7D2ED11
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 04:26:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86A1F83A5A;
	Tue, 20 Jan 2026 05:26:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XM1ZhTby";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dRp8AKzL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2675F8063E; Tue, 20 Jan 2026 05:26:07 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB0C7839DF
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 05:26:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60JGo2qK1904978
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 04:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=I/D3A6dmWnz
 2YrEbzA4YL852rUAMUM3QHk3E+NjrptE=; b=XM1ZhTbyLIjegpVhQoi9zPltR9B
 J0KdM4pHLznl4JcduJ4mAdh9Cpc1xSD/dzLLCHwrOfFUVe2gFbW6IGzcxRMBlCsG
 ugt3tdE9IAnhxRYJlt3I80WK95YJNrBIGpRAIvla3Q6PTKpzcN5Ugll2Wm1VIU4B
 IXZjCt3u/RYNuCJutn/bVMOyJ8NjlkcT/ZogUGk8AOshauTZIu4UdcQdmhj+JoY7
 IYm6RWP+ZSACGa2pkbgjLkNrZAa64Ff3HCrlvmFND9GUzp5bH8fGMjMX665hes/V
 l/oeHC/EWzhJ49Dl8HdCV/NmVypsQm77EHuepdv7jDOrMk1X3Bsxd/SrPfw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsgmuaypq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 04:26:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a58c1c74a3so41949715ad.2
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 20:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768883162; x=1769487962; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I/D3A6dmWnz2YrEbzA4YL852rUAMUM3QHk3E+NjrptE=;
 b=dRp8AKzLA7ZK88o62kqS412ONau3FRNqJeIO/WXaomN5I1EaUJCct6wmGN7iyLU5eY
 V4/WQ143WjPsITZHSVS0zppA/0yD4MYtq7ik7ufWGSpldcX/8XlDLHTLHANAv6/wS1H8
 bmoTOG+DKI4jSPaXZSxR6M0Ycd3bXoaspOUR/Y4M9lIRml7doyhK36Fbp4pRf81WCusN
 1lasozV6DtqvI+UtlzQiraM/lnw19dL8UEYxTle0UojK7kw/9JqU0sMFNA/TvLejUoZf
 ya0XlvKEtiRGXPWsDe9oWz0AZBq89tw3C2BzXvIzUO3DyLdw9xgvOj6SNLmdLzi8peO5
 3rZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768883162; x=1769487962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I/D3A6dmWnz2YrEbzA4YL852rUAMUM3QHk3E+NjrptE=;
 b=MCpHuf5apMHSL5ZHEMDI2jZxw7NpdGEbPpfPaaF9LuvJhufU1P/CCeVtdLwdPALUy+
 265iqZu+VQX465slPH+OnuBeJHX+KTDAJ7IbwaChUMHkkb7E3Xnp9D2qlAtqCssct20R
 I6Affs0CUnZsmwfmx7Jj6w2R8MfjUsc+lbLMXkDUs23V13djKSaGNz3DrjqTKFsAF/j/
 EKGRJdFqNTab8EJgZpPRFA+PiQEMFBi+Jtgj4Lv8onvsaGue/pdgsMR6QEJNSLfF1pgG
 U/XZesNakEq01fVExWJ/o1LprJsvl3vAzGUy2kqcKCfiWNOLtP8qk6s7UIsB52yYOr6C
 ShnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlfSspYGEe82KIZkTOxJuZeizys8HF5N6hAKd4M6eas6qH+2c99GCn8omSX2iuFa1jjmUa5oU=@lists.denx.de
X-Gm-Message-State: AOJu0YwwomRE2Y5e24XNFHQvjJ5AbSX4lXUq1Z254UV63dncBfp0gOyZ
 E2GdKJ45XsaNkpypjfZhfd7L9dHc4FiU9JJ7gr01xEbXcwM1mNC4FPQzrYvPi30enYZ2d5GFmdd
 PeOiayORYGqbO666nsWhqD9YJfF+MS+8Sd8cdExdyzaMIzeyh8lmgSggv
X-Gm-Gg: AZuq6aJr5LSfVWHcqEpUGXNSVczw1mlzCcV6DngGBlgDFqZ9z4FuQb7/FfEnuOU4N3g
 +FM8mn49L3FQx7H+GT/sjJKWGrIVR/eFR1yZl6PW5YGuMGpoxsZKL0NdVQobxqLLs/Sr1L0v4UH
 Vt+ijZZqg+jKXsauk3Q0mPl/EqbZ7LfE6TCuAE9n1i7cCTF2XnFy1PzAy51ujw7Hb+HNzErOEGA
 t8lI7KRMaWtvyM2djAowQ7EykHkBbA7T7WsWJGq5QsXLoCMtM+Z3R5Mkisy+pnCLT0Fsd8EFS5s
 GOjK0MlQO3OwyDcvECj/OpuymAffj5rdEMIZucJGkPb7JmqknN+cbV00034TZuAPBdkJud63GEC
 789pdBZwB6F5TtARXvPFJWwbvrFuc0+Dj1siQs1yeHXJtcuxUEEwEIhxqJXQsHsZVgGiVp47SKj
 j26scRk/gTexZHkyEARAXyE44c28CnsjCzV3sVZg==
X-Received: by 2002:a17:902:e54e:b0:29b:e54f:936d with SMTP id
 d9443c01a7336-2a71888af64mr123668665ad.1.1768883162280; 
 Mon, 19 Jan 2026 20:26:02 -0800 (PST)
X-Received: by 2002:a17:902:e54e:b0:29b:e54f:936d with SMTP id
 d9443c01a7336-2a71888af64mr123668475ad.1.1768883161797; 
 Mon, 19 Jan 2026 20:26:01 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190eeefasm107929825ad.43.2026.01.19.20.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 20:26:01 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com, lukma@denx.de,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, balaji.selvanathan@oss.qualcomm.com,
 alexeymin@postmarketos.org, nathbappai@gmail.com, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: [PATCH v2 1/3] arm: dts: qcs615-ride: Remove unsupported USB clock
 reference
Date: Tue, 20 Jan 2026 09:55:49 +0530
Message-Id: <20260120042551.650113-2-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260120042551.650113-1-balaji.selvanathan@oss.qualcomm.com>
References: <20260120042551.650113-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDAzNCBTYWx0ZWRfX5EzPi65IfIHy
 MjOQ+hGxLds+WQjKBVdJi6lez0ohy4yvJpKNGtKR2j4Omx8egKm4GF+20tBsIBXa0BL8c9dXKY9
 hIgM5T8KFhrA0zzU+8Y+LU42t9fx1If397Zcxqnvj8ucKPjRqpCOGnxbh7IZm7z3aRG5rja8F2+
 5rRK6H0gp+vyCcfsE5qZl/IvxRjuwMJsk1MaJgi0jM/4h5hAhhDcUcf7VYYDKO3mKgHiqfEvEPJ
 L1IHv5NLCyQ8EPOgV4tqW/tadSed+Aa5/Vt8KG3KiWGqkH3eOZNITT54puCZOAD3OfLbKpHjx/c
 uZCJAb615I8zwkgUU/qUgYPRlG+EgZ/vaCLH/NnqKYpnzUL/Weo1ep/quR4YYQpMIHgrFDINInE
 enaiESCVwHFO5VgqZsL/kw2411ZcCt4d6AUhEZHNnvfaQWvAuynmRJDJM7iWnqe5f6XPMNx70OO
 rrpKhRNTQztJobgzgwg==
X-Authority-Analysis: v=2.4 cv=Is4Tsb/g c=1 sm=1 tr=0 ts=696f03db cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Qin-PeR8fBxZ1AKwSVEA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 8RlJ4b2lsOvS9PBTDZqopWJI2c7r5KW9
X-Proofpoint-GUID: 8RlJ4b2lsOvS9PBTDZqopWJI2c7r5KW9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_01,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200034
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

