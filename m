Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F25C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 09:50:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76340864AD;
	Mon, 28 Aug 2023 11:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="RIBzIwGA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5304A864CE; Mon, 28 Aug 2023 11:49:59 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CFDD8645F
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 11:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20230828094954epoutp03755164b9b67593497b9e6bc5fa20bfb5~-gyhLbsT60676806768epoutp03T
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 09:49:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20230828094954epoutp03755164b9b67593497b9e6bc5fa20bfb5~-gyhLbsT60676806768epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693216194;
 bh=BtozO3mJUkcuJLMhR0467hVidx8I5RnNIWgnk/GAKRE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RIBzIwGAjWg1L6df4F4p/WhPsv2/miyoQGyLAj7tL7pRyE3zT2vC7Ob+uvCZI7aA5
 ozLbjtCoj5i2hfI0H7YFBbwPVs36Fo89X6RtYHPe650TROdNK2YhLRSN69wEfJWpj5
 D9XLJc73sw+LfIcRTBfodUEG5B5p12wb4bRfJ+a4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20230828094953epcas2p49720ba6e0999e386a3b3bb83ac335004~-gyg5wK3-1639016390epcas2p4Z;
 Mon, 28 Aug 2023 09:49:53 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.98]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4RZ5Ps1N7Vz4x9Py; Mon, 28 Aug
 2023 09:49:53 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 DA.A7.09660.1CD6CE46; Mon, 28 Aug 2023 18:49:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20230828094952epcas2p497990b22d236fdaf4239dc9df80e4c7a~-gygFq8Cy1639016390epcas2p4V;
 Mon, 28 Aug 2023 09:49:52 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230828094952epsmtrp1da4718710d3a10f3bdcdbd95da967211~-gygFHxeW1977419774epsmtrp1c;
 Mon, 28 Aug 2023 09:49:52 +0000 (GMT)
X-AuditID: b6c32a47-afdff700000025bc-94-64ec6dc1a1d6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 AE.34.18916.0CD6CE46; Mon, 28 Aug 2023 18:49:52 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230828094952epsmtip2995ab8b47b576155b152e1f6a6f9ad39~-gyf50P2b2737727377epsmtip2I;
 Mon, 28 Aug 2023 09:49:52 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, Simon Glass
 <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v2 1/3] riscv: bootstage: correct bootstage_report guard
Date: Mon, 28 Aug 2023 18:49:36 +0900
Message-Id: <20230828094938.2061606-2-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828094938.2061606-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmue7B3DcpBudec1hc3q9t8fbFWUaL
 b1u2MVq83dvJbvH40GsmB1aPPadnMXvMbrjI4nH2zg5Gj74tqxgDWKKybTJSE1NSixRS85Lz
 UzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA9ioplCXmlAKFAhKLi5X07WyK
 8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjMOdOQU9LBXHH/9gK2B
 8RlrFyMnh4SAicTcfctYQGwhgR2MEvePmXYxcgHZnxgl/p9ezgjn9L96wAjTMWvVdGaIxE6g
 qlnH2SGcaUwSzcvuM4NUsQnoSmx5/gqog4NDRKBc4tg9fpAws4C2ROfnKewgtrCAh8Tyg8vB
 bBYBVYndk5eAtfIKOEjcnr6dGaRVQkBeYvEDCZAwp4CjxNm/f6FKBCVOznzCAjFSXqJ562yw
 eyQETrFLPGg/zw5xqIvE5H1bmCBsYYlXx7dAxaUkXva3sUPML5fYsSwJoreFUaK5bQ8zRI29
 xI+bU1hBapgFNCXW79KHKFeWOHILai2fRMfhv1BTeCU62oQgGtUlDmyfzgJhy0p0z/nMClHi
 ITH9YAYknKYwSky6+Z11AqPCLCTPzELyzCyEvQsYmVcxiqUWFOempxYbFRjDIzc5P3cTIzgJ
 arnvYJzx9oPeIUYmDsZDjBIczEoivJccX6UI8aYkVlalFuXHF5XmpBYfYjQFhvREZinR5Hxg
 Gs4riTc0sTQwMTMzNDcyNTBXEue91zo3RUggPbEkNTs1tSC1CKaPiYNTqoGJz85u+ZXlSb3/
 dnJ+Tvt9pklK8SxvynRXPraL7yatLZ6ieGvpJOZOdTa5OvYHR62DlOKdY8KdK5JL4/ljf/nX
 WmrtEhE1TjR9JHWq+BnvEbmpCcfjjywq2lbhsVDjANt52z/PDW9/7F0Rdahc5M5r77vH9pxR
 qHj/99JH66PR81VsRDqT73b3KzyWZ9maknvn+e+XLbPXtN/Z7hQaUljd0J1wdLGWpvukOGuv
 D9fsJL6LZ+7YIhuq3PTL8UX1ZaenOw63FIXY+4So3/rAz/T2V2il1S6efW+mhVqeX2LWtHpX
 +GSZZ+Lcrxec2qs90XGlxPWPp/6dt+W2etD3L+G+YexcrvJOptX9fyYH8P9WYinOSDTUYi4q
 TgQAjMBGWgsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSvO6B3DcpBs/261tc3q9t8fbFWUaL
 b1u2MVq83dvJbvH40GsmB1aPPadnMXvMbrjI4nH2zg5Gj74tqxgDWKK4bFJSczLLUov07RK4
 Mg505BT0sFccf/2ArYHxGWsXIyeHhICJxKxV05m7GLk4hAS2M0r07z3NDJGQlXj2bgc7hC0s
 cb/lCCtE0SQmidPdO8C62QR0JbY8f8UIYosIVEs8f7SDDcRmFtCW6Pw8BaxZWMBDYvnB5WA2
 i4CqxO7JS8AW8Ao4SNyevh3I5gBaIC+x+IEESJhTwFHi7N+/YCVCQCWblr5ggygXlDg58wkL
 xHh5ieats5knMArMQpKahSS1gJFpFaNoakFxbnpucoGhXnFibnFpXrpecn7uJkZwsGoF7WBc
 tv6v3iFGJg7GQ4wSHMxKIryXHF+lCPGmJFZWpRblxxeV5qQWH2KU5mBREudVzulMERJITyxJ
 zU5NLUgtgskycXBKNTAJHO1cqa2+vPnLenlW/qzccE0ZAe209XKioab5zgt4r/q0F12dNudW
 T/WnwOk1thNn35J4dGbO8uDD+Ysizm0Myj7FWrvwuHFIHYPRE80fNyq32jYfZLldvG/XKb+X
 fXtnyZr4m+XVVjWu6L8r1LbpSIzO64WhyseMN+1e+b41N37uxQWdKhp2/qc/sJ5s6dZ/9VjW
 6UBKsszBgEO+WyUsNJ2muK6L772vv0Q64sCGXVbmSS8i5zw1ylTgDrL4s/3pceneqoAY9l/1
 zgoJ8Z6hydU+jWw3vkfInT9znVlM5t/kxu/8U9aKpT07cGLi14uvJfjTjA89/yn8/7WTavKd
 V0al2Uv/NC4IbLM1jldiKc5INNRiLipOBADgVvfExQIAAA==
X-CMS-MailID: 20230828094952epcas2p497990b22d236fdaf4239dc9df80e4c7a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230828094952epcas2p497990b22d236fdaf4239dc9df80e4c7a
References: <20230828094938.2061606-1-chanho61.park@samsung.com>
 <CGME20230828094952epcas2p497990b22d236fdaf4239dc9df80e4c7a@epcas2p4.samsung.com>
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

