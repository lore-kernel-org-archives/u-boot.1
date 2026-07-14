Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A2FC43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 09:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC06884CE7;
	Tue, 14 Jul 2026 11:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yo3Xv3lI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fy/tays0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39AAD84CE7; Tue, 14 Jul 2026 11:52:55 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C2C384C5E
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 11:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E77ERl3931703
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 09:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=; b=Yo3Xv3lIx+VbrrLI
 9mLdpx4YY+hVIsrW3pMHN0+0A25I56CrPX2ZOdOoE8qS2pgyUACEqt1WP2ipX1mb
 wRwfz9Uaw3F/LMki1clJ3kn1vb6vFvnAc5FSYJbSFLcjqu++byEdV3qnwysvQLm7
 vLVwUQi1rNTV5bgngbA1OpF0g4MkBoebAmEDfqTtTw429J65SypKAIExFY2xYfAj
 iiieKe3n6RBp+ALAVFK4K4M5NQniHUtAlOd2+isnaj1sLbBpSFa20ffB99Z/0Sqm
 4m3EHYWOHk4mACKE3OKLTIP1M7+aF5Z4kzvznA/1iGn/bYbtd7fcfalQFU68v/0S
 93y4rA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdgeq0mc6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 09:52:51 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3811279d51aso1620641a91.1
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 02:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784022770; x=1784627570; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
 b=fy/tays0JkIdxnjyLrXtd3fX4f6yMEjqCiiStC+uZl9frCtsoca8esub2lfJTYS6T1
 mmjENSHb6JmrMH2BooTrKYfxZYKMEXWR6LNQcTh7hpQwmQ3GD0G9ezyTUhGDGWbcyHTm
 XfmxL4hDNfXQtUvTZyXNraHEGC9oTet/v1Q0ysLZiDV2mmmBcYjbh7ZNO2Z5QxH3MlnY
 tyooQSWoDaIpjspJaLhYcvlrzOnF7BkYwwAbOv+5BNq9Y/JtuZT9MUzZfc/N90GYEUfA
 di1pDOOguFdA69BcAXsa1CnIYUHtiWWW4LMlO60NN3qjZKs8bFJ7G+A/q1YwBHdo6+x0
 avpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784022770; x=1784627570;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
 b=gyZIJPGVi0SYJbNXTzLAo8poA0/qTn7yngw9BaFJIjsq9RsXPJ1ZSF+vAv8o/176V4
 0vwf8zPr9oqAUpcrFFJZv72UyT71M5+r2vrHOHouEvUINItkekc0r68SejAt+aXzmQtZ
 St6Ip63ZPeu1v0+8DytqNLI34AOJShYcArG2i7oavlKcgH7UteMz1zKZ7qQWocSEvqqR
 lwCqvQvRBCrnRvACK35AhMDV1dUugaHOm/3l2klwKlQxuBU/jtT3jJmgoJaiInDYU31/
 3hrXrvjYZ8t6u+dBOEgX9QmyeddBmdGTFHp98mzx1NBMZCI85JsmfEwO3VAA6VRJ9iij
 9TWQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpyv0u/PBs4W2B6ghet0i6L+8HWTKpPWq5UkGBSo/t3qZJM7oaiQBfM5zuWfaclWm0zTzasMe4=@lists.denx.de
X-Gm-Message-State: AOJu0YwhQgzUpr2ItdpiPrxIqxTK1SmfjWZZhFJwhK5tT1FPrk4tx6HI
 UfG5dGc40wtl1OqmltiGesMRkutBgbUq4TYs8H6M+7++R+DOtU1Fboc4CVxndjBOhfnapVQ5doA
 qDuzIl6Xi0siEIKk4i44lMabfz1J3oAoG/OJfh8VZ5QjKshluPy7ExTaQ
X-Gm-Gg: AfdE7ckqWyO9HuPUzhz1dqiKjioRPfufZTLYKv9ZuutSYlLfpz9aV22aQKvI2FjvYIK
 enz1PDBSle58KIDGDYW3pmrjLXrKRiuuQkOLGUqlbtirBSs3VaxVkgpXXpPqECT7DUIIMXsbCM4
 2QTE0ddczZhZ+8PTeAWad3awPjxIB50YSCTLiL7H1GghGHZcPh8yWodAPUumWQiluzAXGX1c7wg
 W6ym81j5GQDuUGtSRJcmI+kez79KsLUg7o3ifTY1FMSlddlMgVck2ftXuoH4o9tZeBQPiHAyrHb
 6qShyJ99H5Tk+VgJDvCIxXChKPsmL7J4N/Amfu3khsFHE07ZApEWg3FZZOxlnRvvHzX33Mcshfx
 KG0FM96GJ7YhpmnE+fT4aCpdCFvkzn817VP5dntaDb7Vfxye2czODgasGCOkWODYX/IKtYU8OGW
 IsagsAM/ueHU0ETfp+9tXc3y7sj93tSgU/BTpqto8x
X-Received: by 2002:a05:6a21:9216:b0:3c0:9c1b:d0b3 with SMTP id
 adf61e73a8af0-3c1108da3bbmr15854989637.62.1784022770480; 
 Tue, 14 Jul 2026 02:52:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:9216:b0:3c0:9c1b:d0b3 with SMTP id
 adf61e73a8af0-3c1108da3bbmr15854964637.62.1784022770073; 
 Tue, 14 Jul 2026 02:52:50 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b9081d5c3sm28180537c88.9.2026.07.14.02.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 02:52:49 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 15:22:38 +0530
Subject: [PATCH 1/3] tools: qcom: mkmbn: Fix ipq5424 MBN version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-ipq5210-v1-1-0b98251aabbd@oss.qualcomm.com>
References: <20260714-ipq5210-v1-0-0b98251aabbd@oss.qualcomm.com>
In-Reply-To: <20260714-ipq5210-v1-0-0b98251aabbd@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwMyBTYWx0ZWRfX9PESwsWmdVpp
 Ec1PcrXiAXzfWbowrMY3j5rLY1rfnFAHMVmMPsLcfiPCZnF5//r69AkpgeQPHcs0aKyU5Xcx88h
 2v868Wqo5NgDgWOlF+0Sbjj0vPkmx2xJDUWzJ30TurP0SUJPHmNqeox9NQOX0zl6S/RWKmVcuww
 xidvUjTVDp6lbur0/TKVLb8WwTIuRDi1QGxj5ZEHd3tA4GJOi6eiKhBOC2v2YC+MwmwXmH2uLKg
 R5o01Kh+Jr0YtrxBFTDLRuU3X2nEcEXvDDbxWUBPkUJ/DZFY4oI91kl3M4XGW3JP3Fr3rqegT2R
 VghYYGRNTzaBq8Vq3/HhFyAQmdK0GHJxfaqebb5gtuYX8k1W2t9OB9FZ3hfQDBJsO+ZwjK7GU2m
 fWqrV7GTN5cHzwkZCvGSYxKJ667npB5N1tIHF9+en8p/mCHWZXH88O2oT7h48A1M4RJjmsgu6UB
 yNqXbaAZhKZxSttGLiw==
X-Proofpoint-GUID: fBGptFJdw3Rc6TBMLHv9VPhplgYXcnpa
X-Proofpoint-ORIG-GUID: fBGptFJdw3Rc6TBMLHv9VPhplgYXcnpa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwMyBTYWx0ZWRfX1ZjJokcjCOza
 +ycTNckuqLbb8udQLWaHscYyZqqb9t41Pf7il5eMIb1wqeJbJGE4dM2f3oy4f++eIEI45urAaJj
 H+VqM1gP9RczGcI07ac2TQHpy5GjqMI=
X-Authority-Analysis: v=2.4 cv=V9VNF+ni c=1 sm=1 tr=0 ts=6a5606f3 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=5oOYJkjiZhHqBJ3UFLIA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
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

Since ipq5424 uses MBN version 7, update the ipq5424 entry in the 'boards'
table accordingly.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 tools/qcom/mkmbn/mkmbn.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index e4484b539b0..8d2078acc30 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -85,7 +85,7 @@ boards: dict[bytes, MbnData] = {
     b"qcom,sm8550\0": MbnData(0xA7000000, 7, SwId.uefi),  # C8550
     b"qcom,sm8650\0": MbnData(0xA7000000, 7, SwId.uefi),  # SM8650
     b"qcom,qcs615\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
-    b"qcom,ipq5424\0": MbnData(0x8a380000, 6, SwId.aboot),
+    b"qcom,ipq5424\0": MbnData(0x8a380000, 7, SwId.aboot),
     b"qcom,ipq9574\0": MbnData(0x4A240000, 6, SwId.aboot),
 
     # msm8916/apq8016 has an "aboot" partition but the process is the same

-- 
2.34.1

