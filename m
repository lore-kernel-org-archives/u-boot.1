Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EECC4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DBA2838D7;
	Mon, 20 Jul 2026 10:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qticcikl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q1iS433v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AA59841F2; Mon, 20 Jul 2026 10:52:13 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71EEB80517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:52:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6RjKw1713706
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 08:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=DiYvEt0vOru9jh5gspwTmsM21jFg85/bsEm
 7MABOsw0=; b=QticciklJWFBT+vcdB5+YndR0pDhm4T00i55mbYpIMnvYhj1IHq
 ADODHR1BZxMmho7A38MIDfy3OijaIxn2+sT+0BcIN+8uAixcqGaDU5/6C4nbtEnR
 5Ddn/2mjjtYcSx/wySFNsN3U/saNkdPxrJ1Wtqja4qAkHicCYXl3YF+eWy+33Zef
 nPK4sriQUxBJosrcQE1v53iTCXgPLMbRcz35EvQCXOcEadFUfj/IEdXpfwwUhneG
 ntx3p679N47M5t/NjIHZ/7l8JB0J1vnsZqOv5QGm6Uko3rc9fDPsc0nxNeTRzw7q
 T7SXedTLGp9gmch4l+2RgU0M5FhXvcWnO5w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2dc5ad2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 08:52:07 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c01ff996dso73031001cf.2
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 01:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784537527; x=1785142327; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DiYvEt0vOru9jh5gspwTmsM21jFg85/bsEm7MABOsw0=;
 b=Q1iS433v/oWu7zXSBWLD69zvs7njKa2NCwmxN4XQHu2D34qrAp9oUV2FlnBRk2gScU
 z4rqNyFjb+rmwHQM/b2w+zWCtwIPj4ml0PLN6O3aOntkw7ken1OU15ZRPjGEijxf5LCA
 YmjKTNjlypWxudgXulRXjwMUnsUVs0nVgVbJKDng0MedXOgZSOf7qAjxVKWIapvB87iL
 UqwY8BwA4v1QuqeJISv3ecSC0WqYwYW0yeeIZOzmTv4OIC7EGF2cm6KD+yGR7xo09nXd
 2D+ZcpjzYTafQeViJLaxuJhQGWrhCqu/ougJY7D6bOtfdPallVPDVwvd4XWnDTMh1Q+7
 sF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784537527; x=1785142327;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DiYvEt0vOru9jh5gspwTmsM21jFg85/bsEm7MABOsw0=;
 b=sR/lJGSjsQ2XZ1UflvEAnUpu0ywBEQtsCmDszXtwCCdL/JJPpbE8cZCILFwyUaxeDD
 JLXJTN6f27/Zw+iKG37bcw6HSM3zw/b6mY0CW/Lsu5fzZsBcguqPaVquNt7U8+Nj0vSm
 sdm0UcFukmR7IQZmJFsBOzFXuJSYxc5/UxldZdSP/IGOyOPv93c0Ase9KwRRaRE5KQ2E
 QLLTUbYZes0ROjI2HAQeHN6qCDsXQvWZdaHGbTpyU2qZtD7gOwTE0pSeOLXCHwqr+2JO
 BiQNyu6sDNgOBWjWd1yws0xe/hoAleuYx5xH0drKtGum3pY5HHjjKPzX64hyT0I+e/KL
 XvbQ==
X-Gm-Message-State: AOJu0YzX/YDZsFqT9ZfFHpYOi0LrEen9EzVXUgdUzOh7hsJu9BugtpSW
 ZMwwTJ8ZQcwtC4de5neBYcTMY/MrYa3ApB5QNe6HjLCpGXLzJ7womgtMrcewOBi49nFbMpu3G0C
 92m2e5zxMjMtCyI3mMX9EtSMylBisM9yw1xVsdDd5ipzFWGniMoHZTyVP
X-Gm-Gg: AfdE7clXRpU7dbhwzWrRPICLIMqJ8zAVZqsvlTddv7a1U6HSlhZQHFXJ5MoAJmOQZwL
 Ze+0+vTj6AYO/2HtkmTpxnfLFolgJCa8lxgQ/XlTuDBoSPYOx8qnLOTV4i4k8wIWmEkGosS2vkA
 MGwh0Z+aaBXaECe06MkXcHJN8byca2KJWt1yyOhPPkPAYlPppTX1Vhs9VHbJOyYhQErTaqsi35j
 Xl65kLqxLo1MG13uF8m56G6soW8Mywh9wHq5qkU/uoLT7fig2aX2nsH84ZGRzf+elqX4VO9sW08
 MpEa7doC0t27l4L8XB5/AwsGvZ1p16CFF6v5kTdWPNVrNvNOS/6+WJ0BCmyOthqg0N1jiQZO//B
 4VctIE8cpeVNRTLcsjviIam1XC1ypF9okBcZ/O9v3Ey+KVBdeTgY=
X-Received: by 2002:ac8:5842:0:b0:51c:7b12:1201 with SMTP id
 d75a77b69052e-5213f274ab8mr122983191cf.79.1784537527276; 
 Mon, 20 Jul 2026 01:52:07 -0700 (PDT)
X-Received: by 2002:ac8:5842:0:b0:51c:7b12:1201 with SMTP id
 d75a77b69052e-5213f274ab8mr122982911cf.79.1784537526790; 
 Mon, 20 Jul 2026 01:52:06 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e499c2sm26450052f8f.4.2026.07.20.01.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:52:06 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, trini@konsulko.com,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 yoshihiro.shimoda.uh@renesas.com, alchark@gmail.com,
 tuyen.dang.xa@renesas.com, macpaul.lin@mediatek.com,
 padmarao.begari@amd.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com,
 hayashi.kunihiko@socionext.com
Cc: u-boot@lists.denx.de, sumit.garg@kernel.org
Subject: [PATCH v1 0/7] ufs: rpmb: route OP-TEE RPMB secure storage over UFS
Date: Mon, 20 Jul 2026 10:51:40 +0200
Message-ID: <20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5OCBTYWx0ZWRfX83Sdqn7urcw6
 7lYwK29rHsBD6JpPHbYKf0+ON+toXJgQt/tHEGJsRa0S+57xrr4kG3cmnEi4ug87dJiWG3+hEF1
 2/a6NZRaIUJ8AQT0KHO6FgIgmBuGqdQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5OCBTYWx0ZWRfX/kKdvQOZB66N
 asYv80xwcV4oewCb6Ap8UrpMj2Se9bO8t8BauCMxTOl700LxV7a/nD8iouI3JqhLMJn8SZZiz31
 kE0hqRo7WNfsmIqFo/Zn+VGtGs0eUNGsGwWrkfOHOYVdYdajOXHFjpEftKaxSC8WbhYLqciIthk
 hHN2JoMT2qcPh1ouwcIltxJzfHeiINQMWIpweIFDOvafxUVxrXJ3j+UvX2wKPej7OhX7W5sfMK+
 yYhImVNZvWqPItjOV7naBbgYVIAMrIT9eq9LjgykeHc8COCdrY+l9dtI3vcBH1ZohZkPDseIZNJ
 XiVXPDj0F1tsdDtb6JQOFIzDLtur1Y0e3ECtTvyGf+tkO7vHFlx92uTkTa2kDAxhQw3aiLdYVlO
 FVOkOonTjiM6Z54g7Xs/8bag9CPmW4GUcbgi408rePRJMUk3yZ1dWW9DiwrFimCmRXDb0HY6OL3
 m0SVbPc3K2BzLoY1/og==
X-Proofpoint-ORIG-GUID: 2b1uRrfZWJdiPbId16jyp_weIUmTejtS
X-Proofpoint-GUID: 2b1uRrfZWJdiPbId16jyp_weIUmTejtS
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a5de1b7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=ol2PIM68P1oNq-Pwn98A:9
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200098
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

OP-TEE secure storage (CFG_RPMB_FS) relies on an RPMB partition, but
U-Boot's OP-TEE RPMB supplicant only speaks the legacy single-command
interface, which is bound to eMMC. SoCs that are UFS-only and have no
eMMC (for example the Qualcomm SA8775P) therefore cannot back OP-TEE
secure storage from U-Boot today. This series adds that support.

It introduces the transport-agnostic OP-TEE RPMB "subsystem" interface
(PROBE_RESET / PROBE_NEXT / FRAMES), where the normal world enumerates
the RPMB device and reports its kind, size and CID, then carries the
signed frames. The legacy eMMC supplicant is preserved unchanged, only
renamed to rpmb_legacy.c; the two are mutually exclusive via Kconfig
(SUPPORT_UFS_RPMB depends on !SUPPORT_EMMC_RPMB) because the OP-TEE
supplicant handles a single RPMB transport. The subsystem interface is
UFS-only for now; eMMC can be migrated onto it later as the legacy path
is retired.

On top of that it adds a UFS RPMB transport that moves JEDEC RPMB frames
to and from the RPMB Well-Known LUN using SCSI SECURITY PROTOCOL IN/OUT.
The per-region 16-byte CID is derived by BLAKE2b-hashing the exact
device-id string the Linux kernel builds (ufshcd_create_device_id()
plus a "-R<region>" suffix), so OP-TEE derives an RPMB key that matches
the one Linux would use.

The first patch is a standalone UFS descriptor fix the RPMB path depends
on (UTF-16BE string decoding); the transport patches also include a
power-on UNIT ATTENTION retry and a DMA-alignment bounce for the RPMB
WLUN.

Note: reading UFS descriptors reliably also requires the descriptor
data-segment cache-invalidation fix, which has already been posted and
merged separately, so this series is based on top of it.

Tested on the Qualcomm IQ-9075-EVK (SA8775P): OP-TEE with CFG_RPMB_FS
programs the RPMB key through U-Boot and reads/writes secure-storage
objects, with the derived CID matching the Linux UFS device_id ABI.

Dependencies:
Linux kernel:
 https://lore.kernel.org/linux-scsi/20260716083728.2226422-1-jorge.ramirez@oss.qualcomm.com/
Op-tee
 https://github.com/OP-TEE/optee_os/pull/7881

Jorge Ramirez-Ortiz (7):
  ufs: decode string descriptors as UTF-16 big-endian
  ufs: add RPMB transport over SCSI SECURITY PROTOCOL
  ufs: rpmb: derive the per-region RPMB CID and size for OP-TEE
  ufs: rpmb: retry SECURITY PROTOCOL on power-on UNIT ATTENTION
  ufs: rpmb: bounce unaligned frames through a DMA-aligned buffer
  optee: rename rpmb.c to rpmb_legacy.c
  optee: implement the RPMB subsystem interface for UFS

 drivers/tee/optee/Makefile               |   3 +-
 drivers/tee/optee/optee_msg_supplicant.h |   8 +
 drivers/tee/optee/optee_private.h        |  41 +++
 drivers/tee/optee/rpmb.c                 | 217 ++++++----------
 drivers/tee/optee/rpmb_legacy.c          | 193 ++++++++++++++
 drivers/tee/optee/supplicant.c           |   9 +
 drivers/ufs/Kconfig                      |  13 +
 drivers/ufs/Makefile                     |   1 +
 drivers/ufs/ufs-rpmb.c                   | 307 +++++++++++++++++++++++
 drivers/ufs/ufs-uclass.c                 |  18 +-
 drivers/ufs/ufs.h                        |  24 ++
 include/ufs.h                            |  12 +
 12 files changed, 701 insertions(+), 145 deletions(-)
 create mode 100644 drivers/tee/optee/rpmb_legacy.c
 create mode 100644 drivers/ufs/ufs-rpmb.c


base-commit: ece349ade2973e220f524ce59e59711cc919263f
-- 
2.54.0

