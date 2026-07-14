Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B194C43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 09:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA48784CEF;
	Tue, 14 Jul 2026 11:53:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="p5axNIGg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JeN+iiIl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73D4384CF0; Tue, 14 Jul 2026 11:53:07 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B1BE84CEC
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 11:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E7YGA64101708
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 09:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P+KAvSWsDKXiobSsiPUT9vNBQpqTfSoB0FEqXQ5N0EI=; b=p5axNIGgKAw4iewh
 4SIgXQAgsC48zWvn9w0H9peOA6hSieW4aUKwbMXLTG4eXqIFBvBWbkN7fsh6NTEJ
 7tP6zpJ2Ug34xukfCoax4TCApkps/spG9qWXnrjYEGTRYLpErMQOc7bAzBtk+Gs3
 hI/BXp2F94wlKF8QDKctPQAorkygr/T3HI5JCBb6DjIwC7yXGnjZ2gY0XfkQGp6k
 Q8mEy3Ae+bM1SyB8Go7CP3eVu+8XsbdXG+3UIAralOwcYcfdHRg37b8rmq38oxpb
 gnYlPND03n3q3W4xrPrHYscBdnmd6y9O8E+fSERMpLPAY1SMIx4o3lU38ebnPzvs
 S6W9mQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdgudgh13-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 09:52:57 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84a06bc82easo3731295b3a.2
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 02:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784022777; x=1784627577; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P+KAvSWsDKXiobSsiPUT9vNBQpqTfSoB0FEqXQ5N0EI=;
 b=JeN+iiIll7zM+ExcMv0IxNVhI7RFi5O8pCro9x/vNalE5MKShkAxN+vUIqkPXxz05r
 Oeqf6HVOpJ9Iu0pwA1StNvc6NAXvtB4eZCGQ0LDylsleNJsvcIQvs0apJQSMnZdDReGz
 Xns9IyGKbNzQLu2yru/+nTUFCLEK4HM2IQcQiq7KsQTeiKdw2/qT9k/UgvTI2X/nL/FV
 HNTigCoLeqiN/0lmyo173Ky8EdOKXuQFZRQAJQn3yNsd/V6/ikLSyrgDCLsQvaRIC3Gj
 RJnqhiD6/Y5iU97hdDd8XouDyv2QHCOgoy7NpfGg6rdLRRagcLqYhRJeXUZhC8BPZG44
 4eVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784022777; x=1784627577;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P+KAvSWsDKXiobSsiPUT9vNBQpqTfSoB0FEqXQ5N0EI=;
 b=Wca2QEVhs74fexjDxKo29S4D0Udslr1pjTqraB8zjrVOP+XmIwYfUPiAzD2+gtliwa
 js1A5GCJGXscT57Ye1Q82AjEdudSuFCfgSW7HPTcaFsk1jS+kpwk2tW7L/z64FNr/c9o
 lDvgZwAbRuoHJk0ko/N5UNEY1IQ7sYAV7/IW+B/bxuLK+2snfborOH5XDSsNtKiN7HJg
 Of23riq5LG+ZhBKxsr6e9WusvAgtHlp47Oz1xmO7ZLNbItr8ykRN+s1IZwxBOn+ngWuL
 4FyUOIDsEdPcmuu4H+F0zuvSaaXBrbIyw4Exzp8zD63eB5KMX6te3jX/q5nk77FqqRnI
 aYsQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoVKnRYqrdEoqNdrsDS1yzWr06dQxKh9XrZHx2hpl4t746svNXP9zmbT2TKIVoWfxkN+5jxUhk=@lists.denx.de
X-Gm-Message-State: AOJu0YzimDC//dvSYYxf/zZELTRCz1g0FKdI9pQp6YK3bUk3n6X1r2nU
 CxUDQA0q9hMStLMZCYjGpXvgNj5eaJj1dA6CxRf75YcnepOlpfP17/LXTQVvu4UcNeoA8j5nb4m
 w1myXmez45jnoh4OvHf+FQkOCiBAB8uy/dN8vvDsBMV1bWSgctTC+AYGe
X-Gm-Gg: AfdE7cm573gowtRiaj68/0bU0ARacyu6mSRMXNWm3b8qhixK1SaUf7XohNq9BfGN4es
 5rDSv/ePW+9TKyR1Y5il9WatUonoUlSHdxvXjh07gvj87PVWoK4QxqdwqMpCM3J0Lq58Z60YHXn
 zSiFBOeMVSEiHEvmevoCg4ogRL/7PYK5OGm/RFAP0QQwWcxU2zZPoRxNrS950Hfi8wJteI1uydL
 fESqm3SdoRuHFnHv8sKqwxO3v+LFwiPjmOd89s6G++jwtsjBiIkyl1Xv2e+P0AH/SGVmoFCWTwv
 6m+5Vdro630yzitIbjSXSEqpqN0YuOYJIRMwXt29JfD2I4A3PqnoFK+a0MxZCthpB6BzCMDmxDX
 lYUDzeIpEuvntOY67gbUPokFxOx0jZNwQN6qHMQQ2/Gac8X5n/lqsmwAN3g5DMP0XI+lvfUetMQ
 6FVDPalFjOu2d87FVc+yysMzq06L3e3qbuFPXHjTv3
X-Received: by 2002:a05:6a21:e8a:b0:3bf:97e8:a026 with SMTP id
 adf61e73a8af0-3c35701e55emr2122274637.25.1784022776664; 
 Tue, 14 Jul 2026 02:52:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:e8a:b0:3bf:97e8:a026 with SMTP id
 adf61e73a8af0-3c35701e55emr2122240637.25.1784022776233; 
 Tue, 14 Jul 2026 02:52:56 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b9081d5c3sm28180537c88.9.2026.07.14.02.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 02:52:55 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 15:22:40 +0530
Subject: [PATCH 3/3] tools: qcom: mkmbn: Add support to create multi-elf
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-ipq5210-v1-3-0b98251aabbd@oss.qualcomm.com>
References: <20260714-ipq5210-v1-0-0b98251aabbd@oss.qualcomm.com>
In-Reply-To: <20260714-ipq5210-v1-0-0b98251aabbd@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: ADj6UsbOzW_ESaD-Ni7vClmH2a4HpkMV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwMyBTYWx0ZWRfX0TY+KmkMr56S
 +dx563Zrltuptf7LzWIAWGErLP0iGisnwQ0D9FuTB31RPZhYMS1Vq5lFdDqMdlngfyQUlt+A8jz
 vevbWGcV1bqSRVOMyTd6u3WCTyFAqvwZEh8DlZM98UBX4dCkekiHE0/qSpHlV/tnu8qTOVMlLhj
 1xIytMAFpMUmPNrUW/LLV+34/CWF/NdoD87qlXhNBJIXznNC274iuwcr/5fyOm6Wt74I2coAxXv
 k16ziPA0i5nF8er5SM94fZt1wewsup1cbaWoEYz1A88fZCfE0zQcjeWToh6l8e7JmJHO/phDMRB
 x22pNeGEe4rzLFxRon5RCtgJeHhd/zw1EN8sarFvMwfkq0ujZhdVdtRAH707ERGMN3APChc9FLo
 6aoKRr3txGJcOdgaZwbyT5KFsMjeT3UqqMk6ftA9P6eQq7sh4pu8TlBQf2NnzauDRCyUufhOqre
 IOJCVwK4IYDHKUAVsIQ==
X-Authority-Analysis: v=2.4 cv=T/O8ifKQ c=1 sm=1 tr=0 ts=6a5606f9 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=cg-7CpDhVU-K4Wno2zgA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwMyBTYWx0ZWRfX2dHAmhU4QVCl
 buBCGxTnImi2bE+cugXKTSdr6gkT2bY6aZEHEyVgZbNCvBPtRNwillknjwJirb24iBABxtLenR9
 Bqqoptqm3ImRuUmHKV6RltGR+yj9lHs=
X-Proofpoint-ORIG-GUID: ADj6UsbOzW_ESaD-Ni7vClmH2a4HpkMV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140103
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

Add a command line argument to take a list of files to be combined to create a
multi-elf expected by the boot rom.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 tools/qcom/mkmbn/mkmbn.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index 46edbcafb32..a2df1433129 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -104,6 +104,9 @@ parser.register("type", "hex", lambda s: int(s, 16))
 parser.add_argument(
     "-l", "--load", type=lambda x: int(x, 0), default=0, help="Load address"
 )
+parser.add_argument(
+    "-m", "--melfs", nargs='+', default=[], help="List of ELFs to include in multi-elf"
+)
 parser.add_argument(
     "-o", "--output", type=Path, default="u-boot.mbn", help="Output file"
 )
@@ -119,6 +122,18 @@ parser.add_argument(
 args = parser.parse_args()
 verbose = args.verbose
 
+if (len(args.melfs)):
+    try:
+        with open(args.output, "wb") as f:
+            for path in args.melfs:
+                with open(path, 'rb') as tmp:
+                    f.write(tmp.read())
+    except Exception as e:
+        print(f"Error: {e}")
+        sys.exit(1)
+
+    sys.exit(0)
+
 elf = Elf()
 
 data: bytes = args.bin.read()

-- 
2.34.1

