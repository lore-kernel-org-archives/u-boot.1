Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63DCEB8FA5
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 05:18:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CDAC86977;
	Wed,  6 Sep 2023 07:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="VFdA8qlv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFADD8652A; Wed,  6 Sep 2023 07:18:40 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9555866E1
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 07:18:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20230906051833epoutp03bb8eeb779818fcfe2c3393a32ac44b8a~CN5KwAWHJ1763517635epoutp03b
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 05:18:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20230906051833epoutp03bb8eeb779818fcfe2c3393a32ac44b8a~CN5KwAWHJ1763517635epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693977513;
 bh=ruSn1Ewu2sjJjsNq1ywMa1JXSGi2+h+MZvyl0hXBECo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VFdA8qlvtOrSJvr7+IcH79oT8wtiyni6tXs6KVG0m8zR32wC1gIXe0MsPSqCaxlOl
 t+G9C/jCt91XJbXF7ufZuuloBVHEQv0JWHPTeHWDOolI3c+UNDQk6IYpHyS5jz1s3E
 2di5rMIDkp6mSOkn9xc+HwoVFWfj1U7Jf9/81AGE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20230906051832epcas2p4641a4f7450173687121637b14efc8329~CN5KY3N1Z0446104461epcas2p4F;
 Wed,  6 Sep 2023 05:18:32 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.90]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4RgVyb74Ynz4x9QC; Wed,  6 Sep
 2023 05:18:31 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 AC.05.09660.7AB08F46; Wed,  6 Sep 2023 14:18:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20230906051831epcas2p3b00d3dcd7d45e98f62e83414c1a5bf22~CN5JEdYCB2364923649epcas2p3V;
 Wed,  6 Sep 2023 05:18:31 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230906051831epsmtrp1afbe426dafd6cf3a4c90daa35785a144~CN5JDtf5m0596705967epsmtrp1d;
 Wed,  6 Sep 2023 05:18:31 +0000 (GMT)
X-AuditID: b6c32a47-d5dfa700000025bc-2e-64f80ba767f3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 CB.3F.08788.7AB08F46; Wed,  6 Sep 2023 14:18:31 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20230906051830epsmtip1e88b63c02e8615e6dd5bf57f297d5a7b~CN5Izr-gU0257502575epsmtip1K;
 Wed,  6 Sep 2023 05:18:30 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, Simon Glass
 <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v3 1/3] riscv: bootstage: correct bootstage_report guard
Date: Wed,  6 Sep 2023 14:18:12 +0900
Message-Id: <20230906051814.1393464-2-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230906051814.1393464-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmme5y7h8pBp+nS1lc3q9t8fbFWUaL
 b1u2MVq83dvJbvH40GsmB1aPPadnMXvMbrjI4nH2zg5Gj74tqxgDWKKybTJSE1NSixRS85Lz
 UzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA9ioplCXmlAKFAhKLi5X07WyK
 8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjM+bVnGWHCYveLBnJ1M
 DYzT2boYOTkkBEwknj/5B2RzcQgJ7GCUmHBwOiuE84lRYsOq30wgVUIC3xglGvcowHRMWD2B
 HaJoL6PEzw1ToZxpTBI3LtwDm8smoCux5fkrxi5GDg4RgUSJx4frQUxmAUeJc1ONQCqEBTwk
 bk99DDafRUBVYvKc6ewgNq+Ag8Ttx0eZQMolBOQlFj+QAAlzAnV2t/xkgSgRlDg58wmYzQxU
 0rx1NjPIBRICl9gl1m9dAfWZi8TxyauYIWxhiVfHt7BD2FISL/vb2CHml0vsWJYE0dvCKNHc
 tgeq3l7ix80prBAna0qs36UPUa4sceQW1Fo+iY7Df6Gm8Ep0tAlBNKpLHNg+nQXClpXonvOZ
 FcL2kPja0AAN2SmMEn+/L2WfwKgwC8k3s5B8Mwth8QJG5lWMYqkFxbnpqcVGBcbw2E3Oz93E
 CE6DWu47GGe8/aB3iJGJg/EQowQHs5II7zv5bylCvCmJlVWpRfnxRaU5qcWHGE2BQT2RWUo0
 OR+YiPNK4g1NLA1MzMwMzY1MDcyVxHnvtc5NERJITyxJzU5NLUgtgulj4uCUamDaoypy+JJP
 bvqKqkep6TYvP1+dlHBwJedxtwvWii3VQe3blHQKzvJtNxf1n+fzX1b0879VE65XFwWd7Y/I
 fuCh7iO3o/NiieskBZb/zpc+eh49ECxaVNVW6lKuM/vgtWeH1sxVt+WvXjRlRveevs/V7V+Z
 olIK884ZPFOQFjHYtV2gcnfmB68/7zpdeXd4SW2xsPz5Obe8SeuvcmTqxoUnhbiZ7tru+rRh
 XrNQx8RvjlZnTnRYlJstlIn7+qZGv3LrhUWKdZPt4hx3rbu6omL3pv+T/xi3dZ+z2xC37emb
 V30rt5+X6JS00mLm95A/Nq1qxWM9g0jus7ZCu7Zbvl5w1ejZju9y54vnR02+qDNTiaU4I9FQ
 i7moOBEAyZOOwQwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWy7bCSnO5y7h8pBhtPMltc3q9t8fbFWUaL
 b1u2MVq83dvJbvH40GsmB1aPPadnMXvMbrjI4nH2zg5Gj74tqxgDWKK4bFJSczLLUov07RK4
 Mj5tWcZYcJi94sGcnUwNjNPZuhg5OSQETCQmrJ7A3sXIxSEksJtR4vrTR8wQCVmJZ+92sEPY
 whL3W46wQhRNYpJYu66RBSTBJqArseX5K0YQW0QgWeJiTxdYA7OAs8Sdc9tZQWxhAQ+J21Mf
 M4HYLAKqEpPnTAer4RVwkLj9+ChQnANogbzE4gcSIGFOAUeJ7pafYOOFgEruzXjBDFEuKHFy
 5hMWiPHyEs1bZzNPYBSYhSQ1C0lqASPTKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M
 4LDV0trBuGfVB71DjEwcjIcYJTiYlUR438l/SxHiTUmsrEotyo8vKs1JLT7EKM3BoiTO++11
 b4qQQHpiSWp2ampBahFMlomDU6qBSSAp5vYGRv6ogh52oSWhyd5iW/ZOf1//Ykbpcj79sGk+
 oXF3D/gLl9gI5Pw1nPIgwaFefCX/pgMXzJ9ffuR0xdZH4Py7bruZPyrWnv4teKTl4U6X38Zr
 XsQwbO81CVTPWTJrjkeY+rSGRTc0UyV/n7RiKDsT3yyi8/byV+29KlNfcepazH5V5HHy0SWu
 Zeu/hVs3Mj//vc5Lb7+i9I20N9aKbDW/g29pBTdblEq/Dp/wxOpWPNv+n7PjM9NrRe5KP3uy
 XFyaR3Qhg0j2zM1NZ45zaDtOMo9f9GHh03/pf7b+Wfcv8jzbITcO7/6pFQt0foi82Flub+2+
 ludb+rKAafLia79MnJXXYR129hCzpRJLcUaioRZzUXEiABaiiA/KAgAA
X-CMS-MailID: 20230906051831epcas2p3b00d3dcd7d45e98f62e83414c1a5bf22
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230906051831epcas2p3b00d3dcd7d45e98f62e83414c1a5bf22
References: <20230906051814.1393464-1-chanho61.park@samsung.com>
 <CGME20230906051831epcas2p3b00d3dcd7d45e98f62e83414c1a5bf22@epcas2p3.samsung.com>
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

Below warning can be occurred when CONFIG_BOOTSTAGE and
!CONFIG_SPL_BOOTSTAGE. It should be guarded by using CONFIG_IS_ENABLED
for SPL build.

arch/riscv/lib/bootm.c:46:9: warning: implicit declaration of
function 'bootstage_report'
   46 |         bootstage_report();
      |         ^~~~~~~~~~~~~~~~
      |         bootstage_error

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 arch/riscv/lib/bootm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
index 276677a5e2f9..cc30efc90498 100644
--- a/arch/riscv/lib/bootm.c
+++ b/arch/riscv/lib/bootm.c
@@ -42,7 +42,7 @@ static void announce_and_cleanup(int fake)
 #ifdef CONFIG_BOOTSTAGE_FDT
 	bootstage_fdt_add_report();
 #endif
-#ifdef CONFIG_BOOTSTAGE_REPORT
+#if CONFIG_IS_ENABLED(BOOTSTAGE_REPORT)
 	bootstage_report();
 #endif
 
-- 
2.39.2

