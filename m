Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83839C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 08:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7EE687A10;
	Tue, 31 Oct 2023 09:25:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="SDhNQM/H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3079C874C4; Tue, 31 Oct 2023 09:25:02 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3C2A879FE
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 09:24:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20231031082457epoutp01b1179dddeac284c689a344ec4bd5c80e~TI6npdNjf2812928129epoutp01F
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 08:24:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20231031082457epoutp01b1179dddeac284c689a344ec4bd5c80e~TI6npdNjf2812928129epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698740697;
 bh=CcaYagbVuHIBZEHe5/0dWuU8shnnZLAxNBN5Zyx2E9Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SDhNQM/Hn7s/NskIAvFw6BBO4rN3pjoX7wGO3MIjONxPFB7N4134TfrFUiIGcVCob
 L4fMAAh9fc8NLpehCeVAR2TEOwjlH4JR/8OGti3J91MJAFEXnldPFb2KWTycVXnjDY
 Edpkxei4xE/jcsgPj3W+sA57ElCO2dB6UR0eWwYM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20231031082456epcas1p2071daa5317af591ba25c9028af36aa26~TI6nTZ1ZG1733717337epcas1p2H;
 Tue, 31 Oct 2023 08:24:56 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.132]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4SKNVJ0zS4z4x9QB; Tue, 31 Oct
 2023 08:24:56 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 DB.75.09744.8D9B0456; Tue, 31 Oct 2023 17:24:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20231031082455epcas1p35b81686fe8c2d836539f8103c9cde629~TI6mbyOT41463914639epcas1p3c;
 Tue, 31 Oct 2023 08:24:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231031082455epsmtrp2d01967060c8b709b5ab7997c0c66b337~TI6ma6i1a3070930709epsmtrp2a;
 Tue, 31 Oct 2023 08:24:55 +0000 (GMT)
X-AuditID: b6c32a35-7239ea8000002610-5f-6540b9d8676e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 DE.EC.08755.7D9B0456; Tue, 31 Oct 2023 17:24:55 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.235]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20231031082455epsmtip2b9377b1eddfd1286183286e7d05247c9~TI6mNFq9k0518305183epsmtip2X;
 Tue, 31 Oct 2023 08:24:55 +0000 (GMT)
From: Jaehoon Chung <jh80.chung@samsung.com>
To: u-boot@lists.denx.de
Cc: ycliang@andestech.com, yanhong.wang@starfivetech.com,
 minda.chen@starfivetech.com, xingyu.wu@starfivetech.com, Jaehoon Chung
 <jh80.chung@samsung.com>
Subject: [PATCH 2/2] configs: starfive2: Enable CONFIG_SYSRET config
Date: Tue, 31 Oct 2023 17:24:39 +0900
Message-Id: <20231031082439.395320-2-jh80.chung@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031082439.395320-1-jh80.chung@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdljTQPfGTodUg5UnWC1u/GpjtZi0PNDi
 7d5OdouFM84yWfzoesRo8fjQayYHNo89p2cxe5y9s4PRo2/LKkaP22d5A1iism0yUhNTUosU
 UvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgHYrKZQl5pQChQISi4uV
 9O1sivJLS1IVMvKLS2yVUgtScgpMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7IzluwQLvjHUvFh
 3mLWBsbVLF2MnBwSAiYSX/tmsnUxcnEICexglPg89wwThPOJUeLZ4n+sEM43Rom+Rc+ZYFru
 PfkCVbWXUeL8tE0sEM4XRomX1z8yglSxCehIbP92HKxDREBC4lf/VUaQImaBuYwS/w6dBisS
 FnCR+HZ7HtglLAKqEtv3HQZr4BWwkZh7q5cVYp28xMxL39m7GDk4OAVsJdZdNYAoEZQ4OfMJ
 WCszUEnz1tnMIPMlBK6xS2xvnc4I0esisXB7KzOELSzx6vgWdghbSuLzu71sEA3NjBJLlxxk
 hXB6gK5ruM4GUWUssX/pZCaQzcwCmhLrd+lDhBUldv6eywixmU/i3dceVpASCQFeiY42IYgS
 FYlLr18ywey6++Q/1C8eEj/+LGaHhNYERonv+yYxT2BUmIXkoVlIHpqFsHkBI/MqRrHUguLc
 9NRiwwJDeBwn5+duYgSnRi3THYwT337QO8TIxMF4iFGCg1lJhPewqUOqEG9KYmVValF+fFFp
 TmrxIUZTYGhPZJYSTc4HJue8knhDE0sDEzMjYxMLQzNDJXFe5ke9KUIC6YklqdmpqQWpRTB9
 TBycUg1MCkePJIr7zpn44MSnj2bGFww51K3u8hltYFndLVB2NLP8mmgh1/mprHvb6xJaJrO+
 D6s//+DPlVtiQq6PJG5ftT9WzvY/Ma+GnfOSw1+3Y11z127bxNWdxtV5bLG4UElH3ik2gWD5
 1kNBM3Lbu7YznFZ5c0Pt3mXvfLZaru5DMfIKSdsrZJeamcUZs/y8FpdfZFs+e8kmYY03/04x
 uK+1v8txcdGDtdPtJVQWX282C+ZPOTK34gTPnYkq4jZ7TSUbp11aJvY08I6twqvXXj9tt1lN
 q81cVrnAfvGxbvFpCyur9Yq+Ot22+5MRWP9Es2PG8byNYTlX3Xic8x1j7pflCuzYF6hlnzb7
 eO4Nya1KLMUZiYZazEXFiQAxBzgHFgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSvO71nQ6pBrOf6ljc+NXGajFpeaDF
 272d7BYLZ5xlsvjR9YjR4vGh10wObB57Ts9i9jh7ZwejR9+WVYwet8/yBrBEcdmkpOZklqUW
 6dslcGUs2SFc8I+l4sO8xawNjKtZuhg5OSQETCTuPfnCBGILCexmlNi2wxwiLiXx+elUti5G
 DiBbWOLw4eIuRi6gkk+MEg+OX2EGqWET0JHY/u04WK+IgITEr/6rjCBFzAILGSVaW1eCLRAW
 cJH4dnsemM0ioCqxfd9hsAZeARuJubd6WSGWyUvMvPSdHWQZp4CtxLqrBhD32Ejc3rSBDaJc
 UOLkzCdgY5iBypu3zmaewCgwC0lqFpLUAkamVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5
 uZsYwaGrpbmDcfuqD3qHGJk4GA8xSnAwK4nwHjZ1SBXiTUmsrEotyo8vKs1JLT7EKM3BoiTO
 K/6iN0VIID2xJDU7NbUgtQgmy8TBKdXAxKNT4Zt7yspe3FSxLHtvqXmQwZpLT0W5LxduUmFl
 T5ltEPc856DUC+mLr9fa7bLh+lm0VePrldf357JcOXvc4q6Dx/Xlc6VWc/1cMKlmqZb71L6D
 Pv/OKnHtO8MuVsK5saI3fC/7IbGdSc+aink7djqm7bUWfzVfzNIrS3FPReIV9zVTU+ZGyF42
 mNcUUf9YUfLtys6veaUs686yRpuxZB3fkbKRlaFjleeuksIPfr3rvokLyNr+eLhvwxvPN537
 D5tPCmKULWhnOWbp0PyTPanry+aXWWs4Kq9VTy9yNr6nFXlikbqzxd3A9jN5lv8k5z+/8dej
 PqaAbT1/Z9OCrNKy23tOnjn4I/hzb7iwEktxRqKhFnNRcSIAGBe+zswCAAA=
X-CMS-MailID: 20231031082455epcas1p35b81686fe8c2d836539f8103c9cde629
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031082455epcas1p35b81686fe8c2d836539f8103c9cde629
References: <20231031082439.395320-1-jh80.chung@samsung.com>
 <CGME20231031082455epcas1p35b81686fe8c2d836539f8103c9cde629@epcas1p3.samsung.com>
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

Enable CONFIG_SYSREST config to do reset.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 configs/starfive_visionfive2_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index b21754feafce..afa74e17ebd5 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -122,6 +122,7 @@ CONFIG_PINCTRL_STARFIVE=y
 # CONFIG_RAM_SIFIVE is not set
 CONFIG_SYS_NS16550=y
 CONFIG_CADENCE_QSPI=y
+CONFIG_SYSRESET=y
 CONFIG_TIMER_EARLY=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-- 
2.25.1

