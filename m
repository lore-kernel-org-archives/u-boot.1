Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E72CCF2E3
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 12:10:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAAAD6069B;
	Mon, 19 Oct 2026 12:10:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SIap50X9MFAq; Mon, 19 Oct 2026 12:10:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B6C7C60634
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792411855;
	b=im/vpFh7aD7m9prpUULxz3UjCncOPvNX/jsvU75rXo14C5qUsiIVwH11D9Zb65ECV3IO
	 vAN705GryuDcjlLGpH0OSM2Gd7cbg95L9/MPnggXcJCrPGzg2Tn7kq006MoKxsSPxf5R5
	 +LqrSq2TK8o53uRSpMhz6Apkr1Wjd5dp85vVcNgr6qS9Ac3J/kTC82NxxZlHv+qh2IxUu
	 fftxHUq7EZ6tP5+pq9DjifmWxxNTz6ANUzNc+hgb4PNkwdP/5NjniNqyN4pzOQvAbIlT5
	 h85mUfMEObiswuypCeJpgOhtc7B19Yu8scKSwsxTR+JilMKwyx6pffEbhSE+9vDMxQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792411855;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pa58Z2CQ/savHVLb4y3HPr0I223iD9moDR1stCTOU+U=;
	b=ZhGv1CK3UPjO60fmozVf+HoYU7OqVK4AwX0ynOCNRbSx6u6MMm7xJKLsuYdYFkYDQNZl
	 Zho+YIUKmukeM56xC4Xc5VSvCU9UiY26+iAeCs99TpMX49SDlihoe/T9DC2sUW5h1Bu6r
	 smVRFCsYMjPSqMmL+HBIxIVx97VZTydC7Qg6TDS58Nkf/c3Oy39rav9zqZJy2uk8VkOQH
	 MeTCf65UZ8C/sU95pDYONsaA+KPHbfL3ZeYz3x/Xo/z2u4m9fgui2DxNKA3Xmg9IHECyc
	 mfOMDmis7nfFpWrTPcGLihabMbSkWgOqnfU+TpJLmkHizVeN3eiUmBMsMbhX0aVzikw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IWesZhG1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ADv9qxVO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792411855;
	bh=pa58Z2CQ/savHVLb4y3HPr0I223iD9moDR1stCTOU+U=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sVYLFLvTVKpzIBeQJoMBmpCG/l38VWkcM9R/lt5+cmMEAv0yRw5NuI6bUZr0lf317
	 tHWW+pt+s7YmZFVEHRY4xX4QdVmTPeVpW5yseN/EB08kfD+FlRwOqqNgMm8U4EnTdp
	 TiWdBlMgu8vyrmMx6y9j1f0eg8kMfBHjyu/tcmClwZy0B4S2q04ir13jnAlwrnESdI
	 zQ7OqD0xK/lzqzunDCczJbuyccLT5CYCeOUuD5zNThT3SXbCrIH1EaDh8AJmuc4NE6
	 8YmosxgfhEgTxZf6+SuirUGkr/dRgkyqVcPXSbLHlhTS+79gcrkZ3sCtEiViGEQOoQ
	 mjJt16+4XPAbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6C7C60634;
	Mon, 19 Oct 2026 12:10:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B30581E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:10:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B0B6E60634
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:10:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id icksVYZHxRT9 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 12:10:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9F1D960612
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792411852;
 b=C7Uub1QJOVkwzAhFeWGX6m6qqJCMocMy1PIHrNEmtoVARQIm/GpNMH8/QjZKVJfc/zEN
 +kByIKAbVXMHoRAhE/nPZrt1qVT2uRpOMM+tzlSuVP8OEA7b79g8mmSSC4bYNLJ7Q3iCS
 Ecf2IeE2AKu5iBLNNlQG0aC+ZbFMudyWmU/K7hSrjF0BHeOQj9XuvuqjWMum3MwYCqIg2
 HsUDTtlfzQf1z/3hp3EVxtl1aL9WGgyrqX3b6uyimm9hgnA1EKbWT5GBK7OxjZBEz+OLs
 Ql/gVQJftMHUtcHWslMfgB1lUVtckJCEY4R4MuM4P/t5e6PDIFlNdy/Kp5I4uN/OAXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792411852;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=pa58Z2CQ/savHVLb4y3HPr0I223iD9moDR1stCTOU+U=;
 b=hs7J6Dx3viqnoKFRXBP6o/FCxV25J/5TQOFIh8fr/DOG/t3hZ0JWs/xbO8zAp5BsGuN1
 x4oktwTerNv0uQ3RPXppqWQdmac5ePCBalQvwgwnApVyxefXI1Ep/ZzIS3E/ogo86JY7u
 r2VVTpIRZ4xE1NroA9h4q+ZW4O68wtGddScMbPuLOFLtkQMbS2tWssdp/YabwgNY9BNot
 F2gN5r+GXaY3FaECwU/GO7/WgM2B7UkNNSRPxLQiYSYKRyBAD9gc942CwZKfJ++nebk3Y
 exPo3vnNlmjN3iW2BF2524ENZ+3VQo6E3581cgmLMCgv52NSirAWpTq6Ixj0K3SIZeg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=IWesZhG1; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ADv9qxVO; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=IWesZhG1; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ADv9qxVO
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9F1D960612
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:10:51 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OnWZ1348091
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=pa58Z2CQ/savHVLb4y3HPr
 0I223iD9moDR1stCTOU+U=; b=IWesZhG1bJ3ho5VFwTu4HMfpkZPjqZ8Gl7pgZz
 gvKbn8a61KDOQz7V7vap+4GCPJjq+/5hAuf68gBtwHjWJPtRNg3X+BVcafbMGnsV
 8nI5rdoQefLZFRxD4eEZ3MuzrKB/9xGqxJyc1FpYKJawKrwe5KVpByAwPZQuuEAK
 M6eNhpbKbK2dDGZEa5Re85RDcinC0Zv3tc3RjE0JmLKRZJymIe9OlOVQy1OUAta4
 oCafDpIdQ9gsEE+T/JnD5uEzNoqHK+S9mVCS0ZFINx+ZAEbflSneap8rqNTEU+K9
 4j0f6y0IuSDSTOrZue3eXX/bx+DFSsFHgmFcY8N0/TgqFozA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf4rgyq4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:10:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a3f673221so790686385a.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 05:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792411850; x=1793016650;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pa58Z2CQ/savHVLb4y3HPr0I223iD9moDR1stCTOU+U=;
 b=ADv9qxVO52t2UW0WlduHjkzYAvHHLfeYl6NJ+lASWmV8Cfk70ZKr2YFoQumbN5oc4B
 cuLoX9VECoSXSQkm/wlKN8IBSX55fRilnFO8aa3BfIzatBSPbMW64Sr+fhHicnf9u7V+
 3K42mJSRb+O2pChQA+hz0qjGOFSLsF3DEw+48F2QJ1JA/2Q5qXHpSYVmU6BrZ/az3Naa
 gLWeBtgw70dbpitIWJn7YfIw9/3XpGExzTktQq0DHBK3S40PguFN/5qTzY1+XxJdLVem
 FtMIsNi/RxTMFiuAxtDYmsHeV3EpbFbYpocHxuUmMFQ3qmaOeWMbdOVsvBDdh+ZYUvdp
 AMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792411850; x=1793016650;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pa58Z2CQ/savHVLb4y3HPr0I223iD9moDR1stCTOU+U=;
 b=AlTrw4K1xx3yVjqEun8irLRCT83xGAm/vFTyfgnoNcIyiL6+z02M0FiBn5lzCUgmqZ
 fnCD4QxzdxkCD0668fq20ZbG2PYkBcn+YjnLHU0lP+60WqYOkdSuvNQzj4hz3DgyG1Hj
 oTgWyqWdc1j4JcjOmt3KDslwlgwTTlXVkpL+GG2gE3LBCrSaPDb7zKXtX9wQe9oj9qYV
 XI9s0aG3jXseEKZEgLH2zn6P8MdjqibWQWa7jy/xgUhBf1VbrT2u9RUGYODlW3vHfHC/
 TIuUeRuDJUc/nLM7zlCv262N3wQ/ybt9tL3dhzLt8z6ytHCz0iY785l2uvoYKFtPe7NJ
 huRw==
X-Gm-Message-State: AFq9FYIybkGHTO/pjslsf8tpSGLQBXWBH6kg6V+gHpTz0jqcUpdOghdL
 Cyczz1SM3K4bPBk9NomuH2JD2inzDf9mBlB70629rreK2PlY4ihjRLhKkdM3khRLp+CdbpipnTt
 dqRoyc+qLWfKMzikTTRDTz5o6eZpGcoelok75fka9hYTkuxw70u42o8SKtOZWYM6flqyMd+k=
X-Gm-Gg: AYBFou2SfCHHswFV1hmYYmIzV9RFSQJJUEWvVUUrzO4aQzRnCPPJg7vkk/L1kepzzqk
 OS9LJs5OjkzOnBAWXOs2S3UAja95zeJKOi9aDASEm6TwBbc6AlvGXfEa/bgP7V6viilMXRO5AmF
 jFF1pnuIXGPog2vcovCHQ42/vXxxIDEpl2x2PCFsD1LG/Dl8IoK+pRP5C5JE+HYU5BSll0nyU6k
 GULWP/ZdF6XlrI94h41vZna37Bz5HgaEC5qCg9nu2YBn/npwjG5B6Lom1ZOFor7C3u4UaTvM5q6
 /IgC/nONp9nc4LHFW6hfmQiCdORZ79MjeQy88G1YybYb159zUvxbxEZUBa/39SS3CBWw16BESkC
 C+iPTRNTFHOvYCxAI8jiavFC7idLwM4syE8zjQmoBwWXK
X-Received: by 2002:a05:620a:290e:b0:93d:e031:5ad with SMTP id
 af79cd13be357-93f29cccea6mr1227485285a.17.1792411850210; 
 Mon, 19 Oct 2026 05:10:50 -0700 (PDT)
X-Received: by 2002:a05:620a:290e:b0:93d:e031:5ad with SMTP id
 af79cd13be357-93f29cccea6mr1227481085a.17.1792411849684; 
 Mon, 19 Oct 2026 05:10:49 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b38a1c6364sm3961522a12.14.2026.10.19.05.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 05:10:47 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: [PATCH v3 0/2] optee: two RPMB fixes for RPMB requests served by
 U-Boot
Date: Mon, 19 Oct 2026 14:10:39 +0200
Message-Id: <20261019-upstream-optee_rpmb_b4-v3-0-c97cf24fc56f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNzQ7CIBAGX8VwlqZAfz35HsY0QLcWI6UCJZqm7
 y6tFw8aL5tM8u3MjBxYBQ4ddjOyEJRTZojA9jskez5cAKs2MqIpLUhKCJ5G5y1wjc3oARo7atG
 IDHddVfAMeJ2yGsXn0UKnHpv4dH6zm8QVpF9t66JXzhv73MqBrLu/kUBwiktZMGglz0RNj8a55
 D7xmzRaJ/GgtRXop43+tNFoq/K2LHie0ZKJL7ZlWV7Asq5DIwEAAA==
X-Change-ID: 20261011-upstream-optee_rpmb_b4-ff86a4ea9039
To: u-boot@lists.u-boot-project.org
Cc: Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: hMfL1ULJZwsRr4c2BU8CA6s0OQEqNNW2
X-Proofpoint-GUID: hMfL1ULJZwsRr4c2BU8CA6s0OQEqNNW2
X-Authority-Analysis: v=2.4 cv=H7NOUOYi c=1 sm=1 tr=0 ts=6ad608cb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=Bsyt1ek_QK09mtdjVvwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX9HTDBsLVBVEg
 9sDsimqNYPGsutMjIu0caUpbF9cv/rme9871UdWwcnGTOfqUQYscXwwycmLrhMkEq+5d1mL/KZi
 Y3D8dS5fe4toiNONRYqEZAi4UBIgoo7Xk0sYDN2ibX300+nufIOH7/ZifphwzSg/gMTid+teEUp
 jCtaak6m5ytcwZWQ1FfCIP+wpcQ8AkgAUYjvEL4dVw30wnB0aLRJXz6rwWTd8UqojIFoyNw9bxV
 6nNvUOCZwl/zzM/mJ1diF8udLwNwBZDt71abe8OxgmYxT4OQyyPV42E3Z8G4cxFYeOeubte3jKa
 bVCUWmf1VNP9Q+CLXkdWL03zjxDAtDyDHwrFLJd8yKOmjSmuwvtmeTB/sQ6aPrwa9Kj2sLIsgdb
 ZnPPijgO/HwxSr8Sc1ib+v7J9aUahQHH7W3I3eNBE6LiX1phbTAVZigQSebU4IlguneAe9llp5V
 S3X1bF/5SJrmZxHB59g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX8pZEnD3SaNFM
 JkUhcvfP6ItK8a2mU+Efl6pwtIxO6bLNo2fJ65FM6eebXoc3yoKNvdcG0Wq5rUo33IVd+EU8XTr
 IrHp8PaJkNJUBgbsMD6xH+PLwUvgwYc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190048
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

When U-Boot serves OP-TEE's RPMB requests itself (CONFIG_SUPPORT_EMMC_RPMB,
drivers/tee/optee/rpmb.c), two problems show up as soon as a TA uses RPMB
secure storage while other code is using the same eMMC. Both were found
running the OP-TEE AVB TA from the Android bootmeth on QEMU virt with
QEMU's eMMC/RPMB model, but neither is specific to QEMU.

The first patch makes the supplicant select the RPMB hardware partition
around every data request and restore the previously selected partition
afterwards. It used to switch to RPMB on first use and switch back only
when the OP-TEE session was released, so between two RPMB requests other
users of the device (libavb reading partitions, the bootmeth loading
boot images) switched the eMMC back to the user area, and the next RPMB
frames were routed to whatever partition was selected at the time,
ending in status timeouts and I/O errors.

The second patch stops optee_rpmb_available() from announcing the RPMB
device while a supplicant RPC is being serviced. When the first eMMC
initialisation is triggered by an RPMB request, OP-TEE is blocked in that
RPC holding its RPMB mutex; the announcement opens a nested session and
OP-TEE's second thread spins on the mutex forever, since U-Boot has no
notification support to put it to sleep.

Tested on QEMU virt (qemu_arm64_defconfig + OP-TEE, eMMC on sdhci-pci
with an RPMB partition) with OP-TEE 4.11.0-rc1: the AVB TA reads and
writes rollback indexes and the lock state while libavb verifies a
vbmeta chain, and a TA call that is the first eMMC access after reset
no longer hangs.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
Changes in v3:
- patch 1: select the RPMB partition inside get_mmc() on every call
  instead of in a separate helper, dropping the dead store of the
  original partition on the first lookup (Ilias Apalodimas)
- patch 2: keep the supplicant counter in handle_rpc() as in v1, not in
  optee_suppl_cmd(): the sandbox TEE driver calls optee_suppl_cmd() with
  its own private data, so the v2 placement wrote into
  sandbox_tee_state (Ilias Apalodimas); explained in the commit message
- Link to v2: https://patch.msgid.link/20261012-upstream-optee_rpmb_b4-v2-0-85d76a54273b@oss.qualcomm.com

Changes in v2:
- track the supplicant request inside optee_suppl_cmd() instead of
  handle_rpc(), and use a local variable for the private data in
  optee_rpmb_available() (Jan Kiszka)
- explain in the commit message of patch 2 how the hang is triggered,
  which TAs reproduce it, and why Linux does not need the check
- Link to v1: https://patch.msgid.link/20261011-upstream-optee_rpmb_b4-v1-0-7c63edca4b92@oss.qualcomm.com

---
Igor Opaniuk (2):
      optee: rpmb: select the RPMB partition per request
      optee: do not announce RPMB from within a supplicant RPC

 drivers/tee/optee/core.c          |  7 +++
 drivers/tee/optee/optee_private.h |  2 +
 drivers/tee/optee/rpmb.c          | 99 +++++++++++++++++++++++++--------------
 3 files changed, 72 insertions(+), 36 deletions(-)
---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261011-upstream-optee_rpmb_b4-ff86a4ea9039

Best regards,
--  
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

