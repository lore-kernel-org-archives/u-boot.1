Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEC5C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 09:00:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81CA2836B4;
	Thu, 24 Jul 2025 11:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YVNhPH1G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86FD9836D2; Thu, 24 Jul 2025 11:00:23 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A792B83666
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 11:00:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NMXbjF029489
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 09:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Q3oeabduSNJxOjy7PYeFB/gOcmWAj8+UhBZ
 EHUDy6G8=; b=YVNhPH1GFNkYF0k9wSDGBPv073trmsxcJOXFhjHa3LsBaqkdn6W
 0NaAdY5IqSPtX81vgivqq3Q4WUTHGRo5pvyJMF9yZTYVZT17JUPDtaA1N5yMwfBD
 FUZIo5OZsLiNEa5bPmIEyjZowK/kPdE+hznAjLOXxbkK4cqKPTuil93Sqom47A5J
 vtO/utTgoEeJVhLSmcdrCpFedpw06z8ovsd+wsFLyfHh9I32u2GuFkm8dlLWLEGc
 aU1Au8rTVFSIwiS83xKsdaCr5Uf7Yfm2ZORLAsH1pGx7IxT4T1WioZ++ufKIqh7H
 Tuy+DrJjdB6QTmIxAJWCLIchvSPSAO+7ZwQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1fe4q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 09:00:19 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-74927be2ec0so1333564b3a.0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 02:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753347618; x=1753952418;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3oeabduSNJxOjy7PYeFB/gOcmWAj8+UhBZEHUDy6G8=;
 b=nPq+hxpxT+UWITZh3aA8aqhP6acYuG6M3fthzUgwCKefTaGWmIB1NvQSyY+FilBMpb
 g00IqMX0+dZP5/cJcxyBUFNutN0pEnc/7eXYOUoGRrRKXDgT41hgg2e0lGvlgKZWUQnX
 sAEeAhgTq4CDmcbIzNJhM51hTFOblHew9B9+85ycCygJL9ZpqiIy74Mgy6ZbMpCO6tNA
 eERbqsEJSuiREWlkD0gV5kC/0y9fVoPMfVek6BuKRK/NEFn+PIcB/iPMROH0cZLYKf3+
 sseh2c6wqowAQZo8TrzruCqJZRCehYTXwi4UqEykD3Clql2rn/Scf4oa02fVfWAVsXKI
 KPbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGir8z35bW6yURj134DzLVqVNz8CSIsag6HXxBjziBvV01RXtIQshei9rGTnvIPLhChotVe98=@lists.denx.de
X-Gm-Message-State: AOJu0Ywhcx/Kx53H3pa1iVXduf9/PmJ2piSZ5zjmkLyk0tn4LxljmwVI
 R4es57pb2HlAqcxS0jD5pkbLIA/3dCh8rcz6yGfafHC65w7Opyp//Nw0bPhviVKIlNhmByP/a0t
 Hx82u+X93/O29XhdLkKUrNYwxnzUx+z/86k7QZvYK4M6tIkZBd9Sl5fih
X-Gm-Gg: ASbGncv59OKNGIR7Z4HGJns9Wvo3+Wysg8CQXVPbCSesEq9pjlFgA/f6pfRQUJtsvUX
 MvfTwcT/yogwImUbKEIwRDf3DSjK+nvRUjR0njBCZCse1Hscp2rrhSkgLruL/njskxw2aEW3wNl
 SP8lN+Hh9Shb4cZ7cJarS7koe+MShgpoktr5/JIvCw1KPpEYOyW6gIR2tRq9fn64oJ7St4sitZB
 3JOOQ8Y6a8gVifSKaQOpadyyRICHzzcGF+ZeEpVt+T4cXzFP9xzMolRQzLN4Z5BedzyQo5y0oHN
 trM+4RX1vBN7rQMHs/TtN6hiAnjr/5JXYD8k+XZLDcw8aNWor1fQoPGTfdLHwv3P8E2A0eMMO3P
 6L5a+N7of1SA9tc7ufjlPCOH4sCeLYTVxE5W9uCc+fiKoXts2v7n29JZ/OxOllE5IMlvw
X-Received: by 2002:a05:6a00:c87:b0:756:b722:b94a with SMTP id
 d2e1a72fcca58-76034c4d017mr7143076b3a.9.1753347617823; 
 Thu, 24 Jul 2025 02:00:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbsIGJloQdfrxFXa1ivDDAPiH1Urd5Dl6BJ6c2yf4nnxvQyOpTLmGOEQ03QJ6dCi+gauspzg==
X-Received: by 2002:a05:6a00:c87:b0:756:b722:b94a with SMTP id
 d2e1a72fcca58-76034c4d017mr7143040b3a.9.1753347617344; 
 Thu, 24 Jul 2025 02:00:17 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-761b061a514sm1161395b3a.114.2025.07.24.02.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 02:00:17 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, adrianox@gmail.com,
 moritzf@google.com, sjg@chromium.org, maks.mishinfz@gmail.com,
 javierm@redhat.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 0/2]  Improve EFI partition matching for capsule update
Date: Thu, 24 Jul 2025 14:30:07 +0530
Message-Id: <20250724090009.569341-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oZ8TczAn591jxNN38xgvw7n15wt8pCfV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA2NSBTYWx0ZWRfX1Yqq3w+DTEOQ
 mY7bIyJQLu29QAZUVSyaoF4mNt6SQDk3joIWh53oGdMjKk1hLVaJJnSIO2OUCmv8Lw9/DCyBQI5
 mMCjlblInXQ5HHqYqU6o4lXKlRrAYoHZw+vzobeD86WdlkqGJB3oWLY0c9DDrWN+axDbJ+kfahp
 CxlOp/03zuNcLV1FW9TLIj6DJx0mcUA6yYkyQuIUtYT/WKDzDZdE0ZPIb4/d5Wdl/GCjr1iD8Lr
 goR5cE5hiy5S5uusKJD30/KR+/B52vSSz7kX8xxRy2xAFBBnCfGVWeAhjeJeFmSnoeR9LfF/Vcr
 jlMDk78UBeiu2Hv5la7TYh7Epqr54RlGQd9GXbwdHbJ2Pao7dAndBsG7Z/bwaH1I4nAyLTcvvJq
 cXTe35tYYc69NTYHjY6pNX9r9UPzIWZhLXnww2yPKkIjFs7NMkUdhgaIj1B5LX2JOYV0O7e4
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=6881f623 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=89Yo0Kf455smERuP9WIA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: oZ8TczAn591jxNN38xgvw7n15wt8pCfV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=549 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240065
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

This patch series improves the reliability of EFI capsule updates by
fixing issues in device path matching and partition name filtering.

The first patch updates the logic in find_handle() to correctly match
device paths when the EFI System Partition (ESP) is a sub-partition
within a larger boot device. Previously, the function only compared
paths when the candidate path was shorter or equal in length to the
input path.
This caused failures when the ESP path was longer, as is
common when the ESP resides inside a UFS LUN. The new logic allows
matching when the input path is a prefix of the candidate path,
ensuring the correct EFI handle is returned for accessing the ESP
during capsule updates.

The second patch fixes a bug in 'capsule_update.c' where the logic
was incorrectly matching partitions like 'uefisecapps_a' when it
intended to match only 'uefi_a' or 'uefi_b'. This prevents flashing
to unintended partitions.

Together, these changes improve the correctness and safety of the
capsule update process on Snapdragon platforms.

Balaji Selvanathan (2):
  efi_loader: improve device path matching for partition lookup
  capsule_update: fix partition match to exclude uefisecapps

 arch/arm/mach-snapdragon/capsule_update.c |  2 +-
 lib/efi_loader/efi_device_path.c          | 62 ++++++++++++++++-------
 lib/efi_loader/efi_disk.c                 |  2 +-
 3 files changed, 46 insertions(+), 20 deletions(-)

-- 
2.34.1

