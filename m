Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C5FC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 666D284A92;
	Fri, 10 Jul 2026 14:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZrrjsjZx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X82CntZk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B49A84B72; Thu,  9 Jul 2026 19:56:17 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B25584B72
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 19:56:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rahul.pathak@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HXms82474053
 for <u-boot@lists.denx.de>; Thu, 9 Jul 2026 17:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=RmjqbiSN5WvW1vNKveYgn/Fgh6v2z9sBuht
 CS1On3S4=; b=ZrrjsjZxJFliT2JtTSGrzBU/CRMhkQlh4j57c4m+w6I3sJ+c1l7
 7lCszRZ7sYZIlCREmJ98zuCtxdKQ9hbXN/hyoInSjdNE/A0ir/T65Ib+9AHttRUU
 ZbwfsOJSl7DjXZcOneIhsLrFI7g4SCMfX8dGV+5g8tsNwhHc2OwSG0mjsjQdQeyK
 RS+j2fjtK5w3iOrdNSGsRwzSOgyWeIjHxUOwRPaNUjo5rxvBkdStXYeiv5L+iYjQ
 bm6lzaZTfBW0fOwNUgoD5OIhUbba1qkMFlUJ2/W7yDR1KrXZVuHPGiWbDCVErcFf
 REFIs6wblgKeLH5QOe3gJiLTAZfe70+MvmA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4facqphabd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 17:56:12 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88da04b719so97850a12.2
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 10:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783619772; x=1784224572; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RmjqbiSN5WvW1vNKveYgn/Fgh6v2z9sBuhtCS1On3S4=;
 b=X82CntZkpOxPXH7Bp/Az3uljSu7Sa+4G+054yFqkVM1PqBsHGl8L7RkPDR5cfo1jc3
 3o2k3FsdDM6fa13YrQ3g0xyJ3zYyNwvWkbAXmH8bxt2xvHP8BuWRsTcFf7e7tagVcb7X
 8Z5d9cXfOQkAksQGUitnGoxELFnK3vmteTRirc7ixh813MC0tpNZzmXz8yLvZMunwuKi
 dOjnRF5LVM3tt5nsIuwQA86LpIeh1MRg1AAl1EFBrc8rfzgqK8IwxpQM2uoyN7wjBFSD
 MPWJ4amzTKNnAEQOTkLbVP7OrgjMcHeb1jQInSojXqIn7PN7EA+72GOuybhRmmJUeuqr
 /MAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783619772; x=1784224572;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RmjqbiSN5WvW1vNKveYgn/Fgh6v2z9sBuhtCS1On3S4=;
 b=CJIuX6ZoMnd1oR1jhl7unGEAdSy6CJQ73JXlJJ4IL02FTkN+nV4EptaE6ltakctDFu
 mjYeJ+x0WXLldnwo4rUXc20ys2gvW7G1eFJGusWAXsVwCORJxH2ubLyMLgZfQ1XSjCG6
 7x8ogOlqjy54Hh2Vr3pH3bWGn6qEwOG8jsV1yfFz9kpJjZQAVyAiGXWTyMuC4KRobfBa
 496c3q8OkA+ok+kERGxZNT0aaDlt8hxJ6Qtu28bx7i9akXdbbLZb/vJL1IjTQssheFQ9
 Fyh+BBCDKkKvzfcq6CWwuRwGF9F45e+3MjMytY8jcouSCXn3v549jg4bpqZ4gsUEXhnw
 oyAw==
X-Gm-Message-State: AOJu0YzJgOxM8Nsqj25Xu5L7b/vo+2/WFibGUc7iGdjtuqMuJ41Vaj2t
 Fi0zMgKzi9mAQa2fT+GLGh/2VJ7E1q7d65m+BDOjuJqT5IzfIUjDyvvlEEa5jaAmaE7OQgiMrBM
 pxLo/xxpBWW/9mpQ66SDSFZS3o9V3tApljal08FN4qNw39fqQ7d2bVZv4JdYnz1Zq
X-Gm-Gg: AfdE7ckZiYFmD3EZT00tjdJdyaFlK3B0yxOBba4UDfAIyTm0mhpn/mXXGuVZbvpABZS
 lWEPYbfqNl3ldxBEQ1zH2LMU6NqYXTRcOpddDXLZGCwLVXHnP3MklzZB8AkEhh/pa3AbXcdGDq0
 4PEniLx8Z1K5fSAdRJ9UjlWirqVxMxcfihETXx5GcAnTRCt/EV8ztDZ35g6uA1KWyxxQ8XqB+m+
 dFfys+qW+l9gd1S3w23rKAKV4oNJPlh/LVijJBgYalPiqidvLiLh3z7XgganpDt2QlcSkG3+TXc
 Z72+Yr6KtFZTmjF508bErd2gnGwYrWcSk516j0Jlpu+IEgNKeXektM38HJI6EdfRHFuFiy2rh7C
 sGln/bEcxNjT5l1K3yd3n22OPnMGOG7KYoC6MZ39Y5+eAx+O2r/hFgsTongYg2/0K47yTHeYtY+
 FWQ7/7FJdlujaz8J4Ut1WPCpZHhPKAFEc=
X-Received: by 2002:a05:6a20:6a1b:b0:3c0:9c19:b27d with SMTP id
 adf61e73a8af0-3c0bccf04c7mr9901271637.75.1783619771971; 
 Thu, 09 Jul 2026 10:56:11 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a1b:b0:3c0:9c19:b27d with SMTP id
 adf61e73a8af0-3c0bccf04c7mr9901238637.75.1783619771495; 
 Thu, 09 Jul 2026 10:56:11 -0700 (PDT)
Received: from hu-rahupath-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174accae5sm51523828eec.29.2026.07.09.10.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 10:56:11 -0700 (PDT)
From: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
To: u-boot@lists.denx.de
Cc: rahul.pathak@oss.qualcomm.com, anup.patel@oss.qualcomm.com
Subject: [PATCH 0/3] riscv: Add generic SBI MPXY interface and MPXY command
Date: Thu,  9 Jul 2026 23:26:01 +0530
Message-ID: <20260709175605.1070755-1-rahul.pathak@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE3NSBTYWx0ZWRfXwffAxSSISBMr
 04FgGu4O5pjpdgL564IHpqoujTilhlm+58tr2ThaRFse6aJ3XTYF+cr7RG6cIOCvtnR/XMJupYQ
 fgEQe4FlLEZlg0iJ7uepFPOMdWiM4K+umXFpDwXOClHovNi85zwkDDgkw6+3T+gNjW+qg5kkWdp
 bO/9PPXeAUvWbBPQCLTh/SaFRB68laW35QulAz5D0N+gATC8pZE40M5LE+4Gxd6taz8jneGyRXX
 fNOyFynaeoHnEb7BXmIvTXRSoiUQED027g2aqTp/z4DZ+bUQPeyFfTv1Ck8M952GFY9t5NgLk7f
 MdEbkmtHsRfelz+7fHjHV4f13d8+7dw0ee9cS+ox/hpF5U4RAQsRa+80/LAucxr9EwBMnbBicDA
 PKXuit4Fr+bGnSJ0yMd/F1f35WdfLOjkH4W7WoDMAOZe/Ot1xYwSfDefKHCsRX2RFOFoVax3iuV
 Rzo0l5WdTmhzyQxkjqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE3NSBTYWx0ZWRfX3h0Wry+z1vBd
 1oyoFBXeiBKyh0N30pB0qmvUFBTW+PjDfohmzR1NRRha1znCOgXT0a9PsNIPJQKLDp4+DGGZMxb
 7ylGeDbgucJynlu1UqFj6kBLwL8pjmM=
X-Proofpoint-GUID: KW0G1-tL0zDo3LV8RjysF68NX2enSwpN
X-Proofpoint-ORIG-GUID: KW0G1-tL0zDo3LV8RjysF68NX2enSwpN
X-Authority-Analysis: v=2.4 cv=GJ441ONK c=1 sm=1 tr=0 ts=6a4fe0bc cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=sgaI_36_ui3AEpRrNwQA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090175
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

This patch series adds a generic SBI MPXY extension
implementation which provides an interface to interact
with platform via supported message protocol (eg. RPMI)

It also adds a mpxy command which uses the generic
SBI MPXY interface and provides cli support to
interact with supported message protocol. Currently
it supports RISC-V RPMI message protocol.

Rahul Pathak (3):
  riscv: Add SBI MPXY generic interface
  cmd: Add mpxy command and add RISC-V RPMI driver
  riscv: Enable SBI MPXY core interface and MPXY command

 arch/riscv/Kconfig                 |   9 +
 arch/riscv/include/asm/sbi.h       | 268 +++++++++++++++
 arch/riscv/lib/Makefile            |   1 +
 arch/riscv/lib/sbi_mpxy.c          | 529 +++++++++++++++++++++++++++++
 cmd/Kconfig                        |   8 +
 cmd/riscv/Makefile                 |   1 +
 cmd/riscv/sbi_mpxy_cmd.c           | 482 ++++++++++++++++++++++++++
 configs/qemu-riscv64_spl_defconfig |   2 +
 8 files changed, 1300 insertions(+)
 create mode 100644 arch/riscv/lib/sbi_mpxy.c
 create mode 100644 cmd/riscv/sbi_mpxy_cmd.c

-- 
2.43.0

