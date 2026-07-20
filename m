Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2A5C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E637D84A1A;
	Mon, 20 Jul 2026 10:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ehr6weu0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XnS0fH3z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 266F284A0A; Mon, 20 Jul 2026 10:52:24 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EA0684974
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K76R4H1712960
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 08:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3ZSdkHgSGty
 uH8RcUgEaGCOxWugSg0hE1yNMneYZEIY=; b=Ehr6weu0CEWgVnh8cx/BJKETI18
 HZa+toH0dJ5NkKjIDidXy8a6IOHzSffFJm8N7kZvA+7ab0vYB80FaFFR59xCEeC7
 dRKx18tu1Kjr36GUgt+EqKaxa6E6y6a3eUIeKxlIt0CRmv8zK+X0my/cVkDkqDY8
 qmJjKF5wZCphEzGlPhvESIP2KrWtQFg5IBRlGZANF1jaq6vaqWZv5B5eRTjagcE3
 CXRNGBtpc0vI4W22fhY+Ip96fnuzT6LHJONuiJRy4CsbOoCaSAuBMTOT9JhgHg9M
 URRthc/+oSrud16ZwGRAAl4UQMUWGfqMoOBRsKDZEKmrvp2hK74hogCHIUQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhf0c0cyt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 08:52:19 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1eb52e1fso78192631cf.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 01:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784537539; x=1785142339; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3ZSdkHgSGtyuH8RcUgEaGCOxWugSg0hE1yNMneYZEIY=;
 b=XnS0fH3zrhIrJm4EMNP0Rg5XmpkfKyfXqL9mpo6U44GINh3ImEPvZeQ086pN0lOb7S
 J38QYBQohwLzqKKOgX4JozHGCZuBs9Iig1wtnDjGk3Um/brQrFjs7mJ5ox7Nqd040DFe
 rL0UllT2vsF1EJlkOzSUYYCMl1Dg7GkrQ4o3ZPM/qcs8qJJINcn0FWgHDQ455zyDzYFs
 YS/8G090nHYr2VeHMGX/RNsOBwJkOANtMdtZbGtYJXumDWxAJDmWgW6sJIJBTElsakzb
 ECvKX90Rs6SB+Kw7FmLwlM9IbWqU1qK9nQtIRj21B/CxP3okweZ1aZ5IyBXB7t7YPFFD
 YejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784537539; x=1785142339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3ZSdkHgSGtyuH8RcUgEaGCOxWugSg0hE1yNMneYZEIY=;
 b=RrCA8ncSLeyM+dLJeh8RplJIPjYF/pM9GkC/6AULFI0AKKM5eQKZl9atOiqlOnhoIo
 1tj2cad/P8PmgaSAm9ySyJGFl6JPxjU9j/AAj2sRo5NMHCW/Xt4V6eA6A1vFpkoWUep1
 H0AI5Y3i9hVgwnovyRaS7Rjoe9nLsthcuxrCwnLrb5uA7tuKIw2rxsKGXpaAjgyJsO3y
 wjsDYgA5YC4b/DQUgMdM5ygxqHzcJiV4/kAKsBdtTheyub2WloRK7z/M6W42JFq3YIdR
 NSWHMifTIh/pUC42eD7RJgDGx3ji3/HXtxxa0Q+T8QySmbpPgrWD69qcldkLA4892i8Q
 sFlQ==
X-Gm-Message-State: AOJu0Yx0wAgpxAD61EA+e81bWb4ilZ/clquC73AqsMOURo3Thv3NbC/R
 sLcx1Zz4uS/gETCz5Ow708FTk7vdLfxqwJj2k2nONTBqd3TjjVf+BbVJaL6eNPy7dCJO77aYi/F
 Ky1WePGivva1L2hoIEJN9vA8KIol6NwXp9ViK3tJWIyVqVVTVldQD8y6a
X-Gm-Gg: AfdE7clKQ3B6kXZE6WUkhVBI6mFAz/cQ9WHBpVqIVL92mgB0sfkXjRXJGj0nai7hY8E
 wSLytU2f/Z+V/hxDhbOwaYH900XeYawXNDmVIymnB0BFwqZu5eZpkSckeSZrERq9Wy2486wh+ZR
 VkDFiwvI2+wl9DtIweD2lttoMSAN7+0XG43CZSdr/3Nthi3XhwPm5V20BMyrVWbeZ+G+ZzCfnvn
 AolCxqcwu9+br0BtLJtc6NNFzMnnm2YjcngE7KoRjM/xuxUYqkRws12sUYGOn3Vy8Ziu7UMcKGY
 UHBqtN0bPUFwT3DeQ+Hq4KIDK7YmhWJQR4GQ0hg/3LzAabKXgPYO306F1tlIpxdpw02i4yyr7I8
 qFqN8QcE4nqzmEcmYaqMlmzoYK/2f+ZW5UsJmeXsBxyy1xpYt6Mg=
X-Received: by 2002:ac8:7c42:0:b0:51a:6feb:dc8a with SMTP id
 d75a77b69052e-5213a384365mr117815141cf.18.1784537539003; 
 Mon, 20 Jul 2026 01:52:19 -0700 (PDT)
X-Received: by 2002:ac8:7c42:0:b0:51a:6feb:dc8a with SMTP id
 d75a77b69052e-5213a384365mr117815071cf.18.1784537538642; 
 Mon, 20 Jul 2026 01:52:18 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e499c2sm26450052f8f.4.2026.07.20.01.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:52:17 -0700 (PDT)
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
Subject: [PATCH v1 6/7] optee: rename rpmb.c to rpmb_legacy.c
Date: Mon, 20 Jul 2026 10:51:46 +0200
Message-ID: <20260720085202.537019-7-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com>
References: <20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HeYkiCE8 c=1 sm=1 tr=0 ts=6a5de1c3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=H4pw0e22ym-jj-fGjdQA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: HteBp6bPHhsH1xbsgl5LZwnAJsfSojyr
X-Proofpoint-ORIG-GUID: HteBp6bPHhsH1xbsgl5LZwnAJsfSojyr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5OCBTYWx0ZWRfX6Oe4OQTfCJPk
 Jy47IkChTHF9aplLPoBSYkWg9lKT2RzItDnR7XayI1VbVJ5Wt2UyWS4PBHVrKlnpMPOifxp750T
 kyX2dlPHz0VRwj/e72/NUztBBNbGwWM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5OCBTYWx0ZWRfXzaRU1TrEnjrq
 MwjV3ioHmhcFUvJx9c+mIThEHOydFZDtzfyqGUthknP0mGU0E2/pc+QDBxQftS1StJ4fZrfxHg8
 LWCqaok4SriC/yurGfkeQ8J3yb8PkPGpsjyVlCWovy3jXW3JwvNeePsELQUhtmRCiPIs9eu+SCP
 C7cjuRvP1pbVtcqtxQ8XHW1MfbLiFE9bulXv4Rt8V3LShk/2/PBFDU5Xap2mgKnglF+N+19NAuK
 e0VUDVGh/QwfsNs2ECeM+Igsr7mJz3idZnD4A4pCwHgID8I1BQY7YfzJcu3ZsUY/SUEWu15wpcf
 wpRH7YfsRS+U1Sm7+s6pfKWax32emwlLgrWKrEVn2nx7nHEnjWeLOuj682svmQjON1Fj3AwnXRD
 W0EwmHy6o57jJoLOIDcYTjpzu5a2ua4W374YPdgzoX63KoBBGEuHx423A1qo0/sdGJa8utnVRgL
 PYJo0DZWycGVsaHaGOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200098
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

This file implements the legacy single-command OPTEE_MSG_RPC_CMD_RPMB
supplicant (eMMC only). Rename it to rpmb_legacy.c so the primary rpmb.c
name is free for the RPMB subsystem interface added next; pure rename plus
its Makefile object, no functional change.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/tee/optee/Makefile                  | 2 +-
 drivers/tee/optee/{rpmb.c => rpmb_legacy.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/tee/optee/{rpmb.c => rpmb_legacy.c} (100%)

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index 36ac085ef42..8321cf53a19 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -3,4 +3,4 @@
 obj-$(CONFIG_OPTEE) += core.o
 obj-y += supplicant.o
 obj-$(CONFIG_DM_I2C) += i2c.o
-obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb.o
+obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb_legacy.o
diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb_legacy.c
similarity index 100%
rename from drivers/tee/optee/rpmb.c
rename to drivers/tee/optee/rpmb_legacy.c
-- 
2.54.0

