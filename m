Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D11F31E3D
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 15:39:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FBE084198;
	Thu,  9 Apr 2026 17:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mPnwXEck";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VDPjfbXr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 684DF84099; Thu,  9 Apr 2026 16:44:29 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51D5583CF5
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 16:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639CIHcw4107667
 for <u-boot@lists.denx.de>; Thu, 9 Apr 2026 14:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W2A8BsSQBFEXqOYWk/0RSBCeS7VYND+3j1QAiNCWzOY=; b=mPnwXEckSI1aix/3
 WN3ilWqAyUzcc/CbNhQLEw67cXBA84rtDizEozGnAPDwt1raaF2a0mTrC+cJTZf3
 pt636zSfAVPT5sZ/wJb2gV8Iht4OT8PCBCFuAXyXvPTHNWO/1Dch2fUQs1QERDel
 urArOUbTxZ+Z58EPxcKVkG0STyli97s7YxRVz5OIrHPOmYzBR+1rWLNTFeipG4xO
 ZZ+PMmQPeTk9njyHiBI7+PkeZDn4iJq+JCEWLmqZ/BHa41CkOauv2KiNOZNddgm9
 RsD5qOzQJVux0EZ0eoikO4NbvcHrUWNFjrEV7ICtVC0w/LNw1KBgFkMvOE1+JxuT
 lSdFfw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddxhakdvx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 14:44:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b242f76113so13241995ad.0
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 07:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775745865; x=1776350665; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W2A8BsSQBFEXqOYWk/0RSBCeS7VYND+3j1QAiNCWzOY=;
 b=VDPjfbXrWXMSD26H+mfzUN5l4wV5oM/G74okU1UJ1gpLhveGC3v0oQQe7E6FsiIgX2
 0q1G3LuTi3SYEdZpXs8PpF7JuxjfVcS4CU06QWrkC/Pr18buZP6mpVVgMKYduHxPHAeV
 hFfG7Apta4gWLDPSKde+47pjft5zXkH+RPHbj1fXB4CXw1excYqhkFl0Ct7/1ObMXJBa
 TIwJrfDphGLffZBL5sIY+RcKXpS+us6EqWuZcF7RTbEhPIp29d6lmh1U5gc7bf3h2wzr
 /TiaYWRCi8UfuBlyPLCZSRd/coARns9MmrZzLezbNRa4Gpa9vTdCJ8JldlrIu23JMtz5
 rtxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775745865; x=1776350665;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W2A8BsSQBFEXqOYWk/0RSBCeS7VYND+3j1QAiNCWzOY=;
 b=D7HrFdyhCyyqdvN4ZuMpsF5+PPqMVbhB9prvtYNDhkb8PwkwOWj8VlMjYZHB55CWR/
 a7t6XE9SAD0J+8R29KvJW3OvpcKjNxV2razNFagWo7gQU4tQNwkHpWKf62MJw9vuvNqk
 B96D9J1TT5S0b72ogkSxTSXpccCLf7FA6BzDWUyZmp90GKaBws7aJmYnsCV50AJU9g78
 VRxkEdRBXxYm51bhxFMkO64Fbzia0sza1GIGFjrJ5ejeaF5Ud3wWePmxwodjx2/yFA8i
 JXkNH8zHk/Jn/4Rd7z51vHZbkTMX4e/2FkDay9NtW3OpCcyTyg8Uq01iFY96gfhD9VZG
 GFeg==
X-Gm-Message-State: AOJu0YxmjzGlv0jdNZpQwD8fRofmR9GsMo1Kl9XLZ02NXOzqhpHYItUG
 +ZCXzt8vXUv19/6mVSmx0PAYKwLGR2PUxeV8n/j9m/B7HMtlIDBrzoOuxsTbMjp7HhQE3qPV+nJ
 gDxLVzk1LW6RGOBCYLmdrGlVPLYzF/Pi8AA6kmU1PYlQXsU+RHiM+pB8s
X-Gm-Gg: AeBDieu94GMTG5l0hLkD9Ui24V7l9YK9E0E4DXXVXNqfWt8FhlI6Sp5mePDbNN6MGe7
 1SwXeHYLRIJbQF5rPwQvandjHHiRfqnn6D6seMfLBUEpAwZPJjuLanwh35NYCiBFa4OdeUR3y6D
 dlFH22qPOhsTKRcdBUuk1+JBy5uw0s4UQKx37aG6+91qnxoreN3WYscvKhii/4EL3pyzWi76kw5
 LNGDvLujjGLBRcx7Xhg5NGwcmuXII/5ROsiRfOFDcKIbYzmcrrwS4YqVzL2g5BHJQLP34pGpCxd
 ch59vmpYvSwYGoB/DzWUf0h6NNW58d8WyLGVZk07zEFdq8hEWR+IyIHsTZ4ZDV6ftmkcVW3s4fS
 QJUzwn7Zj7FepzndWb0FPxXN2NV0Ls2WNi6kiDwJ9tnhbNxeqX46HbMvOssB+l+2n6lx+MAv7oq
 t91IHxN/A70Dy/OOaQvGBpNTQqYqW7ZKo7T3EN8ne/C/5pynitLA==
X-Received: by 2002:a17:903:3848:b0:2b2:4260:109 with SMTP id
 d9443c01a7336-2b2c73c6399mr40147815ad.23.1775745864306; 
 Thu, 09 Apr 2026 07:44:24 -0700 (PDT)
X-Received: by 2002:a17:903:3848:b0:2b2:4260:109 with SMTP id
 d9443c01a7336-2b2c73c6399mr40147445ad.23.1775745863686; 
 Thu, 09 Apr 2026 07:44:23 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749cbd85sm235083535ad.74.2026.04.09.07.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 07:44:23 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 09 Apr 2026 20:13:34 +0530
Subject: [PATCH 4/4] clk: stub: Add Kconfig option for SPL stub driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-spl_ufs_only-v1-4-f7e0e243d805@oss.qualcomm.com>
References: <20260409-spl_ufs_only-v1-0-f7e0e243d805@oss.qualcomm.com>
In-Reply-To: <20260409-spl_ufs_only-v1-0-f7e0e243d805@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Javier Tia <javier.tia@linaro.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Dhruva Gole <d-gole@ti.com>, Richard Genoud <richard.genoud@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775745813; l=832;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=1VTtqywsu66ZoAJvMDZOlPBc9boJLj0NkVEdqqJ+5pc=;
 b=Gegk31Z0x1+aNZMZxARV+QyurHfYtCG6zryu+1mDMUFBA34bvaDSUQym5Vqe2M7qEZsBVoSwr
 uoYIB8ObagvANy/kwguACSnyB+v2tMw4Zori3X74JSq3Rl8sW7V8zgf
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: XZ9pvzd1OZqxOYTMYzwbe4Kz1owyRbNm
X-Proofpoint-GUID: XZ9pvzd1OZqxOYTMYzwbe4Kz1owyRbNm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEzNCBTYWx0ZWRfX35l6YNsau4LA
 zO5EWiH01jSa6Gh5xTFwWZd05ba41nm9V112Q5Rm8uDsUS3jViy/IqjuU94oGlBvhAluShy8hbt
 qxnE8wleQRW502naTgjQmcygvFURDnX4K7BQNXTw3IaXfHhXxvePWeLtzbznYYbJBdKiLjZlXQU
 +OI9d60lszPbLmuNodI/pChO7ryEEsG4IF1YsgfYOc+qtI/D9f5MLV38sus3jzOxkBGKq0AbBhO
 E6vIW7yJaR50o3JQ0U4YEnwpgrFdJy2j+sHeqaNAXaznZq6zpzIyuPS629jwqS76sBu2YEoXful
 x0J6m2AAK1mdeQL11AHXZKnX7lQxcYkA93vwdX8fZiHPYUp57woNmzZAQfVbEik0MPSaagHZnt7
 t6Uw4Y/IzZtr/GaSMdejrxg3Dv0J9QyiE0QWcya/oM7IoBVyVAfAps6G1kuHksw2QYx7H+kp0ul
 fyH36KWufjmJv9wxhrA==
X-Authority-Analysis: v=2.4 cv=BefoFLt2 c=1 sm=1 tr=0 ts=69d7bb49 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=1BS4-0ygqXffVQKo0Z4A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090134
X-Mailman-Approved-At: Thu, 09 Apr 2026 17:38:43 +0200
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

Add SPL_CLK_STUB configuration option to enable the stub clock
driver in U-Boot SPL builds.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/clk/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c2da7b3938b..ca69577c060 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -114,6 +114,13 @@ config CLK_STUB
 	  Enable this to provide a stub clock driver for non-essential clock
 	  controllers.
 
+config SPL_CLK_STUB
+	bool "Stub clock driver in SPL"
+	depends on SPL_CLK
+	help
+	  Enable this to provide a stub clock driver for non-essential clock
+	  controllers in U-Boot SPL.
+
 config CLK_BCM6345
 	bool "Clock controller driver for BCM6345"
 	depends on CLK && ARCH_BMIPS

-- 
2.34.1

