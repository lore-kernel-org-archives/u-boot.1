Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EABBC44512
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 06:08:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB39F80D2B;
	Wed, 22 Jul 2026 06:08:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VVTKvh-MSBFq; Wed, 22 Jul 2026 06:08:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB39280D99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784700503;
	bh=i5ZNUrFJ7D8/J5Kp8PZx/b8ujkZntNWmleHHIxXW4iM=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=ytfAk+o+BhwgkmOXqb7K11kCN9eRjmZ2CbwjWh2W3uRi/mUtM0zgmwsx7V0DcXU2B
	 YiLFIpSxQZCAehwdh8FAEZ2ylzfBPoJtBe/wAQoX9lKQQXnT2XeQ3ZxXoeC2oKS2g+
	 5mP5DVnoDLpQtqqWTm6iFcPwN/iASF5Zc4ScWnhl0X/rShg1cDDwvPdl+3UDmO7dyX
	 BoCxCTQBj+KKeX0tfVZzpBWossS+aGtohijAMfUbaQ53j+VBhqJXwRdKhcNPreucNW
	 YGDfBhevXggiPZGXSwRQLUoRji6nJ/Fbzs7wy2MkjUsAMV0hXlidV8dwE+8MJNlXGz
	 neuk/+gFHtJGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB39280D99;
	Wed, 22 Jul 2026 06:08:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A844DF0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:08:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7BBB06071B
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:08:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eNjZm9tXKcbd for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 06:08:21 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org EB5FA60639
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EB5FA60639
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EB5FA60639
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:08:20 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0085F848BA; Wed, 22 Jul 2026 08:08:18 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45D04803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 08:08:15 +0200 (CEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53fhc4027263
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 06:08:13 GMT
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9bsbs60-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 06:08:13 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so193509281cf.2
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 23:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784700492; x=1785305292;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i5ZNUrFJ7D8/J5Kp8PZx/b8ujkZntNWmleHHIxXW4iM=;
 b=PGKPdQ6671R8IPacOhXHTE4MVO3AP0JgvjTljIam+reuq8Uch/HadtqP2TfSmNQePN
 /ertSU1EWj7Mu6BqsWlI5gLhAs2Dx+CKrrfkfPFQE6SZgcwCp/5rjOBMUU5ljwY+WSSO
 hKwEoi8uVx6p1Y1r7/Po6dcC0lIURUOyOwaAl9cNwRD+FHWU+siXYAwPKTOqoay58+YN
 +QzXYz31Sba6misezac7h+wbRfVlsZyEsUz38R4Tb2SMWXvyC21jb9vPxEIKyNHvxfGL
 ZWATtMF8uNx13Hb4edj6tgsmK+Fou145E19mdWr8ZeBQHw1pz2fCmXK4JLUKrX/vJeIT
 xiXQ==
X-Gm-Message-State: AOJu0YxvQPxqQNRs+I8VAPVsHPO3dujjqU0ZdYf43vxmQzRt0VpO2V5v
 oTuRUJiYbAzUYYZOEVT6gr4zMtME6WQFhx9sLHYplDokQ1J4bJczQnimTgg/5hXVOsemz2spz1H
 omqKteJQAgKQk2jMxok91W3/QOse34S8rgq6wHzgOKwRWNcQVTlXtNj76
X-Gm-Gg: AR+sD12mECXDK6hVjrWVgm7qoOpXpbMn47rLahNg98rVLui7jI0xYmtDj/qRDp6davz
 vMxl8J8dirWXPG591LVctfCrXB2XCz68fMSK0KtDq3TBJFhOmEP9WJIS2BZwPVl0Kyf2QPg9T2y
 V07Yp0yozmvbuRTwrO5kawqxxH2854udGp7LqOgDkl5Cy9a6vFE1uKri+fBLlt3KocuFh3PsW3l
 YcmIPzFbzTFoq0ObV9S9XjDu0ptYd8L7yAcrZfEQmd5U/ikByDQZvua3IH+BB+Vh8DjGMMp4kmw
 Yn1QdHcZTSk0Avdc4KP2j2ia8WlCg05heyw/5Gx9W3UPfj+h2oxrO4QWXUG43vUivJZLDMyeXPb
 Ou3qOMXQSJhv23e//AVM1VTb/d7Xw74ziQufjMDSN4in4IIiJkXc=
X-Received: by 2002:a05:622a:2304:b0:51c:196:98d3 with SMTP id
 d75a77b69052e-5213fc578d7mr195671481cf.66.1784700491967; 
 Tue, 21 Jul 2026 23:08:11 -0700 (PDT)
X-Received: by 2002:a05:622a:2304:b0:51c:196:98d3 with SMTP id
 d75a77b69052e-5213fc578d7mr195671141cf.66.1784700491183; 
 Tue, 21 Jul 2026 23:08:11 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49565373200sm110860865e9.5.2026.07.21.23.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:08:10 -0700 (PDT)
To: jorge.ramirez@oss.qualcomm.com, neil.armstrong@linaro.org,
 trini@konsulko.com, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 marek.vasut+renesas@mailbox.org, shawn.lin@rock-chips.com,
 igor.belwon@mentallysanemainliners.org,
 yoshihiro.shimoda.uh@renesas.com, alchark@gmail.com,
 tuyen.dang.xa@renesas.com, padmarao.begari@amd.com,
 macpaul.lin@mediatek.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com,
 hayashi.kunihiko@socionext.com, dlechner@baylibre.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/5] ufs: rpmb: route OP-TEE RPMB secure storage over UFS
Date: Wed, 22 Jul 2026 08:07:42 +0200
Message-ID: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jO7SvoL43Tl6Fz0TGnOD8QXbTCIhbsKe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA1NCBTYWx0ZWRfXwADcXzq4EXLB
 5h0GJPVvw/ZgZtVQA9loH8Rx6NIxDjdIMe8CErxBL2z7Y2Z+N5585F/XDkF19Ovxr6LD67j3GRw
 MZb2BzaQfYlFzScK6c1T0I5wjHi12TpOVpuKg4O1gubPnlG8tlwGxUQ26axw3dOcFSjdWebkyu4
 W8irT/ZjYm8CNMzfmf9XHau+xTv/Ywii/FL5R/I7akqReuV5sOniuTdBFAIcEY3cYMP8x13KsaH
 WXF4bP8E6JMOSf0XVvUZNCZkLzum1cPWqJBzlyBDfAVNvrrsFNCMc5N8Z5eEcZg8vYarP6MCbVY
 RvoSVYd9+qKttwKaMJFYy07i6iLF8HM/C5jeneUFqhVEc0AxfXqAX1CGm1H+xuXMBMSvwKX63m6
 jucAPMyfU7L4zh98K2iQ/2N0dObRkoCjvBaFTlac9ScjMOOT+8Bj8L5ZnYWklPCufPKStQdVMKV
 qvLBs+N9KCDJA6B9/Og==
X-Proofpoint-GUID: jO7SvoL43Tl6Fz0TGnOD8QXbTCIhbsKe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA1NCBTYWx0ZWRfXwXQYTTJFIyQQ
 VHUa9UJ/eqhRUi1KCHBJzhbS3LGbWx1UXtGFMOe6tpKQPTKo3mYxifuKfdo7fbFuXN8DQBO8sJX
 w1r49Z/QdP3XbRkwdeRQ9hHPuJ+lQx0=
X-Authority-Analysis: v=2.4 cv=QK1YgALL c=1 sm=1 tr=0 ts=6a605e4d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=WO1vEFamxveZV3c57HoA:9
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220054
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=i5ZNUrFJ7D8/J5Kp8PZx/b8ujkZntNWmleH
 HIxXW4iM=; b=f5YyhiqDEjVJKvMax9TeYPdgx8X9AcbFaqEHhaZJOaXs10LhFOQ
 FHj3RYtXnNjpKRzpkHO6DktT6LPTan2FZ2LuYT05p2rwgTJs2KfxxvBysZRtQlFc
 vjqFn+yU/IEV4K2hsa/aIIpobAhPjUi6nPedHrfijCaDI5LF8GxKqfICiwjE3M/0
 WQoaGfPleq9YgC+ofkYfOjSvpd4CsSmcc0wO00AP0Bn2mddNBeWUfGODajv8kJDD
 oU93WzTc9ki9r6+qiiUVCQwiBBv7xEIzfGL3yQnPZe9ATCkLBXE69guufa33opah
 uDyQDyD2vyWOKDnRQe7nvIVoEfJCT9GInRA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784700492; x=1785305292; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=i5ZNUrFJ7D8/J5Kp8PZx/b8ujkZntNWmleHHIxXW4iM=;
 b=S6H0Jrytgfcd/pCyx9sw1ovFxg4dihbW+jkE7DWYZ2wxFTk+gj+GARFO10zlUER8gT
 C1YyaKTxShalb9pokt1k0mjF8VTHv67E+klMdgCdWe+bIXzDQ47UC18OzBaK2aIJSj6b
 FfJ3kmZ6iiY7vxYJiomN9cag5uySJOmIbxr3vK3UBNC2gOieWfJbE5hm4ckx5gSPCww6
 ML9VKcPDzxAX8/SADAmsZVRDloHzK8wdptTmu/uKrOypTgzdA933BgYGbbAyQFjt/I20
 koIZDt1arQSxQZlJ5HbBpghiqMVm3tIGHI4dYI7xPjYAgDKQDOrJLC1pUFMAeAdIW4/J
 wWlQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=f5YyhiqD; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=S6H0Jryt
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="f5YyhiqD";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="S6H0Jryt"; 
 dkim-atps=neutral
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
From: Jorge Ramirez-Ortiz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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

v2:
 - Squashed the standalone "retry SECURITY PROTOCOL on power-on UNIT
   ATTENTION" and "bounce unaligned frames through a DMA-aligned buffer"
   patches into the UFS RPMB transport patch; the series is now 5 patches.
 - Reused the existing ufshcd_read_desc_param() (now exported) for all
   descriptor reads instead of adding a new ufshcd_read_descriptor()
   wrapper.
 - Moved the SECURITY PROTOCOL IN/OUT opcodes to the generic SCSI header
   as SCSI_SECURITY_PROTOCOL_IN/OUT instead of private UFS defines.
 - Factored the UTF-16BE string-descriptor byte-swap into a
   ufshcd_str_desc_to_cpu() helper.
 - Dropped the ufs_rpmb_get_scsi_dev() wrapper; callers now use
   uclass_get_device(UCLASS_SCSI, ...) directly.

Jorge Ramirez-Ortiz (5):
  ufs: decode string descriptors as UTF-16 big-endian
  ufs: add RPMB transport over SCSI SECURITY PROTOCOL
  ufs: derive the per-region RPMB CID and size for OP-TEE
  optee: rename rpmb.c to rpmb_legacy.c
  optee: implement the RPMB subsystem interface for UFS

 drivers/tee/optee/Makefile               |   3 +-
 drivers/tee/optee/optee_msg_supplicant.h |   8 +
 drivers/tee/optee/optee_private.h        |  41 +++
 drivers/tee/optee/rpmb.c                 | 215 ++++++----------
 drivers/tee/optee/rpmb_legacy.c          | 193 ++++++++++++++
 drivers/tee/optee/supplicant.c           |   9 +
 drivers/ufs/Kconfig                      |  13 +
 drivers/ufs/Makefile                     |   1 +
 drivers/ufs/ufs-rpmb.c                   | 309 +++++++++++++++++++++++
 drivers/ufs/ufs-uclass.c                 |  25 +-
 drivers/ufs/ufs.h                        |   9 +
 include/scsi.h                           |   2 +
 include/ufs.h                            |  12 +
 13 files changed, 692 insertions(+), 148 deletions(-)
 create mode 100644 drivers/tee/optee/rpmb_legacy.c
 create mode 100644 drivers/ufs/ufs-rpmb.c


base-commit: ece349ade2973e220f524ce59e59711cc919263f
-- 
2.54.0

