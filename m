Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32625C4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 23:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1269186FA7;
	Mon,  6 Nov 2023 00:14:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="D4PE4waM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81E5586EB5; Mon,  6 Nov 2023 00:14:06 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 249F286EF2
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 00:13:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231105231341epoutp04e35e232f1106e8d7d7c607230dba4711~U3RBnayto1396013960epoutp04-
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 23:13:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231105231341epoutp04e35e232f1106e8d7d7c607230dba4711~U3RBnayto1396013960epoutp04-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1699226021;
 bh=RxrgGD5DGkDVZvcWvTuEwV7vJYy0UPWtrgEibe5nlsY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=D4PE4waMRrFHGaHNRKXdprYeT6t7a6yCyKjAy3Xbn8ghg+s4uFDOxWNzMw+xTXusD
 ejw5fRvDDLpaaPlpiUvVMBJsDn7T8tK8BNO1CYtF2P2kQTGzq5fTk8IIoArdQlXlZn
 FOAuAfgLBK4QV/hGwZGTxETJ8GNyjpUNoHpgaT8k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20231105231341epcas2p38f780571cc6e90224ec3d6598a2c1ba1~U3RBYeNjM0622506225epcas2p3V;
 Sun,  5 Nov 2023 23:13:41 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.100]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4SNqzT2M6rz4x9Ps; Sun,  5 Nov
 2023 23:13:41 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 2B.2E.09622.5A128456; Mon,  6 Nov 2023 08:13:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20231105231340epcas2p1a3aa6337906b651d5d3e1b279714df3f~U3RAuXbvZ2977629776epcas2p1B;
 Sun,  5 Nov 2023 23:13:40 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231105231340epsmtrp17e8107bf3210fcc06a30d6d27c5819a5~U3RAsnVCB3182231822epsmtrp1h;
 Sun,  5 Nov 2023 23:13:40 +0000 (GMT)
X-AuditID: b6c32a46-d61ff70000002596-61-654821a579cf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 98.4A.18939.4A128456; Mon,  6 Nov 2023 08:13:40 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20231105231340epsmtip25775aa0e67236e673f9d364f5ee58711~U3RAbk3Kw1198411984epsmtip2O;
 Sun,  5 Nov 2023 23:13:40 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, Stefan
 Roese <sr@denx.de>, Yanhong Wang <yanhong.wang@starfivetech.com>, Xingyu Wu
 <xingyu.wu@starfivetech.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 3/4] riscv: dts: jh7110: Add watchdog device tree node
Date: Mon,  6 Nov 2023 08:13:17 +0900
Message-Id: <20231105231318.992857-4-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231105231318.992857-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdljTXHepokeqwYsFAhaX92tbvH1xltHi
 5LoPTBZv93ayWyyccZbJ4kfXI0aLx4deMzmwe+w5PYvZY96sEyweZ+/sYPTo27KK0eP2Wd4A
 1qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygK5QU
 yhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ
 2Rl/jx9jLnjCVrH70h7GBsY9rF2MnBwSAiYS35f+YOli5OIQEtjBKNFzagcbSEJI4BOjxLXD
 xhAJILtzwV0mmI7Nv44wQRTtZJQ4czMWomgak8SRt9PBEmwCuhJbnr9iBLFFBE4xSqy7pAxi
 MwtoS3R+nsIOYgsLuEns6z8FdAYHB4uAqsSHI+IgYV4Be4m+phUsIGEJAXmJxQ8kQMKcAg4S
 vbu3sUGUCEqcnPmEBWKivETz1tnMICdICDxil9jQ9ZkJotdF4vlUTYiThSVeHd/CDmFLSbzs
 b2OHKCmX2LEsCaK1hVGiuW0PM0SNvcSPm1PALmMW0JRYv0sfolxZ4sgtqK18Eh2H/0JN4ZXo
 aBOCaFSXOLB9OguELSvRPeczNJQ9JBrWrYWG8mRGicbli1kmMCrMQvLMLCTPzEJYvICReRWj
 WGpBcW56arFRgRE8cpPzczcxghOkltsOxilvP+gdYmTiYDzEKMHBrCTC6+jtkirEm5JYWZVa
 lB9fVJqTWnyI0RQY0BOZpUST84EpOq8k3tDE0sDEzMzQ3MjUwFxJnPde69wUIYH0xJLU7NTU
 gtQimD4mDk6pBqajMxieKO2+JP3opk6i8TvvtwGHffZ87EhTEMpcksZ4IDOpV/d9Y8q6rJSN
 fucqXi2y2TZZwShGSb87XtSq470SwyHh2p8cSp1hrVHuz3qvrTpY94ZzUaqXoLbatIdrlC9p
 ZWR43Dy8VOZM8KQX3zITeb38tENKRXIndDyus4zuF1rHZcQid9OwWLqr4eK57o5rX34VHvp4
 d8Ihx4CVFkutT/z0UhD45LrXQHKvf9kz6XruT8HO0Usf79GLTzozx9KCO1vC5ZGHa/Kao9xX
 yjQ++Av/Ozn19aPwQ6sMvdM6lVecUSoqElnjn/U8b4ZPWdqdRxNmMT9j9Tdd12Y97YUAj4Dz
 zJVs8X+8Hl75psRSnJFoqMVcVJwIAJbMnIYZBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsWy7bCSvO4SRY9Ug6uvjSwu79e2ePviLKPF
 yXUfmCze7u1kt1g44yyTxY+uR4wWjw+9ZnJg99hzehazx7xZJ1g8zt7ZwejRt2UVo8fts7wB
 rFFcNimpOZllqUX6dglcGX+PH2MueMJWsfvSHsYGxj2sXYycHBICJhKbfx1h6mLk4hAS2M4o
 8XHmdTaIhKzEs3c72CFsYYn7LUdYIYomMUlMaHkPlmAT0JXY8vwVI0hCROACo8SEHbMYQRLM
 AtoSnZ+ngBUJC7hJ7Os/BdTNwcEioCrx4Yg4SJhXwF6ir2kFC0hYQkBeYvEDCZAwp4CDRO/u
 bWA3CAGV/Ph6iBmiXFDi5MwnLBDT5SWat85mnsAoMAtJahaS1AJGplWMoqkFxbnpuckFhnrF
 ibnFpXnpesn5uZsYwaGsFbSDcdn6v3qHGJk4GA8xSnAwK4nwOnq7pArxpiRWVqUW5ccXleak
 Fh9ilOZgURLnVc7pTBESSE8sSc1OTS1ILYLJMnFwSjUwdc1sFGd8l7M2NTHk5eocaUvr0+U2
 TIvMDQ7fTbk6Z9HjPzt/WjuZPNCcZPqki3vvickT3t9lWLCCg+GGp9RF1W9SLs8MtywVTdl+
 IeaZdKLz7wPFcfEPVsoeTfgYUnIo7bC12J1Mnxvrpx65Jn6y/v37DUkHNUws+5bLHK3jf37+
 sPbC5IJvhkrfGE+L73qnf1JNcsP1B07xliE72wXUGAS2bM3d1dRgv5CLMXM555H70RdFNyZc
 C5qTmpS9eu0ULsv2oqWsdtNFN2qfkT9Sp/Nl+rv3/tERrmc8vhrN/zVXctXErw3lNe9eKx39
 dTZqOkOpNo93a9IZUzPGrw7ZS1W2WmbMk+P5yvi2WV/5gBJLcUaioRZzUXEiAKmcBgTUAgAA
X-CMS-MailID: 20231105231340epcas2p1a3aa6337906b651d5d3e1b279714df3f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231105231340epcas2p1a3aa6337906b651d5d3e1b279714df3f
References: <20231105231318.992857-1-chanho61.park@samsung.com>
 <CGME20231105231340epcas2p1a3aa6337906b651d5d3e1b279714df3f@epcas2p1.samsung.com>
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

Adds jh7110 watchdog device tree node.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 arch/riscv/dts/jh7110.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/dts/jh7110.dtsi b/arch/riscv/dts/jh7110.dtsi
index 13c47f7caa36..6d2675d6ceac 100644
--- a/arch/riscv/dts/jh7110.dtsi
+++ b/arch/riscv/dts/jh7110.dtsi
@@ -533,6 +533,16 @@
 			#gpio-cells = <2>;
 		};
 
+		watchdog@13070000 {
+			compatible = "starfive,jh7110-wdt";
+			reg = <0x0 0x13070000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_WDT_APB>,
+				 <&syscrg JH7110_SYSCLK_WDT_CORE>;
+			clock-names = "apb", "core";
+			resets = <&syscrg JH7110_SYSRST_WDT_APB>,
+				 <&syscrg JH7110_SYSRST_WDT_CORE>;
+		};
+
 		mmc0: mmc@16010000 {
 			compatible = "starfive,jh7110-mmc";
 			reg = <0x0 0x16010000 0x0 0x10000>;
-- 
2.39.2

