Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8E0C43458
	for <u-boot@archiver.kernel.org>; Sat,  4 Jul 2026 05:35:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DC148484C;
	Sat,  4 Jul 2026 07:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VsFR5MaT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OMp2mmFx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE35A8341A; Sat,  4 Jul 2026 07:35:17 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 833CD846F8
 for <u-boot@lists.denx.de>; Sat,  4 Jul 2026 07:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6642AmLD1748161
 for <u-boot@lists.denx.de>; Sat, 4 Jul 2026 05:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=eYp+jYQQMLb
 3AlwO+SF0gvO+Bo/1M/3PteimWi/vyNE=; b=VsFR5MaTSbCWsj1g52tsmGp5e55
 6Fpz+VGsWpBA5llET5FVtWx8BuwEuKPSwN1BQYCZLrNbgEsRS9pCkSBLWHmeLBix
 2RZ8i4F/EkDTII8HuY2VdzWgbXPARZJHMUQit85in2HdPZVU17oja8x7jdOBgoNW
 kEtrf4vs1QsqksNpKGoCTZvmMcCU+tHhW/V1w42PcY2mUsJudIAPWd6vyNLVsteW
 dZaQPJ38fA3PmGVv86ey5QIU5eyviF15Fk4pVgm/Z7HLAVpNDwHhjwa5q9ZRxZDe
 9gXIiPO82cLdEtfFxz5tXDedyva9dlULITdfiHl9ubOYt0tqwuAvse/GEmA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4sray0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 05:35:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-37fc66ee6a4so2161736a91.3
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 22:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783143313; x=1783748113; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eYp+jYQQMLb3AlwO+SF0gvO+Bo/1M/3PteimWi/vyNE=;
 b=OMp2mmFxdArhBW6jg665ag2puHmMjL2uOD0EdXRG0XXUlBkhtk+Flk77QD8rUPW0ze
 KR2S+oEAoCXMdciNTrvsOm/7EhTgXEljS52wLr+OWO/rsil8kzwVpxxUeGVt5tKrDr2c
 PT1krfLhSPO5ENKwUdnxOgdnDuwCsd2DRwrpDHVY97S7CNgNgPC+aONPBeuGr4a/SFWc
 0i3W64PSBSBIVHpvs5YgdNnbUhmZUb/z+ozwOSSWxEvzVS7pDnQexLMPq23hoGW6zpyI
 NdTKPSSaDB+tkw8pyMvRScCYI/wJ7xeQRK/t0KlnGvr3qCnMIurhkLv1Vc/9HQgAwmJy
 yYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783143313; x=1783748113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eYp+jYQQMLb3AlwO+SF0gvO+Bo/1M/3PteimWi/vyNE=;
 b=EC7Nwo/BGDZ/9AaoyOFgFSpvBiaLz6fm1pi+jtvRePGoUKIOV9vJtBFgVP+R7Md3MW
 r3zaQJ+O4zIaZ3OkUxZK7Hhk1ZtneKaxyPyNe18IXaq1QF42xviNQbW5AdnnaMzZYq4P
 pktW+5L+hLRpVIlN6nlh19lOAvJ6vRvIu0cWqbc0v5f+Uzf5xpNLS6/+30FySIojtCV1
 SOq0z5MU/s5CH/U8RMtvZUf+KH/FVjdKzwl0mPYHAbabgLZW2+T+nyoEndNH6BVFQ08M
 OwOUsOAHNNhBGBhMANR8uuJux8ePQZG9j6qqU/2Jov1XXOzVuYAM5gmAFP/Rhl+A4uRH
 dcDw==
X-Forwarded-Encrypted: i=1;
 AHgh+RolXgWE7L53m9QseF1qBZeXz1Z3dbwW7UG+qtyaPvNhPvb9x2I2LQGWEWA3MF+uQeAX3yZ+xuE=@lists.denx.de
X-Gm-Message-State: AOJu0YzVGF0u6/qyZiiLj84KcUpkMy8C9gMFktEhaOMmvTDUii9fOBv3
 I1JJLm3XZlWJH9u9Sa5oLEF6k79eMGZROHZBE9axeaWxahFRzbJHb9I5hVp5cWsUpS3+fHIotW5
 knifdd/bAIl5kR0Vrp2xyS62aHPYzrzOXjTzFIqnb02qyrPKjar7VTu0i
X-Gm-Gg: AfdE7ckLrwLtJLD5Fn3L/w3WdzY3KZvzeAk06pO5pVk/T8jtJ4Y0M9mwJgQbGmTCNu4
 WdyTLxdaMklCWCqldHgdW+WnU+kyUTJJKxyXIqUX7lyQIvT/dUgXozUP1JjiZZzhZIhjvgifAFj
 TzyzZn2UbNkK4laLGbvUajKjo85TPsO8SGUC0qE8jA/QqbrRI9PTz6orf4ixAQfN/hw82PvHgNE
 UHUIoxoREyo7Tt6JzaqcCjOztMOhMBdN2LzjLrWptBdeAnTEjotBeD5xFuGAkuqTcVsfA9vqbf5
 6CpO9RaulIJPsDoC51gWCzCWZRSozjJn5bGP/xEBU2KTl5hHTkYDW0yyYO5ws9oeMLmrszRn1++
 UTCkQCg7uTHIslwPF6HD7RgG03r6b+USKiO/YT78KPYFf35y/ovg38ZrlbtTmTaCMre4ZvLRobk
 XK/j85wkk95a31wLs+TwqfgKRAHxVU4w==
X-Received: by 2002:a17:90b:5790:b0:381:792d:f993 with SMTP id
 98e67ed59e1d1-3829eb1d464mr2096903a91.17.1783143313053; 
 Fri, 03 Jul 2026 22:35:13 -0700 (PDT)
X-Received: by 2002:a17:90b:5790:b0:381:792d:f993 with SMTP id
 98e67ed59e1d1-3829eb1d464mr2096878a91.17.1783143312586; 
 Fri, 03 Jul 2026 22:35:12 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bbd221bsm28362250eec.22.2026.07.03.22.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 22:35:12 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 luca.weiss@fairphone.com, andrew.goodbody@linaro.org,
 swboyd@chromium.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 2/2] serial: msm_geni: Fix clock enable on error pointer
Date: Sat,  4 Jul 2026 11:04:52 +0530
Message-Id: <20260704053452.761684-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260704053452.761684-1-aswin.murugan@oss.qualcomm.com>
References: <20260704053452.761684-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDA1MCBTYWx0ZWRfX6SKSyR9R8ldA
 F2zyNMuv9+9GIhnwFqWQj/JOoGlBJY9nzyiyiIu/ButvIp2C9aWGaMgETeWrrH6xh0fxeiU+T5F
 H3YuN91nhV+z7tRKawptZElDuscYY6E=
X-Proofpoint-ORIG-GUID: tZwqo_cTYzScT_7AW5035XAO2t24r_Km
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDA1MCBTYWx0ZWRfX4iZXrW80XTS1
 a6PLNa4bcclGCaYonW65Xyp1Np8W22pHWhn52UxFpOCvH27vv4elGXVhGK+Q0JLP7og52wLiYGD
 2d87gC8IKUCFa1YBcT7yt203RHhHi+tmy6ARJx48hJ3VHwyTKyI23/OfF/MNqZwMueY73+5Zu2Q
 VloWlDKT3LwWrLTHblbGF+wPj6wVntNUNQiw+B7FZgcP88Y4ZFs2oYSsgzzOkt8JOtaG3dWPl0x
 FEhm3PYJdjUooMAepr+JAQGNfqGkfmFtuqVJyelRbHEHm36YdC0Blky0fr69ekq0rd+ODGWSDwT
 4nKrTnGonvFlvT9OIkuojbhaO4QNnA7NV84shbSpoDdIycrsn6y7GTGnEe3BTTeMa/oaFrbWdh9
 RZG1bjwnySxUgt6S/sN39Q9RuJo7zMDlghAXabs8xhfF8BLnaP78kmoQjqVuAtNnt5bHAT26n+1
 ZZJRXvcKyVReYajuUtQ==
X-Proofpoint-GUID: tZwqo_cTYzScT_7AW5035XAO2t24r_Km
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a489b91 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=enwCI8h027-K9Gn1bSsA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040050
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

When CONFIG_SKIP_EARLY_DM is enabled and no clock driver is available
during early serial init, devm_clk_get_optional() returns an error
pointer. The original code attempted to enable this error pointer,
causing a crash.

Fix by checking for both error pointers and NULL before calling
clk_enable(), using IS_ERR_OR_NULL() to handle all cases properly.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/serial/serial_msm_geni.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index 3dca581f68f..d5c4f3f1310 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -524,7 +524,8 @@ static int msm_serial_probe(struct udevice *dev)
 		priv->se = clk;
 
 	/* Try enable clock */
-	clk_enable(clk);
+	if (!IS_ERR_OR_NULL(clk))
+		clk_enable(clk);
 
 	/* Check if firmware loading is needed (BT UART) */
 	proto = readl(priv->base + GENI_FW_REVISION_RO);
-- 
2.34.1

