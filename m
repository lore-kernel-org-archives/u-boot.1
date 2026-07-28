Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F354CC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 19:14:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD7B840A59;
	Tue, 28 Jul 2026 19:14:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LbV5PN7h4KeX; Tue, 28 Jul 2026 19:14:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BC58840A41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785266093;
	bh=7NH+juqatEeGcxJfIouXrNACzbcJdOayGkTgQx1gOOs=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=oJfH310XPVR8hbxjO0QNJKYtc24AIwqQnxX7pdRaiUvpSYcWNPfeGxY++GzHtIiaY
	 eOnS8lq3qxfE96gdh8VHEMTHqA4Xki0Bwmjg0ZxtFl/kgsblNWnetI32PAvP7WSYeb
	 Wg1FX2GdQhsuLR429bXRfD91MxyyzQfMpQktkMoUmihMgyUblr/wj3Tm0/bavISgoN
	 A32y20RiVTr2IfEhNdlC4te9F0HqpDmh+HHryNXC5q28BofXRPD4yqpbwY1rnUa2jh
	 sulRT72q0W4HVSHRhUXh1giX7Hhy8vFuBOhIjyW3+wxm02Jfy+kXsAOAgvHwN+yzuE
	 kOl8wRph+1Kbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC58840A41;
	Tue, 28 Jul 2026 19:14:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 284A14BF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:14:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0EA0640A3E
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:14:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XxHxVDLG2R3E for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 19:14:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9D67440A41
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9D67440A41
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9D67440A41
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:14:50 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 983078494B; Tue, 28 Jul 2026 21:14:48 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D9008404D
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 21:14:46 +0200 (CEST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SICDeg3505803
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 19:14:44 GMT
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpqxjk9xg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 19:14:44 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38f57e31b6eso152510a91.1
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 12:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266084; x=1785870884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7NH+juqatEeGcxJfIouXrNACzbcJdOayGkTgQx1gOOs=;
 b=PYnvRnMUUMf3LbE9PnJ0Ocl2UpsvCW9R6RWIMD5ltLUfvqu0Nl/O36uIwu+iDfdiMN
 WrhdV4jfIVGVU+8FPHlP6fLGlZ2SSfnFWtc2YXRFg328YvcVZojwM6Xc6I/vin1b1Ti8
 PuwetvdKy9jDDexAg7t47S38gZ0avQJz7X8E9tCdV5nJpLkPA3uxNC2F7CQ9LzbJtosC
 OELxWrLHeH2//Guvp76uLuCnQDZFN2piX5Yx86fsh4SReUGVzPqbCiWuOzjEQf8tkHPF
 KZxSUVffJ+0Z22yl1chQPVJVgbBQMNLSHBL090qws2X+an41avq5/9wV4Z3eCXuIy03E
 VmFg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrHaY/NtCdGtFD60nTzNPamrh3z6TrSv1oJbgHxagEBjP/cwSQJqgGtdDT5lj6n3C8D+Qyr5zg=@lists.denx.de
X-Gm-Message-State: AOJu0YyvdVV6uMAJeVl1AStN9ButTADxeluthu0yIvcTBBsYT+hUCVi0
 FjFy/2Di30F/Vw2UzxGSu6vIreDCbrFqwvwuHhCDyleyK8jjJpE8cJt6+GPE7g65+GgriJk+vRF
 1ux7wenlEtmkKHqQ4K0pGnwpi4fjhHNL5tljAvzcZbjtUb74UkKMFy2xm
X-Gm-Gg: AR+sD13e+IAuSn00oe+eQk+6LTy9A+vRjud2MHAKObau7s9CEXQL7mFb1Wuocg1UG3t
 8ECqppFieBaule6dXBtFAEi3nCssLRMuiDaz4fGOmdtAPSqst2k0mgCOoO3YAXZGr2TzksaiAT+
 8sL1drqCOFKIUUP0PWVqiPKGJAalK6Gm9ro0YY241c6p3/VoAsWfAlgdUgj6PaNDurVE/13BQGJ
 swF5VyqFs+Gg9fqQfjgLymk4teOAAcRFUSHqHQzBP9iEpWjsG8EFMqFJH2jKzZE49tQSQlfDOrL
 8Ua+LvykzRdSni8lRPPcnFNQb1e+tFpJCdCilVNGG/ep60hl6ArzDa2vJ4EJ82NtkbEWmM6l+MW
 4a5sdOaNrr+9ZTyzYqOPu7AwosfL41bbpzy+4nT07PbSfEuQVYJJf+9yhKUz33LnK8vzguhdzEn
 bU3vvS+yafPFbX75a+CnA=
X-Received: by 2002:a17:90b:4f84:b0:38f:57f0:1f4b with SMTP id
 98e67ed59e1d1-38f6a460cccmr3820691a91.35.1785266083685; 
 Tue, 28 Jul 2026 12:14:43 -0700 (PDT)
X-Received: by 2002:a17:90b:4f84:b0:38f:57f0:1f4b with SMTP id
 98e67ed59e1d1-38f6a460cccmr3820671a91.35.1785266083252; 
 Tue, 28 Jul 2026 12:14:43 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504d373c3sm1261294eec.23.2026.07.28.12.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:14:42 -0700 (PDT)
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, quic_varada@quicinc.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 sjg@chromium.org, linux@smankusors.com, ilias.apalodimas@linaro.org,
 nathbappai@gmail.com, luca.weiss@fairphone.com, jbx6244@gmail.com,
 peng.fan@nxp.com, ycliang@andestech.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, quentin.schulz@cherry.de,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 4/5] configs: qcom_defconfig: Enable QCOM_FIT_MULTIDTB
Date: Wed, 29 Jul 2026 00:44:00 +0530
Message-Id: <20260728191401.849143-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728191401.849143-1-aswin.murugan@oss.qualcomm.com>
References: <20260728191401.849143-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bQ-MNUkqJ6h2vhPpiyZwkhHYZEAka0XY
X-Authority-Analysis: v=2.4 cv=MORQXsZl c=1 sm=1 tr=0 ts=6a68ffa4 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=uqFMpbG4MC8BjM4yXrYA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE2NiBTYWx0ZWRfX3mtDIYv/seuX
 nRaoEEHZzMYx7z+h2pcvjKnrlYxtjFv2J32az8gkirhpbBM8rqo8lL1ARl5/Z0Vh0sBc6gn+40M
 BVudLXFSWG/xQ17SoQ4SXbVfFHGglpw=
X-Proofpoint-ORIG-GUID: bQ-MNUkqJ6h2vhPpiyZwkhHYZEAka0XY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE2NiBTYWx0ZWRfX3kNeh5N9Dw9w
 6gjgGRzrjgzQhd/nikc9SaAGKMbDQ8EPQR2yQMR2v/VBSVTgj/FJcd3tmlhFttfhnEwTWuhEE5h
 lNxPqGXTcTMt3sO8w+c/X813km9+BiNuDHj9pK6sllnjvL0roWdbwwvvGdp1KD3j/TEuQ0DdKjr
 BqB1irFnH7dYckEW4FawUzVFkUCgKxw64CILu/JAqHwcTJ87ZoQVJKuPnCG2MjPRCfey+bPlYCV
 PYoKDfQYcibUhHFaxnPjq5Wma4Gb2lFS5GkwUx82iu7Jv9DOIKVWVd/k45bpTvPtyEvhITJgqf/
 O3XpESpbF4j3ba72zRx2THuAn80HV4X5aLJedRckL0CafnBIMn15NnUN36Akh2PBspBIPEIp9F7
 nbHXd86cj1i0uo1T1EN2v1qVfJkEkt0nR+u/C0NJxWgZVAqeVTWGE1rpBMD11KNFU+bus8Fq5xC
 klpN8hdSsRfxUVdQ5kA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280166
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7NH+juqatEe
 GcxJfIouXrNACzbcJdOayGkTgQx1gOOs=; b=EK0C7DY6qdhtsdco0+Mi74TcxsT
 H/quWueLFFT9UH+MZn73bMpIwF2ix213ttT6+N4H4RckAtHrTP8+fF2wAV3+PtGe
 t9hfUN1J1UtJjd5A7Hd3Z8PpxzIk1N7mYPKw+eO+LhptgAU/qZIKNtavSv58Dpsf
 AuAcKPDjZdLXYdH1t5C4Bi+YNlKPam+oA+YK/SehUISXCbFjO+HLf5EmeEYw0cXu
 AAd9VsRdKvUBZMDqNm2QFi0zVckrnx/MzaEc7Eewv4JHawlr3MVeSx/VbLijkQEQ
 ldbW2gOj7FdCddxLV+Cun+1yga7nWupoM9OeNQHKbA46Ni65IA0KWwPhKpA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785266084; x=1785870884; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7NH+juqatEeGcxJfIouXrNACzbcJdOayGkTgQx1gOOs=;
 b=eO2hIXdVUQMK+GT9CP0zNrxCbvSZ0+r1o+8Ah7PYZLlL0oP+aUrBtPViLuyTsyQasZ
 ckMiEb4AtGKGi4SdAhPQT+plQHfn1mh6u+X3B0SoJpvJ4pJcK5bJUXqUhODEuDMALafU
 9xQjJStMfS19pH8s13Vte1ugdI+1xZR3Og9VhrzSOWikRd2ag0rBjA6/CmAuwAoKBeRR
 fDpY90vDEtv4j4KU9cvRvb+j6RQhq6QZCC0SzWtRlGw9eIyu1Ouwm1rVhmRQ/zrSVbE+
 51m+Rl21xshVYxhgxx+mAc5+YZNI54sSPN+ygk+85lS84vIdv+egmtco5/qv+tIzirWj
 N5iA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org; spf=fail
 smtp.mailfrom=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=EK0C7DY6; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eO2hIXdV
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=aswin.murugan@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EK0C7DY6";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="eO2hIXdV"; 
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
From: Aswin Murugan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Enable FIT multi-DTB selection and its OF_LIBFDT_OVERLAY dependency
by default.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v4:
No change in v4
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 0cf51f0d9ea..aa97c41a63e 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -13,6 +13,7 @@ CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_QCOM_FIT_MULTIDTB=y
 CONFIG_BOOTSTD_FULL=y
 # CONFIG_BOOTMETH_VBE is not set
 CONFIG_BOOTDELAY=1
@@ -50,6 +51,7 @@ CONFIG_CMD_RNG=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
 CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE=y
 CONFIG_ENV_DEFAULT_ENV_TEXT_FILE="board/qualcomm/default.env"
-- 
2.34.1

