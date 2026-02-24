Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73025EFB7EF
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 03:50:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84ADA82BF2;
	Tue, 24 Feb 2026 04:50:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BIfUcia3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IbgOXKg+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC2CB83642; Tue, 24 Feb 2026 04:50:16 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C29358063E
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 04:50:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61O3L1kQ2189781
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 03:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Ysc8WUf0j7mKMM5tF3Ll+2oJZmRuW5WkmiX
 6Utz3lSc=; b=BIfUcia3DrgQ6KaiVUt5TBx7jXvjxRQYr1heLw5FqWc2MeRvodk
 fp40xOOsLW7LsyItHEn9KpPhJSYnl28FrSNRxMU2uMgAHIO114Nm6EZzOA91fpxg
 vsEwyzu85bbawNjPwBnqLVXo99N3De7OPwDPrMmO2ttXCeL0ZECCaFBOkAeg2e/u
 Bp/S4nhCn6SaR0EWqycbnAgpH9Iiab+s7HqAQAmvE4TCEHJ0q/rUVGtuowc9nmyy
 I7YJwTEUdIg3WYzEN7wit12QkHgHc8oE31lt7f3zBtKZfgwYkG/ymcGytnZJQo1s
 9CIDlD8Slv5JoXf0dDQ/zHDxxIEkwNvc9Jg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgtyj9kmh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 03:50:11 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a8c273332cso461589645ad.1
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 19:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1771905011; x=1772509811; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ysc8WUf0j7mKMM5tF3Ll+2oJZmRuW5WkmiX6Utz3lSc=;
 b=IbgOXKg+xU9Xf6dnF7dwaf3kfpSJyc4WzJ2dkhFUjteRBwjy0jb6pYutkF8Yhxx6Qi
 NY6LrC6AGN2VGOyyWUROJNddhaL87IRRTPJgv9kaaSCa1wdQlChn3pp6TWkZ4qWFlLp3
 xyBfhE0oifoi8w5uBTyeZjmoL/EZFHIt0BeM0I2Gh355YGCiuckZiLDnu5I5W2Jxbuom
 BZAHChVBP0DuaqUZanY7SF5KVcCR8zK+nzgnym2NUvg/Y7g+jjrzNUygI+dHeTEJAoce
 UjHss1EIQpnZEz6S1mhhROxiPUrLh+iwF4lSJLDRt0fzwleMzxQ4LNxeRBnige0aEdmK
 89ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771905011; x=1772509811;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ysc8WUf0j7mKMM5tF3Ll+2oJZmRuW5WkmiX6Utz3lSc=;
 b=U5DCSGjWKWzVJJ+ZhJmBRYC59iF+0RFhmOI8qa3o6AvhdL6uWwtp+SxDxp8XI9Bw6k
 OTUeTyTDsWdi3drH3LZeXO6wHob3lExz8N6wl8joUlHRRgBwMOq8Ffm5/KLi8VI2LLHn
 9W6nXGDEyejGZ7IzfAI+Dzz0SjlX/xVJQIBSEWvlnokqR6tV2wyXYa92AlTcR0SWyGsc
 UncAcSTQU1LGg1TOcJnBPHy7+X7/T4MF0wp5KfIRQWpFAFyg3gaP49bq3yVzHv2DDwD0
 6XSez5P610K8Z14skCmPD/6S1MhOiCXKPlS4sn/f18pAK43tMQWkFoPspPGfovU7p0VC
 U3lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm6HtHKAwijATjAZbEhVYVI+OUgk+yqEiVI2/8D3uXOr54CCWUBkeLnsrsd2vPdplHxntTGJw=@lists.denx.de
X-Gm-Message-State: AOJu0YzC6wZiZCT9uveB5nmVMpiU3+ZAOZ/zHouCYz6hBbq3CiqKoK0f
 GjPB5/R+fn9MhRruXj5HcKen4tx1nldh1JgX5DCUtOzeBzUw+4id1V5Rd4fAeuElPqfkbLRhDkX
 uD3FvNwTflDUdazXBYlSCSBA9KdZtZDXtaMQuI6u+bLMR0RoBBzO2/af0
X-Gm-Gg: ATEYQzxE9Hr1vHW0gUKGb3eWgdwGrdPrlss+O8IiSX8Aeanyqhj+8QDwR4VV3PAYwXw
 CCdKUT/OiLSSDBW5WPJxirV/Z21+XlILtZ3SO4rptqa95FSLFeO509bzstsyqS3lf40G4riwn1s
 CuLDmht7uV2XLaWBc9a4BF09s3JAmL4XzcdbPkU5yRUbp1vd1r+9wBcl1Oesvg+hTEcFHz8tB1x
 63XTB5VeBsyck3MwMw9mhBhno+35q5ViLJL4Re68nvbwibI8WSXLgjs6Yc2e0hyGN/sSvVojWan
 jA23zLi05Gsn+2+e4vziCcD+wfV/tyDr2Xi0FPOn24Ai0BqSTh0aWcOcFb9dUU8fi+NS7JAA4EN
 ohEoQpR23FzdP3OdsEdFgn9Omc9ae828Q6ZhLY8InVbo/kohUBTp5HgypfgOUoZiAmY/B+vUNar
 YZDB3uEEm6sGEG2MaLOkGBFDSbnLW1fdLD3qxsSH+AFKR+bAT04gw=
X-Received: by 2002:a17:902:e787:b0:2a9:3396:738 with SMTP id
 d9443c01a7336-2ad74547d8dmr92670705ad.44.1771905010935; 
 Mon, 23 Feb 2026 19:50:10 -0800 (PST)
X-Received: by 2002:a17:902:e787:b0:2a9:3396:738 with SMTP id
 d9443c01a7336-2ad74547d8dmr92670405ad.44.1771905010352; 
 Mon, 23 Feb 2026 19:50:10 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad75027affsm86037945ad.66.2026.02.23.19.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 19:50:09 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, christopher.obbard@linaro.org,
 marek.vasut+renesas@mailbox.org, me@samcday.com,
 varadarajan.narayanan@oss.qualcomm.com, gabriel.dalimonte@gmail.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, balaji.selvanathan@oss.qualcomm.com
Subject: [PATCH v6 1/2] fs: fat: Handle 'FAT sector size mismatch'
Date: Tue, 24 Feb 2026 09:19:58 +0530
Message-Id: <20260224035000.1617869-1-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Jq/8bc4C c=1 sm=1 tr=0 ts=699d1ff3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5p_tG3gqAAAA:8 a=YfCOm-DyAAAA:8
 a=COk6AnOGAAAA:8 a=qk1Lz77g9ZyMB9GH-C8A:9 a=1OuFwYUASf3TG4hYMiVC:22
 a=zQLMK8awuJ6_Hvp-_9Ux:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: kZ36d5a9BfYPfN6Io8TQCr8Y_DoC8Lw6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDAyOSBTYWx0ZWRfX5nXcl8qq1P4n
 obhgze2ph4VNQQKBJaawzUg0eyyWgBdhG2xEvLzK7qCN/gUwPBEhiNE/JhyBk3GolP1I/OLLl97
 Qt/Y5772QK6TXIx+pXyaNFrXbALexV8jG8Lb1jmIphYeW67FGpyDvhK1WPyz/6Q06yNKIDWfQGB
 wG1F/l9+fJBqJKNXL9DRwcpbi19B2xQwJIp+hF+n7aehM6Je00PrC46n++hGhESkE1avzKt47e1
 Vy+uJR6v+ubbbWINhN69UpLjPZhFDU6ewlrZYqsTQyxOcelkPCoE0GTUEMHgiMm1Cz9hopzCOGb
 RpkvA4waLaWukxD7k+V8DAWUHd1rC2x/Hu5j2byujw/qWPCrCR3rUcuWpx46iYvmtmYjspQhOOU
 oUrehhjHFPoKydn8kV/W6taDo8RQdLAVnuKHZTny2JOT3Xf2lQ5GVLLquScK/5mbSP7jxMVCtR+
 0x7a2Yuh+PykzQpgafQ==
X-Proofpoint-GUID: kZ36d5a9BfYPfN6Io8TQCr8Y_DoC8Lw6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602240029
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

The disk_read() and disk_write() functions of the FAT driver use the
blk_dread() and blk_dwrite() respectively. The blk_* APIs read and write
to the devices in terms of the device block size. However, the FAT
driver reads in terms of the device block size (from fat_set_blk_dev and
read_bootsectandvi) and sector size in the rest of the places.

This causes buffer overflows or partial reads when the FAT sector size
is not equal to device block size. Fix this by using blk_dread in
fat_set_blk_dev and read_bootsectandvi instead of disk_read. And update
disk_read/disk_write to handle FAT sector size and block size mismatch.

Changes in v6:

Added a new config to avoid code size impact to platforms that don't
need this.

Tested on
	blksz | FAT sector size
	------+----------------
	4096  | 4096
	512   | 512
	4096  | 512
	512   | 4096

CI test results
---------------
	https://github.com/u-boot/u-boot/pull/871
	All checks have passed
	93 successful checks
	No conflicts with base branch

Code size change info
---------------------
       arm: (for 1/1 boards) all +32.0 text +32.0
            qemu_arm       : all +32 text +32
               u-boot: add: 0/0, grow: 2/0 bytes: 24/0 (24)
                 function                                   old     new   delta
                 read_bootsectandvi                         420     432     +12
                 fat_set_blk_dev                            204     216     +12

   aarch64: (for 1/1 boards) all +12.0 rodata -8.0 text +20.0
            qemu_arm64     : all +12 rodata -8 text +20
               u-boot: add: 0/0, grow: 2/0 bytes: 20/0 (20)
                 function                                   old     new   delta
                 read_bootsectandvi                         408     420     +12
                 fat_set_blk_dev                            204     212      +8

   aarch64: (for 1/1 boards) all -2.0 data -8.0 rodata +6.0
            qcom_qcs9100   : all -2 data -8 rodata +6
               u-boot: add: 1/-1, grow: 8/-1 bytes: 708/-224 (484)
                 function                                   old     new   delta
                 disk_rw                                      -     628    +628
                 read_bootsectandvi                         408     428     +20
                 fat_itr_root                               500     520     +20
                 get_cluster                                376     388     +12
                 set_contents                              2076    2084      +8
                 fat_set_blk_dev                            204     212      +8
                 static.set_fatent_value                    536     540      +4
                 get_fatent                                 420     424      +4
                 fat_next_cluster                           368     372      +4
                 disk_read                                  100       -    -100
                 disk_write                                 132       8    -124

Changes in v5: https://lore.kernel.org/u-boot/20260217035643.2383088-1-varadarajan.narayanan@oss.qualcomm.com/
- Fix CI error reported in https://dev.azure.com/u-boot/u-boot/_build/results?buildId=12821&view=logs&j=a007cd84-3be0-5a02-8a7a-a34fb3052485&t=216c79d4-eaff-5600-0b8f-3a63c01a45d6
- All CI tests passed. (Please see https://github.com/u-boot/u-boot/pull/868)
- U-boot SPL for (am335x_evm, am335x_hs_evm, am335x_hs_evm_spi) includes the
  FAT driver. The additional checks done in this patch resulted in increased
  code size causing it to overshoot the '.sram' area.
- Address this by using the existing disk_read & disk_write routines for
  SPL.
- Also bail out in case of sector size mismatch for SPL

Changes in v4: https://lore.kernel.org/u-boot/20260213053719.2590474-1-varadarajan.narayanan@oss.qualcomm.com/
- Fix clang warning reported in https://source.denx.de/u-boot/u-boot/-/jobs/1365316
- Remove unused function 'size_to_blocks()'
- Triggered CI, it fails with this error https://dev.azure.com/u-boot/u-boot/_build/results?buildId=12817&view=logs&j=a007cd84-3be0-5a02-8a7a-a34fb3052485&t=216c79d4-eaff-5600-0b8f-3a63c01a45d6&l=405. But that seems to be seen on top-of-tree without this change also.

Changes in v3: https://lore.kernel.org/u-boot/20260122063442.2622684-1-balaji.selvanathan@oss.qualcomm.com/
- Respin, no changes

Changes in v2: https://lore.kernel.org/u-boot/20241125085213.460723-1-quic_varada@quicinc.com/
- fat_sect_size is declared as static
- The else block in disk_write() function has been removed
- The commit message has additional details about testing

v1: https://lore.kernel.org/u-boot/20241119073048.3469260-1-quic_varada@quicinc.com/

Varadarajan Narayanan (2):
  fs: fat: Handle 'FAT sector size mismatch'
  configs: qcom: Enable FS_FAT_HANDLE_SECTOR_SIZE_MISMATCH

 configs/qcom_defconfig |   1 +
 fs/fat/Kconfig         |   8 +++
 fs/fat/fat.c           | 152 +++++++++++++++++++++++++++++++++++++++--
 fs/fat/fat_write.c     |   2 +
 4 files changed, 158 insertions(+), 5 deletions(-)

-- 
2.34.1

