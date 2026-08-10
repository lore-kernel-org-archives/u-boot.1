Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3ED3C5AC82
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 09:35:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3AB1A40589;
	Mon, 10 Aug 2026 09:35:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YR9HbGEk09yS; Mon, 10 Aug 2026 09:35:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B35C740560
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786354504;
	bh=LE5Vx1Ll0Tu92kmD3P4lWWKHO3drEYADo2C2Kg03Soo=;
	h=Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=KkKuMXNxakOJli8u0iFknS2yYH5pbmWMPMxJa6P8A0GZFmsEXHuEyD/qQ4NxvI4MG
	 /L5mdmeryRXy7IzwaFpZW88qtQxvfyL6f613URA3MGRZdP0fekb3ftWIhmeEyIRaw1
	 /INUiEU9VBaJ2CQWYxbJiRQ/dKNRYAcbN+DvFkIc0Rm7k5s07HX+UuTqm8IePBTmL0
	 MBAbl/ddwyeJbBDV5kXmwmi2dDnRn8myRradAGhhJwV/jRMHyjyrF9e+gvDSOBsfKc
	 swGRmq83AIyxm/mkF5UJlQZm5FkOWkQrZQm5Lygvkq8u49ZoKXQOiYXl+vRL9djWtQ
	 NynLGsbZGpIoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B35C740560;
	Mon, 10 Aug 2026 09:35:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 82A9C282
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 09:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 808F96065A
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 09:35:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8ousE8KccScl for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 09:35:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 81EAD6063A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 81EAD6063A
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 81EAD6063A
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 09:35:01 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67A9SD111119428
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 09:35:00 GMT
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy8v6rqrb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 09:35:00 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cf6acd760cso22939685ad.3
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 02:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786354499; x=1786959299;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LE5Vx1Ll0Tu92kmD3P4lWWKHO3drEYADo2C2Kg03Soo=;
 b=YTPBRr20IxTC+GZIwofYApTNH+yIy6UwWXeSMNKCKhmW2Wu9vuObDdYEyIDj0gg1kT
 N6dMNonBOkmgoiQKQ316COEqtJT0skaDQAWW3jREBh6qJU5ibPRRFJUfCbj3yuVSYxxf
 htd9N/W27fitkmLugWjxj9F4+AEhI7MZtJ97CF+t8TXWlGTtBtZ4H/INqx37KS8ohm4c
 UAjmWBwLSrLKzh2YSQzYEXJSTaKk4n4uCtWXebGqMn6JFV9WZJn//2xvJ2xSf0hzAJXD
 OtOt40wA75AD/7AgG0QGmbloWqjJybpGch2mYszK6c1hex4v8btKzL/4/BJ+C+UIFDYS
 T+5Q==
X-Gm-Message-State: AOJu0YyXLeQk3mcj/O5xZl0Eevlj0PFzdFxTGJLEzlN39KLqLG5GT1e7
 MiFHTyW0dkE2ifgYA7KNzagIt5kdHOdMVpEWKffvqjU9CiYBMPm4EehW98rnNNsmCVVJiTTcQFB
 o1C8sUPDJriUHQM8F/MEtdzeZh2kJz2pl4pfVjQ04lxmjl5Isegi8wdYsEZI5aa0HwZkJdqU=
X-Gm-Gg: AR+sD11R6VlJHAiSzFuZ47ZmbEoee3e7O34F5D0W7xA5rvHLyVCxqOHwBTM8yw2Uujm
 4xcyZKuyNDWs6iIBkNhqDxGbXa8RV6i5qSuj2i3JqtSl47lH8zEUuJ/F1d/tZpBBkmtdQ6paUtd
 2FP/FCSCnMoZBrtZQlMP2cShSTOXRJeDLcFh3q0fSH9jtIpuy/YYG6GyUrPUrDWVgoOmSqYs0L6
 dXSCtiLPkY5dbL4f2wLe55mAUBD8TKo4na9Nh1Jf7QvG4zA5HQrJbVkcSBT248+GCJQi2RQxuxZ
 qTc6YjV6tNilX2MmkZSqPO/6jXGXFmXu3qu8U5rj/hGaKFyyFNXB7pWwxZCE/YKFZScq4SqQ6zL
 TaCld0HJE+O3E86UNUVONnZ3zn4C2ObrHtYpMTQ/HWs1F/fDN/z8S80jCs69YJoUn1mF3u5PTDv
 RiumbuPco8ZZD65+CSJICrBYW9hI/0
X-Received: by 2002:a05:6a21:7a45:b0:3c6:3c5b:f2e3 with SMTP id
 adf61e73a8af0-3cc1a38a97emr633039637.33.1786354499308; 
 Mon, 10 Aug 2026 02:34:59 -0700 (PDT)
X-Received: by 2002:a05:6a21:7a45:b0:3c6:3c5b:f2e3 with SMTP id
 adf61e73a8af0-3cc1a38a97emr632989637.33.1786354498819; 
 Mon, 10 Aug 2026 02:34:58 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14101b95b20sm33467099c88.15.2026.08.10.02.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 02:34:58 -0700 (PDT)
Date: Mon, 10 Aug 2026 15:04:53 +0530
Subject: [PATCH] boot: image-fdt: suppress spurious error on expected
 reservation failures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-suppress-fdt-res-error-v1-1-e9641eb0aadb@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADybeWoC/x2MQQqAMAwEvyI5G2h7sOpXxIO0qeaikqgI4t8N3
 mZgdh9QEiaFvnpA6GLlbTXxdQVpmdaZkLM5BBca13qHeu67kCqWfKABksgmGEukJuYwdT6Bja0
 pfP/Hw/i+H3XFTmJoAAAA
X-Change-ID: 20260810-suppress-fdt-res-error-7f7e67d2a91c
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Randolph Sapp <rs@ti.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786354496; l=2209;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=16Rjjd8dWFSXMYquzFo9CWz3W8HsrJxXCcTJbHTv9eQ=;
 b=ke8gMcMBCWmK55gOMDDBWs6ZLoOLcwoBT/gkA9WKgB2MmmON+IiPiplT+YSayHe8TB3osOfkK
 yHugTMOa1NiCBzjqN+JWenfHjQmc4jrvyE8R1Rs1MilpZP2AyBIJ/aN
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA4MiBTYWx0ZWRfXxAtgw+hkc3nE
 zS12Zq5ZNp1AO9VxHMN6/i4ivZcfqH0+Dlcnxb0/z3l6WOVbwEut9P03UcaXop+U2VwdWBIzZz6
 G1dgB+Sz8HKC5n7+Ny+yMu31gd4XRxQ=
X-Authority-Analysis: v=2.4 cv=PvijqQM3 c=1 sm=1 tr=0 ts=6a799b44 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=qTihPGgffPgmkg78wwAA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA4MiBTYWx0ZWRfX3OgBKG0FTTBZ
 tjzYFZCmpCOT0xY/mEGX3cFCLMnfMfP7W8XlbIQVrKKZHPbyXkqWO8+CxYbbzVhKeE4x9+JLxat
 V/Vhyo9n4V6htawYTbOKymUPHg/VAp3IBCwYiwiMa6C89mMlWF1rkLAvkgmPshrXtBN7f1R8SB1
 tFYSdbMdgcajlX2fSDIcgg4diH4aJ/YZOFG1KxKknTLYRBlM11o7moMkl21qKMjF+iteMfGFDWH
 oLn3RqUGjog3xkBlwrT44GC/d8Mb96vdx0DmbguF0KxFVhQzRrNAaLn2250T1PTxovbo2R1K6X6
 gGkZVFolzZGyVuLwIvN3nYYDTghe4zbttLNxu5ynnZOAizAoHvVwgaYVmgR8dlg2o/uRtJo/rNR
 tJNIgkxoPjAbUgQ5o8hT3HpBXZroDl8VQmEBjDPROOgJCh3JOVaC9pv8Cjo5RdpF7jSPO59cAFz
 1jbV0vD4kTaO9w7JAAA==
X-Proofpoint-GUID: Ph9QHh8M-p52OXGzUEnfZGuGZiqCoe1E
X-Proofpoint-ORIG-GUID: Ph9QHh8M-p52OXGzUEnfZGuGZiqCoe1E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100082
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=LE5Vx1Ll0Tu92kmD3P4lWW
 KHO3drEYADo2C2Kg03Soo=; b=VkT1TgaEKDZev7tRE9UwOlCyKp1OMt+mGV2/kd
 CJl7jWXt2FE8ozrJXmjVW0/8/4Zc8Fp1FfCUbiy4VQehmp1yr3GjyF27HnYXZvbM
 ASDzt8DcX3XYsezV0OAeXgZi6y6KoGecSGcIF37JvThfp3u9vJcYXHwqboI5Gqr+
 AA7RyoNSGFryPRd292QB7VkccchmQjNSk+1AITSCPqLlEsddAuV4x3hdyq6Iq3m6
 gIZUBQmrEjD2K1hbdbuyl6AWKsXHSclZQTkrC2yzdvzp6/91jgHEbu2z0w7gbX/2
 l5C0xpMkXbd+PPv1b56qEat1GNCGVsRKxSI43sTj5yVczoiQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786354499; x=1786959299;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LE5Vx1Ll0Tu92kmD3P4lWWKHO3drEYADo2C2Kg03Soo=;
 b=OSTOpwO1FFo9m7OIeN3EP2vUcOWP5ZNrvYBNZuLQOnMqC0PdZCHlya4W3bIMsk//Ck
 x1BquDgulGvJ+nCvUa1d/7mSPTakEvTyXTePHY77/F5KLEWG4k1K6zgqoZAvjeSD5eSy
 odSYcadDgijANabXr/LckcPyRC7xXBvexHhShN11IwfClUuJ5WevTnj9KGJtWurfTM+C
 etefUvVlP1+c7LyU9B1bddw8q2aQQXgZ6HWFkOcoZiXHwjya+1wbalVts5nxUkKltJIw
 V1zJQfugdHO7XB9KfNCpl3kxOMSMK3iCpFpgkE1tocdu18gNCjLh8UtnJT4LjBHlsqvI
 Cu0A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=VkT1TgaE; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OSTOpwO1
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Before commit 623f6c5b6ab7 ("boot: image-fdt: free old dtb
reservations"), boot_fdt_handle_region() filtered out -EEXIST and
-EINVAL when reserving an FDT memory region, treating both as benign.
That commit added the free/reserve toggle but dropped the filter, so
these now print as errors.

-EINVAL in particular is expected: when a reserved-memory region falls
outside the available memory LMB knows about, _lmb_alloc_addr() returns
-EINVAL. This happens when a carve-out described in the kernel DT lies
in a range the platform does not report as usable RAM, so its
reservation fails with -EINVAL and prints:

  ERROR: reserving fdt memory region failed (addr=91a80000 size=80000 flags=2): -22

on an otherwise clean boot. The region is still described in the
kernel DT and Linux reserves it itself, so U-Boot failing to track it
in LMB is harmless.

Restore the old filter, scoped to the reserve path: print the error
only when freeing, or when a reservation fails with something other
than -EEXIST or -EINVAL. The "free ||" guard keeps free-path failures
always visible.

Fixes: 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 boot/image-fdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 9e0e0f93edd..d4a588ec164 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -95,7 +95,7 @@ static void boot_fdt_handle_region(u64 addr, u64 size, u32 flags, bool free)
 		debug("   %s fdt memory region: addr=%llx size=%llx flags=%x\n",
 		      free ? "freed" : "reserved", (unsigned long long)addr,
 		      (unsigned long long)size, flags);
-	} else {
+	} else if (free || (ret != -EEXIST && ret != -EINVAL)) {
 		printf("ERROR: %s fdt memory region failed (addr=%llx size=%llx flags=%x): %ld\n",
 		       free ? "freeing" : "reserving", (unsigned long long)addr,
 		       (unsigned long long)size, flags, ret);

---
base-commit: 28515d7ff5285e0b942f15577e3198f15c667a25
change-id: 20260810-suppress-fdt-res-error-7f7e67d2a91c

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

