Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E43C5AC67
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 05:50:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8222C4091E;
	Thu, 13 Aug 2026 05:50:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cgLDj2L1MX9K; Thu, 13 Aug 2026 05:50:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A7892408BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786600236;
	bh=qLEf3t/pDKXgMXS/tKRssDZ1oz8MXphDCyiU+D3RsWU=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=T2jHkQRQnoLYTCf9Dk0mjXD18NVie+ZgPLV8Q1LIIbTTTGr5MFW5Rf/8Z8+xVTWrV
	 2GL94tFHN44Hzot3JN7gRnoa5wG/ulkp7Dde/Nxb1yJ3ZjxctzmAobow0beU9PbzWm
	 usxJnOMf4z6ElUTH2qnkGmF/OwvS3vCnfe1dBW3FUlH4+bOjlP/E2N5RV4AcGge9w/
	 aTZrHOp7pbDtXFwNcTU17BffisKh9hPbHkEONjhfR2SaRy6NEi2awEnG9gjQMupRTF
	 hRsFxNx0i0Mdgp6iRxA1DIuK0bBlcvqwoTAoLndlJ6fd+0y8WPz60Mn0eLr+r8xn5Y
	 xWZGGVXOzrEHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7892408BA;
	Thu, 13 Aug 2026 05:50:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C2A162B2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC7F9608B4
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OWAHKqRF93Rn for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 05:50:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B0BC560869
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B0BC560869
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B0BC560869
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:34 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D5g40j2398406
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:33 GMT
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0sk43t6y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:50:33 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38ec0f510a9so4164218a91.2
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 22:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786600233; x=1787205033;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qLEf3t/pDKXgMXS/tKRssDZ1oz8MXphDCyiU+D3RsWU=;
 b=Lfx6KIHLAOwBZqmwwE9EfkjIAPgRyw+tzvU8OV2+Dl1QuMX6xXfyQK19v6JK1V4t1B
 MeUr2IK06rT/CaK01XLUuQ6JRtn3NanAQx/SxCYzm1LKVe/sI4Z+j3NCKKbCzRHjKGFY
 hLzKhunQC3IWiYf7PBD9b/3hWMI15L1nU32iBR7zpBXef5euBg0MBukJzqxYtNbyDZKv
 x0h18npMnVyCa08w95g5ggVQyuBMC5McG0OZqL+NjiEm2Mw54vIbU4ypzPx5i9WVCxPi
 tStKOmMTZnj1N4/CKIdCjWgdjKS4B88BJ9pObW9dUzvO8/s+9RdFGIt1X1TfNUvCqwYL
 +m1A==
X-Gm-Message-State: AOJu0YwHXCKJHMRCc1bpy3fB+Q9YRP9iwzNDo0ocbiXCYxsFMFSFriMj
 lmL2TS1aG0a5CWseqDa/ljz+hoQtFRDUhF8YfIrhJh2XiPuEVkqeJj7UldggEtuQbESpzZ5yVXL
 xNqTK7dmOjJoXO4IYjMdbIMqzFXMdnh6A+/KzqfplDthikRUvcrJGCWJfEyM1OfNFRLFaNKo=
X-Gm-Gg: AR+sD13eq/DB6itmkwjx/jCoz1UUOgo9EYz+9x/oFOKkxD9EB9TQx8hw3JqAGzxhvug
 Zj7xhoJ6j+2n1RcDmeZ7XiJ+mEobeg9Gx1fRd1QpemMFj9UKRFRgJS1PU7t5kdUtcd89ZwQzmhd
 4lRBH4Oiwkp+eZPTIxYnnWzudtzUbh24Zv+b1f36sLAyTwpjo+Y3ugsoppFj0z0direVwU1alXY
 AWkdD2ldH1ocq0YqTcwzlkIuLC26jDnQfvrB7PMpoCLpd5lY6F1OaLs4iGCJYSJmx1M2Y5j4KB2
 BxGoomeeEvCqCKOq61SXnuXhyiwuB6Aa5YGS3AZAitc7TShP6Y5WUXbbJsZiRTB4fGPH3sqnFru
 +LmYVe1Fw8yf9pm4oBrZy5XkxrB4x/Xp/IqAzx/JjvBypO6ZS2iz7ub7bChmz5rP4RYTwbUusA1
 Ka7005Gtxcgh/2eqY5g7xb0tRzTiyL
X-Received: by 2002:a17:90a:ec8e:b0:380:fead:448d with SMTP id
 98e67ed59e1d1-3931e26f714mr4527742a91.13.1786600232822; 
 Wed, 12 Aug 2026 22:50:32 -0700 (PDT)
X-Received: by 2002:a17:90a:ec8e:b0:380:fead:448d with SMTP id
 98e67ed59e1d1-3931e26f714mr4527714a91.13.1786600232332; 
 Wed, 12 Aug 2026 22:50:32 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ec022acabsm3402870eec.27.2026.08.12.22.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 22:50:31 -0700 (PDT)
Subject: [PATCH 0/4] efi_loader: track capsule last attempt status for
 ESRT, add efidebug capsule images
Date: Thu, 13 Aug 2026 11:20:16 +0530
Message-Id: <20260813-efi-esrt-last-attempt-v1-0-3be172f47d9d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABhbfWoC/x2MQQqAMAzAviI9W9h2mOJXxMPQTgs6x1pEEP/u8
 BhI8oBQYRIYmgcKXSx8pgq2bWDeQloJeakMzjhvemuRIiNJUdyDKAZVOrKid8Ea6nrTRQe1zaV
 69/8dp/f9AJV0H+xnAAAA
X-Change-ID: 20260811-efi-esrt-last-attempt-62a10e7807f2
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Aristo Chen <aristo.chen@canonical.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786600229; l=2237;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=rbERV/pezhnkW+oDqBkiRdAyrvFfh9L+Mzk0HdkIzoo=;
 b=BeI5AHAfurArYAus5+/przFEhAD+UXtNvWRqXb8/HBH7/k9RULXkS0GBw+TcojS71/2t6KyiF
 u6poNhqZMgQDjDJcurIJnoXPDX2r4D5oBI0dzQLCpsa2u+JG0wPcRXH
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: sF_maEAS1nkUYLQ-tRkBWvNjdt9fh5ex
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDAzNyBTYWx0ZWRfXzQHxwRD4V22Q
 /cb1delRND+RRZIeWzn7sJJx0+3M88PM68dwcmtEIsJXgTX9bWi6DcKc7WsgM4C5bzjXqE6HzGv
 +JFyc3mKqWjT8w+BYxXqXEeq2Ooj4T8uCFqQYKtiYjv43/EbPEoR/iqaVpyDQEQMqtMQk1nDWoe
 WmMiF/Mf2TnhE87XazKtp1f86sO46AJ5ZOVVvLPvtA0sngftwTV1peySO2+FEq6zV7Py+yZlu3m
 i+mMMbvqKk1bpy+Mu6T4FCbLqAkPzZe2tottB164ZupT6nVVl/uLhsNkg1aA74dpdAXvrlWtnLc
 YqPSLFJqQil4ysldxpar7+lRD50Wz3+AUOS36l273XmnTI5gWDolkUfT5BcFwfUMGdMiS6BPc/d
 squDITCTu+4Gax/NzwxksVJYqtbqvNbYNKk3L8CeMxgA8Ghcd9cVXvwzSXacyuljS6lf3wICsc+
 AmUoToKu12I1dpnIa3w==
X-Authority-Analysis: v=2.4 cv=E8n9Y6dl c=1 sm=1 tr=0 ts=6a7d5b29 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=OIpgJ-WAo9WEGMKYZ48A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDAzNyBTYWx0ZWRfX4oaj6xz+iIU/
 rbmo2lEMh9KyligfVXBwvGSVzl68f5iIh3+cm/+RZbVDNaTZmBScjDuIaRbY/C86CtozsJxyKIe
 l2u68RNhitcjSGtejPduba4rEWTyXCk=
X-Proofpoint-ORIG-GUID: sF_maEAS1nkUYLQ-tRkBWvNjdt9fh5ex
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130037
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=qLEf3t/pDKXgMXS/tKRssD
 Z1oz8MXphDCyiU+D3RsWU=; b=JQCildpx4OfEj0a+UmywGhKqg9PAoKh1JGkhfQ
 tk8zGmBz69/CYFyX3F8oZyIt3i9KGAJRHZX0KBmeRnXMPKotXwndLfOSJ9jDp9On
 TTzbeaKaPuj/r6QirRkka7uY8ecryNRtGQ0VCojeJX4dltGJwnv/8Q1l+F3uU9qU
 N5IOPpx3YvRs0yziQT/6OV8AfdMF3Gkmh2xSmWutD4RutB2pllYvS+KG1K/WivJf
 nnDV3/n9U06s1fDbWJGvhaq0PfnWytN4/Stw84yhHQhtOiO0rLsQzfLgUBGNB4sc
 fg6vzYiB8RBb5oIyQYf+n5qwdmhnlfkZADHIl9V4aWBQSbtQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786600233; x=1787205033;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qLEf3t/pDKXgMXS/tKRssDZ1oz8MXphDCyiU+D3RsWU=;
 b=BtC14H2dweWbNzSPiShik1ieHRpGomIsNPumI6RHMw+wEQalQbRWiJdUEEoKJZKQzA
 akWG2DT7zaOJVmXGUQcRBfnVyulrM8L17PHk1Ek7xPuc0V92YfKLcV0UTbHufRT/hrA6
 bAgH3c9yLXBtiC3ayK/jT7kJugMk2SpUgxjvhnKEmMEQgxqTom0vaPkLYsgO5Bybj6gX
 aMyQG0UE8f/HxY14KE7kvu4h5NoonpRT/UxZtKa0J2vWcSfSn/Gq290AvDECKmV2XIC5
 cfGvzC1nkjfpjyQZUr63lTFUoYcmwLlGiy+SGMyx0R7V/DMhRLliYcNoOgJJc9T3UTrn
 5xeg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=JQCildpx; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BtC14H2d
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

Right now the ESRT firmware resource entries never reflect a failed
update. LastAttemptStatus and LastAttemptVersion stay at whatever they
were set to at boot, so an OS querying ESRT after a rejected or failed
capsule has no way to see that anything went wrong.

This series threads last-attempt tracking through the RAW capsule
update path (raw image writes and the DFU-backed image writes it
shares code with), maps the internal error codes to UEFI status codes,
and makes sure the FMP variable gets updated on both success and
failure so ESRT stays accurate. It also fixes FW version extraction so
it still happens when authentication fails, since that path was
skipping the version read entirely and left ESRT with stale version
info on rejected capsules.

The last patch adds "efidebug capsule images", which prints the FMP
image descriptors a board currently exposes (index, name, type GUID).
This got more useful once fw_images[] started varying at runtime
depending on what a board actually has.

This work is part of multi-image capsule update support for
Qualcomm boards.

There is no dependency on any other series.

Balaji Selvanathan (4):

efi_loader: firmware: track last attempt status for ESRT reporting
efi_loader: firmware: add last attempt tracking for RAW capsules
efi_loader: Extract FW version even on authentication failure
efidebug: capsule: add a command to list updatable firmware images
---
Balaji Selvanathan (4):
      efi_loader: firmware: track last attempt status for ESRT reporting
      efi_loader: firmware: add last attempt tracking for RAW capsules
      efi_loader: Extract FW version even on authentication failure
      efidebug: capsule: add a command to list updatable firmware images

 cmd/efidebug.c                                     | 102 +++++++++++++++++
 lib/efi_loader/efi_firmware.c                      | 121 ++++++++++++++++++---
 .../test_efi_capsule/test_capsule_firmware_raw.py  |  22 ++++
 3 files changed, 232 insertions(+), 13 deletions(-)
---
base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
change-id: 20260811-efi-esrt-last-attempt-62a10e7807f2

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

