Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69EF1073CA5
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 12:21:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C416284150;
	Wed,  8 Apr 2026 14:21:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JOe1KAPc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g8KvOVvz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E896784132; Wed,  8 Apr 2026 14:21:05 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1600838BB
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 14:21:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638B5dRm1314650
 for <u-boot@lists.denx.de>; Wed, 8 Apr 2026 12:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6N0UVmGyTe3
 PKWnGxyc/Z4S8g869j7Uf5QtNBFHExk4=; b=JOe1KAPcA/yDna1VBSk0xp1wiPh
 MmBvicKurHMcTCoQCk0vQOKAPahR7CaxKtY9iVnfBqzjwyFogweGcsszwNbWk7+E
 ZVC63QV4Mo0h8ixZJzsf/TnwOrnJUGhPxjQ4BK9KiwNIU4pSdiMWEKxelaxGiifP
 J0+B1hgyw+h6bo+PgT9orph2q4pP9dCA1HJ3VpsOZLBMQWpK4XmDbdxY3U1/pCx6
 E6ZWKo9NwwwGFe0pSfpugn5RyRZkfULAfQ6gPxH18YfvyWmyinqMieGwsKA/rpoe
 Y6XDTSwJNuAqjW6eCZOSCQY9SS1iVPA3cDxo/xRes7OMuM77N63uvI3DRFg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd8d6k5bb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 12:21:01 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c741f038f7cso3168244a12.2
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 05:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775650861; x=1776255661; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6N0UVmGyTe3PKWnGxyc/Z4S8g869j7Uf5QtNBFHExk4=;
 b=g8KvOVvz1x/zEApfA7NGTHfC1dYBq9rzkov9mLMmWC4e4ZQN7TWQtSQK+8eKUOTA//
 B08WCoJLtkIEcob6MBRF9GWs4EXfo5XErAU+7fKOl8tjxJFKfWpro4UEoIjzlAR3tDaX
 Wg4HtzE/w4UnzkWxTVRVk+UDKzKCHnLofgM5p43tQosK9AqGlIe+lui7LmMiu92DfZcd
 oyeZmH9vEK3hI2ywraGTMgAY5DwdiXb/kBX701IkQS1sf+THy3Xb8v9xnRX0kF/Ag2at
 lSM8bf8DIED5EXTxOjoq3SmNt4Bh0Gl3iE+NrjV/PY6RYCCP+ow8jEfpK5s0kL4vGOFj
 W31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775650861; x=1776255661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6N0UVmGyTe3PKWnGxyc/Z4S8g869j7Uf5QtNBFHExk4=;
 b=Dqdbt3w1x9YkevkmjxXfz1JbQhAvt/baHnHK/zx6U7acHydjSjAC1Rs4Sb/kldhBHY
 /grQ2qcx0OcaAMK6CJUpDIWk+uTeFu18hPs3llpsro/UO+U8WpFrwjfKbl8ZNAyxKM80
 r/ir+55/2YsJtJeXefMI+bqeNgKv1iOnDi4Y9KWl/HgJmd1RXxdIt+NWGZtHcTBslMVZ
 ysdqCcrt+Fy5qyVOS5NHiSnAA9b2/F2mTEKbWdaYnVNgDnnUH1Vg9bE+BihBrgzXPnUk
 heTCImYE2zgXPG1lBzIeVYRC2uB6QoqYXEY0o/Amsa47sHJrvMLVLoXa1zYeeGlUT3Wh
 JYDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMkkjLjS5697VU8Gt8Nj42OKDvU3fLvg7drnhRD9j5U342mjp2aigXIzvCLPaEWcM8tH7Fjwk=@lists.denx.de
X-Gm-Message-State: AOJu0Yxf/36/CrE0PoBolZLgikHNy8Gmimi13TO/rZBUk8vRUR/Yz3Qw
 ynhajOkEo/cfba+6lfoEGyQnXe7JllnFKIT/I8KLIdG51MK0uF+5ckA23YlaDBbIpEWyGLr/qZJ
 fXrRnsKhs50bEAt5Ao59eCIATqvqwBWra4ggaARP0+/NrtXKZYo29+TNB
X-Gm-Gg: AeBDievCYtxHB8C7T2b+/0qWJSjKzAmax8h5xwrhqWmlvXDc9MsykEkZ53MgvNpfhV5
 AUizhMpgwRYOWUm+wQEvfUeVOfFB7DMfgXsHtcNpjl90S9YtcsSy7PsLVXb+FNuhpBQx56GHU84
 YWbWaWLPKoYWsTvILzTK/U1WELYVaZYU8rUHJolahkb056dHcyl5EmTM7E0ZPBMeOaRxjS/r2Ky
 eFGOeQWqgLOCZfUcAshLfd3drDB8KjANi5AKVRClXwLApynS2PpAA7CzzIcGODM76R5oFHMKibB
 U6AX2rxYGCyHS3U6Ho4GKxCPgjIioeVzz8aGndoTJc7WbUU1MewfMubV5fWlNcVOr0QAwgtpnmv
 tfQxYWCcNC2cp5XU/bRocbC96q7SP/3nsk4vk6DeDT+154w/HtCaEn3xivSjspD6Q2/jYuFQmJv
 hm5ojt8a+M1sZ/sqx3jIogTlBorUD4M2gkUBdWoi2F
X-Received: by 2002:a05:6a00:414b:b0:829:b55e:1b27 with SMTP id
 d2e1a72fcca58-82d0dbcfa64mr20929604b3a.53.1775650861236; 
 Wed, 08 Apr 2026 05:21:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:414b:b0:829:b55e:1b27 with SMTP id
 d2e1a72fcca58-82d0dbcfa64mr20929577b3a.53.1775650860629; 
 Wed, 08 Apr 2026 05:21:00 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9a24039sm20512602b3a.0.2026.04.08.05.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 05:20:59 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, sjg@chromium.org, seanga2@gmail.com,
 sughosh.ganu@arm.com, gchan9527@gmail.com, ilias.apalodimas@linaro.org,
 mkorpershoek@kernel.org, marek.vasut+renesas@mailbox.org,
 hs@nabladev.com, msp@baylibre.com, ravi@prevas.dk,
 dinesh.maniyam@altera.com, sajattack@postmarketos.org,
 peng.fan@nxp.com, quentin.schulz@cherry.de,
 jamie.gibbons@microchip.com, mateuslima.ti@gmail.com,
 justin@tidylabs.net, wens@kernel.org, n-francis@ti.com,
 ycliang@andestech.com, jerome.forissier@arm.com, clamor95@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 5/7] qcom_defconfig: Enable reboot-mode support in
 qcom_defconfig
Date: Wed,  8 Apr 2026 17:48:39 +0530
Message-Id: <20260408121841.186410-6-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408121841.186410-1-aswin.murugan@oss.qualcomm.com>
References: <20260408121841.186410-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: x2FjtqFqJ93ehHGGolWyq9z1ys7Zl2DG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDExMiBTYWx0ZWRfX+R2xMNizLF9U
 iD3agxuMcUchUZUQgur41ZDMvxy6DuJ6cItymdqaU74akHDpeUOTfFyxeEjTkTLVlZY/Xu7fJns
 N1uIqztFoyEMcTkUsZKKojznN1cguNIWu5hZx4dLeWGGhQpdIMQwt+SALQ655kSXjP4l1KH0yYW
 IhReWJPgGClhBdvE75Dwucmoy3HOz6ULy9Zk4kexRzyKF9RreGz48vn/XR9mGUuqOVTjGfK65yS
 5imtipkbRPX+Q90/Mu/rBtcX8xz2mhZ72dEszNmlliQJpsgbWGyr6zRyQyXwYM+u7lrvdnNib6F
 RO64SE84vcMRFqKWtOmDncjFwRHO8DwVvfDURZmdUKyuQxCM5FnUI1BI0uCOZ/WKCoAkmfHeiVZ
 6bRCtntR5N2/OSTSAOnZcjIfZyojDpf7VG3SIl00rCCc8tzIxq4jcLtgmFFULCkGJTVhcm2XCoh
 fIvuEo75DQKag12xUhA==
X-Authority-Analysis: v=2.4 cv=GN041ONK c=1 sm=1 tr=0 ts=69d6482d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=cm27Pg_UAAAA:8 a=WZ0Oi6wz51U_qUjvFLIA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: x2FjtqFqJ93ehHGGolWyq9z1ys7Zl2DG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080112
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

Enable reboot-mode functionality for all Qualcomm platforms that define
reboot-mode device tree nodes. The drivers gracefully handle platforms
without reboot-mode configuration, making it safe to enable globally.

Add config options:
  CONFIG_DM_REBOOT_MODE=y       - Core reboot-mode framework
  CONFIG_REBOOT_MODE_NVMEM=y    - NVMEM-based storage backend
  CONFIG_QCOM_SPMI_SDAM=y       - Qualcomm PMIC SDAM/PON access

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v4:
1. No change in v4

Changes in v3:
1. No change in v3
---
 configs/qcom_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index fe5880de1fd..4ecdc70f307 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -116,6 +116,7 @@ CONFIG_PINCONF=y
 CONFIG_PINCTRL_QCOM_GENERIC=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
+CONFIG_DM_REBOOT_MODE=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_QCOM_RPMH=y
@@ -127,6 +128,8 @@ CONFIG_MSM_GENI_SERIAL=y
 CONFIG_SOC_QCOM=y
 CONFIG_QCOM_COMMAND_DB=y
 CONFIG_QCOM_RPMH=y
+CONFIG_QCOM_SPMI_SDAM=y
+CONFIG_REBOOT_MODE_NVMEM=y
 CONFIG_SPMI_MSM=y
 CONFIG_SYSINFO=y
 CONFIG_SYSINFO_SMBIOS=y
-- 
2.34.1

