Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15305C5CFCF
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 01:12:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D00DC6090C;
	Wed, 12 Aug 2026 01:12:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Urx6QrXPIyUC; Wed, 12 Aug 2026 01:12:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 09C58608FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786497175;
	bh=ak6hOb2/EATFHpBm5UHre2Pg25mRns9J/voYawB6UzY=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ZOGXaJx8lOofxK1IUQS6yTdj94qU1/yTdMwEqurQWFtFl5mlRV+aiTJFf7eZV4ZDo
	 nrsx7pZiFyexirRiJR7btHSpoihXl3UIQTnEH6Tf7SxYcmmzyVNrzqgLcA7M4TCXIx
	 yVeOC7g3GfGdo7EZKrARYTmaFSF2QM+6RNU2AjQgnLLK54kz827ZtyjD7PrgVTaM+f
	 pI/zqAM5MNJ9G4hpBquxMkhe/sm39MYv89rEWMQb3UTPEAjl3+vRu4y3MuEIty9S6B
	 EYlovOsvaBZhLznEg/UMwSMCBmH7onKX41Zf8yrd4HSJ57xweFOkcUQCKbYJL4Yac8
	 vSzKYc6dnG8jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09C58608FC;
	Wed, 12 Aug 2026 01:12:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A347D3A4
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A1166608FC
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NOFDQdI9it_O for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 01:12:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8628560904
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8628560904
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8628560904
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:52 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BNH2oD2071030
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:51 GMT
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g01nc3c36-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38f97b3f853so662561a91.3
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 18:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786497170; x=1787101970;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ak6hOb2/EATFHpBm5UHre2Pg25mRns9J/voYawB6UzY=;
 b=VtVsoJZvyLKUPEc+gJW3c6lPnoRhUNCnrn4wLVpBN3VuGQ+T61t/XvQCVuCYsXox7q
 NrnipZNZwW89xWM1Tlth80qTU764BgcMYoAAUv9PNG8QS+TJ3LoGrZDhKDl048SS07U0
 bIuXoA2R//Zu5d25Waju7BXwWRIxp8ekfbdstdoDeswNzx66tGIeW/KzFiBtw3IFfmuG
 FIzuDFN+dG3a9TUmabXUAj1c/qMhpZn+INKSuncGbvnyz2mn4KBecZnRaJlk4j7V+BMV
 924lEvb6F+5+Bg0vFrB+jkA2OrauJt983gXEsQ4M5zOBIsRTfkZNpXrga0sgWvr/W1Rr
 LRKw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrmCq+PE+OmGXvPMhK/TpvOoRxrEWDuJ1KafNQGMnAUHjbb1BQHtMX22BnSj1tZ4YS1GIf7rIY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyLZZa3xGwXQrlrtRb4ObTsm7AjWn4V/2KZCHrhZ7AtsVxWuJDm
 ey2hZ7trF5LACEtB/ffi2lIv2u5+VOu8RVfVNR2iwGAzg0baVgxl5TLuahv1UV1Th7G+aw4qJFi
 FHZiG2QVtFbTM4xGrbpXCB7oDtGdKjD7epN68Z4sHORC0N3+EGoa8Fid2PWg5st7hHonVU+M=
X-Gm-Gg: AR+sD13t/GETQqkpC1C1+Rrl8bCS78uX15oAoejSuf6JsAMMkyFLNpErOtP+L88IGD9
 c5FGkpsxqp1JOQwDfbkxoBxjstKAqrpcY3OM8cwxD1hEqEeZe8WcOtL7CODx0d80Ab7Ze7M3hun
 S/HgTCHaPBJvrRkTGK1wO85DDXzpyfgqW+abFscbNqD2avWmpReZf5uvboY0In0JU6x22rQEcJP
 xidyVySly9Y3biiJFowGFYWHrl0zwamqILMfuADWdYuf+9JtaoHtJhrW8D22prJlgV6sra0hVgn
 hdVvrsvWs0PUnhjIHULe1gp1z+srh/fpBbdbVgKVH8ZclUMd5P0IlVTAknLQ5oFDnDDHQas9P3L
 JB1cnYChBmqetBktmQT3MUHcYTioC45P0G4aXuZ++jLeeJRyXmmgqKQnUHP5ICFu1jaWtm1ZuWl
 +OKGoo6NKnRzwsBjTluIS7ENaUSkOS
X-Received: by 2002:a17:90b:2d81:b0:38e:3fdc:62e5 with SMTP id
 98e67ed59e1d1-39301648901mr1353403a91.19.1786497170192; 
 Tue, 11 Aug 2026 18:12:50 -0700 (PDT)
X-Received: by 2002:a17:90b:2d81:b0:38e:3fdc:62e5 with SMTP id
 98e67ed59e1d1-39301648901mr1353351a91.19.1786497169741; 
 Tue, 11 Aug 2026 18:12:49 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31cf6d7a366sm4371725eec.27.2026.08.11.18.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 18:12:49 -0700 (PDT)
Date: Wed, 12 Aug 2026 06:42:05 +0530
Subject: [PATCH v2 7/7] configs: qcom_qcs8300: Switch to monaco-evk DT and
 enable new drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-b4-monaco-v2-7-865d288c0be6@oss.qualcomm.com>
References: <20260812-b4-monaco-v2-0-865d288c0be6@oss.qualcomm.com>
In-Reply-To: <20260812-b4-monaco-v2-0-865d288c0be6@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786497134; l=779;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=65vXpYdHa8nCXtebg/bwjCZq6MXkdl1RqQBK55oB+2k=;
 b=CQTykXXUEFdgioOSKydC+8Szpkhd2BfCFN7kSwn7eOsffT7xVpiBph+pX43z3Bxo+OXbaHvYx
 DYDEUpJoUmEC80IXOhtRenAf9DBQ6jbxa0eB4Y63w/bTPK30NrYtpAN
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDAwNiBTYWx0ZWRfX7e+PHsKXtWRB
 nKIK34gLpz9ewXB9DS/5tp7aVGlifdFLvL96kavWfVkKLNcaitPpEDeuPKZk5tyqG6xulruyYJv
 dc16qHAolUToGpOeKbbDPTEPPZjw3Dk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDAwNiBTYWx0ZWRfXwSzopibKiese
 eX9fWSkV3mUyW5cXK3f2SrtCflQXJMyEFSqLIIc4RJN4KAgknIX89KkT9PgeYgtnAcHIj2apq/M
 B776B1/SSks9piQoD0EotyzUvcxmbmaIfK7rT6PLVtOvOEupiPq4FLAAZJxh1gLjw29flYIpFsS
 TMxya55wOVw7w/42L3Q1KbvdFh34OcUoGlhA5xrmkRR6dV0q1CVQF9alPDLEpSvswa7CtNG9nxx
 vs+a6R9t3fCa/5AWzFYJDraQUphcibUCG7UXfARoxF7gFN+ZUfxXAoCrvnsooWcQNAW/C4n4SgB
 qDjNG6LRRhshWHEVt2nmpTPhXc7/y+UYkCcNsRYdDccqvPzzrkg0i4RsyOes2C3XQ/IiUmyth/l
 fVlF9p4/wMq/jMI/QTlehPJXNVBlJiqB4Yp30UIOWZsznbXhtjmDyZIvwWfh7ypvVKqVdamQDn8
 M3zBKFzeT6YRfZLRzXw==
X-Authority-Analysis: v=2.4 cv=RY6gzVtv c=1 sm=1 tr=0 ts=6a7bc893 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=p8VvgLCOea7M2xW4:21 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=uNq1Cg9DbGaxvhqkZz4A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: 6z4ztCH76oNS9IuLvoZgyqwuD7Xqryvf
X-Proofpoint-GUID: 6z4ztCH76oNS9IuLvoZgyqwuD7Xqryvf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120006
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ak6hOb2/EATFHpBm5UHre2Pg25mRns9J/voYawB6UzY=; b=Kgjvr7lHA5lJgtVR
 Wwcx5S9QlXXN46Ybqsgg576+jvXxk8lXyYhh4neO8Hb0u2xNVlw2ifrSFv0lUjDk
 yJAeMspIPT/+BV4fesDPqhARyvRW5rl+QVj0Y3vxH2sElqX7gNX1iHpjXsM3Km+C
 4AoES20zLlKeDvuNx3BB0HZYgULuuQQshj+t8BCcamn04oorGfMXZ/GVwfB18NuA
 62brfiCnwklfmYfot3Ff6HhDqdo63WuHA6znRT7JlujTBLx+obKzuv52ikuVKOE0
 IiCekxjW6sg9DwBs8rjmT2wtBK+ShVgnrrJLlRba05LCdMhK723On7n/NeWavZxQ
 mVz9SA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786497170; x=1787101970;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ak6hOb2/EATFHpBm5UHre2Pg25mRns9J/voYawB6UzY=;
 b=kKfCmjVyrtFF7v9P2jPgmfyv/yTjEw6kzcE/HkJjMfx8ahImjago/YUuaGLxL+N5IA
 sqZmlihqICTU5GGTLVX8bxqYjI1QnDEdXqFQYMh6Rk1EqHVHgs0LdntLUzuOCyBkh9nC
 2VUkBTvGygBNZBwErHhd9p1MkPSWPqz2+S6SGqsXY0NqHP9V4dp74XuD4ZYTWPVBJ1v9
 Wuu7D2NZHF6rCVGXxDudbVjbHxNpnLg0uQocA3QuZ/sEyhmxzEg5xLtp7cM7gActVWUd
 Elk0cLUQVr5hC6+atraRalH6IInUhPu5wLP+zToOfC5Qjhbv+xHVY7akOO+n/7w79AEW
 6qrw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Kgjvr7lH; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kKfCmjVy
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

Point qcom_qcs8300_defconfig at the monaco-evk device tree and
turn on required drivers.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_qcs8300_defconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configs/qcom_qcs8300_defconfig b/configs/qcom_qcs8300_defconfig
index 5fffcddc16e..c8c4ccb9ab2 100644
--- a/configs/qcom_qcs8300_defconfig
+++ b/configs/qcom_qcs8300_defconfig
@@ -18,4 +18,8 @@ CONFIG_DEBUG_UART_CLOCK=14745600
 CONFIG_TEXT_BASE=0xaf000000
 CONFIG_REMAKE_ELF=y
 
-CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs8300-ride"
+CONFIG_DEFAULT_DEVICE_TREE="qcom/monaco-evk"
+CONFIG_PINCTRL_QCOM_QCS8300=y
+CONFIG_INTERCONNECT_QCOM_QCS8300=y
+
+CONFIG_WATCHDOG_AUTOSTART=y

-- 
2.34.1

