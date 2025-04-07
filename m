Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDEEC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 08:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 179DB82CD5;
	Mon,  7 Apr 2025 10:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BfXUsAzd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33BCD82CD5; Mon,  7 Apr 2025 10:19:37 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD16A82BCD
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 10:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53766Ax9013116
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 08:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=4piElHWIhaXD//vwfo//Rmoc+fw3BEiuLoQ
 OAcEHjW4=; b=BfXUsAzdDkk3jbxnJVbrm6U4XKyKBBQ0J+o7rkz4bqNhNCq50ba
 YWvfoN5a1TaoXTgiDDkuiOo6R4a/e2iz95xmAWwOWp8xaGokFD5TGESlM16QkmqD
 5XKg2ylF9JBSjYp2UdQS/xRRK5K2D42x4klLwLbG+VcNSOQnjVTndDh9egpRRjKT
 kLK9IFJfEwsq/qq1dbetl7pjGzliEGoCfEcX+iu5cBfxTfmXuh8MW2660I7Ay6c0
 lpVLHmtjIkVRA0A/x49NaT8NaY30DMtXkjk2PiEltxYk/ZuLqm3Di+gD5bdxD5fF
 89EKHT7SDd6nmZysYeaKkjsIXTMQM954fvQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcyuevj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 08:19:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c54e9f6e00so844129785a.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 01:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744013973; x=1744618773;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4piElHWIhaXD//vwfo//Rmoc+fw3BEiuLoQOAcEHjW4=;
 b=WzNKrAl1s0IZ+36lwUBqXgIn2d0FXv94KmfeospHzMqsQOuGfT83yzQSFPPiQ+iDF0
 Go/vAHUNbca1BUc5APQEhi/u4vu1+B33dTYglV5XAlg8yr7BDzYUUp5lTJMV0OA+Jdbx
 IIbBoEGAFM/Rw7QoI9vEQ7QBNkyrXN4jHSxygztF5fO5IoZZzWeeD+hyHzzxCYEWzpQ9
 /GZ8PtsyKPD5kmAv1xHfQm7QkICdAQRhNlaKXME/p3o4ndUKHSDl5j/tq7Vq9OE66gE9
 qzuOV7A1382P9xbtGs/8vwbfT7IP/Dn4mdURakm8nlPXZEZ1A2IU6nAFEFyhrLrFRa1B
 XC/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYDnIbI0unaSB3d7y0XPVk1yTAI7KRttLTfJifk7xXjmS+xxfH4JeSSh/vtlKgIpkIZitah5Y=@lists.denx.de
X-Gm-Message-State: AOJu0YwZ2ts+uYOhhVQEWGsxWmLe0HleAc0YJwypUhrIGVz5F9reQb38
 cJNfznXkpMI+u/fzQ0nv/1GnFNRFS8dOW2GnhmeXMFWMcLhjM8p1KBYWvaEnipRLI5j8jYD7bIR
 fc3rVoNN2K0XU7ZCcKdPhelgddb/Mk9drZSPRM2fDEiHBJjiqO0dx
X-Gm-Gg: ASbGncskX8E2+9e0FD35AR8LzIe+Aaoxze0Va6pSkye/Oe7W1ZCiGKzna40mgphzv3R
 pAsgEu5GQUcj3lMXaUnCrIQdhGjyKiET98VkEWBH8zxteA/VqTIUKme9i5suUH5AWHQjjjzaGLQ
 N870z9FGGvVZziSq45y8gR1rd8Uj7nF69j9bhzdwJom63zjYn82mYhMbvOsIAuKcrIX0RfTwQRO
 VsV4EnQmJyUgPgW93mkb8ypnWTCb95zxRZNvtbJ92a8Eg/SK9uCY71Npk+Vu1QU1bLfLM115j/U
 vTmumT7l6e9/MlpDTJtwK+ujYNBKRrWtq6xrgvO6iz5MFUQckqNDqO7PVmyanalaAS+srQ==
X-Received: by 2002:a05:620a:d86:b0:7c0:a264:4de1 with SMTP id
 af79cd13be357-7c76c9d6377mr2187450785a.24.1744013972711; 
 Mon, 07 Apr 2025 01:19:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtcGuaJpJU5DyX8C7tMzhbIOULCBkwMLHAi4goVqqvQT/HOiyd7T7/pYeVG3nGAK0jLO9kYg==
X-Received: by 2002:a05:620a:d86:b0:7c0:a264:4de1 with SMTP id
 af79cd13be357-7c76c9d6377mr2187448585a.24.1744013972363; 
 Mon, 07 Apr 2025 01:19:32 -0700 (PDT)
Received: from trex.. (233.red-79-144-185.dynamicip.rima-tde.net.
 [79.144.185.233]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec169b4e4sm125815155e9.20.2025.04.07.01.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 01:19:31 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Dragonboard 820c - fix board support
Date: Mon,  7 Apr 2025 10:19:20 +0200
Message-Id: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: z1WK0ktrfWFKuqTaVmacmtX-D9IHbRQB
X-Authority-Analysis: v=2.4 cv=Q4vS452a c=1 sm=1 tr=0 ts=67f38a95 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=9rMOtB7ueBl8bWGkC6audQ==:17
 a=XR8D0OoHHMoA:10 a=1WAWCIbmk_mZ0XDlsxYA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: z1WK0ktrfWFKuqTaVmacmtX-D9IHbRQB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_02,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 mlxlogscore=496 classifier=spam authscore=0 authtc=n/a authcc=
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

This series addresses the existing issues with U-Boot support for the
DragonBoard 820c.

[PATCH 1/7] board: qualcomm: dragonboard820c: udpate readme
[PATCH 2/7] clk/qcom: apq8096: fix set rate for the uart clock
[PATCH 3/7] mmc: msm_sdhci: handle bulk clock initialization error
[PATCH 4/7] clk/qcom: apq8096: fix the sdhci clock
[PATCH 5/7] configs: dragonboard820: enable GPIO
[PATCH 6/7] mach-snapdragon: board interface to enforce fdt
[PATCH 7/7] board: qualcommm: dragonboard820c: external fdt

