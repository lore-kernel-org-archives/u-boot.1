Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C6DCD4F25
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 23:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFF30846C6;
	Fri, 15 May 2026 01:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SFPiMEdq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d3UbcM9s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74E408467B; Thu, 14 May 2026 22:58:23 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35F2B844BF
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 22:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ricardo.salveti@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EIpxnY719657
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 20:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=sKgtWmdQZKU1A5JL9NCqLrRD+rkfw4BCluq
 UHrjIaVs=; b=SFPiMEdqBsQ43bRPpYBbzH/F9tOBB9pspMYfhick7kvmUspq4JH
 PBfRf5pF0NCv6FtgRoO1U3a+7dHGRbi5oJ4UkfvX5PqsNiwKCOg89DKxfjHwURrS
 WTKTZdXp8/xvzO3ZOKiye2AeqcxGBR82q7CYeuwP8qz3OeDVsDRSH9D6CEXioe/8
 EvIYSNwb2bBbGQFhuHNyP1PWftcGAIWYRXqIb+xhNqnNDpPFoWedRYvh8DgvIoUM
 6fO52cIis6vSHHhq9yM84FlysqqfIIXGfzQm9DDZBVNJYeRuOOayreY2S8/WcMLJ
 2rZC4np6wx3/bKlGMZVqv721at6v9YpunBw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1x0cht-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 20:58:18 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-6312aa1d7adso42027137.0
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 13:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778792298; x=1779397098; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sKgtWmdQZKU1A5JL9NCqLrRD+rkfw4BCluqUHrjIaVs=;
 b=d3UbcM9scPawxma2l4PiAhJ9Z3QkJmgpst2wLbVfqdUGNEDrHlWiO68JdoZlMKnjzk
 oUeF3whAMlx4OKZXK4fMFjVO2OfTHpMU8Gu39wmhXzy9h7QBw0ZrtunPLw/RQug5lK3K
 0t7Qu0EQ+AXY3EkBHoaumcxbdiSAjDj9KdbqHm80BKP8NMcwq1o+Bmw+WhqQvFmqsFW5
 zu01lXVXkKw7lWiGPI8tdEg93l5bt96LLSRNH60RtFQmFRvty7uBOuBctTspH6J8p6oy
 rFKQ+jr7ob0dHZkzT+sEyexgVEBfOIJvDOmqL5lZVXcF0ZBE7fAAaVZrd00PwNHyoSkn
 5G2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778792298; x=1779397098;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKgtWmdQZKU1A5JL9NCqLrRD+rkfw4BCluqUHrjIaVs=;
 b=QFCJ1D+ir6JWRmj4BRg2jeFarPpZGy2osfqpOAXRY+hsZMPpDQRITSiOPOBQ6Fvr0I
 yvojoDQH/5q0ghbLY5NitGMbHb4LCn9b/EW+LBK2oCoCk3+s8mbPuIOgTrRgY94yW8ah
 4DvCI/dvuwP9EIv4oOGOQuIQ5v4+0SVymzMN3C2EXv6xjJ5QH2liUBPz4tGoJBah6+jd
 PhcFDOVjTWSgY01gzQRL2VojPGs/ascYl+5Un7hkHKaYWajm48Amugy7cjdFXeHZonms
 dYp39GqwJDFnaFYNgqArui0cj4XxKJ4RwUpjr0oWLVw1vaF9PkW5mlgLQovG5pSmvRNw
 rM0A==
X-Gm-Message-State: AOJu0YzSpuUPyTi8RDOJuZBhsDRREbZrUVVfVRjz+ITMDKB/s26TfdfE
 sOweBqUQGN5YPncFM00TDjzCUSFqsKLANjFy9fDmCkZD6mWloNANk5XKovfyOb2wRZ94hxz3sSn
 obm+d4h9UctAm4XCNwHwHTRkMByfIynMbScJKuqewexuRZmmlDEZELiuWiStnaySv
X-Gm-Gg: Acq92OHCYI67Y8K1bLMvLyWwtwlSD4rzC9abAgCTbvjDXAsKN7YJbiNXEGo6pkTdrd7
 Gj0MkTjvdrL5PSUu2CMs44O3Vpw/48LE7qjeew1ny1zCdneOzYd2N24i3zgdBN79IUgh9XFMNVz
 WDpMnluGksSnjLvXBe1uCJXwi0Mv2eH0/u+NHElNoJxgbSxnjHjSaTqdmzsD6sy7xVUfSsdvdbX
 RhTW1Bch7C1kJ4dNqIPeoXLfoMp3oVf8Wl+8Rzt3P2hn8Wn3S84RWpSA6iY/dfCPXsATffNdwqC
 feC3v/teQw6Rn67taZRSyGEJ7F/Pjxb1kip1ROR8Y35kF6aCxbpyLzyoKdu31dMaT864KiDcQd6
 iPXD/h0W3u6JgMOh5XCgOuFQhyA/LWA==
X-Received: by 2002:a05:6102:5806:b0:612:7ddc:52ee with SMTP id
 ada2fe7eead31-63a3f3920eemr522953137.15.1778792297739; 
 Thu, 14 May 2026 13:58:17 -0700 (PDT)
X-Received: by 2002:a05:6102:5806:b0:612:7ddc:52ee with SMTP id
 ada2fe7eead31-63a3f3920eemr522944137.15.1778792297305; 
 Thu, 14 May 2026 13:58:17 -0700 (PDT)
Received: from evatuf ([187.65.214.56]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-63aa72b2df3sm50371137.9.2026.05.14.13.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 13:58:16 -0700 (PDT)
From: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
To: u-boot@lists.denx.de
Cc: u-boot-qcom@groups.io, casey.connolly@linaro.org, sumit.garg@kernel.org
Subject: [PATCH] board/qualcomm: use bootflow for default boot
Date: Thu, 14 May 2026 17:57:59 -0300
Message-ID: <20260514205759.3553253-1-ricardo.salveti@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDIwNyBTYWx0ZWRfX6yUsXDcZAZK3
 ZGn7hIeSU7q7VGQ8t6lsTVzPRZNvhC5NFn+AfVTbPZIShjcie9/Yd4nuUZ7KRHfB1zgKly99Ufr
 tgnMrYcDXZQcjvk9hZ5m6wScgG1dWIBMstjvoqYv6fiuMv/3+AwPrXsiwKU0SJlN3h6oJIHl+L0
 y2r3T037/JXtZ9kIyR8pITwdMZzTsdo/aytHRNHBX2Oilu7ufNzOLA5hnrcP1qLtnyI2zWAXiun
 6S4am+L5t02Lolq2+YaumUqp9QjDairq5zoKUCZd2r1OuZboCYoJktbDg4EjzRwJ43n3MmN6btJ
 qISqB83GN+Ff6D1mv6cK8gqTcWVdEJlC2h42Pu5hgmsl2la1Mc9zz/0lw3oaX35hpw12Jec5d3J
 dlCSX9cAisOwmrAHwFLGg1/1m8QGqi9cqtY1nKXwjUhcZqYQQT8QQNyn7NakSngrYJAWREMFVqL
 Vs8ArZCmcN48eHL7rMQ==
X-Proofpoint-GUID: _CygcvbBurv9soF2kC62Lq9toU6QRl-f
X-Authority-Analysis: v=2.4 cv=GL441ONK c=1 sm=1 tr=0 ts=6a06376a cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=5XGjxTY8yYkUmB1D1iF5Cg==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=pvzyUYBe7NGHqeDSje8A:9 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: _CygcvbBurv9soF2kC62Lq9toU6QRl-f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 bulkscore=0 impostorscore=0 suspectscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605140207
X-Mailman-Approved-At: Fri, 15 May 2026 01:39:52 +0200
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

The Qualcomm default environment currently boots only with
'bootefi bootmgr'. This bypasses the standard boot flow used to
discover extlinux and script boot entries, which are commonly used
for FIT-based Linux boots.

Switch do_boot to 'bootflow scan -lb' so bootstd handles boot method
selection. This keeps EFI support available through the EFI boot
methods while also enabling extlinux/boot.scr based bootflows by
default.

Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
---
 board/qualcomm/default.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/qualcomm/default.env b/board/qualcomm/default.env
index dbf6f4e7260..a47c289acce 100644
--- a/board/qualcomm/default.env
+++ b/board/qualcomm/default.env
@@ -3,7 +3,7 @@ stdout=serial,vidconsole
 stderr=serial,vidconsole
 preboot=scsi scan; usb start
 fastboot=fastboot -l $fastboot_addr_r usb 0
-do_boot=bootefi bootmgr
+do_boot=bootflow scan -lb
 bootmenu_0=Boot first available device=run do_boot
 bootmenu_1=Enable fastboot mode=run fastboot
 bootmenu_2=Reset device=reset
-- 
2.47.3

