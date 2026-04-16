Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98AC5F88090
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 07:04:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63B498423D;
	Thu, 16 Apr 2026 09:04:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RcfH6dgo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eFmlKunO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87F708423D; Thu, 16 Apr 2026 09:04:09 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4560684227
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 09:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G1huZH862148
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZzGLSXqbT8z
 69Hf1/36j2DkRicklfRFY1LAZVUn+Bog=; b=RcfH6dgo+TAA4xcmiGSnfVvwGfs
 TYTQzNImtQYhA0pWnVTClOj+LPd451l+eoy/mNsRL2Cp/VAR26dLRvBZiU2PlRvJ
 MDIROPMznmtOk2G3d6DmQZD9uHiQHAT50QLBu2/JaC0sgEpeR0WcmYiW1orbqw8K
 ASGlpER+wn2WS6ufm2TEkvQx0/T/5n/dxt8ySXuTehAMNuwX03+K2aqbYB0LQhwB
 14zoLDAZz7b2oXBJ8t6GhqailwktcaKUO01I8oadjANjG8lei8IT49Bb0hPG4fIB
 eT3DmL2nemy+o61EVE78pmnvU71TwDhZm5603/ZeNhWuRfuSq17NQzadq+w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djd0eaq00-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:04:05 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35d99c2908cso7352852a91.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 00:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776323045; x=1776927845; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZzGLSXqbT8z69Hf1/36j2DkRicklfRFY1LAZVUn+Bog=;
 b=eFmlKunOBmLF5TDGEAkyeb8umHaxuWQCS3wJe7HdJLG+OEgT8hmwNp9oG4MnUB4ZFH
 S6FrlxWpJlwlg4TRZipx1iMHd3g+cOgVNRQsAJf/olh6hOcsSXXMKpATg4ynQgQmISjN
 dFVhFRgWK1mRp3q/5VJSj12ycV13A4k0O8Z1K2f6wSwyO13tQztt3BYzQChIaQAsqfGT
 mviJKnxQDMf0Xz4Eb2QGkmFDGZzVy6btr/YpKT45tNrrGurY+3kVzVFuygWaJlFGA7NW
 u5qh7BVqXzdzFly//C3p0ODyoWRREcclE/BnDS6pGjq8zowDOHpaYzrlHNs8P3ooW8m8
 sulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776323045; x=1776927845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZzGLSXqbT8z69Hf1/36j2DkRicklfRFY1LAZVUn+Bog=;
 b=VFsDo+riaLHRjMSN9ktULKjVTv8AY2E8u36ZfvO8sGLWHMbOAos/0YrbFXeBcQ/nid
 yIlFUFcgA5TCs6zDS+efIHlzsTqUA12PCwvQbNzCnPpj8RZHnoT7RyE2YypCKnsxPjwD
 KsXs42u3b85efkaAWi01gN+yZK9lIHdkdwBsuq4RJe2khUedm8fV+/Tq6Hto1+qjijqt
 NdzHxXWeVdd8ZMlbEFL5EqhlcllMbSQjeV2vo6eifpv7R+zIGBajiTvgKKc5XYB3Vck1
 cDf6SJu2TC/lGaKaYbIWajhlOe4+U0RdBVhM0GuCBkC0X7kW9sA8S6DOs2p7yMZzZIGu
 kKVg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+WMAfD2OPWMctBDxCOsYt/wg8Zvb6kMheFUWVbDJFcrBZfGk8aihRvMh8m7RRjvWa2Z6f/6Nw=@lists.denx.de
X-Gm-Message-State: AOJu0YxQZycQ6u+z8vZAHMEOVFmI84d2sHgKVt6+sVhCT+8KAM2XIGlm
 IIJ60cha1oyAJ8ri5BpkuQwT+6E+o+nckZad8TjxVvOLSg6yLyMYPB4VqjCJUmp6zMJgMCo+yla
 aXz/dhBAINBWS33llxUmc55tXinUm8yqqJ32VSUOC22nIZJqD/ubz3Oub
X-Gm-Gg: AeBDiesfWIIK9/9sJ19nid8wbID1+Ds+8CElM5ht2fprp0uv9NiYjuEJuX+3+uNKniH
 UjEFsSmSRORRV8gSXydwynHK/Lmp1AsZhtaAjhWjLuu5L8fj2FbaoVy8yAMjPS/VcJXjpgAwoZp
 8bJJaN7hOSO+zyw6Qj7GR1FMTR9PVMWYKNKzOW0unmHdVFgYFPvqOtKIiHmIhEZqtGPlk5LbT1V
 0T2Six05GfTFK4hXSUB7oWpK+HOnSqBRQ0bqEu/B/JGgY0pLH1PFRrDp+anT0K5c6/c+VItYZbP
 xy3oX7JYmOZg47XL0eRDJiur9rEH+7z420pax2ZQPZgKRlXvxhkMc+P80aJM8kRZ+rtxy5ESuAC
 wb591ifBanMph1Rsfma2z3nSWnoI3bN6nlDhdKp8ejX1Kz+r6FbpW0QDI+Us7QafLmvenmgqQvQ
 lzuVGB7GFEbkNWE7K0kqCFh5KlhSIvt7dMJHfU/s5SIbJ4mzvOVWU=
X-Received: by 2002:a17:90b:388c:b0:35f:b572:ece3 with SMTP id
 98e67ed59e1d1-35fb572ef32mr14782793a91.6.1776323044766; 
 Thu, 16 Apr 2026 00:04:04 -0700 (PDT)
X-Received: by 2002:a17:90b:388c:b0:35f:b572:ece3 with SMTP id
 98e67ed59e1d1-35fb572ef32mr14782741a91.6.1776323044187; 
 Thu, 16 Apr 2026 00:04:04 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b4782b1174sm54195255ad.70.2026.04.16.00.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 00:04:03 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, aswin.murugan@oss.qualcomm.com,
 simon.glass@canonical.com, tien.fong.chee@altera.com,
 michal.simek@amd.com, visitorckw@gmail.com, clamor95@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v7 4/5] cmd: boot: Add '-edl' option to reset command
 documentation
Date: Thu, 16 Apr 2026 12:33:29 +0530
Message-Id: <20260416070330.3006528-5-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416070330.3006528-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260416070330.3006528-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ye2Kkmm1T1p7JoW62KLUl34eNT1Yz-RH
X-Proofpoint-ORIG-GUID: ye2Kkmm1T1p7JoW62KLUl34eNT1Yz-RH
X-Authority-Analysis: v=2.4 cv=GP441ONK c=1 sm=1 tr=0 ts=69e089e5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=Mf8A1FuHfXW03_C84bMA:9 a=iS9zxrgQBfv6-_F4QbHw:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA2NCBTYWx0ZWRfX3kUrmXF6CIgj
 iXH8+Vh6EGAVcOLjKR+2YjmjwOub2hy5dAYLX2ebnTUQn73g/0uXeB7TXvLMFLm5rfBEj4LZEiA
 J9znRTmiVQMgSwiMlghn0OS+yMcs1Gq0vekiZKpsnJuFqS+MshiXTzqMYfOLlYS+Hp8Ht/yv3TR
 hSgb+fK9jzs5YCcg8hE6QtiOia+jDrLYD+PnXO938miXcpmIucJON3puV3Q7i9/74L+IawcGtlU
 vsP62AuIsT2msJtP4bpnaizthO4OtxykjlZiRvZk1YD9VzXATu90NO2TWXanvV1j+jPM8EIto6z
 aXnI0VWf5qkb+xEG80oc5+C40zThrT+OGXuu9R6iaabbZoQO8OdLHJbb3wenTWZY+NmUQFNBs0f
 sdXHZdiWJPK7iH3yg6vRatKha/W4pPTvxQjzVws1aLIy2k0GS4xPSo4Zl5JSofGAEwDV5ZEYbBq
 y8qekoMqDOZdhCvPfNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160064
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

Add help text about '-edl' option to reset command definition and
related documentation.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 cmd/boot.c              | 3 +++
 doc/usage/cmd/reset.rst | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/cmd/boot.c b/cmd/boot.c
index 23496cafdf5..d80f9d8c05d 100644
--- a/cmd/boot.c
+++ b/cmd/boot.c
@@ -60,6 +60,9 @@ U_BOOT_CMD(
 	reset, 2, 0,	do_reset,
 	"Perform RESET of the CPU",
 	"- cold boot without level specifier\n"
+#ifdef CONFIG_SYSRESET_QCOM_PSCI
+	"reset -edl - Boot to Emergency DownLoad mode\n"
+#endif
 	"reset -w - warm reset if implemented"
 );
 
diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
index 126db21cdb8..366b17eea16 100644
--- a/doc/usage/cmd/reset.rst
+++ b/doc/usage/cmd/reset.rst
@@ -22,6 +22,8 @@ DDR and peripherals, on some boards also resets external PMIC.
 -w
     Do warm WARM, reset CPU but keep peripheral/DDR/PMIC active.
 
+-edl
+    Boot to Emergency DownLoad mode on supported Qualcomm platforms.
 
 Return value
 ------------
-- 
2.34.1

