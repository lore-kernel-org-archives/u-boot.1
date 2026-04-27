Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAA6FF8861
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 09:26:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A460841DF;
	Mon, 27 Apr 2026 11:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="I35eGGY6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KF+HdEdZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90D7783693; Mon, 27 Apr 2026 11:26:23 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79F92841DF
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:26:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R8TNeL4055027
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tTa563scjFybIlZgUtSjeKIIZ0CnHOhw5D5C7E49uw0=; b=I35eGGY6FFiOvPlo
 AqOLr2HGRvo9WYXar/mPliBWrStZlZtu4r87U7snaQMcJGsbJ4Sxhtv0CeTKDwcj
 ZWidAVz30FcCYzcyatbOOvk9BSRPNeXlrXknQetAdYP3pfhIA6qikH5ZuEGTJALH
 3PZi7wygT6XPWeeXH9WEQKN0S0EMTVxg5MI9K7fnew7vU9FzqxunxuyjYrETNgxc
 T86dYJ3qpYaK/aSsDu2f7IKdfqjbpnqkKT+1g22XkHYXZT12nCXi2UkmsNaQez4z
 yRSkq5Wy54mzvuoDLPF575CZc8vZVgcNfo8XhP9ne5WxfrCOPrM96UrK2P0OONAq
 kixMwA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnkxdfjn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:26:19 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c797d8c9c2dso10743449a12.2
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 02:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777281979; x=1777886779; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tTa563scjFybIlZgUtSjeKIIZ0CnHOhw5D5C7E49uw0=;
 b=KF+HdEdZ9r4WXqilcRDrOLBz8mT6UnnQl3/IZ8gksdolDuKdRJIc+5EWnf/e3l1zLj
 3feMH7P6etgTkbwzMG7KVGt5ghRTXW8m/FwE8+Fg7V1Zuno2joQoq1qqB1M3iHRf3t/t
 933syhV/ja+WPWOXlU2oIS2pPW3CwsmmLSncYXe6iEjNkH/Lyuh7ivgQ+LSWP/ZpOV2v
 GOQhzk7mdaLbHI4laqtkM9QbWXiBggP82hc25cbSw5/nDLxsO+w7oWsWTzNBQe9Nl7PT
 mboJvQtJJCoJFWJ8W1cFGf0e1z2nK4T7ROm+PmkdugINjs/3ZVvwNJax0HpR6bIjpOzI
 mqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777281979; x=1777886779;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tTa563scjFybIlZgUtSjeKIIZ0CnHOhw5D5C7E49uw0=;
 b=GwckuYKVm2nM7hMVBkJb73HAVujE4XJq6I72iI09/b05pUCeCNwxMkhDYcMuEHipD5
 fJyd77dKuFg5xBfR7BaH+ldj4GdxTBR6dU0zqNhL6Vh9/ZtVvye0uB384RYXU3Ii5G5W
 X5LO0g78RKwOQyR3kututaaXDp4T0FRXWomuPbodmPzgv/rFN0BwPv74Wr7n+npzQ3R8
 Szy8SDSIazsJblFfAJ7YT9tJ/QYArg5dlgNtiNecjzZYtlXO0FvfSJVKmK0/0O1nM2k9
 TFBpItf4d6WSnqjKW1E8hTDb+g7RbYUwBcMY9uz1CCeDSQ63Ujy45T26tSR3Off1htH8
 i+pw==
X-Gm-Message-State: AOJu0YyuR2jK/jWn40F0D0XjRGDxTslK56A426GKs9C9ZrFY7cRPGIMv
 UT3XvnJlSFU2T0ZsaCJD72aO2VdiyYFzWV9lwMTvE9K78Gi1jxGtmj5x/oCPSnxIEfveuMd1IxV
 r0Nw1oStQP0uHybVS84SI9VRh3q8bft/l/xxPN0pLzZWhJeujr5UeXCNR
X-Gm-Gg: AeBDietJtH4XMcJ7MtZ9amy/A+gM+WKy95yLUHDOgm2YC77wTyaC9L0WkELmtjZZC30
 jK7MMAKLAwJUG0nPJ39BbgrvKHNcoWbrjjjfJ9dTciNsml+fOUqYSkdXecGbk4N0/0b2r4MqUws
 MpGEVQJ0PQudwFHItGrk2YaP+LWN6rxsnZZznW3ddhP5vUsv4CXyl5TO3kVXomcnpiuq6IdP7fU
 xGxpj39tI5Jg+D6EmaYhH+Qaj9QsdQZzPd+aQZwq/4JydbBDwhsDzskIwtQYnC43bQnmOu8VWcY
 HqcMRwI2jy3ObY0uUZ/Tb/TILA3oLKlppS39O0g9AQB1V/VxNI+9efj2xOUFH/MtBMkMQ37tzg6
 NNs7pWe4IyKf4eT2QN+djsVRp+XWo3J7YQHouR6h2dbdQUNb6mlptSJURbaM4+kpnFZW+7WswY8
 jDoRaXyuspZVcYwVX5AkqIyDS6a98o0yJPaiI1JsAXKtGYjZmEIt7MEQp5jmjr
X-Received: by 2002:a05:6a00:8011:b0:81e:12f1:d8a with SMTP id
 d2e1a72fcca58-82f8c90497bmr45066483b3a.34.1777281978729; 
 Mon, 27 Apr 2026 02:26:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:8011:b0:81e:12f1:d8a with SMTP id
 d2e1a72fcca58-82f8c90497bmr45066452b3a.34.1777281978161; 
 Mon, 27 Apr 2026 02:26:18 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9819fesm31903133b3a.4.2026.04.27.02.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 02:26:17 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 14:56:05 +0530
Subject: [PATCH v2 1/7] clk: stub: Sort compatible strings alphabetically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-ufs_clk-v2-1-36e10a7c0ef6@oss.qualcomm.com>
References: <20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com>
In-Reply-To: <20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Wronek <david.wronek@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>, Luca Weiss <luca.weiss@fairphone.com>,
 Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777281967; l=1039;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=E8aGxAjxVhqq3Wf1vtDPHrqN6YIc1MOdU7gvsXrNZfc=;
 b=Tm4nyAd7VRDMbLb9u3qDw1wgXGtRf98F3r8KabrWEA6HF1cWAIh/1QsCQcELsQcaio8zOlul7
 MhlymerfpZ9A2583l3Xkc1gaieLWTYwEG6gmkWNymD+tCFPDKj5GdXN
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: CBBg4vGNNOW6hkJxJWUslgBXQkuzqBCP
X-Proofpoint-ORIG-GUID: CBBg4vGNNOW6hkJxJWUslgBXQkuzqBCP
X-Authority-Analysis: v=2.4 cv=TuPWQjXh c=1 sm=1 tr=0 ts=69ef2bbb cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=hAxWxQ9IVj5lvxi5g_4A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEwMCBTYWx0ZWRfX6s9MH0dOpG+z
 FTNSKHZT3E2sw51kK9Ips2S7woL7Sqeje4WqPsSVS9luKjRUpHsYk8zyCqRALylWWM4R14S1/wg
 FG4lTXSAfKDOnm1PoQJpOs7oEyGFxG0ULECRAFWKFbqdtxHhw6CRegvIsVz2bzdvONWGZouVyv5
 +ISvQc8JSuuJLHpL8jIyKITDpsvTn416FLYfENNzncpnH3vHfMyYP9uwij3eSKSfrFRPBm8JR3V
 v1Jvp2o/aDCsE530B9zOV7bAqJiqrqHjVQnfkZ67jbQdJrhtHVW/m8IzfQFJkW4LV6oDSUWVP85
 UXzPoC4B4Zgl1+Qlj51vPhtedF4FmPF0m3H2vCIqJ1ffyjXzPlQJiop0Bc/eiGJ48D8i9zmXN1j
 27XoqixZnv0RqKZoDDwyjoJwFuVmvTX7UriszM5/NOsjjFt8BduIAIphQy6oQzxiAX+WP9vOwmb
 cle0qOgl+2R11/jrC9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270100
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

Reorder compatible strings in stub_clk_ids to maintain alphabetical
order for easier maintenance.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Newly added in v2
---
 drivers/clk/clk-stub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index 117266ac778..ddcaaa00d91 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -50,10 +50,10 @@ static struct clk_ops stub_clk_ops = {
 
 static const struct udevice_id stub_clk_ids[] = {
 	{ .compatible = "qcom,rpmcc" },
-	{ .compatible = "qcom,sdm670-rpmh-clk" },
-	{ .compatible = "qcom,sdm845-rpmh-clk" },
 	{ .compatible = "qcom,sc7180-rpmh-clk" },
 	{ .compatible = "qcom,sc7280-rpmh-clk" },
+	{ .compatible = "qcom,sdm670-rpmh-clk" },
+	{ .compatible = "qcom,sdm845-rpmh-clk" },
 	{ .compatible = "qcom,sm6350-rpmh-clk" },
 	{ .compatible = "qcom,sm8150-rpmh-clk" },
 	{ .compatible = "qcom,sm8250-rpmh-clk" },

-- 
2.34.1

