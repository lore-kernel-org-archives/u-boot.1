Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F897C531D2
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 14:39:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53D1A409A8;
	Thu, 23 Jul 2026 14:39:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ybujq0kl706U; Thu, 23 Jul 2026 14:39:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5564B409B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784817549;
	bh=+NlKeg3ZPz9MGzVu7d0SG7peTPEUQQBCQLpjvmtHRQw=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=CZb99OMyaG8uc2fGwYSrends7XuZn44Fgo42CG89+mVuT7wPM6+xQgJVGQts0LHGe
	 3AiMR+INzo6n7WgUPi3341a9HcE+TfvjYlkk+loSb9MeIuWsq4XTxJUq6fYcA0V6/a
	 W7UKGG7KJnoqAwFMYrfqK/51SGhPY8xDt44/z3GL72JmrgTWuqdVVJnWrtXfDThZvd
	 gyyFvPKO8uEos6STqcXw21p235GAxXe3KelZy5+iYN0r2fegKE0acH74kLf98aVrBI
	 7Xsrm7cPbxn56L1BoIVBDLPjMnMaujjwpwWF1KypVkU462v7I0MOx0yEsJ5edAQmr1
	 dDxWajm/sCHlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5564B409B4;
	Thu, 23 Jul 2026 14:39:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AFFA44BF
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AD882403DE
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:39:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sIyp1jpRxnUe for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 14:39:06 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 41589403E9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 41589403E9
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 41589403E9
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:39:06 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA89E80287; Thu, 23 Jul 2026 16:39:02 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45E4B80087
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 16:39:00 +0200 (CEST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NCvnvD011770
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 14:38:58 GMT
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkayhakq7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 14:38:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c075c1e25so11262021cf.3
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 07:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784817538; x=1785422338;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+NlKeg3ZPz9MGzVu7d0SG7peTPEUQQBCQLpjvmtHRQw=;
 b=fWoCjLWrdXJZMHYQrYXWjbcTugCUEZJzUlC0B/3uodMY5BkQs+3UhlHkGJmhFuo3Gr
 LCU3WuZlYSpu58omKJIcLt66hi0g6S+BAnJlGxUFmHkGTOMN8Ur3dLKXDMYya4Jr2CqR
 kL12Nnyg/BE4uhf1ZmDEISYebmcNihCOvFT6BWfCa2/SjO9pm1raSHwcU/z8rsGntIrO
 8ygra8QgHj2ObkHhFtgsJ/moU5F19djdgUCWo97mvhU60qjmEtHIYpm9iMfRnnNuvLED
 Qe8ZGvbjGV9Jr6bhlL89kFErzrsJJ7cENhizp3mIoVVXje2L3lI4c0vWs+wyTVRC/Jot
 mlAA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrOg84qxxAv/xowjn71xI9A8A2+FZ68lDJDDWiAmG7um6tOECww3GU19bbbqxm7t/Bj4D9lAug=@lists.denx.de
X-Gm-Message-State: AOJu0YysoyfcCd3tthTBdoGt0bt+1ZTV3oLuWAUzFmyXwpxvS+1hxvES
 05/TV4ivyyfs30TlAOBSePUws59b6WmSVm6xJdqrqAw+8O3Foutl3goj38BeIzribdspXZgM99b
 JRdgzvag8RGENAYU5ZXnPDZIgNiilniI+kJsFCfkufr4xGMFhVuIfRZ4e
X-Gm-Gg: AR+sD11a5z9/c2GURIS72tJdgXUh8rXwcdpVeYa1dGp/sqLeSBA8m9yQrIPORR+w6++
 5+RembGBVjLuYKq4+dsg7lUPTgwPSxnHZExQZMNh008U45NxyIRQ+/VRGxT/KMZ6pTuO5BUVPme
 qrcnrEIHpKvzxoMjVCAJ5NhU8sS3oUCdpNB244FnJ7D2md77aOwI5G703IPF0EdiPUYq1M7VBA9
 dfgtchSgfpVyIvg8meeo++WxpgFxf6kwQ8T2y8PRlu6ELtSQLCIG2TlifcfzqoIBtFglssoLQIP
 TbQJ/wXQSdirn9oW2jc2zUvtPi5YuShmlB4Yqawjw/pzOyX7uJhzlZuOVdDDUnNgiJltc57ywY6
 u2EE6XNEI2OynvJjlAvkiEbrtHj7bkxDFXBEaFWmdCvNXr3WWXIo=
X-Received: by 2002:a05:622a:2b09:b0:519:ef86:127d with SMTP id
 d75a77b69052e-5283dd9487fmr33800291cf.18.1784817537609; 
 Thu, 23 Jul 2026 07:38:57 -0700 (PDT)
X-Received: by 2002:a05:622a:2b09:b0:519:ef86:127d with SMTP id
 d75a77b69052e-5283dd9487fmr33800021cf.18.1784817537176; 
 Thu, 23 Jul 2026 07:38:57 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c67339sm16968193f8f.31.2026.07.23.07.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 07:38:56 -0700 (PDT)
To: jorge.ramirez@oss.qualcomm.com, neil.armstrong@linaro.org,
 trini@konsulko.com, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 bhupesh.linux@gmail.com, n-francis@ti.com, marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 alchark@gmail.com, tuyen.dang.xa@renesas.com,
 yoshihiro.shimoda.uh@renesas.com, padmarao.begari@amd.com,
 jstephan@baylibre.com, hayashi.kunihiko@socionext.com,
 macpaul.lin@mediatek.com, venkyada@qti.qualcomm.com, j-mcarthur@ti.com,
 dlechner@baylibre.com, u-boot@lists.denx.de
Subject: [PATCH v3 0/5] ufs: rpmb: route OP-TEE RPMB secure storage over UFS
Date: Thu, 23 Jul 2026 16:38:17 +0200
Message-ID: <20260723143852.2287208-1-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HZgkiCE8 c=1 sm=1 tr=0 ts=6a622782 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=WO1vEFamxveZV3c57HoA:9
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 1ElAY-1fsWLwzGxQHPJMraqOgJ_TE9hL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE0NCBTYWx0ZWRfX81Pl+G5vUSXl
 xPkqaemgcL0X9wC9smZMCLAd+F49NyzyFGVmkHTCsr3pO3gY0GdAls3lSylzuV3kJYp7e+ua/CY
 Lms9VLncWyGbwowyYuD1CGVqkMFpnI4g/vYmDJXHeGqHhJjeinp6FSKDWkXa4EhMoF4yAnFZ9N4
 3Hcrd8lciZ2Eg75BchsyoW024Kez92MAcK3UFii4SQ0nwOVXr4PIOcFZ2fBRFuMuCY8zeVSpe+G
 mu+OAV1rLZ70cKUK2mOdqs2uRHMByQo+Oa+2y9UEE9Gqn8xb6kN3Af1mZcRePsmzWWgR6oKcBmH
 bRgGCcWbVBF8udzGza0hXt3D+1ayDFuKzlyTsQ39n3w4WyKH8lAvbtsp0JhfkP3q3w9q0LABDwh
 +60waHWa1lr3ElkOA1V3T6gCJHupbQxdMPcqsy9S4nezRs7Ei5Gi2w1tTdssuhtgzfWO/rLvDOB
 n+T/XCCanqMuBzx33Zg==
X-Proofpoint-GUID: 1ElAY-1fsWLwzGxQHPJMraqOgJ_TE9hL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE0NCBTYWx0ZWRfX31uGaVfBs6uE
 peDpNe4ASp/zht42+AksbXeLES6acOx+au/LvWq1my1Pr1X3dm+zAfmm7/ZtB4XEIIud7TgHYLg
 mppSQS2ltBoO+SLCJ2amETeIs2KsJoM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230144
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=+NlKeg3ZPz9MGzVu7d0SG7peTPEUQQBCQLp
 jvmtHRQw=; b=o74kV6YtKchw5p8CCGyAmP0Q3IqDTstvupm9fYg28UeSPeS0zcx
 CbdLSz3HRzIS+m+AeE+o8dG0Wjf6twfJfSGqBzH6sAQxLlHtDtWae6CnYEEM04jl
 FIQ/vMQnjvPOohDzcw3qQbXBunF2cWu+yLpIrfBZTTyNhfS28V5oLnnliRWqLGvI
 PPNjKk8bT3/9/hZOmQZsWt8eAWzVWV5R5T+7CJikp0UKL060GQK4ZEjvZUh9we0W
 PYw7S48HKMg5yPWG+zya0evugikrxE+NB2tncsRpCq5YwRVvuoeQc+uheFG+V9M9
 j3sqhIgY3gkvQulGvjy8YxIUAx/cEsmBgyw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784817538; x=1785422338; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+NlKeg3ZPz9MGzVu7d0SG7peTPEUQQBCQLpjvmtHRQw=;
 b=SMIYuXTgl/R9lDGyR7q/dVbOMKTO4xYBsA6spw8WDVX1QbOnYRvjOMVFuvM4VJfs3v
 RtK3/29xcBjU2vSWPE0uXjztYeAzZZEhMpgBsb73ID2wbXz4frzl5Rowjbct0gKxnLAw
 eKgliz9wGDcNVHq1aVisxQB+V/lJN/ZU73nFmbm058Ciny1KW8DPc34wLpFzF7PZrnRv
 hNU2LmBaJ76wEqw0zPdSfZsazjutLMsLRCc6gBKjXrJwidgcvw6iL36xOJhS2pJAVbs+
 PUnkERQzpTCVvm7rdI570m8K+2QcyDp8x6rFETFKcv/wzgJb+tNJwup/IaO73qJQMTUI
 2RSw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=o74kV6Yt; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SMIYuXTg
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="o74kV6Yt";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="SMIYuXTg"; 
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
renamed to rpmb_emmc.c, with the new UFS backend added as a separate
rpmb_ufs.c; the two are mutually exclusive via Kconfig (SUPPORT_UFS_RPMB
depends on !SUPPORT_EMMC_RPMB) because the OP-TEE supplicant handles a
single RPMB transport. The subsystem interface is UFS-only for now; eMMC
can be migrated onto it later as the legacy path is retired.

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

v3:
 - Renamed the legacy eMMC supplicant to rpmb_emmc.c (was rpmb_legacy.c)
   and kept it as a pure 100% rename: the UFS RPMB subsystem backend now
   lives in its own rpmb_ufs.c instead of being folded into rpmb.c, so
   the eMMC path is left byte-for-byte unchanged.
 - Added CONFIG_UFS_RPMB_CONTROLLER to select the RPMB-owning UFS
   controller on boards with more than one UFS controller.
 - Reworked the commit messages to lead with the motivation rather than
   the implementation detail.

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
  optee: rename rpmb.c to rpmb_emmc.c
  optee: implement the RPMB subsystem interface for UFS

 drivers/tee/optee/Makefile                |   3 +-
 drivers/tee/optee/optee_msg_supplicant.h  |   8 +
 drivers/tee/optee/optee_private.h         |  41 +++
 drivers/tee/optee/{rpmb.c => rpmb_emmc.c} |   0
 drivers/tee/optee/rpmb_ufs.c              | 141 ++++++++++
 drivers/tee/optee/supplicant.c            |   9 +
 drivers/ufs/Kconfig                       |  21 ++
 drivers/ufs/Makefile                      |   1 +
 drivers/ufs/ufs-rpmb.c                    | 321 ++++++++++++++++++++++
 drivers/ufs/ufs-uclass.c                  |  21 +-
 drivers/ufs/ufs.h                         |   7 +
 include/scsi.h                            |   2 +
 include/ufs.h                             |  10 +
 13 files changed, 581 insertions(+), 4 deletions(-)
 rename drivers/tee/optee/{rpmb.c => rpmb_emmc.c} (100%)
 create mode 100644 drivers/tee/optee/rpmb_ufs.c
 create mode 100644 drivers/ufs/ufs-rpmb.c


base-commit: ece349ade2973e220f524ce59e59711cc919263f
-- 
2.54.0

