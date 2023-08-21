Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9A9EE49A6
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 01:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D90786A8F;
	Mon, 21 Aug 2023 03:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="s8J6pyQs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF5CD86BF8; Mon, 21 Aug 2023 03:04:12 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A204086A8F
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 03:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20230821010403epoutp043b7be5dedf9e9567bd9c4f166227cadf~9QGZjiWuy0809208092epoutp04F
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 01:04:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20230821010403epoutp043b7be5dedf9e9567bd9c4f166227cadf~9QGZjiWuy0809208092epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1692579843;
 bh=BtozO3mJUkcuJLMhR0467hVidx8I5RnNIWgnk/GAKRE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=s8J6pyQs7H8mK44AmyHxM/KoR3/8d+OTaGRTrdS2sa+KV1X2C4JCwOfxAiTTWAjIf
 qpslYilRvqaOV3pmfV+yxVYWv+dLgBDgLSgoqPN7jXx2+gAqh/neEVYsX5nHL4sHsY
 qxsuWZ8C6Q/jtPNc23+NDcYOjxc/UF5m3JbTNxBk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20230821010403epcas2p130c2fef3b2b0048c015c73f426a73a79~9QGZRvqkz2944329443epcas2p10;
 Mon, 21 Aug 2023 01:04:03 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.99]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4RTZ4L3wwZz4x9QM; Mon, 21 Aug
 2023 01:04:02 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 3B.97.50232.208B2E46; Mon, 21 Aug 2023 10:04:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20230821010401epcas2p45a647001722e345bcb98bd2c79831eda~9QGYJh2St0964809648epcas2p4_;
 Mon, 21 Aug 2023 01:04:01 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230821010401epsmtrp13b3db4d474c227d7bc46e9c0e203052d~9QGYI535N0926909269epsmtrp1N;
 Mon, 21 Aug 2023 01:04:01 +0000 (GMT)
X-AuditID: b6c32a4d-36bff7000006c438-ed-64e2b802610d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 D1.ED.64355.108B2E46; Mon, 21 Aug 2023 10:04:01 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230821010401epsmtip2360777b4790481a6af61a2ecbb0bff8b~9QGX4bHAt1197211972epsmtip2E;
 Mon, 21 Aug 2023 01:04:01 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, Simon Glass
 <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 1/3] riscv: bootstage: correct bootstage_report guard
Date: Mon, 21 Aug 2023 10:03:48 +0900
Message-Id: <20230821010350.324112-2-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230821010350.324112-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmqS7TjkcpBlvaJC0u79e2ePviLKPF
 ty3bGC3e7u1kt3h86DWTA6vHntOzmD1mN1xk8Th7ZwejR9+WVYwBLFHZNhmpiSmpRQqpecn5
 KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAe5UUyhJzSoFCAYnFxUr6djZF
 +aUlqQoZ+cUltkqpBSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ2RkHOnIKetgrjr9+wNbA
 +Iy1i5GTQ0LAROLrhd9MXYxcHEICexgl5i/ezQjhfGKUuDTjNSucs+9EFxtMy7LHb9lBbCGB
 nYwSh2aZQtjTmCROT+EHsdkEdCW2PH8FNImDQ0SgXOLYPbAws4C2ROfnKWCtwgKuElOOfWUG
 KWERUJX4/aUcJMwrYC+xfd0WFpCwhIC8xOIHEiBhTgEHidsn5jFBlAhKnJz5hAViorxE89bZ
 zCBXSgicY5eYdOU2M8SVLhJrb/cyQtjCEq+Ob2GHsKUkXva3sUPML5fYsSwJoreFUaK5bQ9U
 r73Ej5tTWEFqmAU0Jdbv0ocoV5Y4cgtqLZ9Ex+G/UFN4JTrahCAa1SUObJ/OAmHLSnTP+QwN
 ZQ+JI+vmsEDCcjKjxK7me2wTGBVmIflmFpJvZiEsXsDIvIpRKrWgODc9NdmowFA3L7UcHr/J
 +bmbGMGpUMt3B+Pr9X/1DjEycTAeYpTgYFYS4ZX+/jBFiDclsbIqtSg/vqg0J7X4EKMpMLQn
 MkuJJucDk3FeSbyhiaWBiZmZobmRqYG5kjjvvda5KUIC6YklqdmpqQWpRTB9TBycUg1McdqG
 E54WGOdmCV3vrJr151C2jMJJs6L97F9YEjz+3brje4b76dWqkyce2vzdv+PSnb9J6YcTl1xY
 Oyfr/MMzy37svayyrHGGwnHGpflq125ueJXneDR8xb4fYhYrp0xVrnZt27R+3xF7/xWvLgV2
 Pj6UKm7vkRdz9eFf1XytWybnpk/lkMqPXpz3omJ269ysE5PF8w29HzscLpobl9+uPWmHgdx7
 i4cf1rZGNYosWsjZcN8u8vu6ifu6JX0iCnVPzzmRX9W526/8HXtiV/+EvcciH6av77gfx3u6
 qlfToqHJfEnJRauZ0wRuWq68/1fl2b6H6k3LJzCnilgf6/gw5+/qT/sFJK22plTPuC/JrqLE
 UpyRaKjFXFScCACNkK3jDgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSvC7jjkcpBv8fGFpc3q9t8fbFWUaL
 b1u2MVq83dvJbvH40GsmB1aPPadnMXvMbrjI4nH2zg5Gj74tqxgDWKK4bFJSczLLUov07RK4
 Mg505BT0sFccf/2ArYHxGWsXIyeHhICJxLLHb9lBbCGB7YwSd9oNIeKyEs/e7WCHsIUl7rcc
 AarnAqqZxCSxbeFksGY2AV2JLc9fMYLYIgLVEs8f7WADsZkFtCU6P08BaxYWcJWYcuwrcxcj
 BweLgKrE7y/lIGFeAXuJ7eu2sICEJQTkJRY/kAAJcwo4SNw+MY8J4hx7iScnPjFClAtKnJz5
 hAViurxE89bZzBMYBWYhSc1CklrAyLSKUTS1oDg3PTe5wFCvODG3uDQvXS85P3cTIzhQtYJ2
 MC5b/1fvECMTB+MhRgkOZiURXunvD1OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8yrndKYICaQn
 lqRmp6YWpBbBZJk4OKUamNbUflE+37iscFJhJJN5960ANqX2OxZ3ua2uaWnLSArP//pz0wbx
 vIYvL15XcMkX+S32nGcmkrBsyY/5OT1LFfZnZE2Y+66jlqPFZ2pUjYX1SsXjz+PzDk45ps57
 xOzVSnk/owm+/Ar5PhZPtPYujWI7OH/a6TuXFDY4fHvS3vORLy/8dF236LTOvviaGoFT/bOj
 ZnWkLdePNEj37a2//ocp+NXX5dMNvgSpTbn66Nhfj7596515Hu8q92XMfZiY+CbY6eW74/u/
 Xnht0/5g1bJX15ND117iYmjLzXQxn7Xu0IYDe1Zb2nTFKRZuT7idMW3ynJk7NB9uDtqj2Tmt
 OS1qe0HGxN9MggtKtERWcyuxFGckGmoxFxUnAgDav98LwwIAAA==
X-CMS-MailID: 20230821010401epcas2p45a647001722e345bcb98bd2c79831eda
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230821010401epcas2p45a647001722e345bcb98bd2c79831eda
References: <20230821010350.324112-1-chanho61.park@samsung.com>
 <CGME20230821010401epcas2p45a647001722e345bcb98bd2c79831eda@epcas2p4.samsung.com>
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

