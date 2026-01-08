Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8ADCF6ABF
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 10:17:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B794D83B87;
	Thu,  8 Jan 2026 11:17:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bHDdOHF9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O5vh/32z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F3A783B8A; Thu,  8 Jan 2026 11:17:33 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 048C6839D7
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 11:17:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60880xnH2239464
 for <u-boot@lists.denx.de>; Thu, 8 Jan 2026 10:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=qKAJYEdHzNKL2Awh8g1AMCSaZKcQN5Otove
 VRIA1to4=; b=bHDdOHF9xXrecw2EMJPIdxli7ot0ZMYwvfCUjHAA4G0LYk4VrKj
 Py0ex9Vf9z6eXCVp5qMMGbACwGAw5gsypW59WdK67qo6yeR0EunRAU9l7VIyBoVE
 xcG6EzT/iysoOMJmxHH4e9Ps9cNw1AY1cPzWfKbJ3nLl8y6+wPSCh9rS54SLJhAp
 gR91KbabISdWRKJ3+rlZG9If0E2IAaFB0en48FCU57qh9kaP3P1VT7frugIVHLIE
 XBqlB6OqRHRegxrH6lJsdwHh1mWln909KVqzu8OyObX3v6lJ2+6ZkDyb0ezXCOTH
 9p0OdlqvsXZVQyU7UhJ9MD2mwUnfOUuKcQQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhqwg3kp9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 10:17:29 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-bc2a04abc5aso2263620a12.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 02:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767867448; x=1768472248; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qKAJYEdHzNKL2Awh8g1AMCSaZKcQN5OtoveVRIA1to4=;
 b=O5vh/32zEargw+oA1PXpfwEiRJm7kBzbXqjGfqjfD8jw5ShifeN/0MSmAX/HDK2GwV
 Xk0lkwq1ziXTxwKj4+mr9zlEjSwumGjvs1IYg/6HOC9eHnnl+iOkcpeszvbFY7Z0lmN4
 Ie7KeAlNSXmW0Y+uLcLPNQXdO2mCheckQoq31G8Ep9RGlEJ1zk2L4c8OoILZTd9s999m
 DWIDvbvPwPnBnTGh76yFPgzFp+DyQeYjX8rSn87u7zFyrl/vToL17ZgMFIOwqzUxpxlz
 lr5XRP+ASfm05eJnpyQkS0zSC/60a4Hi5fvA+Rxp/BA0c6xEjRsYdLhp8xwr3hfq2/VZ
 rcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767867448; x=1768472248;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qKAJYEdHzNKL2Awh8g1AMCSaZKcQN5OtoveVRIA1to4=;
 b=aanr+A2M3lVQRwFNOPRQ02zzuOm4tKixPFDzD4IY4OAq0SNWYVO0aA48psfSAugH3m
 q4ZvvlsUIzZcyLFjLPj7r+53lHAXH9/K9K+qnt5GIJ9XQbXkXIDVIEwRstsEwJ7+4xKZ
 u/xu0XIqYEh1lVy/sPHyX5Vqk7AqhE2JFjgbCoY0wdMbGy9zfOIhXjWOZePj810VUE+F
 nsAWSAqaTy0nDqRztzljhHJL9JusIST8KAC+xthxDKXL6bT2h+hGcHNcvq9i/A1hDu1l
 G/VSa27ppdrE1ov+RkCr3pcyPKqCRgBmxlJ6+6zTZDALwl7uhchjYQaSh5KZNlVDVcmM
 8aaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAEpSQndJy5A4W8VJyuDIK+0gbpI8aVKG4itgZTAgA5jIkBJSp5pbvZkDWGrf4nHmh61wz7oM=@lists.denx.de
X-Gm-Message-State: AOJu0Yyvshn7IyiCS+ZhgiqhWXwa6jCZ5OjMaVUGgXXK6LLJQJfOIvOD
 EmgKLA/AazkgOMZN1nq/gCrlmDU+UPgTMBCwtCDPJZyhzpi05zYhtzREOsZ8LSERYlGPdR8WRWY
 SUOB6NcyGJiiIUmrYQWLmzWG9C3Dyn/QXFAk4NoPQR27m0KhcIjYgN2nD
X-Gm-Gg: AY/fxX4eYqSMqB6bM04SvCankg598QgmrVUK4TtEqvYh6SWpk1wpVlPHzmJNNIzPwGs
 TZbvD++PwwmnNQVhy0xHDDwL5GLypFkVcaxM+N6SekQ9IQ0JlT8OXa3n5Xfk5pFoEzdu6RCju+b
 jlQrXrFvcZCHTcXJNsXa7ZPfhvqhxwnZYy2WTmMBVs4rI2cNs4aHONo+C1+jwBNiIIZLRESbpHB
 vQ02EZlyIvI6Ztyp3zRSmW4jbiH2EkTKRreJxncidqt4erbYacvpjKT61TOE+mqrRzlmNZgiYb4
 Q0apGBUqTvtIeAtKEDIcmaZqh2XkNn4r3s6h+J6TKeSEmZ5jzp483TXvVEpMTugwYffC/poGwzA
 jjM0m7eLrKVJDAQAWe6oIcW19noVK0Sn8WZ+0Ujm+SwH+Ya66vWhBJCqTw4leoby76nN/buRPKm
 4hh2Aa2dRXtiAzbCrSJ9pzSB985ugneDl5oni89Q==
X-Received: by 2002:a05:6a20:7d86:b0:334:9b5d:3876 with SMTP id
 adf61e73a8af0-3898f8f5751mr5176697637.4.1767867448399; 
 Thu, 08 Jan 2026 02:17:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEG0mM7kZvamBK3JNgrFM7Nv+RCNiFIRdJg386SeOc8DJEO3YrNv54y50hN3Vub1UD+u+bXnQ==
X-Received: by 2002:a05:6a20:7d86:b0:334:9b5d:3876 with SMTP id
 adf61e73a8af0-3898f8f5751mr5176673637.4.1767867447874; 
 Thu, 08 Jan 2026 02:17:27 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbf29086esm7730007a12.1.2026.01.08.02.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 02:17:27 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, me@samcday.com, sughosh.ganu@linaro.org,
 gchan9527@gmail.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 0/2] Clear RPMH TCS state before kernel boot
Date: Thu,  8 Jan 2026 15:47:19 +0530
Message-Id: <20260108101721.3411854-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RkbNw-WaH_h5s6nBMhqQWs3akcZsWDN5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA2OSBTYWx0ZWRfX6wAJua+H+tlc
 1b6qZT4O32QW4KbbVN++KzT5rz298tYuzgtbQAoHQ1Mo3sd/vaosqtMQu0Lj6QbAHL6eHP4UiBh
 c6YZUCTAY+at2jK7ijtFDWqhIOZ/DVJltD8E85JqI5QzJJ7Au/s6yvMY2HPD2jVSGij5buomvHU
 65gl+txaYN/vHVxVtvq+14sBjP7dlZNRU2yM7RlRgmmlBW6MkdUOXcFp48AGALTbyZokWji7KDq
 mm+PwhdUltLCuD8kkmRhb3UgWQpFUnEgdYZPbq1TLjvy432eDMRwuqCUBvLJuKplG23Goxa58UQ
 Jaf49XUl8ruKkvNkVRSURVH6DX8t8rh0bOUJfZQsPjSRsjEE/7KtPBfyAEAVZZXtuUhuDBTHCMk
 rvC8Um8pvUcwT4NXf55kmshW6tWC8XtaPSOY2zhp9B3ro1MPeiuFJGoFgv8o6T7rRc7KEshaACO
 TLJ3yhMeXq72YQaRyTg==
X-Authority-Analysis: v=2.4 cv=Pa7yRyhd c=1 sm=1 tr=0 ts=695f8439 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8mnm4oOvxDWZ0NhHhCgA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: RkbNw-WaH_h5s6nBMhqQWs3akcZsWDN5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080069
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

Clear RPMH TCS hardware state before kernel handoff to prevent
timeout errors during kernel RPMH driver initialization.

U-Boot RPMH operations leave TCS registers configured. This series
clears TCS state via device removal and board_quiesce_devices.

Balaji Selvanathan (2):
  soc: qcom: rpmh-rsc: Clear TCS state before kernel boot
  arm: snapdragon: Add RPMH cleanup in board_quiesce_devices()

 arch/arm/mach-snapdragon/board.c |  14 +++++
 drivers/soc/qcom/rpmh-rsc.c      | 101 +++++++++++++++++++++++++++++++
 include/soc/qcom/rpmh.h          |   9 +++
 3 files changed, 124 insertions(+)

-- 
2.34.1

