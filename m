Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D0BC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 08:20:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFDC582C55;
	Mon,  7 Apr 2025 10:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lQoR3RLN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 947A482CFA; Mon,  7 Apr 2025 10:19:39 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07DBE82CD3
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 10:19:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53766CVh001086
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 08:19:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Im5yMayum9T
 PVIAo+s49B8K/jtOzQDexCsmLQkiUmUU=; b=lQoR3RLNxERaCub8fQy3StTXeAf
 Z/5FXcIbfw3vnhrWw67hsPnGLg+mqX14X1FWaMGSZatWwC4Ivhpps3kEG3kYCNzT
 jY6IE9iergH/HnTYkGR09Z7LNz+YaCHnP5r2LqQq62eR0GQIUr4DDBI79U5Sfrt8
 RcCGmDOof4r4oAIBd3k+DS2KEnzW0LDbcU2JffWVcDSMd64pk4hV9hb8w+JhHX+V
 1EngIZVEV6xF/QQuEsdUfb2hzZ80GIoOJ+T1a6ZmCfA3zE7UQwzU0c6LimUo0gpn
 0PfzNeAWxaCW92DWX559GhYzWMbo89qjZyiQNOCcWPR8rwkhd/0Lq+OmpMQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twdgbeqn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 08:19:35 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c548e16909so368714785a.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 01:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744013975; x=1744618775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Im5yMayum9TPVIAo+s49B8K/jtOzQDexCsmLQkiUmUU=;
 b=CujfL5wvWjNcoo7HlThPvGduVfphL43jjRqT1o6McWlZuKbMXSW+8674f9makg/Kb0
 riqnjhHRk4VCwP96jBdEbziSw8YFCXy4Eos8C9if0tcovSbMHJRoYJgwkSqfHEF2H0Ja
 8ye78qqQj2YGa+70JrKq0eMY+ZYoHSCTCJ1FcdkeilkdNwWvJpF6YJxLkYDZCLLCJWsJ
 F44CpOHJPi565GvO5QhsxSRvuhgSZoVHtMEV0cW4De++yt2yskbxek6LJfu4wqL0zUL2
 RKWYugaQTi5hlA7IUIbR46jl+Bc0bSq8GGcnHoAr1A8AoD/4kcWnLrP6iK2SW92jmSDl
 uZYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRGMdIU8cSDz8C6Ezne48+IYn7h8qyRxhOycSjWpUaJDUYyPBfXh/G7VUkO32I4gEuG4BwU3M=@lists.denx.de
X-Gm-Message-State: AOJu0YyQaHnwrfMRhsw/MqKxi7hZYD1zz9KTMVPOLM31ELK8bt9fZ3AX
 PiE8Tar4YUwaIy1iGxckCHg7keW8B1li6GaFSsut94EHexhRw5sVk+6kWnDER07M1RUiCDRpQhP
 RiVj4cbQh9nLzXqWivnRHOIiF/kSYpOwfXly1vygU31cozzdyPcl5
X-Gm-Gg: ASbGnctW1IjnYoekzDSyqDALGi47flkHzsZLXAEQScOMukl+ZjYygj6xhSm3i7UFAKl
 jPfxtebpV7lBtZ9cVNQFxufrFhzuBh2R1XrR/fp5UqSG8Y8vFn6OPmGtqYykBM62OFM60LPtgMe
 kjLECD01GrlrfXlou8VtNZjISiPgm174YfbJBKFqoiFglQCkRm2Ummgduyq0eyacUHHpmsB4rKL
 PMneMMu0MkDUEN0cl2pHeJ8owgFTIFFzUhyUPHbuJjU0sx9tKi9L5n6HvW1Iz7rim3qtJBis1kG
 ksXCeqSgKv30jZyAei5gs6V4+DbbaWpWE4k3KevUOtrA9nv0f07FCsdKR64T1IDBwJcmeg==
X-Received: by 2002:a05:620a:4612:b0:7c5:460d:45de with SMTP id
 af79cd13be357-7c7759e9d77mr1841584685a.8.1744013974992; 
 Mon, 07 Apr 2025 01:19:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtB06gQ7RcwFjhfrFBCq+fY36r+5qX+mvszFj9xNSQ5EAqv5KvlVwFO3nrWbPSUN1WIpQgnQ==
X-Received: by 2002:a05:620a:4612:b0:7c5:460d:45de with SMTP id
 af79cd13be357-7c7759e9d77mr1841582085a.8.1744013974612; 
 Mon, 07 Apr 2025 01:19:34 -0700 (PDT)
Received: from trex.. (233.red-79-144-185.dynamicip.rima-tde.net.
 [79.144.185.233]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec169b4e4sm125815155e9.20.2025.04.07.01.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 01:19:34 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH 2/7] clk/qcom: apq8096: fix set rate for the uart clock
Date: Mon,  7 Apr 2025 10:19:22 +0200
Message-Id: <20250407081927.138915-3-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
References: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PJgP+eqC c=1 sm=1 tr=0 ts=67f38a97 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=9rMOtB7ueBl8bWGkC6audQ==:17
 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=y8Ro2cJD4jgClqCDWvEA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: swowEHhGvwpbWXtiqGxwxe499szm1vUK
X-Proofpoint-GUID: swowEHhGvwpbWXtiqGxwxe499szm1vUK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_02,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070058
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

The function should return a valid rate.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-apq8096.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
index c77d69128b0..bc00826a5e8 100644
--- a/drivers/clk/qcom/clock-apq8096.c
+++ b/drivers/clk/qcom/clock-apq8096.c
@@ -87,7 +87,8 @@ static ulong apq8096_clk_set_rate(struct clk *clk, ulong rate)
 		return clk_init_sdc(priv, rate);
 		break;
 	case GCC_BLSP2_UART2_APPS_CLK: /*UART2*/
-		return clk_init_uart(priv);
+		clk_init_uart(priv);
+		return 7372800;
 	default:
 		return 0;
 	}
-- 
2.34.1

