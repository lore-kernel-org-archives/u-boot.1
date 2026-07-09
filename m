Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2563C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:57:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 058CC8484A;
	Fri, 10 Jul 2026 14:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QaxravnM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qf8QV/ft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1251D84BF0; Thu,  9 Jul 2026 19:56:23 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3EE184B86
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 19:56:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rahul.pathak@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HX3oc2295172
 for <u-boot@lists.denx.de>; Thu, 9 Jul 2026 17:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Zxdxm5TVsg3
 TRAcjXePs5oB68FZvciUKw23ccXqB0UU=; b=QaxravnM2qg8Th0rKcYP5ATBVrb
 KpIcENqiYH7kBuWhmSJBh54qkRGnx4//VYWnco9lD4CvN/BZYcJs/Ipl4BVWaSeg
 j9FdcLXlWHeN5MilcOVpFNKauWmGoOXMqt13VOIXLifVZE24aGEVPnTc+GJBdgid
 wQlTVjfceKHTal9wTe2C0WOTieDF59lGXcptXmrZTMcbOqqFzqkmrj9quAG0/D3/
 FOAWvFdwcukFR8/TcnKExBYWiPDRAXwtrHmMifPgRZYdpRSwxYpvkYPiRDItr4hd
 11IIrJFHnbIYSXPrXy4uollxW8fvxebJioifkgS2Y8Mm1ViCBgBugvSgSOQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa55vkh8y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 17:56:19 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c860544c077so214740a12.3
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 10:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783619778; x=1784224578; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zxdxm5TVsg3TRAcjXePs5oB68FZvciUKw23ccXqB0UU=;
 b=Qf8QV/ftFxwAoh979JX8ZUbs/XX6s8m/MJVy0mWO+KHkAobHPI4oA2k2qKaqPb62ac
 m3Txm4t5EcOcPFZ4DsFGsnikGwx18UfbIGLcCUbc1hYg46LNJeb+4EwqBeRgKhG7Y8w2
 yOklbsTZ5biWwmtfmdhcCs9/080bVL9XFeu9EN1rwz97pkOrCaKPEOPzIaPuzSUvg/Vm
 z8ZynM97P483nIyyd+kL15hPsGZvrqTPrul7stjIUfE4L5tPDK7LEjgZHWUMQhG44sRv
 +c8Np8k848lM+eZ+kECvUQpzCVFz34m3f3HUVGih+B0eMi1sLLk3NZeTvrm9Z266IBoh
 zetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783619778; x=1784224578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zxdxm5TVsg3TRAcjXePs5oB68FZvciUKw23ccXqB0UU=;
 b=hTb4WQwfwjSj9bS3ggJrEyeAzdPhE7/+Scro8e2nMHuW1hCeuT50UwE6p0Il3UDD6P
 eBCQU2P7/d8HB2X/RI5L3bozfs7/mQNR7/BLz5vklxLlaqdrTnpI3P2kIpGrPBVVD2Ap
 6h9rHCeNiFgSXBmbWaUpOyK0f/RNeNaK+JmhoQHiidFiyPaGIAL5i4Ct/jTTPBX1xa2G
 v5EK0io9sAimh2Tq9ygIGfzuR0Kv2uOkIOdd638J8cJ9Chb0CnSvPCEnU2kfaIWe3orp
 zasdVzZLkXo7UpY/eJvoj6vFN997kYi+RvDh+cCAdQ4s3gmnbhvmem3hQ7pH07mrQ/VR
 294Q==
X-Gm-Message-State: AOJu0Yw440HP62Nne2etSY00FKZ0epbMUh8cvVzlGX/5Dj5r8+vct6dN
 qDky3lUEOMeuSPdRmOlP6wLm++JmomWUcOImQq2ro9z8jEsVCkWLoFWNvp8N7aKAhRyc/X8KUQ7
 zFvdHvCIiBppeWbB1jMKt6VfzKGrs812U1gWH+wtyovkij04+W4SEDcm8ge77DSw/
X-Gm-Gg: AfdE7cllbd/Cw1lcNwT65phpau9BhIXg4drlePg3zM7vx9TOjqF9aaVseLTMuVxH+CP
 3fdeoCg+yQp9EtGIS+3x8gRRid63OMEYSDxuX/m2/Bv19urD0bqnPOEeRn4HTXgfhmzEmQIRLH+
 ajc/VFKhwAeBlh6gKbDFEoDlulyCAsm/QXIxQ9jwo5mKHxSOQiB37r7upMqBgFm3qGE/OHvDYps
 LxCjfRikC4fPBnYT4Desm8cKMmtZtMlCcPStpr/4VUaZYHcgZbbYISEx6/LtCncetCwA/fKDw84
 LLyjAe5bsyo9ubmAFvnkKo8H244DTjnrti5WjPJ2GoYSxawtNb8uuQZbcUCIyEwgz5iXRlt8Ofz
 mRqQIx6wpNRbL5qZPiRi4cuxjoTqa+WAhztAsoe6h4NpCaR5juhqa5OVeWHBY9lQAyIQEmGKc8M
 yZxu8Lt2AsvDr1dcGEFd5WUuU5NT6yVWc=
X-Received: by 2002:a05:6a20:431a:b0:3b2:8685:1473 with SMTP id
 adf61e73a8af0-3c0bcf15d9amr8805565637.7.1783619778490; 
 Thu, 09 Jul 2026 10:56:18 -0700 (PDT)
X-Received: by 2002:a05:6a20:431a:b0:3b2:8685:1473 with SMTP id
 adf61e73a8af0-3c0bcf15d9amr8805547637.7.1783619778068; 
 Thu, 09 Jul 2026 10:56:18 -0700 (PDT)
Received: from hu-rahupath-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174accae5sm51523828eec.29.2026.07.09.10.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 10:56:17 -0700 (PDT)
From: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
To: u-boot@lists.denx.de
Cc: rahul.pathak@oss.qualcomm.com, anup.patel@oss.qualcomm.com
Subject: [PATCH 3/3] riscv: Enable SBI MPXY core interface and MPXY command
Date: Thu,  9 Jul 2026 23:26:04 +0530
Message-ID: <20260709175605.1070755-4-rahul.pathak@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709175605.1070755-1-rahul.pathak@oss.qualcomm.com>
References: <20260709175605.1070755-1-rahul.pathak@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE3NSBTYWx0ZWRfX9ywU/5HweIuF
 p4Q2/ePoEIOEzb/1mgQzS4TLp5iTt60uIWXpkeLl0ZoxEq134Mi0aJZzo7/KDbJEBcFLpRRXLIw
 HP6foIjsbqg/qcl/gdQs66kC8u4/XVvXicI5Ps/eKaXAsq++TUNVWIIyBrq7t/ULd7TY8tqjBZd
 6flWHzd1EImbTb+YXOZMqTbTYEqNR/WX7vTocPgniLJFPWg0KNpxlYTn6Q1N/OIaLK3rzijz0WA
 u0gqT3ul5IGY2betuqLpK/JyyTt16Pw1BAxI8rHy3mwmjDU8vdSqafpfzfn6/LcquiHCP9Pxwjo
 Z7AJpRUUANbtg+dPCFvub6Y4iH7P2cPCAXABsMqAv3+T6F9Eid6Os2PRoQXPE+GsmE0fraaqk53
 LhsTvbQuveYAmtKwa5MkgDQ57bX1+5K0tdp/c9Hb7zai7qQHX+PlVvhkRb5fL7FZGfqNeHYgfdY
 LpmZuqaBk5KouzM5N/g==
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a4fe0c3 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=asErNQHET0HVgYpMWa8A:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE3NSBTYWx0ZWRfX2aUJAUC6c7B/
 jUTZVngNhYS7bGEieYYem4xVIl4eofHxP9JDrspWYk0sYhoBHKJQLBt0YVkJU1vZjMmHgBhZGWq
 9lZjpCGO+8qT8GAldC4JlZKoDDd/bIg=
X-Proofpoint-ORIG-GUID: rorWjty8FfvX4icznYXcJd4skUIvCAdj
X-Proofpoint-GUID: rorWjty8FfvX4icznYXcJd4skUIvCAdj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090175
X-Mailman-Approved-At: Fri, 10 Jul 2026 14:56:43 +0200
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

Enable SBI MPXY interface implementation and
MPXY command for riscv platform.

Signed-off-by: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
---
 configs/qemu-riscv64_spl_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qemu-riscv64_spl_defconfig b/configs/qemu-riscv64_spl_defconfig
index 04dec72ceac..5235b8a6cc6 100644
--- a/configs/qemu-riscv64_spl_defconfig
+++ b/configs/qemu-riscv64_spl_defconfig
@@ -25,3 +25,5 @@ CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2
 # CONFIG_BINMAN_FDT is not set
 CONFIG_UNIT_TEST=y
+CONFIG_SBI_MPXY=y
+CONFIG_CMD_MPXY=y
-- 
2.43.0

