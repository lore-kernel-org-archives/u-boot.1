Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BAEC5AD49
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 15:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22D458309A;
	Thu, 29 May 2025 17:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eaEgJMjZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D52C08309A; Thu, 29 May 2025 17:50:09 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71D34830C0
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 17:50:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TC1s4K014821
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 15:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=fyaaT/iHh1I
 F8YkvJjbZmYIYQNArGa6aorgbQizOh5o=; b=eaEgJMjZOJyrZsgNNW34C7B6NPB
 0gcGpJ2Ff2/C1dW6+HtCMb/MFf6gd7xKNbChGLFSV78U1koCXXToHLfK7MukeZOP
 Lx04dVzNO1IkZIzb2ya3srLEjf0FMdFWtXTiGpe4kQeuJm+ERQ592OhrEKmbLrOT
 EWbkfZZe3iM5sDdKle96VINTENF+h4a/Ft1o8kz1C0yVwJ4xvRWHHlH5ynDe1iNx
 yydfXwlNZeHdWxIPgNw0k8lO/BrEmOhbY6ASRIJz4ZicdDcMZR+Vq/aLU1p39+a6
 zB3V6HmLsHx6PiNqrEmfwVgZbH8X8Xiu6JTywIlc22s68/XagVRLxC1Gp4A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46wavm02cc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 15:50:05 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-af5310c1ac1so764143a12.2
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 08:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748533804; x=1749138604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fyaaT/iHh1IF8YkvJjbZmYIYQNArGa6aorgbQizOh5o=;
 b=L+F6GzZDaDrnxsiQ5TRwDIIID12Liy7SRCPZGtha+g26eacKe9eyS1tFXJU9OZztL+
 8+LNYbIQMNzMO0E5qts23DwOMaRQT1ahXvg1i69h9Yy7fNSQZ/GnsMNW6sYAZcXKgSdB
 qrYNuqifsOl1aeaqMJRTSKoW/x/89lvz8s9F94ciY3Iaml5sRDnxcesj6LZiR6CRT7ml
 lR/7nMGiqYPeqjxp21ug9pNfIfREKxKlqd9kEXeMCHNaNRutdZEbqI4r/vVPyGZzS5pU
 Bh36/1I3iMScEwnEb01k4GYt8/lRObNN17h8bpry35UuGSjhs3PpNqqfX2nW4VILkv1i
 WzGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj615NwSfFQQ1JcmZZstpbxhCOI1JRNV8nOQ8fZmQKQ4okwIrLx2yK3vMekHsWBseTQsqr+sY=@lists.denx.de
X-Gm-Message-State: AOJu0YyPYEX9fXQQL4Ddl8Pp/cnS/FsdkYQmpDSQSf+qsXIPMGA6vQFG
 bl5UDd7Dkj3nlyhV2xsf4pV+WvlEhZAKzkf8nlt3lJpDzErcd+xq952DaOc2sGcndxxkm5eiUd2
 5+zTyB5Gk12XIXWlEqQZ4VdCau0QaRjlEGQ/RjP6AeVGglnZRK/OVTjvh
X-Gm-Gg: ASbGncsc86eNjMThzXPulJgbCkobZ44Sy5Z0qfzF2y+kK4PgrseAqaxKEY0LoO8A1qr
 09pVdv99BnGReOscWmOYd7MpmUtIEcqwYoMXH4+eiQkk1A4gdMRmD/7ceIiYS6VtWvEpYq1GfF9
 zyYYm0CIqjWlZqXYD/O3VmI147asow5/FUSG3m6SlyfKC4KZJaaAme0KwFSEpZQwYEMZZIOe1xb
 j4iDkMPG7ynsjVjObzw1savpWp01RCnz2pCIkMljMAGUOb85wDGQldUoxwUk1gh28cnzxaY/7DP
 bZqK2U2mnCIlXK3Nn/DvYc1DLtxozOxG5t/p7AOxccTrZ6eeFJ83JzxmKHOVk43uoUkSGqJ4oJ+
 dGUsxc+VIrnC+uf4ZaTdZXJxX8HY=
X-Received: by 2002:a17:902:ea0f:b0:234:b41e:37a2 with SMTP id
 d9443c01a7336-23528fedc2bmr1614235ad.11.1748533804498; 
 Thu, 29 May 2025 08:50:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhz12It9u+wZ9OZ+W0aG03Feel9HhT6WHA3ksjzbeEZ32YFHxEfzRw0SlPxvfh+iHdwM3AgQ==
X-Received: by 2002:a17:902:ea0f:b0:234:b41e:37a2 with SMTP id
 d9443c01a7336-23528fedc2bmr1613865ad.11.1748533804136; 
 Thu, 29 May 2025 08:50:04 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506cf5448sm13879045ad.185.2025.05.29.08.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 08:50:03 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Google-Original-From: Balaji Selvanathan <quic_bselvana@quicinc.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, sjg@chromium.org, lehmanju@devpi.de,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 5/6] qcom_defconfig: Enable QCS8300 clock driver
Date: Thu, 29 May 2025 21:19:30 +0530
Message-Id: <20250529154931.1879976-6-quic_bselvana@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529154931.1879976-1-quic_bselvana@quicinc.com>
References: <20250529154931.1879976-1-quic_bselvana@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wwc7s6CwAC1HJpASRD6VobzogZOhhm5f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE1NCBTYWx0ZWRfX9/Tf27MgZJig
 +m6TN+XoWACwIXu6VK2ZMhtSFrOMENYJAjLmGuONeRNguC71RFe8slq/6Fg/hZJJGdhWf2JzFvE
 DYdj8n/z+/+vIJjJrZ754ZztCs8Pvdf4MfBta7mE/TOAkgQ5niDMC363EL+49/zD7Xk7goL44fR
 +a9i+TlCO7AQ+1mBhoN16vaOHtxjUxSON3Jtf/w2sMgL+r1Q0c4T3sPedEqfeA7oOF/a4J2Nf10
 hkhXL0KpSNytxNrVJtaIEKf8pFyMh7kvuXv6mvHFGHO3VNwS6Zm3OzBW1kNCDU9CDpiyAg9cR+r
 u2A6pp2G6RDd0+foXhjgiaUkqiDNRfruxZkUZAX2A8q1sOnh2OzxbKAQHbDA6xLyv/e+0kw5KK4
 KkFtHKP9xW2cOSi6uUFqEscQEDnCI5bK/0M693Rr9EPKkrFji1tX22tva8uUwPihMwmkjeiD
X-Authority-Analysis: v=2.4 cv=fMk53Yae c=1 sm=1 tr=0 ts=6838822d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=yiAYSNrAowt6Iz-k4CwA:9
 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: wwc7s6CwAC1HJpASRD6VobzogZOhhm5f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=771 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290154
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

From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Enable the QCS8300 clock driver in Qualcomm defconfig.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
v4:
- No changes to this patch in v4

v3:
- No changes to this patch in v3

v2:
- Arranged the configs in alphabetical order in configs/qcom_defconfig
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index b8399701da0..fbbf82d947a 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -51,6 +51,7 @@ CONFIG_CLK_QCOM_APQ8016=y
 CONFIG_CLK_QCOM_APQ8096=y
 CONFIG_CLK_QCOM_QCM2290=y
 CONFIG_CLK_QCOM_QCS404=y
+CONFIG_CLK_QCOM_QCS8300=y
 CONFIG_CLK_QCOM_SA8775P=y
 CONFIG_CLK_QCOM_SDM845=y
 CONFIG_CLK_QCOM_SM6115=y
-- 
2.34.1

