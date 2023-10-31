Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9F6C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 08:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26C078759B;
	Tue, 31 Oct 2023 09:24:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="OpuDHJjY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 065BD8759B; Tue, 31 Oct 2023 09:24:57 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89EB1874C4
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 09:24:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20231031082450epoutp0358655b0d173d417660f384fcd7294461~TI6hdJCnk3131531315epoutp03S
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 08:24:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20231031082450epoutp0358655b0d173d417660f384fcd7294461~TI6hdJCnk3131531315epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698740690;
 bh=MEmUyiXJPPawF1bdMKSRTu0f5lHZOFtLg1qojwX8CgY=;
 h=From:To:Cc:Subject:Date:References:From;
 b=OpuDHJjYO3wE6eEnZNZ1zCqmYtkTS8WoFdVcKXzaQ4FBGqZFNQUpDdvgnGdEMlKZk
 jr4Bv/nFo6O4VNxg9+L3z1/hqvrugA2lkT/EPYKMX7jo3hk4ciachzyZk7OEHwbNqS
 Q5Gb1xXOjKG6/NzNoO8I4fNmcsqv19pcTTM9uf+k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20231031082449epcas1p12c48c6c825b6e95fd8b2a68c1b0b169a~TI6g-tOFZ0729007290epcas1p1n;
 Tue, 31 Oct 2023 08:24:49 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.134]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4SKNV90MSzz4x9QM; Tue, 31 Oct
 2023 08:24:49 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 41.4A.19104.0D9B0456; Tue, 31 Oct 2023 17:24:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20231031082448epcas1p33a8ff166d2e48df3dcd6c0b1f0132efc~TI6fjR9Gb1463914639epcas1p3E;
 Tue, 31 Oct 2023 08:24:48 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231031082448epsmtrp1f46e571e2492c36ffe220e83ae637122~TI6fiEFzv0871608716epsmtrp1P;
 Tue, 31 Oct 2023 08:24:48 +0000 (GMT)
X-AuditID: b6c32a4c-559ff70000004aa0-e5-6540b9d0217c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 B3.AA.07368.0D9B0456; Tue, 31 Oct 2023 17:24:48 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.235]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20231031082448epsmtip251c86e80c94f6e6e964e7049d0c9bba3~TI6fWYidf1092410924epsmtip2q;
 Tue, 31 Oct 2023 08:24:48 +0000 (GMT)
From: Jaehoon Chung <jh80.chung@samsung.com>
To: u-boot@lists.denx.de
Cc: ycliang@andestech.com, yanhong.wang@starfivetech.com,
 minda.chen@starfivetech.com, xingyu.wu@starfivetech.com, Jaehoon Chung
 <jh80.chung@samsung.com>
Subject: [PATCH 1/2] riscv: dts: jh7110: Add a gpio-restart node
Date: Tue, 31 Oct 2023 17:24:38 +0900
Message-Id: <20231031082439.395320-1-jh80.chung@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmru6FnQ6pBh8O2Vjc+NXGajFpeaDF
 272d7BYLZ5xlsvjR9YjR4vGh10wObB57Ts9i9jh7ZwejR9+WVYwet8/yBrBEZdtkpCampBYp
 pOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAO1WUihLzCkFCgUkFhcr
 6dvZFOWXlqQqZOQXl9gqpRak5BSYFugVJ+YWl+al6+WlllgZGhgYmQIVJmRnPOmdzF6wirvi
 7MUrbA2Mczi7GDk5JARMJC529zB3MXJxCAnsYZTou97FBOF8YpS4cX4WG4TzjVHixd3FLF2M
 HGAtSxqFIOJ7GSX2n3vMAuF8YZRYe2IJC8hcNgEdie3fjjOB2CICEhK/+q8yghQxC8xllPh3
 6DQjSEJYwEHizs3rYA0sAqoSh9b/ZwWxeQVsJFpeHWCBOFBeYual7+wQcUGJkzOfgMWZgeLN
 W2eDHS4hcIhd4sxMmPNcJO6vFYfoFZZ4dXwLO4QtJfGyv40dor6ZUWLpkoOsEE4P0EUN19kg
 qowl9i+dzAQyiFlAU2L9Ln2IsKLEzt9zGSEW80m8+9rDCrGLV6KjTQiiREXi0uuXTDC77j6B
 +EVCwEPi3KtWsBuEBGIlJjW2sUxglJ+F5J1ZSN6ZhbB4ASPzKkap1ILi3PTUZMMCQ9281HJ4
 1Cbn525iBCdCLZ8djN/X/9U7xMjEwXiIUYKDWUmE97CpQ6oQb0piZVVqUX58UWlOavEhRlNg
 IE9klhJNzgem4rySeEMTSwMTMyNjEwtDM0Mlcd6YT+0pQgLpiSWp2ampBalFMH1MHJxSDUzs
 /Uu472VPn7Cz0XB9/tSOm3a/lhxLzzvdcHF316SnGz0+XfhUWBJzcJvfijVKa0py98/f8NP4
 9YUcvgc6jJ+vfymW32MbdsJwTWHX9QrVSTerciU+L2+/zDfp+5HP5luz7c1uqvBNDbm3oX12
 6qk8w6n/tKu2fZp5lUV6msgTh/Yf09TMctLfHnble2Y2d9JS+W5L5w89W1c9XNU5r31famjd
 iSvX7e82haZdCNr5s2WW2vVzspt8lrY/FGRytGFZeVj44MflQbVXTkzcOOPbZb8dDz/arpg/
 86hTYP7Pcz6T5ZOfnJLb3me3NVqcQV059IjY+or+juh5j+zDxMVOdxz3UfCf4N22fMO13E07
 XiuxFGckGmoxFxUnAgCySEmJDQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrELMWRmVeSWpSXmKPExsWy7bCSvO6FnQ6pBusWiljc+NXGajFpeaDF
 272d7BYLZ5xlsvjR9YjR4vGh10wObB57Ts9i9jh7ZwejR9+WVYwet8/yBrBEcdmkpOZklqUW
 6dslcGU86Z3MXrCKu+LsxStsDYxzOLsYOTgkBEwkljQKdTFycQgJ7GaUuPHgHlsXIydQXEri
 89OpbBA1whKHDxeDhIUEPjFK/O9kArHZBHQktn87DmaLCEhI/Oq/yggyh1lgIaNEa+tKFpCE
 sICDxJ2b18FsFgFViUPr/7OC2LwCNhItrw6wQOySl5h56Ts7RFxQ4uTMJ2BxZqB489bZzBMY
 +WYhSc1CklrAyLSKUTK1oDg3PTfZsMAwL7Vcrzgxt7g0L10vOT93EyM4GLU0djDem/9P7xAj
 EwfjIUYJDmYlEd7Dpg6pQrwpiZVVqUX58UWlOanFhxilOViUxHkNZ8xOERJITyxJzU5NLUgt
 gskycXBKNTCty3a032v/hLX6zLa9v+RPXHSU36Sev/X9h3f9pfPVJt7ZvyM3p7NYrokldPGX
 ONZJ5lduZag/UfweqpCyP+7d9FwTr5/Ge2d/UOH/kJAdL+O107W9UVDN9L/VWrW5fyaU73QX
 s1g5Y39i1NXuTsfF1zbEHA6ze/MnzW/z0Sfe5yRrxec9v+s6lefmFi7H/yn3K+qD3mut8ZW9
 /XXtjbk7H5UGrDbUbfT/0RXz6pHpD/Z1BYyReUkdvUmalzoZf5Xcst5c8XTl1MJHqezH5dmb
 VwncvvBJYp/CtaPbTlnXPZKudLV4dFvVfObKC/tY31lsL60y2njcVOjRY2ePxVvMhGwnPnl2
 zG1JBU+hV4+2EktxRqKhFnNRcSIA4xDWlbUCAAA=
X-CMS-MailID: 20231031082448epcas1p33a8ff166d2e48df3dcd6c0b1f0132efc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031082448epcas1p33a8ff166d2e48df3dcd6c0b1f0132efc
References: <CGME20231031082448epcas1p33a8ff166d2e48df3dcd6c0b1f0132efc@epcas1p3.samsung.com>
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

Add gpio-restart node to do reset.

Before applied this patch, System Reset Extension doesn't appear with
sbi command.

OpenSBI 1.3
Machine:
  Vendor ID 489
  Architecture ID 8000000000000007
  Implementation ID 4210427
Extensions:
  sbi_set_timer
  sbi_console_putchar
...[snip]...
  IPI Extension
  RFENCE Extension
  Hart State Management Extension
  Performance Monitoring Unit Extension

After applied this patch, System Reset Extension is supported from SBI.

OpenSBI 1.3
Machine:
  Vendor ID 489
  Architecture ID 8000000000000007
  Implementation ID 4210427
Extensions:
  sbi_set_timer
  sbi_console_putchar
...[snip]...
  IPI Extension
  RFENCE Extension
  Hart State Management Extension
  System Reset Extension
  Performance Monitoring Unit Extension

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
index e40f57a15080..e94f9fe826a8 100644
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
@@ -34,6 +34,11 @@
 		device_type = "memory";
 		reg = <0x0 0x40000000 0x2 0x0>;
 	};
+
+	gpio-restart {
+		compatible = "gpio-restart";
+		gpios = <&sysgpio 35 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &osc {
-- 
2.25.1

