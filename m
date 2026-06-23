Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA97CD4F26
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 07:00:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6DDD849FB;
	Tue, 23 Jun 2026 08:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QxV9Z6+f";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ghrv47mB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B6A849C5; Tue, 23 Jun 2026 08:48:38 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59A76848DC
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 08:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N6clXv1628578
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UBuaUnkVV/I
 BufQ9E05pDEiDYL9KRNgn8IFIzkHTOLA=; b=QxV9Z6+fAv0WU848eW19/mwZUSV
 aE2qSMdGkpkofUFbJNPl0w5O/gUVPY7ncUah7cmR3Z62fXZbFJiMK3Uq0Fw3Gthw
 ezBmt0oAXjIcLOcTUHGCX66obvnh4Gb9S3m42nZt3I5SUQMmU8IP/Cqrnl0q9mXo
 +Ao3SGHrfVIJXl8SZu0U4itl7PUmU/nRhkYmcv71xItaZU7yCE/0NypEFEsq8uEt
 xIzDOWWQ+qpXZw0iae19c+dHbhkzavqgzxpoXD/jT+UGguJSghBBAnbGN1xCdocJ
 j4S4BGv2fQMEuEhoUhQeNUxAvb6yGP+eYfKX4R6Id/3wFziLY30i5JJ2KLw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yhv00p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:48:34 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-37d4f23eb37so4251894a91.0
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 23:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782197314; x=1782802114; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBuaUnkVV/IBufQ9E05pDEiDYL9KRNgn8IFIzkHTOLA=;
 b=ghrv47mBB6iK29aTEJgDdF2PbIgzom8ZEynWI1y88WywZXayOQ8O5B/mwQ8yFPqh8q
 vivnTn4X+SDSJTKnwe8nGf6wATsE4M/pHQqIxowso+rQ0Q/7HkBXnFkLKfsEz4HXf8gu
 10GaVTtQrZp1glyHC8cbTesrt6VR302F8O/otUkSZ4VTWT8LGDbYJk6YglzklKikFd2D
 Z3lpJ/L0GK8sSO8HUPjfWPE9YDWfE+VtV7rzvZ6ZE+SoYBpi0wPv4cJ17DXd2/FuTfV4
 sSwkdlHn2RvTxzfDHFie12S07/519/E0sGpwrzonIuLwvo6kAX/mQjZe4Xkyr56a3hDx
 1sxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782197314; x=1782802114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UBuaUnkVV/IBufQ9E05pDEiDYL9KRNgn8IFIzkHTOLA=;
 b=RIKDU/P+S62LHAxf0ZOvmD40asMSx149Wwlz8J2mHEkMk6Pa52KCkOwwbRgE+W+yu6
 IiUNUhetDEnidg8Hm8eb06PCeG4x8AaeVahODkEB5VQoiynozOW7QiqV34IN113ovu/p
 2wanieWurLeP3OpHxLu4cOo6kuEE9J7JfVMohLY/kGq54Y4/ok8+oZLLwLVuXMVTM6HZ
 LwSpdG+1VYabf10vN3+YPOBaPS/gwvXA3Nb0fgqQecBA/95qzTlqT4UMF2E4ykMUK+Ly
 UQzeRNkgYZjinm8o0teVKOGLUp9YlDTKMnsiAxmqp2+3G24YJK+VGXizcUqJ2JUDixyD
 A6FQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpmajgEohCPn5Z9owmr1sek+orkUanOtbKXgjhBDzcdXGhOIoW6hTA6uufuhMIYv6Vo2C3iWqE=@lists.denx.de
X-Gm-Message-State: AOJu0YyVrfwlxqAooJApO8b5u2f3yh6j+j2maltxHP1R+df8dK/PSPRl
 GsZLvDBqAir2Ls54QyPYl6FwCtt44RjjLx5lMx7G1u6upYcQOXn+UETK9ittYgOVRCfxDyi8mty
 ageEX9amRtSGQPQe02P9ecWGi6NJxBOBdLlddEMF6XM+jvu9ytXxh0tPv
X-Gm-Gg: AfdE7clA6QaV7wnrcIJx9iPX3ZIlSDyXssc3e3Aj4MbjiwOaBIM7S2EU98QBo1gIxlz
 bXJVYICixBoMAclD/+YEVp/crz5GrwqUBn5Xt1R0Lp6NeAdJkS5Z+AqDKc1St9uV08P/OVy9d/e
 CPGNZxbtfFu3iXaBoPj1QLtz5QCyjpKszM9LgVj2G2Oy9xNgJKdaSMzb0WxO7Py2gVWpZOWYvrq
 dHc1mj+4ajelRmiYGXJfOTcxbygFxhJwnKTIMqnOPk2JdBQ1RuwH8jt4n7ETGKlFeXXUB93w6sS
 DvZ1Tzayx85GhVWHikjK5wGSsx1tsqj6tRV/yXf810qqMk75somx7Z4iAxuqMekQQq9Tb9UyXFh
 2NWmgGn7XywHyfoebbDN5e9yUEhrUAlSS9aksbB123gH1KQ7HgNrxb2ZBnOZwNjCNqyZ4oadVCj
 tUKqby6hxc0ZjqT6v60kWfTVDGhb9SvAXTqZB0yGdu
X-Received: by 2002:a17:90b:2b46:b0:36d:6315:1de4 with SMTP id
 98e67ed59e1d1-37dd0dcb335mr1995030a91.17.1782197313645; 
 Mon, 22 Jun 2026 23:48:33 -0700 (PDT)
X-Received: by 2002:a17:90b:2b46:b0:36d:6315:1de4 with SMTP id
 98e67ed59e1d1-37dd0dcb335mr1995010a91.17.1782197313214; 
 Mon, 22 Jun 2026 23:48:33 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37d4eede23esm8951704a91.2.2026.06.22.23.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 23:48:32 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, marek.vasut+renesas@mailbox.org,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org, varadarajan.narayanan@oss.qualcomm.com,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com,
 alchark@gmail.com, mkorpershoek@kernel.org, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com,
 ycliang@andestech.com, n-francis@ti.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, philip.molloy@analog.com, ravi@prevas.dk,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v6 01/11] dts: ipq5210-rdp504-u-boot: add override dtsi
Date: Tue, 23 Jun 2026 12:17:54 +0530
Message-Id: <20260623064804.3988799-2-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA1MyBTYWx0ZWRfX7KPfOKPePFwO
 5PpXBebX8HFAYxeUwBQHpxlzjAtrLD31oJyw3q3Ojcy08L8e9mu2Wy5Df8b/wCJy03Gt5uGHbbz
 /6Ibcb5lJaOhSf9oOzgOCzxEQKuEGoo=
X-Proofpoint-ORIG-GUID: 7-WHHk-tWeSBOa_LVSL6fjApiyczQQMq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA1MyBTYWx0ZWRfX/6eI80IZX/hx
 tXCwXi8hFtmz0zqu3DmQ40Y5ps4lgz8YpbY6va+GCdE5ehTRrGxpQLTa2Srm6mCs2t48mn5MLin
 20pihMzcksjbid6qvXZze7qIBUsF93hsFEwkODAKTzge3FKRXVxDI/iFe+4qx9Ho3PT9MPEScGU
 DzlSW/nKbimOJB0k20vQOMoUeBaXwmWNW8EjwL8ai6PM87SO2GoTcwUFvJ3bnbp2W3vJNo6hGAr
 SSzx2QwzGAudlUGD+CXM8RdnSBTajGtBHqPuXtkoeWkkf/AeO6kN03WQzw9fLvISozI50i5xNBD
 5pKiMoT+s8MunredSqUTxrxPLusHwRgE9Y8QWzFGZNoAKlBZi595Zx9RiWAqFqoR5WXz63uWi9D
 NEeeKB70BPLJq6omLbEdvLlO2ygwwtE5SkWDJFIBMDq5AzXqWgvjZOr6Chd74V4VEk8eJ8Icnhw
 ZjZIXgswYcguugSinKQ==
X-Proofpoint-GUID: 7-WHHk-tWeSBOa_LVSL6fjApiyczQQMq
X-Authority-Analysis: v=2.4 cv=cKbQdFeN c=1 sm=1 tr=0 ts=6a3a2c42 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=cm27Pg_UAAAA:8
 a=EUspDBNiAAAA:8 a=31KvTjPItaxnfPctQswA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230053
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:59:38 +0200
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

* Add initial support for the IPQ5210 MMC based RDP platforms.
* Define memory layout statically.
* Mark the nodes that would be needed for SPL.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
v6: Move out binman node

v4: Add binman details
---
 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi

diff --git a/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi b/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
new file mode 100644
index 00000000000..b3d048dd251
--- /dev/null
+++ b/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IPQ5210 RDP504 board device tree source
+ *
+ * Copyright (c) 2026 The Linux Foundation. All rights reserved.
+ */
+
+/ {
+	/* Will be removed when SMEM parsing is updated */
+	memory@80000000 {
+		bootph-all;
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x20000000>;
+	};
+};
-- 
2.34.1

